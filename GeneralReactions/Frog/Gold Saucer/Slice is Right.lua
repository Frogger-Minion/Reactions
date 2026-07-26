local tbl = 
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
						actionLua = "-- ============================================================\n--  Slice Is Right – Subtractive Safe-Spot Draw\n--  TensorReactions / Argus2  –  Frame-draw, runs every tick\n-- ============================================================\n\n-- ─── Content IDs ─────────────────────────────────────────────\nlocal CID_POINT_BLANK = 2010779  -- Giant PB circle (r ≈ 11)\nlocal CID_BOTH_WAYS   = 2010778  -- Forward + backward rect\nlocal CID_FORWARD     = 2010777  -- Forward-only rect\nlocal CID_GOLD_PILE   = 2010780  -- Pile of Gold (NPC) – visible state\nlocal CID_GOLD_HIDDEN = 2010781  -- Pile of Gold – hidden under cup state\nlocal CID_DAIGORO     = 108      -- Daigoro – may sit on the active pile\n\n-- ─── Arena ───────────────────────────────────────────────────\nlocal CENTER       = { x = 70.6, y = -4.5, z = -35.9 }\nlocal ARENA_RADIUS = 14.85\n\n-- ─── Geometry ────────────────────────────────────────────────\nlocal RECT_LENGTH   = 50\nlocal RECT_WIDTH    = 5\nlocal PB_RADIUS     = 11\nlocal PILE_RADIUS   = 4\nlocal BAMBOO_RADIUS = RECT_WIDTH / 2   -- = 2.5, matches rect width diameter\n\nlocal H_FWD = 1.5 * math.pi\nlocal H_BCK = 0.5 * math.pi\n\n-- ─── Render flags ────────────────────────────────────────────\nlocal RF_TERRAIN = Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal RF_OVERLAY = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n                 | Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal RF_OCCLUDE = Argus2.RenderFlags.FLAG_OCCLUDE\n                 | Argus2.RenderFlags.FLAG_WARP_TERRAIN\n\n-- ─── Channel allocation ──────────────────────────────────────\nlocal chSafe   = Argus2.getNextUnusedChannel()  -- green floor + occluders\nlocal chPiles  = Argus2.getNextUnusedChannel()  -- red pile/daigoro circles\nlocal chBamboo = Argus2.getNextUnusedChannel()  -- blue bamboo spawn circles\n\n-- ─── Guard ───────────────────────────────────────────────────\nif not (Argus2 and GUI and TensorCore) then return end\n\n-- ─── Colours ─────────────────────────────────────────────────\nlocal green = GUI:ColorConvertFloat4ToU32(0.0, 1.0, 0.0, 0.5)\nlocal red   = GUI:ColorConvertFloat4ToU32(1.0, 0.1, 0.1, 0.6)\nlocal blue  = GUI:ColorConvertFloat4ToU32(0.2, 0.4, 1.0, 0.7)\n\n-- ─── Drawers ─────────────────────────────────────────────────\nlocal safeDrawer = TensorCore.getStaticDrawer(green, 0, chSafe)\nsafeDrawer.gradientIntensity = 0\n\nlocal occludeDrawer = TensorCore.getCachedDrawer(\n    0x00000000, 0x00000000, 0x00000000, nil, 0\n)\noccludeDrawer.occlusionChannel = chSafe\n\nlocal pileDrawer = TensorCore.getStaticDrawer(red, 0, chPiles)\npileDrawer.gradientIntensity = 0\n\nlocal bambooDrawer = TensorCore.getStaticDrawer(blue, 0, chBamboo)\nbambooDrawer.gradientIntensity = 0\n\n-- ─── Poll entities ───────────────────────────────────────────\nlocal entList = EntityList(\"contentid=2010779;2010778;2010777\")\n-- Pile query covers visible (2010780) and hidden/cup state (2010781).\nlocal pileList = EntityList(\"contentid=2010780;2010781\")\n\nif not entList then return end\n\n-- ─── Draw safe zone (base, chSafe) ───────────────────────────\nsafeDrawer:addCircle(\n    CENTER.x, CENTER.y, CENTER.z,\n    ARENA_RADIUS,\n    false,\n    RF_TERRAIN\n)\n\n-- ─── Draw pile/daigoro circles ───────────────────────────────\nif pileList then\n    for _, e in pairs(pileList) do\n        pileDrawer:addCircle(\n            e.pos.x, e.pos.y, e.pos.z,\n            PILE_RADIUS,\n            false,\n            RF_OVERLAY\n        )\n    end\nend\n\n-- ─── Draw bamboo spawns + occlude AoEs ───────────────────────\nfor _, e in pairs(entList) do\n    local pos = e.pos\n\n    if e.contentid == CID_POINT_BLANK then\n        bambooDrawer:addCircle(pos.x, pos.y, pos.z, BAMBOO_RADIUS, false, RF_OVERLAY)\n        occludeDrawer:addCircle(pos.x, pos.y, pos.z, PB_RADIUS, false, RF_OCCLUDE)\n\n    elseif e.contentid == CID_BOTH_WAYS then\n        bambooDrawer:addCircle(pos.x, pos.y, pos.z, BAMBOO_RADIUS, false, RF_OVERLAY)\n        local h_fwd = math.fmod(pos.h + H_FWD, 2*math.pi) - math.pi\n        local h_bck = math.fmod(pos.h + H_BCK, 2*math.pi) - math.pi\n        occludeDrawer:addRect(pos.x, pos.y, pos.z, RECT_LENGTH, RECT_WIDTH, h_fwd, false, RF_OCCLUDE)\n        occludeDrawer:addRect(pos.x, pos.y, pos.z, RECT_LENGTH, RECT_WIDTH, h_bck, false, RF_OCCLUDE)\n\n    elseif e.contentid == CID_FORWARD then\n        bambooDrawer:addCircle(pos.x, pos.y, pos.z, BAMBOO_RADIUS, false, RF_OVERLAY)\n        local h_fwd = math.fmod(pos.h + H_FWD, 2*math.pi) - math.pi\n        occludeDrawer:addRect(pos.x, pos.y, pos.z, RECT_LENGTH, RECT_WIDTH, h_fwd, false, RF_OCCLUDE)\n    end\nend\n\n-- Frame draws: no self.used – reaction must re-fire every tick.",
						conditions = 
						{
							
							{
								"43c7ff96-174e-0177-9640-534c84bfa919",
								true,
							},
							
							{
								"121faf86-a33e-c0a6-b8ad-45a2618fdfea",
								true,
							},
						},
						gVar = "ACR_RikuSGE3_CD",
						uuid = "9daad067-56bf-7168-a545-e23668772fdc",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						dequeueIfLuaFalse = true,
						localmapid = 144,
						uuid = "43c7ff96-174e-0177-9640-534c84bfa919",
						version = 3,
					},
				},
				
				{
					data = 
					{
						buffID = 1284,
						category = "Self",
						dequeueIfLuaFalse = true,
						uuid = "121faf86-a33e-c0a6-b8ad-45a2618fdfea",
						version = 3,
					},
				},
			},
			eventType = 12,
			name = "Subtractive Is Right",
			timeout = 6,
			uuid = "4b5f0d62-20c6-92ba-89a8-098cf60e6dda",
			version = 2,
		},
		inheritedIndex = 1,
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
						actionLua = "local timeout = 1000\n\nlocal entList = EntityList(\"contentid=2010779;2010778;2010777\")\n\nif not entList then\n    return\nend\n\nlocal drawer = TensorCore.getCachedDrawer(\n    0x40FF0000, -- fill\n    0xFFFF0000, -- outline\n    0xFFFFFFFF, -- outline colour\n    2\n)\n\nfor _, e in pairs(entList) do\n\n    if e then\n\n        local pos = e.pos\n\n        if e.contentid == 2010779 then\n            -- Giant point blank AOE\n\n            drawer:addTimedCircle(\n                timeout,\n                pos.x,\n                pos.y,\n                pos.z,\n                11,\n                50,\n                Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n            )\n\n\n        elseif e.contentid == 2010778 then\n            -- Forward and backward slice\n\n            local h1 = math.fmod(pos.h + 1.5 * math.pi, 2 * math.pi) - math.pi\n            local h2 = math.fmod(pos.h + 0.5 * math.pi, 2 * math.pi) - math.pi\n\n            drawer:addTimedRect(\n                timeout,\n                pos.x,\n                pos.y,\n                pos.z,\n                50,\n                5,\n                h1,\n                Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n            )\n\n            drawer:addTimedRect(\n                timeout,\n                pos.x,\n                pos.y,\n                pos.z,\n                50,\n                5,\n                h2,\n                Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n            )\n\n\n        elseif e.contentid == 2010777 then\n            -- Forward-only slice\n\n            local h = math.fmod(pos.h + 1.5 * math.pi, 2 * math.pi) - math.pi\n\n            drawer:addTimedRect(\n                timeout,\n                pos.x,\n                pos.y,\n                pos.z,\n                50,\n                5,\n                h,\n                Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n            )\n\n        end\n    end\nend\n\nself.used = true",
						conditions = 
						{
							
							{
								"43c7ff96-174e-0177-9640-534c84bfa919",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSGE3_CD",
						uuid = "9daad067-56bf-7168-a545-e23668772fdc",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						dequeueIfLuaFalse = true,
						localmapid = 144,
						uuid = "43c7ff96-174e-0177-9640-534c84bfa919",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Self",
						dequeueIfLuaFalse = true,
						uuid = "121faf86-a33e-c0a6-b8ad-45a2618fdfea",
						version = 3,
					},
				},
			},
			enabled = false,
			eventType = 2,
			name = "Slice is Right",
			uuid = "e2c6aa8a-460b-c4da-b769-cbd5513752be",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl