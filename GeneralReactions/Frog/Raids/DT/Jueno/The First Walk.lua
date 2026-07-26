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
						aType = "ACR",
						conditions = 
						{
							
							{
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
							
							{
								"0ef616ec-aa02-ef52-9733-4f4c535fc2db",
								true,
							},
						},
						gVar = "ACR_RikuSCH3_AOE",
						gVarValue = 2,
						name = "Disable AOE",
						uuid = "8b1670cb-74df-8e62-bb03-cdd8745c6244",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "ACR",
						conditions = 
						{
							
							{
								"0ef616ec-aa02-ef52-9733-4f4c535fc2db",
								true,
							},
							
							{
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
						},
						gVar = "ACR_RikuSCH3_SmartDoT",
						gVarValue = 2,
						name = "Disable Smart DoT",
						uuid = "f198c923-d1af-fa80-9dfe-8d8ec31d02aa",
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
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
							
							{
								"477c9900-9519-273b-8ade-a140028b75cd",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Fallback targeting MR",
						setTarget = true,
						targetContentID = 13641,
						targetType = "ContentID",
						uuid = "8249073d-6f40-0a8c-9ebd-f15cfbefe438",
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
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
							
							{
								"fb81ab92-fe74-e555-a89b-9f58708f49c7",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Fallback targeting TT",
						setTarget = true,
						targetContentID = 13642,
						targetType = "ContentID",
						uuid = "a36855bf-2504-25c5-bd88-c62c84640471",
						version = 2.1,
					},
					inheritedIndex = 4,
				},
				
				{
					data = 
					{
						aType = "Misc",
						conditions = 
						{
							
							{
								"dff56020-a643-f0a5-aa89-9a52068d3e89",
								true,
							},
							
							{
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Fallback targeting GK",
						setTarget = true,
						targetContentID = 13643,
						targetType = "ContentID",
						uuid = "9040c6ba-3911-36ab-8280-124e7b780fc1",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "ACR",
						conditions = 
						{
							
							{
								"5ebee4ab-f12c-3cc2-8c4e-9965930a9b54",
								true,
							},
							
							{
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
							
							{
								"0ef616ec-aa02-ef52-9733-4f4c535fc2db",
								false,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_AOE",
						name = "Enable AOE",
						uuid = "d8f3a7a9-7c40-e199-87d3-47f616c54301",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "ACR",
						conditions = 
						{
							
							{
								"5ebee4ab-f12c-3cc2-8c4e-9965930a9b54",
								true,
							},
							
							{
								"138584e8-8083-172b-b2a0-16c8e7d2a1f7",
								true,
							},
							
							{
								"0ef616ec-aa02-ef52-9733-4f4c535fc2db",
								false,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_SmartDoT",
						name = "Enable Smart DoT",
						uuid = "b7789362-c6b8-07ef-9b5a-11c161b295dc",
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
						localmapid = 1248,
						name = "M - In First Walk",
						uuid = "138584e8-8083-172b-b2a0-16c8e7d2a1f7",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						buffCheckType = 5,
						buffIDList = 
						{
							4196,
							4194,
							4192,
						},
						category = "Self",
						matchAnyBuff = true,
						name = "B - Has Firewall",
						uuid = "0ef616ec-aa02-ef52-9733-4f4c535fc2db",
						version = 3,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						buffID = 4192,
						category = "Self",
						name = "B - Epic Hero",
						uuid = "477c9900-9519-273b-8ade-a140028b75cd",
						version = 3,
					},
					inheritedIndex = 3,
				},
				
				{
					data = 
					{
						buffID = 4194,
						category = "Self",
						name = "B - Fated Hero",
						uuid = "dff56020-a643-f0a5-aa89-9a52068d3e89",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						buffID = 4196,
						category = "Self",
						name = "B - Vaunted Hero",
						uuid = "fb81ab92-fe74-e555-a89b-9f58708f49c7",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Filter",
						conditions = 
						{
							
							{
								"07ba113f-6106-6c31-b329-dee253b02997",
								true,
							},
							
							{
								"25e5739f-f438-dd61-944b-20250643afcf",
								true,
							},
							
							{
								"672f3da6-51ef-e005-b811-e6133b9b441e",
								true,
							},
							
							{
								"daf91ffb-3600-e872-8c44-01d0c348eacd",
								true,
							},
							
							{
								"85a6f8bf-bed1-0529-9e9f-1d50e327aa75",
								true,
							},
						},
						filterTargetType = "Enemy",
						matchAnyBuff = true,
						name = "F - Or Gate",
						uuid = "5ebee4ab-f12c-3cc2-8c4e-9965930a9b54",
						version = 3,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - MR",
						partyTargetContentID = 13641,
						uuid = "07ba113f-6106-6c31-b329-dee253b02997",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - TT",
						partyTargetContentID = 13642,
						uuid = "672f3da6-51ef-e005-b811-e6133b9b441e",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - GK",
						partyTargetContentID = 13643,
						uuid = "25e5739f-f438-dd61-944b-20250643afcf",
						version = 3,
					},
					inheritedIndex = 9,
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - EV",
						partyTargetContentID = 13644,
						uuid = "daf91ffb-3600-e872-8c44-01d0c348eacd",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - HM",
						partyTargetContentID = 13642,
						uuid = "85a6f8bf-bed1-0529-9e9f-1d50e327aa75",
						version = 3,
					},
				},
			},
			name = "ARK ANGELS FIREWALL",
			uuid = "5024e249-760e-bd58-9b5b-41c16e15b7a5",
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
						aType = "Misc",
						conditions = 
						{
							
							{
								"c6509ae2-ca27-74a3-aa59-6aac8b54c3ab",
								true,
							},
							
							{
								"6ef97ea4-39dd-09ec-a122-de5248fb57d3",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Target GK",
						setTarget = true,
						targetContentID = 13641,
						targetType = "ContentID",
						uuid = "5e0a11d7-af79-018e-b008-4b7cd6edc041",
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
								"943d6e8a-af5c-22a3-8a22-b8e772272518",
								true,
							},
							
							{
								"6ef97ea4-39dd-09ec-a122-de5248fb57d3",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Target TT",
						setTarget = true,
						targetContentID = 13642,
						targetType = "ContentID",
						uuid = "b64dad61-7eab-d68d-a3dd-f221f12f2272",
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
								"23908f75-224e-3f73-9e6b-408cf746d03a",
								true,
							},
							
							{
								"6ef97ea4-39dd-09ec-a122-de5248fb57d3",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuSCH3_CD",
						name = "Target MR",
						setTarget = true,
						targetContentID = 13643,
						targetType = "ContentID",
						uuid = "65f9204f-4ce1-277a-9ec8-cad1bb038e76",
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
						localmapid = 1248,
						name = "M - In First Walk",
						uuid = "6ef97ea4-39dd-09ec-a122-de5248fb57d3",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						comparator = 3,
						eventArgOptionType = 2,
						eventArgType = 7,
						eventEntityID = 1073746227,
						eventIntValue = 1073746227,
						eventTargetContentID = 13643,
						eventTargetID = 1073746227,
						name = "E - Tether to MR",
						uuid = "23908f75-224e-3f73-9e6b-408cf746d03a",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						comparator = 3,
						eventArgOptionType = 2,
						eventArgType = 7,
						eventEntityID = 1073746227,
						eventIntValue = 1073746227,
						eventTargetContentID = 13641,
						eventTargetID = 1073746227,
						name = "E - Tether to GK",
						uuid = "c6509ae2-ca27-74a3-aa59-6aac8b54c3ab",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						comparator = 3,
						eventArgOptionType = 2,
						eventArgType = 7,
						eventEntityID = 1073746227,
						eventIntValue = 1073746227,
						eventTargetContentID = 13642,
						eventTargetID = 1073746227,
						name = "E - Tether to TT",
						uuid = "943d6e8a-af5c-22a3-8a22-b8e772272518",
						version = 3,
					},
					inheritedIndex = 3,
				},
			},
			eventType = 15,
			name = "ARK ANGEL TETHER",
			uuid = "25ac0f54-3264-9837-b46d-98f442b9e6cb",
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
						actionID = 7548,
						conditions = 
						{
							
							{
								"bcc65174-e4aa-a21a-a7b0-9828556a3592",
								true,
							},
							
							{
								"d67c209d-0377-15dc-89a2-804a501419f9",
								true,
							},
							
							{
								"bc183b0b-c2d7-1797-8985-334e0af0b115",
								true,
							},
							
							{
								"6b67216a-cbe4-2c0c-9673-3bb9f5795a61",
								true,
							},
						},
						gVar = "ACR_RikuSCH3_CD",
						uuid = "adf163ff-a424-9665-a269-126bf51d466f",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						actionID = 7559,
						conditions = 
						{
							
							{
								"bcc65174-e4aa-a21a-a7b0-9828556a3592",
								true,
							},
							
							{
								"d67c209d-0377-15dc-89a2-804a501419f9",
								true,
							},
							
							{
								"bc183b0b-c2d7-1797-8985-334e0af0b115",
								true,
							},
							
							{
								"6b67216a-cbe4-2c0c-9673-3bb9f5795a61",
								true,
							},
						},
						gVar = "ACR_RikuSCH3_CD",
						uuid = "0a6213d9-53b7-4b3a-97cb-fdc3402b0e63",
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
						localmapid = 1248,
						name = "M - In First Walk",
						uuid = "6b67216a-cbe4-2c0c-9673-3bb9f5795a61",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 2,
						eventEntityContentID = 13643,
						name = "E - MR is caster",
						uuid = "bcc65174-e4aa-a21a-a7b0-9828556a3592",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 41068,
						name = "E - Spiral Finish",
						uuid = "d67c209d-0377-15dc-89a2-804a501419f9",
						version = 3,
					},
				},
				
				{
					data = 
					{
						channelCheckTimeRemain = 6,
						channelCheckType = 3,
						comparator = 2,
						conditionType = 7,
						name = "T - Time remaining",
						uuid = "bc183b0b-c2d7-1797-8985-334e0af0b115",
						version = 3,
					},
				},
			},
			eventType = 3,
			name = "MR FINISH",
			uuid = "f7e58a5e-5c2c-1c90-b3c7-a1fc69ca4468",
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
						aType = "Misc",
						conditions = 
						{
							
							{
								"cd3760cc-8a17-9ba3-b1f4-50750e3a840d",
								true,
							},
							
							{
								"68cb8933-3385-d655-acbc-f1f21b7117cf",
								true,
							},
						},
						gVar = "ACR_RikuSCH3_CD",
						name = "Target shield",
						setTarget = true,
						targetContentID = 13719,
						targetType = "ContentID",
						uuid = "6c9b3d79-cd65-a857-8751-30ec0d47b04d",
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
						localmapid = 1248,
						name = "M - In First Walk",
						uuid = "68cb8933-3385-d655-acbc-f1f21b7117cf",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 2,
						eventEntityContentID = 13719,
						name = "E - Ark Shield",
						uuid = "cd3760cc-8a17-9ba3-b1f4-50750e3a840d",
						version = 3,
					},
				},
			},
			eventType = 26,
			name = "ARK SHIELD",
			uuid = "3e870e1a-97bd-2b10-93c4-6f333931488b",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl