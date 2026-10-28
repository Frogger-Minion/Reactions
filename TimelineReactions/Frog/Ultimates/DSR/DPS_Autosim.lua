local tbl =
{

	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "c3177804-d9fb-0758-524d-74fe6a9a6b14",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable Duty Helper",
				uuid = "682beece-c4b0-97ad-ab3d-f25d03c84408",
				version = 2,
			},
			inheritedObjectUUID = "0aa4264a-c853-7cad-8e8d-9e7d2d367ef3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set Toggles",
				uuid = "cb340422-3f4a-8921-8acc-9f9c8e309588",
				version = 2,
			},
			inheritedObjectUUID = "2294072d-64d7-f529-92a7-e028d0fe6003",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Check Stance",
				uuid = "4b6e0ff9-63bf-4eb5-b139-f62279122020",
				version = 2,
			},
			inheritedObjectUUID = "8b091900-941e-3545-99fd-0d6ed74171e7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DRG] Force move in",
				uuid = "d1a12752-5091-b0a8-a443-3f250042e9cf",
				version = 2,
			},
			inheritedObjectUUID = "ae21405e-af61-f2e3-a420-6c63348b9617",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set custom cone angle",
				uuid = "fc0f5bbe-f06f-9030-8b07-d40c120eabf6",
				version = 2,
			},
			inheritedObjectUUID = "a6e75154-2021-4960-aaf0-adf7f31723e7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Add blacklists",
				uuid = "8d2a1f6b-f81e-4ffe-ae76-c6491331095e",
				version = 2,
			},
			inheritedObjectUUID = "2036e7b4-d472-fe89-a812-1e107eb9210a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Force early bana",
				uuid = "748f91f4-3e7a-0ded-b8f4-c4fad6e17c6f",
				version = 2,
			},
			inheritedObjectUUID = "5907e7e4-f3d8-35e5-b69b-233f067f14ae",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "60aee82b-4e6b-7da7-0c2b-c6c5a42f453b",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH] Wipe potion queue cleanup",
				uuid = "5f6ef262-bc7a-199d-b98b-f7a5de646d12",
				version = 2,
			},
			inheritedObjectUUID = "83716412-ffb1-27dc-9b56-d9076813a8c3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] P2 opening Wildfire and Hypercharge delay",
				uuid = "0f247151-bc8e-e555-b65e-b68b92cb92d6",
				version = 2,
			},
			inheritedObjectUUID = "2c30bf99-8a4e-7818-a5c8-b304c7973ed9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Observe PB and Nadi",
				uuid = "98a814e4-c4e4-0db6-b04b-065ea2734090",
				version = 2,
			},
			inheritedObjectUUID = "460283a1-4bb5-f6a4-9af2-7d9be41c6608",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Reset PB observation on death",
				uuid = "cac74758-0622-42f2-a7d6-5dc5d44face2",
				version = 2,
			},
			inheritedObjectUUID = "f3250246-daa3-a4df-a0f0-b9b4339ffa98",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] P2 burst hold fallback after full P1",
				uuid = "db51c70d-cef1-51b4-8e66-182441b4ab4e",
				version = 2,
			},
			inheritedObjectUUID = "8499b489-ed5a-9514-a57d-42d94cffe205",
			inheritedOverwrites =
			{
				enabled = false,
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
							actionLua = "local player=TensorCore.mGetPlayer()\nif not player or (player.job~=25 and player.job~=34 and player.job~=39) or data.dsrBrdAutoSim then return end\nif TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})then return end\nlocal api=TensorCore.API.TensorACR\nlocal now=api.getAutoSimTime();local timer=TensorReactions_CurrentTimer\nif type(now)~=\"number\" or type(timer)~=\"number\" then return end\nlocal offset=now-timer\nlocal s=data.frog_dsr_blm_p1_movement\nif s and now>=s.last and math.abs(offset-s.offset)<1 then s.last=now;self.used=true return end\ndata.frog_dsr_blm_p1_movement={offset=offset,last=now}\napi.clearAutoSimPhases(\"CasterDowntime\")\nlocal windows={\n {35.940,37.870},\n {42.870,44.620},\n {45.010,46.950},\n {57.890,59.930},\n {64.250,66.689},\n {73.363,76.988},\n {86.814,89.646},\n {100.800,103.083},\n {105.810,109.114},\n {222.186,224.508},\n {226.851,229.055},\n {232.437,243.836},\n}\nif player.job~=25 then windows={{87.02,91.28},{217.20,219.22},{221.44,223.91},{226.92,228.06}}end\nfor _,w in ipairs(windows)do\n local a,b=math.max(0,offset+w[1]),offset+w[2]\n if b>math.max(a,now)then api.addAutoSimPhase(\"CasterDowntime\",a,b)end\nend\nself.used=true",
							conditions =
							{

								{
									"f457556d-a5c4-97c8-b23c-d96164c0f280",
									true,
								},
							},
							name = "Forecast P1 movement",
							uuid = "9bda64cd-e64e-3309-bc64-411c5253f01f",
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
							conditionLua = "local p=TensorCore.mGetPlayer();return p and (p.job==25 or p.job==34 or p.job==39)",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "BLACKMAGE",
							name = "Casting jobs",
							uuid = "f457556d-a5c4-97c8-b23c-d96164c0f280",
							version = 3,
						},
					},
				},
				loop = true,
				name = "[AutoSim] P1 movement forecast",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 250,
				timerStartOffset = -60,
				uuid = "6e3cab13-6955-afa0-88a2-058864da3b1b",
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
							actionLua = "local s=data.dsrBrdAutoSim\nlocal p=TensorCore.mGetPlayer()\nif not s or not s.meleeMove or not p or (p.job~=34 and p.job~=39)then self.used=true return end\nlocal api=TensorCore.API.TensorACR\nlocal now=api.getAutoSimTime()\nlocal id=eventArgs.spellID\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then self.used=true return end\nlocal duration=eventArgs.channelTimeMax\nif id==28060 then\n local key=s.exaAt\n if not key or now-key>10 then s.exaAt=now;s.exaSources={}end\n s.exaSources[e.id]={x=e.pos.x,z=e.pos.z,h=e.pos.h,first=now+duration+.25}\n s.meleeMove(\"exa-in\",now+duration+.25,now+duration+1.85)\n local boss\n for _,b in pairs(TensorCore.entityList(\"contentid=11319,targetable,alive\")or{})do boss=b;break end\n if boss then\n  for _,ray in pairs(s.exaSources)do\n   local first,last\n   for step=1,5 do\n    for _,rotation in ipairs({0,math.pi/2,-math.pi/2})do\n     local h=ray.h+rotation\n     local x,z=ray.x+math.sin(h)*7*step,ray.z+math.cos(h)*7*step\n     for _,side in ipairs({-math.pi/4,0,math.pi/4})do\n      local bh=boss.pos.h+math.pi+side\n      local rx,rz=boss.pos.x+math.sin(bh)*(boss.hitradius+1),boss.pos.z+math.cos(bh)*(boss.hitradius+1)\n      if (x-rx)^2+(z-rz)^2<42.25 then\n       local at=ray.first+step*1.9\n       first=math.min(first or at,at);last=math.max(last or at,at)\n      end\n     end\n    end\n   end\n   if first then s.meleeMove(\"exa-follow-\"..ray.x..\":\"..ray.z,first-.9,last+.55)end\n  end\n end\nelseif id==28058 then\n s.gigaFirst=now+duration+.25\n s.meleeMove(\"gigaflare\",s.gigaFirst,s.gigaFirst+8.35)\nelseif id==28115 and s.gigaFirst then\n s.meleeMove(\"gigaflare\",s.gigaFirst,now+duration+.6)\nelseif id==27939 or id==27940 or id==27942 or id==27943 then\n s.wings={time=now,x=e.pos.x,z=e.pos.z,partyFar=id==27939 or id==27942,ends=now+duration+.3}\n s.meleeMove(\"wings-position\",now+.6,now+(s.wings.partyFar and 4.6 or 2.3))\n s.meleeMove(\"wings-return\",s.wings.ends,s.wings.ends+1.8)\nelseif id==27966 then\n local w=s.wings\n if w and now-w.time<8 and w.partyFar and (e.pos.x-100)*(w.x-100)>0 then\n  local finish=now+duration+1.1\n  s.meleeMove(\"wings-range\",w.time+1,finish,\"MeleeDowntime\")\n  s.meleeMove(\"wings-escape\",now,now+1.5)\n end\nend\nself.used=true",
							conditions =
							{

								{
									"322dd828-0a4d-afe7-8632-9cefba6f8e79",
									true,
								},
							},
							name = "Forecast movement and range loss",
							uuid = "1750c27e-275d-a033-aef3-f9475126b835",
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
							name = "Movement mechanics",
							spellIDList =
							{
								28060,
								28058,
								28115,
								27939,
								27940,
								27942,
								27943,
								27966,
							},
							uuid = "322dd828-0a4d-afe7-8632-9cefba6f8e79",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				name = "[AutoSim] Melee movement patterns",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2000,
				timerStartOffset = -60,
				uuid = "9fdc6553-63e8-8e9c-bd10-1ddd09dc1dc3",
				version = 2,
			},
		},
	},

	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5b91a01b-4de8-febf-6944-cbf166d1fe6b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Move",
				uuid = "4b0cdc0d-c55e-6093-89dc-ea5830b59051",
				version = 2,
			},
			inheritedObjectUUID = "ad5d7f8b-51cf-70b8-a50a-b0b2596409f2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold Jumps",
				uuid = "7d074289-e20d-0e98-916c-450cff76a666",
				version = 2,
			},
			inheritedObjectUUID = "9678637d-ab47-8452-a185-03b5b3593b33",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},

	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9676279a-034f-8afe-28f8-f158b65c70ea",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "6a863fea-9ecb-a4a5-8141-57760f86f8af",
				version = 2,
			},
			inheritedObjectUUID = "3ac9cc9c-53b4-bf8b-8606-8d01d45f81e6",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "f1eb7190-0e66-5d79-aba5-4919c240ea14",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[7] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b855160e-8c79-904a-2cbf-ef746dd0099e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "d77d97b9-5912-ae93-adae-ece987e812c1",
				version = 2,
			},
			inheritedObjectUUID = "d6dbb2b3-9586-30a9-b87e-dc262b5aa7b3",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "72ed2550-44eb-fbdf-8b0c-4783b49f967c",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[8] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7a3d0935-3b11-8519-99b0-4ee7c7dec885",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "317425ee-229f-1145-b112-7c6821edfebc",
				version = 2,
			},
			inheritedObjectUUID = "02195257-601b-cf00-84e3-8719dd2aa59d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[10] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a9e558f8-bf52-8834-a547-821e931a4a08",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw line with marker",
				uuid = "cb966dfc-6f73-98ec-aec4-7b51af6115da",
				version = 2,
			},
			inheritedObjectUUID = "8b9646c0-e3b3-4629-91b9-d660e96b0c0f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "77991907-6d7b-6d1b-b768-c92555d0be17",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[11] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "df4a3391-2cf8-0c5d-3b4c-de5f94eefd61",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "edf1ffe0-5d14-5b8e-940e-4254ffa56e9f",
				version = 2,
			},
			inheritedObjectUUID = "d4101bf7-449d-dc38-8109-872065764be1",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "ffccfa51-0841-7f75-a680-bc7ecb00a06e",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[12] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b7620d1e-d367-790a-97ca-cdf855c4046e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw knockback",
				uuid = "ae8cdc30-1d52-e9fc-8fb6-31ee796399d1",
				version = 2,
			},
			inheritedObjectUUID = "64bca99e-e346-d588-9670-dfcfaee3ae42",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw orb radius",
				uuid = "56a0c4bf-9719-eb12-8bb4-f528b1717ff2",
				version = 2,
			},
			inheritedObjectUUID = "349e6a46-7db0-5ce2-a0bb-2a30ae747610",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[13] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4d67695f-5438-df8b-cd2f-a89179a3bd2f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "2a70e699-936c-432c-8c2a-fc1bd5512364",
				version = 2,
			},
			inheritedObjectUUID = "6a0844ef-1566-1c4e-a84f-fe64e619b0c2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Hold for AOE",
				uuid = "40c9f76c-25d1-8620-8cf8-0d484d89c3d7",
				version = 2,
			},
			inheritedObjectUUID = "8ad9d1b5-485f-3638-80bc-5330e2b548b1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[14] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b42c6e94-f6e9-6a18-edd3-e96a1608d164",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Jumps off",
				uuid = "8e1a0980-2c8f-a478-97c2-5e54e4b31b09",
				version = 2,
			},
			inheritedObjectUUID = "72b0ed25-4eb0-de71-a79e-3995d12e9c0c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "0fbe00bb-8d64-7ae7-bf4e-c689df94654b",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[15] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "aab1e5bd-97a0-d3b1-9e49-76ebe6457bcd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw knockback",
				uuid = "e87c6861-9ddb-52de-a444-afc85ff35a0b",
				version = 2,
			},
			inheritedObjectUUID = "13031b79-354d-0b21-8aca-62dfd2f7b7fd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "673dbaf9-1111-7e8d-9406-2d97d44c3d7c",
				version = 2,
			},
			inheritedObjectUUID = "59945ef1-4fbe-db92-aea3-448473890f3b",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "4b41f54e-341e-01a8-a2bb-6af3afdf814e",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "TTS Marker Type",
				uuid = "70e6758e-7581-46b5-b7b1-73f620d5ed75",
				version = 2,
			},
			inheritedObjectUUID = "34671482-090f-3e70-a579-90ed350eefc1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Disable Hold AOE",
				uuid = "ba81ca9e-3903-560e-acc7-d4130ae5c691",
				version = 2,
			},
			inheritedObjectUUID = "685b1c36-6114-55da-9e07-eb87b783aff2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "2e166562-50da-653e-5285-e28003d8fc72",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[16] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ffee746a-97bd-30be-a211-e394abfd797a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "038a5426-4d57-99c1-853e-6a871c12d575",
				version = 2,
			},
			inheritedObjectUUID = "8a1400e6-a6e6-625f-9289-47609a48dd39",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[17] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b06401eb-891b-0a7f-9897-5abdf29ec17b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[18] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e7be5c80-9bed-ab3c-66b0-89268520a3d0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[DNC] Disable Hold AOE",
				uuid = "9a85197a-9ef0-1b1d-8d6b-1640430df908",
				version = 2,
			},
			inheritedObjectUUID = "cd1e9a45-d22f-5d60-846c-8bfd9ba62325",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[21] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "34b71dcc-992f-4a88-b852-e5e6b697a69c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "6081f5c3-2725-2b3a-a039-4f03635f3bd7",
				version = 2,
			},
			inheritedObjectUUID = "d9d8042e-93ef-497f-985c-06443095be5f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[24] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e0fdf429-ec5a-7c4d-10c3-2753e74021b9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "edb1e0f4-2524-63ff-8ff0-7358d159264f",
				version = 2,
			},
			inheritedObjectUUID = "98ff5c5c-ead6-f6d7-bf8d-52d83464a799",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[29] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "94f06fc4-8b35-a450-84a4-fdde42458514",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[35] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "bb2e8b67-4492-18eb-f158-31b127a771f7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[36] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a1034260-485a-8594-f174-8ebe19a337b0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable DoTs",
				uuid = "a0e5d5c0-81bf-83de-adb9-f270bc59fb65",
				version = 2,
			},
			inheritedObjectUUID = "6f02ff7d-1b27-325d-81f4-292c8e96429d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[38] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fcf5b6ca-0cf9-2b26-f5a5-093cbfd816da",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "06fc195d-8703-ac88-b25f-c6aa273cd65f",
				version = 2,
			},
			inheritedObjectUUID = "0f01afdc-1b6b-87c9-9d21-8d73895ac956",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "70439a29-08c2-ddfd-951b-3e93ff525939",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH] Prioritise Queen in P2 opener",
				uuid = "53a0f9a3-50f1-2192-8c0e-3bc1affbd198",
				version = 2,
			},
			inheritedObjectUUID = "63e244a9-3773-7ed7-9d7a-b393e8dd4bad",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "64911666-a9e7-b33c-b130-79d76102b42b",
			},
			objectType = "folder",
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
							actionLua = "local acr=TensorCore.API.TensorACR\nlocal s={nextBoundary=1,primaryID=nil,secondaryID=nil,phase=\"p2\"}\ndata.dsrBrdAutoSim=s\nlocal function point(t,c,up,phase,slot) return {time=t,cid=c,up=up,phase=phase,slot=slot} end\ns.points={\n point(32.360,3632,false,\"p2\",0),point(63.532,3632,true,\"p2\",0),\n point(100.594,3632,false,\"p2\",0),point(151.516,3632,true,\"p2\",0),point(188.313,3632,false,\"p2\",0),\n point(197.610,3458,true,\"p3\",0),point(309.438,3458,false,\"p3\",0),\n point(326.703,11318,true,\"eyes\",0),point(326.703,11317,true,\"eyes\",1),\n point(385.313,11317,false,\"eyes\",1),point(390.156,11318,false,\"eyes\",0),\n point(410.234,3642,true,\"intermission\",0),point(447.891,3642,false,\"intermission\",0),\n point(447.891,11320,true,\"intermission\",0),point(458.609,11320,false,\"intermission\",0),\n point(473.656,3632,true,\"p5\",0),point(505.719,3632,false,\"p5\",0),\n point(528.750,3632,true,\"p5\",0),point(566.234,3632,false,\"p5\",0),\n point(612.344,3632,true,\"p5\",0),point(643.328,3632,false,\"p5\",0),\n point(653.656,3458,true,\"p6\",0),point(653.656,4954,true,\"p6\",1),\n point(694.531,3458,false,\"p6\",0),point(708.047,3458,true,\"p6\",0),\n point(719.484,4954,false,\"p6\",1),point(735.172,4954,true,\"p6\",1),\n point(797.766,3458,false,\"p6\",0),point(797.766,4954,false,\"p6\",1),\n point(812.313,3458,true,\"p6\",0),point(812.313,4954,true,\"p6\",1),\n point(820.688,4954,false,\"p6\",1),point(822.094,3458,false,\"p6\",0),\n point(874.250,11319,true,\"p7\",0),point(1095.550,11319,false,\"p7\",0),\n}\ns.lifetimes={{0,0,5},{0,6,7},{0,8,11},{1,9,10},{0,12,13},{0,14,15},\n {0,16,21},{0,22,33},{1,23,32},{0,34,35}}\ns.windows={{0,0,1},{0,2,3},{0,4,5},{0,6,7},{0,8,11},{1,9,10},\n {0,12,13},{0,14,15},{0,16,17},{0,18,19},{0,20,21},\n {0,22,24},{0,25,28},{0,30,33},{1,23,26},{1,27,29},{1,31,32},{0,34,35}}\ns.buffStarts={{0,5.157},{0,5.297},{4,-1.437},{4,1.047},{6,77.249},{6,77.812},{12,2.985},{12,5.438},{18,5.031},{18,7.547},{22,3.547},{22,3.703},{22,125.657},{22,127.016},{34,25.063},{34,30.328},{34,145.063},{34,150.328},{34,265.063},{34,270.328}}\nfunction s.at(i) return i==0 and 0 or s.points[i].time end\ns.windows[#s.windows+1]={0,24,24,1.313,10.297}\ns.windows[#s.windows+1]={1,26,26,1.360,10.454}\ns.windows[#s.windows+1]={0,28,28,1.312,7.406}\ns.windows[#s.windows+1]={1,29,29,1.312,7.406}\nfunction s.windowStart(w) return s.at(w[2])+(w[4] or 0) end\nfunction s.windowEnd(w) return s.at(w[3])+(w[5] or 0) end\nfunction s.rebuildPersonalStop()\n acr.clearAutoSimPhases(\"Stun\")\n local a=s.wb2ActualStopAt or s.at(28)+(s.wb2StopOffset or 5.609)\n local b=s.wb2TouchdownAt or math.min(s.at(30),s.at(31))\n if b>a then acr.addAutoSimPhase(\"Stun\",a,b) end\nend\nfunction s.available(slot,now)\n for _,w in ipairs(s.windows) do\n  if w[1]==slot and now>=s.windowStart(w) and now<s.windowEnd(w) then return true end\n end\n return false\nend\nfunction s.rebuildBuffs()\n s.rebuildCasterMovement()\n s.rebuildMeleeMovement()\n acr.clearAutoSimPhases(\"RaidBuff\")\n local windows={}\n local kill=s.points[35].time\n for _,v in ipairs(s.buffStarts) do\n  local a=s.at(v[1])+v[2]\n  local b=math.min(a+20,kill)\n  if b>a then windows[#windows+1]={a,b} end\n end\n table.sort(windows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(windows) do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\nend\nfunction s.rebuildAOE()\n acr.clearAutoSimPhases(\"Line25Yd\")\n for _,primary in ipairs(s.windows) do\n  if primary[1]==0 then\n   for _,secondary in ipairs(s.windows) do\n    if secondary[1]==1 then\n     local a=math.max(s.windowStart(primary),s.windowStart(secondary))\n     local b=math.min(s.windowEnd(primary),s.windowEnd(secondary))\n     if b>a then acr.addAutoSimPhase(\"Line25Yd\",a,b,2) end\n    end\n   end\n  end\n end\nend\ns.blmCasterWindows={\n {1,3.622,7.460},\n {1,10.002,18.244},\n {1,18.932,25.300},\n {1,25.983,28.244},\n {3,3.911,9.101},\n {3,16.860,22.342},\n {3,28.848,31.754},\n {3,47.530,51.473},\n {5,0.395,4.723},\n {6,22.015,23.979},\n {6,28.874,31.797},\n {6,37.875,39.845},\n {6,50.288,55.577},\n {6,64.205,68.482},\n {7,0.684,2.598},\n {9,19.626,22.857},\n {9,44.927,48.157},\n {9,48.812,52.633},\n {10,8.105,10.704},\n {12,21.595,23.943},\n {12,26.402,28.417},\n {12,31.562,33.872},\n {17,3.377,6.992},\n {17,16.361,22.858},\n {19,2.319,5.261},\n {19,14.135,17.965},\n {19,18.319,20.880},\n {19,27.894,30.167},\n {20,23.239,25.893},\n {20,30.570,33.896},\n {23,30.356,33.877},\n {24,4.172,9.469},\n {24,11.922,16.094},\n {26,4.414,10.578},\n {26,11.410,28.063},\n {27,31.355,35.750},\n {27,39.768,41.900},\n {27,46.126,50.205},\n {27,51.800,53.981},\n {29,0.126,3.740},\n {29,10.038,12.520},\n {33,3.486,8.855},\n {34,25.920,29.815},\n {34,53.142,55.112},\n {34,59.698,68.782},\n {34,105.286,108.472},\n {34,126.379,131.037},\n {34,132.737,137.643},\n {34,139.302,148.308},\n {34,159.396,162.302},\n {34,184.707,189.293},\n {34,206.992,209.003},\n {34,209.723,212.068},\n}\nfunction s.rebuildCasterMovement()\n local player=TensorCore.mGetPlayer()\n if not player or player.job~=25 then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.blmCasterWindows)do\n  local base=s.at(w[1]);local a,b=math.max(0,base+w[2]),base+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={a,b}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\n\ns.meleeCasterWindows={\n {1,-19.956,-18.486},\n {6,29.038,31.748},\n {6,32.798,34.598},\n {6,48.024,49.804},\n {6,53.989,55.439},\n {6,57.744,59.854},\n {6,62.484,65.192},\n {6,66.261,68.972},\n {9,17.493,21.833},\n {9,48.576,53.201},\n {9,53.631,55.141},\n {12,16.055,18.505},\n {12,21.533,23.333},\n {12,26.037,28.767},\n {23,12.122,16.812},\n {25,8.271,12.923},\n {26,11.593,20.773},\n {27,8.874,9.724},\n}\ns.meleeMovingPhases={}\nfunction s.rebuildMeleeMovement()\n local p=TensorCore.mGetPlayer()\n if not p or (p.job~=34 and p.job~=39)then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.meleeCasterWindows)do\n  local a,b=s.at(w[1])+w[2],s.at(w[1])+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={math.max(0,a),b}end\n end\n for _,w in pairs(s.meleeMovingPhases)do\n  if w[3]==\"CasterDowntime\" and w[2]>math.max(w[1],now)then spans[#spans+1]={w[1],w[2]}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\nfunction s.meleeMove(key,a,b,kind)\n local p=TensorCore.mGetPlayer()\n if not p or (p.job~=34 and p.job~=39)then return end\n kind=kind or \"CasterDowntime\"\n local old=s.meleeMovingPhases[key]\n if old and old[4]then acr.removeAutoSimPhase(old[4])end\n s.meleeMovingPhases[key]={a,b,kind}\n if kind==\"CasterDowntime\"then s.rebuildMeleeMovement()\n else s.meleeMovingPhases[key][4]=acr.addAutoSimPhase(kind,a,b)end\nend\n\nfunction s.rebuild()\n local kill=s.points[35].time\n acr.setAutoSimKillTime(kill)\n acr.clearAutoSimPhases(\"DotAvailability\",0);acr.clearAutoSimPhases(\"DotAvailability\",1)\n acr.clearAutoSimPhases(\"TargetLifetime\",0);acr.clearAutoSimPhases(\"TargetLifetime\",1)\n acr.clearAutoSimPhases(\"FullDowntime\")\n for _,v in ipairs(s.lifetimes) do\n  local a,b=s.at(v[2]),s.at(v[3])\n  if b>a then acr.addAutoSimPhase(\"TargetLifetime\",a,b,1,v[1]) end\n end\n local union={}\n for _,v in ipairs(s.windows) do\n  local a,b=s.windowStart(v),s.windowEnd(v)\n  if b>a then\n   local dotEnd=b\n   if v[1]==1 and v[2]==9 and s.leftEyeDotStopAt then dotEnd=math.min(dotEnd,s.leftEyeDotStopAt) end\n   if dotEnd>a then acr.addAutoSimPhase(\"DotAvailability\",a,dotEnd,1,v[1]) end\n   union[#union+1]={a,b}\n  end\n end\n table.sort(union,function(a,b)return a[1]<b[1]end)\n local previous=0\n for _,v in ipairs(union) do\n  if v[1]>previous then acr.addAutoSimPhase(\"FullDowntime\",previous,v[1]) end\n  previous=math.max(previous,v[2])\n end\n if previous<kill then acr.addAutoSimPhase(\"FullDowntime\",previous,kill) end\n s.rebuildAOE()\n s.rebuildPersonalStop()\n s.rebuildBuffs()\n acr.clearAutoSimUncertainty()\n local now=acr.getAutoSimTime()\n acr.addAutoSimUncertainty(now,1)\n local nextPoint=s.points[s.nextBoundary]\n if nextPoint and s.nextBoundary<35 and nextPoint.time-12>now then\n  acr.addAutoSimUncertainty(nextPoint.time-12,4)\n end\n if kill-25>now then acr.addAutoSimUncertainty(kill-25,20) end\nend\nfunction s.resync(i,now)\n local delta=now-s.points[i].time\n local first=i\n while first>s.nextBoundary and math.abs(s.points[first-1].time-s.points[i].time)<1 do first=first-1 end\n for n=first,#s.points do s.points[n].time=s.points[n].time+delta end\n s.nextBoundary=i+1;s.phase=s.points[i].phase\n s.rebuild()\nend\nlocal thordan=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})\nif thordan then s.primaryID=thordan.id;acr.setAutoSimTarget(0,thordan.id) end\nacr.clearAutoSimTarget(1)\ns.rebuild()\nself.used=true",
							name = "Initialize DSR checkpoint",
							uuid = "059bb825-a105-47d3-801f-51219dc1d81a",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 291.5,
				name = "[AutoSim] Initialize DSR checkpoint",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = -286.5,
				timerStartOffset = -321.5,
				uuid = "33a31954-a984-dabc-b078-eca4b2414378",
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
							actionLua = "local acr=TensorCore.API.TensorACR\nlocal s={nextBoundary=1,primaryID=nil,secondaryID=nil,phase=\"p2\"}\ndata.dsrBrdAutoSim=s\nlocal function point(t,c,up,phase,slot) return {time=t,cid=c,up=up,phase=phase,slot=slot} end\ns.points={\n point(32.360,3632,false,\"p2\",0),point(63.532,3632,true,\"p2\",0),\n point(100.594,3632,false,\"p2\",0),point(151.516,3632,true,\"p2\",0),point(188.313,3632,false,\"p2\",0),\n point(197.610,3458,true,\"p3\",0),point(309.438,3458,false,\"p3\",0),\n point(326.703,11318,true,\"eyes\",0),point(326.703,11317,true,\"eyes\",1),\n point(385.313,11317,false,\"eyes\",1),point(390.156,11318,false,\"eyes\",0),\n point(410.234,3642,true,\"intermission\",0),point(447.891,3642,false,\"intermission\",0),\n point(447.891,11320,true,\"intermission\",0),point(458.609,11320,false,\"intermission\",0),\n point(473.656,3632,true,\"p5\",0),point(505.719,3632,false,\"p5\",0),\n point(528.750,3632,true,\"p5\",0),point(566.234,3632,false,\"p5\",0),\n point(612.344,3632,true,\"p5\",0),point(643.328,3632,false,\"p5\",0),\n point(653.656,3458,true,\"p6\",0),point(653.656,4954,true,\"p6\",1),\n point(694.531,3458,false,\"p6\",0),point(708.047,3458,true,\"p6\",0),\n point(719.484,4954,false,\"p6\",1),point(735.172,4954,true,\"p6\",1),\n point(797.766,3458,false,\"p6\",0),point(797.766,4954,false,\"p6\",1),\n point(812.313,3458,true,\"p6\",0),point(812.313,4954,true,\"p6\",1),\n point(820.688,4954,false,\"p6\",1),point(822.094,3458,false,\"p6\",0),\n point(874.250,11319,true,\"p7\",0),point(1095.550,11319,false,\"p7\",0),\n}\ns.lifetimes={{0,0,5},{0,6,7},{0,8,11},{1,9,10},{0,12,13},{0,14,15},\n {0,16,21},{0,22,33},{1,23,32},{0,34,35}}\ns.windows={{0,0,1},{0,2,3},{0,4,5},{0,6,7},{0,8,11},{1,9,10},\n {0,12,13},{0,14,15},{0,16,17},{0,18,19},{0,20,21},\n {0,22,24},{0,25,28},{0,30,33},{1,23,26},{1,27,29},{1,31,32},{0,34,35}}\ns.buffStarts={{0,5.157},{0,5.297},{4,-1.437},{4,1.047},{6,77.249},{6,77.812},{12,2.985},{12,5.438},{18,5.031},{18,7.547},{22,3.547},{22,3.703},{22,125.657},{22,127.016},{34,25.063},{34,30.328},{34,145.063},{34,150.328},{34,265.063},{34,270.328}}\nfunction s.at(i) return i==0 and 0 or s.points[i].time end\ns.windows[#s.windows+1]={0,24,24,1.313,10.297}\ns.windows[#s.windows+1]={1,26,26,1.360,10.454}\ns.windows[#s.windows+1]={0,28,28,1.312,7.406}\ns.windows[#s.windows+1]={1,29,29,1.312,7.406}\nfunction s.windowStart(w) return s.at(w[2])+(w[4] or 0) end\nfunction s.windowEnd(w) return s.at(w[3])+(w[5] or 0) end\nfunction s.rebuildPersonalStop()\n acr.clearAutoSimPhases(\"Stun\")\n local a=s.wb2ActualStopAt or s.at(28)+(s.wb2StopOffset or 5.609)\n local b=s.wb2TouchdownAt or math.min(s.at(30),s.at(31))\n if b>a then acr.addAutoSimPhase(\"Stun\",a,b) end\nend\nfunction s.available(slot,now)\n for _,w in ipairs(s.windows) do\n  if w[1]==slot and now>=s.windowStart(w) and now<s.windowEnd(w) then return true end\n end\n return false\nend\nfunction s.rebuildBuffs()\n s.rebuildCasterMovement()\n s.rebuildMeleeMovement()\n acr.clearAutoSimPhases(\"RaidBuff\")\n local windows={}\n local kill=s.points[35].time\n for _,v in ipairs(s.buffStarts) do\n  local a=s.at(v[1])+v[2]\n  local b=math.min(a+20,kill)\n  if b>a then windows[#windows+1]={a,b} end\n end\n table.sort(windows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(windows) do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\nend\nfunction s.rebuildAOE()\n acr.clearAutoSimPhases(\"Line25Yd\")\n for _,primary in ipairs(s.windows) do\n  if primary[1]==0 then\n   for _,secondary in ipairs(s.windows) do\n    if secondary[1]==1 then\n     local a=math.max(s.windowStart(primary),s.windowStart(secondary))\n     local b=math.min(s.windowEnd(primary),s.windowEnd(secondary))\n     if b>a then acr.addAutoSimPhase(\"Line25Yd\",a,b,2) end\n    end\n   end\n  end\n end\nend\ns.blmCasterWindows={\n {1,3.622,7.460},\n {1,10.002,18.244},\n {1,18.932,25.300},\n {1,25.983,28.244},\n {3,3.911,9.101},\n {3,16.860,22.342},\n {3,28.848,31.754},\n {3,47.530,51.473},\n {5,0.395,4.723},\n {6,22.015,23.979},\n {6,28.874,31.797},\n {6,37.875,39.845},\n {6,50.288,55.577},\n {6,64.205,68.482},\n {7,0.684,2.598},\n {9,19.626,22.857},\n {9,44.927,48.157},\n {9,48.812,52.633},\n {10,8.105,10.704},\n {12,21.595,23.943},\n {12,26.402,28.417},\n {12,31.562,33.872},\n {17,3.377,6.992},\n {17,16.361,22.858},\n {19,2.319,5.261},\n {19,14.135,17.965},\n {19,18.319,20.880},\n {19,27.894,30.167},\n {20,23.239,25.893},\n {20,30.570,33.896},\n {23,30.356,33.877},\n {24,4.172,9.469},\n {24,11.922,16.094},\n {26,4.414,10.578},\n {26,11.410,28.063},\n {27,31.355,35.750},\n {27,39.768,41.900},\n {27,46.126,50.205},\n {27,51.800,53.981},\n {29,0.126,3.740},\n {29,10.038,12.520},\n {33,3.486,8.855},\n {34,25.920,29.815},\n {34,53.142,55.112},\n {34,59.698,68.782},\n {34,105.286,108.472},\n {34,126.379,131.037},\n {34,132.737,137.643},\n {34,139.302,148.308},\n {34,159.396,162.302},\n {34,184.707,189.293},\n {34,206.992,209.003},\n {34,209.723,212.068},\n}\nfunction s.rebuildCasterMovement()\n local player=TensorCore.mGetPlayer()\n if not player or player.job~=25 then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.blmCasterWindows)do\n  local base=s.at(w[1]);local a,b=math.max(0,base+w[2]),base+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={a,b}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\n\ns.meleeCasterWindows={\n {1,-19.956,-18.486},\n {6,29.038,31.748},\n {6,32.798,34.598},\n {6,48.024,49.804},\n {6,53.989,55.439},\n {6,57.744,59.854},\n {6,62.484,65.192},\n {6,66.261,68.972},\n {9,17.493,21.833},\n {9,48.576,53.201},\n {9,53.631,55.141},\n {12,16.055,18.505},\n {12,21.533,23.333},\n {12,26.037,28.767},\n {23,12.122,16.812},\n {25,8.271,12.923},\n {26,11.593,20.773},\n {27,8.874,9.724},\n}\ns.meleeMovingPhases={}\nfunction s.rebuildMeleeMovement()\n local p=TensorCore.mGetPlayer()\n if not p or (p.job~=34 and p.job~=39)then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.meleeCasterWindows)do\n  local a,b=s.at(w[1])+w[2],s.at(w[1])+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={math.max(0,a),b}end\n end\n for _,w in pairs(s.meleeMovingPhases)do\n  if w[3]==\"CasterDowntime\" and w[2]>math.max(w[1],now)then spans[#spans+1]={w[1],w[2]}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\nfunction s.meleeMove(key,a,b,kind)\n local p=TensorCore.mGetPlayer()\n if not p or (p.job~=34 and p.job~=39)then return end\n kind=kind or \"CasterDowntime\"\n local old=s.meleeMovingPhases[key]\n if old and old[4]then acr.removeAutoSimPhase(old[4])end\n s.meleeMovingPhases[key]={a,b,kind}\n if kind==\"CasterDowntime\"then s.rebuildMeleeMovement()\n else s.meleeMovingPhases[key][4]=acr.addAutoSimPhase(kind,a,b)end\nend\n\nfunction s.rebuild()\n local kill=s.points[35].time\n acr.setAutoSimKillTime(kill)\n acr.clearAutoSimPhases(\"DotAvailability\",0);acr.clearAutoSimPhases(\"DotAvailability\",1)\n acr.clearAutoSimPhases(\"TargetLifetime\",0);acr.clearAutoSimPhases(\"TargetLifetime\",1)\n acr.clearAutoSimPhases(\"FullDowntime\")\n for _,v in ipairs(s.lifetimes) do\n  local a,b=s.at(v[2]),s.at(v[3])\n  if b>a then acr.addAutoSimPhase(\"TargetLifetime\",a,b,1,v[1]) end\n end\n local union={}\n for _,v in ipairs(s.windows) do\n  local a,b=s.windowStart(v),s.windowEnd(v)\n  if b>a then\n   local dotEnd=b\n   if v[1]==1 and v[2]==9 and s.leftEyeDotStopAt then dotEnd=math.min(dotEnd,s.leftEyeDotStopAt) end\n   if dotEnd>a then acr.addAutoSimPhase(\"DotAvailability\",a,dotEnd,1,v[1]) end\n   union[#union+1]={a,b}\n  end\n end\n table.sort(union,function(a,b)return a[1]<b[1]end)\n local previous=0\n for _,v in ipairs(union) do\n  if v[1]>previous then acr.addAutoSimPhase(\"FullDowntime\",previous,v[1]) end\n  previous=math.max(previous,v[2])\n end\n if previous<kill then acr.addAutoSimPhase(\"FullDowntime\",previous,kill) end\n s.rebuildAOE()\n s.rebuildPersonalStop()\n s.rebuildBuffs()\n acr.clearAutoSimUncertainty()\n local now=acr.getAutoSimTime()\n acr.addAutoSimUncertainty(now,1)\n local nextPoint=s.points[s.nextBoundary]\n if nextPoint and s.nextBoundary<35 and nextPoint.time-12>now then\n  acr.addAutoSimUncertainty(nextPoint.time-12,4)\n end\n if kill-25>now then acr.addAutoSimUncertainty(kill-25,20) end\nend\nfunction s.resync(i,now)\n local delta=now-s.points[i].time\n local first=i\n while first>s.nextBoundary and math.abs(s.points[first-1].time-s.points[i].time)<1 do first=first-1 end\n for n=first,#s.points do s.points[n].time=s.points[n].time+delta end\n s.nextBoundary=i+1;s.phase=s.points[i].phase\n s.rebuild()\nend\nlocal thordan=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})\nif thordan then s.primaryID=thordan.id;acr.setAutoSimTarget(0,thordan.id) end\nacr.clearAutoSimTarget(1)\ns.rebuild()\nself.used=true",
							conditions =
							{

								{
									"23eb1df9-fe89-3009-aa95-94b05e2741f2",
									true,
								},

								{
									"130c1f2a-86c7-4c0b-9d7a-82c67dc2bd60",
									true,
								},
							},
							name = "Initialize DSR without countdown",
							uuid = "38b8e729-53a3-ed1a-b11e-90c9c61a0299",
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
							name = "Tracked casts",
							spellIDList =
							{
								25544,
							},
							uuid = "23eb1df9-fe89-3009-aa95-94b05e2741f2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.dsrBrdAutoSim == nil",
							name = "Not initialized",
							uuid = "130c1f2a-86c7-4c0b-9d7a-82c67dc2bd60",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 291.5,
				name = "[AutoSim] Initialize DSR without countdown",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = -270,
				timerStartOffset = -321.5,
				uuid = "3a649c35-29dc-f19c-a5e9-06e9d621e75b",
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
							actionLua = "local s=data.dsrBrdAutoSim\nif not s then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nif now<0 then self.used=true return end\nlocal cid,id,up=eventArgs.entityContentID,eventArgs.entityID,eventArgs.isTargetable\nlocal entity=TensorCore.mGetEntity(id)\nif up and (not entity or entity.hp.max<=0 or entity.hp.current<=0) then self.used=true return end\n\n\n\nif up and (cid==3458 or cid==4954) and s.nextBoundary>=22\n and s.nextBoundary<=34 and math.abs(entity.pos.z-100)>30 then self.used=true return end\nlocal best,distance\n\n\nfor i=math.max(1,s.nextBoundary-2),#s.points do\n local p=s.points[i]\n if p.cid==cid and p.up==up then\n  local d=math.abs(now-p.time)\n  if d<=30 and (i>=s.nextBoundary or d<1) and (not distance or d<distance) then best,distance=i,d end\n end\nend\nif not best then self.used=true return end\nlocal p=s.points[best]\n\nif up and (best==30 or best==31) and not s.wb2TouchdownAt then\n s.wb2TouchdownAt=now\n s.rebuildPersonalStop()\nend\nif up then\n if data.dsrBrdBalance then data.dsrBrdBalance.pins[p.slot]=false end\n if p.slot==0 then\n  s.primaryID=id\n  TensorCore.API.TensorACR.setAutoSimTarget(0,id)\n  if p.phase~=\"eyes\" and p.phase~=\"p6\" then\n   s.secondaryID=nil;TensorCore.API.TensorACR.clearAutoSimTarget(1)\n  end\n else\n  s.secondaryID=id;TensorCore.API.TensorACR.setAutoSimTarget(1,id)\n end\nend\nif best>=s.nextBoundary then\n if best==35 then s.nextBoundary=36 else s.resync(best,now) end\nend\nself.used=true",
							conditions =
							{

								{
									"ce0ea281-f709-4dd8-9995-8fd845203882",
									true,
								},
							},
							name = "DSR targetability resync",
							uuid = "9932852c-bc33-51c7-9350-69685710a0dc",
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
							conditionLua = "local c=eventArgs.entityContentID\nreturn c==3632 or c==3458 or c==11317 or c==11318 or c==3642 or c==11320 or c==4954 or c==11319",
							dequeueIfLuaFalse = true,
							name = "DSR actor event",
							uuid = "ce0ea281-f709-4dd8-9995-8fd845203882",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				eventType = 26,
				loop = true,
				mechanicTime = 291.5,
				name = "[AutoSim] DSR targetability resync",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 2000,
				timerStartOffset = -321.5,
				uuid = "598a5910-e33a-ba61-a78f-5cf5e2a60954",
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
							actionLua = "local s=data.dsrBrdAutoSim\nif not s then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal spell=eventArgs.spellID\nif s.buffSeen[spell] and math.abs(now-s.buffSeen[spell])<1 then self.used=true return end\nlocal best,distance\nfor _,v in ipairs(s.buffSpecs) do\n if v[1]==spell and not v.actual then\n  local d=math.abs(now-v.predictedStart)\n  if not distance or d<distance then best,distance=v,d end\n end\nend\nif best and distance<=60 then best.actual=now;s.buffSeen[spell]=now;s.rebuildBuffs() end\nself.used=true",
							conditions =
							{

								{
									"92898594-50e1-512d-9ab5-ee71f9dab2a3",
									true,
								},
							},
							name = "Observe DSR raid buffs",
							uuid = "eb8e2d68-73d7-5e76-9b62-0bc4bba2b6ca",
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
							name = "Tracked casts",
							spellIDList =
							{
								7396,
								34675,
							},
							uuid = "92898594-50e1-512d-9ab5-ee71f9dab2a3",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				enabled = false,
				eventType = 2,
				loop = true,
				mechanicTime = 291.5,
				name = "[AutoSim] Observe DSR raid buffs",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 2000,
				timerStartOffset = -321.5,
				uuid = "57fea3f1-b67d-9a35-9692-b7cfdc46d7b2",
				version = 2,
			},
		},
	},
	[40] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1e775957-e3a0-f3eb-f264-2be54947a1e7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Move",
				uuid = "5b5d67ad-6fc4-8feb-b434-9e788199f760",
				version = 2,
			},
			inheritedObjectUUID = "7bd1e51e-c3ee-9644-8166-7aa7f4e346d0",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "force meikyo after kaeshi",
				uuid = "0f17b0d0-4b9a-4b51-91dd-63570ddd000e",
				version = 2,
			},
			inheritedObjectUUID = "9042258c-5dde-2d95-aeee-11358687207a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[43] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "10c07310-e769-6094-454b-39d22f1c58e0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[45] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b8227802-ea9e-ff1e-2df7-926046700052",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Heavy Impact",
				uuid = "4c90848b-fa87-4f1d-81ad-93c9f1be9e96",
				version = 2,
			},
			inheritedObjectUUID = "0053e5d9-ae8f-1e42-bc21-72da9ce4c8ac",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw spreads",
				uuid = "d8750986-df4c-cceb-bb0a-35b487dd1315",
				version = 2,
			},
			inheritedObjectUUID = "021df5aa-a1a5-8849-86ea-7963b0e8daa4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "c3a03071-55fb-1625-55fb-9a1fb0afdf41",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[46] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f9d06955-1287-2591-4822-db67f388f265",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable DoTs",
				uuid = "c2cdc80b-fbd3-1382-ac4b-7dc6b846566e",
				version = 2,
			},
			inheritedObjectUUID = "d8171a44-2446-b91b-9c18-6ffa374e559f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[BRD] Refresh DoTs",
				uuid = "ff45103b-0590-5609-a4e2-792856e370c7",
				version = 2,
			},
			inheritedObjectUUID = "a53f4cc8-ee3d-ac30-b493-a08e3d606f43",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Mirage Dive",
				uuid = "db1e6260-1754-d1aa-8597-75362e7b79b9",
				version = 2,
			},
			inheritedObjectUUID = "497bb665-cb72-c2ea-99fc-af90173f8636",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "172b2c06-5f2d-bc5f-90d1-1a50bbc04d3f",
				version = 2,
			},
			inheritedObjectUUID = "3cb4e569-50f1-2373-a31b-0b5c5175800d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Predraw dashes",
				uuid = "ccafbe3a-4e9a-999c-a3d7-f3a35ce95361",
				version = 2,
			},
			inheritedObjectUUID = "37491814-6076-2c11-b9ea-ceabdc1938a7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set arenaCenter",
				uuid = "b4125517-6e26-26ce-9a16-be2754ca14d3",
				version = 2,
			},
			inheritedObjectUUID = "8cd9563d-586a-f3e6-9968-fd6d624667be",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[RPR] Disable SoD",
				uuid = "d6f896e4-22fe-0dea-9b30-9157e011dfd0",
				version = 2,
			},
			inheritedObjectUUID = "eb2cf39a-0e38-d9d6-9af2-fc55c91e9768",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Multi] Anti-ghosting",
				uuid = "6d9e16c6-c6f1-dba2-8fd8-89c7ad004105",
				version = 2,
			},
			inheritedObjectUUID = "8fcd0cab-2382-0146-95f2-9fb6bc311ef6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "rai",
				uuid = "b443a08b-e4f1-7de2-976f-40d9fd3ae31d",
				version = 2,
			},
			inheritedObjectUUID = "1ec2a863-d012-a6e9-9c82-94af86f1ef1d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[49] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "dccaf2ae-a3a2-2e72-db32-7bf401e4c7fe",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "29241687-0058-1ea3-9534-98b1f32a520f",
				version = 2,
			},
			inheritedObjectUUID = "4b221daf-d02d-b62c-8a5a-b39dee14e971",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "36308c83-c880-bc86-b77a-c9ac7058f542",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[50] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1e0a8704-c78a-f868-4516-c802074fde54",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Flare",
				uuid = "922eabf1-1ff0-35e1-be67-aeee81deda47",
				version = 2,
			},
			inheritedObjectUUID = "ff877487-0da4-de5e-b35c-59ca6850cbdb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Move",
				uuid = "3259cc13-f69d-4dce-ad8d-7029aa1550d0",
				version = 2,
			},
			inheritedObjectUUID = "36fb5716-fb48-5cac-9677-398759727b3e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Marker Draw",
				uuid = "004fdf9a-e58f-6fc7-8c83-33e35303c74d",
				version = 2,
			},
			inheritedObjectUUID = "701c164e-bd03-4bc4-aabe-f52a1cd7dd0d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw line to Warrior for alignment",
				uuid = "ee9bfc3d-7b09-b356-9c26-5f702621b45f",
				version = 2,
			},
			inheritedObjectUUID = "85f754e5-a6fa-3aee-88cb-1b9ce885c7d1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "cf83e72b-1b72-2237-ff89-807137c216fb",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[56] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1348250e-64fb-f25a-9db4-c31089576dde",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "efc8cf3f-4b54-252a-b45b-21044fd3e669",
				version = 2,
			},
			inheritedObjectUUID = "88423e4a-b4f2-b778-a662-bc91c6f71ce6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[57] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4b69374f-6a7f-74db-4b1b-3a89192acd1f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "0e4e9a3d-41a5-687d-b86e-a521ef5c8421",
				version = 2,
			},
			inheritedObjectUUID = "ac8fda96-f622-5669-9194-ec6b1f89e905",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "4e2077b0-3377-18e9-a66a-438ad0d4825c",
				version = 2,
			},
			inheritedObjectUUID = "0d80b984-6c5d-1da0-bc52-505ac536b586",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "879f50fe-a1f9-ff51-ad4c-5b20d2db2437",
				version = 2,
			},
			inheritedObjectUUID = "6184762a-8312-1a20-96ee-a21cc3cf84f6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "98784e94-5ed2-b0a6-ba5a-93bb94017695",
				version = 2,
			},
			inheritedObjectUUID = "d28e18fe-fc12-7873-8c56-823c8fee9a0a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Blacklist Thordan",
				uuid = "7f527cd0-6e26-efbf-84eb-d4563acce532",
				version = 2,
			},
			inheritedObjectUUID = "6944e884-b924-6940-87c9-5e2423682b6d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable SS prio",
				uuid = "3716f250-5c13-8506-9bc1-d73daa3c2f19",
				version = 2,
			},
			inheritedObjectUUID = "edab9d8a-9e27-e027-86f3-77319f4464a6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "4178536f-c58d-9bb6-8760-a45b7b3946dd",
				version = 2,
			},
			inheritedObjectUUID = "d55052f2-113d-85c0-bb3d-c6f756c72384",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Precast Meikyo",
				uuid = "f04ec120-bfe7-9446-a223-743ad81abc2f",
				version = 2,
			},
			inheritedObjectUUID = "9fd21fb5-6244-b20d-81f8-5d8d51e7c461",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "644d089b-c199-07d7-8213-4358e6711e1c",
				version = 2,
			},
			inheritedObjectUUID = "a8ffcaa7-ebb6-d61b-993a-b6f7e88b1f31",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Precast TN",
				uuid = "0098625f-ddec-fbca-a92c-225b3dec697d",
				version = 2,
			},
			inheritedObjectUUID = "c0f005f2-b01a-3f30-ba6d-0cdf84298586",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DRG] High Jump",
				uuid = "a17800c2-f768-f0fd-b95f-1e1094ed5644",
				version = 2,
			},
			inheritedObjectUUID = "485f7681-e35f-d8dc-af15-a24eb0230a3c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Force early bana",
				uuid = "f88ea3ff-8c02-69ad-b3c8-543194800363",
				version = 2,
			},
			inheritedObjectUUID = "5eba810a-ce8e-bd52-96c8-b173fe666259",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[58] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "eda68d0c-bec7-1330-9ae9-59ba7e756bdc",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "634f4f13-e1e8-e297-afd2-3b79f25942c3",
				version = 2,
			},
			inheritedObjectUUID = "5047fe10-0e6f-b735-8a34-d8a64205032f",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "d6a3ff26-a870-78c2-aae8-ab3402209af6",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[64] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f9bb1a5d-deca-9d99-da5b-b95ff2d783ed",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Check for marker 1",
				uuid = "d2e24c79-6efd-4ff9-9e0a-fea4953ab0ff",
				version = 2,
			},
			inheritedObjectUUID = "b9cc08aa-6871-c2b6-9d7f-ea478f265738",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw heading on knights",
				uuid = "8ae19094-fa4d-533e-b7a4-749287a78475",
				version = 2,
			},
			inheritedObjectUUID = "4e590c1b-5297-17cd-9a00-98fad2d6c818",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "f8be1dc2-3d61-c996-a721-218cc3100552",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[65] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8c159634-d440-3460-4456-5d1eac239d84",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable DoTs",
				uuid = "19071b3e-3185-25ec-a470-f6abfaa6c583",
				version = 2,
			},
			inheritedObjectUUID = "89b11261-e66b-9d42-97af-64e012cba1dd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "store eye position",
				uuid = "16b07ed1-0674-ba38-a186-55ebfd2d1c5d",
				version = 2,
			},
			inheritedObjectUUID = "4b5bf511-ea8b-06cb-8f09-9e1438934be7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "cae0dc17-4c75-527e-baff-5008b604fdbe",
				version = 2,
			},
			inheritedObjectUUID = "1ca7c5bd-684b-b6ab-9d43-d03b7db3a1ce",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 15s",
				uuid = "f297cf77-5988-3432-ab43-b98b8a9de98a",
				version = 2,
			},
			inheritedObjectUUID = "dec20f8e-e9e8-ad3b-a564-20fdf1229d88",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 20s",
				uuid = "12ead050-c08e-e963-9d99-0262b8393d7a",
				version = 2,
			},
			inheritedObjectUUID = "4461cccf-0c30-31e9-a23f-2599fb945d35",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Dont waste midare",
				uuid = "877304e4-d314-6d3f-b312-1bf1529f0a70",
				version = 2,
			},
			inheritedObjectUUID = "1e9d8b30-350f-557f-8578-83237a32abaf",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[RPR] Disable SoD",
				uuid = "aae23d57-73c4-37ef-8af9-e2a83ee3cdcb",
				version = 2,
			},
			inheritedObjectUUID = "11d833a5-d410-149c-8b23-910102856d4f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Multi] Anti-ghosting",
				uuid = "617928f0-f130-2109-b0f2-31edaea89786",
				version = 2,
			},
			inheritedObjectUUID = "ed975e8f-b753-65e8-b8d4-5af3d445d50f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DRG] Delay life",
				uuid = "40916775-92d8-027f-8031-766de538c4f1",
				version = 2,
			},
			inheritedObjectUUID = "55a38541-e593-2049-9c1e-f6437fd009c8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[66] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "20fbed8b-ee6b-7d67-6c3e-8391449dc59b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "lookaway",
				uuid = "1f816c5b-e97f-b79d-9f73-191b8747761a",
				version = 2,
			},
			inheritedObjectUUID = "6df0cfed-35f5-454a-bb5c-a229f5621d2c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[68] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7ebc48d9-6ff5-f21d-2626-5f93a5a984e9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw orb radius",
				uuid = "eb181517-6ee8-3b5c-a77f-14bded14f06f",
				version = 2,
			},
			inheritedObjectUUID = "7076f51d-da51-d313-9dfb-d1e1cdb312a3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "dbad90d3-aa34-9ca4-a5c7-d857ca8f7216",
				version = 2,
			},
			inheritedObjectUUID = "3d377c29-3031-fe55-81c9-44cb961c1020",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "d3003311-62da-87ed-9208-83354d5b43c9",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "0dc3af56-64f0-6202-f683-08d81bbb2da6",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[70] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "289c12ee-eb5f-6a02-2142-5668f299553e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Marker Role",
				uuid = "4d56f4ae-ae8c-924f-a9ce-5f8e5b2a6891",
				version = 2,
			},
			inheritedObjectUUID = "7a13a9e4-c7fc-95f8-854e-8334c5d877b7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set comets",
				uuid = "2f41a15f-2c58-725c-a7af-cebaf5fe7e93",
				version = 2,
			},
			inheritedObjectUUID = "af9fa8d3-780b-b377-972b-d35f908ddb26",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Meteor Pattern",
				uuid = "5c5f2366-60d8-328e-b82c-9f30fe077e1d",
				version = 2,
			},
			inheritedObjectUUID = "0fef7b13-337b-38bc-afa8-a82d31ed5326",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Tower Splits",
				uuid = "c1045b58-8532-e6d1-9186-31930d925560",
				version = 2,
			},
			inheritedObjectUUID = "01a71a79-c32d-a5aa-9ce1-d95e77569110",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[71] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "37cd651c-890c-8868-44a8-228eb1320aec",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[72] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "65f25888-c426-f32c-ce25-cdce51c58e98",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw comet drops timer",
				uuid = "5fa10eac-369c-12df-aa4b-f97fc1b7b701",
				version = 2,
			},
			inheritedObjectUUID = "9bdf53d1-e128-bd9e-8a69-a502540c0f8a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "ffbb3497-6a22-b6c3-51a8-7f5508fe6767",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[73] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "67c70be1-2d0d-5b55-c580-5c0ff27cf831",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "a2b7aa99-b70c-e0f4-ad98-82b7b242db78",
				version = 2,
			},
			inheritedObjectUUID = "809e9873-762d-aa1e-8481-7a4910dcbbf0",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "5a29396d-27ab-a30c-b70c-2b0dcf866918",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[80] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fa233493-ea0c-2f7f-a7fd-a5398bc665a3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw knockback",
				uuid = "d1411a69-99d8-62dd-b995-98cade2bbce9",
				version = 2,
			},
			inheritedObjectUUID = "c7806d06-68bf-6ff2-a089-db92ed10b695",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[82] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7261f105-f891-f8b1-756f-e007d290aa15",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "513e8846-2411-3eea-9cca-567970285b3f",
				version = 2,
			},
			inheritedObjectUUID = "8b34f398-920b-348f-b5fb-c88a90590787",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "b2e21eaa-f076-db69-b6a8-d5ea8a15368c",
				version = 2,
			},
			inheritedObjectUUID = "1363f875-198a-9350-ae04-44a52c93aaf1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "95a7acad-5cee-e2d3-9acc-2680f45c3f97",
				version = 2,
			},
			inheritedObjectUUID = "ee889ea0-7545-2188-b37a-27528a6e7595",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Reass",
				uuid = "b66e5875-c79d-c3ad-b1dc-2781853c8671",
				version = 2,
			},
			inheritedObjectUUID = "d35eb8bf-ce35-bd84-a0e8-677b22fd956e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Optional CD hold",
				uuid = "b78c0c8b-4aab-6492-b288-07d74ed2852b",
				version = 2,
			},
			inheritedObjectUUID = "a6e50ba7-b1f1-e44d-adc3-825194f8fad6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Force Ikishoten",
				uuid = "01c50723-4410-078c-a692-e42995b7cda1",
				version = 2,
			},
			inheritedObjectUUID = "409cdfbd-2091-741d-ac22-dd7f0594a974",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Precast Meikyo",
				uuid = "a878f330-92b9-0294-84b5-79811b9cedb5",
				version = 2,
			},
			inheritedObjectUUID = "5e12153c-de0e-fa8c-a385-5862a1315f27",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "5fc1e6c5-5fdd-09e3-8b77-545ff2e23be7",
				version = 2,
			},
			inheritedObjectUUID = "05987fbc-e7fe-2da0-acd6-5230e471c1ef",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "dda9f51a-924d-325c-a3cd-81f9a849be69",
				version = 2,
			},
			inheritedObjectUUID = "c16010e5-57dc-57c1-9bb4-ef5b18dbbc87",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Precast TN",
				uuid = "660220b5-8246-6605-b413-053f495eff1c",
				version = 2,
			},
			inheritedObjectUUID = "aa57d8a5-4305-4cea-aa3d-b5e7d778b079",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Force early bana",
				uuid = "4ee1c491-2dac-19a5-8d12-535b19e46d32",
				version = 2,
			},
			inheritedObjectUUID = "a81e77b6-903e-3a42-9646-46769a0dc8dd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "ca02b1ba-74f8-da3e-bad3-30041013444a",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MNK] Sanctity Blitz preparation",
				uuid = "8606905c-72f9-6b69-a00d-7fc99f1862bd",
				version = 2,
			},
			inheritedObjectUUID = "e21e6ecf-d6a4-590b-bb15-eb4cb8294221",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Sanctity Blitz preparation release",
				uuid = "efbb1a16-3782-3f26-92ce-4a025b9f46b8",
				version = 2,
			},
			inheritedObjectUUID = "09f9b098-0c9a-174f-b90e-705932facb73",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[84] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "878a6b07-b52a-048b-6047-6605fc758a17",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "c5a4872b-19a7-fca7-be8f-4a5303ecb814",
				version = 2,
			},
			inheritedObjectUUID = "11f0fb51-b42c-a694-9411-86888ff09252",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "1ed096f7-df26-8bfd-af0d-dccbdc71c1c3",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "SS Prio",
				uuid = "60b8241b-4931-b585-99ab-b9f1fb024f00",
				version = 2,
			},
			inheritedObjectUUID = "25243fa0-96ec-575e-8f77-4b8354dc0514",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable Fast TA",
				uuid = "61c605b6-0efa-55da-8990-4d889dadf2c8",
				version = 2,
			},
			inheritedObjectUUID = "2cb22312-ed26-52a2-8277-d3d3d82ce316",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[86] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ba183039-8de9-315d-e808-a993b2419e49",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Broad Swing",
				uuid = "a2753c5d-03d8-5dd9-a2c1-01f6def85191",
				version = 2,
			},
			inheritedObjectUUID = "7348cd16-086e-9c17-99e7-e0be7ccaa830",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold Gauge",
				uuid = "2d7dcff5-86e7-8270-bd64-4a9b9c51946e",
				version = 2,
			},
			inheritedObjectUUID = "f03fabfe-e08f-c563-9237-4cfa7ca0813a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold 2",
				uuid = "5e8a7841-8bed-05eb-827b-5fd1595e9dae",
				version = 2,
			},
			inheritedObjectUUID = "d697e448-908f-2b11-852b-5d35b86eb659",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "4f4b77f6-1b76-a4c2-3ebf-f2d8d5516246",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[90] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ec7b4630-b070-bb6c-edfe-c7d6d6c89800",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Broad Swing",
				uuid = "1aa6ca2a-1df4-7621-89b9-b49644b8f8b5",
				version = 2,
			},
			inheritedObjectUUID = "163817d2-c0a0-6aca-b2a0-84c3db512182",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[94] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "95a842cc-ec26-c950-fedd-d6a21788cb9c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable standard",
				uuid = "0a67f84e-8ef7-6fca-b485-196bbeccdbea",
				version = 2,
			},
			inheritedObjectUUID = "f8dc50cc-12d0-d1e7-a610-ed71e27ec47a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "63a9e7ad-bad7-92e3-a61d-a810bef35956",
				version = 2,
			},
			inheritedObjectUUID = "ded6a322-6cef-5390-9d87-e289cdaa165c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Anti-ghosting",
				uuid = "4e2e302f-04ce-41a5-8390-d53a7c95eb8b",
				version = 2,
			},
			inheritedObjectUUID = "6715f475-346f-c27f-8604-2ab030141165",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[97] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8a93fd03-028a-8a97-5b31-a3f5883c4b13",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "1a93e501-9275-62c6-942f-a325b11358fe",
				version = 2,
			},
			inheritedObjectUUID = "baa1ebcf-1e25-481b-8de7-27f709376c44",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "545cd9e0-80b6-96cd-9d48-0290bdecc0d8",
				version = 2,
			},
			inheritedObjectUUID = "ad1496c9-1c65-734a-8a2f-baef76a1de35",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "d20768a0-01e9-5817-8d2c-b25565906480",
				version = 2,
			},
			inheritedObjectUUID = "901639da-fe1b-99d4-ab0c-6f160631f903",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "850ba88a-9d1e-f9d6-a780-1c6b433a517b",
				version = 2,
			},
			inheritedObjectUUID = "0da75eec-f4f8-03ea-b9c0-d56541990ecb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Stop Holding Gauge",
				uuid = "c1cc2c6e-0ac6-173b-8118-1bf81dbb8650",
				version = 2,
			},
			inheritedObjectUUID = "006e8b0d-72ae-784b-aa70-d971c4c78cd2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Stop + Improv",
				uuid = "61f33558-0b74-e736-89db-edd5c92fe0a4",
				version = 2,
			},
			inheritedObjectUUID = "85726014-dbc7-9b04-a6fc-7a1bd9d41950",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Improv finish",
				uuid = "6c7a4fad-0a44-72eb-9d25-92ac256d7cb9",
				version = 2,
			},
			inheritedObjectUUID = "cc964fe7-6564-5618-bb1d-4c5ad4e1298e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable Pots",
				uuid = "2df21eb5-f580-0ab6-8da3-5b478ec1f9ce",
				version = 2,
			},
			inheritedObjectUUID = "506114fc-f1ad-74e7-8388-4e3709d36d0a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Reass pot",
				uuid = "cd8c87c0-f47f-5c6a-8cab-6a882386a9ac",
				version = 2,
			},
			inheritedObjectUUID = "5360257e-d479-907b-bbeb-8c294cc867f1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "690c2449-bfe4-23d1-830a-ec07a1ddee74",
				version = 2,
			},
			inheritedObjectUUID = "6741b301-67e7-4680-9adb-854c916145aa",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Flamethrower",
				uuid = "17504797-9f28-5590-83eb-5e12ffdbedf5",
				version = 2,
			},
			inheritedObjectUUID = "171a1b8b-81a7-17c6-9eba-19cb81194535",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "fb6f1e1a-c062-7c31-ad85-9551b08bea19",
				version = 2,
			},
			inheritedObjectUUID = "2798c507-f5f5-eb43-b124-eae31e932b94",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[98] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f53f2b68-7d0e-f6e4-9008-17ce98ef9478",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "d7e8b275-bea7-aea2-974b-0d875851754b",
				version = 2,
			},
			inheritedObjectUUID = "1c81d415-8494-6d5a-8413-a52fa0e1cfa7",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "f1cb49ab-4aea-ad7e-9824-bb7ae62f6c56",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[99] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4e8d3641-4d4b-a14d-8762-a60fce546f11",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Set markers",
				uuid = "f457e1d4-a8ea-e731-9631-6bf55ca5ad42",
				version = 2,
			},
			inheritedObjectUUID = "05eff784-fc28-daca-b6f3-b3e484f5b2dc",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set arrow type",
				uuid = "4b0eefbc-231a-df36-91e9-e22fea199166",
				version = 2,
			},
			inheritedObjectUUID = "213caf2c-435d-8930-8852-d1455c803b93",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "2cdd478e-d07b-f9f2-3ec6-6dbcfba7d1de",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Opti] Dive from Grace Snapshot Hold",
				uuid = "6ddcd893-2226-c02e-aadd-2ecb2a28a94b",
				version = 2,
			},
			inheritedObjectUUID = "362531aa-cbc3-b009-9773-ab1c5be72412",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Opti] Dive from Grace Wipe Cleanup",
				uuid = "b9ed3bc6-9ab3-a21c-8909-b279bbdb44c6",
				version = 2,
			},
			inheritedObjectUUID = "18c6f631-d6fa-4bec-a7c8-e063bbba23a9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Opti] Dive from Grace Death Cleanup",
				uuid = "8bf2043a-0d08-f859-9af2-3d86fc21a8bd",
				version = 2,
			},
			inheritedObjectUUID = "9917af74-94dd-c335-911b-a6795904b839",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[100] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "582b60d4-5449-84a8-c3ac-06bed6c5ac64",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Gnash and lash",
				uuid = "7be3f523-c0b4-afb5-a8b5-420455a2e9c6",
				version = 2,
			},
			inheritedObjectUUID = "1eba0d7d-987e-10e5-9b7a-d8519fa7c4e5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Gnash and lash TTS",
				uuid = "028f1b20-3e41-c46d-9508-509a9945b828",
				version = 2,
			},
			inheritedObjectUUID = "74374219-c1fe-c384-8b9e-acbcf90f41c5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[101] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f64ec1fd-4289-a181-b509-e07fa70256cd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "d75276d7-9a63-19e9-9dbc-779858e75338",
				version = 2,
			},
			inheritedObjectUUID = "e611b105-6a30-ed4a-b4f9-a26d8fc0c970",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "8470866e-dba8-becc-813c-736744b38c4b",
				version = 2,
			},
			inheritedObjectUUID = "90347a66-51c4-a45c-b1c0-94a4f7e11766",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Bait",
				uuid = "bd523d32-36d5-4bc7-9092-fd2f6bd6c04e",
				version = 2,
			},
			inheritedObjectUUID = "5dbdd3b3-6a58-86e4-969f-0ba4fe6de894",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw tower position (personal only)",
				uuid = "5d238dd2-0f0c-8233-8309-19a7a89e0dd1",
				version = 2,
			},
			inheritedObjectUUID = "36c8a490-ff20-eee9-a02c-ad6260c32ed7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[102] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6d259baa-aa76-cb0e-22d8-40186cba547a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "448e0a4e-3f16-3861-a4d4-07cbaada803c",
				version = 2,
			},
			inheritedObjectUUID = "5c546f02-4b12-aaa7-9c5c-4c291d5b98e9",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "bc47588e-c492-6612-9c01-dddbc0744445",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[106] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "da32f05e-8897-dc9a-eb41-5e341680df6e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "c8f893d2-bd75-66a7-a428-472101f83762",
				version = 2,
			},
			inheritedObjectUUID = "fda072ee-def8-f366-bf75-8aee6df53bd3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "8bef2ad9-5642-974c-b7b7-d1ce696b6397",
				version = 2,
			},
			inheritedObjectUUID = "33d7f612-2290-5b67-ad73-40205ec1daae",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Bait",
				uuid = "52fe9972-c05a-3d9c-8f57-8418273c1faf",
				version = 2,
			},
			inheritedObjectUUID = "66a2f8a2-518c-b2c6-bb1b-ea9d3425fa36",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw tower position (personal only)",
				uuid = "a3775b06-0d5f-6455-8c36-9e0fca17f77c",
				version = 2,
			},
			inheritedObjectUUID = "a22b6e11-e470-b3ef-a816-e2f6b070bb99",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold jumps",
				uuid = "8badcdcc-98c3-9477-82ca-faee05a38b5e",
				version = 2,
			},
			inheritedObjectUUID = "62d51a21-b3c2-3c7f-82bd-46991cca78e4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[108] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "cf50ee5c-dc7e-9c70-7cb5-e9460a2770ec",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable Jumps if soaking 2",
				uuid = "1169f3b8-e9a8-47fb-992d-57d7b3520632",
				version = 2,
			},
			inheritedObjectUUID = "9e6893d5-5612-8836-887f-b6569ea7f291",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[109] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4ea44545-aebf-1469-7499-11a7325c6015",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "f067428f-d399-852f-80e4-d237212d4839",
				version = 2,
			},
			inheritedObjectUUID = "090974f5-c3e4-e365-b0cf-4527515bd6ab",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw tower position (personal only)",
				uuid = "9cc95bee-8bc4-822d-94ec-dabc4db9fde8",
				version = 2,
			},
			inheritedObjectUUID = "d1cc0c7a-ecb3-426a-8b5e-b5b2e3b7df46",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Bait",
				uuid = "e487349d-cb09-e6b2-841f-03ed1ef93434",
				version = 2,
			},
			inheritedObjectUUID = "c1823f69-ae3b-99f7-9d99-9ce00e9aab70",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "cef0500d-2a1c-a2b0-9761-63b75eb1514e",
				version = 2,
			},
			inheritedObjectUUID = "58ca87de-c205-7ef6-b022-7b3e386ec1eb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[110] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9a232467-dea3-a02b-0a86-c381cf9e98b7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Gnash and lash",
				uuid = "a390d696-23e7-610f-b9f5-8bc5a4da2e11",
				version = 2,
			},
			inheritedObjectUUID = "8bb1f513-7d89-a871-88d1-f76bc5b10904",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Gnash and lash TTS",
				uuid = "18da34d1-0859-f575-810e-c52f3a42d9ac",
				version = 2,
			},
			inheritedObjectUUID = "4c5d1317-92da-4fcf-a8df-9276f25a3e1b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[111] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "dfef2906-255f-a8aa-1c46-a6a86188b916",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "4ba6e87d-50ef-607f-a6b8-e8519867dff5",
				version = 2,
			},
			inheritedObjectUUID = "236aeebb-72e5-2d6e-bada-87ef4fb2a107",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "cdd0ee62-51be-4181-81ac-9ba84e383331",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "[DNC] No Holds",
				uuid = "6a7f8cbb-df56-f164-bd5a-14673b770d96",
				version = 2,
			},
			inheritedObjectUUID = "1b2e15d7-1168-cb1a-9b8b-f695b3c21458",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[117] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8ee8abfc-6c99-6b38-5094-fe9ad7fdb00c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Hold pots",
				uuid = "36068492-2e88-1fd4-af71-10a2a1963916",
				version = 2,
			},
			inheritedObjectUUID = "c7f33b3e-c07e-a9bf-80be-def1f3b2be25",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold until after towers",
				uuid = "3139e284-ebd0-5f79-afab-168d1cbea348",
				version = 2,
			},
			inheritedObjectUUID = "3c02727e-83c5-6e7a-8a71-a00c9352c268",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold trick",
				uuid = "9615d441-701d-a2fe-b47b-6339a1be6b40",
				version = 2,
			},
			inheritedObjectUUID = "2ca70fd1-4b53-41a3-bcca-01337b871daf",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DRG] Delay life",
				uuid = "2673d109-7900-2f43-9f22-6b24f027ae51",
				version = 2,
			},
			inheritedObjectUUID = "f1449391-2b41-de88-bc0e-8c434332ab2f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[118] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9d59be3f-1e8b-26d3-76bc-366935c05a4f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH & SAM] Force pot",
				uuid = "524c048a-b951-45f8-8176-79fff4c18d63",
				version = 2,
			},
			inheritedObjectUUID = "0e2f8367-fefc-238e-af7c-da5efe2e6856",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Disable Reass Hold for pot",
				uuid = "23ade2c5-8e02-0edd-9af4-86013b468aba",
				version = 2,
			},
			inheritedObjectUUID = "520f48fe-214b-cb67-b5ee-f2077e9c64f5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enum Towers",
				uuid = "0bbd0046-c52b-31ef-bb8e-8ffb267d94a8",
				version = 2,
			},
			inheritedObjectUUID = "75ca105c-09bb-644b-bcf8-ccd398ca49dd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Arrow to Tower",
				uuid = "88164191-ca59-5f2e-85ab-f9af99cf16f2",
				version = 2,
			},
			inheritedObjectUUID = "439a5ab3-aef0-37a8-a1e5-a51da003975e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "9a5cc9ac-f4ee-7198-19a7-7726171abe7c",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH] P3 bounded potion",
				uuid = "9b17729a-e68c-4ea3-b5c3-78053897c0f9",
				version = 2,
			},
			inheritedObjectUUID = "52614b55-e58e-6bc7-844d-fab0741112ee",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] P3 potion queue cleanup",
				uuid = "cca00db3-5b55-9577-9054-9f87a11c2c02",
				version = 2,
			},
			inheritedObjectUUID = "a8febc22-a4d2-fd15-904f-6ac3ef3539bf",
			inheritedOverwrites =
			{
				enabled = false,
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
							actionLua = "local model=data.dsrBrdAutoSim\nlocal s=data.frog_enum_v1\nlocal p=TensorCore.mGetPlayer()\nif not model or not model.meleeMove or not s or not s.solved or not p or (p.job~=34 and p.job~=39)then self.used=true return end\nif model.enumForecast==s then self.used=true return end\nlocal t=TensorReactions_CurrentTimer\nif not s.ends or t>=s.ends then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal tower=s.towers[s.index]\nlocal distance=math.sqrt((p.pos.x-tower.x)^2+(p.pos.z-tower.z)^2)\nlocal ends=now+s.ends-t\nif distance>4.5 then\n local moving=math.min(math.max(.5,(distance-3.5)/6+.3),math.max(.1,ends-now-.3))\n model.meleeMove(\"enum-entry\",math.max(now,ends-moving-.3),ends-.3)\nend\nmodel.meleeMove(\"enum-exit\",ends+.2,ends+1.7)\nmodel.enumForecast=s\nself.used=true",
							name = "Forecast assigned tower movement",
							uuid = "2d81dd4b-46bf-3a6f-bfe0-2500f86a188e",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 676.9,
				name = "[AutoSim] Enumeration movement",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 2,
				timerStartOffset = -7,
				uuid = "13a1f1f9-337d-d214-a951-40389774cad8",
				version = 2,
			},
		},
	},
	[119] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "52c04a7e-768c-84b2-a47b-be70fd9f480e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "36279b88-763c-2f73-9d39-9dd7cb16ab53",
				version = 2,
			},
			inheritedObjectUUID = "8630d50d-38b1-fd54-98f6-986f8a063a8b",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "5600b622-4e9e-5b40-aa7c-9f8c83e9ccfb",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "TTS Bait",
				uuid = "9b784ae3-31c5-33e2-856e-4a2f247ecede",
				version = 2,
			},
			inheritedObjectUUID = "dcd51d4b-cf76-2fb6-9be0-e55d9f06c033",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[120] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4374d7be-0520-7442-d862-8fd490076f4e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw AOE on Tethers",
				uuid = "ddaf2781-893e-33b1-ba50-7ffcefb6140f",
				version = 2,
			},
			inheritedObjectUUID = "f5c0fd58-444e-ecaa-98ac-d28f3bfdf5e4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable Fast TA",
				uuid = "a968a3ee-8ac1-5215-81ca-36bfb4c5d63b",
				version = 2,
			},
			inheritedObjectUUID = "68e7c7f2-ba60-28c2-b739-47885a12a110",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DRG] Undelay life",
				uuid = "ff8a054e-2c6e-8f37-9431-fa40694e24a4",
				version = 2,
			},
			inheritedObjectUUID = "653cdd52-bcfe-b925-844c-dd860878e403",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "745bee05-f6b4-9231-35ae-607b7a62b8d5",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[122] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a2a11118-b371-4a6c-ed5c-caaae323f7e8",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Set new priority",
				uuid = "91226ff9-9811-6656-993a-2cd09c222904",
				version = 2,
			},
			inheritedObjectUUID = "7e365a35-f02b-1a5c-9ce8-59ff5577dbfc",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[123] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "43587ab1-dba6-3995-a6a0-c22b3c7202c1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "f29111bc-7a29-1e6f-b120-3a207c5d54d1",
				version = 2,
			},
			inheritedObjectUUID = "7a3f4af6-ca56-9959-83f9-1b962eeafa5d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold Gauge",
				uuid = "ce4294ac-d27e-dd4c-98af-852c3a529c6d",
				version = 2,
			},
			inheritedObjectUUID = "a84b5c52-2ffc-aed2-9a08-cffd5278fa44",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "4e574575-39c4-0cea-a8e5-26ac165e1b43",
				version = 2,
			},
			inheritedObjectUUID = "aa0d179d-773b-8adf-be0f-653980bd95c4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Anti-ghosting",
				uuid = "a0723cdb-1c55-1789-af95-8666a0b80fc8",
				version = 2,
			},
			inheritedObjectUUID = "36b93324-9521-ba80-a765-9c389dc0a473",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[127] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "d8afb35d-bb57-2dc9-ea3d-7e9fcd3beaad",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "85f10ed6-69aa-7270-ab74-d30cca138579",
				version = 2,
			},
			inheritedObjectUUID = "ef13e6df-da0f-f4b7-a6e7-a7c27132b9fe",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "6e2040d7-bebc-b823-b794-9d5ec2548112",
				version = 2,
			},
			inheritedObjectUUID = "c3c3230c-76a5-36ac-af99-504bd2e347af",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "a7f889a2-e359-8b10-be72-1a23521f7697",
				version = 2,
			},
			inheritedObjectUUID = "37a22c88-cd7a-d96e-9a2d-e7dc6f591d10",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "1a0732b8-ad89-45eb-954f-29b8816801ae",
				version = 2,
			},
			inheritedObjectUUID = "fd429cfd-8611-f872-98ff-4edd1aa66cbe",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Disable No Holds",
				uuid = "2e675424-fb2b-5c86-a47b-a2efdbe3265d",
				version = 2,
			},
			inheritedObjectUUID = "ad2a0a35-7f9f-872d-9ca7-3d4c7827c37e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Stop holding",
				uuid = "701dc3f6-1af3-9136-b82b-fdfc9e71333d",
				version = 2,
			},
			inheritedObjectUUID = "f019160a-f7cb-6993-819f-40f9095965ca",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Improvised finish",
				uuid = "5db50e3e-1594-f43d-a92c-a4742746402e",
				version = 2,
			},
			inheritedObjectUUID = "b3cb16ad-d857-d360-9676-389870558aef",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Improv close to alphinaud",
				uuid = "cb17b6b0-fc21-ad92-9c9f-742496a30d87",
				version = 2,
			},
			inheritedObjectUUID = "77d02a42-ca9e-d2c1-b776-f31e71055300",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold Reass for Chainsaw",
				uuid = "bbdd15da-c567-7ac7-a7d9-b5d09ae94ba4",
				version = 2,
			},
			inheritedObjectUUID = "f96d81d2-eaf8-29e9-9124-db25821136a8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Stop holding reass",
				uuid = "efa5cefe-6c4b-b32b-8adf-881d7524ef40",
				version = 2,
			},
			inheritedObjectUUID = "470cc9b7-8dcb-2d4d-b9b2-8275190f7587",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "0415cd32-80af-2079-a3f1-1db6a18dca20",
				version = 2,
			},
			inheritedObjectUUID = "c926686f-8a2f-b090-9bb4-6836357c7f2f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "44a346c2-6810-69c6-8f8f-bf4c6d5e0e92",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "12edd6da-b6ff-df1d-9d50-2dd2972467ee",
			},
			objectType = "folder",
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
							actionLua = "local model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nif not model.eyesBudget then\n model.eyesBudget={yellow={},blue={},yellowCount=0,blueCount=0,hits=0,waves={},wave=0}\nend\nlocal s=model.eyesBudget\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal id=eventArgs.entityID\nif not s.yellow[id] then\n s.yellow[id]=true;s.yellowCount=s.yellowCount+1\n if s.yellowCount>=2 and s.blueCount>=4 and not s.orbsAt then s.orbsAt=now end\nend\nself.used=true",
							conditions =
							{

								{
									"05c69732-6794-7952-9eff-e79b8c6605e1",
									true,
								},
							},
							name = "Count yellow orbs",
							uuid = "56f28888-56bf-6161-92fc-39adc3d93ad3",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "local model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nif not model.eyesBudget then\n model.eyesBudget={yellow={},blue={},yellowCount=0,blueCount=0,hits=0,waves={},wave=0}\nend\nlocal s=model.eyesBudget\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal id=eventArgs.entityID\nif not s.blue[id] then\n s.blue[id]=true;s.blueCount=s.blueCount+1\n if s.yellowCount>=2 and s.blueCount>=4 and not s.orbsAt then s.orbsAt=now end\nend\nself.used=true",
							conditions =
							{

								{
									"3c2efa41-6d7e-cccc-8a4f-ecf438f454b7",
									true,
								},
							},
							name = "Count blue orbs",
							uuid = "c1bfaeb2-9af0-735e-84c8-8629ebb4d695",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "local model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nif not model.eyesBudget then\n model.eyesBudget={yellow={},blue={},yellowCount=0,blueCount=0,hits=0,waves={},wave=0}\nend\nlocal s=model.eyesBudget\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\n\nlocal w=s.waves[s.wave]\nif not w or now-w.time>2 then\n if s.wave>=4 then self.used=true return end\n s.wave=s.wave+1;w={time=now,targets={},count=0};s.waves[s.wave]=w\nend\nlocal id=eventArgs.targetID\nif not w.targets[id] and w.count<2 then\n w.targets[id]=true;w.count=w.count+1;s.hits=s.hits+1\nend\nself.used=true",
							conditions =
							{

								{
									"9e6f7b0e-6b0e-c859-a756-76f2ae075357",
									true,
								},
							},
							name = "Account for landed dives",
							uuid = "4fae7774-3362-2ab5-9ce9-380c4ea788d2",
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
							name = "Tracked casts",
							spellIDList =
							{
								26817,
							},
							uuid = "05c69732-6794-7952-9eff-e79b8c6605e1",
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
							name = "Tracked casts",
							spellIDList =
							{
								26815,
							},
							uuid = "3c2efa41-6d7e-cccc-8a4f-ecf438f454b7",
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
							name = "Tracked casts",
							spellIDList =
							{
								26820,
							},
							uuid = "9e6f7b0e-6b0e-c859-a756-76f2ae075357",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 757,
				name = "[AutoSim] Eyes orb and dive accounting",
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 90,
				timerStartOffset = -2,
				uuid = "4720d94c-6368-53fe-954a-f809b7eb98cc",
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
							actionLua = "\nlocal model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nlocal s=model.eyesBudget\nif not s then self.used=true return end\nlocal acr=TensorCore.API.TensorACR\nlocal now=acr.getAutoSimTime()\nlocal left=model.secondaryID and TensorCore.mGetEntity(model.secondaryID)\nlocal right=model.primaryID and TensorCore.mGetEntity(model.primaryID)\ns.desiredID=nil;s.noSafeTarget=false\nif not left or left.hp.max<=0 or left.hp.current<=0 or not left.targetable then self.used=true return end\n\n\nif not s.startHP then\n if s.yellowCount<2 or s.blueCount<4 or now<s.orbsAt+0.5 then self.used=true return end\n\n if s.hits>0 then self.used=true return end\n s.maxHP=left.hp.max;s.startHP=left.hp.current\n s.diveHP=s.maxHP*0.40\n s.requiredHP=math.max(0,s.startHP-s.diveHP)\n s.startPercent=100*s.startHP/s.maxHP\n s.requiredPercent=100*s.requiredHP/s.maxHP\nend\n\n\n\ns.playerDamageHP=s.startHP-left.hp.current-s.diveHP*s.hits/8\nlocal covered=s.covered or s.playerDamageHP>=s.requiredHP\n\nif s.hits>=8 then covered=false end\nif covered~=s.covered then\n s.covered=covered\n model.leftEyeDotStopAt=covered and now or nil\n if covered then acr.clearAutoSimTarget(1)\n else acr.setAutoSimTarget(1,left.id) end\n\n model.rebuild()\nend\nif covered then\n local usable=right and right.targetable and right.attackable and right.hp.max>0\n  and right.hp.current>0 and math.max(0,right.distance2d-right.hitradius)<=25\n if usable then s.desiredID=right.id\n else s.noSafeTarget=true end\nend\nself.used=true",
							name = "Left eye player-damage budget",
							uuid = "0ee1ee5c-db96-bbce-9d7c-7ffbb3e2e271",
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
									"3e73ca84-b0c6-4e6d-b182-88a91c440048",
									true,
								},
							},
							name = "Switch to right eye",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "8233b353-ec6f-c909-a750-295dbaaec259",
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
									"e216f30f-1619-4803-a9e0-b15a5ace2ea6",
									true,
								},
							},
							name = "Leave covered left eye",
							setTarget = true,
							uuid = "d45f49ff-6c3e-83aa-b6d9-451168d6226e",
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
							conditionLua = "local m=data.dsrBrdAutoSim\nlocal s=m and m.eyesBudget\nlocal t=TensorCore.mGetTarget()\nreturn m and m.phase==\"eyes\" and s and s.desiredID and eventArgs.detectionTargetID==s.desiredID and (not t or t.id~=s.desiredID)",
							name = "Right eye after budget",
							uuid = "aa37d5ff-9d9b-7232-9c81-72423b282158",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							conditions =
							{

								{
									"aa37d5ff-9d9b-7232-9c81-72423b282158",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "Available right eye",
							uuid = "3e73ca84-b0c6-4e6d-b182-88a91c440048",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local m=data.dsrBrdAutoSim\nlocal s=m and m.eyesBudget\nlocal t=TensorCore.mGetTarget()\nreturn m and m.phase==\"eyes\" and s and s.noSafeTarget and t and t.contentid==11317",
							name = "Left eye covered; right unavailable",
							uuid = "e216f30f-1619-4803-a9e0-b15a5ace2ea6",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 757,
				name = "[AutoSim] Left eye player-damage budget",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 90,
				timerStartOffset = -2,
				uuid = "b636577c-7984-907a-80c8-6e33dff6aaf0",
				version = 2,
			},
		},
	},
	[128] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fc7eba46-1604-2dfa-4f88-1d5cedfe1f56",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "5d7a2966-4d3f-e2ba-a687-cd8a7b7abcfe",
				version = 2,
			},
			inheritedObjectUUID = "427c1b68-1297-eeef-a1da-a5ff504c1199",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "4355cc9a-5894-494f-b50a-198a820639c6",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[129] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f461e2a7-5ca5-75fb-cedb-7445e8644cf7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Post-draw mirage dive",
				uuid = "85e51394-65d1-d084-a467-8d069166f356",
				version = 2,
			},
			inheritedObjectUUID = "7db15b0c-8355-4ee5-a407-17d169d3c360",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[130] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8a4f9481-5db6-f525-1a5a-53672e202511",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "d1096983-8986-ffe5-a809-1e922ff8038c",
				version = 2,
			},
			inheritedObjectUUID = "29a51448-4110-15a3-adff-3155e2f0ee57",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Standard Step",
				uuid = "59fc7616-1e05-d06e-8c85-402d0781206e",
				version = 2,
			},
			inheritedObjectUUID = "3a21f06f-0b86-d9a0-95a6-88b291671988",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[131] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9c0f77a8-ffdf-5f3c-6026-5806f8bb4a78",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[SAM] Disable Higanbana",
				uuid = "0d7d4228-c508-96a6-a830-a0b86c2c8ab9",
				version = 2,
			},
			inheritedObjectUUID = "2b61e994-ef2b-305a-ac70-fb58c7a6dc56",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[132] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "2a5dd04f-4d0a-c3b3-0ab9-73999c3d5adf",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "9055d8d3-94b3-e3bf-9a43-8ee896995473",
				version = 2,
			},
			inheritedObjectUUID = "d580baef-5bfe-f854-9cb7-a689cc5a4837",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Avoid ninki cap v2",
				uuid = "0e68f1b3-e589-a926-8f68-cc0173a38ef0",
				version = 2,
			},
			inheritedObjectUUID = "8d20c3fe-7b26-3f96-9f8a-e6b5b10e4a3a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[133] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f23cbe0e-194d-bd12-002f-0a600637fe9e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "53988bfd-c2fb-ee1f-9fd5-73cf95c763d1",
				version = 2,
			},
			inheritedObjectUUID = "de863cd3-6f75-dd40-9d1a-aa089f590cb4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "dd0163b3-35dd-7652-a6e0-bb88b27ed99a",
				version = 2,
			},
			inheritedObjectUUID = "6a65e126-ef3f-cdcd-8e49-1f85f2cd9f23",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "e830c84d-4128-2e8b-ab8e-b24374de4ffd",
				version = 2,
			},
			inheritedObjectUUID = "93f86308-9e11-0c55-80cd-9bbc58ae564b",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "66809bee-abbf-a192-a362-48a7cea38e70",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[135] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fcff2004-67f4-1aa0-1782-b1d203026014",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "bf8b9db6-49bd-b194-ab2a-375c981f6847",
				version = 2,
			},
			inheritedObjectUUID = "f11eb469-7c4a-ee21-a8b9-ab63575fafd9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "f4677dd2-7153-6dd0-82fe-bccf436875a9",
				version = 2,
			},
			inheritedObjectUUID = "f1968d1f-79c7-5552-96aa-3db84495d1a7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "330f1351-85e3-2ae8-bbdd-a2865faee4ee",
				version = 2,
			},
			inheritedObjectUUID = "5351e82e-26b0-9fa9-a5a2-9e55c472ab39",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "SS Prio",
				uuid = "f8695b3d-b0b7-0f67-b44e-8095586e05db",
				version = 2,
			},
			inheritedObjectUUID = "09c36882-3e59-6270-8e27-fac9d8253e8b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Drill",
				uuid = "b77bb3f3-292d-635a-a3b4-022b8fc30dca",
				version = 2,
			},
			inheritedObjectUUID = "3a471b43-c09a-63bb-b15c-9ded776d90ac",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Huraijin",
				uuid = "62ae5e2d-585a-f542-b188-1cde713ce76a",
				version = 2,
			},
			inheritedObjectUUID = "c9153d97-174c-596b-bb40-104c1d8ff9a8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Disable burn",
				uuid = "3dc1ae81-d1d6-b22f-bc96-64a43bf7bab8",
				version = 2,
			},
			inheritedObjectUUID = "e3c6e3e1-a99b-1996-998e-229b01851fc1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "b96095f1-1983-06fc-b942-cbd35391188e",
				version = 2,
			},
			inheritedObjectUUID = "0a6b4953-a313-e209-9f99-fabcbf2e6277",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable ninjutsu",
				uuid = "d8df1a8f-e1f7-7d16-a379-9f863f9e3681",
				version = 2,
			},
			inheritedObjectUUID = "cdcd3219-273b-b778-a346-249274092526",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Re-enable ninjutsu",
				uuid = "25135f88-446a-f78b-8eb4-eb3eae494db0",
				version = 2,
			},
			inheritedObjectUUID = "c803269e-6e91-a714-ab20-d3672cdbbfbe",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[140] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e3f5cc88-49eb-a074-0f33-04a2385bfa58",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[146] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fcd8fbfa-6f79-25fe-eab5-e930eada834a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Hold Gauge",
				uuid = "bb8d24a9-10fe-9585-bba4-938f35314a96",
				version = 2,
			},
			inheritedObjectUUID = "37cd67b8-ead2-bf13-ab6e-fcc6c13fbce5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Stop holding",
				uuid = "cf101917-52d6-621d-98ee-e94235d86444",
				version = 2,
			},
			inheritedObjectUUID = "131ef6e9-b55e-a936-9ba0-b3b6f9f13f5c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Find target",
				uuid = "2be6315d-ebcc-9aa6-abe8-0f66f6035b5f",
				version = 2,
			},
			inheritedObjectUUID = "27cfe60d-39ff-05d4-b49d-ea4b3ee5b78b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "d7e19ce9-63ca-81ac-80d0-c78fa4895c3f",
				version = 2,
			},
			inheritedObjectUUID = "6fad0c23-dd3c-3f5f-9b04-11d1327b6a76",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "78a34296-62c2-c1a2-84b6-05ad8f3cb3ce",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[148] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "d5fc2650-aba1-877c-90ea-c85a8ee80ee0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "89f505d4-1a35-264b-a2a3-5ba9cd980148",
				version = 2,
			},
			inheritedObjectUUID = "3d6d4377-e3c8-f4f5-b54d-5c3d69a6bf98",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Standard",
				uuid = "b374d1f0-53d3-3153-8b96-4890a0aa0ae3",
				version = 2,
			},
			inheritedObjectUUID = "4d005d5f-5100-4cd9-a96e-af04c73ec5ed",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "a9e2eed8-9f80-dae1-8254-642e22290aa7",
				version = 2,
			},
			inheritedObjectUUID = "a6c45929-c290-18ab-bd5e-31ffc6e26a8a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Hold HC again (hp)",
				uuid = "453a6bed-6d7c-addb-b2b5-a9cc0622216f",
				version = 2,
			},
			inheritedObjectUUID = "27697ace-1aa9-139d-a02f-3f9a342af2a5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Hold HC again (timer)",
				uuid = "2688343f-82e4-1c95-a079-60dc13f40cf2",
				version = 2,
			},
			inheritedObjectUUID = "3a6722af-5fb8-b431-82cb-01553f48ad7d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[150] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9eff618b-1eb9-1107-709c-940525274f5b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "abacc3c7-4481-f210-9015-2558e50a3657",
				version = 2,
			},
			inheritedObjectUUID = "85d88f92-56f6-c9d5-8c88-4b039772f12a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "3e316eb3-8ff2-d357-bbff-d5b9dec5c588",
				version = 2,
			},
			inheritedObjectUUID = "945f7ae6-e110-8c5c-b06b-dc64dcdb1206",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "3e43a20f-9b65-868f-87fa-218af1a2446a",
				version = 2,
			},
			inheritedObjectUUID = "26f0e7e0-c297-ab7d-bff6-0012e81419c8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "dcbb8c44-cde9-1b83-ad0b-a0ef9e043785",
				version = 2,
			},
			inheritedObjectUUID = "e87adeaa-3aea-660a-b37f-c9d3efda1d66",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "ff3c0d8e-dfd2-5f31-b286-4e96879f6b83",
				version = 2,
			},
			inheritedObjectUUID = "901f7658-21e4-e337-8494-107086e34613",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Pots",
				uuid = "5b5e03c5-3d89-47aa-b52a-88f37258a56b",
				version = 2,
			},
			inheritedObjectUUID = "c8f600a5-b15b-3031-bb8f-3b08c9fedcf9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "9dbaf840-8c40-b297-8bb5-6bd5d0af182d",
				version = 2,
			},
			inheritedObjectUUID = "1b26353c-030b-3f32-9eac-b2bee09f8251",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[154] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "5ec4c06c-ebab-33d8-a34d-4af6fb25483c",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[155] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e283b2be-6885-0772-46ea-24802f164a4e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[BRD] Refresh DoTs",
				uuid = "91bcd623-3190-ebb9-815b-2034036c2e4e",
				version = 2,
			},
			inheritedObjectUUID = "76ee1f91-f8d6-5ee1-be38-60a5d9b2bbe7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "ecbb8a29-84cc-1f86-90fd-a91c02cd9dec",
				version = 2,
			},
			inheritedObjectUUID = "f680b35c-07e3-a3f7-8843-3c47fefd625c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "e4593e3c-6c11-5050-9e6d-90e5dc98cef6",
				version = 2,
			},
			inheritedObjectUUID = "f4df76a6-d6f0-2e71-a620-0d582f236616",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 15s",
				uuid = "09fb75de-22d5-1607-83d6-07b3570068da",
				version = 2,
			},
			inheritedObjectUUID = "1911c2d9-204b-ad4a-a704-5576bdaf6f29",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 20s",
				uuid = "e388c413-220d-07ed-a76d-7089c18aba45",
				version = 2,
			},
			inheritedObjectUUID = "77678b84-c78b-dc97-a2d2-e3af30b838a9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Multi] Anti-ghosting",
				uuid = "24b4a512-3d15-e1ae-81c3-fef3518ca772",
				version = 2,
			},
			inheritedObjectUUID = "7e8ba4c9-5fc7-d911-9a9b-bb5de5fcf1c3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[156] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e26755b1-0990-9705-85c5-0e07db80ddc1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Divebomb",
				uuid = "e1a827f6-9745-8cb9-bfc4-c978345ad2b7",
				version = 2,
			},
			inheritedObjectUUID = "26aeded5-adf6-d65e-b895-167889e88ac8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Record Tether",
				uuid = "94945ad2-ddc2-5948-9011-4c801233d558",
				version = 2,
			},
			inheritedObjectUUID = "929d6d5c-6fc6-f9c1-a314-6ffbff864064",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Record Defamation",
				uuid = "a6881d9b-63fa-7216-8962-850db99fb597",
				version = 2,
			},
			inheritedObjectUUID = "c2b38d33-d013-177b-9022-51b86e756bfc",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Mechanic",
				uuid = "7b26dcaf-c49a-0446-b6dc-76e2ba759198",
				version = 2,
			},
			inheritedObjectUUID = "ae0d01cf-235e-a19c-905a-ef2bd2a662dd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Thunder Radius",
				uuid = "eb8e4585-5e63-6ef6-af71-9f37eead2c01",
				version = 2,
			},
			inheritedObjectUUID = "3affab55-aa0a-73c7-a72c-3fc07d43a4eb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[157] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "41afec18-209e-5b1c-d7f6-dc268232d2e8",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Twisters",
				uuid = "86a4a7cd-6da8-6692-af38-546a3a30e033",
				version = 2,
			},
			inheritedObjectUUID = "888afb2b-5e50-23ef-9c9d-28ef21bff631",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw blue marker",
				uuid = "4584bbf3-c75b-6d7b-a2e7-431373f40232",
				version = 2,
			},
			inheritedObjectUUID = "886d8d53-d101-cd6a-b8ca-7181858816af",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Twister Snapshot",
				uuid = "cb019261-545b-82b7-9ac4-c7f74232f5fe",
				version = 2,
			},
			inheritedObjectUUID = "91728547-278a-bd65-b2ab-43b6f6dddd57",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw arrow to warrior",
				uuid = "ee6ad7cc-a329-3db7-829f-ef9b5990dc21",
				version = 2,
			},
			inheritedObjectUUID = "61475749-e2b4-5485-9cff-5c1cb32b75c4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw tether",
				uuid = "bd04deb2-57bc-6405-a91e-0544f70e0bc1",
				version = 2,
			},
			inheritedObjectUUID = "3c500a62-0c0b-2b14-9510-292375f4b157",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[160] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8efbd5a2-f35e-225e-642c-fb88c9b501b2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw proteans",
				uuid = "1b5bc809-095e-5b59-bfc4-5cccef297f8a",
				version = 2,
			},
			inheritedObjectUUID = "b71be9d2-1ae7-eca5-b09f-68249e379103",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "ad4d7447-3465-3af2-a0d1-24d5168b2e3f",
				version = 2,
			},
			inheritedObjectUUID = "3f5bf899-afdd-5151-8689-bee54e0ae69f",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "ce281608-9244-c5c0-9dcc-50da4c95c977",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Shade shift",
				uuid = "687bb5b0-73be-45b0-96cd-6a41faf82dea",
				version = 2,
			},
			inheritedObjectUUID = "dad21179-291f-faea-9583-e2ddd5fad5cb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[172] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7826a893-eff6-27ef-f7f5-bd5de2aabf63",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "5c9aeef9-51bc-b559-b762-5913f261a60a",
				version = 2,
			},
			inheritedObjectUUID = "7b00b3ef-c9b7-c88f-bac8-8e2495ae425e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "67876a08-659e-7fdf-8b10-62c3ea7fd536",
				version = 2,
			},
			inheritedObjectUUID = "482c7c7c-669d-8ede-ad7d-67eb24c7712e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "f60b3556-b3f9-e1a1-83ff-45c6a8d19a4f",
				version = 2,
			},
			inheritedObjectUUID = "53b531d3-9023-11cf-bd75-a48433025508",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "f3fb6590-5aeb-3581-9c44-8e4c5ec5712e",
				version = 2,
			},
			inheritedObjectUUID = "afda9ebc-5b76-451c-b587-fc5871ee5cb5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "067ee1d8-285b-32dc-4cbf-f0c2caf78ae8",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MNK] Wrath early PB",
				uuid = "bda9734a-25e0-b029-8a51-6c2e2cf957ba",
				version = 2,
			},
			inheritedObjectUUID = "6221ad09-2632-7e13-93b8-957c23f8a3dd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[174] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "381ba439-9d26-b88d-5418-bb7fac0bb709",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "a85a6359-3537-0207-9f1c-f5b1a5e60126",
				version = 2,
			},
			inheritedObjectUUID = "70bbd963-d595-dda3-bc39-92cc4f31a61d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[178] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "89a67ebd-b9d4-5f09-b416-c0b38f5e108d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[180] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "bc9f73e3-b7ac-33df-3f4f-824d20389e33",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[181] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1515d635-76dc-13d9-2e79-6097c137e285",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "73336911-46b2-a611-bdc0-8337afbab191",
				version = 2,
			},
			inheritedObjectUUID = "a857cbfe-bdea-7d5a-9eeb-f0576a2403dc",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 15s",
				uuid = "a024ca8f-a4b6-c9a6-927b-7da1de7b54a8",
				version = 2,
			},
			inheritedObjectUUID = "1a04e198-dec1-493c-ae87-c003cec3ffb7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 20s",
				uuid = "c5bf1559-a8dc-ae61-ad3f-770136900bc5",
				version = 2,
			},
			inheritedObjectUUID = "ce9d4587-c563-5966-8630-da776dc726d7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Force MB",
				uuid = "fd91bce5-9e60-17fc-b298-f32b398e4cb4",
				version = 2,
			},
			inheritedObjectUUID = "dd5fdd69-75c3-4624-a5e8-dd1353ac9605",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "8649eb35-addd-3882-adff-46789db27736",
				version = 2,
			},
			inheritedObjectUUID = "90d5fe1d-3fa7-1ba7-b8f3-e6159dfc3d38",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Overdrive",
				uuid = "d8fc0f53-af1c-2917-8554-695fb4dc9cba",
				version = 2,
			},
			inheritedObjectUUID = "fa47ee7b-d915-ed5d-a35d-9d3b33f61712",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Heavy Impact",
				uuid = "53fc5ae1-7295-774a-a6b7-370cd12c809d",
				version = 2,
			},
			inheritedObjectUUID = "31b3a39d-787e-b3be-b032-2d55c8657e83",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Multi] Anti-ghosting",
				uuid = "5280ab76-11d1-db37-8506-905281920b58",
				version = 2,
			},
			inheritedObjectUUID = "9f386cec-6869-3a72-9694-1ab515039884",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[186] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b7175416-7a3e-e212-dc5f-916c28922aa6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Twisters",
				uuid = "2b28a427-11a2-df61-8e03-a731a554e1a1",
				version = 2,
			},
			inheritedObjectUUID = "4e5c4a61-6110-a0df-81d1-e353c28ca68f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Twister Snapshot",
				uuid = "c10f2870-a712-26d1-851b-7ffe1a341955",
				version = 2,
			},
			inheritedObjectUUID = "c1340714-6b0a-6fa5-82f9-3a8717a8ba50",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[187] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "252d33b7-adfb-e8b3-0494-8095d6605c87",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw spreads",
				uuid = "b18a71e5-c1a9-5869-af65-87b6e0b7abc5",
				version = 2,
			},
			inheritedObjectUUID = "f14ed201-a1a3-734b-9fea-44af3e751b97",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Doom Puddles",
				uuid = "34fb2670-c71a-7d4a-8550-bb61c9207c32",
				version = 2,
			},
			inheritedObjectUUID = "2c80bebe-66d2-f5e7-b9d4-0fe65ea337da",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[190] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "caf7749f-012a-5243-3ed9-35d99b51bd2f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "lookaway",
				uuid = "c38aa941-8b8b-eadb-a6f7-49728b32a9a4",
				version = 2,
			},
			inheritedObjectUUID = "498f7b69-050e-aa33-8201-e48fac5e0ccd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw knockback",
				uuid = "2e81fa79-cb78-38a4-95d4-e02edb17d28f",
				version = 2,
			},
			inheritedObjectUUID = "1f4dc2a5-5e37-c052-861d-62572ac618c0",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Marker Type",
				uuid = "03921d91-67e1-02f4-b519-4ab92506ab7f",
				version = 2,
			},
			inheritedObjectUUID = "d41df8c5-3cb9-2274-a894-112e79b3a899",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "store eye position",
				uuid = "930fc3f8-1a52-20eb-8fb5-4fd4f08968d1",
				version = 2,
			},
			inheritedObjectUUID = "c18e0549-33be-c4db-8c42-494022ecfe33",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[193] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "15508338-e5c6-580c-dda7-0e46b4c84a08",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "ad6d30aa-3778-7fb6-82e4-d4f17411825c",
				version = 2,
			},
			inheritedObjectUUID = "8c7ee3ea-4be7-600d-9f57-51ce77e001ff",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "759b5201-4a61-b23c-9020-e6226b22b4d4",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[194] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "875ab82b-dd67-40b7-86a5-3c25144cc17b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Precast Dance",
				uuid = "6774bcd3-ab0b-a3c2-9160-ad3ccaa26947",
				version = 2,
			},
			inheritedObjectUUID = "4af9ca60-4592-cf05-9619-793cc12ab7eb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Precast flourish",
				uuid = "20ade76e-c4aa-c24b-9855-e391dec69191",
				version = 2,
			},
			inheritedObjectUUID = "396f92c0-a0c7-a73f-a334-6f31c8b32925",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Find target",
				uuid = "81dfba0c-993e-5a52-bfe4-2a68495e1a86",
				version = 2,
			},
			inheritedObjectUUID = "c580d9cd-d84c-2d08-b638-5ea3e1197cb8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Advanced Find Target (Highest HP)",
				uuid = "0e417f32-dd0f-8972-aa9c-4dd46e743e9a",
				version = 2,
			},
			inheritedObjectUUID = "26494dd6-6202-eb1f-baf8-9a76827e8ea2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold chainsaw so it isn't 1st gcd",
				uuid = "ebc526da-85e9-442a-af59-e98a62976cb6",
				version = 2,
			},
			inheritedObjectUUID = "acdfc235-a8d6-a1eb-a9ce-20dd67b2a30d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Hold",
				uuid = "196559a7-d51f-de98-8919-06146032e924",
				version = 2,
			},
			inheritedObjectUUID = "11827153-5b06-748d-b95b-1345f30e51bb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[SAM] Precast Meikyo",
				uuid = "a571224d-348b-fa2a-91bf-0152d5fd0ffe",
				version = 2,
			},
			inheritedObjectUUID = "36f210f8-d2ae-4775-a6f6-ca6643fe95a6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "8a41dc0f-ce09-ddd2-a13a-e48cb02e9579",
				version = 2,
			},
			inheritedObjectUUID = "aaaa5136-d7b8-ae0d-a799-729a43ee0d3f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Force Trick 1st gcd",
				uuid = "ecd25741-c53a-0cd6-9dfe-d65b9f0f70f9",
				version = 2,
			},
			inheritedObjectUUID = "39517bc1-071c-f3f4-a893-666213ded2e5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Queen",
				uuid = "447ab426-c707-3659-9f2d-4a885b94a0cd",
				version = 2,
			},
			inheritedObjectUUID = "80a2ae05-2a4b-da5d-aa59-265fb8104af0",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "8eabd52a-8d2d-ed77-aba0-864d1d1e0387",
				version = 2,
			},
			inheritedObjectUUID = "af2e1a39-7d6c-7af6-b0e4-76c87059c3d8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "53fdea40-1d5f-a4f4-0fa3-f79ad9c55e90",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MNK] DOTH comet Blitz preparation",
				uuid = "b8fedb71-d5ed-4876-a03c-864c5e9a4dcb",
				version = 2,
			},
			inheritedObjectUUID = "1e68811b-a3d6-2d34-a42a-3864dbd8148a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] DOTH comet Blitz preparation release",
				uuid = "6d17c1eb-0230-fafb-8fa5-8265fb7caa18",
				version = 2,
			},
			inheritedObjectUUID = "6442f25e-2032-e5f7-9e8b-d29876189ce4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] DOTH pre-comet Riddle of Fire",
				uuid = "27ae5429-93e4-d202-8b08-df1c7cb93f56",
				version = 2,
			},
			inheritedObjectUUID = "2a768dac-903d-f7b8-b7ce-22668e3c403c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[196] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "573fe6fd-0fb0-3969-75f9-0ab307f37bcd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "38a0a501-451f-1894-a39b-8cc7286f7ec2",
				version = 2,
			},
			inheritedObjectUUID = "5980c2b8-0b87-84a7-8316-b8fd455b3262",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "53066a7a-02dc-e783-9923-7643efc4efe3",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Find target",
				uuid = "a607766f-65dd-8e7a-bf3e-37a2f84bb2bd",
				version = 2,
			},
			inheritedObjectUUID = "729008cb-14f8-decb-9e54-a5cb50d5e4cd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable Queen",
				uuid = "d94943e4-cbcd-90eb-99b7-df6a70e5c1ee",
				version = 2,
			},
			inheritedObjectUUID = "07dfb046-7646-b918-a02a-e89ee7119627",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable songs if in AP",
				uuid = "dd6875b2-54d2-1112-b592-fb5de4ccf8c7",
				version = 2,
			},
			inheritedObjectUUID = "d79bcef4-6408-f172-a5f8-d0681a6f3d85",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[200] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "88df51d3-e2ae-6237-441a-76190e2053a3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[201] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e0e0afb2-7498-8296-3990-0ce07e64d2c2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "55c6ff42-04b5-9e1c-8e77-6c062404aa1c",
				version = 2,
			},
			inheritedObjectUUID = "ecc2a899-f7e1-d241-bf78-cb103ca06fcb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "3f939350-d21e-2cd0-b38c-f99d141ca8c2",
				version = 2,
			},
			inheritedObjectUUID = "99c1b094-89ea-ee7f-a8bc-82c1b2e2a2c5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 20s",
				uuid = "15bff7b4-9fe0-4b55-b1c6-1346ca143509",
				version = 2,
			},
			inheritedObjectUUID = "66c56af6-16eb-3db2-a3e6-b46dd9f59820",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Remove Target",
				uuid = "889d64a8-bbc3-4a95-8351-486dd21b6f51",
				version = 2,
			},
			inheritedObjectUUID = "89057924-152d-3790-a422-52cf27ab86c3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 15s",
				uuid = "57ae2537-4c92-da9d-9aad-c6cf7f113e49",
				version = 2,
			},
			inheritedObjectUUID = "fb619610-f420-11b1-911e-99ac59c05bde",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[203] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f1df265c-42b6-e2f0-9987-5a862cb5a8ec",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "81d7f902-582b-159b-8a77-43d3197b1f53",
				version = 2,
			},
			inheritedObjectUUID = "cae736ad-f08d-a2c6-bb4f-9aba6e9c03fb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "450c59f2-b2e9-1c43-b2e6-738fb0297d2c",
				version = 2,
			},
			inheritedObjectUUID = "e895bb16-1de4-ab47-9108-397b1c28b20d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "432840b1-208c-33f8-bff9-9d9bdfde8255",
				version = 2,
			},
			inheritedObjectUUID = "bdde8b68-457d-5945-acf8-a16af77b0f49",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "b42ede26-e1ec-0b36-9571-1f04bf14cf51",
				version = 2,
			},
			inheritedObjectUUID = "94bcd353-a545-6dd6-a58d-2eb3dc840333",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "1dab640d-99ae-9624-8eac-e7eb5cfdd438",
				version = 2,
			},
			inheritedObjectUUID = "8034508b-5794-9ac1-9918-72adb8a2cac7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Remove Target",
				uuid = "3899a421-b964-d889-88b2-934a346d5a11",
				version = 2,
			},
			inheritedObjectUUID = "073663ec-5ea0-bae2-be18-0b79b0495894",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "09c84a0c-0a7a-b521-96e6-ffedbac98f34",
				version = 2,
			},
			inheritedObjectUUID = "8414eed2-b1da-5c6c-af2f-46a820ac8900",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[rDPS] Precast Potion",
				uuid = "05238a2f-2955-3499-8206-715d73ab40bb",
				version = 2,
			},
			inheritedObjectUUID = "6430f911-1f3f-41e4-a330-c08d1945816f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "f7372573-95fe-892f-02f0-c61dad3c7d03",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH] P6 HP safety guard",
				uuid = "60b4e373-93ef-4e9f-8d3f-37942e8f1444",
				version = 2,
			},
			inheritedObjectUUID = "8c7180dd-3c17-6055-b503-d4cbeeefc73a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] P6 Brotherhood on cooldown",
				uuid = "43380353-d2de-d191-b02b-0d174b41c711",
				version = 2,
			},
			inheritedObjectUUID = "112c39f1-95bc-8432-b8be-db72b8250761",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] P6 Riddle of Fire on cooldown",
				uuid = "a6315216-a834-8a94-9a59-3ae3724b01ba",
				version = 2,
			},
			inheritedObjectUUID = "93ae4200-66d4-aab0-a980-cc8e624f672a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[205] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "306f1066-ee0d-8162-4880-dd7c3d18ce76",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Tethers",
				uuid = "f99e0f0a-3add-a52b-8c33-e8c05aca8c90",
				version = 2,
			},
			inheritedObjectUUID = "6f552a4e-f3c4-caf5-8a5b-49db3d1b21f3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "37ed62b9-c864-e853-a100-55becc66cc94",
				version = 2,
			},
			inheritedObjectUUID = "1d70c495-969f-9ce0-9f1b-02d5c2b03d85",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "52c5d178-5237-47b7-95d2-9a88096ad530",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Detect Tank Mech Hraesvelgar",
				uuid = "99c62a3b-511a-c115-ae76-1b541541b28d",
				version = 2,
			},
			inheritedObjectUUID = "d3ed2828-c088-2be6-aab3-4654cbf034e6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Detect Tank Mech Nidhog",
				uuid = "2ed3479a-07c6-7179-ad22-3cdc761d4e00",
				version = 2,
			},
			inheritedObjectUUID = "56cef626-3fac-8ab1-a354-123d677da577",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Tank Mech",
				uuid = "4581eea7-b7e3-3fdb-ba51-2a3861818600",
				version = 2,
			},
			inheritedObjectUUID = "8a097c9f-58a3-88e5-96fd-e2778bc92b25",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "70a971bd-c752-f611-94a5-2053cecf91cd",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[207] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6325ebc0-eb0d-798c-50e3-b452686bb6d0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS Mortal Vow Passing",
				uuid = "1c37ce84-0627-6349-8412-d7342a3649c4",
				version = 2,
			},
			inheritedObjectUUID = "c6dd700d-29e8-f194-9777-f97d4abc2fdf",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Find Highest HP target",
				uuid = "47ab47ce-b8f0-a1e3-9272-6a6608f4e526",
				version = 2,
			},
			inheritedObjectUUID = "523036da-d7d2-3717-bc56-7f10bb6b38a9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "99e5ea3f-1aa5-0a63-cbaa-d34112d4424f",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[208] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "48f7cb2b-48d0-23cf-234f-d2f1d5e9d47b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "606dc0c9-7c42-0ee7-ad70-7ee694e7e4e8",
				version = 2,
			},
			inheritedObjectUUID = "b5715b6e-a2af-28c3-af50-b003cf462129",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "222d5681-b1f1-a225-b62d-a6b7e668e2af",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Reset tank mech",
				uuid = "5a92bc4b-cc4b-b25a-be48-5cc9c973dab5",
				version = 2,
			},
			inheritedObjectUUID = "3c01bee0-8509-71ac-8746-a1725b5dd4a7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Target hraes",
				uuid = "cfd48fdb-b9b8-46cb-864e-abacb2641aec",
				version = 2,
			},
			inheritedObjectUUID = "7fab58f7-f2d1-a146-98a5-ecb80d086ba2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Bio",
				uuid = "4345e7bc-d191-b2c2-b056-a06c9331b257",
				version = 2,
			},
			inheritedObjectUUID = "c7272790-b1c9-c2bf-871e-b516f369662c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "1b192d40-dfbd-9ffc-d14c-eefea0e0a190",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "512d1050-5869-199c-9e71-3ea171ea95c5",
			},
			objectType = "folder",
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
							actionLua = "\n\nlocal s = data.dsrBrdBalance\nif not s then\n    s = {margin=1, pins={[0]=false,[1]=false},\n        nidhoggOptions={contentid=3458,subgroup=\"Nearest\"},\n        hraesvelgrOptions={contentid=4954,subgroup=\"Nearest\"}}\n    data.dsrBrdBalance = s\n    function s.usable(e,slot)\n        local model=data.dsrBrdAutoSim\n        if not model or model.phase~=\"p6\" or not model.available(slot,TensorCore.API.TensorACR.getAutoSimTime()) then return false end\n        return e ~= nil and e.targetable and e.attackable and e.hp.max > 0\n            and e.hp.current > 0 and math.max(0,e.distance2d-e.hitradius) <= 25\n    end\n    function s.pin(slot,id)\n        if s.pins[slot] ~= id then\n            if id then TensorCore.API.TensorACR.setAutoSimTarget(slot,id)\n            else TensorCore.API.TensorACR.clearAutoSimTarget(slot) end\n            s.pins[slot] = id\n        end\n    end\nend\nif not s.nidhoggID then\n    local e = TensorCore.getEntityByGroup(\"ContentID\",s.nidhoggOptions)\n    if e then s.nidhoggID=e.id end\nend\nif not s.hraesvelgrID then\n    local e = TensorCore.getEntityByGroup(\"ContentID\",s.hraesvelgrOptions)\n    if e then s.hraesvelgrID=e.id end\nend\nlocal n = s.nidhoggID and TensorCore.mGetEntity(s.nidhoggID)\nlocal h = s.hraesvelgrID and TensorCore.mGetEntity(s.hraesvelgrID)\nlocal nu,hu = s.usable(n,0),s.usable(h,1)\nlocal current = TensorCore.mGetTarget()\nlocal chosen\nlocal nDot,hDot = nu,hu\nif nu and hu then\n    local gap=100*n.hp.current/n.hp.max-100*h.hp.current/h.hp.max\n    if gap > s.margin then chosen=n;hDot=false\n    elseif gap < -s.margin then chosen=h;nDot=false\n    elseif current and (current.id==n.id or current.id==h.id) then chosen=current\n    else chosen=gap>=0 and n or h end\nelseif nu then chosen=n\nelseif hu then chosen=h end\ns.desiredID=chosen and chosen.id or nil\n\n\ns.pin(0,nDot and n.id or nil)\ns.pin(1,hDot and h.id or nil)\nself.used=true",
							name = "P6 dragon HP balance",
							uuid = "cafebf52-bb67-e2a7-8dcc-2e11fa1e98c5",
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
									"bb7da3a0-4804-34d2-9a64-ee9469d79973",
									true,
								},
							},
							name = "Target higher HP dragon",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "cd0692c6-303a-ca7a-8b26-6768bb1c31bb",
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
							conditionLua = "local s=data.dsrBrdBalance\nlocal t=TensorCore.mGetTarget()\nreturn s and s.desiredID and eventArgs.detectionTargetID==s.desiredID and (not t or t.id~=s.desiredID)",
							name = "Higher HP dragon",
							uuid = "8bc37fa4-d93e-e403-b511-50553e7c4bcd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							conditions =
							{

								{
									"8bc37fa4-d93e-e403-b511-50553e7c4bcd",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "Available dragon",
							uuid = "bb7da3a0-4804-34d2-9a64-ee9469d79973",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 1254.2,
				name = "[AutoSim] P6 dragon HP balance",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 208,
				timerEndOffset = 150,
				timerStartOffset = -40,
				uuid = "7f3048ef-0d64-0a67-a053-e826566631a9",
				version = 2,
			},
		},
	},
	[209] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8fb3d3aa-10af-118e-e303-f8588f488c7a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Pre-draw cauterize (niddy)",
				uuid = "903139e9-d05c-b510-a494-8f485cd659eb",
				version = 2,
			},
			inheritedObjectUUID = "8eda97a1-357b-ec29-99a8-0fee95de3d40",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[211] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "19133f69-ba12-204d-b704-23d7ca8b34b9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Hallowed Wings",
				uuid = "981ed118-d9df-bcf4-b008-3c890aef43bc",
				version = 2,
			},
			inheritedObjectUUID = "f848d4c1-4f27-f5bd-ad43-453aa7806bb5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Party Location",
				uuid = "f9e70446-3163-2c1b-83fe-47d515d1a0bb",
				version = 2,
			},
			inheritedObjectUUID = "1a278774-f25a-6cee-83ab-f32c4e507b71",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[212] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "78b46716-7fca-1dfa-a94d-3d90ea2f3da6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS + Draw Mortal Vow Passing",
				uuid = "beb65f60-ba24-bba2-8fc7-91cc6b93b43c",
				version = 2,
			},
			inheritedObjectUUID = "509b18a5-bf30-80fa-9857-537b74851d04",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[213] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e6ca46b7-c66b-65fb-56b3-b50997fd6f87",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Automarkers",
				uuid = "8ac42cc0-56b6-82be-aa51-737ca56fdba0",
				version = 2,
			},
			inheritedObjectUUID = "b9b1ddf8-6f34-9386-af4a-1db7538207de",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Target nidhog",
				uuid = "0c051b44-4c74-01c2-9597-c792ea5f9b90",
				version = 2,
			},
			inheritedObjectUUID = "ddbdd4be-660e-bd05-9a20-0a5c0d514451",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "236d0af4-7e49-cb10-fbfd-cd86868a3784",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[214] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ef295e0c-66e6-ee88-50af-428299e2b99c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[215] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "d6b2e935-68bb-a1e1-8d52-bd6382d4f585",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Pre-draw cauterize (hraes)",
				uuid = "7ce176bd-c0b2-e541-871e-43c923ce3daf",
				version = 2,
			},
			inheritedObjectUUID = "b9c282b1-f256-2349-8b64-cb8f6e4e8be7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[216] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "f22965e2-2990-a8ee-2976-cbace1c965f2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "91dffedf-4c5a-d15c-83fb-274f98d1988c",
				version = 2,
			},
			inheritedObjectUUID = "cc292ad3-fc2f-ac6b-a4a0-4f47b5a5b9cf",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "b0da5331-0a23-8f67-88db-8d9926e0c6d2",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[218] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "be9dafa8-1d37-3a6c-7557-bd2e1b498278",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Enable Bio",
				uuid = "a5bdec5d-1185-e7ba-9a70-a1d23e6a7e82",
				version = 2,
			},
			inheritedObjectUUID = "ba49e951-9d28-050e-84fe-1905b07cfc55",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Spreads",
				uuid = "d3476c2c-41eb-a1f1-a9ff-66169a7e8ff6",
				version = 2,
			},
			inheritedObjectUUID = "7bc9ae7f-db37-7439-9d58-7e1d54c0b897",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[219] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "acddcc81-456c-2995-8cd5-7def50ae5d11",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find Highest HP target",
				uuid = "958d3374-b9ae-9ea6-9de0-73091cf33a02",
				version = 2,
			},
			inheritedObjectUUID = "c7a83263-c8c8-dbb5-80ce-d1b81bf9429c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[220] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "be2e04cd-412f-ee91-e5f4-33dfb1aad31d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "186f285a-925b-d5b4-ae5d-41f389b8d492",
				version = 2,
			},
			inheritedObjectUUID = "82ea868e-dd9e-901f-abf9-9c5cd955d19d",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "c71e3488-ec02-9b3a-9890-d7826399cfee",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Disable Markers",
				uuid = "cde4cc64-4eb6-e25f-806d-4abe9befe9d6",
				version = 2,
			},
			inheritedObjectUUID = "c994c03c-e7a9-cb9b-b362-bfc463b4aa32",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[222] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ca874a7b-af4d-245f-77d6-fe11cf3cf74b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable Markers",
				uuid = "c4f72712-88b1-15d6-bec9-cef6d16ad694",
				version = 2,
			},
			inheritedObjectUUID = "5951b56e-f6f3-9883-bec4-3e74c7403a88",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS + Draw Mortal Vow Passing",
				uuid = "709f4e10-f9d9-ca7d-bdd2-b3874da095e4",
				version = 2,
			},
			inheritedObjectUUID = "f1c730da-b880-6871-80d0-1e25048f3f3e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[223] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "83e6027a-1947-c81e-4272-237871e789ca",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "a725c297-7424-c939-a8d8-b5e7a99b8b7f",
				version = 2,
			},
			inheritedObjectUUID = "06b5fbeb-063c-cb6f-829a-ac872e940659",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "19ed045f-a2b2-7604-a174-a0bdd5bbaf9f",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Target hraes",
				uuid = "1437c201-2941-e2c1-8321-e8d34cedcb2b",
				version = 2,
			},
			inheritedObjectUUID = "265a6a86-2fae-46e9-9a1b-bf8e927efbe5",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw on Healers",
				uuid = "9df6a564-e93d-5211-a500-4c00a3c7e2ad",
				version = 2,
			},
			inheritedObjectUUID = "bf801fe6-d43d-531b-97b0-70ad40257701",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "79b4d119-84a7-6f25-0cc8-0b87fb3f9d29",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[229] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "21531eec-49a4-1780-1157-dea624e5e5fc",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Hallowed Wings",
				uuid = "700bb824-68e4-0b32-aa41-158b6c12cdf2",
				version = 2,
			},
			inheritedObjectUUID = "f469ab10-4c98-1adf-a98d-ba0534de9033",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "TTS Party Location",
				uuid = "4a739770-68c3-c14f-91f4-0b24c393af80",
				version = 2,
			},
			inheritedObjectUUID = "ff6273f0-e956-767f-947c-a7395e2b39ee",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Force Queen",
				uuid = "93cac2ae-0eae-f28b-a0b8-92af0eab99f5",
				version = 2,
			},
			inheritedObjectUUID = "63d517ef-600a-2e28-89dc-c72fb811c8b1",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[230] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "65f013ea-a317-38ce-cd43-e84c82e6dcba",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS + Draw Mortal Vow Passing",
				uuid = "536d2143-4ec3-d79c-a279-4e4bf581039c",
				version = 2,
			},
			inheritedObjectUUID = "1cfede9b-4eec-fe93-b3b2-460fadca1fb3",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[232] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1a2e0e14-f633-c168-4894-072288e9fba4",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "3b9587bc-7d0e-83fd-8f09-13faa844fb5b",
				version = 2,
			},
			inheritedObjectUUID = "ce60a460-6d94-6428-893f-e4b687f8448d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 15s",
				uuid = "cc77cec0-a7ec-e5ae-b562-225235a251ef",
				version = 2,
			},
			inheritedObjectUUID = "e115c696-2892-3fd2-9530-02a92a54490d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable 20s",
				uuid = "a9a0eb80-f8bc-4ced-b34e-8ba89c8b4790",
				version = 2,
			},
			inheritedObjectUUID = "43be994b-fbc6-13da-b1a0-6b853115a63e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Tethers",
				uuid = "5c1ca598-c1f2-7011-9658-1e952fb3afea",
				version = 2,
			},
			inheritedObjectUUID = "02c84f78-6b86-0726-8dbe-76434df9d50c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Detect Tank Mech Hraesvelgar",
				uuid = "faedacd4-d589-01b7-861d-92055d144d4a",
				version = 2,
			},
			inheritedObjectUUID = "cf2e912a-0674-45d1-82fe-2642e45fb060",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Detect Tank Mech Nidhog",
				uuid = "d4aa9323-c9d4-d691-93c5-007def0dd403",
				version = 2,
			},
			inheritedObjectUUID = "375d4852-efa6-8a66-9df0-b2d6059b5435",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Draw Tank Mech",
				uuid = "e80d8f09-d5ce-a519-968d-6c61c1a4360d",
				version = 2,
			},
			inheritedObjectUUID = "008cce79-8648-ae95-be51-52ddb84ce369",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Avoid ninki cap",
				uuid = "2afafd7c-70e5-00e3-8210-3c10925bb565",
				version = 2,
			},
			inheritedObjectUUID = "f2a97044-7e5f-8e6d-b1d6-840698a2b60d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Scattergun",
				uuid = "89df1514-e297-9d74-825e-9907e6843931",
				version = 2,
			},
			inheritedObjectUUID = "41e33cbe-b431-92b0-973b-eddefad0bd41",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[233] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "10b3853d-4f81-cc41-c22f-a283166b170d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable Hypercharge",
				uuid = "e5e7d4b1-d4fc-ec91-9ee6-3a85237a6d97",
				version = 2,
			},
			inheritedObjectUUID = "99c4d18d-9de8-be9e-82ca-d23aba47281f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Queen",
				uuid = "9317c0f2-5660-09f6-ba51-8958269b3e23",
				version = 2,
			},
			inheritedObjectUUID = "b81ad959-59f5-0f96-bbc5-01a7cda4418c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Armor Crush",
				uuid = "55865289-da30-48e9-bbda-c0ad31421812",
				version = 2,
			},
			inheritedObjectUUID = "ce8c61df-0197-56e6-8c09-7944404e8f63",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "c4727ce2-3605-3d8e-7bbb-4ec8a25c6c32",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
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
							actionLua = "local s=data.dsrBrdAutoSim\nlocal player=TensorCore.mGetPlayer()\nif not s or s.phase~=\"p6\" or not player or eventArgs.entityID~=player.id then self.used=true return end\nlocal id=eventArgs.buffID\nif id~=2898 and id~=2899 then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\n\nif math.abs(now-s.at(28))>20 then self.used=true return end\n\nlocal margin=2\ns.wb2StopOffset=now+math.max(0,eventArgs.buffDuration-margin)-s.at(28)\ns.rebuildPersonalStop()\nself.used=true",
							name = "Forecast own fire or ice action stop",
							uuid = "94485732-deb7-cb5a-b730-c671ce55d667",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 8,
				mechanicTime = 1356.5,
				name = "[AutoSim] WB2 personal fire/ice downtime",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = 25,
				timerStartOffset = -2,
				uuid = "3d834a2e-aefe-6497-8980-23e1bff4a4b3",
				version = 2,
			},
		},
	},
	[234] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1d63ac9e-93a4-bb5a-2416-ebb051bcc5ae",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Stop if fire",
				uuid = "f519ec3f-a78a-222f-a29e-32443cb84820",
				version = 2,
			},
			inheritedObjectUUID = "c4259f37-b557-16e5-9154-ea8dff3653fd",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Keep going if ice",
				uuid = "fbae1646-945f-bbd4-a35e-a8070a6e3866",
				version = 2,
			},
			inheritedObjectUUID = "ff71c181-4b74-b69d-afe5-04dfc3920f4b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Resume after fire",
				uuid = "ece38e59-651d-6a68-8ed9-c5e685b4cc52",
				version = 2,
			},
			inheritedObjectUUID = "efab6804-c968-183f-ae66-4d20f50d0dcc",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "edbd1ba5-b264-c5b9-0117-036f0d6a9df5",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},
	},
	[235] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b36908df-9928-3ddb-798a-bea9693a866f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Enable CDs",
				uuid = "015d2f0c-e15b-470f-a6e1-6613dd167503",
				version = 2,
			},
			inheritedObjectUUID = "d8c964bf-dbc9-00fa-9510-52bf502e3f10",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Target nidhog",
				uuid = "d59f91e6-84d9-8017-89df-0bbae36623b4",
				version = 2,
			},
			inheritedObjectUUID = "eedf48c4-10c2-80dd-99a6-356d5ad4f40e",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "7f93e849-6b66-7ae5-bbb3-30833343cbb5",
				version = 2,
			},
			inheritedObjectUUID = "402ba1bf-c938-b022-826e-26b6eed24b62",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "329aa322-131a-935f-9498-7936fa43d95b",
				version = 2,
			},
			inheritedObjectUUID = "9a3cbf9e-a50a-1600-b893-d892d4be1eb0",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Reassemble",
				uuid = "8b0f10a9-e56f-8e27-bdaf-1be3209484a3",
				version = 2,
			},
			inheritedObjectUUID = "65724180-6d35-70c0-a497-afddf26fc708",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Bio",
				uuid = "2231903a-f5cb-4958-98b1-635dfd5758c3",
				version = 2,
			},
			inheritedObjectUUID = "f0cbc0f4-dc44-f575-912d-76d5feb17c8c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Disable burn",
				uuid = "d9c33451-96bf-1de0-a577-1bdd82321d88",
				version = 2,
			},
			inheritedObjectUUID = "b84adfa4-11f5-8547-a61d-634ddebf7f99",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "bcb31393-8737-6a2b-9029-c47ea421f63f",
				version = 2,
			},
			inheritedObjectUUID = "5eafd0bf-dc41-e257-a066-21fa2c9af02d",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Force MB",
				uuid = "2b38f7f2-8246-e1a0-9f8c-4772edfa8b17",
				version = 2,
			},
			inheritedObjectUUID = "60c14577-bf43-4872-9208-65b149aa0165",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[236] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0fe6f878-f6d6-2ac4-37b4-f85669d3ab48",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "TTS + Draw Mortal Vow Passing",
				uuid = "73eb68cc-fc05-c6ec-948b-2f7ec78c5f10",
				version = 2,
			},
			inheritedObjectUUID = "d8aa0105-4fb0-2788-a95b-bea05818d6d6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[237] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "454bd311-e04b-b42d-321b-25f74c0c65a1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "b5b93b88-f025-8ff0-96d9-07a503f8a4b9",
				version = 2,
			},
			inheritedObjectUUID = "4d15b9eb-df35-b160-b36a-75d095234693",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[239] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ff33af13-fb74-1677-16f2-c3ad69b7c5e3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Improvised finish",
				uuid = "9280fd5d-93ec-8d54-951b-d2711f40e7ae",
				version = 2,
			},
			inheritedObjectUUID = "f20ea85a-4743-5b8f-92de-797f3a76f74b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Improv",
				uuid = "0340f758-f405-0f7b-ac67-2e5189018980",
				version = 2,
			},
			inheritedObjectUUID = "2d152a56-ea2c-0b52-b249-aef095cc1ca2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[242] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "539db0c1-7f5a-8f2d-5897-930bb53b9051",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[243] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fa4fa5e8-95e5-05c4-d7c6-2c8a46ceeeb8",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Find target",
				uuid = "af911324-64d7-919d-8470-f8a4468432cc",
				version = 2,
			},
			inheritedObjectUUID = "3d85dc4a-5e88-8b66-a227-8650eb8e968c",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Enable CD",
				uuid = "1ced0cf8-e52c-2f3a-816e-63459e0b61ac",
				version = 2,
			},
			inheritedObjectUUID = "a05254dd-c039-0609-8e6e-089c4b27fb93",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Set Thordan ID",
				uuid = "86619dc3-25f7-84b8-adfc-93491f2eb911",
				version = 2,
			},
			inheritedObjectUUID = "39007ed5-17bd-fef0-88d6-b3e57c6531ab",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[NIN] Precast Mudra",
				uuid = "399ea34d-eca0-6265-b058-a5f1007d1aaa",
				version = 2,
			},
			inheritedObjectUUID = "4ca25e24-82e6-8a0b-9299-5f9849507255",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[DNC] Precast Dance",
				uuid = "dbb4db68-34a7-1174-9b73-50773bd021fc",
				version = 2,
			},
			inheritedObjectUUID = "0f034b2a-3b42-0737-a3a9-5b6ceee87510",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Precast Queen",
				uuid = "18e10443-02ac-5321-bcc4-9ae567cc9501",
				version = 2,
			},
			inheritedObjectUUID = "a46b64f1-a699-0a0d-8f80-7aba7e797a58",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Flamethrower",
				uuid = "a25f48e6-3784-c8b5-9ea6-39a7e3e4262d",
				version = 2,
			},
			inheritedObjectUUID = "5752256e-579e-f24f-bee6-d9bea05cf84a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] Form Shift",
				uuid = "f3378947-2547-9f6d-814e-23a963630e3a",
				version = 2,
			},
			inheritedObjectUUID = "dbedcd03-647a-33d7-bfb1-4534195714af",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "b33427b7-dea0-926b-cb98-dd69e10ad547",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MNK] P7 transition Blitz preparation",
				uuid = "09e46455-fbc8-32ae-b712-731d39c0b95c",
				version = 2,
			},
			inheritedObjectUUID = "dfec9f59-c52a-f253-9839-517b96ef0734",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MNK] P7 transition Blitz preparation release",
				uuid = "b90575ce-f475-8555-91b8-c463a6618f8a",
				version = 2,
			},
			inheritedObjectUUID = "834ed73d-0de1-f664-a35b-0840fab54d58",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "331935f5-ceb6-0401-b5d1-10f698cea6b5",
			},
			objectType = "folder",
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
							actionLua = "local s=data.dsrBrdAutoSim\ns.points[35].time=TensorCore.API.TensorACR.getAutoSimTime()+10\ns.rebuild()\nself.used=true",
							conditions =
							{

								{
									"432932ee-4c23-6d56-aaa6-17928c77cd8f",
									true,
								},
							},
							name = "Extend DSR late kill",
							uuid = "d15ada42-a205-8c95-9cb9-f585fc906afa",
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
							conditionLua = "local s=data.dsrBrdAutoSim\nreturn s and s.nextBoundary==35 and TensorCore.API.TensorACR.getAutoSimTime()>=s.points[35].time",
							name = "Alive past estimate",
							uuid = "432932ee-4c23-6d56-aaa6-17928c77cd8f",
							version = 3,
						},
					},
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 1542.1,
				name = "[AutoSim] Extend DSR late kill",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 400,
				uuid = "878e7435-bc07-32af-9955-edcb40676d97",
				version = 2,
			},
		},
	},
	[244] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9d44225b-3980-a20f-9bff-8731b8d923ab",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Exaflares",
				uuid = "a9e3b109-a0d6-577b-bed5-f34d31635301",
				version = 2,
			},
			inheritedObjectUUID = "20ce0d84-6b3e-2314-ae96-c9d097a0aec4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Reset exaflares",
				uuid = "3e6bf96d-1d32-fcdc-a0f2-590de63c9965",
				version = 2,
			},
			inheritedObjectUUID = "8e970bf4-970b-d67b-b5db-c623a9b32ea6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[245] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "97c09fda-4226-13ce-fb48-1d98ff952c2a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "31fb40e9-dd0f-9a26-b94f-b37204935904",
				version = 2,
			},
			inheritedObjectUUID = "bc868fc3-8cd5-9124-b1ac-7650a8650e48",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[248] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ff8ffaf7-2a97-6e03-fe23-f4a54b108bc7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "9c6d0a3d-4834-f607-9ced-f62c41eb10f3",
				version = 2,
			},
			inheritedObjectUUID = "6a91da67-009d-99d3-93e1-670905026457",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "e9c38766-29fe-6c76-b6de-eb0f1922deb1",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[249] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0529cd56-b0fb-d2a2-a04c-5ebca05068e6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "17a5ccf8-5002-7c67-855c-b9abbf7ebb04",
				version = 2,
			},
			inheritedObjectUUID = "c76fbf91-8660-aa79-9a38-b6e637b0e581",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[251] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "cb717b65-8bb7-9e71-fd12-757b469441b5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Hold until after gigaflares",
				uuid = "11e1a635-47f2-dbf9-8df9-374ce46dff78",
				version = 2,
			},
			inheritedObjectUUID = "1246a147-41d2-831f-9a0c-b266329199a0",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Shorter hold",
				uuid = "902c5763-4089-a7ab-8d1d-b8b7cf404a4f",
				version = 2,
			},
			inheritedObjectUUID = "7fdc452f-7a96-f998-b119-ddedeeb202a2",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[253] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4d9db6f3-bf59-bb3f-f0b9-2fcd7a6eb0c3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "85644dbe-fded-5d48-be9f-3c54e7caa023",
				version = 2,
			},
			inheritedObjectUUID = "07467977-ea9b-4621-86d5-00442779c12b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[MCH] Disable Reass Hold for pot",
				uuid = "62d02abb-41f1-1e4e-8ce0-62d43e9e1667",
				version = 2,
			},
			inheritedObjectUUID = "6cb0087a-00b1-429f-b68d-f28eb6c22bc4",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[254] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0704e1e0-4f32-c1f4-6037-b86eb6b41ff0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "a4415100-a90c-d5b2-8a49-141e08a445ff",
				version = 2,
			},
			inheritedObjectUUID = "6571fc0a-e7bc-c12d-a3e7-7d71d40f7191",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "4853a830-3a3d-8ecc-ae9a-8fa326a4d74e",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Smart Queen",
				uuid = "17d54483-f6b5-dab7-a51d-00fcdd4e662a",
				version = 2,
			},
			inheritedObjectUUID = "1798efab-4195-13cc-a845-8070fc8f3274",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[257] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "21302ae7-5b3f-ba4b-9f62-b16156ab9f37",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Exaflares",
				uuid = "31a50b9d-0534-9edb-8724-f96fdcac7f3d",
				version = 2,
			},
			inheritedObjectUUID = "5fd2bc41-6909-553e-b634-f1e96510fef6",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Reset exaflares",
				uuid = "58f4a070-fde3-7b0d-956f-d98ecb376482",
				version = 2,
			},
			inheritedObjectUUID = "4963fcf5-5a8c-a4d0-ba21-81817fa2940a",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Disable Fast TA",
				uuid = "4debdd1f-0939-f901-aaf7-13a4026356e9",
				version = 2,
			},
			inheritedObjectUUID = "92b69e0c-6700-b47c-8a24-a0c1d928fbb9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[258] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b43fcb74-a1f7-d860-a58d-73c28f6eb084",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "ea427f30-7aea-a270-8060-69d5204fbffa",
				version = 2,
			},
			inheritedObjectUUID = "d65ea3cc-f581-6161-9450-8f5c7f8f6e89",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[260] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "24288a09-fac4-ff55-2c61-9863f0207259",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[261] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "76c21290-91de-972c-efbe-1d8242299e20",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "6748e413-0efc-e46c-addc-dc2e3f102594",
				version = 2,
			},
			inheritedObjectUUID = "de6041db-8515-dd93-9d84-28ed47a0bdaf",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "5c41d611-8835-1760-bae2-5a7080324f9b",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Burn",
				uuid = "4f879bec-a166-fc6a-b8ea-be940b7cf44f",
				version = 2,
			},
			inheritedObjectUUID = "a967bdba-e4c5-1972-9bfe-01199cc73505",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[262] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8478f8d7-f5ba-88e3-316c-0ed586d17327",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "ae08257a-7222-c2e1-b5dc-4cc5e79f5682",
				version = 2,
			},
			inheritedObjectUUID = "2d8981d2-4f42-d2cb-81f3-9b089c94fcaa",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[266] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5ac79263-1f6b-ef57-f5c2-900927404733",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "bd703012-e52d-4522-99a6-bb5ffb6d0079",
				version = 2,
			},
			inheritedObjectUUID = "dd789161-7e78-9ceb-a24e-f5b167d50db7",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[267] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1e241782-1c55-2db6-485c-1890f3834092",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "b59d0d56-b5b7-0fc4-b7f5-01959579f73a",
				version = 2,
			},
			inheritedObjectUUID = "e9604ce9-8d8b-7541-9ace-0bcfd5e82595",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "9aae6eb2-7337-a0d3-8c1a-85ace47a055a",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[270] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "91603566-dcc4-cb32-95b1-16c09e09f376",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Exaflares",
				uuid = "c6396867-241c-31b6-ab5a-4c8b5d59f29f",
				version = 2,
			},
			inheritedObjectUUID = "61ad0911-9b06-73bb-bd5d-c2db602886e8",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Reset exaflares",
				uuid = "ddb15b29-eb39-cb04-b6f9-669c3e9c9d81",
				version = 2,
			},
			inheritedObjectUUID = "19775c0b-2d17-682c-9eb6-9b77ce7878bb",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[271] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "3c205847-84c3-6d53-fa12-6f79dfc09d17",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "f72e6626-5cab-e783-860f-39f8505b04b3",
				version = 2,
			},
			inheritedObjectUUID = "b9b92c07-58ac-1541-a3f7-5015e98e839b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[274] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "41d1d4b2-2c53-2be6-246a-515cdf55f7c2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Melee] Self-Mitigation",
				uuid = "3c1b7efc-85b7-dc6c-b3d1-d33c3594c186",
				version = 2,
			},
			inheritedObjectUUID = "92612433-165b-1620-9184-2478d7f7b6e6",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "remove",
						value =
						{
							data =
							{
								name = "",
								uuid = "63415d6d-0a31-494e-941b-e10161d72cc4",
								version = 2.1,
							},
							inheritedObjectUUID = "4a2a4cdc-3615-1f2f-9b87-1a4d77fcc66e",
						},
					},
				},
			},
		},
	},
	[275] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "e9d076d3-d713-4ec7-a3bd-a8456f1178a3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "84b418b1-d473-7674-a46e-41a79831c88b",
				version = 2,
			},
			inheritedObjectUUID = "57baee0b-e3a4-9c37-8961-f81f1349a1a9",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "Hold until after chariot/dynamo",
				uuid = "5f8643c2-d1e5-d514-a5ed-5aeabc430129",
				version = 2,
			},
			inheritedObjectUUID = "58b99957-b15e-2261-972e-3b24c4fb142f",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[280] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "3e036e3b-ae61-86af-2537-b6c1d07dcd0b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Burn",
				uuid = "a4a073d2-6a01-755d-8a84-1d757c4bedc4",
				version = 2,
			},
			inheritedObjectUUID = "ebf98ad8-199a-803a-bc3c-c6508f4ecb28",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	inheritedProfiles =
	{
		"Frog\\Ultimates\\DSR\\Draws",
		"store\\anyone\\dsw\\universal",
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl
