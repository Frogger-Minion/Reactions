local tbl =
{
	[2] =
	{

		{
			data =
			{
				displayPath = "",
				name = "BLM AutoSim",
				uuid = "7e0e8bac-1e8a-2cdd-8bb1-24ef5316b917",
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
							actionLua = "-- Enuo EX / TensorNuke4. Evidence: Self sorted logs/Unmaking, 29 April 2026.\n-- Main clear: 20260429-2147-1185-10.txt. Other pulls corroborate scripted timings.\n-- Slot 0 follows the current target; inherited reactions select personal adds.\nif data.frogEnuoBlmSim then self.used=true return end\nlocal acr=TensorCore.API.TensorACR\nlocal s={stage=\"p1\",p1Shift=0,actors={},chases={},movementActual={},targetID=0,waves={{seen=0,down=0},{seen=0,down=0}}}\ndata.frogEnuoBlmSim=s\n-- Median boundaries from four pulls reaching final phase; final-phase length from the clear.\ns.times={155.070,175.289,254.586,255.962,265.227,273.516,633.688}\ns.addLife={[14755]=18.805,[14757]=12.242,[14756]=12.875}\ns.castSpecs={\n {50049,9.156,0},{49975,21.719,0},{49973,35.860,0},{50002,77.360,0},\n {49994,107.485,0},{50043,128.094,0},{50010,149.875,0},\n {50029,0.094,6},{49972,20.281,6},{49976,31.078,6},{49973,45.219,6},\n {49987,49.266,6},{49987,60.609,6},{50045,66.641,6},{49976,80.203,6},\n {50047,94.328,6},{49994,110.172,6},{50002,131.531,6},{49972,165.719,6},\n {49973,179.141,6},{49992,183.281,6},{49992,222.875,6},\n {50047,261.359,6},{49972,276.437,6},{49976,287.187,6},\n {49973,301.375,6},{49987,305.453,6},{49987,316.750,6},\n {50043,322.766,6},{49976,335.172,6},{50047,349.359,6}}\n-- Movement is forecast in advance. Chases are added only for the local assignment.\n-- Freezing Up lasts 2s (thaliak.com/extremes/unmaking/), refined by own status duration.\n-- Beam sweep: first through last of ten 50005 hits, with a small movement margin.\ns.moveSpecs={\n -- Short healer-line/partner-stack adjustments; movement allowances end just after resolution.\n {\"healerLine1\",0,27.7,30.9},{\"pairStack1\",0,55.0,57.7},\n {\"healerLine2\",0,65.8,69.0},{\"pairStack2\",0,120.5,123.4},\n {\"meltdownIn1\",0,42.5,44.7},{\"meltdownOut1\",0,47.05,51.1},\n {\"healerLine3\",6,36.9,40.0},{\"holyStack\",6,69.8,72.8},\n {\"healerLine4\",6,85.8,88.8},\n {\"healerLine5\",6,292.5,295.7},{\"healerLine6\",6,340.4,343.6},\n {\"pairStack3\",6,215.5,218.6},{\"pairStack4\",6,255.1,258.1},\n -- Video review + logged orb vulnerability applications: short soak repositioning.\n {\"orb1a\",0,92.0,94.8},{\"orb1b\",0,97.8,100.7},\n {\"orb2a\",6,146.5,149.7},{\"orb2b\",6,154.4,157.5},\n {\"vacuum1\",0,112.5,116.0},\n -- Passage casts resolve in two steps; allow brief positioning, not a continuous hold.\n {\"passage1\",6,53.1,55.6},{\"passage2\",6,64.4,66.9},\n {\"passage3\",6,188.1,190.6},{\"passage4\",6,209.4,211.9},\n {\"passage5\",6,227.7,230.2},{\"passage6\",6,249.0,251.6},\n {\"passage7\",6,309.2,311.7},{\"passage8\",6,320.5,323.0},\n -- Beacon lines: stop forecasting movement as soon as the Beacon actually dies.\n {\"beaconDodge1\",4,5.0,7.7},{\"beaconDodge2\",4,8.0,10.7},\n {\"beaconDodge3\",4,11.0,13.7},\n {\"meltdownIn2\",6,116.5,119.1},{\"meltdownOut2\",6,121.36,125.46},\n {\"beam1\",0,84.15,88.25}, {\"freeze1\",0,134.25,136.35},\n {\"beam2\",6,138.30,142.50}, {\"freeze2\",6,328.95,331.05},\n -- Adds: brief entry, tower approach, and cleave placement for either role assignment.\n -- Placement is a conservative 3.5s allowance, not a claim that all of the cast requires movement.\n {\"addEntry\",2,0,3.0},\n {\"tower1\",2,2.56,5.56}, {\"cleave1\",2,10.609,14.109},\n {\"tower2\",2,30.2,33.2}, {\"cleave2\",2,38.281,41.781}}\nfunction s.anchor(i) if i==0 then return s.p1Shift end return s.times[i] end\nfunction s.merge(rows,kind)\n table.sort(rows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(rows) do\n  if w[2]>w[1] then\n   if first and w[1]<=last then last=math.max(last,w[2])\n   else\n    if first then acr.addAutoSimPhase(kind,first,last) end\n    first,last=w[1],w[2]\n   end\n  end\n end\n if first then acr.addAutoSimPhase(kind,first,last) end\nend\nfunction s.rebuildMovement()\n acr.clearAutoSimPhases(\"CasterDowntime\")\n acr.clearAutoSimPhases(\"GroundFieldMovement\")\n local rows={}\n for _,v in ipairs(s.moveSpecs) do\n  local actual=s.movementActual[v[1]]\n  local a,b\n  if actual then a,b=actual[1],actual[2]\n  else a,b=s.anchor(v[2])+v[3],s.anchor(v[2])+v[4] end\n  if v[2]==4 then b=math.min(b,s.times[5]) end\n  rows[#rows+1]={a,b}\n  -- Freeze requires a short local wiggle; predict being back in the field at its end.\n  -- Beam rotations/chases leave it; no invented return to Ley Lines is scheduled.\n  if v[1]==\"freeze1\"or v[1]==\"freeze2\"then\n   acr.addAutoSimPhase(\"GroundFieldMovement\",a,b,2)\n  end\n end\n for _,v in pairs(s.chases) do rows[#rows+1]={v[1],v[2]} end\n s.merge(rows,\"CasterDowntime\")\nend\n-- Tethers restrict each individual actor, not every entity sharing its content ID.\nfunction s.canHit(id,player)\n local a=s.actors[id]\n if not a or not a.owner then return false end\n if a.owner==player.id then return true end\n if a.released then return true end\n local owner=TensorCore.mGetEntity(a.owner)\n if owner and not owner.alive then a.released=true return true end\n return false\nend\nfunction s.waveComplete(wave,now)\n local w=s.waves[wave]\n if w.cleared then return end\n w.cleared=now\n if wave==1 then\n  -- Four pulls: next Empty Shadow starts 1.156-1.172s after the fourth add dies.\n  s.movementActual.tower2={now+1.656,now+4.656}\n  s.movementActual.cleave2={now+9.703,now+13.203}\n  s.rebuildMovement()\n else\n  -- Central-add cleanup is damage-dependent; refined again by its actual death.\n  s.shift(3,now+18.531)\n end\nend\nfunction s.deferSecondWave(now)\n local w=s.waves[1]\n if s.towerWave~=1 or w.seen<4 or w.cleared then return end\n if s.nextWaveForecast and now<s.nextWaveForecast then return end\n local v=s.movementActual.tower2\n local predicted=v and v[1]or s.times[2]+30.2\n if predicted<now+1.656 then\n  s.nextWaveForecast=now+1\n  s.movementActual.tower2={now+1.656,now+4.656}\n  s.movementActual.cleave2={now+9.703,now+13.203}\n  s.rebuildMovement()\n end\nend\nfunction s.rebuildDots()\n for group=0,1 do acr.clearAutoSimPhases(\"DotAvailability\",0,group) end\n acr.clearAutoSimPhases(\"TargetLifetime\",0)\n local rows={{0,s.times[1]},{s.times[2],s.times[3]},\n  {s.times[4],s.times[5]},{s.times[6],s.times[7]}}\n local a=s.addTarget\n if s.stage==\"adds\" and a then\n  rows[2]={a.born,math.min(a.finish,s.times[3])}\n end\n for _,w in ipairs(rows) do\n  if w[2]>w[1] then\n   acr.addAutoSimPhase(\"TargetLifetime\",w[1],w[2],1,0)\n   for group=0,1 do acr.addAutoSimPhase(\"DotAvailability\",w[1],w[2],1,0,group) end\n  end\n end\nend\nfunction s.rebuildBuffs()\n acr.clearAutoSimPhases(\"RaidBuff\")\n -- Fixed 20-second windows, 1.3 throughout. No live buff observations or composition multiplier.\n -- Forecast burst 5s into pull/return, with at least 120s between starts.\n local starts={5+s.p1Shift,125+s.p1Shift,s.times[6]+5,s.times[6]+125,s.times[6]+245}\n local last=-120\n for _,v in ipairs(starts) do\n  local a=math.max(v,last+120)\n  local b=math.min(a+20,s.times[7])\n  if b>a then acr.addAutoSimPhase(\"RaidBuff\",a,b,1.3) end\n  last=a\n end\nend\nfunction s.rebuild()\n acr.setAutoSimKillTime(s.times[7])\n acr.clearAutoSimUncertainty()\n acr.addAutoSimUncertainty(145,15)\n if s.stage==\"final\"then\n  acr.addAutoSimUncertainty(s.times[6],0.5)\n  acr.addAutoSimUncertainty(s.times[7]-20,5)\n end\n acr.clearAutoSimPhases(\"FullDowntime\")\n acr.addAutoSimPhase(\"FullDowntime\",s.times[1],s.times[2])\n acr.addAutoSimPhase(\"FullDowntime\",s.times[3],s.times[4])\n acr.addAutoSimPhase(\"FullDowntime\",s.times[5],s.times[6])\n -- A brief orb-phase boss reposition observed in the clear, not the whole orb mechanic.\n local a=s.microDown or s.times[6]+151.766\n local b=s.microUp or s.times[6]+152.187\n if b>a then acr.addAutoSimPhase(\"FullDowntime\",a,b) end\n s.rebuildDots();s.rebuildMovement();s.rebuildBuffs()\nend\nfunction s.shift(index,now)\n local delta=now-s.times[index]\n for i=index,7 do s.times[i]=s.times[i]+delta end\n s.rebuild()\nend\nacr.clearAutoSimPhases(\"Stun\")\nacr.clearAutoSimPhases(\"BossModifier\")\nacr.clearAutoSimPhases(\"TargetCircle5YdRange25Yd\")\nacr.clearAutoSimPhases(\"TargetCircle8YdRange25Yd\")\n-- Adds remain one target until actual cleave evidence supports a larger count.\n-- Keep the user's saved unexpected movement percentage rather than forcing zero.\ns.rebuild()\nself.used=true\n",
							conditions =
							{

								{
									"5e4c818f-5e9a-c958-bdf4-68303fac944a",
									true,
								},

								{
									"f17cca2f-57b0-11d2-8974-a8edbde8c69b",
									true,
								},
							},
							name = "Initialize Enuo BLM",
							uuid = "a22bab33-1514-ce1c-b79d-9634b4555d7a",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "5e4c818f-5e9a-c958-bdf4-68303fac944a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "f17cca2f-57b0-11d2-8974-a8edbde8c69b",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				eventType = 16,
				mechanicTime = 14.2,
				name = "[AutoSim] Initialize Enuo BLM",
				timeRange = true,
				timelineIndex = 2,
				timerStartOffset = -60,
				uuid = "0ba2d4ed-1933-229d-ba98-caf3a9df60df",
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
							actionLua = "-- Enuo EX / TensorNuke4. Evidence: Self sorted logs/Unmaking, 29 April 2026.\n-- Main clear: 20260429-2147-1185-10.txt. Other pulls corroborate scripted timings.\n-- Slot 0 follows the current target; inherited reactions select personal adds.\nif data.frogEnuoBlmSim then self.used=true return end\nlocal acr=TensorCore.API.TensorACR\nlocal s={stage=\"p1\",p1Shift=0,actors={},chases={},movementActual={},targetID=0,waves={{seen=0,down=0},{seen=0,down=0}}}\ndata.frogEnuoBlmSim=s\n-- Median boundaries from four pulls reaching final phase; final-phase length from the clear.\ns.times={155.070,175.289,254.586,255.962,265.227,273.516,633.688}\ns.addLife={[14755]=18.805,[14757]=12.242,[14756]=12.875}\ns.castSpecs={\n {50049,9.156,0},{49975,21.719,0},{49973,35.860,0},{50002,77.360,0},\n {49994,107.485,0},{50043,128.094,0},{50010,149.875,0},\n {50029,0.094,6},{49972,20.281,6},{49976,31.078,6},{49973,45.219,6},\n {49987,49.266,6},{49987,60.609,6},{50045,66.641,6},{49976,80.203,6},\n {50047,94.328,6},{49994,110.172,6},{50002,131.531,6},{49972,165.719,6},\n {49973,179.141,6},{49992,183.281,6},{49992,222.875,6},\n {50047,261.359,6},{49972,276.437,6},{49976,287.187,6},\n {49973,301.375,6},{49987,305.453,6},{49987,316.750,6},\n {50043,322.766,6},{49976,335.172,6},{50047,349.359,6}}\n-- Movement is forecast in advance. Chases are added only for the local assignment.\n-- Freezing Up lasts 2s (thaliak.com/extremes/unmaking/), refined by own status duration.\n-- Beam sweep: first through last of ten 50005 hits, with a small movement margin.\ns.moveSpecs={\n -- Short healer-line/partner-stack adjustments; movement allowances end just after resolution.\n {\"healerLine1\",0,27.7,30.9},{\"pairStack1\",0,55.0,57.7},\n {\"healerLine2\",0,65.8,69.0},{\"pairStack2\",0,120.5,123.4},\n {\"meltdownIn1\",0,42.5,44.7},{\"meltdownOut1\",0,47.05,51.1},\n {\"healerLine3\",6,36.9,40.0},{\"holyStack\",6,69.8,72.8},\n {\"healerLine4\",6,85.8,88.8},\n {\"healerLine5\",6,292.5,295.7},{\"healerLine6\",6,340.4,343.6},\n {\"pairStack3\",6,215.5,218.6},{\"pairStack4\",6,255.1,258.1},\n -- Video review + logged orb vulnerability applications: short soak repositioning.\n {\"orb1a\",0,92.0,94.8},{\"orb1b\",0,97.8,100.7},\n {\"orb2a\",6,146.5,149.7},{\"orb2b\",6,154.4,157.5},\n {\"vacuum1\",0,112.5,116.0},\n -- Passage casts resolve in two steps; allow brief positioning, not a continuous hold.\n {\"passage1\",6,53.1,55.6},{\"passage2\",6,64.4,66.9},\n {\"passage3\",6,188.1,190.6},{\"passage4\",6,209.4,211.9},\n {\"passage5\",6,227.7,230.2},{\"passage6\",6,249.0,251.6},\n {\"passage7\",6,309.2,311.7},{\"passage8\",6,320.5,323.0},\n -- Beacon lines: stop forecasting movement as soon as the Beacon actually dies.\n {\"beaconDodge1\",4,5.0,7.7},{\"beaconDodge2\",4,8.0,10.7},\n {\"beaconDodge3\",4,11.0,13.7},\n {\"meltdownIn2\",6,116.5,119.1},{\"meltdownOut2\",6,121.36,125.46},\n {\"beam1\",0,84.15,88.25}, {\"freeze1\",0,134.25,136.35},\n {\"beam2\",6,138.30,142.50}, {\"freeze2\",6,328.95,331.05},\n -- Adds: brief entry, tower approach, and cleave placement for either role assignment.\n -- Placement is a conservative 3.5s allowance, not a claim that all of the cast requires movement.\n {\"addEntry\",2,0,3.0},\n {\"tower1\",2,2.56,5.56}, {\"cleave1\",2,10.609,14.109},\n {\"tower2\",2,30.2,33.2}, {\"cleave2\",2,38.281,41.781}}\nfunction s.anchor(i) if i==0 then return s.p1Shift end return s.times[i] end\nfunction s.merge(rows,kind)\n table.sort(rows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(rows) do\n  if w[2]>w[1] then\n   if first and w[1]<=last then last=math.max(last,w[2])\n   else\n    if first then acr.addAutoSimPhase(kind,first,last) end\n    first,last=w[1],w[2]\n   end\n  end\n end\n if first then acr.addAutoSimPhase(kind,first,last) end\nend\nfunction s.rebuildMovement()\n acr.clearAutoSimPhases(\"CasterDowntime\")\n acr.clearAutoSimPhases(\"GroundFieldMovement\")\n local rows={}\n for _,v in ipairs(s.moveSpecs) do\n  local actual=s.movementActual[v[1]]\n  local a,b\n  if actual then a,b=actual[1],actual[2]\n  else a,b=s.anchor(v[2])+v[3],s.anchor(v[2])+v[4] end\n  if v[2]==4 then b=math.min(b,s.times[5]) end\n  rows[#rows+1]={a,b}\n  -- Freeze requires a short local wiggle; predict being back in the field at its end.\n  -- Beam rotations/chases leave it; no invented return to Ley Lines is scheduled.\n  if v[1]==\"freeze1\"or v[1]==\"freeze2\"then\n   acr.addAutoSimPhase(\"GroundFieldMovement\",a,b,2)\n  end\n end\n for _,v in pairs(s.chases) do rows[#rows+1]={v[1],v[2]} end\n s.merge(rows,\"CasterDowntime\")\nend\n-- Tethers restrict each individual actor, not every entity sharing its content ID.\nfunction s.canHit(id,player)\n local a=s.actors[id]\n if not a or not a.owner then return false end\n if a.owner==player.id then return true end\n if a.released then return true end\n local owner=TensorCore.mGetEntity(a.owner)\n if owner and not owner.alive then a.released=true return true end\n return false\nend\nfunction s.waveComplete(wave,now)\n local w=s.waves[wave]\n if w.cleared then return end\n w.cleared=now\n if wave==1 then\n  -- Four pulls: next Empty Shadow starts 1.156-1.172s after the fourth add dies.\n  s.movementActual.tower2={now+1.656,now+4.656}\n  s.movementActual.cleave2={now+9.703,now+13.203}\n  s.rebuildMovement()\n else\n  -- Central-add cleanup is damage-dependent; refined again by its actual death.\n  s.shift(3,now+18.531)\n end\nend\nfunction s.deferSecondWave(now)\n local w=s.waves[1]\n if s.towerWave~=1 or w.seen<4 or w.cleared then return end\n if s.nextWaveForecast and now<s.nextWaveForecast then return end\n local v=s.movementActual.tower2\n local predicted=v and v[1]or s.times[2]+30.2\n if predicted<now+1.656 then\n  s.nextWaveForecast=now+1\n  s.movementActual.tower2={now+1.656,now+4.656}\n  s.movementActual.cleave2={now+9.703,now+13.203}\n  s.rebuildMovement()\n end\nend\nfunction s.rebuildDots()\n for group=0,1 do acr.clearAutoSimPhases(\"DotAvailability\",0,group) end\n acr.clearAutoSimPhases(\"TargetLifetime\",0)\n local rows={{0,s.times[1]},{s.times[2],s.times[3]},\n  {s.times[4],s.times[5]},{s.times[6],s.times[7]}}\n local a=s.addTarget\n if s.stage==\"adds\" and a then\n  rows[2]={a.born,math.min(a.finish,s.times[3])}\n end\n for _,w in ipairs(rows) do\n  if w[2]>w[1] then\n   acr.addAutoSimPhase(\"TargetLifetime\",w[1],w[2],1,0)\n   for group=0,1 do acr.addAutoSimPhase(\"DotAvailability\",w[1],w[2],1,0,group) end\n  end\n end\nend\nfunction s.rebuildBuffs()\n acr.clearAutoSimPhases(\"RaidBuff\")\n -- Fixed 20-second windows, 1.3 throughout. No live buff observations or composition multiplier.\n -- Forecast burst 5s into pull/return, with at least 120s between starts.\n local starts={5+s.p1Shift,125+s.p1Shift,s.times[6]+5,s.times[6]+125,s.times[6]+245}\n local last=-120\n for _,v in ipairs(starts) do\n  local a=math.max(v,last+120)\n  local b=math.min(a+20,s.times[7])\n  if b>a then acr.addAutoSimPhase(\"RaidBuff\",a,b,1.3) end\n  last=a\n end\nend\nfunction s.rebuild()\n acr.setAutoSimKillTime(s.times[7])\n acr.clearAutoSimUncertainty()\n acr.addAutoSimUncertainty(145,15)\n if s.stage==\"final\"then\n  acr.addAutoSimUncertainty(s.times[6],0.5)\n  acr.addAutoSimUncertainty(s.times[7]-20,5)\n end\n acr.clearAutoSimPhases(\"FullDowntime\")\n acr.addAutoSimPhase(\"FullDowntime\",s.times[1],s.times[2])\n acr.addAutoSimPhase(\"FullDowntime\",s.times[3],s.times[4])\n acr.addAutoSimPhase(\"FullDowntime\",s.times[5],s.times[6])\n -- A brief orb-phase boss reposition observed in the clear, not the whole orb mechanic.\n local a=s.microDown or s.times[6]+151.766\n local b=s.microUp or s.times[6]+152.187\n if b>a then acr.addAutoSimPhase(\"FullDowntime\",a,b) end\n s.rebuildDots();s.rebuildMovement();s.rebuildBuffs()\nend\nfunction s.shift(index,now)\n local delta=now-s.times[index]\n for i=index,7 do s.times[i]=s.times[i]+delta end\n s.rebuild()\nend\nacr.clearAutoSimPhases(\"Stun\")\nacr.clearAutoSimPhases(\"BossModifier\")\nacr.clearAutoSimPhases(\"TargetCircle5YdRange25Yd\")\nacr.clearAutoSimPhases(\"TargetCircle8YdRange25Yd\")\n-- Adds remain one target until actual cleave evidence supports a larger count.\n-- Keep the user's saved unexpected movement percentage rather than forcing zero.\ns.rebuild()\nself.used=true\n",
							conditions =
							{

								{
									"16102f9b-6f33-cec3-859f-d40689846b2f",
									true,
								},

								{
									"45d3929a-d4aa-4c97-b8de-8529e6b1164b",
									true,
								},

								{
									"fcc1e487-cc47-08f1-8356-a5a5e3b105db",
									true,
								},

								{
									"8ab24099-c466-6580-baef-faf626c3587f",
									true,
								},
							},
							name = "Initialize without countdown",
							uuid = "fb05df05-ed46-9c16-bcdf-a81787f37e1b",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "16102f9b-6f33-cec3-859f-d40689846b2f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "45d3929a-d4aa-4c97-b8de-8529e6b1164b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "fcc1e487-cc47-08f1-8356-a5a5e3b105db",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frogEnuoBlmSim == nil",
							name = "Not initialized",
							uuid = "8ab24099-c466-6580-baef-faf626c3587f",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				mechanicTime = 14.2,
				name = "[AutoSim] Initialize without countdown",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = -4.2,
				timerStartOffset = -14.2,
				uuid = "97118e9f-cfda-c9a2-9bdd-3738669825ab",
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
							actionLua = "local s=data.frogEnuoBlmSim\nif not s then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal cid=eventArgs.entityContentID\nlocal id=eventArgs.entityID\nlocal up=eventArgs.isTargetable\nif s.addLife[cid] then\n local a=s.actors[id]\n if up then\n  if not a then a={};s.actors[id]=a end\n  if not a.up then\n   a.born=now;a.finish=now+s.addLife[cid];a.up=true\n   a.wave=math.min(s.towerWave or 1,2)\n   s.waves[a.wave].seen=s.waves[a.wave].seen+1\n  end\n elseif a and a.up then\n  a.up=false;a.finish=now\n  local w=s.waves[a.wave];w.down=w.down+1\n  if w.seen>=4 and w.down>=4 then s.waveComplete(a.wave,now) end\n  if s.addTarget==a then s.rebuildDots() end\n end\nelseif cid==14749 then\n if not up and s.stage==\"p1\" and now>120 then\n  s.stage=\"waitAdds\";s.shift(1,now)\n elseif up and s.stage~=\"p1\"and s.stage~=\"final\"then\n  s.stage=\"final\";s.addTarget=nil;s.shift(6,now)\n elseif s.stage==\"final\" and now-s.times[6]>140 and now-s.times[6]<170 then\n  if up then s.microUp=now else s.microDown=now;s.microUp=now+0.421 end\n  s.rebuild()\n end\nelseif cid==14752 then\n if up and (s.stage==\"waitAdds\"or s.stage==\"adds\")then\n  s.stage=\"adds\";s.loomingID=id;s.shift(2,now)\n elseif not up and s.stage==\"adds\"and id==s.loomingID then\n  s.stage=\"waitBeacon\";s.addTarget=nil;s.shift(3,now)\n end\nelseif cid==14754 then\n if up then s.stage=\"beacon\";s.addTarget=nil;s.shift(4,now)\n elseif s.stage==\"beacon\"then s.stage=\"waitBoss\";s.shift(5,now) end\nend\nself.used=true\n",
							conditions =
							{

								{
									"67b44ca7-19ec-41c5-81ed-4826eac4eba9",
									true,
								},

								{
									"b0f47999-0ba9-d260-8fc4-29ad9276cc77",
									true,
								},
							},
							name = "Sync Enuo targetability",
							uuid = "d9611467-8147-b423-bfcb-a62cb357b391",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "67b44ca7-19ec-41c5-81ed-4826eac4eba9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "b0f47999-0ba9-d260-8fc4-29ad9276cc77",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				eventType = 26,
				mechanicTime = 14.2,
				name = "[AutoSim] Sync Enuo targetability",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.8,
				timerStartOffset = -14.2,
				uuid = "fb0d871b-27b7-b38d-b0d1-0b9b12877de3",
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
							actionLua = "local s=data.frogEnuoBlmSim\nif not s then self.used=true return end\n-- Four simultaneous Empty Shadow casts describe one tower wave.\nif s.stage==\"adds\"and eventArgs.entityContentID==14752 and eventArgs.spellID==50013 then\n local now=TensorCore.API.TensorACR.getAutoSimTime()\n if not s.lastTowerCast or now-s.lastTowerCast>3 then\n  s.lastTowerCast=now;s.towerWave=(s.towerWave or 0)+1\n  local key=s.towerWave==1 and \"tower1\"or \"tower2\"\n  s.movementActual[key]={now+0.5,now+3.5}\n  s.rebuildMovement()\n end\n self.used=true return\nend\nif eventArgs.entityContentID~=14749 then self.used=true return end\nlocal acr=TensorCore.API.TensorACR\nlocal now=acr.getAutoSimTime()\nlocal spell=eventArgs.spellID\nlocal best,dist\nfor _,v in ipairs(s.castSpecs)do\n if v[1]==spell and ((s.stage==\"p1\"and v[3]==0)or(s.stage==\"final\"and v[3]==6))then\n  local d=math.abs(now-(s.anchor(v[3])+v[2]))\n  if d<8 and (not dist or d<dist)then best,dist=v,d end\n end\nend\nif best then\n local delta=now-(s.anchor(best[3])+best[2])\n if best[3]==0 then\n  s.p1Shift=s.p1Shift+delta\n  for i=1,7 do s.times[i]=s.times[i]+delta end\n else\n  s.times[6]=s.times[6]+delta;s.times[7]=s.times[7]+delta\n end\n s.rebuild()\nend\nself.used=true\n",
							conditions =
							{

								{
									"82e154a1-aa9e-93ee-b3e0-f83fb259524c",
									true,
								},

								{
									"596c2e5e-bd7d-5195-950b-7b3a5b77e716",
									true,
								},
							},
							name = "Sync casts and towers",
							uuid = "d5fbc9aa-2c22-29e4-8882-cab4955f5f36",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "82e154a1-aa9e-93ee-b3e0-f83fb259524c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "596c2e5e-bd7d-5195-950b-7b3a5b77e716",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				eventType = 3,
				mechanicTime = 14.2,
				name = "[AutoSim] Sync casts and towers",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.79998779297,
				timerStartOffset = -14.199999809265,
				uuid = "29eb338e-00e0-ed13-be7f-27dc38743384",
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
							actionLua = "local s=data.frogEnuoBlmSim\nlocal player=TensorCore.mGetPlayer()\nif not s or not player or eventArgs.entityID~=player.id then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal duration=eventArgs.buffDuration\nif duration>0 and eventArgs.buffID==3523 then\n local key=s.stage==\"final\"and \"freeze2\"or \"freeze1\"\n s.movementActual[key]={now,now+duration};s.rebuildMovement()\nelseif duration>0 and eventArgs.buffID==4562 then\n -- Chains prohibits movement, not casting. Forecast the dodge only after it expires.\n local key=s.stage==\"final\"and \"meltdownOut2\"or \"meltdownOut1\"\n s.movementActual[key]={now+duration+0.05,now+math.max(duration+0.25,6.2)}\n s.rebuildMovement()\nend\nself.used=true\n",
							conditions =
							{

								{
									"347c29ca-0df5-8300-ad16-b0d419edf2c5",
									true,
								},

								{
									"8f13608d-9556-0924-ad14-e20a769c63bb",
									true,
								},
							},
							name = "Own Freezing Up movement",
							uuid = "644c32bf-555d-37db-9376-30198b603c4f",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "347c29ca-0df5-8300-ad16-b0d419edf2c5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "8f13608d-9556-0924-ad14-e20a769c63bb",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				eventType = 8,
				mechanicTime = 14.2,
				name = "[AutoSim] Own freeze and Meltdown movement",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.8,
				timerStartOffset = -14.2,
				uuid = "3ea07e9b-32e3-56a4-bcb6-3e07103ceecb",
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
							actionLua = "local s=data.frogEnuoBlmSim\nlocal player=TensorCore.mGetPlayer()\nif not s or not player then self.used=true return end\nif s.stage==\"adds\"and eventArgs.newTetherID==284 and s.addLife[eventArgs.sourceEntityContentID] then\n local id=eventArgs.sourceEntityID\n local a=s.actors[id]\n if not a then a={};s.actors[id]=a end\n a.owner=eventArgs.newTargetID\nend\nif s.stage==\"adds\"and eventArgs.newTetherID==284 and eventArgs.newTargetID==player.id and s.addLife[eventArgs.sourceEntityContentID] then\n local now=TensorCore.API.TensorACR.getAutoSimTime()\n local key=(s.towerWave or 1)==1 and \"cleave1\"or \"cleave2\"\n s.movementActual[key]={now,now+3.5}\n s.rebuildMovement()\n self.used=true return\nend\nif s.stage~=\"final\"then self.used=true return end\nlocal e=eventArgs\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal changed=false\n-- First chaser assignment and the later handoff are both Void -> player, tether 404.\nif e.sourceEntityContentID==14751 then\n local key=e.sourceEntityID\n if e.oldTargetID==player.id and e.newTargetID~=player.id and s.chases[key] then\n  s.chases[key][2]=now;changed=true\n end\n if e.newTargetID==player.id and e.newTetherID==404 then\n  local pending=s.chases.pending\n  local a=now\n  if pending and now-pending[1]<10 then a=pending[1];s.chases.pending=nil end\n  -- First assignment has ~15.15s until handoff; second chaser lasts ~8.2s.\n  local duration=e.oldTetherID==0 and 15.3 or 8.3\n  s.chases[key]={a,now+duration};changed=true\n end\nelseif e.newTetherID==405 and e.newTargetID==player.id then\n -- Player -> player tether announces the next target ~5.65s before handoff.\n -- Include the movement out to receive it, then the following chase.\n s.chases.pending={now,now+14.0};changed=true\nend\nif changed then s.rebuildMovement() end\nself.used=true\n",
							conditions =
							{

								{
									"1b5abf47-f7f1-40b3-b611-bd3a03070793",
									true,
								},

								{
									"6d68d392-3816-f28d-8534-0302f6e5d9ac",
									true,
								},
							},
							name = "Own cleave and chase movement",
							uuid = "6e15877e-56a6-8ee0-be72-b01de1c1e9b4",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "1b5abf47-f7f1-40b3-b611-bd3a03070793",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "6d68d392-3816-f28d-8534-0302f6e5d9ac",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				eventType = 15,
				mechanicTime = 14.2,
				name = "[AutoSim] Own cleave and chase movement",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.8,
				timerStartOffset = -14.2,
				uuid = "75fec86b-b995-9255-96e4-93a21236d5a5",
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
							actionLua = "local s=data.frogEnuoBlmSim\nif not s or s.stage~=\"adds\"and s.stage~=\"beacon\"then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nif s.stage==\"beacon\"then\n local beacon=TensorCore.mGetTarget()\n if beacon and beacon.contentid==14754 and beacon.alive and beacon.targetable and s.times[5]<now+1 then s.shift(5,now+3) end\n self.used=true return\nend\ns.deferSecondWave(now)\n-- Remember a release even if the owner is raised before we finish our own add.\nfor _,a in pairs(s.actors)do\n if a.owner and not a.released then\n  local owner=TensorCore.mGetEntity(a.owner)\n  if owner and not owner.alive then a.released=true end\n end\nend\nlocal looming=s.loomingID and TensorCore.mGetEntity(s.loomingID)\nif looming and looming.alive and looming.targetable and s.times[3]<now+2 then s.shift(3,now+4) end\nlocal target=TensorCore.mGetTarget()\nif target and target.id~=s.targetID then\n s.targetID=target.id\n if s.addLife[target.contentid] then\n  local a=s.actors[target.id]\n  if not a or not a.born then\n   local now=TensorCore.API.TensorACR.getAutoSimTime()\n   a={born=now,finish=now+s.addLife[target.contentid]};s.actors[target.id]=a\n  end\n  s.addTarget=a\n else s.addTarget=nil end\n s.rebuildDots()\nelseif target and s.addTarget and target.alive and target.targetable then\n local now=TensorCore.API.TensorACR.getAutoSimTime()\n if s.addTarget.finish<now+1 then\n  -- Do not leave a surviving add permanently outside its estimated lifetime.\n  s.addTarget.finish=now+3;s.rebuildDots()\n end\nend\nself.used=true\n",
							conditions =
							{

								{
									"c96ba2a9-9919-8518-98e8-c332dd7f9809",
									true,
								},

								{
									"49b20fbd-c444-2bf8-a9ba-ff2fce984d83",
									true,
								},

								{
									"8460bf2c-c5a1-1768-8242-7ffc17853238",
									true,
								},
							},
							name = "Personal add Thunder lifetime",
							uuid = "29ab6aa9-3f64-d978-93cf-d4ab066a5b5c",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "c96ba2a9-9919-8518-98e8-c332dd7f9809",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "49b20fbd-c444-2bf8-a9ba-ff2fce984d83",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frogEnuoBlmSim\nreturn s~=nil and (s.stage==\"adds\" or s.stage==\"beacon\")",
							name = "Adds or Beacon",
							uuid = "8460bf2c-c5a1-1768-8242-7ffc17853238",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				mechanicTime = 14.2,
				name = "[AutoSim] Personal add Thunder lifetime",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.8,
				timerStartOffset = -14.2,
				uuid = "a8f850af-33fa-a6f9-bc1f-9e118d1b6bca",
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
									"2b57a4fc-e3f7-53df-8702-7d242087f618",
									true,
								},

								{
									"138f7b67-73bf-2d86-9e80-98c0e83ebcb5",
									true,
								},

								{
									"fbf34fd1-3a3d-fdae-8def-ea17d1066d58",
									true,
								},

								{
									"0503c8f2-eb66-a58d-9845-acd65e7c9df8",
									true,
								},

								{
									"1e9fe421-2e33-7130-b505-2ca0c98e4190",
									true,
								},
							},
							endIfUsed = true,
							name = "Prioritize my add",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "3ca4d22b-396a-2bca-bf19-4d0038e44c10",
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
									"2b57a4fc-e3f7-53df-8702-7d242087f618",
									true,
								},

								{
									"138f7b67-73bf-2d86-9e80-98c0e83ebcb5",
									true,
								},

								{
									"fbf34fd1-3a3d-fdae-8def-ea17d1066d58",
									true,
								},

								{
									"0503c8f2-eb66-a58d-9845-acd65e7c9df8",
									false,
								},

								{
									"adbab8f7-a956-daff-bcd8-2042a617cd24",
									true,
								},

								{
									"1e9fe421-2e33-7130-b505-2ca0c98e4190",
									true,
								},
							},
							endIfUsed = true,
							name = "Help released add",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "7a04e9cc-61e7-b637-9fc2-3f889c782808",
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
									"2b57a4fc-e3f7-53df-8702-7d242087f618",
									true,
								},

								{
									"138f7b67-73bf-2d86-9e80-98c0e83ebcb5",
									true,
								},

								{
									"fbf34fd1-3a3d-fdae-8def-ea17d1066d58",
									true,
								},

								{
									"0503c8f2-eb66-a58d-9845-acd65e7c9df8",
									false,
								},

								{
									"adbab8f7-a956-daff-bcd8-2042a617cd24",
									false,
								},

								{
									"d0e257f9-0f88-a3bf-af67-3781f444aefe",
									true,
								},

								{
									"1e9fe421-2e33-7130-b505-2ca0c98e4190",
									true,
								},
							},
							endIfUsed = true,
							name = "Return to Looming Shadow",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "ec39d201-74c3-fefe-bffa-c58b21237760",
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
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "BLM",
							uuid = "2b57a4fc-e3f7-53df-8702-7d242087f618",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 8,
							localmapid = 1362,
							name = "Enuo EX",
							uuid = "138f7b67-73bf-2d86-9e80-98c0e83ebcb5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frogEnuoBlmSim ~= nil and data.frogEnuoBlmSim.stage == \"adds\"",
							name = "Adds phase",
							uuid = "fbf34fd1-3a3d-fdae-8def-ea17d1066d58",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frogEnuoBlmSim\nlocal e=TensorCore.mGetEntity(eventArgs.detectionTargetID)\nlocal p=TensorCore.mGetPlayer()\nlocal a=e and s.actors[e.id]\nreturn e~=nil and e.alive and e.targetable and p~=nil and p.alive and a~=nil and a.owner==p.id",
							name = "My living add",
							uuid = "f17e42df-27a6-e5a6-9ada-483302f9720c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frogEnuoBlmSim\nlocal e=TensorCore.mGetEntity(eventArgs.detectionTargetID)\nlocal p=TensorCore.mGetPlayer()\nreturn e~=nil and e.alive and e.targetable and p~=nil and p.alive and s.addLife[e.contentid]~=nil and s.canHit(e.id,p)",
							name = "Released living add",
							uuid = "95a113b8-4148-6de8-ac57-9fea44a28a52",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local e=TensorCore.mGetEntity(eventArgs.detectionTargetID)\nlocal p=TensorCore.mGetPlayer()\nreturn e~=nil and e.alive and e.targetable and p~=nil and p.alive",
							name = "Alive and targetable",
							uuid = "f4ce50e3-c2f2-a563-ae42-c01cd4349da4",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t==nil or t.id~=eventArgs.detectionTargetID",
							name = "Different target",
							uuid = "1e9fe421-2e33-7130-b505-2ca0c98e4190",
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
									"f17e42df-27a6-e5a6-9ada-483302f9720c",
									true,
								},
							},
							filterTargetType = "Enemy",
							name = "Nearest my add",
							uuid = "0503c8f2-eb66-a58d-9845-acd65e7c9df8",
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
									"95a113b8-4148-6de8-ac57-9fea44a28a52",
									true,
								},
							},
							filterTargetType = "Enemy",
							name = "Nearest released add",
							uuid = "adbab8f7-a956-daff-bcd8-2042a617cd24",
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
									"f4ce50e3-c2f2-a563-ae42-c01cd4349da4",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Looming Shadow",
							partyTargetContentID = 14752,
							uuid = "d0e257f9-0f88-a3bf-af67-3781f444aefe",
							version = 3,
						},
					},
				},
				displayPath = "BLM AutoSim",
				mechanicTime = 14.2,
				name = "[AutoSim] My add before central target",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 885.8,
				timerStartOffset = -14.2,
				uuid = "c42de837-1a21-7f54-a18b-6a9587cd7dbb",
				version = 2,
			},
		},
	},
	[25] =
	{

		{
			data =
			{
				name = "[Opti] Target Add Shadow",
				uuid = "88f8fcaa-21ea-ec73-8a61-3be765ce4236",
				version = 2,
			},
			inheritedObjectUUID = "f8e75cf9-63d0-e74b-8bfe-2868c3d55b41",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},

		{
			data =
			{
				name = "[Opti] Retarget Looming Shadow",
				uuid = "46b391c5-bb43-71c9-96fb-1d74a36b138c",
				version = 2,
			},
			inheritedObjectUUID = "eeb78cdd-5f3a-afd5-8c96-1b37764d452b",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	inheritedProfiles =
	{
	},
	timelineName = "enuo-ex",
	version = "1.0.1",
}



return tbl
