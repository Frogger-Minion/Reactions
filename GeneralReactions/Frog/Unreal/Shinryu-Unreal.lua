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
			name = "-- Unreals --",
			uuid = "c6866b7a-733d-d356-8990-972ba038b04e",
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
						aType = "Misc",
						conditions = 
						{
							
							{
								"b7d9f8d2-e9fc-82e6-96c4-1492ce99c8f7",
								true,
							},
							
							{
								"fe40f74a-a185-10a7-9c8d-8225f521d937",
								true,
							},
							
							{
								"2d63c287-50db-708c-b2f9-291d63c4d22e",
								true,
							},
							
							{
								"43450aa2-aafa-f438-bf54-95f1ffae3b27",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_TensorMagnum3_CD",
						name = "Melee Tail",
						setTarget = true,
						targetType = "Detection Target",
						uuid = "d68aa4fd-e966-53b5-a902-7ef914834844",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Misc",
						conditions = 
						{
							
							{
								"b7d9f8d2-e9fc-82e6-96c4-1492ce99c8f7",
								true,
							},
							
							{
								"c93751c3-e2d6-04e7-bc97-2e268f77f7ed",
								true,
							},
							
							{
								"a7ffd1d2-bd87-2ad0-b7a5-903820dccb69",
								true,
							},
							
							{
								"43450aa2-aafa-f438-bf54-95f1ffae3b27",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_TensorMagnum3_CD",
						name = "Melee Heart",
						setTarget = true,
						targetType = "Detection Target",
						uuid = "43c72294-e505-713e-8c15-fe50332e4ff5",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Misc",
						conditions = 
						{
							
							{
								"b7d9f8d2-e9fc-82e6-96c4-1492ce99c8f7",
								true,
							},
							
							{
								"c93751c3-e2d6-04e7-bc97-2e268f77f7ed",
								false,
							},
							
							{
								"fe40f74a-a185-10a7-9c8d-8225f521d937",
								false,
							},
							
							{
								"f335628c-c536-104b-837d-edcd3071116a",
								false,
							},
							
							{
								"1d1a8b27-f8e3-80db-b15e-dd97a74d702e",
								true,
							},
							
							{
								"43450aa2-aafa-f438-bf54-95f1ffae3b27",
								true,
							},
						},
						endIfUsed = true,
						gVar = "ACR_TensorMagnum3_CD",
						name = "Melee Shinryu Fallback",
						setTarget = true,
						targetType = "Detection Target",
						uuid = "0cf122c3-9e2f-e899-a1d8-506c4ba5250a",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Misc",
						conditions = 
						{
							
							{
								"b7d9f8d2-e9fc-82e6-96c4-1492ce99c8f7",
								true,
							},
							
							{
								"6231559f-7893-343a-afb2-e6f8e3291819",
								true,
							},
							
							{
								"43450aa2-aafa-f438-bf54-95f1ffae3b27",
								false,
							},
							
							{
								"f335628c-c536-104b-837d-edcd3071116a",
								false,
							},
						},
						endIfUsed = true,
						gVar = "ACR_RikuDRG3_CD",
						name = "Ranged",
						setTarget = true,
						targetType = "Detection Target",
						uuid = "b44036a6-db14-8163-adb6-ddb28026d59b",
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
						localmapid = 1372,
						uuid = "b7d9f8d2-e9fc-82e6-96c4-1492ce99c8f7",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - Tail",
						partyTargetContentID = 5789,
						uuid = "fe40f74a-a185-10a7-9c8d-8225f521d937",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - Heart",
						partyTargetContentID = 6271,
						uuid = "c93751c3-e2d6-04e7-bc97-2e268f77f7ed",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						conditionType = 2,
						filterTargetType = "ContentID",
						name = "F - Shinryu",
						partyTargetContentID = 5640,
						uuid = "1d1a8b27-f8e3-80db-b15e-dd97a74d702e",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - Left Wing",
						partyTargetContentID = 5641,
						uuid = "3ba69176-7120-0c40-aa53-c1d8588f61f6",
						version = 3,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Filter",
						filterTargetType = "ContentID",
						name = "F - Right Wing",
						partyTargetContentID = 5642,
						uuid = "fae4c7c0-5a0a-28d1-a18b-ab33a448cdc9",
						version = 3,
					},
					inheritedIndex = 6,
				},
				
				{
					data = 
					{
						category = "Filter",
						conditions = 
						{
							
							{
								"fe40f74a-a185-10a7-9c8d-8225f521d937",
								true,
							},
							
							{
								"c93751c3-e2d6-04e7-bc97-2e268f77f7ed",
								true,
							},
							
							{
								"1d1a8b27-f8e3-80db-b15e-dd97a74d702e",
								true,
							},
						},
						matchAnyBuff = true,
						name = "F - OR Gate",
						partyTargetNumber = 0,
						uuid = "6231559f-7893-343a-afb2-e6f8e3291819",
						version = 3,
					},
					inheritedIndex = 5,
				},
				
				{
					data = 
					{
						category = "Party",
						comparator = 2,
						conditionType = 4,
						inRangeValue = 25,
						name = "R - Shinryu Range",
						partyTargetType = "Detection Target",
						uuid = "c3ac15fa-e9b3-07bc-8ec1-538dc0f35f46",
						version = 3,
					},
					inheritedIndex = 7,
				},
				
				{
					data = 
					{
						category = "Party",
						comparator = 2,
						conditionType = 4,
						inRangeValue = 32,
						name = "R - Heart Range",
						partyTargetType = "Detection Target",
						uuid = "a7ffd1d2-bd87-2ad0-b7a5-903820dccb69",
						version = 3,
					},
					inheritedIndex = 7,
				},
				
				{
					data = 
					{
						category = "Party",
						comparator = 2,
						conditionType = 4,
						inRangeValue = 18,
						name = "R - Tail Range",
						partyTargetType = "Detection Target",
						uuid = "2d63c287-50db-708c-b2f9-291d63c4d22e",
						version = 3,
					},
					inheritedIndex = 7,
				},
				
				{
					data = 
					{
						category = "Filter",
						conditions = 
						{
							
							{
								"3ba69176-7120-0c40-aa53-c1d8588f61f6",
								true,
							},
							
							{
								"fae4c7c0-5a0a-28d1-a18b-ab33a448cdc9",
								true,
							},
						},
						matchAnyBuff = true,
						name = "F - Wing OR",
						partyTargetNumber = 0,
						uuid = "f335628c-c536-104b-837d-edcd3071116a",
						version = 3,
					},
					inheritedIndex = 11,
				},
				
				{
					data = 
					{
						buffID = 19,
						category = "Self",
						conditionType = 14,
						jobIDList = 
						{
							19,
							20,
							21,
							22,
							30,
							32,
							34,
							37,
							39,
							41,
						},
						name = "Is melee?",
						uuid = "43450aa2-aafa-f438-bf54-95f1ffae3b27",
						version = 3,
					},
					inheritedIndex = 9,
				},
			},
			mechanicTime = 283.095,
			name = "Shinryu Target",
			timelineIndex = 67,
			uuid = "672be9bd-d0bf-cca2-aac9-b06289cc10cc",
			version = 2,
		},
		inheritedIndex = 2,
	},
	
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
								"217ed8f9-6d6d-d200-9e59-ea5bbdc20819",
								true,
							},
							
							{
								"ed3bc3cd-1060-9002-bf69-db0f334c79d5",
								true,
							},
							
							{
								"c801f14c-2655-bdf2-9e27-d57c366eec5f",
								true,
							},
							
							{
								"56dd8ef9-661f-7df1-8ceb-77bfd4305f24",
								true,
							},
						},
						gVar = "ACR_RikuDRK3_Hotbar_ArmsLength",
						name = "Arms Tidal",
						uuid = "09e21802-f4b9-51c3-944b-d402c1220b10",
						variableTogglesType = 2,
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
								"217ed8f9-6d6d-d200-9e59-ea5bbdc20819",
								true,
							},
							
							{
								"ed3bc3cd-1060-9002-bf69-db0f334c79d5",
								true,
							},
							
							{
								"c801f14c-2655-bdf2-9e27-d57c366eec5f",
								true,
							},
							
							{
								"56dd8ef9-661f-7df1-8ceb-77bfd4305f24",
								true,
							},
						},
						gVar = "ACR_RikuRDM3_Hotbar_Surecast",
						name = "SureC Tidal",
						uuid = "24fa914f-3dea-4350-9498-b5c42257c0f2",
						variableTogglesType = 2,
						version = 2.1,
					},
					inheritedIndex = 2,
				},
				
				{
					data = 
					{
						aType = "ACR",
						conditions = 
						{
							
							{
								"217ed8f9-6d6d-d200-9e59-ea5bbdc20819",
								true,
							},
							
							{
								"ed3bc3cd-1060-9002-bf69-db0f334c79d5",
								true,
							},
							
							{
								"9c1a1301-1d97-0861-b6ab-464748ee0f71",
								true,
							},
							
							{
								"56dd8ef9-661f-7df1-8ceb-77bfd4305f24",
								true,
							},
						},
						gVar = "ACR_RikuDRK3_Hotbar_ArmsLength",
						name = "Arms Aerial",
						uuid = "03737871-6271-be66-8b5b-9f116bf3b30a",
						variableTogglesType = 2,
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
								"217ed8f9-6d6d-d200-9e59-ea5bbdc20819",
								true,
							},
							
							{
								"ed3bc3cd-1060-9002-bf69-db0f334c79d5",
								true,
							},
							
							{
								"9c1a1301-1d97-0861-b6ab-464748ee0f71",
								true,
							},
							
							{
								"56dd8ef9-661f-7df1-8ceb-77bfd4305f24",
								true,
							},
						},
						gVar = "ACR_RikuRDM3_Hotbar_Surecast",
						name = "SureC Aerial",
						uuid = "73975039-e26a-a4a8-82b5-31ce5ee85a08",
						variableTogglesType = 2,
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
						localmapid = 1372,
						uuid = "217ed8f9-6d6d-d200-9e59-ea5bbdc20819",
						version = 3,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgOptionType = 2,
						eventEntityContentID = 5640,
						name = "Shinryu",
						uuid = "ed3bc3cd-1060-9002-bf69-db0f334c79d5",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 50261,
						name = "Tidal Wave",
						uuid = "c801f14c-2655-bdf2-9e27-d57c366eec5f",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						eventArgType = 2,
						eventSpellID = 50235,
						name = "Aerial Blast",
						uuid = "9c1a1301-1d97-0861-b6ab-464748ee0f71",
						version = 3,
					},
					inheritedIndex = 4,
				},
				
				{
					data = 
					{
						category = "Party",
						channelCheckTimeRemain = 5.8000001907349,
						channelCheckType = 3,
						comparator = 2,
						conditionType = 5,
						name = "6s or less",
						partyTargetType = "Event Entity",
						uuid = "56dd8ef9-661f-7df1-8ceb-77bfd4305f24",
						version = 3,
					},
				},
			},
			eventType = 3,
			name = "Shinryu KB",
			uuid = "dc82ce96-32dc-707a-aab4-b2ca310ac369",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl