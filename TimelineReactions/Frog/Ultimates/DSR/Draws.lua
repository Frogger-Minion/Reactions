local tbl = 
{
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
				timerEndOffset = 13.7,
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
							actionLua = "local state = data.sam_hiemal_meteor\nif state == nil or state.marked == nil or state.markerCount < 2 then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    return\nend\n\nif state.slotOrder == nil then\n    state.slotOrder = {\"MT\", \"OT\", \"H1\", \"H2\", \"M1\", \"M2\", \"R1\", \"R2\"}\n    state.definitions = {\n        {name = \"MT\", cardinal = \"N\"},\n        {name = \"OT\", cardinal = \"S\"},\n        {name = \"H1\", cardinal = \"W\"},\n        {name = \"H2\", cardinal = \"E\"},\n        {name = \"M1\", cardinal = \"W\"},\n        {name = \"M2\", cardinal = \"E\"},\n        {name = \"R1\", cardinal = \"N\"},\n        {name = \"R2\", cardinal = \"S\"}\n    }\nend\n\nif state.meteorSolverVersion ~= 3 then\n    state.meteorSolverVersion = 3\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.towerByID = nil\nend\n\nif state.assignmentsReady ~= true then\nlocal rosterSlotByName = {\n    MT = \"T1\",\n    OT = \"T2\",\n    H1 = \"H1\",\n    H2 = \"H2\",\n    M1 = \"M1\",\n    M2 = \"M2\",\n    R1 = \"R1\",\n    R2 = \"R2\"\n}\nlocal refreshedSlots = {}\nlocal refreshedInitialCardinal = {}\nlocal rosterIDs = {}\n\n-- Replay-safe roster join:\n-- Roster.members() contains the logical slots and human names, while\n-- getAgnosticPartyList() contains the current live entity IDs.\nlocal rosterMembers = AnyoneCore.Roster.members()\nlocal agnosticParty = AnyoneCore.API.getAgnosticPartyList()\nif type(rosterMembers) ~= \"table\" or type(agnosticParty) ~= \"table\" then\n    return\nend\n\nlocal actorByJob, actorJobCount, rosterJobCount = {}, {}, {}\nfor _, actor in pairs(agnosticParty) do\n    if actor.id ~= nil and actor.job ~= nil then\n        actorByJob[actor.job] = actor\n        actorJobCount[actor.job] = (actorJobCount[actor.job] or 0) + 1\n    end\nend\nfor _, member in pairs(rosterMembers) do\n    if member.job ~= nil then\n        rosterJobCount[member.job] = (rosterJobCount[member.job] or 0) + 1\n    end\nend\nlocal actorByNameJob = {}\nfor _, actor in pairs(agnosticParty) do\n    if actor ~= nil and actor.id ~= nil and actor.name ~= nil and actor.job ~= nil then\n        local key = tostring(actor.name) .. \"\\31\" .. tostring(actor.job)\n        actorByNameJob[key] = actor\n    end\nend\n\nfor _, definition in ipairs(state.definitions) do\n    local rosterSlot = rosterSlotByName[definition.name]\n    local member = rosterMembers[rosterSlot]\n    if member == nil or member.name == nil or member.job == nil then\n        return\n    end\n\n    local key = tostring(member.name) .. \"\\31\" .. tostring(member.job)\n    local actor = actorByNameJob[key]\n    -- Anonymized replay names can differ; use only an unambiguous job join.\n    if actor == nil and actorJobCount[member.job] == 1 and rosterJobCount[member.job] == 1 then\n        actor = actorByJob[member.job]\n    end\n    if actor == nil or actor.id == nil then\n        return\n    end\n\n    local kind\n    if definition.name == \"MT\" or definition.name == \"OT\"\n        or definition.name == \"H1\" or definition.name == \"H2\" then\n        kind = \"SUPPORT\"\n    else\n        kind = \"DPS\"\n    end\n\n    local id = actor.id\n    refreshedSlots[definition.name] = {\n        id = id,\n        cardinal = definition.cardinal,\n        kind = kind\n    }\n    refreshedInitialCardinal[id] = definition.cardinal\n    rosterIDs[#rosterIDs + 1] = definition.name .. \"=\" .. tostring(id)\nend\n\nlocal rosterSignature = table.concat(rosterIDs, \":\")\nif state.rosterSignature ~= rosterSignature then\n    state.rosterSignature = rosterSignature\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.finalCardinal = nil\n    state.rotatedFrom = nil\n    state.meteorPlayers = nil\n    state.towerByID = nil\n    state.quadrants = nil\nend\n\nstate.slots = refreshedSlots\nstate.initialCardinal = refreshedInitialCardinal\n\nlocal meteorPlayers = {}\nlocal meteorKind = nil\nfor _, slotName in ipairs(state.slotOrder) do\n    local slot = state.slots[slotName]\n    if slot ~= nil and state.marked[slot.id] == true then\n        meteorPlayers[#meteorPlayers + 1] = slot\n        if meteorKind == nil then\n            meteorKind = slot.kind\n        elseif meteorKind ~= slot.kind then\n            return\n        end\n    end\nend\n\nif #meteorPlayers < 2 or meteorKind == nil then\n    return\nend\n\nif state.assignmentsReady ~= true then\n    state.finalCardinal = {}\n    state.rotatedFrom = {}\n    state.meteorPlayers = meteorPlayers\n\n    local occupied = {N = false, S = false}\n    for _, slot in ipairs(state.slotOrder) do\n        local entry = state.slots[slot]\n        state.finalCardinal[entry.id] = entry.cardinal\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"N\" or entry.cardinal == \"S\") then\n            occupied[entry.cardinal] = true\n        end\n    end\n\n    -- Meteor players already starting north or south stay fixed.\n    -- West rotates clockwise to north; east rotates clockwise to south.\n    -- If that destination is already occupied by a meteor, use the other\n    -- fixed cardinal instead.\n    for _, slotName in ipairs(state.slotOrder) do\n        local entry = state.slots[slotName]\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"W\" or entry.cardinal == \"E\") then\n            local target = entry.cardinal == \"W\" and \"N\" or \"S\"\n            if occupied[target] == true then\n                target = target == \"N\" and \"S\" or \"N\"\n            end\n            state.finalCardinal[entry.id] = target\n            state.rotatedFrom[target] = entry.cardinal\n            occupied[target] = true\n        end\n    end\n\n    -- The non-meteor support/DPS player who originally owned the fixed\n    -- cardinal flexes into the quadrant vacated by the rotating meteor.\n    for target, originalCardinal in pairs(state.rotatedFrom) do\n        for _, slotName in ipairs(state.slotOrder) do\n            local entry = state.slots[slotName]\n            if entry.kind == meteorKind\n                and state.marked[entry.id] ~= true\n                and entry.cardinal == target then\n                state.finalCardinal[entry.id] = originalCardinal\n                break\n            end\n        end\n    end\n\n    state.meteorKind = meteorKind\n    state.assignmentsReady = true\nend\n\nend -- roster and flex assignment are captured once per mechanic\n\nlocal fixedSpot = {\n    N = {x = 100.0, z = 89.5},\n    E = {x = 110.5, z = 100.0},\n    S = {x = 100.0, z = 110.5},\n    W = {x = 89.5, z = 100.0}\n}\n\nlocal drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, 0xFF0000FF, nil, 1.0, 0, 0\n)\n\nif TensorReactions_CurrentTimer < 415.2 then\n    local initialCardinal = state.finalCardinal[player.id]\n    if initialCardinal ~= nil then\n        local destination = fixedSpot[initialCardinal]\n        if destination ~= nil then\n            drawer:addLine(\n                player.pos.x, player.pos.y, player.pos.z,\n                destination.x, destination.y or 0.05, destination.z,\n                8.0, 2.0\n            )\n        end\n    end\nend\n\nif state.towersResolved ~= true then\n    if state.towerCount ~= 8 then return end\n    local outer = {N = {}, E = {}, S = {}, W = {}}\n    local inner = {}\n    local cardinals = {\"N\", \"E\", \"S\", \"W\"}\n    local axis = {N = {0,-1}, E = {1,0}, S = {0,1}, W = {-1,0}}\n    local function inside(t)\n        local x,z = t.x-100,t.z-100\n        return x*x+z*z < 64\n    end\n    local function lateral(t,c)\n        local a = axis[c]\n        return -(t.x-100)*a[2]+(t.z-100)*a[1]\n    end\n    local function distance(a,b)\n        return (a.x-b.x)^2+(a.z-b.z)^2\n    end\n    for _,t in pairs(state.towers) do\n        if inside(t) then\n            inner[#inner+1] = t\n        else\n            local x,z = t.x-100,t.z-100\n            local c\n            if math.abs(z)>=math.abs(x) then c=z<0 and \"N\" or \"S\"\n            else c=x>0 and \"E\" or \"W\" end\n            outer[c][#outer[c]+1]=t\n        end\n    end\n    -- Stable ordering makes equal geometric choices deterministic.\n    local function order(a,b)\n        if a.x ~= b.x then return a.x < b.x end\n        return a.z < b.z\n    end\n    table.sort(inner,order)\n    for _,c in ipairs(cardinals) do table.sort(outer[c],order) end\n    local assigned,used = {},{}\n    local first,second = state.meteorPlayers[1],state.meteorPlayers[2]\n    local c1,c2 = state.finalCardinal[first.id],state.finalCardinal[second.id]\n    if not ((c1==\"N\" and c2==\"S\") or (c1==\"S\" and c2==\"N\")) then return end\n    local bestA,bestB,bestCenters,bestDistance = nil,nil,-1,-1\n    for _,a in ipairs(outer[c1]) do\n        for _,b in ipairs(outer[c2]) do\n            -- Center means the OUTER cardinal tower, never an inner tower.\n            local centers = (math.abs(lateral(a,c1))<0.5 and 1 or 0)\n                +(math.abs(lateral(b,c2))<0.5 and 1 or 0)\n            local d=distance(a,b)\n            if centers>bestCenters or (centers==bestCenters and d>bestDistance) then\n                bestA,bestB,bestCenters,bestDistance=a,b,centers,d\n            end\n        end\n    end\n    if bestA==nil or bestB==nil then return end\n    assigned[first.id],assigned[second.id]=bestA,bestB\n    used[bestA],used[bestB]=true,true\n    local innerPlayers={}\n    for _,c in ipairs(cardinals) do\n        local other,meteorRole\n        for _,name in ipairs(state.slotOrder) do\n            local entry=state.slots[name]\n            if state.finalCardinal[entry.id]==c then\n                if entry.kind==state.meteorKind then meteorRole=entry else other=entry end\n            end\n        end\n        if other==nil or meteorRole==nil or #outer[c]<1 then return end\n        if #outer[c]==1 then\n            -- Every meteor-role player owns the outer tower in this case.\n            local t=outer[c][1]\n            if assigned[meteorRole.id]~=nil and assigned[meteorRole.id]~=t then return end\n            assigned[meteorRole.id]=t\n            used[t]=true\n            innerPlayers[#innerPlayers+1]={id=other.id,cardinal=c}\n        else\n            -- Unmarked opposite-role player: CCW outer first, respecting\n            -- the outer tower already reserved for a marked meteor player.\n            local best\n            for _,t in ipairs(outer[c]) do\n                if not used[t] and (best==nil or lateral(t,c)<lateral(best,c)) then best=t end\n            end\n            if best==nil then return end\n            assigned[other.id]=best\n            used[best]=true\n            if assigned[meteorRole.id]==nil then\n                local remaining\n                for _,t in ipairs(outer[c]) do\n                    if not used[t] then remaining=t break end\n                end\n                if remaining==nil then return end\n                assigned[meteorRole.id]=remaining\n                used[remaining]=true\n            end\n        end\n    end\n    if #innerPlayers~=#inner then return end\n    -- Match all inner players together. Maximize fulfilled immediate-CW\n    -- claims before choosing the shortest remaining clockwise rotations.\n    local picks,bestPicks={},nil\n    local bestClaims,bestTravel=-1,math.huge\n    local function search(i,claims,travel)\n        if i>#innerPlayers then\n            if claims>bestClaims or (claims==bestClaims and travel<bestTravel) then\n                bestClaims,bestTravel=claims,travel\n                bestPicks={}\n                for k,t in ipairs(picks) do bestPicks[k]=t end\n            end\n            return\n        end\n        local a=axis[innerPlayers[i].cardinal]\n        for _,t in ipairs(inner) do\n            if not used[t] then\n                local x,z=t.x-100,t.z-100\n                local forward=x*a[1]+z*a[2]\n                local side=-x*a[2]+z*a[1]\n                local angle=math.atan2(side,forward)\n                if angle<0 then angle=angle+2*math.pi end\n                local claim=(forward>0.5 and side>0.5) and 1 or 0\n                picks[i]=t\n                used[t]=true\n                search(i+1,claims+claim,travel+angle)\n                used[t]=nil\n                picks[i]=nil\n            end\n        end\n    end\n    search(1,0,0)\n    if bestPicks==nil then return end\n    for i,entry in ipairs(innerPlayers) do assigned[entry.id]=bestPicks[i] end\n    -- Publish only a complete, unique assignment satisfying role rules.\n    local check={}\n    for _,name in ipairs(state.slotOrder) do\n        local entry=state.slots[name]\n        local t=assigned[entry.id]\n        if t==nil or check[t] then return end\n        check[t]=true\n        if entry.kind==state.meteorKind and inside(t) then return end\n        if entry.kind~=state.meteorKind and #outer[state.finalCardinal[entry.id]]==1\n            and not inside(t) then return end\n    end\n    state.quadrants=outer\n    state.towerByID=assigned\n    state.towersResolved=true\nend\nself.used=true\n",
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
							actionLua = "local old = data.frog_dfg_v2\nlocal s = {line=old and old.line or {}, positions={}, jump={}, side={}, placement={}, planned={}, towers={{},{},{}}, placed={}, resolved={0,0,0}, towerByCaster={}, resolvedCasters={{},{},{}}, stacks=0, ready=false}\ndata.frog_dfg_v2 = s\nlocal boss = TensorCore.mGetEntity(eventArgs.entityID)\nif not boss or not boss.pos or not boss.hitradius or boss.hitradius <= 0 then self.used=true return end\ns.bossID=boss.id\ns.center={x=boss.pos.x,y=boss.pos.y,z=boss.pos.z}\ns.radius=boss.hitradius\ns.drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\nlocal party=TensorCore.getEntityGroupList(\"Party\")\nfor _,e in pairs(party or {}) do\n    s.positions[e.id]={x=e.pos.x,y=e.pos.y,z=e.pos.z}\nend\nfunction s.assign()\n    if s.ready then return end\n    local counts={0,0,0}\n    local highs={true,true,true}\n    for id,p in pairs(s.positions) do\n        local line=s.line[id]\n        if not line then return end\n        local e=TensorCore.mGetEntity(id)\n        if not e then return end\n        if not s.jump[id] then\n            if TensorCore.hasBuff(e,2755) then s.jump[id]=1\n            elseif TensorCore.hasBuff(e,2756) then s.jump[id]=2\n            elseif TensorCore.hasBuff(e,2757) then s.jump[id]=3 end\n        end\n        if not s.jump[id] then return end\n        counts[line]=counts[line]+1\n        if s.jump[id]~=1 then highs[line]=false end\n    end\n    if counts[1]~=3 or counts[2]~=2 or counts[3]~=3 then return end\n    local westSecond\n    for id,p in pairs(s.positions) do\n        if s.line[id]==2 and (not westSecond or p.x<s.positions[westSecond].x or (p.x==s.positions[westSecond].x and id<westSecond)) then westSecond=id end\n    end\n    for id,p in pairs(s.positions) do\n        local line,jump=s.line[id],s.jump[id]\n        local side\n        if not highs[line] then side=jump==1 and \"S\" or jump==2 and \"E\" or \"W\"\n        elseif line==2 then side=id==westSecond and \"W\" or \"E\"\n        else\n            local dx,dz=p.x-s.center.x,p.z-s.center.z\n            if -dx>=dz and dx<=0 then side=\"W\" elseif dx>=dz then side=\"E\" else side=\"S\" end\n        end\n        s.side[id]=side\n        local r=s.radius\n        local x,z=s.center.x,s.center.z\n        if line==2 then\n            local q=(r+1)/math.sqrt(2)\n            x=x+(side==\"W\" and -q or q); z=z-q\n        elseif side==\"W\" then x=x-r elseif side==\"E\" then x=x+r else z=z+r end\n        -- Keep the player's placement on the edge; project the tower separately.\n        local tx=x\n        if jump==2 then\n            tx=x-14\n        elseif jump==3 then\n            tx=x+14\n        end\n        s.placement[id]={x=x,y=s.center.y+0.05,z=z}\n        s.planned[id]={x=tx,y=s.center.y+0.05,z=z}\n    end\n    s.ready=true\nend\nfunction s.tower(wave,side)\n    local best,score\n    -- Captured jump positions supersede assignment predictions.\n    for id,p in pairs(s.planned) do\n        if s.line[id]==wave then\n            local t=s.towers[wave][id] or p\n            local v=side==\"W\" and -t.x or side==\"E\" and t.x or t.z\n            if not best or v>score then best,score=t,v end\n        end\n    end\n    return best\nend\nfunction s.guide(id)\n    local line,side=s.line[id],s.side[id]\n    if not s.ready or not line or not side then return nil end\n    if line==1 then\n        if not s.placed[id] then return s.placement[id],\"place1\" end\n        if side==\"S\" then\n            if s.stacks<2 then return nil,\"stack\" end\n            if s.resolved[3]<3 then return s.tower(3,\"S\"),\"soak3\" end\n        else\n            if s.resolved[2]<2 then return s.tower(2,side),\"soak2\" end\n            if s.stacks<2 then return nil,\"stack\" end\n        end\n    elseif line==2 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if not s.placed[id] then return s.placement[id],\"place2\" end\n        if s.stacks<2 then return nil,\"stack\" end\n        if s.resolved[3]<3 then return s.tower(3,side),\"soak3\" end\n    elseif line==3 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if s.resolved[1]<3 then return s.tower(1,side),\"soak1\" end\n        if not s.placed[id] then return s.placement[id],\"place3\" end\n    end\n    return nil,\"done\"\nend\ns.assign()\nself.used=true",
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
	},
	inheritedProfiles = 
	{
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl