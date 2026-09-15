local tbl = 
{
	
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.frog_draw_settings == nil or data.frog_draw_settings.version~=3 then\n local p={\n  version=3,\n  path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]],\n  default=\"R1 H1 M1 MT OT M2 H2 R2\",\n  roles={MT=true,OT=true,H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n }\n function p.parse(text)\n  if type(text)~=\"string\" then return nil,\"Enter all eight roles.\" end\n  local order,seen={},{}\n  for role in string.upper(text):gmatch(\"[^%s,]+\") do\n   if not p.roles[role] then return nil,\"Unknown role: \"..role end\n   if seen[role] then return nil,\"Duplicate role: \"..role end\n   seen[role]=true; order[#order+1]=role\n  end\n  if #order~=8 then return nil,\"Enter each of MT OT H1 H2 M1 M2 R1 R2 once.\" end\n  return order,table.concat(order,\" \")\n end\n function p.save(text)\n  local order,normalized=p.parse(text)\n  if not order then p.message=normalized; return false end\n  local nextSettings={}\n  for k,v in pairs(p.settings) do nextSettings[k]=v end\n  nextSettings.doth_conga=normalized\n  local ok,err=pcall(FileSave,p.path,nextSettings)\n  local readOK,saved=pcall(FileLoad,p.path)\n  if not ok or not readOK or type(saved)~=\"table\" or saved.doth_conga~=normalized then\n   p.message=\"Save failed: \"..tostring(err or saved); return false\n  end\n  p.settings=nextSettings\n  p.order,p.saved,p.edit=order,normalized,normalized\n  p.message=\"Saved. Used when DOTH begins.\"\n  return true\n end\n p.order,p.saved=p.parse(p.default)\n p.edit=p.saved\n p.settings={}\n if FileExists(p.path) then\n  local ok,settings=pcall(FileLoad,p.path)\n  local order,normalized\n  if ok and type(settings)==\"table\" then\n   p.settings=settings\n   order,normalized=p.parse(settings.doth_conga)\n  end\n  if order then p.order,p.saved,p.edit=order,normalized,normalized\n  else p.message=\"Invalid settings file; using defaults. Apply to repair.\" end\n else\n  local previous=data.frog_draw_settings\n  p.save(previous and previous.saved or p.default)\n end\n data.frog_draw_settings=p\nend\n\nlocal p=data.frog_draw_settings\nif p.open==false then self.used=true return end\nlocal visible,open=GUI:Begin(\"Frog Draws - Priorities\",true)\np.open=open\nif visible then\n GUI:TextUnformatted(\"DOTH conga order: west to east\")\n p.edit=GUI:InputText(\"Roles\",p.edit)\n if GUI:Button(\"Apply and save\") then p.save(p.edit) end\n if GUI:Button(\"Load defaults into editor\") then p.edit=p.default end\n GUI:TextUnformatted(\"Saved: \"..p.saved)\n if p.message then GUI:TextUnformatted(p.message) end\nend\nGUI:End()\nself.used=true\n",
							name = "Persistent Draw Priorities Menu",
							uuid = "037d4e2f-1842-5c02-8610-55c301569a25",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 13,
				loop = true,
				name = "[Settings] Draw Priorities",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 20,
				timerStartOffset = -30,
				uuid = "40ce343b-d6ae-f0e8-8fed-38b54bcd6171",
				version = 2,
			},
		},
	}, 
	[10] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal centerX = 100.0\nlocal centerY = 0.0\nlocal centerZ = 100.0\nlocal arenaSize = 44.0\nlocal bladeWidth = 8.0\nlocal brightRadius = 9.0\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal state = TensorReactions_AdelphelBladeDrawState\n\nif state == nil or now < (state.lastTimer or now) then\n    state = {lastTimer = now, completedDashes = 0}\n    TensorReactions_AdelphelBladeDrawState = state\nend\nstate.lastTimer = now\nlocal completedDashes = math.min(state.completedDashes or 0, 4)\n\nlocal channel = 1\nlocal drawHeight = 0.05\nlocal baseFlags =\n    Argus2.RenderFlags.FLAG_OCCLUSION_BASE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal occludeFlags =\n    Argus2.RenderFlags.FLAG_OCCLUDE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n\nlocal base = TensorCore.getStaticFlatDrawer(0x5500FF00, 1.0, channel, baseFlags)\nbase:setHeightOffset(drawHeight)\nif now >= 52.9 then\n    base:addCenteredRect(centerX, centerY, centerZ, arenaSize, arenaSize, 0.0, false, baseFlags)\nend\n\nlocal cut = TensorCore.getStaticFlatDrawer(0xFFFFFFFF, 0.0, channel, occludeFlags)\ncut:setHeightOffset(drawHeight)\n\nlocal cardinals = {\n    [0] = {x = 0.0, z = 1.0},\n    [1] = {x = 1.0, z = 0.0},\n    [2] = {x = 0.0, z = -1.0},\n    [3] = {x = -1.0, z = 0.0}\n}\n\nif state.startIndex ~= nil and state.firstDashCaptured == true then\n    local function point(index)\n        return {\n            x = centerX + cardinals[index].x * 22.0,\n            y = centerY,\n            z = centerZ + cardinals[index].z * 22.0\n        }\n    end\n\n    local startIndex = state.startIndex\n    local firstIndex = state.firstIndex\n    local secondIndex = (firstIndex + 2) % 4\n    local thirdIndex = (startIndex + 2) % 4\n    local path = {\n        point(startIndex),\n        point(firstIndex),\n        point(secondIndex),\n        point(thirdIndex),\n        point(startIndex)\n    }\n\n    local function drawBlade(fromPoint, toPoint)\n        local dx = toPoint.x - fromPoint.x\n        local dz = toPoint.z - fromPoint.z\n        local length = math.sqrt(dx * dx + dz * dz)\n        local heading = TensorCore.getHeadingToTarget(fromPoint, toPoint)\n        local midX = (fromPoint.x + toPoint.x) * 0.5\n        local midZ = (fromPoint.z + toPoint.z) * 0.5\n        cut:addCenteredRect(midX, centerY, midZ, length, bladeWidth, heading, false, occludeFlags)\n    end\n\n    for i = completedDashes + 1, #path - 1 do\n        drawBlade(path[i], path[i + 1])\n    end\n\n    local predictedBrightspheres = {\n        {x = 0.0, z = 22.0},\n        {x = -11.0, z = 11.0},\n        {x = -22.0, z = 0.0},\n        {x = -7.48, z = 0.0},\n        {x = 7.48, z = 0.0},\n        {x = 22.0, z = 0.0},\n        {x = 11.0, z = -11.0},\n        {x = 0.0, z = -22.0},\n        {x = 0.0, z = -7.48},\n        {x = 0.0, z = 7.48},\n        {x = 0.0, z = 22.0}\n    }\n\n    for _, orb in ipairs(predictedBrightspheres) do\n        local worldX = centerX + orb.x * state.eastX + orb.z * state.northX\n        local worldZ = centerZ + orb.x * state.eastZ + orb.z * state.northZ\n        cut:addCircle(worldX, centerY, worldZ, brightRadius, false, occludeFlags)\n    end\nend\n\nlocal liveBrightspheres = TensorCore.getEntityByGroup(\"ContentID\", {\n    contentid = 4385,\n    subgroup = \"Number\",\n    noAliveCheck = true\n})\n\nif state.firstDashCaptured == true and liveBrightspheres then\n    if liveBrightspheres.id ~= nil then\n        cut:addCircle(liveBrightspheres.pos.x, liveBrightspheres.pos.y, liveBrightspheres.pos.z, brightRadius, false, occludeFlags)\n    else\n        for _, orb in pairs(liveBrightspheres) do\n            if orb and orb.pos then\n                cut:addCircle(orb.pos.x, orb.pos.y, orb.pos.z, brightRadius, false, occludeFlags)\n            end\n        end\n    end\nend\n\nself.used = true\n",
							name = "Draw Adelphel Blades",
							uuid = "4cf89cc3-9394-259b-bfd6-a4c1b82697b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 44.8,
				name = "[Draw] Adelphel Blade Draw",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 24.299999237061,
				uuid = "60c1eed1-d29b-e477-b273-75945c25583d",
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
							actionLua = "\nlocal centerX = 100.0\nlocal centerZ = 100.0\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal state = TensorReactions_AdelphelBladeDrawState\n\nif state == nil or now < (state.lastTimer or now) then\n    state = {lastTimer = now, completedDashes = 0}\n    TensorReactions_AdelphelBladeDrawState = state\nend\nstate.lastTimer = now\n\nlocal event = eventArgs\nlocal entity = event and TensorCore.mGetEntity(event.entityID)\nlocal castX = event and event.castPosX\nlocal castZ = event and event.castPosZ\n\nif state.firstDashCaptured ~= true\n    and event\n    and event.entityContentID == 3634\n    and entity\n    and entity.pos\n    and castX ~= nil\n    and castZ ~= nil\nthen\n    local startDX = entity.pos.x - centerX\n    local startDZ = entity.pos.z - centerZ\n    local castDX = castX - centerX\n    local castDZ = castZ - centerZ\n    local startIndex\n    local firstIndex\n\n    if math.abs(startDX) >= math.abs(startDZ) then\n        startIndex = (startDX >= 0.0) and 1 or 3\n    else\n        startIndex = (startDZ >= 0.0) and 0 or 2\n    end\n\n    if math.abs(castDX) >= math.abs(castDZ) then\n        firstIndex = (castDX >= 0.0) and 1 or 3\n    else\n        firstIndex = (castDZ >= 0.0) and 0 or 2\n    end\n\n    local adjacentA = (startIndex + 1) % 4\n    local adjacentB = (startIndex + 3) % 4\n    if firstIndex == adjacentA or firstIndex == adjacentB then\n        local cardinals = {\n            [0] = {x = 0.0, z = 1.0},\n            [1] = {x = 1.0, z = 0.0},\n            [2] = {x = 0.0, z = -1.0},\n            [3] = {x = -1.0, z = 0.0}\n        }\n\n        state.startIndex = startIndex\n        state.firstIndex = firstIndex\n        state.eastX = -cardinals[firstIndex].x\n        state.eastZ = -cardinals[firstIndex].z\n        state.northX = cardinals[startIndex].x\n        state.northZ = cardinals[startIndex].z\n        state.firstDashCaptured = true\n    end\nend\n\nstate.completedDashes = math.min((state.completedDashes or 0) + 1, 4)\nTensorReactions_AdelphelBladeDrawState = state\nself.used = true\n",
							conditions = 
							{
								
								{
									"83213c31-9d0f-965b-9158-f000a09e801d",
									true,
								},
							},
							name = "Track Blade Dash",
							uuid = "88c93550-4e4c-c50e-bb11-82467c48d68d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25294,
							name = "E - 62-66s Shining Blade",
							uuid = "83213c31-9d0f-965b-9158-f000a09e801d",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 44.8,
				name = "[Draw] Blade Progress",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 24.299999237061,
				uuid = "1b0307a5-c3db-601c-b74c-684a9eedc809",
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
							actionLua = "\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal timeout = math.max(0.0, (69.1 - now) * 1000.0)\nlocal occludeFlags =\n    Argus2.RenderFlags.FLAG_OCCLUDE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal drawer = TensorCore.getStaticFlatDrawer(0x00000000, 0.0, 1, occludeFlags)\ndrawer:setHeightOffset(0.05)\n\nif timeout > 0.0 and eventArgs.entityID ~= nil then\n    drawer:addTimedCircleOnEnt(\n        timeout,\n        eventArgs.entityID,\n        9.0,\n        0,\n        false,\n        true,\n        occludeFlags\n    )\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"7c31b38e-ca90-e402-887a-f4cc5f3e01a1",
									true,
								},
							},
							name = "Draw Tear Cutout",
							uuid = "40c8be0c-3391-633b-a9b7-e926c1e7b63e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3293,
							name = "E - 46s/53s Tear Added",
							uuid = "7c31b38e-ca90-e402-887a-f4cc5f3e01a1",
							version = 3,
						},
					},
				},
				eventType = 5,
				loop = true,
				mechanicTime = 44.8,
				name = "[Draw] Tear Cutouts",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 24.299999237061,
				uuid = "4c2eeccb-cad2-53e2-aec9-5bcfa66eb4bf",
				version = 2,
			},
		},
	},
	[14] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local remaining = 69.1 - (TensorReactions_CurrentTimer or 0)\nif remaining <= 0 or remaining > 4.01 then return end\n\nlocal adelphel = TensorCore.getEntityByGroup(\"ContentID\", {\n    contentid = 3634,\n    subgroup = \"Nearest\",\n    noAliveCheck = true\n})\nlocal target = adelphel and TensorCore.mGetEntity(adelphel.targetid)\nif not target then return end\n\nlocal drawer = TensorCore.getStaticFlatDrawer(\n    0x330000FF, 2.0, 0, Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n)\ndrawer:setHeightOffset(0.1)\nlocal uuid = drawer:addTimedCircleOnEnt(remaining * 1000, target.id, 3.0, 0, false, true)\nif uuid then self.used = true end",
							name = "Execution Warning on Adelphel Target",
							uuid = "2064f924-6f3b-715b-a2be-3dd923a6ed96",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 69.1,
				name = "[Draw] Execution Snapshot Warning",
				timeRange = true,
				timelineIndex = 14,
				timerStartOffset = -4,
				uuid = "587d38ef-6dbf-fe1e-865b-f1654686e510",
				version = 2,
			},
		},
	},
	[15] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local event = eventArgs\nlocal entityID = event and event.entityID\nlocal marker = event and event.markerID\nif entityID == nil\n    or (marker ~= 281 and marker ~= 282 and marker ~= 283 and marker ~= 284) then\n    self.used = true\n    return\nend\n\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal state = data.playstation_symbol_tether\nif state == nil or now < (state.lastTimer or now) then\n    state = {lastTimer = now, symbols = {}}\n    data.playstation_symbol_tether = state\nend\n\nstate.lastTimer = now\nstate.symbols[entityID] = marker\n\nself.used = true",
							conditions = 
							{
								
								{
									"66611d33-283d-b826-ba31-6fdaf107159e",
									true,
								},
							},
							name = "Capture PlayStation Symbol",
							uuid = "01d435c2-e58f-744a-b367-6fb4395c0553",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local event = eventArgs\nlocal marker = event and event.markerID\nreturn marker == 281 or marker == 282 or marker == 283 or marker == 284",
							dequeueIfLuaFalse = true,
							name = "PlayStation Symbol Entity",
							uuid = "66611d33-283d-b826-ba31-6fdaf107159e",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 86.2,
				name = "[Draw] PlayStation Symbol Capture",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "8586edac-a1b3-98f4-a4de-bf5906381d18",
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
							actionLua = "local player = TensorCore.mGetPlayer()\nlocal state = data.playstation_symbol_tether\nif not player or not player.pos or not state or not state.symbols then\n    self.used = true\n    return\nend\n\nlocal marker = state.symbols[player.id]\nif marker ~= 281 and marker ~= 282 and marker ~= 283 and marker ~= 284 then\n    self.used = true\n    return\nend\n\n-- Resolve the local player directly from Anyone's logical roster and\n-- live agnostic party list. This avoids role-partner entOf() lookups.\nif state.rosterResolved ~= true then\n    local rosterMembers = AnyoneCore.Roster.members()\n    local agnosticParty = AnyoneCore.API.getAgnosticPartyList()\n    if type(rosterMembers) ~= \"table\" or type(agnosticParty) ~= \"table\" then\n        self.used = true\n        return\n    end\n\n    local actorByNameJob = {}\n    for _, actor in pairs(agnosticParty) do\n        if actor ~= nil and actor.id ~= nil and actor.name ~= nil and actor.job ~= nil then\n            local key = tostring(actor.name) .. \"\\31\" .. tostring(actor.job)\n            actorByNameJob[key] = actor\n        end\n    end\n\n    local definitions = {\n        {name = \"MT\", rosterSlot = \"T1\"},\n        {name = \"OT\", rosterSlot = \"T2\"},\n        {name = \"H1\", rosterSlot = \"H1\"},\n        {name = \"H2\", rosterSlot = \"H2\"},\n        {name = \"M1\", rosterSlot = \"M1\"},\n        {name = \"M2\", rosterSlot = \"M2\"},\n        {name = \"R1\", rosterSlot = \"R1\"},\n        {name = \"R2\", rosterSlot = \"R2\"}\n    }\n\n    state.roleByID = {}\n    for _, definition in ipairs(definitions) do\n        local member = rosterMembers[definition.rosterSlot]\n        if member == nil or member.name == nil or member.job == nil then\n            state.roleByID = nil\n            self.used = true\n            return\n        end\n\n        local key = tostring(member.name) .. \"\\31\" .. tostring(member.job)\n        local actor = actorByNameJob[key]\n        if actor == nil or actor.id == nil then\n            state.roleByID = nil\n            self.used = true\n            return\n        end\n\n        state.roleByID[actor.id] = definition.name\n    end\n\n    state.rosterResolved = true\nend\n\nlocal role = state.roleByID and state.roleByID[player.id]\nif role == nil then\n    self.used = true\n    return\nend\n\nlocal targetX = nil\nlocal targetZ = nil\n\n-- Marker IDs: circle=281, triangle=282, square=283, cross=284.\n-- Fixed waymark-side destinations use the same 22-yalm arena layout.\nlocal isTank = role == \"MT\" or role == \"OT\"\nlocal isHealer = role == \"H1\" or role == \"H2\"\nlocal isDPS = role == \"M1\" or role == \"M2\"\n    or role == \"R1\" or role == \"R2\"\n\nif isTank then\n    if marker == 284 then\n        targetX = 100.0\n        targetZ = 78.0\n    elseif marker == 283 then\n        targetX = 122.0\n        targetZ = 78.0\n    end\nelseif isHealer then\n    if marker == 284 then\n        targetX = 100.0\n        targetZ = 122.0\n    elseif marker == 282 then\n        targetX = 122.0\n        targetZ = 122.0\n    end\nelseif isDPS then\n    if marker == 282 then\n        targetX = 78.0\n        targetZ = 78.0\n    elseif marker == 283 then\n        targetX = 78.0\n        targetZ = 122.0\n    elseif marker == 281 then\n        local otherCircleX = nil\n        for entityID, otherMarker in pairs(state.symbols) do\n            if entityID ~= player.id and otherMarker == 281 then\n                local other = TensorCore.mGetEntity(entityID)\n                if other ~= nil and other.pos ~= nil then\n                    otherCircleX = other.pos.x\n                    break\n                end\n            end\n        end\n\n        if otherCircleX ~= nil then\n            local myWest = math.abs(player.pos.x - 78.0)\n            local myEast = math.abs(player.pos.x - 122.0)\n            local otherWest = math.abs(otherCircleX - 78.0)\n            local otherEast = math.abs(otherCircleX - 122.0)\n\n            -- Choose the globally consistent west/east split.\n            if (myWest + otherEast) <= (myEast + otherWest) then\n                targetX = 78.0\n            else\n                targetX = 122.0\n            end\n            targetZ = 100.0\n        end\n    end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n    local drawer = TensorCore.getMoogleDrawer()\n    drawer:addLine(\n        player.pos.x, player.pos.y, player.pos.z,\n        targetX, player.pos.y, targetZ,\n        8.0, 3.0\n    )\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"6d9e0260-d620-393e-b85a-f5671b0fdf33",
									true,
								},
							},
							name = "Draw PlayStation Symbol Tether",
							uuid = "ee906177-2d71-2221-9c6e-2236ce2ee808",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local player = TensorCore.mGetPlayer()\nlocal state = data.playstation_symbol_tether\nlocal marker = state and player and state.symbols[player.id]\nreturn marker == 281 or marker == 282 or marker == 283 or marker == 284",
							name = "PlayStation Symbol Ready",
							uuid = "6d9e0260-d620-393e-b85a-f5671b0fdf33",
							version = 3,
						},
					},
				},
				eventType = 12,
				loop = true,
				mechanicTime = 86.2,
				name = "[Draw] PlayStation Symbol Tether",
				timeRange = true,
				timelineIndex = 15,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "a6ea40a2-70cb-f04b-a9ec-b956da1e86a3",
				version = 2,
			},
		},
	},
	[50] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_bash=data.frog_bash or {}\nlocal s=data.frog_bash\ns.x,s.z,s.target=nil,nil,nil\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then return end\nif not s.q then\n s.q={contentid=3632,subgroup=\"Number\",noAliveCheck=true}\n s.aq={contentid=3634,noAliveCheck=true}\n s.jq={contentid=3635,noAliveCheck=true}\n s.holders=s.holders or {}\n s.done=s.done or {}\nend\nif not s.role then\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if type(roster)~=\"table\" or type(party)~=\"table\" then return end\n for slot,m in pairs(roster) do\n  if slot==\"T1\" or slot==\"T2\" then\n   local exact,unique,count=nil,nil,0\n   local rosterCount=0\n   for _,v in pairs(roster) do if v.job==m.job then rosterCount=rosterCount+1 end end\n   for _,a in pairs(party) do\n    if a.job==m.job then\n     count=count+1 unique=a\n     if a.name==m.name then exact=a end\n    end\n   end\n   local a=exact or (count==1 and rosterCount==1 and unique)\n   if a and a.id==p.id then s.role=slot break end\n  end\n end\n if not s.role then self.used=true return end\nend\nlocal thordan=s.thordan and TensorCore.mGetEntity(s.thordan)\nif not thordan then\n local list=TensorCore.getEntityByGroup(\"ContentID\",s.q)\n local best=100\n for _,e in pairs(list or {}) do\n  if e.pos then\n   local d=(e.pos.x-100)^2+(e.pos.z-100)^2\n   if d>best then best=d thordan=e end\n  end\n end\n if thordan then s.thordan=thordan.id end\nend\nif not thordan or not thordan.pos then return end\nlocal nx,nz=thordan.pos.x-100,thordan.pos.z-100\nlocal radius=math.sqrt(nx*nx+nz*nz)\nif radius<10 then s.thordan=nil return end\nnx,nz=nx/radius,nz/radius\nlocal ex,ez=-nz,nx\nif not s.knight then\n local a=TensorCore.getEntityByGroup(\"ContentID\",s.aq)\n local j=TensorCore.getEntityByGroup(\"ContentID\",s.jq)\n if not a or not j or not a.pos or not j.pos then return end\n local ap=(a.pos.x-100)*ex+(a.pos.z-100)*ez\n local jp=(j.pos.x-100)*ex+(j.pos.z-100)*ez\n if math.abs(ap-jp)<1 then return end\n local west,east\n if ap<jp then west,east=a,j else west,east=j,a end\n s.knight=(s.role==\"T1\" and west or east).id\nend\nif s.done[s.knight] then self.used=true return end\nif s.holders[s.knight]==p.id then\n local side=s.role==\"T1\" and 3 or -3\n local forward=math.sqrt(radius*radius-9)\n s.x=100+nx*forward+ex*side\n s.z=100+nz*forward+ez*side\nelse\n s.target=s.knight\nend\nself.used=true",
							name = "[Draw] Shield Bash Tank Assignment",
							uuid = "7ec443b8-a879-6bc3-887b-d58ac800a859",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 335.3,
				name = "[Draw] Shield Bash Tank Assignment",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.6,
				uuid = "2c1d8b92-2491-8b1a-8a13-ae114572f112",
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
							actionLua = "data.frog_bash=data.frog_bash or {}\nlocal s=data.frog_bash\ns.holders=s.holders or {}\ns.holders[eventArgs.sourceEntityID]=eventArgs.newTetherID==84 and eventArgs.newTargetID or nil\nself.used=true",
							conditions = 
							{
								
								{
									"2e805132-4ef7-f28f-b49e-9bf9ad845737",
									true,
								},
							},
							name = "[Draw] Shield Bash Tether Capture",
							uuid = "38ed172a-20e8-f58a-b242-d4189ab4654c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return (eventArgs.sourceEntityContentID==3634 or eventArgs.sourceEntityContentID==3635) and (eventArgs.oldTetherID==84 or eventArgs.newTetherID==84)",
							dequeueIfLuaFalse = true,
							name = "Bash knight tether change",
							uuid = "2e805132-4ef7-f28f-b49e-9bf9ad845737",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 335.3,
				name = "[Draw] Shield Bash Tether Capture",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.6,
				uuid = "05a626e0-a6e5-8337-b4df-85aaf4f08d2f",
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
							actionLua = "local s=data.frog_bash\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then return end\nlocal x,z=s.x,s.z\nif s.target then\n local e=TensorCore.mGetEntity(s.target)\n if not e or not e.pos then return end\n x,z=e.pos.x,e.pos.z\nend\nif not x then return end\nTensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0):addLine(p.pos.x,p.pos.y,p.pos.z,x,0.05,z,8,2)\nself.used=true",
							name = "[Draw] Shield Bash Personal Tether",
							uuid = "e38b0883-2b60-8ffe-8be0-ddacad9c6b25",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 335.3,
				name = "[Draw] Shield Bash Personal Tether",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.6,
				uuid = "bbfbd4a9-df92-0ce2-b30f-effc1eef8c17",
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
							actionLua = "data.frog_bash=data.frog_bash or {}\nlocal s=data.frog_bash\ns.done=s.done or {}\ns.done[eventArgs.entityID]=true\ns.x,s.z,s.target=nil,nil,nil\nself.used=true",
							conditions = 
							{
								
								{
									"faa65597-19e1-3fa2-a905-f74f8ac87cc3",
									true,
								},
							},
							name = "[Draw] Shield Bash Resolution",
							uuid = "1bdec85d-bf30-ed68-901f-cf7ff623b837",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25297,
							uuid = "faa65597-19e1-3fa2-a905-f74f8ac87cc3",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 335.3,
				name = "[Draw] Shield Bash Resolution",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.6,
				uuid = "afd2ef94-b4e1-08fb-a031-58ab671502e1",
				version = 2,
			},
		},
	},
	[64] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local cid = eventArgs.entityContentID\nif cid ~= 3633 and cid ~= 3634 and cid ~= 3635 then\n    self.used = true\n    return\nend\n\nlocal state = data.sam_sanctity_flex\nif state == nil then\n    state = {}\n    data.sam_sanctity_flex = state\nend\n\n-- All Sanctity knights become visible in the same frame. Preserve knight IDs\n-- already captured earlier in that queued visibility batch when Zephirin\n-- initializes the fresh set, while clearing pull-specific marker/geometry data.\nif cid == 3633 then\n    state = {\n        captureInitialized = true,\n        markers = {},\n        zephirinLocked = false,\n        knightBias = nil,\n        zephirinID = eventArgs.entityID,\n        adelphelID = state.adelphelID,\n        janlenouxID = state.janlenouxID\n    }\n    data.sam_sanctity_flex = state\nelseif state.captureInitialized ~= true then\n    state.captureInitialized = true\n    state.markers = {}\n    state.zephirinLocked = false\n    state.knightBias = nil\nend\n\nif cid == 3634 then\n    state.adelphelID = eventArgs.entityID\nelseif cid == 3635 then\n    state.janlenouxID = eventArgs.entityID\nend\n\nself.used = true",
							conditions = 
							{
								
								{
									"9f13be59-871a-234a-b494-04088120b99c",
									true,
								},
							},
							name = "Capture Sanctity flex entities",
							uuid = "f8820393-4e70-5368-af1d-38ed02199435",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							name = "Sanctity knight visible",
							uuid = "9f13be59-871a-234a-b494-04088120b99c",
							version = 3,
						},
					},
				},
				eventType = 22,
				loop = true,
				mechanicTime = 385.6,
				name = "[Draw] Sanctity Flex Capture",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 13.7,
				timerStartOffset = -6,
				uuid = "11f879ce-31b8-c5ff-b031-b1e7b4f637f3",
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
							actionLua = "local state = data.sam_sanctity_flex\nif state == nil or state.markers == nil or\n   state.zephirinID == nil or state.adelphelID == nil or state.janlenouxID == nil then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal zephirin = TensorCore.mGetEntity(state.zephirinID)\nlocal adelphel = TensorCore.mGetEntity(state.adelphelID)\nlocal janlenoux = TensorCore.mGetEntity(state.janlenouxID)\nif player == nil or player.pos == nil or\n   zephirin == nil or zephirin.pos == nil or\n   adelphel == nil or adelphel.pos == nil or\n   janlenoux == nil or janlenoux.pos == nil then\n    return\nend\n\nlocal mySlot = AnyoneCore.Roster.mySlot()\nif mySlot == nil then\n    return\nend\n\nlocal groupOneSlots = {\n    T1 = true,\n    H1 = true,\n    M1 = true,\n    R1 = true\n}\nlocal partnerSlots = {\n    T1 = \"T2\",\n    T2 = \"T1\",\n    H1 = \"H2\",\n    H2 = \"H1\",\n    M1 = \"M2\",\n    M2 = \"M1\",\n    R1 = \"R2\",\n    R2 = \"R1\"\n}\n\nlocal baseGroup\nif groupOneSlots[mySlot] == true then\n    baseGroup = 1\nelseif partnerSlots[mySlot] ~= nil then\n    baseGroup = 2\nelse\n    return\nend\n\nlocal otherSlot = partnerSlots[mySlot]\nlocal otherID = nil\n\n-- Replay-safe partner lookup:\n-- Roster.members() supplies the logical role slot and human identity;\n-- getAgnosticPartyList() supplies the current live entity ID.\nlocal rosterMembers = AnyoneCore.Roster.members()\nlocal agnosticParty = AnyoneCore.API.getAgnosticPartyList()\nif type(rosterMembers) == \"table\" and type(agnosticParty) == \"table\" then\n    local partner = rosterMembers[otherSlot]\n    if partner ~= nil and partner.name ~= nil and partner.job ~= nil then\n        local partnerKey = tostring(partner.name) .. \"\\31\" .. tostring(partner.job)\n        for _, actor in pairs(agnosticParty) do\n            if actor ~= nil and actor.id ~= nil\n                and actor.name ~= nil and actor.job ~= nil\n                and tostring(actor.name) .. \"\\31\" .. tostring(actor.job) == partnerKey then\n                otherID = actor.id\n                break\n            end\n        end\n    end\nend\n\nlocal playerMarker = state.markers[player.id]\nlocal otherMarker = nil\nif otherID ~= nil then\n    otherMarker = state.markers[otherID]\nend\n\nlocal finalGroup = baseGroup\nif playerMarker == 50 then\n    finalGroup = 1\nelseif playerMarker == 51 then\n    finalGroup = 2\nelseif otherMarker == 50 then\n    finalGroup = 2\nelseif otherMarker == 51 then\n    finalGroup = 1\nend\n\nif state.zephirinLocked ~= true then\n    local zx = zephirin.pos.x - 100.0\n    local zz = zephirin.pos.z - 100.0\n    if math.abs(zx) < 8.0 or math.abs(zz) < 8.0 then\n        return\n    end\n    state.zephirinX = zephirin.pos.x\n    state.zephirinZ = zephirin.pos.z\n    state.zephirinLocked = true\nend\n\nif state.knightBias == nil then\n    local west, east\n    if math.abs(adelphel.pos.x - 95.0) <= 0.75 and\n       math.abs(janlenoux.pos.x - 105.0) <= 0.75 then\n        west, east = adelphel, janlenoux\n    elseif math.abs(janlenoux.pos.x - 95.0) <= 0.75 and\n           math.abs(adelphel.pos.x - 105.0) <= 0.75 then\n        west, east = janlenoux, adelphel\n    else\n        return\n    end\n\n    if math.abs(west.pos.z - 100.0) > 0.75 or\n       math.abs(east.pos.z - 100.0) > 0.75 or\n       west.pos.h == nil or east.pos.h == nil then\n        return\n    end\n\n    if math.abs(west.pos.h) > 1.5 and math.abs(east.pos.h) < 1.5 then\n        state.knightBias = 1\n    elseif math.abs(west.pos.h) < 1.5 and math.abs(east.pos.h) > 1.5 then\n        state.knightBias = -1\n    else\n        return\n    end\nend\n\nlocal dx = state.zephirinX - 100.0\nlocal dz = state.zephirinZ - 100.0\nlocal radius = math.sqrt(dx * dx + dz * dz)\nif radius <= 0.0 then\n    return\nend\n\nlocal directionX = dx / radius\nlocal directionZ = dz / radius\nif finalGroup == 1 then\n    directionX = -directionX\n    directionZ = -directionZ\nend\n\nlocal biasRadians = state.knightBias * 0.2094395102\nlocal cosine = math.cos(biasRadians)\nlocal sine = math.sin(biasRadians)\nlocal adjustedX = directionX * cosine - directionZ * sine\nlocal adjustedZ = directionX * sine + directionZ * cosine\nlocal targetX = 100.0 + adjustedX * 20.25\nlocal targetZ = 100.0 + adjustedZ * 20.25\n\nif state.drawer == nil then\n    state.drawer = TensorCore.getCachedFlatDrawer(\n        nil, nil, 0xFF0000FF, nil, 1.0, 0, 0\n    )\nend\n\nstate.drawer:addLine(\n    player.pos.x, player.pos.y, player.pos.z,\n    targetX, 0.05, targetZ,\n    8.0, 2.0\n)\n\nself.used = true\n",
							name = "Draw Sanctity flex tether",
							uuid = "53d18b17-56fd-d820-b631-f77d09b7e1f8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 385.6,
				name = "[Draw] Sanctity Flex Tether",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 13.699999809265,
				timerStartOffset = 4.5,
				uuid = "4303064e-5ceb-e4e2-92fd-d41e4472795e",
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
							actionLua = "local cid = eventArgs.entityContentID\nif cid ~= 3634 and cid ~= 3635 then\n    self.used = true\n    return\nend\n\nlocal state = data.sam_sanctity_draw\nif state == nil then\n    state = {}\n    data.sam_sanctity_draw = state\nend\n\nstate.entityIDs = state.entityIDs or {}\nstate.entityIDs[cid] = eventArgs.entityID\nstate.armed = true\nself.used = true\n",
							conditions = 
							{
								
								{
									"3c6fb205-2153-af21-b8f7-220298ddbc64",
									true,
								},
							},
							name = "Capture Sanctity knight entity",
							uuid = "044c8815-bb39-af74-b7f8-86c4c3e022c9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							name = "Adelphel is visible",
							uuid = "3c6fb205-2153-af21-b8f7-220298ddbc64",
							version = 3,
						},
					},
				},
				eventType = 22,
				loop = true,
				mechanicTime = 385.6,
				name = "[Draw] Sanctity Predictive Capture",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 13.7,
				timerStartOffset = -6,
				uuid = "8fe74c06-fd1a-6294-b637-aa9e1e29ea7d",
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
							actionLua = "\nlocal state = data.sam_sanctity_draw\nif state == nil then\n    state = {}\n    data.sam_sanctity_draw = state\nend\n\nif state.predictionDrawn == true then\n    self.used = true\n    return\nend\n\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal predictionEnd = 399.3\nlocal arenaEnd = 404.9\nlocal predictionTimeout = math.floor((predictionEnd - now) * 1000.0)\nlocal arenaTimeout = math.floor((arenaEnd - now) * 1000.0)\nif arenaTimeout <= 0 then\n    self.used = true\n    return\nend\n\nlocal centerX, centerY, centerZ = 100.0, 0.0, 100.0\nlocal arenaRadius, orbRadius, laneWidth = 21.0, 9.0, 8.0\nlocal channel, drawHeight = 1, 0.05\nlocal baseFlags =\n    Argus2.RenderFlags.FLAG_OCCLUSION_BASE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal occludeFlags =\n    Argus2.RenderFlags.FLAG_OCCLUDE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n\nif state.baseDrawn ~= true then\n    local base = TensorCore.getStaticFlatDrawer(0x5500FF00, 1.0, channel, baseFlags)\n    base:setHeightOffset(drawHeight)\n    base:addTimedCircle(arenaTimeout, centerX, centerY, centerZ, arenaRadius, 0, false, true, baseFlags)\n    state.baseDrawn = true\nend\n\nif predictionTimeout <= 0 then\n    self.used = true\n    return\nend\n\nif state.entityIDs == nil or\n   state.entityIDs[3634] == nil or state.entityIDs[3635] == nil then\n    self.used = true\n    return\nend\n\nlocal adelphel = TensorCore.mGetEntity(state.entityIDs[3634])\nlocal janlenoux = TensorCore.mGetEntity(state.entityIDs[3635])\nif adelphel == nil or janlenoux == nil or\n   adelphel.pos == nil or janlenoux.pos == nil or\n   adelphel.pos.x == nil or janlenoux.pos.x == nil or\n   adelphel.pos.z == nil or janlenoux.pos.z == nil or\n   adelphel.pos.h == nil or janlenoux.pos.h == nil then\n    self.used = true\n    return\nend\n\nlocal west, east\nif adelphel.pos.x < 100.0 and janlenoux.pos.x > 100.0 then\n    west, east = adelphel, janlenoux\nelseif janlenoux.pos.x < 100.0 and adelphel.pos.x > 100.0 then\n    west, east = janlenoux, adelphel\nelse\n    self.used = true\n    return\nend\n\nif math.abs(west.pos.x - 95.0) > 0.5 or math.abs(west.pos.z - 100.0) > 0.5 or\n   math.abs(east.pos.x - 105.0) > 0.5 or math.abs(east.pos.z - 100.0) > 0.5 then\n    self.used = true\n    return\nend\n\n-- Arm from the verified starting snapshot, even if visibility fired\n-- before this reaction was loaded into an already-running replay.\nstate.armed = true\n\nlocal westFacingPi = math.abs(west.pos.h) > 1.5\nlocal eastFacingZero = math.abs(east.pos.h) < 1.5\nlocal pattern\n\nif westFacingPi and eastFacingZero then\n    pattern = {\n        {\n            start = {x = 95.0, z = 100.0},\n            finish = {x = 100.0, z = 79.0},\n            orbs = {\n                {x = 95.000, z = 100.000},\n                {x = 97.502, z = 89.494},\n                {x = 100.000, z = 79.000}\n            }\n        },\n        {\n            start = {x = 105.0, z = 100.0},\n            finish = {x = 100.0, z = 121.0},\n            orbs = {\n                {x = 105.000, z = 100.000},\n                {x = 102.498, z = 110.506},\n                {x = 100.000, z = 121.000}\n            }\n        }\n    }\nelseif (not westFacingPi) and (not eastFacingZero) then\n    pattern = {\n        {\n            start = {x = 95.0, z = 100.0},\n            finish = {x = 100.0, z = 121.0},\n            orbs = {\n                {x = 95.000, z = 100.000},\n                {x = 97.502, z = 110.506},\n                {x = 100.000, z = 121.000}\n            }\n        },\n        {\n            start = {x = 105.0, z = 100.0},\n            finish = {x = 100.0, z = 79.0},\n            orbs = {\n                {x = 105.000, z = 100.000},\n                {x = 102.498, z = 89.494},\n                {x = 100.000, z = 79.000}\n            }\n        }\n    }\nelse\n    self.used = true\n    return\nend\n\nlocal cut = TensorCore.getStaticFlatDrawer(0x00000000, 0.0, channel, occludeFlags)\ncut:setHeightOffset(drawHeight)\n\nfor _, dash in ipairs(pattern) do\n    local dx = dash.finish.x - dash.start.x\n    local dz = dash.finish.z - dash.start.z\n    local length = math.sqrt(dx * dx + dz * dz)\n    local heading = TensorCore.getHeadingToTarget(dash.start, dash.finish)\n    cut:addTimedCenteredRect(\n        predictionTimeout,\n        (dash.start.x + dash.finish.x) * 0.5,\n        centerY,\n        (dash.start.z + dash.finish.z) * 0.5,\n        length,\n        laneWidth,\n        heading,\n        0,\n        false,\n        true,\n        occludeFlags\n    )\n\n    for _, orb in ipairs(dash.orbs) do\n        cut:addTimedCircle(\n            predictionTimeout,\n            orb.x,\n            centerY,\n            orb.z,\n            orbRadius,\n            0,\n            false,\n            true,\n            occludeFlags\n        )\n    end\nend\n\nstate.predictionDrawn = true\nself.used = true\n",
							name = "Draw Sanctity Predictive Occlusion",
							uuid = "a0629032-1124-5240-a10b-df9accf9fc8b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 385.6,
				name = "[Draw] Sanctity Predictive Occlusion",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 13.699999809265,
				timerStartOffset = 2,
				uuid = "85dccc92-0e0c-fedc-9848-393300427559",
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
							actionLua = "local marker = eventArgs.markerID\nif marker ~= 50 and marker ~= 51 then\n    self.used = true\n    return\nend\n\nlocal state = data.sam_sanctity_flex\nif state == nil then\n    state = {}\n    data.sam_sanctity_flex = state\nend\n\nstate.markers = state.markers or {}\nstate.markers[eventArgs.entityID] = marker\nself.used = true\n",
							name = "Capture Sanctity sword marker",
							uuid = "627dd271-34ff-1d10-b376-17e2d2bb70ba",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 4,
				loop = true,
				mechanicTime = 385.6,
				name = "[Draw] Sanctity Sword Marker Capture",
				timeRange = true,
				timelineIndex = 64,
				timerEndOffset = 13.7,
				timerStartOffset = 4.5,
				uuid = "cc0414f0-aecf-112f-8446-ba032223805a",
				version = 2,
			},
		},
	},
	[68] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "\nlocal timeout = 2000.0\nlocal occludeFlags =\n    Argus2.RenderFlags.FLAG_OCCLUDE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal drawer = TensorCore.getStaticFlatDrawer(0x00000000, 0.0, 1, occludeFlags)\ndrawer:setHeightOffset(0.05)\n\nif eventArgs.entityID ~= nil then\n    drawer:addTimedCircleOnEnt(\n        timeout,\n        eventArgs.entityID,\n        9.0,\n        0,\n        false,\n        true,\n        occludeFlags\n    )\nend\n\nself.used = true\n",
							conditions = 
							{
								
								{
									"7186d283-e797-cfb1-aa11-623eeba229ec",
									true,
								},
							},
							name = "Draw Brightsphere Occlusion",
							uuid = "3cd5842c-9168-e9ea-b651-addee93881b6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 4385,
							name = "Brightsphere event",
							uuid = "7186d283-e797-cfb1-aa11-623eeba229ec",
							version = 3,
						},
					},
				},
				eventType = 5,
				loop = true,
				mechanicTime = 399.3,
				name = "[Draw] Sanctity Brightsphere Occlusion",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 5.5999999046326,
				uuid = "14d46326-3012-9e0a-b3eb-969d25e1f037",
				version = 2,
			},
		},
	},
	[71] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.sam_hiemal_meteor\nif state == nil\n    or state.towersResolved ~= true\n    or state.towerByID == nil then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    return\nend\n\nlocal tower = state.towerByID[player.id]\nif tower == nil then\n    return\nend\n\nlocal drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, 0xFF0000FF, nil, 1.1, 0, 0\n)\n\ndrawer:addLine(\n    player.pos.x, player.pos.y, player.pos.z,\n    tower.x, tower.y or 0.05, tower.z,\n    8.0, 2.0\n)\n",
							name = "Draw Hiemal First Tower Tether",
							uuid = "8eb5ed44-df8d-9e57-bd6f-33bfc85beca8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 417.4,
				name = "[Draw] Hiemal Meteor First Tower Tether",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = 4.19,
				timerStartOffset = -2.2,
				uuid = "f18b26ef-d7aa-1e0e-b741-b6ecc895ac05",
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
							actionLua = "local function createMeteorState()\n    return {\n        marked = {},\n        markerCount = 0,\n        towers = {},\n        towerCount = 0,\n        assignmentsReady = false,\n        towersResolved = false\n    }\nend\n\nif eventArgs == nil or eventArgs.markerID ~= 285 or eventArgs.entityID == nil then\n    return\nend\n\nlocal state = data.sam_hiemal_meteor\nif state == nil or state.markerCount == nil or state.markerCount >= 2 then\n    state = createMeteorState()\n    data.sam_hiemal_meteor = state\nend\n\nstate.marked[eventArgs.entityID] = true\nlocal count = 0\nfor _ in pairs(state.marked) do\n    count = count + 1\nend\nstate.markerCount = count\nself.used = true\n",
							name = "Capture Hiemal Meteor Markers",
							uuid = "a36c5c2c-4358-fbc7-b1a5-95cb2de5c2fd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 4,
				loop = true,
				mechanicTime = 417.4,
				name = "[Draw] Hiemal Meteor Marker Capture",
				timeRange = true,
				timelineIndex = 71,
				timerStartOffset = -12,
				uuid = "498c2fd9-a02e-6116-9369-2e3a0cfc0c9c",
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
							actionLua = "local state = data.sam_hiemal_meteor\nif state == nil or state.marked == nil or state.markerCount < 2 then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    return\nend\n\nif state.slotOrder == nil then\n    state.slotOrder = {\"MT\", \"OT\", \"H1\", \"H2\", \"M1\", \"M2\", \"R1\", \"R2\"}\n    state.definitions = {\n        {name = \"MT\", cardinal = \"N\"},\n        {name = \"OT\", cardinal = \"S\"},\n        {name = \"H1\", cardinal = \"W\"},\n        {name = \"H2\", cardinal = \"E\"},\n        {name = \"M1\", cardinal = \"W\"},\n        {name = \"M2\", cardinal = \"E\"},\n        {name = \"R1\", cardinal = \"N\"},\n        {name = \"R2\", cardinal = \"S\"}\n    }\nend\n\nif state.meteorSolverVersion ~= 4 then\n    state.meteorSolverVersion = 4\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.towerByID = nil\nend\n\nif state.assignmentsReady ~= true then\nlocal rosterSlotByName = {\n    MT = \"T1\",\n    OT = \"T2\",\n    H1 = \"H1\",\n    H2 = \"H2\",\n    M1 = \"M1\",\n    M2 = \"M2\",\n    R1 = \"R1\",\n    R2 = \"R2\"\n}\nlocal refreshedSlots = {}\nlocal refreshedInitialCardinal = {}\nlocal rosterIDs = {}\n\n-- Replay-safe roster join:\n-- Roster.members() contains the logical slots and human names, while\n-- getAgnosticPartyList() contains the current live entity IDs.\nlocal rosterMembers = AnyoneCore.Roster.members()\nlocal agnosticParty = AnyoneCore.API.getAgnosticPartyList()\nif type(rosterMembers) ~= \"table\" or type(agnosticParty) ~= \"table\" then\n    return\nend\n\nlocal actorByJob, actorJobCount, rosterJobCount = {}, {}, {}\nfor _, actor in pairs(agnosticParty) do\n    if actor.id ~= nil and actor.job ~= nil then\n        actorByJob[actor.job] = actor\n        actorJobCount[actor.job] = (actorJobCount[actor.job] or 0) + 1\n    end\nend\nfor _, member in pairs(rosterMembers) do\n    if member.job ~= nil then\n        rosterJobCount[member.job] = (rosterJobCount[member.job] or 0) + 1\n    end\nend\nlocal actorByNameJob = {}\nfor _, actor in pairs(agnosticParty) do\n    if actor ~= nil and actor.id ~= nil and actor.name ~= nil and actor.job ~= nil then\n        local key = tostring(actor.name) .. \"\\31\" .. tostring(actor.job)\n        actorByNameJob[key] = actor\n    end\nend\n\nfor _, definition in ipairs(state.definitions) do\n    local rosterSlot = rosterSlotByName[definition.name]\n    local member = rosterMembers[rosterSlot]\n    if member == nil or member.name == nil or member.job == nil then\n        return\n    end\n\n    local key = tostring(member.name) .. \"\\31\" .. tostring(member.job)\n    local actor = actorByNameJob[key]\n    -- Anonymized replay names can differ; use only an unambiguous job join.\n    if actor == nil and actorJobCount[member.job] == 1 and rosterJobCount[member.job] == 1 then\n        actor = actorByJob[member.job]\n    end\n    if actor == nil or actor.id == nil then\n        return\n    end\n\n    local kind\n    if definition.name == \"MT\" or definition.name == \"OT\"\n        or definition.name == \"H1\" or definition.name == \"H2\" then\n        kind = \"SUPPORT\"\n    else\n        kind = \"DPS\"\n    end\n\n    local id = actor.id\n    refreshedSlots[definition.name] = {\n        id = id,\n        cardinal = definition.cardinal,\n        kind = kind\n    }\n    refreshedInitialCardinal[id] = definition.cardinal\n    rosterIDs[#rosterIDs + 1] = definition.name .. \"=\" .. tostring(id)\nend\n\nlocal rosterSignature = table.concat(rosterIDs, \":\")\nif state.rosterSignature ~= rosterSignature then\n    state.rosterSignature = rosterSignature\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.finalCardinal = nil\n    state.rotatedFrom = nil\n    state.meteorPlayers = nil\n    state.towerByID = nil\n    state.quadrants = nil\nend\n\nstate.slots = refreshedSlots\nstate.initialCardinal = refreshedInitialCardinal\n\nlocal meteorPlayers = {}\nlocal meteorKind = nil\nfor _, slotName in ipairs(state.slotOrder) do\n    local slot = state.slots[slotName]\n    if slot ~= nil and state.marked[slot.id] == true then\n        meteorPlayers[#meteorPlayers + 1] = slot\n        if meteorKind == nil then\n            meteorKind = slot.kind\n        elseif meteorKind ~= slot.kind then\n            return\n        end\n    end\nend\n\nif #meteorPlayers < 2 or meteorKind == nil then\n    return\nend\n\nif state.assignmentsReady ~= true then\n    state.finalCardinal = {}\n    state.rotatedFrom = {}\n    state.meteorPlayers = meteorPlayers\n\n    local occupied = {N = false, S = false}\n    for _, slot in ipairs(state.slotOrder) do\n        local entry = state.slots[slot]\n        state.finalCardinal[entry.id] = entry.cardinal\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"N\" or entry.cardinal == \"S\") then\n            occupied[entry.cardinal] = true\n        end\n    end\n\n    -- Meteor players already starting north or south stay fixed.\n    -- West rotates clockwise to north; east rotates clockwise to south.\n    -- If that destination is already occupied by a meteor, use the other\n    -- fixed cardinal instead.\n    for _, slotName in ipairs(state.slotOrder) do\n        local entry = state.slots[slotName]\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"W\" or entry.cardinal == \"E\") then\n            local target = entry.cardinal == \"W\" and \"N\" or \"S\"\n            if occupied[target] == true then\n                target = target == \"N\" and \"S\" or \"N\"\n            end\n            state.finalCardinal[entry.id] = target\n            state.rotatedFrom[target] = entry.cardinal\n            occupied[target] = true\n        end\n    end\n\n    -- The non-meteor support/DPS player who originally owned the fixed\n    -- cardinal flexes into the quadrant vacated by the rotating meteor.\n    for target, originalCardinal in pairs(state.rotatedFrom) do\n        for _, slotName in ipairs(state.slotOrder) do\n            local entry = state.slots[slotName]\n            if entry.kind == meteorKind\n                and state.marked[entry.id] ~= true\n                and entry.cardinal == target then\n                state.finalCardinal[entry.id] = originalCardinal\n                break\n            end\n        end\n    end\n\n    state.meteorKind = meteorKind\n    state.assignmentsReady = true\nend\n\nend -- roster and flex assignment are captured once per mechanic\n\nlocal fixedSpot = {\n    N = {x = 100.0, z = 89.5},\n    E = {x = 110.5, z = 100.0},\n    S = {x = 100.0, z = 110.5},\n    W = {x = 89.5, z = 100.0}\n}\n\nlocal drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, 0xFF0000FF, nil, 1.0, 0, 0\n)\n\nif TensorReactions_CurrentTimer < 415.2 then\n    local initialCardinal = state.finalCardinal[player.id]\n    if initialCardinal ~= nil then\n        local destination = fixedSpot[initialCardinal]\n        if destination ~= nil then\n            drawer:addLine(\n                player.pos.x, player.pos.y, player.pos.z,\n                destination.x, destination.y or 0.05, destination.z,\n                8.0, 2.0\n            )\n        end\n    end\nend\n\nif state.towersResolved ~= true then\n    if state.towerCount ~= 8 then return end\n    local outer = {N = {}, E = {}, S = {}, W = {}}\n    local inner = {}\n    local cardinals = {\"N\", \"E\", \"S\", \"W\"}\n    local axis = {N = {0,-1}, E = {1,0}, S = {0,1}, W = {-1,0}}\n    local function inside(t)\n        local x,z = t.x-100,t.z-100\n        return x*x+z*z < 64\n    end\n    local function lateral(t,c)\n        local a = axis[c]\n        return -(t.x-100)*a[2]+(t.z-100)*a[1]\n    end\n    local function distance(a,b)\n        return (a.x-b.x)^2+(a.z-b.z)^2\n    end\n    for _,t in pairs(state.towers) do\n        if inside(t) then\n            inner[#inner+1] = t\n        else\n            local x,z = t.x-100,t.z-100\n            local c\n            if math.abs(z)>=math.abs(x) then c=z<0 and \"N\" or \"S\"\n            else c=x>0 and \"E\" or \"W\" end\n            outer[c][#outer[c]+1]=t\n        end\n    end\n    -- Stable ordering makes equal geometric choices deterministic.\n    local function order(a,b)\n        if a.x ~= b.x then return a.x < b.x end\n        return a.z < b.z\n    end\n    table.sort(inner,order)\n    for _,c in ipairs(cardinals) do table.sort(outer[c],order) end\n    local assigned,used = {},{}\n    local first,second = state.meteorPlayers[1],state.meteorPlayers[2]\n    local c1,c2 = state.finalCardinal[first.id],state.finalCardinal[second.id]\n    if not ((c1==\"N\" and c2==\"S\") or (c1==\"S\" and c2==\"N\")) then return end\n    local bestA,bestB,bestCenters,bestDistance,bestPreference = nil,nil,-1,-1,-math.huge\n    for _,a in ipairs(outer[c1]) do\n        for _,b in ipairs(outer[c2]) do\n            -- Center means the OUTER cardinal tower, never an inner tower.\n            local centers = (math.abs(lateral(a,c1))<0.5 and 1 or 0)\n                +(math.abs(lateral(b,c2))<0.5 and 1 or 0)\n            local d=math.sqrt(distance(a,b))\n            -- Symmetric towers differ slightly in logged coordinates.\n            -- Within 0.1 yalm, leave the CCW tower for the non-meteor role.\n            local preference=lateral(a,c1)+lateral(b,c2)\n            if centers>bestCenters or (centers==bestCenters and\n                (d>bestDistance+0.1 or\n                    (math.abs(d-bestDistance)<=0.1 and preference>bestPreference))) then\n                bestA,bestB,bestCenters,bestDistance,bestPreference=a,b,centers,d,preference\n            end\n        end\n    end\n    if bestA==nil or bestB==nil then return end\n    assigned[first.id],assigned[second.id]=bestA,bestB\n    used[bestA],used[bestB]=true,true\n    local innerPlayers={}\n    for _,c in ipairs(cardinals) do\n        local other,meteorRole\n        for _,name in ipairs(state.slotOrder) do\n            local entry=state.slots[name]\n            if state.finalCardinal[entry.id]==c then\n                if entry.kind==state.meteorKind then meteorRole=entry else other=entry end\n            end\n        end\n        if other==nil or meteorRole==nil or #outer[c]<1 then return end\n        if #outer[c]==1 then\n            -- Every meteor-role player owns the outer tower in this case.\n            local t=outer[c][1]\n            if assigned[meteorRole.id]~=nil and assigned[meteorRole.id]~=t then return end\n            assigned[meteorRole.id]=t\n            used[t]=true\n            innerPlayers[#innerPlayers+1]={id=other.id,cardinal=c}\n        else\n            -- Reserve the middle OUTER tower for the meteor role, including\n            -- unmarked players who flexed east/west. Marked N/S choices above\n            -- remain authoritative. Without a middle, leave CCW to the other role.\n            if assigned[meteorRole.id]==nil then\n                for _,t in ipairs(outer[c]) do\n                    if not used[t] and math.abs(lateral(t,c))<0.5 then\n                        assigned[meteorRole.id]=t\n                        used[t]=true\n                        break\n                    end\n                end\n            end\n            -- Opposite-role player takes CCW among the unreserved outer towers.\n            local best\n            for _,t in ipairs(outer[c]) do\n                if not used[t] and (best==nil or lateral(t,c)<lateral(best,c)) then best=t end\n            end\n            if best==nil then return end\n            assigned[other.id]=best\n            used[best]=true\n            if assigned[meteorRole.id]==nil then\n                local remaining\n                for _,t in ipairs(outer[c]) do\n                    if not used[t] then remaining=t break end\n                end\n                if remaining==nil then return end\n                assigned[meteorRole.id]=remaining\n                used[remaining]=true\n            end\n        end\n    end\n    if #innerPlayers~=#inner then return end\n    -- Match all inner players together. Maximize fulfilled immediate-CW\n    -- claims before choosing the shortest remaining clockwise rotations.\n    local picks,bestPicks={},nil\n    local bestClaims,bestTravel=-1,math.huge\n    local function search(i,claims,travel)\n        if i>#innerPlayers then\n            if claims>bestClaims or (claims==bestClaims and travel<bestTravel) then\n                bestClaims,bestTravel=claims,travel\n                bestPicks={}\n                for k,t in ipairs(picks) do bestPicks[k]=t end\n            end\n            return\n        end\n        local a=axis[innerPlayers[i].cardinal]\n        for _,t in ipairs(inner) do\n            if not used[t] then\n                local x,z=t.x-100,t.z-100\n                local forward=x*a[1]+z*a[2]\n                local side=-x*a[2]+z*a[1]\n                local angle=math.atan2(side,forward)\n                if angle<0 then angle=angle+2*math.pi end\n                local claim=(forward>0.5 and side>0.5) and 1 or 0\n                picks[i]=t\n                used[t]=true\n                search(i+1,claims+claim,travel+angle)\n                used[t]=nil\n                picks[i]=nil\n            end\n        end\n    end\n    search(1,0,0)\n    if bestPicks==nil then return end\n    for i,entry in ipairs(innerPlayers) do assigned[entry.id]=bestPicks[i] end\n    -- Publish only a complete, unique assignment satisfying role rules.\n    local check={}\n    for _,name in ipairs(state.slotOrder) do\n        local entry=state.slots[name]\n        local t=assigned[entry.id]\n        if t==nil or check[t] then return end\n        check[t]=true\n        if entry.kind==state.meteorKind and inside(t) then return end\n        if entry.kind~=state.meteorKind and #outer[state.finalCardinal[entry.id]]==1\n            and not inside(t) then return end\n    end\n    state.quadrants=outer\n    state.towerByID=assigned\n    state.towersResolved=true\nend\nself.used=true\n",
							name = "Draw Hiemal Meteor Prey and Tower Tethers",
							uuid = "39ad4dc3-6862-3c3a-bd6c-d63a1c7af231",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 417.4,
				name = "[Draw] Hiemal Meteor Role Tethers",
				timeRange = true,
				timelineIndex = 71,
				timerEndOffset = 4.1900000572205,
				timerStartOffset = -12,
				uuid = "7b4a11b0-76e6-6cbe-8c69-aaf2050b2095",
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
							actionLua = "local state = data.sam_hiemal_meteor\nif state == nil then\n    state = {\n        marked = {},\n        markerCount = 0,\n        towers = {},\n        towerCount = 0,\n        assignmentsReady = false,\n        towersResolved = false\n    }\n    data.sam_hiemal_meteor = state\nend\n\nstate.towers = state.towers or {}\nstate.towerCount = state.towerCount or 0\n\nlocal validTower =\n    eventArgs ~= nil and eventArgs.aoeID == 29564 and eventArgs.contentID == 3640\n\nif not validTower\n    or eventArgs.entityID == nil\n    or eventArgs.x == nil\n    or eventArgs.y == nil\n    or eventArgs.z == nil then\n    self.used = true\n    return\nend\n\nif state.towerCount >= 8 then\n    self.used = true\n    return\nend\n\nif state.towers[eventArgs.entityID] == nil then\n    state.towers[eventArgs.entityID] = {\n        x = eventArgs.x,\n        y = eventArgs.y,\n        z = eventArgs.z\n    }\n    state.towerCount = state.towerCount + 1\nend\nself.used = true\n",
							name = "Capture Hiemal Conviction Towers",
							uuid = "331d74c4-d4cc-0ba3-9c3d-d2521a082be0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 18,
				loop = true,
				mechanicTime = 417.4,
				name = "[Draw] Hiemal Meteor Tower Capture",
				timeRange = true,
				timelineIndex = 71,
				timerStartOffset = -12,
				uuid = "4dde1532-92e5-0a36-94a9-9e9d4c181757",
				version = 2,
			},
		},
	},
	[72] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local state = data.sam_hiemal_meteor\nif state == nil\n    or state.marked == nil\n    or state.markerCount < 2\n    or state.slots == nil\n    or state.slotOrder == nil\n    or state.initialCardinal == nil\n    or state.finalCardinal == nil\n    or state.meteorKind == nil then\n    self.used = true\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    self.used = true\n    return\nend\n\nlocal playerKind = nil\nfor _, slotName in ipairs(state.slotOrder) do\n    local slot = state.slots[slotName]\n    if slot ~= nil and slot.id == player.id then\n        playerKind = slot.kind\n        break\n    end\nend\n\nlocal target = nil\nlocal isMeteor = state.marked[player.id] == true\nlocal resolvedCardinal = state.finalCardinal[player.id]\nlocal startingCardinal = state.initialCardinal[player.id]\n\n-- Final Conviction tower positions from the live replay.\nlocal finalTower = {\n    N = {x = 100.000, z = 82.000},\n    NE = {x = 112.728, z = 87.272},\n    E = {x = 118.000, z = 100.000},\n    SE = {x = 112.728, z = 112.728},\n    S = {x = 100.000, z = 118.000},\n    SW = {x = 87.272, z = 112.728},\n    W = {x = 82.000, z = 100.000},\n    NW = {x = 87.272, z = 87.272}\n}\n\nif playerKind == state.meteorKind then\n    if isMeteor then\n        -- Marked meteor players finish at the opposite fixed cardinal.\n        if resolvedCardinal == \"N\" then\n            target = finalTower.S\n        elseif resolvedCardinal == \"S\" then\n            target = finalTower.N\n        end\n    else\n        -- Same-role nonmeteors remain on their resolved E/W cardinal.\n        if resolvedCardinal == \"E\" then\n            target = finalTower.E\n        elseif resolvedCardinal == \"W\" then\n            target = finalTower.W\n        end\n    end\nelse\n    -- Nonmeteor role returns to its starting quadrant and moves one tower CW.\n    if startingCardinal == \"N\" then\n        target = finalTower.NE\n    elseif startingCardinal == \"E\" then\n        target = finalTower.SE\n    elseif startingCardinal == \"S\" then\n        target = finalTower.SW\n    elseif startingCardinal == \"W\" then\n        target = finalTower.NW\n    end\nend\n\nif target == nil then\n    self.used = true\n    return\nend\n\nif state.finalDrawer == nil then\n    state.finalDrawer = TensorCore.getCachedFlatDrawer(nil, nil, 0xFF0000FF, nil, 1.0, 0, 0)\nend\n\nstate.finalDrawer:addLine(\n    player.pos.x, player.pos.y, player.pos.z,\n    target.x, 0.05, target.z,\n    8.0, 2.0\n)\n\nself.used = true\n",
							name = "Draw Hiemal Final Conviction Tower Tether",
							uuid = "afccbb03-a120-6920-89e8-74c717b33426",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 421.6,
				name = "[Draw] Hiemal Final Conviction Tower Tether",
				timeRange = true,
				timelineIndex = 72,
				timerEndOffset = 13.1,
				uuid = "1c044c55-6bb8-9ccd-a337-8f72be56725b",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local old = data.frog_dfg_v2\nlocal s = {line=old and old.line or {}, positions={}, jump={}, side={}, placement={}, planned={}, towers={{},{},{}}, placed={}, resolved={0,0,0}, towerByCaster={}, resolvedCasters={{},{},{}}, stacks=0, geirLocked={}, ready=false}\ndata.frog_dfg_v2 = s\nlocal boss = TensorCore.mGetEntity(eventArgs.entityID)\nif not boss or not boss.pos or not boss.hitradius or boss.hitradius <= 0 then self.used=true return end\ns.bossID=boss.id\ns.center={x=boss.pos.x,y=boss.pos.y,z=boss.pos.z}\ns.radius=boss.hitradius\ns.drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\nlocal party=TensorCore.getEntityGroupList(\"Party\")\nfor _,e in pairs(party or {}) do\n    s.positions[e.id]={x=e.pos.x,y=e.pos.y,z=e.pos.z}\nend\nfunction s.assign()\n    if s.ready then return end\n    local counts={0,0,0}\n    local highs={true,true,true}\n    for id,p in pairs(s.positions) do\n        local line=s.line[id]\n        if not line then return end\n        local e=TensorCore.mGetEntity(id)\n        if not e then return end\n        if not s.jump[id] then\n            if TensorCore.hasBuff(e,2755) then s.jump[id]=1\n            elseif TensorCore.hasBuff(e,2756) then s.jump[id]=2\n            elseif TensorCore.hasBuff(e,2757) then s.jump[id]=3 end\n        end\n        if not s.jump[id] then return end\n        counts[line]=counts[line]+1\n        if s.jump[id]~=1 then highs[line]=false end\n    end\n    if counts[1]~=3 or counts[2]~=2 or counts[3]~=3 then return end\n    local westSecond\n    for id,p in pairs(s.positions) do\n        if s.line[id]==2 and (not westSecond or p.x<s.positions[westSecond].x or (p.x==s.positions[westSecond].x and id<westSecond)) then westSecond=id end\n    end\n    for id,p in pairs(s.positions) do\n        local line,jump=s.line[id],s.jump[id]\n        local side\n        if not highs[line] then side=jump==1 and \"S\" or jump==2 and \"E\" or \"W\"\n        elseif line==2 then side=id==westSecond and \"W\" or \"E\"\n        else\n            local dx,dz=p.x-s.center.x,p.z-s.center.z\n            if -dx>=dz and dx<=0 then side=\"W\" elseif dx>=dz then side=\"E\" else side=\"S\" end\n        end\n        s.side[id]=side\n        local r=s.radius\n        local x,z=s.center.x,s.center.z\n        if line==2 then\n            local q=(r+1)/math.sqrt(2)\n            x=x+(side==\"W\" and -q or q); z=z-q\n        elseif side==\"W\" then x=x-r elseif side==\"E\" then x=x+r else z=z+r end\n        -- Keep the player's placement on the edge; project the tower separately.\n        local tx=x\n        if jump==2 then\n            tx=x-14\n        elseif jump==3 then\n            tx=x+14\n        end\n        s.placement[id]={x=x,y=s.center.y+0.05,z=z}\n        s.planned[id]={x=tx,y=s.center.y+0.05,z=z}\n    end\n    s.ready=true\nend\nfunction s.tower(wave,side)\n    local best,score,owner\n    -- Captured jump positions supersede assignment predictions.\n    for id,p in pairs(s.planned) do\n        if s.line[id]==wave then\n            local t=s.towers[wave][id] or p\n            local v=side==\"W\" and -t.x or side==\"E\" and t.x or t.z\n            if not best or v>score then best,score,owner=t,v,id end\n        end\n    end\n    return best,owner\nend\nfunction s.guide(id)\n    local line,side=s.line[id],s.side[id]\n    if not s.ready or not line or not side then return nil end\n    if line==1 then\n        if not s.placed[id] then return s.placement[id],\"place1\" end\n        if side==\"S\" then\n            if s.stacks<2 then return nil,\"stack\" end\n            if s.resolved[3]<3 then return s.tower(3,\"S\"),\"soak3\" end\n        else\n            -- Wait at the stack until BOTH second-in-line jumps have landed.\n            -- Arrow jumps can reverse which player owns the west/east tower.\n            for other,wave in pairs(s.line) do\n                if wave==2 and not s.placed[other] then return nil,\"stack\" end\n            end\n            local tower,owner=s.tower(2,side)\n            if not owner then return nil,\"stack\" end\n            -- Stay to soak and bait; leave when this tower clone locks Geirskogul.\n            if not s.geirLocked[owner] then return tower,\"soak2\" end\n            if s.stacks<2 then return nil,\"stack\" end\n        end\n    elseif line==2 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if not s.placed[id] then return s.placement[id],\"place2\" end\n        if s.stacks<2 then return nil,\"stack\" end\n        if s.resolved[3]<3 then return s.tower(3,side),\"soak3\" end\n    elseif line==3 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if s.resolved[1]<3 then return s.tower(1,side),\"soak1\" end\n        if not s.placed[id] then return s.placement[id],\"place3\" end\n    end\n    return nil,\"done\"\nend\ns.assign()\nself.used=true",
							conditions = 
							{
								
								{
									"1e7514aa-4db5-b043-87a1-d5922935a28e",
									true,
								},
								
								{
									"f009e45f-b579-24c5-bc06-ab68944a4318",
									true,
								},
							},
							name = "Capture line and jump data",
							uuid = "ffd000f3-9fda-1062-951e-46b201c8de7f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26381,
							name = "Dive from Grace",
							uuid = "1e7514aa-4db5-b043-87a1-d5922935a28e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg caster",
							uuid = "f009e45f-b579-24c5-bc06-ab68944a4318",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Assignment Capture",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 10,
				timerStartOffset = -5.5,
				uuid = "c708edb7-f258-bd67-9977-5fcf2ab1e915",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s then s={line={}};data.frog_dfg_v2=s end\ns.line[eventArgs.entityID]=eventArgs.markerID-318\nself.used=true",
							conditions = 
							{
								
								{
									"9f523295-56ad-7eae-ad77-2106604b6faa",
									true,
								},
							},
							name = "Capture line marker",
							uuid = "d44b87df-2a14-5d62-a69f-93c7a0665ce3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								319,
								320,
								321,
							},
							name = "Line markers",
							uuid = "9f523295-56ad-7eae-ad77-2106604b6faa",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Line Capture",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "4d909d44-c452-90d7-a3d2-ee3f27e7a0e0",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s or not s.ready then self.used=true return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then self.used=true return end\nlocal target,stage=s.guide(p.id)\ns.stage=stage\nif stage==\"stack\" then\n    local boss=TensorCore.mGetEntity(s.bossID)\n    if boss and boss.pos and boss.hitradius then\n        local x,y,z=TensorCore.getPosInDirection(boss.pos,boss.pos.h,boss.hitradius,true)\n        s.drawer:addLine(p.pos.x,p.pos.y,p.pos.z,x,y+0.05,z,8,1.5)\n    end\nelseif target then\n    s.drawer:addLine(p.pos.x,p.pos.y,p.pos.z,target.x,target.y,target.z,8,1.5)\nend\nself.used=true",
							name = "Draw Dive from Grace tethers",
							uuid = "b57244ee-2638-f2e6-beb6-b111e99a6293",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Position Tethers",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 64,
				uuid = "81068bea-b927-c7fc-b131-d9a7c4c8b548",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s then self.used=true return end\nlocal ref=s.towerByCaster[eventArgs.entityID]\nif ref and not s.resolvedCasters[ref.wave][eventArgs.entityID] then\n    s.resolvedCasters[ref.wave][eventArgs.entityID]=true\n    s.resolved[ref.wave]=s.resolved[ref.wave]+1\nend\nself.used=true",
							conditions = 
							{
								
								{
									"d819b5ec-0d81-f69e-9499-2725a6409a32",
									true,
								},
								
								{
									"b923c2fc-0c50-5dac-903f-9a2507793b65",
									true,
								},
							},
							name = "Capture Darkdragon tower waves",
							uuid = "f43efe36-85a4-c932-b247-45bee69b1117",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26385,
							name = "Darkdragon Dive",
							uuid = "d819b5ec-0d81-f69e-9499-2725a6409a32",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg caster",
							uuid = "b923c2fc-0c50-5dac-903f-9a2507793b65",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Tower Resolution",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 64,
				uuid = "c6c40ffd-c8d2-8c1f-aed4-027d0ed4b613",
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
							actionLua = "local s=data.frog_dfg_v2\nif s and (not s.lastStack or Now()-s.lastStack>1000) then s.stacks=math.min(2,s.stacks+1);s.lastStack=Now() end\nself.used=true",
							conditions = 
							{
								
								{
									"cfb478be-9789-ae75-be28-aa39084b38f6",
									true,
								},
								
								{
									"0c7926a3-d0f9-50b9-b7ed-5bae7c19b87f",
									true,
								},
							},
							name = "Mark first stack resolved",
							uuid = "176e2b01-a767-a8f6-8f5d-ec50bf681a60",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26388,
							name = "Eye of the Tyrant",
							uuid = "cfb478be-9789-ae75-be28-aa39084b38f6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg caster",
							uuid = "0c7926a3-d0f9-50b9-b7ed-5bae7c19b87f",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Stack Progress",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 64,
				uuid = "1e7ab052-7891-d371-b577-c86ff1e7d1e3",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s then self.used=true return end\nlocal id=eventArgs.targetID\nlocal wave=s.line[id]\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not wave or not e or not e.pos then self.used=true return end\nif s.placed[id] then self.used=true return end\nlocal x,y,z=e.pos.x,e.pos.y,e.pos.z\nif eventArgs.spellID~=26382 then\n    -- The clone's reported heading already includes Elusive's reversal.\n    x,y,z=TensorCore.getPosInDirection(e.pos,eventArgs.heading,14,true)\nend\nlocal t={x=x,y=y+0.05,z=z}\ns.towers[wave][id]=t\ns.towerByCaster[eventArgs.entityID]={wave=wave,id=id}\ns.placed[id]=true\nself.used=true",
							conditions = 
							{
								
								{
									"8d2b34e1-01b2-de19-925e-bd50b09ef266",
									true,
								},
								
								{
									"1be7f415-ec1b-bd86-9378-a631df0112ce",
									true,
								},
							},
							name = "Capture jump landing",
							uuid = "3d1eca0e-c0d9-540e-88d1-0264cd76f68a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Jump placement",
							spellIDList = 
							{
								26382,
								26383,
								26384,
							},
							uuid = "8d2b34e1-01b2-de19-925e-bd50b09ef266",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg",
							uuid = "1be7f415-ec1b-bd86-9378-a631df0112ce",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Jump Placement",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 45,
				uuid = "974cf95f-d81a-6279-aaaa-af1c942f23fc",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s then self.used=true return end\nlocal ref=s.towerByCaster[eventArgs.entityID]\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif ref and e and e.pos then\n    local t=s.towers[ref.wave][ref.id]\n    t.x=e.pos.x; t.y=e.pos.y+0.05; t.z=e.pos.z\nend\nself.used=true",
							conditions = 
							{
								
								{
									"e9a70d95-dcf1-1735-bd95-efccb2f5ed70",
									true,
								},
								
								{
									"1a6178c6-6976-e584-b31e-f340057f47a5",
									true,
								},
							},
							name = "Confirm tower position",
							uuid = "d364514d-9de4-dcec-a47e-88f781642cf6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26385,
							name = "Darkdragon Dive",
							uuid = "e9a70d95-dcf1-1735-bd95-efccb2f5ed70",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg",
							uuid = "1a6178c6-6976-e584-b31e-f340057f47a5",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Tower Position",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 45,
				uuid = "dd27fdd3-0fed-785a-b9fd-1c8be4469367",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s or not s.assign then return end\ns.assign()\nif s.ready then self.used=true end",
							name = "Wait for all jump assignments",
							uuid = "2424fbc4-6268-ed0b-9881-7035e521bf63",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Assignment Finalize",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 9,
				uuid = "adc30783-8745-cb47-94de-1259493b940b",
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
							actionLua = "local p=TensorCore.mGetPlayer()\nlocal buff=TensorCore.getBuff(p,2755) or TensorCore.getBuff(p,2756) or TensorCore.getBuff(p,2757)\nif not buff then return end\nlocal arrow=TensorCore.hasAnyBuff(p,2756,2757)\ndata.frog_dfg_control={expires=Now()+buff.duration*1000,arrow=arrow,active=true}\nif arrow then\n    TensorCore.API.TensorACR.setLockFaceHeading(-math.pi/2)\n    TensorCore.API.TensorACR.toggleLockFace(true)\nend\nself.used=true",
							conditions = 
							{
								
								{
									"e0cd7562-14e4-5b79-b3a4-e6c4a92937ca",
									true,
								},
							},
							name = "Set west facing and snapshot deadline",
							uuid = "a25eea1f-24d7-6d85-be0c-0b8306ebbfc1",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"4323bed3-2a75-8a4f-9f85-e18c9b46cb4b",
									true,
								},
							},
							name = "Stop All Actions",
							stopAllActions = true,
							uuid = "b33e373c-b862-aed6-8e08-e282c8499602",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Misc",
							conditions = 
							{
								
								{
									"e8384e73-48b3-1fc0-9939-71b1e6a3e4b6",
									true,
								},
							},
							name = "Resume All Actions",
							resumeAllActions = true,
							uuid = "6946d2c6-c9f5-17a9-b24e-67faef71a428",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local c=data.frog_dfg_control\nif c then\n    if c.arrow then TensorCore.API.TensorACR.toggleLockFace(false) end\n    c.active=false\nend\nself.used=true",
							conditions = 
							{
								
								{
									"7f000f46-8cb1-a1b7-bd89-347e0c53852e",
									true,
								},
							},
							endIfUsed = true,
							name = "Release our facing lock",
							uuid = "de5d8b18-09c5-58e7-aa26-80b8c5d7f89f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							buffCheckType = 7,
							buffDuration = 1,
							buffIDList = 
							{
								2755,
								2756,
								2757,
							},
							category = "Self",
							comparator = 2,
							matchAnyBuff = true,
							name = "Jump expires <=1s",
							uuid = "e0cd7562-14e4-5b79-b3a4-e6c4a92937ca",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local c=data.frog_dfg_control\nif not c or not c.active then return false end\nlocal now=Now()\nif now<c.expires-500 or now>=c.expires then return false end\nif not c.arrow then return true end\nlocal p=TensorCore.mGetPlayer()\nreturn p and p.pos and math.abs(math.sin(p.pos.h+math.pi/2))<0.05 and math.cos(p.pos.h+math.pi/2)>0",
							name = "Snapshot -0.5s",
							uuid = "4323bed3-2a75-8a4f-9f85-e18c9b46cb4b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local c=data.frog_dfg_control\nreturn c and c.active and Now()>=c.expires+500",
							name = "Snapshot +0.5s",
							uuid = "e8384e73-48b3-1fc0-9939-71b1e6a3e4b6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							actionUUID = "6946d2c6-c9f5-17a9-b24e-67faef71a428",
							category = "Action",
							name = "Resume issued",
							uuid = "7f000f46-8cb1-a1b7-bd89-347e0c53852e",
							version = 3,
						},
					},
				},
				mechanicTime = 620.5,
				name = "[Opti] Dive from Grace Snapshot Hold",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 45,
				uuid = "362531aa-cbc3-b009-9773-ab1c5be72412",
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
							actionLua = "local old=eventArgs.oldData\nlocal c=old and old.frog_dfg_control\nif c and c.active then\n    if c.arrow then TensorCore.API.TensorACR.toggleLockFace(false) end\n    c.active=false\nend\nself.used=true",
							name = "Release only our facing lock",
							uuid = "78ee9bfe-8d20-0d29-a89d-aea7c8482de1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 9,
				loop = true,
				mechanicTime = 620.5,
				name = "[Opti] Dive from Grace Wipe Cleanup",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 1000,
				timerStartOffset = -620.5,
				uuid = "18c6f631-d6fa-4bec-a7c8-e063bbba23a9",
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
							actionLua = "local old=data\nlocal c=old and old.frog_dfg_control\nif c and c.active then\n    if c.arrow then TensorCore.API.TensorACR.toggleLockFace(false) end\n    c.active=false\nend\nself.used=true",
							name = "Release only our facing lock",
							uuid = "f0edca16-29a5-48b1-aabb-ca32e528b217",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 10,
				loop = true,
				mechanicTime = 620.5,
				name = "[Opti] Dive from Grace Death Cleanup",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 1000,
				timerStartOffset = -620.5,
				uuid = "9917af74-94dd-c335-911b-a6795904b839",
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
							actionLua = "local s=data.frog_dfg_v2\nif s then\n    local ref=s.towerByCaster[eventArgs.entityID]\n    if ref and ref.wave==2 then\n        s.geirLocked=s.geirLocked or {}\n        s.geirLocked[ref.id]=true\n    end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"127d5a27-6848-f92e-a8a2-1399b7cc6a4d",
									true,
								},
								
								{
									"c23b76d4-bd05-52cb-97d6-ac19e282887e",
									true,
								},
							},
							name = "Capture second-wave Geirskogul lock",
							uuid = "10602660-b9e9-d7bf-9039-81a1523c96bf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26378,
							name = "Geirskogul",
							uuid = "127d5a27-6848-f92e-a8a2-1399b7cc6a4d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3458,
							name = "Nidhogg",
							uuid = "c23b76d4-bd05-52cb-97d6-ac19e282887e",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 620.5,
				name = "[Draw] Dive from Grace Geirskogul Lock",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 45,
				uuid = "33f648c5-9c49-bafd-98a7-f5289c248869",
				version = 2,
			},
		},
	},
	[127] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_eyes_v1=data.frog_eyes_v1 or {}\nlocal s=data.frog_eyes_v1\ns.soulTime=TensorReactions_CurrentTimer\nself.used=true",
							conditions = 
							{
								
								{
									"2485b2fc-3f6a-55e5-9678-7f1cb60cebc6",
									true,
								},
							},
							name = "Soul clock",
							uuid = "6fa6f3e4-6cfb-3dd8-8d8b-bd5a1c27bc9f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_eyes_v1=data.frog_eyes_v1 or {}\ndata.frog_eyes_v1.hatebound=true\nself.used=true",
							conditions = 
							{
								
								{
									"6bf9b6ea-aafc-2379-8f22-28fb519abfa5",
									true,
								},
							},
							name = "Hatebound",
							uuid = "951833fd-574c-c362-a834-e00a8d1ed4ea",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_eyes_v1=data.frog_eyes_v1 or {}\nlocal s=data.frog_eyes_v1\ns.yellow=s.yellow or {}\nfor _,id in ipairs(eventArgs.hitTargets) do s.yellow[id]=true end\nself.used=true",
							conditions = 
							{
								
								{
									"3c87a8c6-b7a8-175f-ad90-9fb36eea2223",
									true,
								},
							},
							name = "Yellow soak",
							uuid = "049541ce-c680-39d0-a49b-de56dfc6d734",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_eyes_v1=data.frog_eyes_v1 or {}\nlocal s=data.frog_eyes_v1\ns.blue=s.blue or {}\nfor _,id in ipairs(eventArgs.hitTargets) do s.blue[id]=true end\nself.used=true",
							conditions = 
							{
								
								{
									"35801e99-9d48-3ed0-96f4-c3a6c3f35ee1",
									true,
								},
							},
							name = "Blue soak",
							uuid = "2b1e21ba-7063-2370-b608-47788becd7a8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_eyes_v1=data.frog_eyes_v1 or {}\nlocal s=data.frog_eyes_v1\ns.waves=s.waves or {}\ns.wave=s.wave or 0\nlocal t=TensorReactions_CurrentTimer\nlocal id=eventArgs.targetID\nlocal target=TensorCore.mGetEntity(id)\nlocal pos=target and target.pos\nif not pos then return end\nlocal w=s.waves[s.wave]\nif not w or t-w.time>2 then\n    if s.wave>=4 then self.used=true return end\n    s.wave=s.wave+1\n    w={time=t}\n    s.waves[s.wave]=w\nend\nfor _,hit in ipairs(w) do if hit.id==id then self.used=true return end end\nif #w<2 then w[#w+1]={id=id,x=pos.x,z=pos.z} end\nself.used=true",
							conditions = 
							{
								
								{
									"63a3ec4c-e62a-d6f8-9abc-b200e77c3c85",
									true,
								},
							},
							name = "Mirage hit pair",
							uuid = "020c8e5e-aa51-b12c-a24e-2e511e711210",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26821,
							name = "Soul clock",
							uuid = "2485b2fc-3f6a-55e5-9678-7f1cb60cebc6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26814,
							name = "Hatebound",
							uuid = "6bf9b6ea-aafc-2379-8f22-28fb519abfa5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26817,
							name = "Yellow soak",
							uuid = "3c87a8c6-b7a8-175f-ad90-9fb36eea2223",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26815,
							name = "Blue soak",
							uuid = "35801e99-9d48-3ed0-96f4-c3a6c3f35ee1",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 26820,
							name = "Mirage hit pair",
							uuid = "63a3ec4c-e62a-d6f8-9abc-b200e77c3c85",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 757,
				name = "[Draw] Eyes Event Capture",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -2,
				uuid = "bd16ae3f-b6f4-5775-b1b9-49bf1e3eafd2",
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
							actionLua = "local t = TensorReactions_CurrentTimer\nlocal s = data.frog_eyes_v1\nif s == nil or (s.lastTime and t < s.lastTime - 1) then\n    s = {}\n    data.frog_eyes_v1 = s\nend\ns.lastTime = t\nif not s.initialized then\n    s.initialized = true\n    s.yellow = s.yellow or {}\n    s.blue = s.blue or {}\n    s.waves = s.waves or {}\n    s.wave = s.wave or 0\n    s.solvedWave = 0\n    s.slots = {}\n    s.roleByID = {}\n    s.station = {}\n    s.pairs = {}\n    s.roleOrder = {\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n    s.rosterNames = {MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}\n    s.partner = {MT=\"H1\",OT=\"H2\",M1=\"R1\",M2=\"R2\",H1=\"MT\",H2=\"OT\",R1=\"M1\",R2=\"M2\"}\n    s.leftQuery = {contentid=11317}\n    s.rightQuery = {contentid=11318}\n    function s.resolveRoster()\n        local members = AnyoneCore.Roster.members()\n        local party = AnyoneCore.API.getAgnosticPartyList()\n        if type(members) ~= \"table\" or type(party) ~= \"table\" then return false end\n        local byName,byJob,counts,rcounts = {},{},{},{}\n        for _,a in pairs(party) do\n            if a.id and a.name and a.job then\n                byName[a.name..\"\\31\"..a.job]=a\n                byJob[a.job]=a\n                counts[a.job]=(counts[a.job] or 0)+1\n            end\n        end\n        for _,m in pairs(members) do\n            if m.job then rcounts[m.job]=(rcounts[m.job] or 0)+1 end\n        end\n        local seen={}\n        for _,role in ipairs(s.roleOrder) do\n            local m=members[s.rosterNames[role]]\n            if not m or not m.name or not m.job then return false end\n            local a=byName[m.name..\"\\31\"..m.job]\n            if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n            if not a or seen[a.id] then return false end\n            seen[a.id]=true\n            s.slots[role]=a.id\n            s.roleByID[a.id]=role\n        end\n        return true\n    end\n    function s.point(x,z,label)\n        s.targetID=nil\n        s.x,s.z,s.label=x,z,label\n    end\n    function s.person(id,label)\n        s.x,s.z=nil,nil\n        s.targetID,s.label=id,label\n    end\n    -- Begin at the north boundary of the NW quadrant, not its diagonal.\n    -- CCW order: NW, SW, SE, NE. Reverse order serves group 2.\n    function s.rank(a,b,cx,cz)\n        local aa=( -math.atan2(a.x-cx,-(a.z-cz)))%(2*math.pi)\n        local bb=( -math.atan2(b.x-cx,-(b.z-cz)))%(2*math.pi)\n        if aa<bb or (aa==bb and a.id<b.id) then return a,b end\n        return b,a\n    end\nend\ns.x,s.z,s.targetID,s.label=nil,nil,nil,nil\ns.callout=nil\nif not s.rosterReady then\n    if s.rosterRetry and t<s.rosterRetry then self.used=true return end\n    s.rosterRetry=t+1\n    s.rosterReady=s.resolveRoster()\n    if not s.rosterReady then s.reason=\"Roster unresolved\"; self.used=true return end\nend\nlocal player=TensorCore.mGetPlayer()\nif not player or not player.pos then self.used=true return end\nlocal role=s.roleByID[player.id]\nif not role then s.reason=\"Self absent from roster\"; self.used=true return end\ns.myRole=role\nlocal left=s.leftID and TensorCore.mGetEntity(s.leftID) or TensorCore.getEntityByGroup(\"ContentID\",s.leftQuery)\nlocal right=s.rightID and TensorCore.mGetEntity(s.rightID) or TensorCore.getEntityByGroup(\"ContentID\",s.rightQuery)\nif not left or not right or not left.pos or not right.pos then\n    s.reason=\"Waiting for eyes\"; self.used=true return\nend\ns.leftID,s.rightID=left.id,right.id\nlocal tank=role==\"MT\" or role==\"OT\"\nlocal melee=role==\"M1\" or role==\"M2\"\nlocal yellowRole=tank or melee\nlocal support=tank or role==\"H1\" or role==\"H2\"\nlocal eye=support and left or right\nlocal north=role==\"H1\" or role==\"R1\"\nlocal sign=north and -1 or 1\nlocal buddy=s.slots[s.partner[role]]\nlocal red=TensorCore.hasBuff(player,2775)\nlocal blue=TensorCore.hasBuff(player,2776)\nlocal clock=t-(s.soulTime or 756.9)\ns.reason=nil\n\n-- Resolve each complete hit pair once; actual hit positions decide priority.\nwhile s.solvedWave < s.wave do\n    local n=s.solvedWave+1\n    local w=s.waves[n]\n    if not w or #w<2 then break end\n    local ccw,cw=s.rank(w[1],w[2],right.pos.x,right.pos.z)\n    if n==1 then s.firstPair={ccw.id,cw.id} end\n    s.pairs={}\n    if n<4 then\n        local takers\n        if n==1 then takers={s.slots.MT,s.slots.OT}\n        elseif n==2 then takers={s.slots.M1,s.slots.M2}\n        else takers=s.firstPair end\n        if takers and takers[1] and takers[2] then\n            s.pairs[1]={giver=ccw.id,taker=takers[1],x=ccw.x,z=ccw.z}\n            s.pairs[2]={giver=cw.id,taker=takers[2],x=cw.x,z=cw.z}\n        end\n    end\n    s.solvedWave=n\nend\n\nif s.wave>0 then\n    if s.solvedWave>=4 then s.label=\"Eyes complete\"; self.used=true return end\n    for _,pair in ipairs(s.pairs) do\n        if not pair.done then\n            if TensorCore.hasBuff(pair.taker,2775) and TensorCore.hasBuff(pair.giver,2776) then\n                pair.done=true\n                s.station[pair.taker]={x=pair.x,z=pair.z}\n                s.station[pair.giver]=nil\n            end\n        end\n        if not pair.done and (player.id==pair.giver or player.id==pair.taker) then\n            s.person(player.id==pair.giver and pair.taker or pair.giver,\"Mirage handoff\")\n            self.used=true return\n        end\n    end\n    -- Red holders spread freely; only blue holders return to the centre.\n    if blue and not red then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    self.used=true return\nend\n\n-- Latch orb resolution from the damage debuff as well as cast hitTargets.\n-- Both orb types apply 2902; the assigned role identifies which orb was soaked.\nif yellowRole then\n    if not s.yellow[player.id] and TensorCore.hasBuff(player,2902) then s.yellow[player.id]=true end\n    if not s.blue[buddy] and TensorCore.hasBuff(buddy,2902) then s.blue[buddy]=true end\nelse\n    if not s.yellow[buddy] and TensorCore.hasBuff(buddy,2902) then s.yellow[buddy]=true end\n    if not s.blue[player.id] and TensorCore.hasBuff(player,2902) then s.blue[player.id]=true end\nend\n-- Initial colour sorting is a one-way stage, never re-entered after a handoff.\nif (yellowRole and red) or (not yellowRole and blue)\n    or s.yellow[player.id] or s.yellow[buddy] or s.blue[player.id] or s.blue[buddy] then\n    s.initialSettled=true\nend\n\nlocal myYellow = yellowRole and s.yellow[player.id] or s.yellow[buddy]\nlocal myBlue = yellowRole and s.blue[buddy] or s.blue[player.id]\n-- Outgoing yellow-orb players finish their handoff on their own Fangbound.\n-- Do not wait for the receiver's status update or blue-orb soak.\nif yellowRole and (myYellow or myBlue) then\n    if blue then s.orbHandoffComplete=true end\n    if not s.orbHandoffComplete then\n        s.person(buddy,\"Pass Clawbound\")\n    elseif not tank or left.hp.percent<=45 then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    self.used=true return\nend\nif myBlue then\n    if tank and left.hp.percent>45 then\n        s.point(left.pos.x,left.pos.z,\"Left eye until 45%\")\n    elseif yellowRole then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    -- Outer Mirage waiting positions are intentionally not tethered.\nelseif myYellow then\n    local giver=yellowRole and player.id or buddy\n    local receiver=yellowRole and buddy or player.id\n    local exchanged=TensorCore.hasBuff(giver,2776) and TensorCore.hasBuff(receiver,2775)\n    if not exchanged then\n        s.person(buddy,\"Pass Clawbound\")\n    elseif not yellowRole and clock>=28 then\n        s.point(eye.pos.x,eye.pos.z+sign*7,\"Blue orb\")\n        s.callout=\"POP NOW\"\n    elseif yellowRole then\n        s.point(eye.pos.x,eye.pos.z,\"Wait for blue orb\")\n    else\n        s.point(eye.pos.x,eye.pos.z+sign*eye.hitradius,\"Wait for blue orb\")\n    end\nelse\n    if not s.initialSettled and (s.hatebound or red or blue) and ((yellowRole and blue) or (not yellowRole and red)) then\n        s.point(100,100,\"Initial color swap\")\n    elseif yellowRole and clock>=22 and red then\n        s.point(eye.pos.x+(support and 7 or -7),eye.pos.z,\"Yellow orb\")\n        s.callout=\"SOAK NOW\"\n    elseif yellowRole then\n        s.point(eye.pos.x,eye.pos.z,\"Initial waiting spot\")\n    else\n        s.point(eye.pos.x,eye.pos.z+sign*eye.hitradius,\"Initial waiting spot\")\n    end\nend\nself.used=true\n",
							name = "Resolve Eyes Guidance",
							uuid = "67e73330-b675-dafe-acdd-ddbc00d369ea",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 757,
				name = "[Draw] Eyes Role Solver",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -2,
				uuid = "6fb85a95-9d48-9616-9a9d-578f6b6962fe",
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
							actionLua = "local s=data.frog_eyes_v1\nif not s or not s.initialized then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then return end\nlocal x,z=s.x,s.z\nlocal y=0.05\nif s.targetID then\n    local target=TensorCore.mGetEntity(s.targetID)\n    if not target or not target.pos then return end\n    x,y,z=target.pos.x,target.pos.y,target.pos.z\nend\nif not x or not z then return end\n-- ShapeDrawer has no entity-attached line; submit this moving endpoint line per frame.\nlocal drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\ndrawer:addLine(p.pos.x,p.pos.y,p.pos.z,x,y,z,8,2)\nself.used=true",
							name = "Draw Eyes Tether",
							uuid = "1d3c1b36-2a86-80e2-9ad5-ecf5934e2b03",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 757,
				name = "[Draw] Eyes Personal Tether",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -2,
				uuid = "971e735e-a32e-3b8d-a43c-43c9bea24569",
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
							aType = "Alert",
							alertDuration = 2000,
							alertTTS = true,
							alertText = "SOAK NOW",
							conditions = 
							{
								
								{
									"52fcedc9-88f3-78b4-a67f-050911b3b968",
									true,
								},
							},
							uuid = "06245fad-240d-7324-b3f0-ba762ad439b4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.frog_eyes_v1 ~= nil and data.frog_eyes_v1.callout == \"SOAK NOW\"",
							name = "Personal soak ready",
							uuid = "52fcedc9-88f3-78b4-a67f-050911b3b968",
							version = 3,
						},
					},
				},
				mechanicTime = 757,
				name = "[Draw] Eyes yellow Soak Callout",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -2,
				uuid = "5a7a169d-9c77-7d06-9bec-3da48eb05c16",
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
							aType = "Alert",
							alertDuration = 2000,
							alertTTS = true,
							alertText = "POP NOW",
							conditions = 
							{
								
								{
									"13a06b30-7571-739f-80fc-e0f909fe1b6c",
									true,
								},
							},
							uuid = "27d70b65-6d00-b285-a263-66d6b3787e18",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return data.frog_eyes_v1 ~= nil and data.frog_eyes_v1.callout == \"POP NOW\"",
							name = "Personal soak ready",
							uuid = "13a06b30-7571-739f-80fc-e0f909fe1b6c",
							version = 3,
						},
					},
				},
				mechanicTime = 757,
				name = "[Draw] Eyes blue Soak Callout",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -2,
				uuid = "9abfbf0a-40e4-d7cc-8394-4e474d9dd3bd",
				version = 2,
			},
		},
	},
	[154] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local old=data.frog_wrath_v1\nif old and old.arrow then Argus.deleteTimedShape(old.arrow) end\ndata.frog_wrath_v1={phase=1}\nself.used=true",
							conditions = 
							{
								
								{
									"ef103cfa-386d-d9ee-8b76-44fa754af142",
									true,
								},
							},
							name = "Reset Wrath State",
							uuid = "a469ffe4-8b24-c86f-8c29-401c10de3f06",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nlocal r=math.sqrt(dx*dx+dz*dz)\nif r<15 then return end\ns.nx,s.nz=dx/r,dz/r\ns.phase=1\nself.used=true",
							conditions = 
							{
								
								{
									"b9ad1751-34a9-bdf6-81cf-00a28790a877",
									true,
								},
							},
							name = "Capture Dragon North",
							uuid = "f67617ff-4737-743a-b251-711aaf51001d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27529,
							name = "Cast 27529",
							uuid = "ef103cfa-386d-d9ee-8b76-44fa754af142",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27531,
							name = "Cast 27531",
							uuid = "b9ad1751-34a9-bdf6-81cf-00a28790a877",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Start and North Capture",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 12.2,
				timerStartOffset = -6.8,
				uuid = "80fa0d38-43f7-e787-afdd-18f32d399303",
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
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\nlocal e=TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif not e or not e.pos then return end\ns.vellID=eventArgs.newTargetID\ns.vellX,s.vellZ=e.pos.x,e.pos.z\nself.used=true",
							conditions = 
							{
								
								{
									"a27ee1a7-3178-5b7b-9476-43f83d4e0b6b",
									true,
								},
								
								{
									"31f11011-c643-3825-ba26-9f533053e1f2",
									true,
								},
							},
							name = "Capture Vellguine Assignment",
							uuid = "51766212-336b-9fa1-aaba-86658edfd065",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\nlocal e=TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif not e or not e.pos then return end\ns.ignID=eventArgs.newTargetID\ns.ignX,s.ignZ=e.pos.x,e.pos.z\nself.used=true",
							conditions = 
							{
								
								{
									"a27ee1a7-3178-5b7b-9476-43f83d4e0b6b",
									true,
								},
								
								{
									"b756bc8f-e96f-ef19-8353-fd1a0debc238",
									true,
								},
							},
							name = "Capture Ignasse Assignment",
							uuid = "fd942bad-10ad-66f5-9392-8b9822551cf0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 5,
							name = "Knight Tether",
							uuid = "a27ee1a7-3178-5b7b-9476-43f83d4e0b6b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3636,
							name = "Vellguine",
							uuid = "31f11011-c643-3825-ba26-9f533053e1f2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3638,
							name = "Ignasse",
							uuid = "b756bc8f-e96f-ef19-8353-fd1a0debc238",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Knight Tether Capture",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 12.2,
				timerStartOffset = 3.2,
				uuid = "5d8c8c59-cd1b-b6a2-b009-a2fb763a15e2",
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
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\nif eventArgs.markerID==14 then s.defamID=eventArgs.entityID else s.diveID=eventArgs.entityID end\nself.used=true",
							conditions = 
							{
								
								{
									"fb330b8c-69b9-f40c-a81b-abbda8e35d4d",
									true,
								},
							},
							name = "Capture Personal Marker",
							uuid = "91fd3919-bfc1-3161-80b5-4bcdbb7a991d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								14,
								20,
							},
							name = "Defamation or Dive",
							uuid = "fb330b8c-69b9-f40c-a81b-abbda8e35d4d",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Marker Capture",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 15.2,
				timerStartOffset = 3.2,
				uuid = "810b02a1-ba7c-261d-b62f-b6578ecabd62",
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
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\ns.gx,s.gz=e.pos.x,e.pos.z\nself.used=true",
							conditions = 
							{
								
								{
									"9cbe3e84-594e-9bb2-b709-40d049cac022",
									true,
								},
								
								{
									"114dc3b9-c1c9-170e-866e-d2c7f02c28c2",
									true,
								},
							},
							name = "Capture Relative South",
							uuid = "096bc472-8f24-16f5-afbd-3786aaa81c99",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3639,
							name = "Grinnaux",
							uuid = "9cbe3e84-594e-9bb2-b709-40d049cac022",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							name = "Visible",
							uuid = "114dc3b9-c1c9-170e-866e-d2c7f02c28c2",
							version = 3,
						},
					},
				},
				eventType = 22,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Grinnaux South Capture",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 17.2,
				timerStartOffset = 7.2,
				uuid = "0ae604d5-3338-10a1-ac44-198371411e3a",
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
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\ns.phase=2\nif s.arrow then Argus.deleteTimedShape(s.arrow) s.arrow=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"bc2c80e8-9423-6e9e-8793-63137706def4",
									true,
								},
							},
							name = "End Initial Guidance",
							uuid = "074b8c2a-7340-113a-ac64-85a3f3ee691f",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\ns.phase=3\nself.used=true",
							conditions = 
							{
								
								{
									"a29828d8-d5cf-d447-973f-a856fab1f880",
									true,
								},
							},
							name = "End Dive Bait Guidance",
							uuid = "799663a8-11f0-85b0-8250-85361fd05e97",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 27531,
							name = "Cast 27531",
							uuid = "bc2c80e8-9423-6e9e-8793-63137706def4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Cauterize",
							spellIDList = 
							{
								27533,
								27534,
							},
							uuid = "a29828d8-d5cf-d447-973f-a856fab1f880",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Dive Progress",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 26.2,
				timerStartOffset = 5.2,
				uuid = "84ab5ace-904a-70fd-a489-d34e881f64a1",
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
							actionLua = "local s=data.frog_wrath_v1\nlocal ex,ez=-s.nz,s.nx\nlocal drawer=TensorCore.getStaticDrawer(0xC000FF00,1,0,0)\ns.arrow=drawer:addTimedArrow(8000,100+ex*5,0.08,100+ez*5,math.atan2(ex,ez),8,1.5,3,4,0,false,0)\nself.used=true",
							conditions = 
							{
								
								{
									"0f820f54-8583-b2a8-a063-86f19e79fadf",
									true,
								},
							},
							name = "Draw Relative East Arrow",
							uuid = "f92484f0-85f8-6a5e-b0dd-0f8898161086",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local s=data.frog_wrath_v1\nif not s or s.phase~=1 or not s.nx or not s.vellID or not s.ignID or not s.defamID then return false end\nlocal p=TensorCore.mGetPlayer()\nreturn p and p.id~=s.vellID and p.id~=s.ignID and p.id~=s.defamID",
							name = "Unmarked Assignment Ready",
							uuid = "0f820f54-8583-b2a8-a063-86f19e79fadf",
							version = 3,
						},
					},
				},
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Unmarked East Arrow",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 12.2,
				timerStartOffset = 3.2,
				uuid = "9185e6e4-b485-f7e9-bea3-ac62b8cbb914",
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
							actionLua = "local s=data.frog_wrath_v1\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then return end\nlocal x,z\nlocal radius=19.5\nif s.phase==1 and s.nx then\n    local kx,kz\n    if p.id==s.vellID then kx,kz=s.vellX,s.vellZ\n    elseif p.id==s.ignID then kx,kz=s.ignX,s.ignZ end\n    if kx then\n        local dx,dz=kx-100,kz-100\n        local length=math.sqrt(dx*dx+dz*dz)\n        if length>0 then x,z=100-radius*dx/length,100-radius*dz/length end\n    elseif p.id==s.defamID then\n        -- WNW: 60 degrees west of dragon-relative north, away from the NW dive lane.\n        local ex,ez=-s.nz,s.nx\n        x,z=100+radius*(0.5*s.nx-0.8660254038*ex),100+radius*(0.5*s.nz-0.8660254038*ez)\n    end\nelseif s.phase==2 and p.id==s.diveID and s.gx then\n    local dx,dz=s.gx-100,s.gz-100\n    local length=math.sqrt(dx*dx+dz*dz)\n    if length>0 then x,z=100-radius*dx/length,100-radius*dz/length end\nend\nif x then\n    -- Moving player endpoint requires a per-frame line.\n    local drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\n    drawer:addLine(p.pos.x,p.pos.y,p.pos.z,x,0.08,z,8,2)\nend\nself.used=true",
							name = "Draw Assigned Position",
							uuid = "cdd0c157-b2d0-6c08-bbae-1c5eedbf2a79",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Personal Guidance",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 26.2,
				timerStartOffset = 3.2,
				uuid = "036d633e-8e25-a056-ab4d-802083c0d1ae",
				version = 2,
			},
		},
	},
	[180] = 
	{
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "if data.frog_draw_settings == nil or data.frog_draw_settings.version~=3 then\n local p={\n  version=3,\n  path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]],\n  default=\"R1 H1 M1 MT OT M2 H2 R2\",\n  roles={MT=true,OT=true,H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n }\n function p.parse(text)\n  if type(text)~=\"string\" then return nil,\"Enter all eight roles.\" end\n  local order,seen={},{}\n  for role in string.upper(text):gmatch(\"[^%s,]+\") do\n   if not p.roles[role] then return nil,\"Unknown role: \"..role end\n   if seen[role] then return nil,\"Duplicate role: \"..role end\n   seen[role]=true; order[#order+1]=role\n  end\n  if #order~=8 then return nil,\"Enter each of MT OT H1 H2 M1 M2 R1 R2 once.\" end\n  return order,table.concat(order,\" \")\n end\n function p.save(text)\n  local order,normalized=p.parse(text)\n  if not order then p.message=normalized; return false end\n  local nextSettings={}\n  for k,v in pairs(p.settings) do nextSettings[k]=v end\n  nextSettings.doth_conga=normalized\n  local ok,err=pcall(FileSave,p.path,nextSettings)\n  local readOK,saved=pcall(FileLoad,p.path)\n  if not ok or not readOK or type(saved)~=\"table\" or saved.doth_conga~=normalized then\n   p.message=\"Save failed: \"..tostring(err or saved); return false\n  end\n  p.settings=nextSettings\n  p.order,p.saved,p.edit=order,normalized,normalized\n  p.message=\"Saved. Used when DOTH begins.\"\n  return true\n end\n p.order,p.saved=p.parse(p.default)\n p.edit=p.saved\n p.settings={}\n if FileExists(p.path) then\n  local ok,settings=pcall(FileLoad,p.path)\n  local order,normalized\n  if ok and type(settings)==\"table\" then\n   p.settings=settings\n   order,normalized=p.parse(settings.doth_conga)\n  end\n  if order then p.order,p.saved,p.edit=order,normalized,normalized\n  else p.message=\"Invalid settings file; using defaults. Apply to repair.\" end\n else\n  local previous=data.frog_draw_settings\n  p.save(previous and previous.saved or p.default)\n end\n data.frog_draw_settings=p\nend\nlocal s = {\n phase=1, doom={}, markers={}, markerPos={}, dives={}, puddles={}, puddleByID={},\n slots={}, roleByID={}, dirty=true,\n order={},\n rosterSlots={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"},\n doomOrder={},clearOrder={}\n}\nfor i,role in ipairs(data.frog_draw_settings.order) do s.order[i]=role end\ndata.frog_doth_v1=s\nfunction s.resolveRoster()\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local byName,byJob,counts,rcounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a\n   byJob[a.job]=a\n   counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(members) do\n  if m.job then rcounts[m.job]=(rcounts[m.job] or 0)+1 end\n end\n local seen={}\n for _,role in ipairs(s.order) do\n  local m=members[s.rosterSlots[role]]\n  if not m or not m.name or not m.job then return false end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n  if not a or seen[a.id] then return false end\n  seen[a.id]=true\n  s.slots[role]=a.id\n  s.roleByID[a.id]=role\n end\n return true\nend\nfunction s.point(e,n,label)\n s.x=100+s.ex*e+s.nx*n\n s.z=100+s.ez*e+s.nz*n\n s.label=label\nend\nfunction s.puddlePoint(index,opposite,label)\n local p=s.puddles[index]\n if not p then s.reason=\"Waiting for cleanse puddles\"; return end\n if opposite then s.x,s.z=200-p.x,200-p.z else s.x,s.z=p.x,p.z end\n s.label=label\nend\nfunction s.sortPuddles(a,b)\n local ae=(a.x-100)*s.ex+(a.z-100)*s.ez\n local be=(b.x-100)*s.ex+(b.z-100)*s.ez\n return ae<be or (ae==be and a.id<b.id)\nend\nfunction s.pairSide(id,marker,axis)\n local mine=s.markerPos[id]\n if not mine then return nil end\n local my=(mine.x-100)*(axis==\"east\" and s.ex or s.nx)+(mine.z-100)*(axis==\"east\" and s.ez or s.nz)\n for other,m in pairs(s.markers) do\n  if other~=id and m==marker then\n   local p=s.markerPos[other]\n   if not p then return nil end\n   local v=(p.x-100)*(axis==\"east\" and s.ex or s.nx)+(p.z-100)*(axis==\"east\" and s.ez or s.nz)\n   return my<v or (my==v and id<other)\n  end\n end\n return nil\nend\ns.rosterReady=s.resolveRoster()\nself.used=true",
							conditions = 
							{
								
								{
									"8fb0bdd0-5d07-9283-a074-93e94ae77290",
									true,
								},
							},
							name = "Reset DOTH and resolve roster",
							uuid = "ca88ec54-36b5-20b6-acf8-9a37304c6ec1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Death of the Heavens",
							spellIDList = 
							{
								27538,
							},
							uuid = "8fb0bdd0-5d07-9283-a074-93e94ae77290",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Start and Roster",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 4.9,
				timerStartOffset = -5.1,
				uuid = "29278938-1a69-45b8-9946-2738079eca0e",
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
							actionLua = "local s=data.frog_doth_v1\nif not s or s.nx then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nlocal r=math.sqrt(dx*dx+dz*dz)\n-- The introductory knight ring is radius 12; the actual impact position is radius 9.\nif r<8 or r>10 then self.used=true return end\ns.nx,s.nz=dx/r,dz/r\ns.ex,s.ez=-s.nz,s.nx\ns.dirty=true\nself.used=true",
							conditions = 
							{
								
								{
									"6deb6aaa-916a-086e-88e7-0e003b1d929a",
									true,
								},
								
								{
									"1777e45a-d613-1661-be8f-71119959470f",
									true,
								},
							},
							name = "Freeze relative north",
							uuid = "1b05117a-f307-7e29-a4aa-5859ccb060c8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3641,
							name = "Guerrique",
							uuid = "6deb6aaa-916a-086e-88e7-0e003b1d929a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 4,
							eventIntValue = 7747,
							name = "Warp arrival",
							uuid = "1777e45a-d613-1661-be8f-71119959470f",
							version = 3,
						},
					},
				},
				eventType = 23,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Guerrique North Capture",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 10.9,
				timerStartOffset = 2.9,
				uuid = "2660c2c1-0627-0145-95bf-93a7d21a2195",
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
							actionLua = "local s=data.frog_doth_v1\nif not s or s.nx then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nlocal r=math.sqrt(dx*dx+dz*dz)\n-- The introductory knight ring is radius 12; the actual impact position is radius 9.\nif r<8 or r>10 then self.used=true return end\ns.nx,s.nz=dx/r,dz/r\ns.ex,s.ez=-s.nz,s.nx\ns.dirty=true\nself.used=true",
							conditions = 
							{
								
								{
									"7f375b4a-8e30-9595-a6e8-1ae63e3ecb24",
									true,
								},
							},
							name = "Capture north if arrival missed",
							uuid = "4a773e6b-35b2-30f7-b7d5-02f2152b9235",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Heavy Impact",
							spellIDList = 
							{
								25557,
							},
							uuid = "7f375b4a-8e30-9595-a6e8-1ae63e3ecb24",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Heavy Impact North Capture",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 12.9,
				timerStartOffset = 4.9,
				uuid = "4093725f-137e-f9a6-8a12-0837c3f21aff",
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
							actionLua = "local s=data.frog_doth_v1\nif s then s.doom[eventArgs.entityID]=true; s.dirty=true end\nself.used=true",
							conditions = 
							{
								
								{
									"437bd08b-7a29-0985-9480-592f9bfd0d3f",
									true,
								},
							},
							name = "Remember doom assignment",
							uuid = "fc054db9-9a5f-6f0c-910e-8620a49de34b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventBuffID = 2976,
							name = "Doom 2976",
							uuid = "437bd08b-7a29-0985-9480-592f9bfd0d3f",
							version = 3,
						},
					},
				},
				eventType = 8,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Doom Capture",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 12.9,
				timerStartOffset = 4.9,
				uuid = "75da7914-04d2-9301-8774-d547de1f34d9",
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
							actionLua = "local s=data.frog_doth_v1\nif s and s.phase==1 then\n s.dives[eventArgs.spellID]=true\n if s.dives[27531] and s.dives[27533] and s.dives[27539] then\n  s.phase=2; s.baitAt=TensorReactions_CurrentTimer+3; s.dirty=true\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"b8f58a37-e7ee-2a68-847b-6678ae2d42e2",
									true,
								},
							},
							name = "End spread after all three dives",
							uuid = "f2b57be5-e2d6-80dc-a08b-2d12069741f0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_doth_v1\nif s then s.phase=4; s.x,s.z=nil,nil; s.dirty=true end\nself.used=true",
							conditions = 
							{
								
								{
									"33f43f20-dd44-dc0a-9528-2a0bd5033ba5",
									true,
								},
							},
							name = "Finish personal guidance",
							uuid = "0f37983b-478e-1bfa-8f07-36e6b13157a0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Three dives",
							spellIDList = 
							{
								27531,
								27533,
								27539,
							},
							uuid = "b8f58a37-e7ee-2a68-847b-6678ae2d42e2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Heavensflame resolved",
							spellIDList = 
							{
								25310,
							},
							uuid = "33f43f20-dd44-dc0a-9528-2a0bd5033ba5",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Dive and Heavensflame Progress",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 33.9,
				timerStartOffset = 11.9,
				uuid = "a9ac8128-fdcd-83c6-9398-ae198710bddc",
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
							actionLua = "local s=data.frog_doth_v1\nif s and not s.puddleByID[eventArgs.entityID] and #s.puddles<4 then\n local p={id=eventArgs.entityID,x=eventArgs.x,z=eventArgs.z}\n s.puddleByID[p.id]=p\n s.puddles[#s.puddles+1]=p\n s.puddlesSorted=false\n s.dirty=true\nend\nself.used=true",
							conditions = 
							{
								
								{
									"8f44dce0-3a2a-42c7-90c9-4d23a42b16d1",
									true,
								},
							},
							name = "Capture actual cleanse coordinates",
							uuid = "0aaea08e-10f6-29b8-aa66-69976231c19b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.aoeID==27542",
							dequeueIfLuaFalse = true,
							name = "Wings of Salvation AOE",
							uuid = "8f44dce0-3a2a-42c7-90c9-4d23a42b16d1",
							version = 3,
						},
					},
				},
				eventType = 18,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Cleanse Puddle Capture",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 28.9,
				timerStartOffset = 14.9,
				uuid = "0b560dba-9528-9efa-8996-11b22293ee59",
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
							actionLua = "local s=data.frog_doth_v1\nif not s then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\ns.markers[e.id]=eventArgs.markerID\ns.markerPos[e.id]={x=e.pos.x,z=e.pos.z}\ns.phase=3\ns.dirty=true\nself.used=true",
							conditions = 
							{
								
								{
									"21369feb-36b1-ea35-9660-9d709d2981f7",
									true,
								},
							},
							name = "Capture marker and pair position",
							uuid = "afac292f-2598-805e-aa7c-a28661899aa5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							markerIDList = 
							{
								281,
								282,
								283,
								284,
							},
							name = "PlayStation markers",
							uuid = "21369feb-36b1-ea35-9660-9d709d2981f7",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH PlayStation Capture",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 28.9,
				timerStartOffset = 19.9,
				uuid = "06b597fa-fa3b-d527-a29b-189db4d5446a",
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
							actionLua = "local s=data.frog_doth_v1\nif not s then self.used=true return end\nlocal t=TensorReactions_CurrentTimer\nif s.lastTick and t<s.lastTick-1 then data.frog_doth_v1=nil; self.used=true return end\ns.lastTick=t\nif not s.rosterReady then\n if not s.retryAt or t>=s.retryAt then s.retryAt=t+1; s.rosterReady=s.resolveRoster(); s.dirty=true end\nend\nif not s.dirty then self.used=true return end\ns.x,s.z,s.label,s.reason=nil,nil,nil,nil\nif not s.rosterReady then s.reason=\"Waiting for Anyone roster\"; self.used=true return end\nif not s.nx then s.reason=\"Waiting for Guerrique arrival\"; self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player then self.used=true return end\ns.myRole=s.roleByID[player.id]\nif not s.myRole then s.reason=\"Self absent from roster\"; self.used=true return end\nif not s.assigned then\n local d=0\n for _,role in ipairs(s.order) do if s.doom[s.slots[role]] then d=d+1 end end\n if d~=4 then s.reason=\"Waiting for all four dooms\"; self.used=true return end\n local di,ci=0,0\n for _,role in ipairs(s.order) do\n  local id=s.slots[role]\n  if s.doom[id] then di=di+1; s.doomOrder[di]=id else ci=ci+1; s.clearOrder[ci]=id end\n end\n s.assigned=true\n s.myDoom=s.doom[player.id]==true\n local order=s.myDoom and s.doomOrder or s.clearOrder\n for rank,id in ipairs(order) do if id==player.id then s.myRank=rank end end\n s.baiter=s.myDoom and (s.myRank==1 or s.myRank==4)\nend\nif #s.puddles==4 and not s.puddlesSorted then table.sort(s.puddles,s.sortPuddles); s.puddlesSorted=true end\nlocal rank=s.myRank\nif s.phase==1 then\n if rank==1 then s.point(s.myDoom and -10.5 or -20,0,\"West spread\")\n elseif rank==4 then s.point(s.myDoom and 10.5 or 20,0,\"East spread\")\n else s.point(rank==2 and -12 or 12,s.myDoom and 16 or -16,\"Offset diagonal spread\") end\nelseif s.phase==2 then\n if s.baiter then s.point(rank==1 and -10.5 or 10.5,0,\"Bait circle\")\n else s.point(0,s.myDoom and -2 or 2,s.myDoom and \"Doom south\" or \"Non-doom north\") end\nelseif s.phase==3 then\n local marker=s.markers[player.id]\n if s.myDoom then\n  if not s.puddlesSorted then s.reason=\"Waiting for all four cleanse puddles\"; self.used=true return end\n  if marker==281 then\n   local west=s.pairSide(player.id,281,\"east\")\n   if west~=nil then s.puddlePoint(west and 1 or 4,false,\"Circle cleanse\") end\n  elseif marker==283 then s.puddlePoint(2,false,\"Square southwest cleanse\")\n  elseif marker==282 then s.puddlePoint(3,false,\"Triangle southeast cleanse\") end\n else\n  if marker==282 then\n   if s.puddlesSorted then s.puddlePoint(3,true,\"Triangle opposite southeast cleanse\")\n   else s.point(-12,16,\"Triangle northwest\") end\n  elseif marker==283 then\n   if s.puddlesSorted then s.puddlePoint(2,true,\"Square opposite southwest cleanse\")\n   else s.point(12,16,\"Square northeast\") end\n  elseif marker==284 then\n   local south=s.pairSide(player.id,284,\"north\")\n   if south~=nil then s.point(0,south and -20 or 20,south and \"Cross south\" or \"Cross north\") end\n  end\n end\nend\ns.dirty=false\nself.used=true",
							name = "Resolve personal DOTH destination",
							uuid = "a9fc0045-9529-6e7a-8bc3-abc526091159",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Assignment Solver",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 33.9,
				timerStartOffset = -1.1,
				uuid = "e40fcf03-16ef-42f9-be63-d0de9dbff003",
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
							aType = "Alert",
							alertDuration = 2000,
							alertTTS = true,
							alertText = "Bait circle",
							conditions = 
							{
								
								{
									"bb9d10f3-58b0-6e4d-b7d8-9b2b1430af65",
									true,
								},
							},
							uuid = "35e7434b-eb80-9e7c-938e-56d9a302144d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local s=data.frog_doth_v1\nreturn s~=nil and s.phase==2 and s.baiter==true and s.baitAt~=nil and TensorReactions_CurrentTimer>=s.baitAt",
							name = "Outer doom ready",
							uuid = "bb9d10f3-58b0-6e4d-b7d8-9b2b1430af65",
							version = 3,
						},
					},
				},
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Bait Circle Callout",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 25.9,
				timerStartOffset = 16.9,
				uuid = "12c81a3c-f40a-6f9e-8063-8fb8905101bf",
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
							actionLua = "local s=data.frog_doth_v1\nlocal p=TensorCore.mGetPlayer()\nif s and s.x and s.z and s.phase<4 and p and p.pos and p.hp.current>0 then\n local drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\n drawer:addLine(p.pos.x,p.pos.y,p.pos.z,s.x,0.08,s.z,8,2)\nend\nself.used=true",
							name = "Draw only my current destination",
							uuid = "4c8eec4b-205e-92a4-83ec-f376b894fa26",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH Personal Tether",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 33.9,
				timerStartOffset = 4.9,
				uuid = "82ac4b13-5f67-d31e-b22c-56c087e10c14",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl