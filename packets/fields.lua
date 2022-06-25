require('onion/struct/insertion_ordered_table')


local fields = {}
fields.outgoing = {}
fields.incoming = {}

local function boolean_true(check_)  
	return check_==true 
end
local function boolean_false(check_) return check_==false end

-- Standard Client
fields.outgoing[0x015] = {
    {ctype='float',             label='X'},                                     -- 04
    {ctype='float',             label='Y'},                                     -- 08
    {ctype='float',             label='Z'},                                     -- 0C
    {ctype='unsigned short',    label='_junk1'},                                -- 10
    {ctype='unsigned short',    label='Run Count'},                             -- 12   Counter that indicates how long you've been running?
    {ctype='unsigned char',     label='Rotation',           fn=dir},            -- 14
    {ctype='unsigned char',     label='_flags1'},                               -- 15   Bit 0x04 indicates that maintenance mode is activated
    {ctype='unsigned short',    label='Target Index',       fn=index},          -- 16
    {ctype='unsigned int',      label='Timestamp',          fn=time_ms},        -- 18   Milliseconds
    {ctype='unsigned int',      label='_unknown3'},                             -- 1C
}

--Unknown NYI on zone. 52 bytes
fields.incoming[0x008] = {                             -- 14
    {ctype='bit',    label='_Unknown', array_size=48},
}

--Standard message NYI. on zone. 
fields.incoming[0x009] = {
	-- 0x0a = anon flag? AF = on, B0 = off
}

-- Zone update
fields.incoming[0x00A] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 08
    {ctype='unsigned char',     label='_padding'},                              -- 0A     
    {ctype='unsigned char',     label='Heading',            fn=dir},            -- 0B -- 0B to 
    {ctype='float',             label='X'},                                     -- 0C
    {ctype='float',             label='Z'},                                     -- 10
    {ctype='float',             label='Y'},                                     -- 14
    {ctype='unsigned short',    label='Run Count'},                             -- 18
    {ctype='unsigned short',    label='Target Index',       fn=index},          -- 1A
    {ctype='unsigned char',     label='Movement Speed'},                        -- 1C   32 represents 100%
    {ctype='unsigned char',     label='Animation Speed'},                       -- 1D   32 represents 100%
    {ctype='unsigned char',     label='HP %',               fn=percent},        -- 1E
    {ctype='unsigned char',     label='Status',             fn=statuses},       -- 1F
    {ctype='data[16]',          label='_unknown1'},                             -- 20
    {ctype='unsigned short',    label='Zone',               fn=zone},           -- 30
    {ctype='data[6]',           label='_unknown2'},                             -- 32
    {ctype='unsigned int',      label='Timestamp 1',        fn=time},           -- 38
    {ctype='unsigned int',      label='Timestamp 2',        fn=time},           -- 3C
    {ctype='unsigned short',    label='_unknown3'},                             -- 40
    {ctype='unsigned short',    label='_dupeZone',          fn=zone},           -- 42
    {ctype='unsigned char',     label='Face'},                                  -- 44
    {ctype='unsigned char',     label='Race'},                                  -- 45
    {ctype='unsigned short',    label='Head'},                                  -- 46
    {ctype='unsigned short',    label='Body'},                                  -- 48
    {ctype='unsigned short',    label='Hands'},                                 -- 4A
    {ctype='unsigned short',    label='Legs'},                                  -- 4C
    {ctype='unsigned short',    label='Feet'},                                  -- 4E
    {ctype='unsigned short',    label='Main'},                                  -- 50
    {ctype='unsigned short',    label='Sub'},                                   -- 52
    {ctype='unsigned short',    label='Ranged'},                                -- 54
    {ctype='unsigned short',    label='Day Music'},                             -- 56
    {ctype='unsigned short',    label='Night Music'},                           -- 58
    {ctype='unsigned short',    label='Solo Combat Music'},                     -- 5A
    {ctype='unsigned short',    label='Party Combat Music'},                    -- 5C
    {ctype='data[4]',           label='_unknown4'},                             -- 5E
    {ctype='unsigned short',    label='Menu Zone'},                             -- 62   Only set if the menu ID is sent, used as the zone for menu responses (0x5b, 0x5c)
    {ctype='unsigned short',    label='Menu ID'},                               -- 64
    {ctype='unsigned short',    label='_unknown5'},                             -- 66
    {ctype='unsigned short',    label='Weather',            fn=weather},        -- 68
    {ctype='unsigned short',    label='_unknown6'},                             -- 6A
    {ctype='data[24]',          label='_unknown7'},                             -- 6C
    {ctype='char[16]',          label='Player Name'},                           -- 84
    {ctype='data[12]',          label='_unknown8'},                             -- 94
    {ctype='unsigned int',      label='Abyssea Timestamp',  fn=time},           -- A0
    {ctype='unsigned int',      label='_unknown9',          const=0x0003A020},  -- A4
    {ctype='data[2]',           label='_unknown10'},                            -- A8
    {ctype='unsigned short',    label='Zone model'},                            -- AA
    {ctype='data[8]',           label='_unknown11'},                            -- AC   0xAC is 2 for some zones, 0 for others
    {ctype='unsigned char',     label='Main Job',           fn=job},            -- B4
    {ctype='unsigned char',     label='_unknown12'},                            -- B5
    {ctype='unsigned char',     label='_unknown13'},                            -- B6
    {ctype='unsigned char',     label='Sub Job',            fn=job},            -- B7
    {ctype='unsigned int',      label='_unknown14'},                            -- B8
	{ctype='fori', label='Job' ,	i=1,till=16,fields = {						-- BC
		{ctype='unsigned char',     label='Level'},                             -- 00
	}},
    {ctype='signed short',      label='STR'},                                   -- CC
    {ctype='signed short',      label='DEX'},                                   -- CE
    {ctype='signed short',      label='VIT'},                                   -- D0
    {ctype='signed short',      label='AGI'},                                   -- D2
    {ctype='signed short',      label='IND'},                                   -- F4
    {ctype='signed short',      label='MND'},                                   -- D6
    {ctype='signed short',      label='CHR'},                                   -- D8
    {ctype='signed short',      label='STR Bonus'},                             -- DA
    {ctype='signed short',      label='DEX Bonus'},                             -- DC
    {ctype='signed short',      label='VIT Bonus'},                             -- DE
    {ctype='signed short',      label='AGI Bonus'},                             -- E0
    {ctype='signed short',      label='INT Bonus'},                             -- E2
    {ctype='signed short',      label='MND Bonus'},                             -- E4
    {ctype='signed short',      label='CHR Bonus'},                             -- E6
    {ctype='unsigned int',      label='Max HP'},                                -- E8
    {ctype='unsigned int',      label='Max MP'},                                -- EC
    {ctype='data[20]',          label='_unknown15'},                            -- F0
}

-- Zone Response
fields.incoming[0x00B] = {
    {ctype='unsigned int',      label='Type'							 },     -- 04
    {ctype='unsigned int',      label='IP',                 fn=ip},             -- 08
    {ctype='unsigned short',    label='Port'},                                  -- 0C
    {ctype='unsigned short',    label='_unknown1'},                             -- 10
    {ctype='unsigned short',    label='_unknown2'},                             -- 12
    {ctype='unsigned short',    label='_unknown3'},                             -- 14
    {ctype='unsigned short',    label='_unknown4'},                             -- 16
    {ctype='unsigned short',    label='_unknown5'},                             -- 18
    {ctype='unsigned short',    label='_unknown6'},                             -- 1A
    {ctype='unsigned short',    label='_unknown7'},                             -- 1C
}

-- PC Update
fields.incoming[0x00D] = {
    -- The flags in this byte are complicated and may not strictly be flags.
    -- Byte 0x20: -- Mentor is somewhere in this byte
    -- 01 = None
    -- 02 = Deletes everyone
    -- 04 = Deletes everyone
    -- 08 = None
    -- 16 = None
    -- 32 = None
    -- 64 = None
    -- 128 = None


    -- Byte 0x21:
    -- 01 = None
    -- 02 = None
    -- 04 = None
    -- 08 = LFG
    -- 16 = Anon
    -- 32 = Turns your name orange
    -- 64 = Away
    -- 128 = None

    -- Byte 0x22:
    -- 01 = POL Icon, can target?
    -- 02 = no notable effect
    -- 04 = DCing
    -- 08 = Untargettable
    -- 16 = No linkshell
    -- 32 = No Linkshell again
    -- 64 = No linkshell again
    -- 128 = No linkshell again

    -- Byte 0x23:
    -- 01 = Trial Account
    -- 02 = Trial Account
    -- 04 = GM Mode
    -- 08 = None
    -- 16 = None
    -- 32 = Invisible models
    -- 64 = None
    -- 128 = Bazaar

    {ctype='unsigned int',      label='Player'},            					 -- 04
    {ctype='unsigned short',    label='Index'},          						-- 08
    {ctype='boolbit',           label='Update Position'},                       -- 0A:0 Position, Rotation, Target, Speed  
    {ctype='boolbit',           label='Update Status'},                         -- 1A:1 Not used for 0x00D
    {ctype='boolbit',           label='Update Vitals'},                         -- 0A:2 HP%, Status, Flags, LS color, "Face Flags"
    {ctype='boolbit',           label='Update Name'},                           -- 0A:3 Name
    {ctype='boolbit',           label='Update Model'},                          -- 0A:4 Race, Face, Gear models
    {ctype='boolbit',           label='Despawn'},                               -- 0A:5 Only set if player runs out of range or zones
    {ctype='boolbit',           label='_unknown1'},                             -- 0A:6
    {ctype='boolbit',           label='_unknown2'},                             -- 0A:6
    {ctype='unsigned char',     label='Heading'},            		            -- 0B
    {ctype='float',             label='X'},                                     -- 0C
    {ctype='float',             label='Y'},                                     -- 10
    {ctype='float',             label='Z'},                                     -- 14
    {ctype='bit[13]',           label='Run Count'},                             -- 18:0 Analogue to Run Count from outgoing 0x015
    {ctype='bit[3]',            label='_unknown3'},                             -- 19:5 Analogue to Run Count from outgoing 0x015
    {ctype='boolbit',           label='_unknown4'},                             -- 1A:0
    {ctype='bit[15]',           label='Target Index'},       		            -- 1A:1
    {ctype='unsigned char',     label='Movement Speed'},                        -- 1C   32 represents 100%
    {ctype='unsigned char',     label='Animation Speed'},                       -- 1D   32 represents 100%
    {ctype='unsigned char',     label='HP %'},               		            -- 1E
    {ctype='unsigned char',     label='Status'},       						    -- 1F
    {ctype='unsigned int',      label='Flags'},                                 -- 20
    {ctype='unsigned char',     label='Linkshell Red'},                         -- 24
    {ctype='unsigned char',     label='Linkshell Green'},                       -- 25
    {ctype='unsigned char',     label='Linkshell Blue'},                        -- 26
    {ctype='unsigned char',     label='_unknown5'},                             -- 27   Probably junk from the LS color dword
    --{ctype='data[0x1A]',        label='_unknown6'},                           -- 28   DSP notes that the 6th bit of byte 54 is the Ballista flag
    {ctype='data[20]',        label='_unknown6_1'},                             --    
    {ctype='data[3]',        label='Pet Index'},                             	-- check for retail
    {ctype='data[3]',        label='_unknown6_3'},                             	--    
    
	
	{ctype='unsigned char',     label='Indi Bubble'},                           -- 42   Geomancer (GEO) Indi spell effect on players. 0 is no effect.
    {ctype='unsigned char',     label='Face Flags'},                            -- 43   0, 3, 4, or 8
    {ctype='data[4]',           label='_unknown7'},                             -- 44
    {ctype='unsigned char',     label='Face'},                                  -- 48
    {ctype='unsigned char',     label='Race'},                                  -- 49
    {ctype='unsigned short',    label='Head'},                                  -- 4A
    {ctype='unsigned short',    label='Body'},                                  -- 4C
    {ctype='unsigned short',    label='Hands'},                                 -- 4E
    {ctype='unsigned short',    label='Legs'},                                  -- 50
    {ctype='unsigned short',    label='Feet'},                                  -- 52
    {ctype='unsigned short',    label='Main'},                                  -- 54
    {ctype='unsigned short',    label='Sub'},                                   -- 56
    {ctype='unsigned short',    label='Ranged'},                                -- 58
    {ctype='char*',             label='Character Name'}                         -- 5A -   *

}

--npc/pet update
fields.incoming[0x00E] = {
    {ctype='unsigned int',      label='NPC'},             						-- 04
    {ctype='unsigned short',    label='Index'},          						-- 08
    -- {ctype='unsigned char',     label='Mask'},        						-- 0A   Bits that control which parts of the packet are actual updates (rest is zeroed). Model is always sent
	{ctype='boolbit',           label='Update Position'},						-- 0A   Bit 0: Position, Rotation, Walk Count								
	{ctype='boolbit',           label='Update Claim'},							-- 0A	Bit 1: Claimer ID							
	{ctype='boolbit',           label='Update Vitals'},							-- 0A   Bit 2: HP, Status						
	{ctype='boolbit',           label='Update Name'},							-- 0A   Bit 3: Name									
	{ctype='boolbit',           label='Update Unknown bit4'},					-- 0A   Bit 4:
	{ctype='boolbit',           label='Update Despawn'},						-- 0A   Bit 5: The client stops displaying the mob when this bit is set (dead, out of range, etc.)							
	{ctype='boolbit',           label='Update Unknown bit6'},					-- 0A   Bit 6:									
	{ctype='boolbit',           label='Update Unknown bit7'},					-- 0A   Bit 7:
    {ctype='unsigned char',     label='Rotation'},            					-- 0B
    {ctype='float',             label='X'},                                     -- 0C
    {ctype='float',             label='Y'},                                     -- 10
    {ctype='float',             label='Z'},                                     -- 14
    {ctype='unsigned int',      label='Walk Count'},                            -- 18   Steadily increases until rotation changes. Does not reset while the mob isn't walking. Only goes until 0xFF1F.
    {ctype='unsigned short',    label='_unknown1'},        						-- 1A
    {ctype='unsigned char',     label='HP %'},        							-- 1E
    {ctype='unsigned char',     label='Status'},       							-- 1F   Status used to be 0x20
    {ctype='unsigned int',      label='_unknown2'},        						-- 20
    {ctype='unsigned int',      label='_unknown3'},        						-- 24
    {ctype='unsigned int',      label='_unknown4'},        						-- 28   In Dynamis - Divergence statue's eye colors
    {ctype='unsigned int',      label='Claimer'},             					-- 2C
    {ctype='unsigned short',    label='_unknown5'},                             -- 30
    {ctype='unsigned short',    label='Model'},                                 -- 32
    {ctype='char*',             label='Name'},                                  -- 34 -   *
}

-- Incoming Chat
-- fields.incoming[0x017] = {
    -- {ctype='unsigned char',     label='Mode',               fn=chat},           -- 04
    -- {ctype='bool',              label='GM'},                                    -- 05
    -- {ctype='unsigned short',    label='Zone',               fn=zone},           -- 06   Set only for Yell                          -- 08
	-- {ctype='char[0xF]',        label='Sender Name'},                           -- 08
    -- {ctype='char*',             label='Message'},                               -- 18   Max of 150 characters
-- }

fields.incoming[0x017] = {
    {ctype='unsigned char',     label='Mode'},           -- 04
	{ctype='case', check = 'Mode', on = {
		['default'] = {
			{ctype='bool',              label='GM'},                                    -- 05
			{ctype='unsigned short',    label='_padding1',},                            -- 06   Reserved for Yell and Assist Modes
			{ctype='char[0xF]',         label='Sender Name'},                           -- 08
			{ctype='char*',             label='Message'},  
		},
		[0x1A] = {
			{ctype='bool',              label='GM'},                                    -- 05
			{ctype='unsigned short',    label='Zone'},             -- 06   Zone ID of sender
			{ctype='char[0xF]',         label='Sender Name'},                           -- 08
			{ctype='char*',             label='Message'},                               -- 17   Max of 150 characters
		},
		-- [0x21] = { -- unity
			-- {ctype='data[255]',              label='GM'},                                    -- 05
		-- },
		[0x22] = {
			{ctype='bool',              label='GM'},                                    -- 05
			{ctype='unsigned char',     label='Mastery Rank'},                          -- 06   Sender Mastery Rank
			{ctype='unsigned char',     label='Mentor Icon'},-- 07   Color of Mentor Flag
			{ctype='char[0xF]',         label='Sender Name'},                           -- 08
			{ctype='char*',             label='Message'},                               -- 17   Max of 150 characters
		},
		[0x23] = {
			{ctype='bool',              label='GM'},                                    -- 05
			{ctype='unsigned char',     label='Mastery Rank'},                          -- 06   Sender Mastery Rank
			{ctype='unsigned char',     label='Mentor Icon'},-- 07   Color of Mentor Flag
			{ctype='char[0xF]',         label='Sender Name'},                           -- 08
			{ctype='char*',             label='Message'},                               -- 17   Max of 150 characters
		},
	}},
}


--[[ 0x2A can be triggered by knealing in the right areas while in the possession of a VWNM KI:
    Field1 will be lights level:
    0 = 'Tier 1', -- faintly/feebly depending on whether it's outside of inside Abyssea
    1 = 'Tier 2', -- softly
    2 = 'Tier 3', -- solidly. Highest Tier in Abyssea
    3 = 'Tier 4', --- strongly
    4 = 'Tier 5', -- very strongly.  Unused currently
    5 = 'Tier 6', --- furiously.  Unused currently
    - But if there are no mobs left in area, or no mobs nearby, field1 will be the KeyItem#
    1253 = 'Clear Abyssite'
    1254 = 'Colorful Abyssite'
    1564 = 'Clear Demilune Abyssite'
    etc.

    Field2 will be direction:
    0 = 'East'
    1 = 'Southeast'
    2 = 'South'
    3 = 'Southwest'
    4 = 'West'
    5 = 'Northwest'
    6 = 'North'
    7 = 'Northeast'

    Field3 will be distance. When there are no mobs, this value is set to 300000

    Field4 will be KI# of the abyssite used. Ex:
    1253 = 'Clear Abyssite'
    1254 = 'Colorful Abyssite'
    1564 = 'Clear Demilune Abyssite'
    etc.
]]

--[[  0x2A can also be triggered by buying/disposing of a VWNM KI from an NPC:
      Index/ID field will be those of the NPC
      Field1 will be 1000 (gil) when acquiring in Jueno, 300 (cruor) when acquiring in Abyssea
      Field2 will be the KI# acquired
      Fields are used slighly different when dropping the KI using the NPC.
]]

--[[  0x2A can also be triggered by spending cruor by buying non-vwnm related items, or even activating/using Flux
      Field1 will be the amount of cruor spent
]]
      
     
--[[ 0x2A can also be triggered by zoning into Abyssea:
     Field1 will be set to your remaining time. 5 at first, then whatever new value when acquiring visiting status.
     0x2A will likely be triggered as well when extending your time limit. Needs verification.
]]


--[[ 0x2A can be triggered sometimes when zoning into non-Abyssea:
     Not sure what it means.
]]

-- Resting Message
fields.incoming[0x02A] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned int',      label='Param 1'},                               -- 08
    {ctype='unsigned int',      label='Param 2'},                               -- 0C
    {ctype='unsigned int',      label='Param 3'},                               -- 10
    {ctype='unsigned int',      label='Param 4'},                               -- 14
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 18
    {ctype='unsigned short',    label='Message ID'},                            -- 1A   The high bit is occasionally set, though the reason for it is unclear.
    {ctype='unsigned int',      label='_unknown1'},                             -- 1C   Possibly flags, 0x06000000 and 0x02000000 observed
}

fields.incoming[0x044] = {
    {ctype='unsigned char',     label='Job',                fn=job},            -- 04
    {ctype='bool',              label='Subjob'},                                -- 05
    {ctype='unsigned short',    label='_unknown1'},                             -- 06
	{ctype='case', check = 'Job', on = {
		[0x12] = {
			{ctype='unsigned char',     label='Automaton Head'},                        -- 08   Harlequinn 1, Valoredge 2, Sharpshot 3, Stormwaker 4, Soulsoother 5, Spiritreaver 6
			{ctype='unsigned char',     label='Automaton Frame'},                       -- 09   Harlequinn 20, Valoredge 21, Sharpshot 22, Stormwaker 23
			{ctype='unsigned char',     label='Slot 1'},                                -- 0A   Attachment assignments are based off their position in the equipment list.
			{ctype='unsigned char',     label='Slot 2'},                                -- 0B   Strobe is 01, etc.
			{ctype='unsigned char',     label='Slot 3'},                                -- 0C
			{ctype='unsigned char',     label='Slot 4'},                                -- 0D
			{ctype='unsigned char',     label='Slot 5'},                                -- 0E
			{ctype='unsigned char',     label='Slot 6'},                                -- 0F
			{ctype='unsigned char',     label='Slot 7'},                                -- 10
			{ctype='unsigned char',     label='Slot 8'},                                -- 11
			{ctype='unsigned char',     label='Slot 9'},                                -- 12
			{ctype='unsigned char',     label='Slot 10'},                               -- 13
			{ctype='unsigned char',     label='Slot 11'},                               -- 14
			{ctype='unsigned char',     label='Slot 12'},                               -- 15
			{ctype='unsigned short',    label='_unknown2'},                             -- 16
			{ctype='unsigned int',      label='Available Heads'},                       -- 18   Flags for the available heads (Position corresponds to Item ID shifted down by 8192)
			{ctype='unsigned int',      label='Available Bodies'},                      -- 1C   Flags for the available bodies (Position corresponds to Item ID)
			{ctype='unsigned int',      label='_unknown3'},                             -- 20
			{ctype='unsigned int',      label='_unknown4'},                             -- 24
			{ctype='unsigned int',      label='_unknown5'},                             -- 28
			{ctype='unsigned int',      label='_unknown6'},                             -- 2C
			{ctype='unsigned int',      label='_unknown7'},                             -- 30
			{ctype='unsigned int',      label='_unknown8'},                             -- 34
			{ctype='unsigned int',      label='Fire Attachments'},                      -- 38   Flags for the available Fire Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Ice Attachments'},                       -- 3C   Flags for the available Ice Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Wind Attachments'},                      -- 40   Flags for the available Wind Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Earth Attachments'},                     -- 44   Flags for the available Earth Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Thunder Attachments'},                   -- 48   Flags for the available Thunder Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Water Attachments'},                     -- 4C   Flags for the available Water Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Light Attachments'},                     -- 50   Flags for the available Light Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Dark Attachments'},                      -- 54   Flags for the available Dark Attachments (Position corresponds to Item ID)
			{ctype='char[16]',          label='Pet Name'},                              -- 58
			{ctype='unsigned short',    label='Current HP'},                            -- 68
			{ctype='unsigned short',    label='Max HP'},                                -- 6A
			{ctype='unsigned short',    label='Current MP'},                            -- 6C
			{ctype='unsigned short',    label='Max MP'},                                -- 6E
			{ctype='unsigned short',    label='Current Melee Skill'},                   -- 70
			{ctype='unsigned short',    label='Max Melee Skill'},                       -- 72
			{ctype='unsigned short',    label='Current Ranged Skill'},                  -- 74
			{ctype='unsigned short',    label='Max Ranged Skill'},                      -- 76
			{ctype='unsigned short',    label='Current Magic Skill'},                   -- 78
			{ctype='unsigned short',    label='Max Magic Skill'},                       -- 7A
			{ctype='unsigned int',      label='_unknown9'},                             -- 7C
			{ctype='unsigned short',    label='Base STR'},                              -- 80
			{ctype='unsigned short',    label='Additional STR'},                        -- 82
			{ctype='unsigned short',    label='Base DEX'},                              -- 84
			{ctype='unsigned short',    label='Additional DEX'},                        -- 86
			{ctype='unsigned short',    label='Base VIT'},                              -- 88
			{ctype='unsigned short',    label='Additional VIT'},                        -- 8A
			{ctype='unsigned short',    label='Base AGI'},                              -- 8C
			{ctype='unsigned short',    label='Additional AGI'},                        -- 8E
			{ctype='unsigned short',    label='Base INT'},                              -- 90
			{ctype='unsigned short',    label='Additional INT'},                        -- 92
			{ctype='unsigned short',    label='Base MND'},                              -- 94
			{ctype='unsigned short',    label='Additional MND'},                        -- 96
			{ctype='unsigned short',    label='Base CHR'},                              -- 98
			{ctype='unsigned short',    label='Additional CHR'},                        -- 9A
		},
		
		-- ['default'] = {
			-- {ctype='bit',     label='unknown',array_size=64},
		-- },
	}},
}
-- Job Info
fields.incoming[0x01B] = {
    {ctype='unsigned int',      label='_unknown1'},                             -- 04   Observed value of 05
    {ctype='unsigned char',     label='Main Job',           fn=job},            -- 08
    {ctype='unsigned char',     label='Flag or Main Job Level?'},               -- 09
    {ctype='unsigned char',     label='Flag or Sub Job Level?'},                -- 0A
    {ctype='unsigned char',     label='Sub Job',            fn=job},            -- 0B
    {ctype='bit[32]',           label='Sub/Job Unlock Flags'},                  -- 0C   Indicate whether subjob is unlocked and which jobs are unlocked. lsb of 0x0C indicates subjob unlock.
    {ctype='unsigned char',     label='_unknown3'},                             -- 10   Flag or List Start
	{ctype='fori', label='Old_' , label_lookup='jobs', label_lookup_field='en' ,	i=1,till=0x0F,fields = {
		{ctype='unsigned char',     label='Level'},                                 -- 00
	}},
    {ctype='unsigned short',    label='Base STR'},                              -- 20  -- Altering these stat values has no impact on your equipment menu.
    {ctype='unsigned short',    label='Base DEX'},                              -- 22
    {ctype='unsigned short',    label='Base VIT'},                              -- 24
    {ctype='unsigned short',    label='Base AGI'},                              -- 26
    {ctype='unsigned short',    label='Base INT'},                              -- 28
    {ctype='unsigned short',    label='Base MND'},                              -- 2A
    {ctype='unsigned short',    label='Base CHR'},                              -- 2C
    {ctype='data[14]',          label='_unknown4'},                             -- 2E   Flags and junk? Hard to say. All 0s observed.
    {ctype='unsigned int',      label='Maximum HP'},                            -- 3C
    {ctype='unsigned int',      label='Maximum MP'},                            -- 40
    {ctype='unsigned int',      label='Flags'},                                 -- 44   Looks like a bunch of flags. Observed value if 01 00 00 00
    {ctype='unsigned char',     label='_unknown5'},                             -- 48   Potential flag to signal the list start. Observed value of 01   
	{ctype='fori', label='', label_lookup='jobs', label_lookup_field='en' , i=1,till=0x16,fields = {-- 49
		{ctype='unsigned char',     label='Level'},                                 -- 00
	}},
    {ctype='unsigned char',     label='Current Monster Level'},                 -- 5F
    {ctype='unsigned int',      label='Encumbrance Flags'},                     -- 60   [legs, hands, body, head, ammo, range, sub, main,] [back, right_ring, left_ring, right_ear, left_ear, waist, neck, feet] [HP, CHR, MND, INT, AGI, VIT, DEX, STR,] [X X X X X X X MP]
}

-- Inventory Count
-- It is unclear why there are two representations of the size for this.
-- I have manipulated my inventory size on a mule after the item update packets have
-- all arrived and still did not see any change in the second set of sizes, so they
-- may not be max size/used size chars as I initially assumed. Adding them as shorts
-- for now.
-- There appears to be space for another 8 bags.
fields.incoming[0x01C] = {
    {ctype='unsigned char',     label='Inventory Size'},                        -- 04
    {ctype='unsigned char',     label='Safe Size'},                             -- 05
    {ctype='unsigned char',     label='Storage Size'},                          -- 06
    {ctype='unsigned char',     label='Temporary Size'},                        -- 07
    {ctype='unsigned char',     label='Locker Size'},                           -- 08
    {ctype='unsigned char',     label='Satchel Size'},                          -- 09
    {ctype='unsigned char',     label='Sack Size'},                             -- 0A
    {ctype='unsigned char',     label='Case Size'},                             -- 0B
    {ctype='unsigned char',     label='Wardrobe Size'},                         -- 0C
    {ctype='unsigned char',     label='Safe 2 Size'},                           -- 0D
    {ctype='unsigned char',     label='Wardrobe 2 Size'},                       -- 0E
    {ctype='unsigned char',     label='Wardrobe 3 Size'},                       -- 0F
    {ctype='unsigned char',     label='Wardrobe 4 Size'},                       -- 10
    {ctype='data[3]',           label='_padding1',          const=''},          -- 11
    {ctype='unsigned short',    label='_dupeInventory Size'},                   -- 14   These "dupe" sizes are set to 0 if the inventory disabled.
    {ctype='unsigned short',    label='_dupeSafe Size'},                        -- 16
    {ctype='unsigned short',    label='_dupeStorage Size'},                     -- 18   The accumulated storage from all items (uncapped) -1
    {ctype='unsigned short',    label='_dupeTemporary Size'},                   -- 1A
    {ctype='unsigned short',    label='_dupeLocker Size'},                      -- 1C
    {ctype='unsigned short',    label='_dupeSatchel Size'},                     -- 2E
    {ctype='unsigned short',    label='_dupeSack Size'},                        -- 20
    {ctype='unsigned short',    label='_dupeCase Size'},                        -- 22
    {ctype='unsigned short',    label='_dupeWardrobe Size'},                    -- 24
    {ctype='unsigned short',    label='_dupeSafe 2 Size'},                      -- 26
    {ctype='unsigned short',    label='_dupeWardrobe 2 Size'},                  -- 28
    {ctype='unsigned short',    label='_dupeWardrobe 3 Size'},                  -- 2A   This is not set to 0 despite being disabled for whatever reason
    {ctype='unsigned short',    label='_dupeWardrobe 4 Size'},                  -- 2C   This is not set to 0 despite being disabled for whatever reason
    {ctype='data[6]',          label='_padding2',          const=''},           -- 2E
}

-- Finish Inventory
fields.incoming[0x01D] = {
    {ctype='unsigned char',     label='Flag',               const=0x01},        -- 04
    {ctype='data[3]',           label='_junk1'},                                -- 06
}

-- Modify Inventory
fields.incoming[0x01E] = {
    {ctype='unsigned int',      label='Count'},                                 -- 04
    {ctype='unsigned char',     label='Bag',                fn=bag},            -- 08
    {ctype='unsigned char',     label='Index',              },        -- 09
    {ctype='unsigned char',     label='Status',             }, -- 0A
    {ctype='unsigned char',     label='_junk1'},                                -- 0B
}

-- Item Assign
fields.incoming[0x01F] = {
    {ctype='unsigned int',      label='Count'},                                 -- 04
    {ctype='unsigned short',    label='Item',               fn=item},           -- 08
    {ctype='unsigned char',     label='Bag',                fn=bag},            -- 0A
    {ctype='unsigned char',     label='Index',              },    -- 0B
    {ctype='unsigned char',     label='Status',             }, -- 0C
}


-- Item Updates
fields.incoming[0x020] = {
    {ctype='unsigned int',      label='Count'},                                 -- 04
    {ctype='unsigned int',      label='Bazaar'},            -- 08
    {ctype='unsigned short',    label='Item'},           -- 0C
    {ctype='unsigned char',     label='Bag'},            -- 0E
    {ctype='unsigned char',     label='Index'},    -- 0F
    {ctype='unsigned char',     label='Status'}, -- 10
    {ctype='data[24]',          label='ExtData'},     -- 11
    {ctype='data[3]',           label='_junk1'},                                -- 29
}

-- Count to 80
-- Sent after Item Update chunks for active inventory (sometimes) when zoning.
fields.incoming[0x026] = {
    {ctype='data[1]',           label='_unknown1',          const=0x00},        -- 04
    {ctype='unsigned char',     label='Slot'},                                  -- 05   Corresponds to the slot IDs of the previous incoming packet's Item Update chunks for active Inventory.
    {ctype='data[22]',          label='_unknown2',          const=0},           -- 06
}

-- String Message
fields.incoming[0x027] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04   0x0112413A in Omen, 0x010B7083 in Legion, Layer Reserve ID for Ambuscade queue, 0x01046062 for Chocobo circuit
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 08   0x013A in Omen, 0x0083 in Legion , Layer Reserve Index for Ambuscade queue, 0x0062 for Chocobo circuit
    {ctype='unsigned short',    label='Message ID' },            -- 0A   -0x8000
    {ctype='unsigned int',      label='Type'},                                  -- 0C   0x04 for Fishing/Salvage, 0x05 for Omen/Legion/Ambuscade queue/Chocobo Circuit
    {ctype='unsigned int',      label='Param 1'},                               -- 10   Parameter 0 on the display messages dat files
    {ctype='unsigned int',      label='Param 2'},                               -- 14   Parameter 1 on the display messages dat files
    {ctype='unsigned int',      label='Param 3'},                               -- 18   Parameter 2 on the display messages dat files
    {ctype='unsigned int',      label='Param 4'},                               -- 1C   Parameter 3 on the display messages dat files
    {ctype='char[16]',          label='Player Name'},                           -- 20
    {ctype='data[16]',          label='_unknown6'},                             -- 30
    {ctype='char[16]',          label='_dupePlayer Name'},                      -- 40
    {ctype='data[32]',          label='_unknown7'},                             -- 50
}

-- Action
fields.incoming[0x028] = {
    {ctype='unsigned char',     label='Size'},                                  -- 04
    {ctype='unsigned int',      label='Actor'},             					-- 05
    {ctype='bit[10]',           label='Target Count'},                          -- 09:0
    {ctype='bit[4]',            label='Category'},								-- 0A:2
    {ctype='bit[16]',           label='Param'},                                 -- 0C:6
    {ctype='bit[16]',           label='_unknown1'},                             -- 0E:6
    {ctype='bit[32]',           label='Recast'},                                -- 10:6
	{ctype='fori', label='Target' ,	i=1,till='Target Count',fields = {
		{ctype='bit[32]',           label='ID', type='number'},             
		{ctype='bit[4]',            label='Action Count', type='number'}, 
		{ctype='fori', label='Action' ,	i=1,till='Action Count',fields = {
			{ctype='bit[5]',            label='Reaction'},                              -- 00:0
			{ctype='bit[11]',           label='Animation'},                             -- 00:5
			{ctype='bit[5]',            label='Effect'},                                -- 02:0
			{ctype='bit[6]',            label='Stagger'},                               -- 02:5
			{ctype='bit[17]',           label='Param'},                                 -- 03:3
			{ctype='bit[10]',           label='Message'},                               -- 06:2
			{ctype='bit[31]',           label='_unknown'},                              -- 07:4 
			{ctype='boolbit',           label='Has Added Effect', response = { on=boolean_true, on_arguments={}, fields = {
				{ctype='bit[6]',            label='Added Effect Animation'},                -- 00:0
				{ctype='bit[4]',            label='Added Effect Effect'},                   -- 00:6
				{ctype='bit[17]',           label='Added Effect Param'},                    -- 01:2
				{ctype='bit[10]',           label='Added Effect Message'},  
			}}},
			{ctype='boolbit',           label='Has Spike Effect', response = { on=boolean_true, on_arguments={}, fields = {
				{ctype='bit[6]',            label='Spike Effect Animation'},                -- 00:0
				{ctype='bit[4]',            label='Spike Effect Effect'},                   -- 00:6
				{ctype='bit[14]',           label='Spike Effect Param'},                    -- 01:2
				{ctype='bit[10]',           label='Spike Effect Message'},   	
			}}},
		}},
	}},
}

-- Action Message
fields.incoming[0x029] = {
    {ctype='unsigned int',      label='Actor'},             					-- 04
    {ctype='unsigned int',      label='Target'},             					-- 08
    {ctype='unsigned int',      label='Param 1'},                               -- 0C
    {ctype='unsigned int',      label='Param 2'},                               -- 10
    {ctype='unsigned short',    label='Actor Index'},          					-- 14
    {ctype='unsigned short',    label='Target Index'},          				-- 16
    {ctype='unsigned short',    label='Message'},                               -- 18
    {ctype='unsigned short',    label='_unknown1'},                             -- 1A
}
--[[ 0x2A can be triggered by knealing in the right areas while in the possession of a VWNM KI:
    Field1 will be lights level:
    0 = 'Tier 1', -- faintly/feebly depending on whether it's outside of inside Abyssea
    1 = 'Tier 2', -- softly
    2 = 'Tier 3', -- solidly. Highest Tier in Abyssea
    3 = 'Tier 4', --- strongly
    4 = 'Tier 5', -- very strongly.  Unused currently
    5 = 'Tier 6', --- furiously.  Unused currently
    - But if there are no mobs left in area, or no mobs nearby, field1 will be the KeyItem#
    1253 = 'Clear Abyssite'
    1254 = 'Colorful Abyssite'
    1564 = 'Clear Demilune Abyssite'
    etc.

    Field2 will be direction:
    0 = 'East'
    1 = 'Southeast'
    2 = 'South'
    3 = 'Southwest'
    4 = 'West'
    5 = 'Northwest'
    6 = 'North'
    7 = 'Northeast'

    Field3 will be distance. When there are no mobs, this value is set to 300000

    Field4 will be KI# of the abyssite used. Ex:
    1253 = 'Clear Abyssite'
    1254 = 'Colorful Abyssite'
    1564 = 'Clear Demilune Abyssite'
    etc.
]]

--[[  0x2A can also be triggered by buying/disposing of a VWNM KI from an NPC:
      Index/ID field will be those of the NPC
      Field1 will be 1000 (gil) when acquiring in Jueno, 300 (cruor) when acquiring in Abyssea
      Field2 will be the KI# acquired
      Fields are used slighly different when dropping the KI using the NPC.
]]

--[[  0x2A can also be triggered by spending cruor by buying non-vwnm related items, or even activating/using Flux
      Field1 will be the amount of cruor spent
]]
      
     
--[[ 0x2A can also be triggered by zoning into Abyssea:
     Field1 will be set to your remaining time. 5 at first, then whatever new value when acquiring visiting status.
     0x2A will likely be triggered as well when extending your time limit. Needs verification.
]]


--[[ 0x2A can be triggered sometimes when zoning into non-Abyssea:
     Not sure what it means.
]]

-- Resting Message
fields.incoming[0x02A] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned int',      label='Param 1'},                               -- 08
    {ctype='unsigned int',      label='Param 2'},                               -- 0C
    {ctype='unsigned int',      label='Param 3'},                               -- 10
    {ctype='unsigned int',      label='Param 4'},                               -- 14
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 18
    {ctype='unsigned short',    label='Message ID'},                            -- 1A   The high bit is occasionally set, though the reason for it is unclear.
    {ctype='unsigned int',      label='_unknown1'},                             -- 1C   Possibly flags, 0x06000000 and 0x02000000 observed
}

-- Kill Message
-- Updates EXP gained, RoE messages, Limit Points, and Capacity Points
fields.incoming[0x02D] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned int',      label='Target',             fn=id},             -- 08   Player ID in the case of RoE log updates
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 0C
    {ctype='unsigned short',    label='Target Index',       fn=index},          -- 0E   Player Index in the case of RoE log updates
    {ctype='unsigned int',      label='Param 1'},                               -- 10   EXP gained, etc. Numerator for RoE objectives
    {ctype='unsigned int',      label='Param 2'},                               -- 14   Denominator for RoE objectives
    {ctype='unsigned short',    label='Message'},                               -- 18
    {ctype='unsigned short',    label='_flags1'},                               -- 1A   This could also be a third parameter, but I suspect it is flags because I have only ever seen one bit set.
}

-- Mog House Menu
fields.incoming[0x02E] = {}                                                    -- Seems to contain no fields. Just needs to be sent to client to open.

-- Digging Animation
fields.incoming[0x02F] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 08
    {ctype='unsigned char',     label='Animation'},                             -- 0A   Changing it to anything other than 1 eliminates the animation
    {ctype='unsigned char',     label='_junk1'},                                -- 0B   Likely junk. Has no effect on anything notable.
}

-- Synth Animation
fields.incoming[0x030] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 08
    {ctype='unsigned short',    label='Effect'},                                -- 0A  -- 10 00 is water, 11 00 is wind, 12 00 is fire, 13 00 is earth, 14 00 is lightning, 15 00 is ice, 16 00 is light, 17 00 is dark
    {ctype='unsigned char',     label='Param'},                                 -- 0C  -- 00 is NQ, 01 is break, 02 is HQ
    {ctype='unsigned char',     label='Animation'},                             -- 0D  -- Always C2 for me.
    {ctype='unsigned char',     label='_unknown1',          const=0x00},        -- 0E  -- Appears to just be trash.
}

-- NPC Interaction Type 1
fields.incoming[0x032] = {
    {ctype='unsigned int',      label='NPC',                fn=id},             -- 04
    {ctype='unsigned short',    label='NPC Index',          fn=index},          -- 08
    {ctype='unsigned short',    label='Zone',               fn=zone},           -- 0A
    {ctype='unsigned short',    label='Menu ID'},                               -- 0C   Seems to select between menus within a zone
    {ctype='unsigned short',    label='_unknown1'},                             -- 0E   00 for me
    {ctype='unsigned char',     label='_dupeZone',          fn=zone},           -- 10
    {ctype='data[3]',           label='_junk1'},                                -- 11   Always 00s for me
}

-- String NPC Interaction
fields.incoming[0x033] = {
    {ctype='unsigned int',      label='NPC',                fn=id},             -- 04
    {ctype='unsigned short',    label='NPC Index',          fn=index},          -- 08
    {ctype='unsigned short',    label='Zone',               fn=zone},           -- 0A
    {ctype='unsigned short',    label='Menu ID'},                               -- 0C   Seems to select between menus within a zone
    {ctype='unsigned short',    label='_unknown1'},                             -- 0E   00 00 or 08 00 for me
    {ctype='char[16]',          label='NPC Name'},                              -- 10
    {ctype='char[16]',          label='_dupeNPC Name1'},                        -- 20
    {ctype='char[16]',          label='_dupeNPC Name2'},                        -- 30
    {ctype='char[16]',          label='_dupeNPC Name3'},                        -- 40
    {ctype='char[32]',          label='Menu Parameters'},                       -- 50   The way this information is interpreted varies by menu.
}

-- NPC Interaction Type 2
--triggered when talking to npc next to proto waypoint
fields.incoming[0x034] = {
    {ctype='unsigned int',      label='NPC',                fn=id},             -- 04
    {ctype='data[32]',          label='Menu Parameters'},                       -- 08   
    {ctype='unsigned short',    label='NPC Index',          fn=index},          -- 28
    {ctype='unsigned short',    label='Zone',               fn=zone},           -- 2A
    {ctype='unsigned short',    label='Menu ID'},                               -- 2C   Seems to select between menus within a zone
    {ctype='unsigned short',    label='_unknown1'},                             -- 2E   Ususually 8, but often not for newer menus
    {ctype='unsigned short',    label='_dupeZone',          fn=zone},           -- 30
    {ctype='data[2]',           label='_junk1'},                                -- 31   Always 00s for me
}

--- When messages are fishing related, the player is the Actor.
--- For some areas, the most significant bit of the message ID is set sometimes.
-- NPC Chat
fields.incoming[0x036] = {
    {ctype='unsigned int',      label='Actor',                fn=id},             -- 04
    {ctype='unsigned short',    label='Actor Index',          fn=index},          -- 08
    {ctype='bit[15]',           label='Message ID'},                              -- 0A
    {ctype='bit',               label='_unknown1'},                               -- 0B
    {ctype='unsigned int',      label='_unknown2'},                               -- 0C  Probably junk
}

-- Player update
-- Buff IDs go can over 0xFF, but in the packet each buff only takes up one byte.
-- To address that there's a 8 byte bitmask starting at 0x4C where each 2 bits
-- represent how much to add to the value in the respective byte.

--[[ _flags1: The structure here looks similar to byte 0x33 of 0x00D, but left shifted by 1 bit
    -- 0x0001 -- Despawns your character
    -- 0x0002 -- Also despawns your character, and may trigger an outgoing packet to the server (which triggers an incoming 0x037 packet)
    -- 0x0004 -- No obvious effect
    -- 0x0008 -- No obvious effect
    -- 0x0010 -- LFG flag
    -- 0x0020 -- /anon flag - blue name
    -- 0x0040 -- orange name?
    -- 0x0080 -- Away flag
    -- 0x0100 -- No obvious effect
    -- 0x0200 -- No obvious effect
    -- 0x0400 -- No obvious effect
    -- 0x0800 -- No obvious effect
    -- 0x1000 -- No obvious effect
    -- 0x2000 -- No obvious effect
    -- 0x4000 -- No obvious effect
    -- 0x8000 -- No obvious effect
    
    _flags2:
    -- 0x01 -- POL Icon :: Actually a flag, overrides everything else but does not affect name color
    -- 0x02 -- No obvious effect
    -- 0x04 -- Disconnection icon :: Actually a flag, overrides everything but POL Icon
    -- 0x08 -- No linkshell
    -- 0x0A -- No obvious effect
    
    -- 0x10 -- No linkshell
    -- 0x20 -- Trial account icon
    -- 0x40 -- Trial account icon
    -- 0x60 -- POL Icon (lets you walk through NPCs/PCs)
    -- 0x80 -- GM mode
    -- 0xA0 -- GM mode
    -- 0xC0 -- GM mode
    -- 0xE0 -- SGM mode
    -- No statuses differentiate based on 0x10
    -- Bit 0x20 + 0x40 makes 0x60, which is different.
    -- Bit 0x80 overpowers those bits
    -- Bit 0x80 combines with 0x04 and 0x02 to make SGM.
    -- These are basically flags, but they can be combined to mean different things sometimes.
    
    _flags3:
    -- 0x10 -- No obvious effect
    -- 0x20 -- Event mode? Can't activate the targeting cursor but can still spin the camera
    -- 0x40 -- No obvious effect
    -- 0x80 -- Invisible model
    
    _flags4:
    -- 0x02 -- No obvious effect
    -- 0x04 -- No obvious effect
    -- 0x08 -- No obvious effect
    -- 0x10 -- No obvious effect
    -- 0x20 -- Bazaar icon
    -- 0x40 -- Event status again? Can't activate the targeting cursor but can move the camera.
    -- 0x80 -- No obvious effects
    
    _flags5:
    -- 0x01 -- No obvious effect
    -- 0x02 -- No obvious effect
    -- 0x04 -- Autoinvite icon
    
    _flags6:
    -- 0x08 -- Terror flag
    -- 0x10 -- No obvious effect
    
    Ballista stuff:
    -- 0x0020 -- No obvious effect
    -- 0x0040 -- San d'Oria ballista flag
    -- 0x0060 -- Bastok ballista flag
    -- 0x0080 -- Windurst Ballista flag
    -- 0x0100 -- Participation icon?
    -- 0x0200 -- Has some effect
    -- 0x0400 -- I don't know anything about ballista
    -- 0x0800 -- and I still don't D:<
    -- 0x1000 -- and I still don't D:<
    
    _flags7:
    -- 0x0020 -- No obvious effect
    -- 0x0040 -- Individually, this bit has no effect. When combined with 0x20, it prevents you from returning to a walking animation after you stop (sliding along the ground while bound)
    -- 0x0080 -- No obvious effect
    -- 0x0100 -- No obvious effect
    -- 0x0200 -- Trial Account emblem
    -- 0x0400 -- No obvious effect
    -- 0x0800 -- Question mark icon
    -- 0x1000 -- Mentor icon
]]
fields.incoming[0x037] = {
    {ctype='unsigned char', label='Buff',  array_size = 32},         				-- 04
    {ctype='unsigned int',      label='Player'},             						-- 24
    {ctype='unsigned short',    label='_flags1'},                               	-- 28   Called "Flags" on the old dev wiki. Second byte might not be part of the flags, actually.
    {ctype='unsigned char',     label='HP %'},        								-- 2A   
    {ctype='bit[8]',            label='_flags2'},                               	-- 2B   
    {ctype='bit[12]',           label='Movement Speed/2'},                      	-- 2C   Player movement speed
    {ctype='bit[4]',            label='_flags3'},                               	-- 2D
    {ctype='bit[9]',            label='Yalms per step'},                        	-- 2E   Determines how quickly your animation walks
    {ctype='bit[7]',            label='_flags4'},                               	-- 2F
    {ctype='unsigned char',     label='Status'},       								-- 30
    {ctype='unsigned char',     label='LS Color Red'},                          	-- 31
    {ctype='unsigned char',     label='LS Color Green'},                        	-- 32
    {ctype='unsigned char',     label='LS Color Blue'},                         	-- 33
    {ctype='bit[3]',            label='_flags5'},                               	-- 34
    {ctype='bit[16]',           label='Pet Index'},                             	-- 34   From 0x08 of byte 0x34 to 0x04 of byte 0x36
    {ctype='bit[2]',            label='_flags6'},                               	-- 36    
    {ctype='bit[9]',            label='Ballista Stuff'},                        	-- 36   The first few bits seem to determine the icon, but the icon appears to be tied to the type of fight, so it's more than just an icon.
    {ctype='bit[8]',            label='_flags7'},                               	-- 37   This is probably tied up in the Ballista stuff too
    {ctype='bit[26]',           label='_unknown1'},                             	-- 38   No obvious effect from any of these
    {ctype='unsigned int',      label='Time offset?'},           					-- 3C   For me, this is the number of seconds in 66 hours
    {ctype='unsigned int',      label='Timestamp'},          				    	-- 40   This is 32 years off of JST at the time the packet is sent.
    {ctype='data[8]',           label='_unknown3'},                             	-- 44
    {ctype='bit[2]',   			label='Bit Mask',  array_size = 32}, 				-- 4C
    {ctype='data[4]',           label='_unknown4'},                             	-- 54 
    {ctype='bit[7]',            label='Indi Buff'},     							-- 58
    {ctype='bit[9]',            label='_unknown5'},                             	-- 58
    {ctype='unsigned short',    label='_junk1'},                                	-- 5A
    {ctype='unsigned int',      label='_flags8'},                               	-- 5C   Two least significant bits seem to indicate whether Wardrobes 3 and 4, respectively, are enabled
	
}

-- Entity Animation
-- Most frequently used for spawning ("deru") and despawning ("kesu")
-- Another example: "sp00" for Selh'teus making his spear of light appear
fields.incoming[0x038] = {
    {ctype='unsigned int',      label='Mob',                fn=id},             -- 04
    {ctype='unsigned int',      label='_dupeMob',           fn=id},             -- 08
    {ctype='char[4]',           label='Type',              },      -- 0C   Four character animation name
    {ctype='unsigned short',    label='Mob Index',          fn=index},          -- 10
    {ctype='unsigned short',    label='_dupeMob Index',     fn=index},          -- 12
}

-- Blacklist
fields.incoming[0x041] = {
	{ctype='fori', label='Entry' ,	i=1,till=12,fields = {						-- 08
		{ctype='unsigned int',      label='ID'},                                    -- 00
		{ctype='char[16]',          label='Name'},                                  -- 04
	}},
    {ctype='unsigned char',     label='_unknown3',          const=3},           -- F4   Always 3
    {ctype='unsigned char',     label='Size'},                                  -- F5   Blacklist entries
}

-- Pet Stat
-- This packet varies and is indexed by job ID (byte 4)
-- Packet 0x044 is sent twice in sequence when stats could change. This can be caused by anything from
-- using a Maneuver on PUP to changing job. The two packets are the same length. The first
-- contains information about your main job. The second contains information about your
-- subjob and has the Subjob flag flipped.
fields.incoming[0x044] = {
    {ctype='unsigned char',     label='Job',                fn=job},            -- 04
    {ctype='bool',              label='Subjob'},                                -- 05
    {ctype='unsigned short',    label='_unknown1'},                             -- 06
	{ctype='case', check = 'Job', on = {
		[0x12] = {
			{ctype='unsigned char',     label='Automaton Head'},                        -- 08   Harlequinn 1, Valoredge 2, Sharpshot 3, Stormwaker 4, Soulsoother 5, Spiritreaver 6
			{ctype='unsigned char',     label='Automaton Frame'},                       -- 09   Harlequinn 20, Valoredge 21, Sharpshot 22, Stormwaker 23
			{ctype='unsigned char',     label='Slot 1'},                                -- 0A   Attachment assignments are based off their position in the equipment list.
			{ctype='unsigned char',     label='Slot 2'},                                -- 0B   Strobe is 01, etc.
			{ctype='unsigned char',     label='Slot 3'},                                -- 0C
			{ctype='unsigned char',     label='Slot 4'},                                -- 0D
			{ctype='unsigned char',     label='Slot 5'},                                -- 0E
			{ctype='unsigned char',     label='Slot 6'},                                -- 0F
			{ctype='unsigned char',     label='Slot 7'},                                -- 10
			{ctype='unsigned char',     label='Slot 8'},                                -- 11
			{ctype='unsigned char',     label='Slot 9'},                                -- 12
			{ctype='unsigned char',     label='Slot 10'},                               -- 13
			{ctype='unsigned char',     label='Slot 11'},                               -- 14
			{ctype='unsigned char',     label='Slot 12'},                               -- 15
			{ctype='unsigned short',    label='_unknown2'},                             -- 16
			{ctype='unsigned int',      label='Available Heads'},                       -- 18   Flags for the available heads (Position corresponds to Item ID shifted down by 8192)
			{ctype='unsigned int',      label='Available Bodies'},                      -- 1C   Flags for the available bodies (Position corresponds to Item ID)
			{ctype='unsigned int',      label='_unknown3'},                             -- 20
			{ctype='unsigned int',      label='_unknown4'},                             -- 24
			{ctype='unsigned int',      label='_unknown5'},                             -- 28
			{ctype='unsigned int',      label='_unknown6'},                             -- 2C
			{ctype='unsigned int',      label='_unknown7'},                             -- 30
			{ctype='unsigned int',      label='_unknown8'},                             -- 34
			{ctype='unsigned int',      label='Fire Attachments'},                      -- 38   Flags for the available Fire Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Ice Attachments'},                       -- 3C   Flags for the available Ice Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Wind Attachments'},                      -- 40   Flags for the available Wind Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Earth Attachments'},                     -- 44   Flags for the available Earth Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Thunder Attachments'},                   -- 48   Flags for the available Thunder Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Water Attachments'},                     -- 4C   Flags for the available Water Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Light Attachments'},                     -- 50   Flags for the available Light Attachments (Position corresponds to Item ID)
			{ctype='unsigned int',      label='Dark Attachments'},                      -- 54   Flags for the available Dark Attachments (Position corresponds to Item ID)
			{ctype='char[16]',          label='Pet Name'},                              -- 58
			{ctype='unsigned short',    label='Current HP'},                            -- 68
			{ctype='unsigned short',    label='Max HP'},                                -- 6A
			{ctype='unsigned short',    label='Current MP'},                            -- 6C
			{ctype='unsigned short',    label='Max MP'},                                -- 6E
			{ctype='unsigned short',    label='Current Melee Skill'},                   -- 70
			{ctype='unsigned short',    label='Max Melee Skill'},                       -- 72
			{ctype='unsigned short',    label='Current Ranged Skill'},                  -- 74
			{ctype='unsigned short',    label='Max Ranged Skill'},                      -- 76
			{ctype='unsigned short',    label='Current Magic Skill'},                   -- 78
			{ctype='unsigned short',    label='Max Magic Skill'},                       -- 7A
			{ctype='unsigned int',      label='_unknown9'},                             -- 7C
			{ctype='unsigned short',    label='Base STR'},                              -- 80
			{ctype='unsigned short',    label='Additional STR'},                        -- 82
			{ctype='unsigned short',    label='Base DEX'},                              -- 84
			{ctype='unsigned short',    label='Additional DEX'},                        -- 86
			{ctype='unsigned short',    label='Base VIT'},                              -- 88
			{ctype='unsigned short',    label='Additional VIT'},                        -- 8A
			{ctype='unsigned short',    label='Base AGI'},                              -- 8C
			{ctype='unsigned short',    label='Additional AGI'},                        -- 8E
			{ctype='unsigned short',    label='Base INT'},                              -- 90
			{ctype='unsigned short',    label='Additional INT'},                        -- 92
			{ctype='unsigned short',    label='Base MND'},                              -- 94
			{ctype='unsigned short',    label='Additional MND'},                        -- 96
			{ctype='unsigned short',    label='Base CHR'},                              -- 98
			{ctype='unsigned short',    label='Additional CHR'},                        -- 9A
		},
		
		-- ['default'] = {
			-- {ctype='bit',     label='unknown',array_size=64},
		-- },
	}},
}


-- Delivery Item
fields.incoming[0x04B] = {
    {ctype='unsigned char',     label='Type'}, 									-- 04
    {ctype='unsigned char',     label='_unknown1'},                             -- 05   FF if Type is 05, otherwise 01
    {ctype='signed char',       label='Delivery Slot'},                         -- 06   This goes left to right and then drops down a row and left to right again. Value is 00 through 07
                                                                                --    01 if Type is 06, otherwise FF
                                                                                --    06 Type always seems to come in a pair, this field is only 01 for the first packet
    {ctype='signed char',       label='_unknown2'},                             -- 07   Always FF FF FF FF?  
    {ctype='signed int',        label='_unknown3'},          					-- 0C   When in a 0x0D/0x0E type, 01 grants request to open inbox/outbox. With FA you get "Please try again later"
    {ctype='signed char',       label='_unknown4'},                             -- 0D   02 and 03 observed
    {ctype='signed char',       label='Packet Number'},                         -- 0E   FF FF observed
    {ctype='signed char',       label='_unknown5'},                             -- 0F   FF FF observed
    {ctype='signed char',       label='_unknown6'},                             -- 10   06 00 00 00 and 07 00 00 00 observed - (06 was for the first packet and 07 was for the second)
    {ctype='unsigned int',      label='_unknown7'},                             -- 10   00 00 00 00 also observed
	{ctype='if', check='Type', is={'0x01', '0x04', '0x06', '0x08', '0x0A'}, result=true, fields = {
		{ctype='char[16]',          label='Player Name'},                           -- 14 This is used for sender (in inbox) and recipient (in outbox)
		{ctype='unsigned int',      label='_unknown8'},                             -- 24   46 32 00 00 and 42 32 00 00 observed - Possibly flags. Rare vs. Rare/Ex.?
		{ctype='unsigned int',      label='Timestamp'},          					-- 28
		{ctype='unsigned int',      label='_unknown9'},                             -- 2C   00 00 00 00 observed
		{ctype='unsigned short',    label='Item'},           						-- 30
		{ctype='unsigned short',    label='_unknown10'},                            -- 32   Fiendish Tome: Chapter 11 had it, but Oneiros Pebble was just 00 00
																					-- 32   May well be junked, 38 38 observed
		{ctype='unsigned int',      label='Flags?'},                                -- 34   01/04 00 00 00 observed
		{ctype='unsigned short',    label='Count'},                                 -- 38
		{ctype='unsigned short',    label='_unknown11'},                            -- 3A
		{ctype='data[28]',          label='_unknown12'},                            -- 3C   All 00 observed, ext data? Doesn't seem to be the case, but same size
	}},
}

--Auction House Menu
-- I think this is more a success/fail type of message system for different things ingame
fields.incoming[0x04C] = {
	{ctype='unsigned char',     label='Type'}, 											-- 04
	{ctype='case', check = 'Type', on = {
		[0x02] = {
			{ctype='unsigned char',     label='_unknown1'},        						-- 05 const=0xFF
			{ctype='unsigned char',     label='Success'},           					-- 06
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='char*',             label='_junk'},                                 -- 08
		},
		-- Sent when initating logout
		[0x03] = {
			{ctype='unsigned char',     label='_unknown1'},        						-- 05 const=0xFF
			{ctype='unsigned char',     label='Success'},           					-- 06
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='char*',             label='_junk'},                                 -- 08
		},
		[0x04] = {
			{ctype='unsigned char',     label='_unknown1'},        						-- 05 const=0xFF
			{ctype='unsigned char',     label='Success'},           					-- 06
			{ctype='unsigned char',     label='_unknown2'},                             -- 07
			{ctype='unsigned int',      label='Fee'},            						-- 08
			{ctype='unsigned short',    label='Inventory Index'},        				-- 0C
			{ctype='unsigned short',    label='Item'},           						-- 0E
			{ctype='unsigned char',     label='Stack'},        							-- 10
			{ctype='char*',             label='_junk'},                                 -- 11
		},
		[0x05] = {
			{ctype='unsigned char',     label='_unknown1'},        						-- 05 const=0xFF
			{ctype='unsigned char',     label='Success'},           					-- 06
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='char*',             label='_junk'},                                 -- 08
		},
		-- 0x0A, 0x0B and 0x0D could probably be combined, the fields seem the same.
		-- However, they're populated a bit differently. Both 0x0B and 0x0D are sent twice
		-- on action completion, the second seems to contain updated information.
		[0x0A] = {
			{ctype='unsigned char',     label='Slot'},                                  -- 05
			{ctype='unsigned char',     label='_unknown1'},        						-- 06 const=0x01
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='data[12]',          label='_junk1'},                                -- 08
			{ctype='unsigned char',     label='Sale status'},							-- 14
			{ctype='unsigned char',     label='_unknown3'},                             -- 15
			{ctype='unsigned char',     label='Inventory Index'},                       -- 16   From when the item was put on auction
			{ctype='unsigned char',     label='_unknown4'},        						-- 17   Possibly padding. const=0x00
			{ctype='char[16]',          label='Name'},                                  -- 18   Seems to always be the player's name
			{ctype='unsigned short',    label='Item'},           						-- 28
			{ctype='unsigned char',     label='Count'},                                 -- 2A
			{ctype='unsigned char',     label='AH Category'},                           -- 2B
			{ctype='unsigned int',      label='Price'},            						-- 2C
			{ctype='unsigned int',      label='_unknown6'},                             -- 30
			{ctype='unsigned int',      label='_unknown7'},                             -- 34
			{ctype='unsigned int',      label='Timestamp'},          					-- 38
		},
		[0x0B] = {
			{ctype='unsigned char',     label='Slot'},                                  -- 05
			{ctype='unsigned char',     label='_unknown1'},                             -- 06   This packet, like 0x0D, is sent twice, the first one always has 0x02 here, the second one 0x01
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='data[12]',          label='_junk1'},                                -- 08
			{ctype='unsigned char',     label='Sale status'},							-- 14
			{ctype='unsigned char',     label='_unknown3'},                             -- 15
			{ctype='unsigned char',     label='Inventory Index'},                       -- 16   From when the item was put on auction
			{ctype='unsigned char',     label='_unknown4'},        						-- 17   Possibly padding const=0x00
			{ctype='char[16]',          label='Name'},                                  -- 18   Seems to always be the player's name
			{ctype='unsigned short',    label='Item'},           						-- 28
			{ctype='unsigned char',     label='Count'},                                 -- 2A
			{ctype='unsigned char',     label='AH Category'},                           -- 2B
			{ctype='unsigned int',      label='Price'},            						-- 2C
			{ctype='unsigned int',      label='_unknown6'},                             -- 30   Only populated in the second packet
			{ctype='unsigned int',      label='_unknown7'},                             -- 34   Only populated in the second packet
			{ctype='unsigned int',      label='Timestamp'},          					-- 38
		},
		[0x0D] = {
			{ctype='unsigned char',     label='Slot'},                                  -- 05
			{ctype='unsigned char',     label='_unknown1'},                             -- 06   Some sort of type... the packet seems to always be sent twice, once with this value as 0x02, followed by 0x01
			{ctype='unsigned char',     label='_unknown2'},                             -- 07   If 0x06 is 0x01 this seems to be 0x01 as well, otherwise 0x00
			{ctype='data[12]',          label='_junk1'},                                -- 08
			{ctype='unsigned char',     label='Sale status'},							-- 14
			{ctype='unsigned char',     label='_unknown3'},                             -- 15
			{ctype='unsigned char',     label='Inventory Index'},                       -- 16   From when the item was put on auction
			{ctype='unsigned char',     label='_unknown4'},        						-- 17   Possibly padding const=0x00
			{ctype='char[16]',          label='Name'},                                  -- 18   Seems to always be the player's name
			{ctype='unsigned short',    label='Item'},           						-- 28
			{ctype='unsigned char',     label='Count'},                                 -- 2A
			{ctype='unsigned char',     label='AH Category'},                           -- 2B
			{ctype='unsigned int',      label='Price'},            						-- 2C
			{ctype='unsigned int',      label='_unknown6'},                             -- 30
			{ctype='unsigned int',      label='_unknown7'},                             -- 34
			{ctype='unsigned int',      label='Timestamp'},          					-- 38
		},
		[0x0E] = {
			{ctype='unsigned char',     label='_unknown1'},                             -- 05
			{ctype='unsigned char',     label='Buy Status'},    						-- 06
			{ctype='unsigned char',     label='_unknown2'},                             -- 07   
			{ctype='unsigned int',      label='Price'},               					-- 08   
			{ctype='unsigned short',    label='Item ID'},              					-- 0C
			{ctype='unsigned short',    label='_unknown3'},                             -- 0E
			{ctype='unsigned short',    label='Count'},                                 -- 10
			{ctype='unsigned int',      label='_unknown4'},                             -- 12
			{ctype='unsigned short',    label='_unknown5'},                             -- 16
			{ctype='char[16]',          label='Name'},                                  -- 18   Character name (pending buy only)
			{ctype='unsigned short',    label='Pending Item ID'},              			-- 28   Only filled out during pending packets
			{ctype='unsigned short',    label='Pending Count'},                         -- 2A   Only filled out during pending packets
			{ctype='unsigned int',      label='Pending Price'},               			-- 2C   Only filled out during pending packets
			{ctype='unsigned int',      label='_unknown6'},                             -- 30
			{ctype='unsigned int',      label='_unknown7'},                             -- 34
			{ctype='unsigned int',      label='Timestamp'},          					-- 38   Only filled out during pending packets
		},
		[0x10] = {
			{ctype='unsigned char',     label='_unknown1'},        						-- 05 const=0x00
			{ctype='unsigned char',     label='Success'},           					-- 06
			{ctype='unsigned char',     label='_unknown2'},        						-- 07 const=0x00
			{ctype='char*',             label='_junk'},                                 -- 08
		}
	}},
}

-- Data Download 2
fields.incoming[0x04F] = {
--   This packet's contents are nonessential. They are often leftovers from other outgoing
--   packets. It is common to see things like inventory size, equipment information, and
--   character ID in this packet. They do not appear to be meaningful and the client functions
--   normally even if they are blocked.
--   Tends to bookend model change packets (0x51), though blocking it, zeroing it, etc. affects nothing.
    {ctype='unsigned int',      label='_unknown1'},                             -- 04
}

-- Equip
fields.incoming[0x050] = {
    {ctype='unsigned char',     label='Inventory Index'},    -- 04
    {ctype='unsigned char',     label='Equipment Slot'},           -- 05
    {ctype='unsigned char',     label='Inventory Bag'},            -- 06
    {ctype='data[1]',           label='_junk1'}                                 -- 07
}

-- Model Change
fields.incoming[0x051] = {
    {ctype='unsigned char',     label='Face'},                                  -- 04
    {ctype='unsigned char',     label='Race'},                                  -- 05
    {ctype='unsigned short',    label='Head'},                                  -- 06
    {ctype='unsigned short',    label='Body'},                                  -- 08
    {ctype='unsigned short',    label='Hands'},                                 -- 0A
    {ctype='unsigned short',    label='Legs'},                                  -- 0C
    {ctype='unsigned short',    label='Feet'},                                  -- 0E
    {ctype='unsigned short',    label='Main'},                                  -- 10
    {ctype='unsigned short',    label='Sub'},                                   -- 12
    {ctype='unsigned short',    label='Ranged'},                                -- 14
    {ctype='unsigned short',    label='_unknown1'},                             -- 16   May varying meaningfully, but it's unclear
}

-- NPC Release
-- fields.incoming[0x052] = {
    -- {ctype='bool',     		label='Was locked'}, 
    -- {ctype='data[3]',     label='_unknown1'},  
-- }

fields.incoming[0x052] = {
    {ctype='unsigned char',     label='Type' },      -- 04
	{ctype='case', check = 'Type', at=0x04*8 , on = {
		[0x02] = {
			{ctype='unsigned short',    label='Menu ID'},                               -- 05
		},
	}},
}

-- Key Item Log
fields.incoming[0x055] = {
    -- There are 6 of these packets sent on zone, which likely corresponds to the 6 categories of key items.
    -- FFing these packets between bytes 0x14 and 0x82 gives you access to all (or almost all) key items.
    {ctype='data[0x40]',        label='Key item available' },     -- 04
    {ctype='data[0x40]',        label='Key item examined'  },     -- 44   Bit field correlating to the previous, 1 if KI has been examined, 0 otherwise
    {ctype='unsigned int',      label='Type'},                                  -- 84   Goes from 0 to 5, determines which KI are being sent
}

-- There are 27 variations of this packet to populate different quest information.
-- Current quests, completed quests, and completed missions (where applicable) are represented by bit flags where the position
-- corresponds to the quest index in the respective DAT.
-- "Current Mission" fields refer to the mission ID, except COP, SOA, and ROV, which represent a mapping of some sort(?)
-- Additionally, COP, SOA, and ROV do not have a "completed" missions packet, they are instead updated with the current mission.
-- Quests will remain in your 'current' list after they are completed unless they are repeatable.
fields.incoming[0x056] = {
	--{ctype='bit',         label='_pre', array_size=24					},     -- 20
	{ctype='short',         label='Type', at=0x24*8 					},     -- 24
	{ctype='case', check = 'Type', at=0x04*8 , on = {
		[0x0080] = {
			{ctype='data[16]',      label='Current TOAU Quests'},                       -- 04
			{ctype='int',           label='Current Assault Mission'},                   -- 14
			{ctype='int',           label='Current TOAU Mission'},                      -- 18
			{ctype='int',           label='Current WOTG Mission'},                      -- 1C
			{ctype='int',           label='Current Campaign Mission'},                  -- 20
		},
		[0x00C0] = {
			{ctype='data[16]',      label='Completed TOAU Quests'},                     -- 04
			{ctype='data[16]',      label='Completed Assaults'},                        -- 14
		},
		[0x00D0] = {
			{ctype='data[8]',       label='Completed San d\'Oria Missions'},            -- 04
			{ctype='data[8]',       label='Completed Bastok Missions'},                 -- 0C
			{ctype='data[8]',       label='Completed Windurst Missions'},               -- 14
			{ctype='data[8]',       label='Completed Zilart Missions'},                 -- 1C
		},
		[0x00D8] = {
			{ctype='data[8]',       label='Completed TOAU Missions'},                   -- 04
			{ctype='data[8]',       label='Completed WOTG Missions'},                   -- 0C
			{ctype='data[16]',      label='_junk'},                                     -- 14
		},
		[0xFFFF] = {
			{ctype='int',           label='Nation'},                                    -- 04
			{ctype='int',           label='Current Nation Mission'},                    -- 08
			{ctype='int',           label='Current ROZ Mission'},                       -- 0C
			{ctype='int',           label='Current COP Mission'},                       -- 10 Doesn't correspond directly to DAT
			{ctype='int',           label='_unknown1'},                                 -- 14
			{ctype='bit[4]',        label='Current ACP Mission'},                       -- 18 lower 4
			{ctype='bit[4]',        label='Current MKD Mission'},                       -- 18 upper 4
			{ctype='bit[4]',        label='Current ASA Mission'},                       -- 19 lower 4
			{ctype='bit[4]',        label='_junk1'},                                    -- 19 upper 4
			{ctype='short',         label='_junk2'},                                    -- 1A
			{ctype='int',           label='Current SOA Mission'},                       -- 1C Doesn't correspond directly to DAT
			{ctype='int',           label='Current ROV Mission'},                       -- 20 Doesn't correspond directly to DAT
		},
		['default']={
			{ctype='data[32]', label='Quest Flags'},
		}
	}},
}

-- Weather Change
fields.incoming[0x057] = {
    {ctype='unsigned int',      label='Vanadiel Time'},          -- 04   Units of minutes.
    {ctype='unsigned char',     label='Weather',     },        -- 08
    {ctype='unsigned char',     label='_unknown1'},                             -- 09
    {ctype='unsigned short',    label='_unknown2'},                             -- 0A
}

-- Assist Response
fields.incoming[0x058] = {
    {ctype='unsigned int',      label='Player',             fn=id},             -- 04
    {ctype='unsigned int',      label='Target',             fn=id},             -- 08
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 0C
}

-- Emote
fields.incoming[0x05A] = {
    {ctype='unsigned int',      label='Player ID',          fn=id},             -- 04 
    {ctype='unsigned int',      label='Target ID',          fn=id},             -- 08
    {ctype='unsigned short',    label='Player Index',       fn=index},          -- 0C
    {ctype='unsigned short',    label='Target Index',       fn=index},          -- 0E
    {ctype='unsigned short',    label='Emote',              fn=emote},          -- 10
    {ctype='unsigned short',    label='_unknown1'},                             -- 12
    {ctype='unsigned short',    label='_unknown2'},                             -- 14
    {ctype='unsigned char',     label='Type'},                                  -- 16   2 for motion, 0 otherwise
    {ctype='unsigned char',     label='_unknown3'},                             -- 17
    {ctype='data[32]',          label='_unknown4'},                             -- 18
}

-- Spawn
fields.incoming[0x05B] = {
    {ctype='float',             label='X'},                                     -- 04
    {ctype='float',             label='Z'},                                     -- 08
    {ctype='float',             label='Y'},                                     -- 0C
    {ctype='unsigned int',      label='ID',                 fn=id},             -- 10
    {ctype='unsigned short',    label='Index',              fn=index},          -- 14
    {ctype='unsigned char',     label='Type' },									-- 16   3 for regular Monsters, 0 for Treasure Caskets and NPCs
    {ctype='unsigned char',     label='_unknown1'},                             -- 17   Always 0 if Type is 3, otherwise a seemingly random non-zero number
    {ctype='unsigned int',      label='_unknown2'},                             -- 18
}

-- Dialogue Information
fields.incoming[0x05C] = {
    {ctype='data[32]',          label='Menu Parameters'},                       -- 04   How information is packed in this region depends on the particular dialogue exchange.
}

-- Campaign/Besieged Map information

-- Bitpacked Campaign Info:
-- First Byte: Influence ranking including Beastmen
-- Second Byte: Influence ranking excluding Beastmen

-- Third Byte (bitpacked xxww bbss -- First two bits are for beastmen)
    -- 0 = Minimal
    -- 1 = Minor
    -- 2 = Major
    -- 3 = Dominant

-- Fourth Byte: Ownership (value)
    -- 0 = Neutral
    -- 1 = Sandy
    -- 2 = Bastok
    -- 3 = Windurst
    -- 4 = Beastmen
    -- 0xFF = Jeuno




-- Bitpacked Besieged Info:

-- Candescence Owners:
    -- 0 = Whitegate
    -- 1 = MMJ
    -- 2 = Halvung
    -- 3 = Arrapago

-- Orders:
    -- 0 = Defend Al Zahbi
    -- 1 = Intercept Enemy
    -- 2 = Invade Enemy Base
    -- 3 = Recover the Orb

-- Beastman Status
    -- 0 = Training
    -- 1 = Advancing
    -- 2 = Attacking
    -- 3 = Retreating
    -- 4 = Defending
    -- 5 = Preparing

-- Bitpacked region int (for the actual locations on the map, not the overview)
    -- 3 Least Significant Bits -- Beastman Status for that region
    -- 8 following bits -- Number of Forces
    -- 4 following bits -- Level
    -- 4 following bits -- Number of Archaic Mirrors
    -- 4 following bits -- Number of Prisoners
    -- 9 following bits -- No clear purpose

fields.incoming[0x05E] = {
    {ctype='unsigned char',     label='Balance of Power'},                      -- 04   Bitpacked: xxww bbss  -- Unclear what the first two bits are for. Number stored is ranking (0-3)
    {ctype='unsigned char',     label='Alliance Indicator'},                    -- 05   Indicates whether two nations are allied (always the bottom two).
    {ctype='data[20]',          label='_unknown1'},                             -- 06   All Zeros, and changed nothing when 0xFF'd.
    {ctype='unsigned int',      label='Bitpacked Ronfaure Info'},               -- 1A
    {ctype='unsigned int',      label='Bitpacked Zulkheim Info'},               -- 1E
    {ctype='unsigned int',      label='Bitpacked Norvallen Info'},              -- 22
    {ctype='unsigned int',      label='Bitpacked Gustaberg Info'},              -- 26
    {ctype='unsigned int',      label='Bitpacked Derfland Info'},               -- 2A
    {ctype='unsigned int',      label='Bitpacked Sarutabaruta Info'},           -- 2E
    {ctype='unsigned int',      label='Bitpacked Kolshushu Info'},              -- 32
    {ctype='unsigned int',      label='Bitpacked Aragoneu Info'},               -- 36
    {ctype='unsigned int',      label='Bitpacked Fauregandi Info'},             -- 3A
    {ctype='unsigned int',      label='Bitpacked Valdeaunia Info'},             -- 3E
    {ctype='unsigned int',      label='Bitpacked Qufim Info'},                  -- 42
    {ctype='unsigned int',      label="Bitpacked Li'Telor Info"},               -- 46
    {ctype='unsigned int',      label='Bitpacked Kuzotz Info'},                 -- 4A
    {ctype='unsigned int',      label='Bitpacked Vollbow Info'},                -- 4E
    {ctype='unsigned int',      label='Bitpacked Elshimo Lowlands Info'},       -- 52
    {ctype='unsigned int',      label="Bitpacked Elshimo Uplands Info"},        -- 56
    {ctype='unsigned int',      label="Bitpacked Tu'Lia Info"},                 -- 5A
    {ctype='unsigned int',      label='Bitpacked Movapolos Info'},              -- 5E
    {ctype='unsigned int',      label='Bitpacked Tavnazian Archipelago Info'},  -- 62
    {ctype='data[32]',          label='_unknown2'},                             -- 66   All Zeros, and changed nothing when 0xFF'd.
    {ctype='unsigned char',     label="San d'Oria region bar"},                 -- 86   These indicate how full the current region's bar is (in percent).
    {ctype='unsigned char',     label="Bastok region bar"},                     -- 87
    {ctype='unsigned char',     label="Windurst region bar"},                   -- 88
    {ctype='unsigned char',     label="San d'Oria region bar without beastmen"},-- 86   Unsure of the purpose of the without beastman indicators
    {ctype='unsigned char',     label="Bastok region bar without beastmen"},    -- 87
    {ctype='unsigned char',     label="Windurst region bar without beastmen"},  -- 88
    {ctype='unsigned char',     label="Days to tally"},                         -- 8C   Number of days to the next conquest tally
    {ctype='data[3]',           label="_unknown4"},                             -- 8D   All Zeros, and changed nothing when 0xFF'd.
    {ctype='int',               label='Conquest Points'},                       -- 90
    {ctype='unsigned char',     label="Beastmen region bar"},                   -- 94   
    {ctype='data[12]',          label="_unknown5"},                             -- 95   Mostly zeros and noticed no change when 0xFF'd.

-- These bytes are for the overview summary on the map.
    -- The two least significant bits code for the owner of the Astral Candescence.
    -- The next two bits indicate the current orders.
    -- The four most significant bits indicate the MMJ level.
    {ctype='unsigned char',     label="MMJ Level, Orders, and AC"},             -- A0

    -- Halvung is the 4 least significant bits.
    -- Arrapago is the 4 most significant bits.
    {ctype='unsigned char',     label="Halvung and Arrapago Level"},            -- A1
    {ctype='unsigned char',     label="Beastman Status (1) "},                  -- A2   The 3 LS bits are the MMJ Orders, next 3 bits are the Halvung Orders, top 2 bits are part of the Arrapago Orders
    {ctype='unsigned char',     label="Beastman Status (2) "},                  -- A3   The Least Significant bit is the top bit of the Arrapago orders. Rest of the byte doesn't seem to do anything?

-- These bytes are for the individual stronghold displays. See above!
    {ctype='unsigned int',      label='Bitpacked MMJ Info'},                    -- A4
    {ctype='unsigned int',      label='Bitpacked Halvung Info'},                -- A8
    {ctype='unsigned int',      label='Bitpacked Arrapago Info'},               -- AC

    {ctype='int',               label='Imperial Standing'},                     -- B0
}

-- Music Change
fields.incoming[0x05F] = {
    {ctype='unsigned short',    label='BGM Type'},                              -- 04   01 = idle music, 06 = mog house music. 00, 02, and 03 are fight musics and some other stuff.
    {ctype='unsigned short',    label='Song ID'},                               -- 06   See the setBGM addon for more information
}

-- Char Stats
fields.incoming[0x061] = {
    {ctype='unsigned int',      label='Maximum HP'},                            -- 04
    {ctype='unsigned int',      label='Maximum MP'},                            -- 08
    {ctype='unsigned char',     label='Main Job',           fn=job},            -- 0C
    {ctype='unsigned char',     label='Main Job Level'},                        -- 0D
    {ctype='unsigned char',     label='Sub Job',            fn=job},            -- 0E
    {ctype='unsigned char',     label='Sub Job Level'},                         -- 0F
    {ctype='unsigned short',    label='Current EXP'},                           -- 10
    {ctype='unsigned short',    label='Required EXP'},                          -- 12
    {ctype='unsigned short',    label='Base STR'},                              -- 14
    {ctype='unsigned short',    label='Base DEX'},                              -- 16
    {ctype='unsigned short',    label='Base VIT'},                              -- 18
    {ctype='unsigned short',    label='Base AGI'},                              -- 1A
    {ctype='unsigned short',    label='Base INT'},                              -- 1C
    {ctype='unsigned short',    label='Base MND'},                              -- 1E
    {ctype='unsigned short',    label='Base CHR'},                              -- 20
    {ctype='signed short',      label='Added STR'},                             -- 22
    {ctype='signed short',      label='Added DEX'},                             -- 24
    {ctype='signed short',      label='Added VIT'},                             -- 26
    {ctype='signed short',      label='Added AGI'},                             -- 28
    {ctype='signed short',      label='Added INT'},                             -- 2A
    {ctype='signed short',      label='Added MND'},                             -- 2C
    {ctype='signed short',      label='Added CHR'},                             -- 2E
    {ctype='unsigned short',    label='Attack'},                                -- 30
    {ctype='unsigned short',    label='Defense'},                               -- 32
    {ctype='signed short',      label='Fire Resistance'},                       -- 34
    {ctype='signed short',      label='Wind Resistance'},                       -- 36
    {ctype='signed short',      label='Lightning Resistance'},                  -- 38
    {ctype='signed short',      label='Light Resistance'},                      -- 3A
    {ctype='signed short',      label='Ice Resistance'},                        -- 3C
    {ctype='signed short',      label='Earth Resistance'},                      -- 3E
    {ctype='signed short',      label='Water Resistance'},                      -- 40
    {ctype='signed short',      label='Dark Resistance'},                       -- 42
    {ctype='unsigned short',    label='Title',           fn=title},             -- 44
    {ctype='unsigned short',    label='Nation rank'},                           -- 46
    {ctype='unsigned short',    label='Rank points',        },    -- 48
    {ctype='unsigned short',    label='Home point',         fn=zone},           -- 4A
    {ctype='unsigned short',    label='_unknown1'},                             -- 4C   0xFF-ing this last region has no notable effect.
    {ctype='unsigned short',    label='_unknown2'},                             -- 4E
    {ctype='unsigned char',     label='Nation'},                                -- 50   0 = sandy, 1 = bastok, 2 = windy
    {ctype='unsigned char',     label='_unknown3'},                             -- 51   Possibly Unity ID (always 7 for me, I'm in Aldo's unity)
    {ctype='unsigned char',     label='Su Level'},                              -- 52   
    {ctype='unsigned char',     label='_unknown4'},                             -- 53   Always 00 for me
    {ctype='unsigned char',     label='Maximum iLevel'},                        -- 54   
    {ctype='unsigned char',     label='iLevel over 99'},                        -- 55   0x10 would be an iLevel of 115
    {ctype='unsigned char',     label='Main Hand iLevel'},                      -- 56   
    {ctype='unsigned char',     label='_unknown5'},                             -- 57   Always 00 for me
    {ctype='bit[5]',            label='Unity ID'},                              -- 58   0=None, 1=Pieuje, 2=Ayame, 3=Invincible Shield, 4=Apururu, 5=Maat, 6=Aldo, 7=Jakoh Wahcondalo, 8=Naja Salaheem, 9=Flavira
    {ctype='bit[5]',            label='Unity Rank'},                            -- 58   Danger, 00ing caused my client to crash
    {ctype='bit[16]',           label='Unity Points'},                          -- 59   
    {ctype='bit[6]',            label='_unknown6'},                             -- 5A   No obvious function
    {ctype='unsigned int',      label='_junk1'},                                -- 5B   
}

-- Skills Update
fields.incoming[0x062] = {
    {ctype='char[124]',         label='_junk1'},
	{ctype='fori', label='Combat Skill' ,	i=1,till=0x30,fields = {			-- 80
		{ctype='bit[15]',           label='Level'},                             -- 00
		{ctype='boolbit',           label='Capped'},                            -- 01
	}},
	{ctype='fori', label='Craft Skill' ,	i=1,till=0x0A,fields = {			-- E0
		{ctype='bit[5]',            label='Rank',               },          	-- 00
		{ctype='bit[10]',           label='Level'},                        		-- 00
		{ctype='boolbit',           label='Capped'},                     		-- 01
	}},
    {ctype='unsigned short[6]', label='_junk2'},                                -- F4
}

-- Set Update
-- This packet likely varies based on jobs, but currently I only have it worked out for Monstrosity.
-- It also appears in three chunks, so it's double-varying.
-- Packet was expanded in the March 2014 update and now includes a fourth packet, which contains CP values.
fields.incoming[0x063] = {
	{ctype='unsigned short',    label='Order'},                                 		-- 04
	{ctype='case', check = 'Order', on = {
		[0x02] = {
			{ctype='data[7]',           label='_flags1'},        -- 06   The 3rd bit of the last byte is the flag that indicates whether or not you are xp capped (blue levels)
		},
		[0x03] = {
			{ctype='unsigned short',    label='_flags1'},                               -- 06   Consistently D8 for me
			{ctype='unsigned short',    label='_flags2'},                               -- 08   Vary when I change species
			{ctype='unsigned short',    label='_flags3'},                               -- 0A   Consistent across species
			{ctype='unsigned char',     label='Mon. Rank'},                             -- 0C   00 = Mon, 01 = NM, 02 = HNM
			{ctype='unsigned char',     label='_unknown1'},                             -- 0D   00
			{ctype='unsigned short',    label='_unknown2'},                             -- 0E   00 00
			{ctype='unsigned short',    label='_unknown3'},                             -- 10   76 00
			{ctype='unsigned short',    label='Infamy'},                                -- 12
			{ctype='unsigned int',      label='_unknown4'},                             -- 14   00s
			{ctype='unsigned int',      label='_unknown5'},                             -- 18   00s
			{ctype='data[64]',          label='Instinct Bitfield 1'},                   -- 1C   See below
			-- Bitpacked 2-bit values. 0 = no instincts from that species, 1 == first instinct, 2 == first and second instinct, 3 == first, second, and third instinct.
			{ctype='data[128]',         label='Monster Level Char field'},              -- 5C   Mapped onto the item ID for these creatures. (00 doesn't exist, 01 is rabbit, 02 is behemoth, etc.)
		},
		[0x04] = {
			{ctype='unsigned short',    label='_unknown1'},                             -- 06   B0 00
			{ctype='data[126]',         label='_unknown2'},                             -- 08   FF-ing has no effect.
			{ctype='unsigned char',     label='Slime Level'},                           -- 86
			{ctype='unsigned char',     label='Spriggan Level'},                        -- 87
			{ctype='data[12]',          label='Instinct Bitfield 3'},                   -- 88   Contains job/race instincts from the 0x03 set. Has 8 unused bytes. This is a 1:1 mapping.
			{ctype='data[32]',          label='Variants Bitfield'},                     -- 94   Does not show normal monsters, only variants. Bit is 1 if the variant is owned. Length is an estimation including the possible padding.
		},
		[0x05] = {
			{ctype='unsigned short',    label='_unknown1',          const=0x0098},      -- 06
			{ctype='unsigned short',    label='_unknown2'},                             -- 08   Lowest bit of this might indicate JP availability
			{ctype='unsigned short',    label='_unknown3'},                             -- 0A
			{ctype='fori', label='Job' ,	i=1,till=24,fields = {
				{ctype='unsigned short',    label='Capacity Points'},                       -- 00
				{ctype='unsigned short',    label='Job Points'},                            -- 02
				{ctype='unsigned short',    label='Spent Job Points'},                      -- 04
			}},
		},
		--0x06 is unknown. happens when job change at nomad moogle
		--not job or job ability or trait related
		-- not mission related
		[0x06] = { 
			-- {ctype='unsigned short',    label='_test1',          const=0x0098},      -- 06
			-- {ctype='unsigned short',    label='_test2'},                             -- 08   Lowest bit of this might indicate JP availability
			-- {ctype='unsigned short',    label='_test3'},                             -- 0A
			-- {ctype='unsigned char', label='Bit',  array_size = 32},         				-- 04
		},
		--0x07 is unknown. happens when job change at nomad moogle
		-- is called 64 times
		[0x07] = { 
			-- {ctype='unsigned short',    label='_unknown const1',          const=0x0088},      -- 06
			-- {ctype='boolbit',    label='_unknown bool1'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit1'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit2'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit3'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit4'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit5'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit6'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit7'},  --first 32 false then 32x true
			-- {ctype='bit',    label='_unknown bit8'},  --first 32 false then 32x true
			-- {ctype='boolbit',    label='_unknown bool2'},   --packet 1 false > packet 2 true >> repeat
			-- {ctype='unsigned char',    label='_unknown char2'},  
			-- {ctype='fori', label='Unknown block ' ,	i=1,till=8,fields = {
				-- {ctype='unsigned char',    label='_unknown'},  
			-- }},
			-- {ctype='fori', label='Unknown block B' ,	i=1,till=32,fields = {
				-- {ctype='unsigned char',    label='_unknown'},  
			-- }},
			
			--{ctype='unsigned char',    label='_unknown',  array_size = 16},                             -- 08   
			--{ctype='unsigned short',    label='_unknown3'},                             -- 0A
			--{ctype='bit[1]', label='Bit',  array_size = 32},         				-- 04
		},
		[0x09] = {
			{ctype='unsigned short',    label='_unknown1'},      						-- 06 const=0x00C4. category for packet
			{ctype='unsigned short',label='Buffs',  array_size = 32},           						-- 08
			{ctype='unsigned int',  label='Time',  array_size = 32},       							-- 48
		},
		--0x0A is unknown. happens when job change at nomad moogle
		[0x0A] = { -- happens when job change at nomad moogle
			-- {ctype='unsigned short',    label='_unknown1',          const=0x0098},      -- 06
			-- {ctype='unsigned short',    label='_unknown2'},                             -- 08   
			-- {ctype='unsigned short',    label='_unknown3'},                             -- 0A
			-- {ctype='bit[1]', label='Bit',  array_size = 32},         				-- 04
		},
	}}
}

-- Repositioning
--on entering and exiting a bcnm
fields.incoming[0x065] = {
-- This is identical to the spawn packet, but has 4 more unused bytes.
    {ctype='float',             label='X'},                                     -- 04
    {ctype='float',             label='Z'},                                     -- 08
    {ctype='float',             label='Y'},                                     -- 0C
    {ctype='unsigned int',      label='ID',                 fn=id},             -- 10
    {ctype='unsigned short',    label='Index',              fn=index},          -- 14
    {ctype='unsigned char',     label='Animation'},                             -- 16
    {ctype='unsigned char',     label='Rotation'},                              -- 17
    {ctype='data[6]',           label='_unknown3'},                             -- 18   All zeros observed.
}

-- Pet Info
fields.incoming[0x067] = {
-- The length of this packet is 24, 28, 36 or 40 bytes, featuring a 0, 4, 8, 12, or 16 byte name field.

-- The Mask is a bitpacked combination of a number indicating the type of information in the packet and
--    a field indicating the length of the packet.

-- The lower 6 bits of the Mask is the type of packet:
-- 2 occurs often even with no pet, contains player index, id and main job level
-- 3 identifies (potential) pets and who owns them
-- 4 gives status information about your pet

-- The upper 10 bits of the Mask is the length in bytes of the data excluding the header and any padding
--    after the pet name.

    {ctype='bit[6]',            label='Message Type'},                          -- 04
    {ctype='bit[10]',           label='Message Length'},                        -- 05
    {ctype='unsigned short',    label='Pet Index'},          					-- 06
    {ctype='unsigned int',      label='Pet ID'},             					-- 08
    {ctype='unsigned short',    label='Owner Index'},          					-- 0C
    {ctype='unsigned char',     label='Current HP%'},        					-- 0E
    {ctype='unsigned char',     label='Current MP%'},        					-- 0F
    {ctype='unsigned int',      label='Pet TP'},                                -- 10
    {ctype='unsigned int',      label='_unknown1'},                             -- 14
    {ctype='char*',             label='Pet Name'},                              -- 18
}

-- Pet Status
-- It is sent every time a pet performs an action, every time anything about its vitals changes (HP, MP, TP) and every time its target changes
fields.incoming[0x068] = {
    {ctype='bit[6]',            label='Message Type',       const=0x04},        -- 04   Seems to always be 4
    {ctype='bit[10]',           label='Message Length'},                        -- 05   Number of bytes from the start of the packet (including header) until the last non-null character in the name
    {ctype='unsigned short',    label='Owner Index',        fn=index},          -- 06
    {ctype='unsigned int',      label='Owner ID',           fn=id},             -- 08
    {ctype='unsigned short',    label='Pet Index',          fn=index},          -- 0C
    {ctype='unsigned char',     label='Current HP%',        fn=percent},        -- 0E
    {ctype='unsigned char',     label='Current MP%',        fn=percent},        -- 0F
    {ctype='unsigned int',      label='Pet TP'},                                -- 10
    {ctype='unsigned int',      label='Target ID',          fn=id},             -- 14
    {ctype='char*',             label='Pet Name'},                              -- 18
}

-- Self Synth Result
fields.incoming[0x06F] = {
    {ctype='unsigned char',     label='Result'},    -- 04
    {ctype='signed char',       label='Quality'},                               -- 05
    {ctype='unsigned char',     label='Count'},                                 -- 06   Even set for fail (set as the NQ amount in that case)
    {ctype='unsigned char',     label='_junk1'},                                -- 07
    {ctype='unsigned short',    label='Item',               fn=item},           -- 08
    {ctype='unsigned short[8]', label='Lost Item',          fn=item},           -- 0A
    {ctype='unsigned char[4]',  label='Skill',              fn=skill},          -- 1A
    {ctype='unsigned char[4]',  label='Skillup'},       -- 1E
    {ctype='unsigned short',    label='Crystal',            fn=item},           -- 22
}

-- Others Synth Result
fields.incoming[0x070] = {
    {ctype='unsigned char',     label='Result'},    -- 04
    {ctype='signed char',       label='Quality'},                               -- 05
    {ctype='unsigned char',     label='Count'},                                 -- 06
    {ctype='unsigned char',     label='_junk1'},                                -- 07
    {ctype='unsigned short',    label='Item',               fn=item},           -- 08
    {ctype='unsigned short[8]', label='Lost Item',          fn=item},           -- 0A
    {ctype='unsigned char[4]',  label='Skill',              fn=skill},          -- 1A   Unsure about this
    {ctype='char*',             label='Player Name'},                           -- 1E   Name of the player
}

-- Campaign Map Info. NYI
fields.incoming[0x071] = {
}

-- Unity Start
-- Any bcnm or event with timer start
fields.incoming[0x075] = {
    {ctype='unsigned int',      label='Fight Designation'},                     -- 04   Anything other than 0 makes a timer. 0 deletes the timer.
    {ctype='unsigned int',      label='Timestamp Offset',   fn=time},           -- 08   Number of seconds since 15:00:00 GMT 31/12/2002 (0x3C307D70)
    {ctype='unsigned int',      label='Fight Duration',     fn=time},           -- 0C
    {ctype='byte[12]',          label='_unknown1'},                             -- 10   This packet clearly needs position information, but it's unclear how these bytes carry it
    {ctype='unsigned int',      label='Battlefield Radius'},                    -- 1C   Yalms*1000, so a 50 yalm battlefield would have 50,000 for this field
    {ctype='unsigned int',      label='Render Radius'},                         -- 20   Yalms*1000, so a fence that renders when you're 25 yalms away would have 25,000 for this field
}

-- Party status icon update
-- Buff IDs go can over 0xFF, but in the packet each buff only takes up one byte.
-- To address that there's a 8 byte bitmask starting at 0x4C where each 2 bits
-- represent how much to add to the value in the respective byte.
fields.incoming[0x076] = {
    {ctype='fori', label='Member' ,	i=1,till=5,fields = {						-- 08
		{ctype='unsigned int',      label='ID',                 fn=id},             -- 00
		{ctype='unsigned short',    label='Index',              fn=index},          -- 04
		{ctype='unsigned short',    label='_unknown1'},                             -- 06
		{ctype='bit[2]',           label='Bit Mask',  array_size = 32},                              -- 08
		{ctype='unsigned char', label='Buff',  array_size = 32},                                 -- 10
	}},
}

-- Merits currently owned and costs. sent in multiple packets
fields.incoming[0x08C] = {
	{ctype='unsigned char', label='Count'},                                 -- 04   Number of merits entries in this packet (possibly a short, although it wouldn't make sense)
	{ctype='data[3]',       label='_unknown1'},                             -- 05   Always 00 0F 01?
	{ctype='fori', label='Merit' ,	i=1,till='Count',fields = {						-- 08
		{ctype='unsigned short',    label='ID'},                                 -- 00
		{ctype='unsigned char',     label='Next Cost'},                             -- 02
		{ctype='unsigned char',     label='Value'},                                 -- 03
	}},
	{ctype='unsigned int',  label='_unknown2',          const=0x00000000},  ---04
}

-- Job Points
-- These packets are currently not used by the client in any detectable way.
-- The below pattern repeats itself for the entirety of the packet. There are 2 jobs per packet,
-- and 11 of these packets are sent at the moment in response to the first 0x0C0 outgoing packet since zoning.
-- This is how it works as of 3-19-14, and it is safe to assume that it will change in the future.
fields.incoming[0x08D] = {
    {ctype='fori', label='Job' ,	i=1,till=2,fields = {						-- 08
		{ctype='unsigned short',    label='Job Point ID'},                          -- 00   32 potential values for every job, which means you could decompose this into a value bitpacked with job ID if you wanted
		{ctype='bit[10]',           label='_unknown1'},                             -- 02   Always 1 in cases where the ID is set at the moment. Zeroing this has no effect.
		{ctype='bit[6]',            label='Current Level'},                         -- 03   Current enhancement for this job point ID
	}}
}

--0x0AA, 0x0AC, and 0x0AE are all bitfields where the lsb indicates whether you have index 0 of the related resource. NYI
fields.incoming[0x0AA] = { --size=1056
}

--0x0AA, 0x0AC, 0x0AD, and 0x0AE are all bitfields where the lsb indicates whether you have index 0 of the related resource.NYI
fields.incoming[0x0AB] = { --size=192
}

-- PC Update
fields.incoming[0x0AC] = {
    {ctype='bit[1]', label='Bit',  array_size = 32},         				-- 04
}

--0x0AA, 0x0AC, 0x0AD and 0x0AE are all bitfields where the lsb indicates whether you have index 0 of the related resource.NYI
fields.incoming[0x0AD] = { --size=1056
}

--0x0AA, 0x0AC, 0x0AD, and 0x0AE are all bitfields where the lsb indicates whether you have index 0 of the related resource.NYI
fields.incoming[0x0AE] = { --size=96
}

-- seek/anon filters
-- _Check fields arent known fields yet 
fields.incoming[0x0B4] = {
    {ctype='boolbit',            label='Is Seeking'},                          -- 04
    {ctype='boolbit',            label='Is Away'},                              -- 04:01
    {ctype='bit',            label='_Check04_2_',array_size=6},                    -- 04:02    
    {ctype='bit',            label='_Check05_1_',array_size=3},                    -- 05        
    {ctype='bit[2]',            label='System Level Filter'},                    -- 05:04        
    {ctype='bit',            label='_Check05_6_',array_size=2},                    -- 05:06      
    {ctype='boolbit',            label='Has Autogroup'},                       -- 05:07
    {ctype='data',            label='_Check6_'},                    -- 06
    {ctype='bit',            label='_Check7_1_',array_size=5},                  -- 07  
    {ctype='boolbit',            label='Has Request'},                         -- 07:06
    {ctype='bit',            label='_Check7_7_',array_size=2},                  -- 07:07
    {ctype='boolbit',            label='Say'},                         -- 08:01
    {ctype='boolbit',            label='Shout'},                         -- 08:02
    {ctype='bit',            label='_Check8_3_',array_size=1},                  -- 08:03 
    {ctype='boolbit',            label='Emotes'},                         -- 08:04
    {ctype='boolbit',            label='Special actions started on/by you'},       -- 08:05
    {ctype='boolbit',            label='Special effects started on/by you'},       -- 08:06
    {ctype='boolbit',            label='Attacks by you'},       -- 08:07
    {ctype='boolbit',            label='Missed attacks by you'},       -- 08:08
    {ctype='boolbit',            label='Attacks you evade'},       					-- 09
    {ctype='boolbit',            label='Damage you take'},       				-- 09:01
    {ctype='boolbit',            label='Special effects started on/by NPC'},       -- 08:06
    {ctype='boolbit',            label='Attacks you NPC'},       				-- 09:08
    {ctype='boolbit',            label='Missed attacks by NPC'},       			-- 09:07
    {ctype='boolbit',            label='Special effects started on/by party'},       -- 09:05
    {ctype='boolbit',            label='Attacks by party'},       				-- 09:06
    {ctype='boolbit',            label='Missed attacks by party'},       			-- 09:07
    {ctype='boolbit',            label='Attacks you party'},       				-- 09:08
    {ctype='boolbit',            label='Damage taken by party'},       				-- 0A
    {ctype='boolbit',            label='Special effects started on/by allies'},       -- 08:06
    {ctype='boolbit',            label='Attacks by allies'},       				-- 09:06
    {ctype='boolbit',            label='Missed attacks by allies'},       			-- 09:07
    {ctype='boolbit',            label='Attacks you allies'},       				-- 09:08
    {ctype='boolbit',            label='Damage taken by allies'},       				-- 0A
    {ctype='boolbit',            label='Special actions started on/by party'},  		--0A:07
    {ctype='boolbit',            label='Special actions started on/by allies'},       -- 0B:01
    {ctype='boolbit',            label='Special actions started on/by NPC'},       -- 08:06
    {ctype='boolbit',            label='Other\'s synthesis and fishing results'},       -- 08:06
    {ctype='boolbit',            label='Lot results'},       						-- 08:06
    {ctype='boolbit',            label='Attacks by others'},       				-- 09:06
    {ctype='boolbit',            label='Missed attacks by others'},       			-- 09:07
    {ctype='bit',            	 label='_Check_0B_6', array_size=2},                	-- 0B
    {ctype='boolbit',            label='Attacks you others'},       				-- 09:08
    {ctype='boolbit',            label='Damage taken by others'},       				-- 0A
    {ctype='boolbit',            label='Special effects started on/by others'},       -- 08:06
    {ctype='boolbit',            label='Special actions started on/by others'},  		--0A:07
    {ctype='boolbit',            label='Attacks by foes'},       				-- 09:06
    {ctype='boolbit',            label='Missed attacks by foes'},       			-- 09:07
    {ctype='boolbit',            label='Attacks you foes'},       				-- 09:08
    {ctype='boolbit',            label='Damage taken by foes'},       				-- 0A
    {ctype='boolbit',            label='Special effects started on/by foes'},       -- 08:06
    {ctype='boolbit',            label='Special actions started on/by foes'},  		--0A:07
    {ctype='boolbit',            label='Campaign-Related data'},       				-- 09:06
    {ctype='boolbit',            label='Tell messages deemed spam'},       				-- 09:06
    {ctype='boolbit',            label='Shout/Yell messages deemed spam'},       				-- 09:06
    {ctype='bit',            	 label='_Check_0D_4', array_size=2},                	-- 0D
    {ctype='boolbit',            label='Job-specific emote'},       				-- 09:06
    {ctype='bit',            	 label='_Check_0E', array_size=1},                	-- 0D
    {ctype='boolbit',            label='Messages from alter egos'},       				-- 09:06
    {ctype='bit',            	 label='_Check_0E_2', array_size=6},                	-- 0D
    {ctype='data[4]',            label='_Check_0Ftill12'},                  		   -- 0E
    {ctype='data',            	 label='_unknown 0 or FF'},                	-- Unknown what this flag is. flips between 0 and ff at unknown times
    {ctype='boolbit',            label='Language Japanese'},                    -- 19
    {ctype='boolbit',            label='Language English'},                   	-- 19
    {ctype='boolbit',            label='Language German'},                    	-- 19
    {ctype='boolbit',            label='Language French'},                    	-- 19
    {ctype='boolbit',            label='Language Other'},                    	-- 19
    {ctype='bit',            label='_Check14_6_',array_size=3},                    -- 19
    {ctype='data[3]',            label='_Check_18till20'},                  		   -- 08
}

-- Alliance status update
fields.incoming[0x0C8] = {
    {ctype='unsigned char',     label='_unknown1'},                             -- 04
    {ctype='data[3]',           label='_junk1'},                                -- 05                          -- 05   Always 00 0F 01?
	{ctype='fori', label='Member' ,	i=1,till=18,fields = {		
		{ctype='unsigned int',      label='ID',                 fn=id},             -- 00
		{ctype='unsigned short',    label='Index',              fn=index},          -- 04
		{ctype='unsigned short',    label='Flags',              },        -- 06
		{ctype='unsigned short',    label='Zone',               fn=zone},           -- 08
		{ctype='unsigned short',    label='_unknown2'},                             -- 0A    Always 0?
	}},
    {ctype='data[0x18]',        label='_unknown3',          const=''},          -- E0   Always 0?
}

-- Bazaar Message
fields.incoming[0x0CA] = {
    {ctype='char[124]',         label='Bazaar Message'},                        -- 04   Terminated with a vertical tab
    {ctype='char[16]',          label='Player Name'},                           -- 80
    {ctype='unsigned short',    label='Player Title ID'},                       -- 90   
    {ctype='unsigned short',    label='_unknown4'},                             -- 92   00 00 observed.
}


-- Found Item/treasure pool update
fields.incoming[0x0D2] = {
    {ctype='unsigned int',      label='_unknown1'},                             -- 04   Could be characters starting the line - FD 02 02 18 observed
                                                                                -- 04   Arcon: Only ever observed 0x00000001 for this
    {ctype='unsigned int',      label='Dropper',            fn=id},             -- 08
    {ctype='unsigned int',      label='Count'},                                 -- 0C   Takes values greater than 1 in the case of gil
    {ctype='unsigned short',    label='Item',               fn=item},           -- 10
    {ctype='unsigned short',    label='Dropper Index',      fn=index},          -- 12
    {ctype='unsigned char',     label='Index'},                                 -- 14   This is the internal index in memory, not the one it appears in in the menu
    {ctype='bool',              label='Old'},                                   -- 15   This is true if it's not a new drop, but appeared in the pool before you joined a party
    {ctype='unsigned char',     label='_unknown4',          const=0x00},        -- 16   Seems to always be 00
    {ctype='unsigned char',     label='_unknown5'},                             -- 17   Seemingly random, both 00 and FF observed, as well as many values in between
    {ctype='unsigned int',      label='Timestamp',          fn=utime},          -- 18
    {ctype='data[28]',          label='_unknown6'},                             -- AC   Always 0 it seems?
    {ctype='unsigned int',      label='_junk1'},                                -- 38
}

-- Party member update
fields.incoming[0x0DD] = {
    {ctype='unsigned int',      label='ID',                 fn=id},             -- 04
    {ctype='unsigned int',      label='HP'},                                    -- 08
    {ctype='unsigned int',      label='MP'},                                    -- 0C
    {ctype='unsigned int',      label='TP',                 fn=percent},        -- 10
    {ctype='unsigned short',    label='Flags',              },        -- 14
    {ctype='unsigned short',    label='_unknown1'},                             -- 16
    {ctype='unsigned short',    label='Index',              fn=index},          -- 18
    {ctype='unsigned short',    label='_unknown2'},                             -- 1A
    {ctype='unsigned char',     label='_unknown3'},                             -- 1C
    {ctype='unsigned char',     label='HP%',                fn=percent},        -- 1D
    {ctype='unsigned char',     label='MP%',                fn=percent},        -- 1E
    {ctype='unsigned char',     label='_unknown4'},                             -- 1F
    {ctype='unsigned short',    label='Zone',               fn=zone},           -- 20
    {ctype='unsigned char',     label='Main job',           fn=job},            -- 22
    {ctype='unsigned char',     label='Main job level'},                        -- 23
    {ctype='unsigned char',     label='Sub job',            fn=job},            -- 24
    {ctype='unsigned char',     label='Sub job level'},                         -- 25
	{ctype='bit[5]',      label='_shift'},    
    {ctype='char*',             label='Name'},                                  -- 26
}

-- Unnamed 0xDE packet
-- 8 bytes long, sent in response to opening/closing mog house. Occasionally sent when zoning.
-- Injecting it with different values has no obvious effect.
fields.incoming[0x0DE] = {
    {ctype='unsigned char',     label='type'},                                  -- 04  Was always 0x4 for opening/closing mog house
    {ctype='data[3]',           label='_junk1'},                                -- 05  Looked like junk
}

-- Char Update
fields.incoming[0x0DF] = {
    {ctype='unsigned int',      label='ID'},             						-- 04
    {ctype='unsigned int',      label='HP'},                                    -- 08
    {ctype='unsigned int',      label='MP'},                                    -- 0C
    {ctype='unsigned int',      label='TP'},        							-- 10
    {ctype='unsigned short',    label='Index'},          						-- 14
    {ctype='unsigned char',     label='HPP'},        							-- 16
    {ctype='unsigned char',     label='MPP'},        							-- 17
    {ctype='unsigned short',    label='_unknown1'},                             -- 18
    {ctype='unsigned short',    label='_unknown2'},                             -- 1A
    {ctype='unsigned int',      label='_unknown3'},                             -- 1C
    {ctype='unsigned char',     label='Main job'},            					-- 20
    {ctype='unsigned char',     label='Main job level'},                        -- 21
    {ctype='unsigned char',     label='Sub job'},            					-- 22
    {ctype='unsigned char',     label='Sub job level'},                         -- 23
}

-- Unknown packet 0x0E0: I still can't make heads or tails of the content. The packet is always 8 bytes long.
--Occasionally sent when zoning.
fields.incoming[0x0E0] = {
}

-- Char Info
fields.incoming[0x0E2] = {
    {ctype='unsigned int',      label='ID',                 fn=id},             -- 04
    {ctype='unsigned int',      label='HP'},                                    -- 08
    {ctype='unsigned int',      label='MP'},                                    -- 0A
    {ctype='unsigned int',      label='TP',                 fn=percent},        -- 10
    {ctype='unsigned int',      label='_unknown1'},                             -- 14   Looks like it could be flags for something.
    {ctype='unsigned short',    label='Index',              fn=index},          -- 18
    {ctype='unsigned char',     label='_unknown2'},                             -- 1A
    {ctype='unsigned char',     label='_unknown3'},                             -- 1B
    {ctype='unsigned char',     label='_unknown4'},                             -- 1C
    {ctype='unsigned char',     label='HPP',                fn=percent},        -- 1D
    {ctype='unsigned char',     label='MPP',                fn=percent},        -- 1E
    {ctype='unsigned char',     label='_unknown5'},                             -- 1F
    {ctype='unsigned char',     label='Zone'},                             		-- 20
    {ctype='unsigned char',     label='_unknown7'},                             -- 21   Could be an initialization for the name. 0x01 observed.
    {ctype='char*',             label='Name'},                                  -- 22   *   Maybe a base stat
}

-- Sparks update packet
fields.incoming[0x110] = {
    {ctype='unsigned int',      label='Sparks Total'},                          -- 04
    {ctype='unsigned char',     label='Unity (Shared) designator'},             -- 08   Unity (Shared) designator (0=A, 1=B, 2=C, etc.)
    {ctype='unsigned char',     label='Unity (Person) designator '},            -- 09   The game does not distinguish these
    {ctype='char[6]',           label='_unknown2'},                             -- 0A   Currently all 0xFF'd, never seen it change.
}

-- Eminence Update
fields.incoming[0x111] = {
	{ctype='fori', label='RoE' ,	i=1,till=30,fields = {						-- BC
		{ctype='bit[12]',           label='Quest ID'},                          -- 00
		{ctype='bit[20]',           label='Quest Progress'},                    -- 01
	}},                                    -- 04
    {ctype='data[132]',         label='_junk'},                                 -- 7C   All 0s observed. Likely reserved in case they decide to expand allowed objectives.
    {ctype='bit[12]',           label='Limited Time RoE Quest ID'},             -- 100
    {ctype='bit[20]',           label='Limited Time RoE Quest Progress'},       -- 101 upper 4
}


-- RoE Quest Log
fields.incoming[0x112] = {
    {ctype='data[128]',         label='RoE Quest Bitfield'},                    -- 04   See next line
    -- Bitpacked quest completion flags. The position of the bit is the quest ID.
    -- Data regarding available quests and repeatability is handled client side or
    -- somewhere else
    {ctype='unsigned int',      label='Order'},                                 -- 84   0,1,2,3
}

--Currency Info (Currencies I)
fields.incoming[0x113] = {
    {ctype='signed int',        label='Conquest Points (San d\'Oria)'},         -- 04
    {ctype='signed int',        label='Conquest Points (Bastok)'},              -- 08
    {ctype='signed int',        label='Conquest Points (Windurst)'},            -- 0C
    {ctype='unsigned short',    label='Beastman Seals'},                        -- 10
    {ctype='unsigned short',    label='Kindred Seals'},                         -- 12
    {ctype='unsigned short',    label='Kindred Crests'},                        -- 14
    {ctype='unsigned short',    label='High Kindred Crests'},                   -- 16
    {ctype='unsigned short',    label='Sacred Kindred Crests'},                 -- 18
    {ctype='unsigned short',    label='Ancient Beastcoins'},                    -- 1A
    {ctype='unsigned short',    label='Valor Points'},                          -- 1C
    {ctype='unsigned short',    label='Scylds'},                                -- 1E
    {ctype='signed int',        label='Guild Points (Fishing)'},                -- 20
    {ctype='signed int',        label='Guild Points (Woodworking)'},            -- 24
    {ctype='signed int',        label='Guild Points (Smithing)'},               -- 28
    {ctype='signed int',        label='Guild Points (Goldsmithing)'},           -- 2C
    {ctype='signed int',        label='Guild Points (Weaving)'},                -- 30
    {ctype='signed int',        label='Guild Points (Leathercraft)'},           -- 34
    {ctype='signed int',        label='Guild Points (Bonecraft)'},              -- 38
    {ctype='signed int',        label='Guild Points (Alchemy)'},                -- 3C
    {ctype='signed int',        label='Guild Points (Cooking)'},                -- 40
    {ctype='signed int',        label='Cinders'},                               -- 44
    {ctype='unsigned char',     label='Synergy Fewell (Fire)'},                 -- 48
    {ctype='unsigned char',     label='Synergy Fewell (Ice)'},                  -- 49
    {ctype='unsigned char',     label='Synergy Fewell (Wind)'},                 -- 4A
    {ctype='unsigned char',     label='Synergy Fewell (Earth)'},                -- 4B
    {ctype='unsigned char',     label='Synergy Fewell (Lightning)'},            -- 4C
    {ctype='unsigned char',     label='Synergy Fewell (Water)'},                -- 4D
    {ctype='unsigned char',     label='Synergy Fewell (Light)'},                -- 4E
    {ctype='unsigned char',     label='Synergy Fewell (Dark)'},                 -- 4F
    {ctype='signed int',        label='Ballista Points'},                       -- 50
    {ctype='signed int',        label='Fellow Points'},                         -- 54
    {ctype='unsigned short',    label='Chocobucks (San d\'Oria)'},              -- 58
    {ctype='unsigned short',    label='Chocobucks (Bastok)'},                   -- 5A
    {ctype='unsigned short',    label='Chocobucks (Windurst)'},                 -- 5C
    {ctype='unsigned short',    label='Daily Tally'},                           -- 5E
    {ctype='signed int',        label='Research Marks'},                        -- 60
    {ctype='unsigned char',     label='Wizened Tunnel Worms'},                  -- 64
    {ctype='unsigned char',     label='Wizened Morion Worms'},                  -- 65
    {ctype='unsigned char',     label='Wizened Phantom Worms'},                 -- 66
    {ctype='char',              label='_unknown1'},                             -- 67   Currently holds no value
    {ctype='signed int',        label='Moblin Marbles'},                        -- 68
    {ctype='unsigned short',    label='Infamy'},                                -- 6C
    {ctype='unsigned short',    label='Prestige'},                              -- 6E
    {ctype='signed int',        label='Legion Points'},                         -- 70
    {ctype='signed int',        label='Sparks of Eminence'},                    -- 74
    {ctype='signed int',        label='Shining Stars'},                         -- 78
    {ctype='signed int',        label='Imperial Standing'},                     -- 7C
    {ctype='signed int',        label='Assault Points (Leujaoam Sanctum)'},     -- 80
    {ctype='signed int',        label='Assault Points (M.J.T.G.)'},             -- 84
    {ctype='signed int',        label='Assault Points (Lebros Cavern)'},        -- 88
    {ctype='signed int',        label='Assault Points (Periqia)'},              -- 8C
    {ctype='signed int',        label='Assault Points (Ilrusi Atoll)'},         -- 90
    {ctype='signed int',        label='Nyzul Tokens'},                          -- 94
    {ctype='signed int',        label='Zeni'},                                  -- 98
    {ctype='signed int',        label='Jettons'},                               -- 9C
    {ctype='signed int',        label='Therion Ichor'},                         -- A0
    {ctype='signed int',        label='Allied Notes'},                          -- A4
    {ctype='unsigned short',    label='A.M.A.N. Vouchers Stored'},              -- A8
    {ctype='unsigned short',    label="Login Points"},                          -- AA
    {ctype='signed int',        label='Cruor'},                                 -- AC
    {ctype='signed int',        label='Resistance Credits'},                    -- B0
    {ctype='signed int',        label='Dominion Notes'},                        -- B4
    {ctype='unsigned char',     label='5th Echelon Battle Trophies'},           -- B8
    {ctype='unsigned char',     label='4th Echelon Battle Trophies'},           -- B9
    {ctype='unsigned char',     label='3rd Echelon Battle Trophies'},           -- BA
    {ctype='unsigned char',     label='2nd Echelon Battle Trophies'},           -- BB
    {ctype='unsigned char',     label='1st Echelon Battle Trophies'},           -- BC
    {ctype='unsigned char',     label='Cave Conservation Points'},              -- BD
    {ctype='unsigned char',     label='Imperial Army ID Tags'},                 -- BE
    {ctype='unsigned char',     label='Op Credits'},                            -- BF
    {ctype='signed int',        label='Traverser Stones'},                      -- C0
    {ctype='signed int',        label='Voidstones'},                            -- C4
    {ctype='signed int',        label='Kupofried\'s Corundums'},                -- C8
    {ctype='unsigned char',     label='Moblin Pheromone Sacks'},                -- CC
    {ctype='data[1]',           label='_unknown2'},                             -- CD
    {ctype='unsigned char',     label="Rems Tale Chapter 1"},                   -- CE
    {ctype='unsigned char',     label="Rems Tale Chapter 2"},                   -- CF
    {ctype='unsigned char',     label="Rems Tale Chapter 3"},                   -- D0
    {ctype='unsigned char',     label="Rems Tale Chapter 4"},                   -- D1
    {ctype='unsigned char',     label="Rems Tale Chapter 5"},                   -- D2
    {ctype='unsigned char',     label="Rems Tale Chapter 6"},                   -- D3
    {ctype='unsigned char',     label="Rems Tale Chapter 7"},                   -- D4
    {ctype='unsigned char',     label="Rems Tale Chapter 8"},                   -- D5
    {ctype='unsigned char',     label="Rems Tale Chapter 9"},                   -- D6
    {ctype='unsigned char',     label="Rems Tale Chapter 10"},                  -- D7
    {ctype='data[8]',           label="_unknown3"},                             -- D8
    {ctype='signed int',        label="Reclamation Marks"},                     -- E0
    {ctype='signed int',        label='Unity Accolades'},                       -- E4
    {ctype='unsigned short',    label="Fire Crystals"},                         -- E8
    {ctype='unsigned short',    label="Ice Crystals"},                          -- EA
    {ctype='unsigned short',    label="Wind Crystals"},                         -- EC
    {ctype='unsigned short',    label="Earth Crystals"},                        -- EE
    {ctype='unsigned short',    label="Lightning Crystals"},                    -- E0
    {ctype='unsigned short',    label="Water Crystals"},                        -- F2
    {ctype='unsigned short',    label="Light Crystals"},                        -- F4
    {ctype='unsigned short',    label="Dark Crystals"},                         -- F6
    {ctype='signed int',        label="Deeds"},                                 -- F8
}


-- PC Update NYI
fields.incoming[0x114] = {
   -- {ctype='bit[1]', label='Bit',  array_size = 32},         				-- 04
}

-- Currency Info (Currencies2)
fields.incoming[0x118] = {
    {ctype='signed int',        label='Bayld'},                                     -- 04
    {ctype='unsigned short',    label='Kinetic Units'},                             -- 08
    {ctype='unsigned char',     label='Coalition Imprimaturs'},                     -- 0A
    {ctype='unsigned char',     label='Mystical Canteens'},                         -- 0B
    {ctype='signed int',        label='Obsidian Fragments'},                        -- 0C
    {ctype='unsigned short',    label='Lebondopt Wings Stored'},                    -- 10
    {ctype='unsigned short',    label='Pulchridopt Wings Stored'},                  -- 12
    {ctype='signed int',        label='Mweya Plasm Corpuscles'},                    -- 14
    {ctype='unsigned char',     label='Ghastly Stones Stored'},                     -- 18
    {ctype='unsigned char',     label='Ghastly Stones +1 Stored'},                  -- 19
    {ctype='unsigned char',     label='Ghastly Stones +2 Stored'},                  -- 1A
    {ctype='unsigned char',     label='Verdigris Stones Stored'},                   -- 1B
    {ctype='unsigned char',     label='Verdigris Stones +1 Stored'},                -- 1C
    {ctype='unsigned char',     label='Verdigris Stones +2 Stored'},                -- 1D
    {ctype='unsigned char',     label='Wailing Stones Stored'},                     -- 1E
    {ctype='unsigned char',     label='Wailing Stones +1 Stored'},                  -- 1F
    {ctype='unsigned char',     label='Wailing Stones +2 Stored'},                  -- 20
    {ctype='unsigned char',     label='Snowslit Stones Stored'},                    -- 21
    {ctype='unsigned char',     label='Snowslit Stones +1 Stored'},                 -- 22
    {ctype='unsigned char',     label='Snowslit Stones +2 Stored'},                 -- 23
    {ctype='unsigned char',     label='Snowtip Stones Stored'},                     -- 24
    {ctype='unsigned char',     label='Snowtip Stones +1 Stored'},                  -- 25
    {ctype='unsigned char',     label='Snowtip Stones +2 Stored'},                  -- 26
    {ctype='unsigned char',     label='Snowdim Stones Stored'},                     -- 27
    {ctype='unsigned char',     label='Snowdim Stones +1 Stored'},                  -- 28
    {ctype='unsigned char',     label='Snowdim Stones +2 Stored'},                  -- 29
    {ctype='unsigned char',     label='Snoworb Stones Stored'},                     -- 2A
    {ctype='unsigned char',     label='Snoworb Stones +1 Stored'},                  -- 2B
    {ctype='unsigned char',     label='Snoworb Stones +2 Stored'},                  -- 2C
    {ctype='unsigned char',     label='Leafslit Stones Stored'},                    -- 2D
    {ctype='unsigned char',     label='Leafslit Stones +1 Stored'},                 -- 2E
    {ctype='unsigned char',     label='Leafslit Stones +2 Stored'},                 -- 2F
    {ctype='unsigned char',     label='Leaftip Stones Stored'},                     -- 30
    {ctype='unsigned char',     label='Leaftip Stones +1 Stored'},                  -- 31
    {ctype='unsigned char',     label='Leaftip Stones +2 Stored'},                  -- 32
    {ctype='unsigned char',     label='Leafdim Stones Stored'},                     -- 33
    {ctype='unsigned char',     label='Leafdim Stones +1 Stored'},                  -- 34
    {ctype='unsigned char',     label='Leafdim Stones +2 Stored'},                  -- 35
    {ctype='unsigned char',     label='Leaforb Stones Stored'},                     -- 36
    {ctype='unsigned char',     label='Leaforb Stones +1 Stored'},                  -- 37
    {ctype='unsigned char',     label='Leaforb Stones +2 Stored'},                  -- 38
    {ctype='unsigned char',     label='Duskslit Stones Stored'},                    -- 39
    {ctype='unsigned char',     label='Duskslit Stones +1 Stored'},                 -- 3A
    {ctype='unsigned char',     label='Duskslit Stones +2 Stored'},                 -- 3B
    {ctype='unsigned char',     label='Dusktip Stones Stored'},                     -- 3C
    {ctype='unsigned char',     label='Dusktip Stones +1 Stored'},                  -- 3D
    {ctype='unsigned char',     label='Dusktip Stones +2 Stored'},                  -- 3E
    {ctype='unsigned char',     label='Duskdim Stones Stored'},                     -- 3F
    {ctype='unsigned char',     label='Duskdim Stones +1 Stored'},                  -- 40
    {ctype='unsigned char',     label='Duskdim Stones +2 Stored'},                  -- 41
    {ctype='unsigned char',     label='Duskorb Stones Stored'},                     -- 42
    {ctype='unsigned char',     label='Duskorb Stones +1 Stored'},                  -- 43
    {ctype='unsigned char',     label='Duskorb Stones +2 Stored'},                  -- 44
    {ctype='unsigned char',     label='Pellucid Stones Stored'},                    -- 45
    {ctype='unsigned char',     label='Fern Stones Stored'},                        -- 46
    {ctype='unsigned char',     label='Taupe Stones Stored'},                       -- 47
    {ctype='unsigned short',    label='Mellidopt Wings Stored'},                    -- 48
    {ctype='unsigned short',    label='Escha Beads'},                               -- 4A
    {ctype='signed int',        label='Escha Silt'},                                -- 4C
    {ctype='signed int',        label='Potpourri'},                                 -- 50
    {ctype='signed int',        label='Hallmarks'},                                 -- 54
    {ctype='signed int',        label='Total Hallmarks'},                           -- 58
    {ctype='signed int',        label='Badges of Gallantry'},                       -- 5C
    {ctype='signed int',        label='Crafter Points'},                            -- 60
    {ctype='unsigned char',     label='Fire Crystals Set'},                         -- 64
    {ctype='unsigned char',     label='Ice Crystals Set'},                          -- 65
    {ctype='unsigned char',     label='Wind Crystals Set'},                         -- 66
    {ctype='unsigned char',     label='Earth Crystals Set'},                        -- 67
    {ctype='unsigned char',     label='Lightning Crystals Set'},                    -- 68
    {ctype='unsigned char',     label='Water Crystals Set'},                        -- 69
    {ctype='unsigned char',     label='Light Crystals Set'},                        -- 6A
    {ctype='unsigned char',     label='Dark Crystals Set'},                         -- 6B
    {ctype='unsigned char',     label='MC-S-SR01s Set'},                            -- 6C
    {ctype='unsigned char',     label='MC-S-SR02s Set'},                            -- 6D
    {ctype='unsigned char',     label='MC-S-SR03s Set'},                            -- 6E
    {ctype='unsigned char',     label='Liquefaction Spheres Set'},                  -- 6F
    {ctype='unsigned char',     label='Induration Spheres Set'},                    -- 70
    {ctype='unsigned char',     label='Detonation Spheres Set'},                    -- 71
    {ctype='unsigned char',     label='Scission Spheres Set'},                      -- 72
    {ctype='unsigned char',     label='Impaction Spheres Set'},                     -- 73
    {ctype='unsigned char',     label='Reverberation Spheres Set'},                 -- 74
    {ctype='unsigned char',     label='Transfixion Spheres Set'},                   -- 75
    {ctype='unsigned char',     label='Compression Spheres Set'},                   -- 76
    {ctype='unsigned char',     label='Fusion Spheres Set'},                        -- 77
    {ctype='unsigned char',     label='Distortion Spheres Set'},                    -- 78
    {ctype='unsigned char',     label='Fragmentation Spheres Set'},                 -- 79
    {ctype='unsigned char',     label='Gravitation Spheres Set'},                   -- 7A
    {ctype='unsigned char',     label='Light Spheres Set'},                         -- 7B
    {ctype='unsigned char',     label='Darkness Spheres Set'},                      -- 7C
    {ctype='data[0x03]',        label='_unknown1'},                                 -- 7D   Presumably Unused Padding
    {ctype='signed int',        label='Silver A.M.A.N. Vouchers Stored'},           -- 80
}

-- Ability timers
fields.incoming[0x119] = {
	{ctype='fori', label='Ability' ,	i=1,till=0x1F,fields = {				-- 04			
		{ctype='unsigned short',    label='Recast Duration',           }, 	-- 00
		{ctype='unsigned char',     label='_unknown1',          const=0x00},  	-- 02
		{ctype='unsigned char',     label='Recast ID',       				},   	-- 03
		{ctype='unsigned int',      label='_unknown2'}                         	-- 04
	}},                
}

-- Unknown. Not mentioned in windower fields.lua aswell
fields.incoming[0x11A] = {

}

return fields