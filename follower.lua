_addon.name = 'follower'

_addon.author = 'Onionknight'

_addon.version = '0.0.0.1'

require('common')
require('packets/packets_light')

local player = GetEntity(AshitaCore:GetDataManager():GetParty():GetMemberTargetIndex(0));
local player_name = AshitaCore:GetDataManager():GetParty():GetMemberName(0)

local player_position = {
	['x']=player['Movement']['LocalPosition']['X'],
	['y']=player['Movement']['LocalPosition']['Y'],
	['z']=player['Movement']['LocalPosition']['Z'],
}

local target_name = ''
local target_position = {
	['x']=player['Movement']['LocalPosition']['X'],
	['y']=player['Movement']['LocalPosition']['Y'],
	['z']=player['Movement']['LocalPosition']['Z'],
}

local followers = {}
local is_moving = false
local min_follow_distance = 0.4
local max_follow_distance = 1.5
local min_focal_distance = 2

--credits to atom0s for the memory positions for the camera
--credits to Hokuten85 and his addon XICamera for giving me this idea 
--by setting the camera to first person and moving in the direction of the target you follow the target
--by checking focal distance between camera and target you see if the camera is in first person
local pointerToCameraPointer = ashita.memory.findpattern('FFXiMain.dll', 0, '83C40485C974118B116A01FF5218C705', 0, 0);
if (pointerToCameraPointer == 0) then error('Failed to locate critical signature #2!'); end
pointerToCamera = ashita.memory.read_uint32(pointerToCameraPointer + 0x10);
if (pointerToCamera == 0) then error('Failed to locate critical signature #3!'); end
local rootCameraAddress = ashita.memory.read_uint32(pointerToCamera);

ashita.register_event('outgoing_packet', function(id, size, data, packet_modified, blocked)
	
	--need 0x015
	if(id==0x015) then
		packet = PACKETS:parse_outgoing(data)
		if(player_position.x~=packet['X'] or player_position.y~=packet['Y'] or player_position.z~=packet['Z']) then
			player_position.x = packet['X']
			player_position.y = packet['Y']
			player_position.z = packet['Z']
			report_position()
		end
	end
    return false;
end);

--remove text from the front if the text starts with given testtext
local function trim_start(input_,start_)
	if(input_:sub(1, #start_) == start_) then
		return string.sub(input_,string.len(start_),-1)
	end
	return input_
end

--split text by seperator
local function split(inputstr, sep)
	if sep == nil then
	   sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

--check if text starts with a given text
local function starts_with(str, start)
   return str:sub(1, #start) == start
end

ashita.register_event('command', function(cmd, nType)
	--dont run if its not for us
	if(not starts_with(cmd,'/'.._addon.name)) then return false end
    
	--split to get arguments
	cmd = trim_start(cmd,'/'.._addon.name..' ')
	local args = split(cmd,' ')
	
	if(args[1]=='add') then 
		--add given follower to your list to send position to
		if(#args~=2) then print('followers requires 1 argument in the add command.') return true end
		add_follower(args[2])
	elseif(args[1]=='remove') then 
		--remove given follower from your list to send position to
		if(#args~=2) then print('followers requires 1 argument in the remove command.') return true end
		remove_follower(args[2])
	elseif(args[1]=='clear') then 
		--clear follow list
		if(#args~=1) then print('followers requires no argument in the clear command.') return true end
		followers = {}
	elseif(args[1]=='pos_report') then --automated comand 
		--automated command. position given by target
		if(#args~=5) then print('followers requires 4 arguments in the pos_report command.') return true end
		if(args[2]~=target_name) then print('followers requires 2nd argument in the pos_report command to be the current target.') return true end
		if(tonumber(args[3]==nil) or tonumber(args[4]==nil) or tonumber(args[5]==nil)) then print('followers requires last 3 arguments in the pos_report command to be numbers.') return true end
		target_position.x =args[3]
		target_position.y =args[4]
		target_position.z =args[5]
	elseif(args[1]=='tar_set') then --automated command
		--automaded command. sets target who the character follows
		if(#args~=2) then print('followers requires 1 argument in the tar_set command.') return true end
		print('following '..args[2])
		target_name=args[2]
		if(target_name==-1) then
			--stop following target
			stop_timer()
		else
			--start following target
			start_timer()
		end
	end
    return true;
end)

--distance between 2 2d coordinates
local function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( (dx * dx) + (dy * dy) )
end

--focal distance between camera origin and given position in x and z axis
local function get_focal_distance(pX,pZ)
	return distance(pX,pZ,ashita.memory.read_float(rootCameraAddress + 0x50),ashita.memory.read_float(rootCameraAddress + 0x58))	
end

--is num between min and max
local function is_between(num,min_,max_)
	return num>=min_ and num<=max_
end

--check if camera is first person and set to third person
local function camera_to_third()
	--check first person camera. set to third person if not
	if(is_between(get_focal_distance(player_position.x,player_position.z),min_focal_distance,100)) then
		AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD5 down',-1)
		AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD5 up',-1)
		CAMERA_WAIT_UNTIL = os.clock()+CAMERA_WAIT_STEP
	end
end

--check if camera in third person and set to first person
local function camera_to_first()
	--check first person camera. set to first person if not
	if(get_focal_distance(player_position.x,player_position.z)<min_focal_distance) then
		AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD5 down',-1)
		AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD5 up',-1)
		CAMERA_WAIT_UNTIL = os.clock()+CAMERA_WAIT_STEP
	end
end

--add given follower to your list to send position to
function add_follower(name)
	for n=1,#followers do
		if(followers[n]==name) then return end
	end
	table.insert(followers,name)
	AshitaCore:GetChatManager():QueueCommand('/ms sendto '..name..' /follower tar_set '..player_name,-1)
end

--remove given follower by index in list from your list to send position to
function remove_follower_by_index(i)
	AshitaCore:GetChatManager():QueueCommand('/ms sendto '..followers[i]..' /follower tar_set',-1)
	table.remove(followers,i)
end

--remove given follower from your list to send position to
function remove_follower(name)
	for n=1,#followers do
		if(followers[n]==name) then 
			remove_follower_by_index(n)
			return
		end
	end
end

--clear follower list
function clear_follower()
	for n=#followers,1,-1 do
		remove_follower_by_index(n)
	end
end

--start following timer
function start_timer()--check first person camera. set to first if not
	camera_to_first()
	ashita.timer.start_timer('follow_timer')
end

--stop following timer
function stop_timer()
	camera_to_third()
	ashita.timer.stop('follow_timer')
	AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD8 up',-1)
end

--report position to who is following you
function report_position()
	for i=1,#followers do
		AshitaCore:GetChatManager():QueueCommand('/ms sendto '..followers[i]..' /follower pos_report '..player_name..' '..player_position.x..' '..player_position.y..' '..player_position.z,-1)
	end
end

--move loop. change direction. check distance
function move_follow()
	if(target_name and  target_name~= '') then
		follow_distance = distance(player_position.x,player_position.z,target_position.x,target_position.z)
		--if distance is higher than minimum then move
		if(follow_distance>max_follow_distance and follow_distance<min_follow_distance) then
			local player = GetEntity(AshitaCore:GetDataManager():GetParty():GetMemberTargetIndex(0));
			local angle = (math.atan2((target_position.z - player_position.z), (target_position.x - player_position.x)) * 180 / math.pi) * -1.0;
			local radian = math.degree2rad(angle) -- + 180);
			
			if (radian) then
				ashita.memory.write_float(player['WarpPointer'] + 0x48, radian);
				ashita.memory.write_float(player['WarpPointer'] + 0x5D8, radian);
			end

			if(is_moving==false) then
				AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD8 down',-1)
				is_moving=true
			end
		else
			if(is_moving==true) then
				AshitaCore:GetChatManager():QueueCommand('/sendkey NUMPAD8 up',-1)
				is_moving=false
			end
		end
		
	end
end

--create timers
ashita.timer.stop('follow_timer')
ashita.timer.adjust_timer('follow_timer',0.1,-1,function()
	move_follow() end)
