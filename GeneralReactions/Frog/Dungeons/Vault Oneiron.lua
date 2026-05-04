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
						aType = "Misc",
						conditions = 
						{
							
							{
								"b216ccef-cdc9-23e8-8c11-e97f1163df56",
								true,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "T Onion",
						setTarget = true,
						targetContentID = 14016,
						targetName = "Vault Onion",
						targetType = "ContentID",
						uuid = "722290b7-1d68-21ca-99c2-4693f654d61c",
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
								"b216ccef-cdc9-23e8-8c11-e97f1163df56",
								false,
							},
							
							{
								"4b0b3cbf-a084-2fc2-b7eb-5222df7c6faf",
								true,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "T Egg",
						setTarget = true,
						targetContentID = 14017,
						targetName = "Vault Eggplant",
						targetType = "ContentID",
						uuid = "7080f1c7-d996-82f2-9c9a-47f51897655a",
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
								"4b0b3cbf-a084-2fc2-b7eb-5222df7c6faf",
								false,
							},
							
							{
								"daff7cc4-75b4-e80e-9ebd-accfd3c4beec",
								true,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "T Garlic",
						setTarget = true,
						targetContentID = 14018,
						targetName = "Vault Garlic",
						targetType = "ContentID",
						uuid = "bfacacaa-770a-dcb6-9a1b-db2c0ba277c6",
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
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
							
							{
								"8b650906-8278-1082-b5bf-6b7c21a9e5a9",
								true,
							},
							
							{
								"daff7cc4-75b4-e80e-9ebd-accfd3c4beec",
								false,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "T Tomato",
						setTarget = true,
						targetContentID = 14019,
						targetName = "Vault Tomato",
						targetType = "ContentID",
						uuid = "b2086017-1d63-b8cd-a968-821ce043b3e4",
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
								"25d0f585-3ba2-fa27-ab53-7401c872dc95",
								true,
							},
							
							{
								"8b650906-8278-1082-b5bf-6b7c21a9e5a9",
								false,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_CD",
						name = "T Queen",
						setTarget = true,
						targetContentID = 14020,
						targetName = "Vault Queen",
						targetType = "ContentID",
						uuid = "459bc083-001f-e41e-9984-9c3541a5c14d",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "_G[\"ACR_\" .. gACRSelectedProfiles[TensorCore.mGetPlayer().job] .. \"_AOE\"] = false\nself.used = true",
						conditions = 
						{
							
							{
								"23d16a6c-1e12-71c0-88bb-dfe79f9d0fc6",
								true,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_AOE",
						gVarValue = 2,
						name = "Disable AOE toggle",
						uuid = "5f2746e9-1b49-8955-b0e5-c4c3216f48b7",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "_G[\"ACR_\" .. gACRSelectedProfiles[TensorCore.mGetPlayer().job] .. \"_AOE\"] = true\nself.used = true",
						conditions = 
						{
							
							{
								"23d16a6c-1e12-71c0-88bb-dfe79f9d0fc6",
								false,
							},
							
							{
								"3196575f-1519-ad21-bc66-23ddcc1ec741",
								true,
							},
						},
						gVar = "ACR_TensorMagnum3_AOE",
						name = "Enable AOE toggle",
						uuid = "ebdc92ad-3c18-4f03-b72a-2263cf3be528",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "Onion Exists",
						partyTargetContentID = 14016,
						partyTargetName = "Vault Onion",
						uuid = "b216ccef-cdc9-23e8-8c11-e97f1163df56",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "Eggplant Exists",
						partyTargetContentID = 14017,
						partyTargetName = "Vault Eggplant",
						uuid = "4b0b3cbf-a084-2fc2-b7eb-5222df7c6faf",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "Garlic Exists",
						partyTargetContentID = 14018,
						partyTargetName = "Vault Garlic",
						uuid = "daff7cc4-75b4-e80e-9ebd-accfd3c4beec",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "Tomato Exists",
						partyTargetContentID = 14019,
						partyTargetName = "Vault Tomato",
						uuid = "8b650906-8278-1082-b5bf-6b7c21a9e5a9",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "Queen Exists",
						partyTargetContentID = 14020,
						partyTargetName = "Vault Queen",
						uuid = "25d0f585-3ba2-fa27-ab53-7401c872dc95",
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
								"b216ccef-cdc9-23e8-8c11-e97f1163df56",
								true,
							},
							
							{
								"4b0b3cbf-a084-2fc2-b7eb-5222df7c6faf",
								true,
							},
							
							{
								"daff7cc4-75b4-e80e-9ebd-accfd3c4beec",
								true,
							},
							
							{
								"8b650906-8278-1082-b5bf-6b7c21a9e5a9",
								true,
							},
							
							{
								"25d0f585-3ba2-fa27-ab53-7401c872dc95",
								true,
							},
						},
						matchAnyBuff = true,
						name = "Any vege alive?",
						partyTargetNumber = 0,
						uuid = "23d16a6c-1e12-71c0-88bb-dfe79f9d0fc6",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Self",
						conditionType = 8,
						localmapid = 1279,
						uuid = "3196575f-1519-ad21-bc66-23ddcc1ec741",
						version = 3,
					},
				},
			},
			enabled = false,
			name = "TARGET",
			uuid = "f6cf29b0-6e15-f9d7-8b58-046f290f6545",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl