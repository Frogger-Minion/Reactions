local tbl = 
{
	
	{
		data = 
		{
			actions = 
			{
			},
			conditions = 
			{
			},
			enabled = false,
			eventType = 13,
			name = "-- BLUE MAGE --",
			uuid = "6f49fbfe-36dd-ea44-96fc-1cd46bed48f1",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Blue Mage Mimicry Helper\n\nif not _G.BLMimicryHelper then\n    _G.BLMimicryHelper = {\n        windowOpen = true\n    }\nend\n\nlocal GUI_FLAGS =\n    GUI.WindowFlags_AlwaysAutoResize +\n    GUI.WindowFlags_NoCollapse\n\nlocal MIMICRY_SKILL_ID = 18322\n\nlocal ROLE_COLORS = {\n    tank = { 0.2, 0.4, 0.8, 1.0 },\n    healer = { 0.2, 0.7, 0.2, 1.0 },\n    dps = { 0.8, 0.2, 0.2, 1.0 }\n}\n\n-- =========================================================\n-- Helpers\n-- =========================================================\n\nlocal function GetRoleTarget(role)\n    local players = EntityList(\"maxdistance=25,alive,entitytype=1,chartype=4\")\n\n    if not players then\n        return nil\n    end\n\n    local myId = TensorCore.mGetPlayer().id\n\n    for _, entity in pairs(players) do\n        if entity and entity.id ~= myId then\n            local job = entity.job or 0\n\n            -- Tanks\n            if role == \"tank\" then\n                if job == 19 or job == 21 or job == 32 or job == 37 then\n                    return entity\n                end\n            end\n\n            -- Healers\n            if role == \"healer\" then\n                if job == 24 or job == 28 or job == 33 or job == 40 then\n                    return entity\n                end\n            end\n\n            -- DPS\n            if role == \"dps\" then\n                local isTank =\n                    job == 19 or job == 21 or job == 32 or job == 37\n\n                local isHealer =\n                    job == 24 or job == 28 or job == 33 or job == 40\n\n                if not isTank and not isHealer then\n                    return entity\n                end\n            end\n        end\n    end\n\n    return nil\nend\n\nlocal function CastMimicry(targetId)\n    local action = ActionList:Get(1, MIMICRY_SKILL_ID)\n\n    if not action then\n        d(\"[BLU Mimicry] Failed to get Aetheric Mimicry action.\")\n        return false\n    end\n\n    action:Cast(targetId)\n    return true\nend\n\nlocal function ApplyMimicry(role)\n    local target = GetRoleTarget(role)\n\n    if not target then\n        d(\"[BLU Mimicry] No valid \" .. role .. \" found within 25 yalms.\")\n        return\n    end\n\n    CastMimicry(target.id)\n\n    d(\"[BLU Mimicry] Applying \"\n        .. role\n        .. \" mimicry to \"\n        .. tostring(target.name))\nend\n\nlocal function RemoveMimicry()\n    local player = TensorCore.mGetPlayer()\n\n    if not player then\n        return\n    end\n\n    CastMimicry(player.id)\n\n    d(\"[BLU Mimicry] Removing mimicry.\")\nend\n\n-- =========================================================\n-- GUI\n-- =========================================================\n\nGUI:Begin(\"BLU Mimicry Helper###BLUMimicryHelper\", true, GUI_FLAGS)\n\n-- Tank\nGUI:PushStyleColor(\n    GUI.Col_Button,\n    ROLE_COLORS.tank[1],\n    ROLE_COLORS.tank[2],\n    ROLE_COLORS.tank[3],\n    ROLE_COLORS.tank[4]\n)\n\nif GUI:Button(\"TANK\", 100, 28) then\n    ApplyMimicry(\"tank\")\nend\n\nGUI:PopStyleColor()\n\nGUI:SameLine()\n\n-- Healer\nGUI:PushStyleColor(\n    GUI.Col_Button,\n    ROLE_COLORS.healer[1],\n    ROLE_COLORS.healer[2],\n    ROLE_COLORS.healer[3],\n    ROLE_COLORS.healer[4]\n)\n\nif GUI:Button(\"HEALER\", 100, 28) then\n    ApplyMimicry(\"healer\")\nend\n\nGUI:PopStyleColor()\n\nGUI:SameLine()\n\n-- DPS\nGUI:PushStyleColor(\n    GUI.Col_Button,\n    ROLE_COLORS.dps[1],\n    ROLE_COLORS.dps[2],\n    ROLE_COLORS.dps[3],\n    ROLE_COLORS.dps[4]\n)\n\nif GUI:Button(\"DPS\", 100, 28) then\n    ApplyMimicry(\"dps\")\nend\n\nGUI:PopStyleColor()\n\nGUI:Spacing()\n\n-- Remove Mimicry Button\nif GUI:Button(\"REMOVE MIMICRY\", 320, 28) then\n    RemoveMimicry()\nend\n\nGUI:End()\n\nself.used = true",
						luaReturnsAction = true,
						uuid = "ec9814dd-108b-36b8-a57e-ecf165303e15",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			eventType = 13,
			name = "Mimicry Helper",
			uuid = "6a9eaa8e-481f-a018-b6f5-a7fef3d9d4b2",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl