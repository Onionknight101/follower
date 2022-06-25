local fields = require('packets/fields')

local stringFunctions = {}


function stringFunctions:get_array_info(string_)
	local type, count_str = string_:match('(.+)%[(.+)%]')
    type = stringFunctions:trim(type or string_)
	if(count_str==nil) then
		count_str = 1
	else
		count_str = tonumber(count_str)
	end
	return type,count_str
end

function stringFunctions:starts_with(str, start)
   return str:sub(1, #start) == start
end

function stringFunctions:ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function stringFunctions:trim(input_,start_,end_)
	if(start_==nil) then return input_:match "^%s*(.-)%s*$" end
	
	if(stringFunctions:starts_with(input_,start_) and stringFunctions:ends_with(input_,end_)) then
		return string.sub(input_,1+string.len(start_),-string.len(end_)-1)
	end
	return input_
end

function stringFunctions:trim_end(input_,end_)
	if(stringFunctions:ends_with(input_,end_)) then
		return string.sub(input_,1,-string.len(end_)-1)
	end
	return input_
end

function stringFunctions:sub_withoutNonChar(input_,start_)
	local retString = ''
	for i=start_,string.len(input_) do
		local c = string.sub(input_,i,i)
		
		if(string.len(string.byte(c))>1) then
			retString = retString..c 
		end
	end
	return retString
end



--[[
    Lengths for C data types.
]]

local sizes = {
    ['unsigned char']   =  8,
    ['unsigned short']  = 16,
    ['unsigned int']    = 32,
    ['unsigned long']   = 64,
    ['signed char']     =  8,
    ['signed short']    = 16,
    ['signed int']      = 32,
    ['signed long']     = 64,
    ['char']            =  8,
    ['short']           = 16,
    ['int']             = 32,
    ['long']            = 64,
    ['bool']            =  8,
    ['float']           = 32,
    ['double']          = 64,
    ['data']            =  8,
    ['bit']             =  1,
    ['boolbit']         =  1,
}

local has_sign = {
	['float'] = true,
}

PACKETS = {}

local format_field = {
	['char']  = function(data_,cur_count,size)
		if(size~=nil) then
			local ret_string = ''
			for i=0,size-1 do
				ret_string=ret_string..string.char(ashita.bits.unpack_be(data_,cur_count+(i*sizes['char']),sizes['char']))
			end
			return ret_string
		else
			return string.char(ashita.bits.unpack_be(data_,cur_count,sizes['char']))
		end
	end,
	['bool']  = function(data_,cur_count)
			return ashita.bits.unpack_be(data_,cur_count,sizes['bool']) ~= 0
	end,
	['boolbit']  = function(data_,cur_count)
			return ashita.bits.unpack_be(data_,cur_count,sizes['boolbit']) ~= 0
	end,

}

local format_type = {
	['number']  = function(data_)
		if(data_~= nil) then return tonumber(data_) end
	end,
}
	
local current_id =  -1

function PACKETS:get_id(data_)
	return ashita.bits.unpack_be(data_,0,9)
end

function PACKETS:handle_fori(table_,data_,v_,pref_,cur_count,size)
	local i = v_.i
	if(type(i)=='string') then
		i = table_[pref_..i]
	end
	if(i==nil) then error('packets fori i not found') return -1 end
	
	local till = v_.till
	if(type(till)=='string') then
		till = table_[pref_..till]
	end
	if(till==nil) then error('packets fori till not found') return -1 end
	
	if(v_.at) then cur_count = v_.at end
	
	if(type(till)~='number') then print('E '..v_.till..' '..type(v_.till)) end
	for s=i,till do
		local new_pref = pref_..v_.label
		if(v_.label_lookup) then 
			new_pref = pref_..v_.label
			if(v_.label_lookup_field) then
				new_pref = pref_..v_.label..RESOURCES:F(v_.label_lookup,s,v_.label_lookup_field)..' '
			else
				new_pref = pref_..v_.label..RESOURCES:E(v_.label_lookup,s)..' '
			end
		else
			new_pref = pref_..v_.label..' '..s..' '
		end
		cur_count = PACKETS:handle_fields(table_,data_,v_.fields,new_pref,cur_count,size)
		if(cur_count == -1) then return -1 end
	end
	
	return cur_count
end

function PACKETS:handle_case(table_,data_,v_,pref_,cur_count,size)
	if(v_.check==nil) then error('packets case case not found in '..PACKETS:get_id(data_)) return -1 end
	local v_case = table_[v_.check]
	if(v_case==nil) then error('packets case field not found in '..PACKETS:get_id(data_)) return -1 end
	
	if(not v_.on[v_case]) then 
		if(v_.on['default']) then
			v_case = 'default'
		else
			return cur_count 
		end
	end
	
	if(v_.at) then cur_count = v_.at end
		
	cur_count = PACKETS:handle_fields(table_,data_,v_.on[v_case],pref_,cur_count,size)
	if(cur_count == -1) then return -1 end
	
	return cur_count
end

function PACKETS:handle_if(table_,data_,v_,pref_,cur_count,size)
	if(v_.check==nil) then error('packets case check not found') return -1 end
	if(table_[v_.check]==nil) then error('packets if field not found '..v_.check) return -1 end
	
	if(v_.is==nil) then error('packets if is not found') return -1 end
	if(v_.result==nil) then error('packets if result not found') return -1 end
	local result = v_.is.result
	
	local check_result = false
	
	for i=1,#v_.is do
		if(v_.is[i]==table_[v_.check]) then check_result=true break end
	end
	if(check_result==result) then
		if(v_.at) then cur_count = v_.at end
		
		cur_count = PACKETS:handle_fields(table_,data_,v_.on[v_case],pref_,cur_count,size)
		if(cur_count == -1) then return -1 end
	end
	
	return cur_count
end

function PACKETS:handle_response(table_,data_,response_,v_data_,pref_,cur_count,size)
	if(response_.on(v_data_,response_.on_arguments)) then
	if(size==nil) then print('nil size handle_response in '..pref_) end
		cur_count = PACKETS:handle_fields(table_,data_,response_.fields,pref_,cur_count,size)
		if(cur_count == -1) then return -1 end
	end
	return cur_count
end

function PACKETS:handle_fields(table_,data_,fields_,pref_,cur_count,size)
	if(size==nil) then print('nil size handle_fields in '..pref_) end
	for k,v in pairs(fields_) do
		local base_type,amount_size = stringFunctions:get_array_info(v.ctype)
		local is_open_arr = stringFunctions:ends_with(base_type,'*')
		
		if(is_open_arr) then base_type = stringFunctions:trim_end(base_type,'*') end
		
		if(v.at) then cur_count = v.at end
		
		if(is_open_arr) then
			if(pref_~='') then error('packets open array type outside root field') return -1 end
			
			if(base_type=='base_type') then
				table_[pref_..v.label]=stringFunctions:sub_withoutNonChar(data_,(cur_count/8)+1)
			else
				
				--nov 2020 update fix. credits to atom0s
				local idSize = struct.unpack('H', data_, 0x00 + 1);
				local msgSize = (4 * (bit.rshift(idSize, 9)) - ((cur_count/8)+1)) + 1;
				local msg = struct.unpack(string.format('c%d', msgSize), data_, (cur_count/8)+1);
				
				table_[pref_..v.label]=msg
			end
			
			cur_count = size
			break
		elseif(base_type=='fori') then
			cur_count = PACKETS:handle_fori(table_,data_,v,pref_,cur_count,size)
		elseif(base_type=='case') then
			cur_count = PACKETS:handle_case(table_,data_,v,pref_,cur_count,size)
		elseif(base_type=='if') then
			cur_count = PACKETS:handle_if(table_,data_,v,pref_,cur_count,size)
		else
			local base_size= sizes[base_type]
			if(base_size==nil) then print('type not found '..base_type) return -1 end
			if(amount_size==nil) then amount_size=1 end
			
			local field_data = nil
			if(v.array_size) then
				for i=1,v.array_size do
					field_data = ashita.bits.unpack_be(data_,cur_count,base_size*amount_size)
					if(format_field[base_type]) then field_data = format_field[base_type](field_data,amount_size) end
				
					table_[pref_..v.label..'['..i..']']=field_data
					cur_count = cur_count+(base_size*amount_size)
				end
			else
				
				if(format_field[base_type]) then 
					field_data = format_field[base_type](data_,cur_count,amount_size) 
				else
					if(base_type=='float') then
						field_data = struct.unpack('f', data_, (cur_count/8)+1)
					else					
						field_data = ashita.bits.unpack_be(data_,cur_count,base_size*amount_size)
					end
				end
				
				if(v.type) then field_data = format_type[v.type](field_data) end
				
				table_[pref_..v.label]=field_data
				
				cur_count = cur_count+(base_size*amount_size)
			end
			
			if(v.response) then
				cur_count = PACKETS:handle_response(table_,data_,v.response,field_data,pref_,cur_count,size)
				if(cur_count == -1) then return -1 end
			end
		end
	end
	return cur_count
end


function PACKETS:parse(data_,from_)
	current_id =  ashita.bits.unpack_be(data_,0,9)
	 local size =  ashita.bits.unpack_be(data_,9,7)*4*8
	 local sequence = ashita.bits.unpack_be(data_,16,16)
	 
	 if(not fields[from_][current_id]) then print('fields not found for '..current_id..' '..size..' '..sequence) return nil end
	
	local cur_count = 32
	
	if(size==nil) then print('nil size parse_incoming in ') end
	local ret_table = {}
	cur_count = PACKETS:handle_fields(ret_table,data_,fields[from_][current_id],'',cur_count,size)
	
	return ret_table
end

function PACKETS:parse_incoming(data_)
	return PACKETS:parse(data_,'incoming')
end

function PACKETS:parse_outgoing(data_)
	return PACKETS:parse(data_,'outgoing')
end