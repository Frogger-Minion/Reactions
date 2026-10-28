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
							actionLua = "local player=TensorCore.mGetPlayer()\nif not player or player.job~=25 or data.dsrBrdAutoSim then return end\nif TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})then return end\nlocal api=TensorCore.API.TensorACR\nlocal now=api.getAutoSimTime();local timer=TensorReactions_CurrentTimer\nif type(now)~=\"number\" or type(timer)~=\"number\" then return end\nlocal offset=now-timer\nlocal s=data.frog_dsr_blm_p1_movement\nif s and now>=s.last and math.abs(offset-s.offset)<1 then s.last=now;self.used=true return end\ndata.frog_dsr_blm_p1_movement={offset=offset,last=now}\napi.clearAutoSimPhases(\"CasterDowntime\")\nlocal windows={\n {35.940,37.870},\n {42.870,44.620},\n {45.010,46.950},\n {57.890,59.930},\n {64.250,66.689},\n {73.363,76.988},\n {86.814,89.646},\n {100.800,103.083},\n {105.810,109.114},\n {222.186,224.508},\n {226.851,229.055},\n {232.437,243.836},\n}\nfor _,w in ipairs(windows)do\n local a,b=math.max(0,offset+w[1]),offset+w[2]\n if b>math.max(a,now)then api.addAutoSimPhase(\"CasterDowntime\",a,b)end\nend\nself.used=true",
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
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "f457556d-a5c4-97c8-b23c-d96164c0f280",
							version = 3,
						},
					},
				},
				loop = true,
				name = "[BLM] P1 movement forecast",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 250,
				timerStartOffset = -60,
				uuid = "6e3cab13-6955-afa0-88a2-058864da3b1b",
				version = 2,
			},
		},
	},
	[38] =
	{

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
							actionLua = "local acr=TensorCore.API.TensorACR\nlocal s={nextBoundary=1,primaryID=nil,secondaryID=nil,phase=\"p2\"}\ndata.dsrBrdAutoSim=s\nlocal function point(t,c,up,phase,slot) return {time=t,cid=c,up=up,phase=phase,slot=slot} end\ns.points={\n point(32.360,3632,false,\"p2\",0),point(63.532,3632,true,\"p2\",0),\n point(100.594,3632,false,\"p2\",0),point(151.516,3632,true,\"p2\",0),point(188.313,3632,false,\"p2\",0),\n point(197.610,3458,true,\"p3\",0),point(309.438,3458,false,\"p3\",0),\n point(326.703,11318,true,\"eyes\",0),point(326.703,11317,true,\"eyes\",1),\n point(385.313,11317,false,\"eyes\",1),point(390.156,11318,false,\"eyes\",0),\n point(410.234,3642,true,\"intermission\",0),point(447.891,3642,false,\"intermission\",0),\n point(447.891,11320,true,\"intermission\",0),point(458.609,11320,false,\"intermission\",0),\n point(473.656,3632,true,\"p5\",0),point(505.719,3632,false,\"p5\",0),\n point(528.750,3632,true,\"p5\",0),point(566.234,3632,false,\"p5\",0),\n point(612.344,3632,true,\"p5\",0),point(643.328,3632,false,\"p5\",0),\n point(653.656,3458,true,\"p6\",0),point(653.656,4954,true,\"p6\",1),\n point(694.531,3458,false,\"p6\",0),point(708.047,3458,true,\"p6\",0),\n point(719.484,4954,false,\"p6\",1),point(735.172,4954,true,\"p6\",1),\n point(797.766,3458,false,\"p6\",0),point(797.766,4954,false,\"p6\",1),\n point(812.313,3458,true,\"p6\",0),point(812.313,4954,true,\"p6\",1),\n point(820.688,4954,false,\"p6\",1),point(822.094,3458,false,\"p6\",0),\n point(874.250,11319,true,\"p7\",0),point(1095.550,11319,false,\"p7\",0),\n}\ns.lifetimes={{0,0,5},{0,6,7},{0,8,11},{1,9,10},{0,12,13},{0,14,15},\n {0,16,21},{0,22,33},{1,23,32},{0,34,35}}\ns.windows={{0,0,1},{0,2,3},{0,4,5},{0,6,7},{0,8,11},{1,9,10},\n {0,12,13},{0,14,15},{0,16,17},{0,18,19},{0,20,21},\n {0,22,24},{0,25,28},{0,30,33},{1,23,26},{1,27,29},{1,31,32},{0,34,35}}\ns.buffStarts={{0,5.157},{0,5.297},{4,-1.437},{4,1.047},{6,77.249},{6,77.812},{12,2.985},{12,5.438},{18,5.031},{18,7.547},{22,3.547},{22,3.703},{22,125.657},{22,127.016},{34,25.063},{34,30.328},{34,145.063},{34,150.328},{34,265.063},{34,270.328}}\nfunction s.at(i) return i==0 and 0 or s.points[i].time end\ns.windows[#s.windows+1]={0,24,24,1.313,10.297}\ns.windows[#s.windows+1]={1,26,26,1.360,10.454}\ns.windows[#s.windows+1]={0,28,28,1.312,7.406}\ns.windows[#s.windows+1]={1,29,29,1.312,7.406}\nfunction s.windowStart(w) return s.at(w[2])+(w[4] or 0) end\nfunction s.windowEnd(w) return s.at(w[3])+(w[5] or 0) end\nfunction s.rebuildPersonalStop()\n acr.clearAutoSimPhases(\"Stun\")\n local a=s.wb2ActualStopAt or s.at(28)+(s.wb2StopOffset or 5.609)\n local b=s.wb2TouchdownAt or math.min(s.at(30),s.at(31))\n if b>a then acr.addAutoSimPhase(\"Stun\",a,b) end\nend\nfunction s.available(slot,now)\n for _,w in ipairs(s.windows) do\n  if w[1]==slot and now>=s.windowStart(w) and now<s.windowEnd(w) then return true end\n end\n return false\nend\nfunction s.rebuildBuffs()\n s.rebuildCasterMovement()\n acr.clearAutoSimPhases(\"RaidBuff\")\n local windows={}\n local kill=s.points[35].time\n for _,v in ipairs(s.buffStarts) do\n  local a=s.at(v[1])+v[2]\n  local b=math.min(a+20,kill)\n  if b>a then windows[#windows+1]={a,b} end\n end\n table.sort(windows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(windows) do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\nend\nfunction s.rebuildAOE()\n acr.clearAutoSimPhases(\"Line25Yd\")\n for _,primary in ipairs(s.windows) do\n  if primary[1]==0 then\n   for _,secondary in ipairs(s.windows) do\n    if secondary[1]==1 then\n     local a=math.max(s.windowStart(primary),s.windowStart(secondary))\n     local b=math.min(s.windowEnd(primary),s.windowEnd(secondary))\n     if b>a then acr.addAutoSimPhase(\"Line25Yd\",a,b,2) end\n    end\n   end\n  end\n end\nend\ns.blmCasterWindows={\n {1,3.622,7.460},\n {1,10.002,18.244},\n {1,18.932,25.300},\n {1,25.983,28.244},\n {3,3.911,9.101},\n {3,16.860,22.342},\n {3,28.848,31.754},\n {3,47.530,51.473},\n {5,0.395,4.723},\n {6,22.015,23.979},\n {6,28.874,31.797},\n {6,37.875,39.845},\n {6,50.288,55.577},\n {6,64.205,68.482},\n {7,0.684,2.598},\n {9,19.626,22.857},\n {9,44.927,48.157},\n {9,48.812,52.633},\n {10,8.105,10.704},\n {12,21.595,23.943},\n {12,26.402,28.417},\n {12,31.562,33.872},\n {17,3.377,6.992},\n {17,16.361,22.858},\n {19,2.319,5.261},\n {19,14.135,17.965},\n {19,18.319,20.880},\n {19,27.894,30.167},\n {20,23.239,25.893},\n {20,30.570,33.896},\n {23,30.356,33.877},\n {24,4.172,9.469},\n {24,11.922,16.094},\n {26,4.414,10.578},\n {26,11.410,28.063},\n {27,31.355,35.750},\n {27,39.768,41.900},\n {27,46.126,50.205},\n {27,51.800,53.981},\n {29,0.126,3.740},\n {29,10.038,12.520},\n {33,3.486,8.855},\n {34,25.920,29.815},\n {34,53.142,55.112},\n {34,59.698,68.782},\n {34,105.286,108.472},\n {34,126.379,131.037},\n {34,132.737,137.643},\n {34,139.302,148.308},\n {34,159.396,162.302},\n {34,184.707,189.293},\n {34,206.992,209.003},\n {34,209.723,212.068},\n}\nfunction s.rebuildCasterMovement()\n local player=TensorCore.mGetPlayer()\n if not player or player.job~=25 then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.blmCasterWindows)do\n  local base=s.at(w[1]);local a,b=math.max(0,base+w[2]),base+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={a,b}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\n\nfunction s.rebuild()\n local kill=s.points[35].time\n acr.setAutoSimKillTime(kill)\n acr.clearAutoSimPhases(\"DotAvailability\",0);acr.clearAutoSimPhases(\"DotAvailability\",1)\n acr.clearAutoSimPhases(\"TargetLifetime\",0);acr.clearAutoSimPhases(\"TargetLifetime\",1)\n acr.clearAutoSimPhases(\"FullDowntime\")\n for _,v in ipairs(s.lifetimes) do\n  local a,b=s.at(v[2]),s.at(v[3])\n  if b>a then acr.addAutoSimPhase(\"TargetLifetime\",a,b,1,v[1]) end\n end\n local union={}\n for _,v in ipairs(s.windows) do\n  local a,b=s.windowStart(v),s.windowEnd(v)\n  if b>a then\n   local dotEnd=b\n   if v[1]==1 and v[2]==9 and s.leftEyeDotStopAt then dotEnd=math.min(dotEnd,s.leftEyeDotStopAt) end\n   if dotEnd>a then acr.addAutoSimPhase(\"DotAvailability\",a,dotEnd,1,v[1]) end\n   union[#union+1]={a,b}\n  end\n end\n table.sort(union,function(a,b)return a[1]<b[1]end)\n local previous=0\n for _,v in ipairs(union) do\n  if v[1]>previous then acr.addAutoSimPhase(\"FullDowntime\",previous,v[1]) end\n  previous=math.max(previous,v[2])\n end\n if previous<kill then acr.addAutoSimPhase(\"FullDowntime\",previous,kill) end\n s.rebuildAOE()\n s.rebuildPersonalStop()\n s.rebuildBuffs()\n acr.clearAutoSimUncertainty()\n local now=acr.getAutoSimTime()\n acr.addAutoSimUncertainty(now,1)\n local nextPoint=s.points[s.nextBoundary]\n if nextPoint and s.nextBoundary<35 and nextPoint.time-12>now then\n  acr.addAutoSimUncertainty(nextPoint.time-12,4)\n end\n if kill-25>now then acr.addAutoSimUncertainty(kill-25,20) end\nend\nfunction s.resync(i,now)\n local delta=now-s.points[i].time\n local first=i\n while first>s.nextBoundary and math.abs(s.points[first-1].time-s.points[i].time)<1 do first=first-1 end\n for n=first,#s.points do s.points[n].time=s.points[n].time+delta end\n s.nextBoundary=i+1;s.phase=s.points[i].phase\n s.rebuild()\nend\nlocal thordan=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})\nif thordan then s.primaryID=thordan.id;acr.setAutoSimTarget(0,thordan.id) end\nacr.clearAutoSimTarget(1)\ns.rebuild()\nself.used=true",
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
							actionLua = "local acr=TensorCore.API.TensorACR\nlocal s={nextBoundary=1,primaryID=nil,secondaryID=nil,phase=\"p2\"}\ndata.dsrBrdAutoSim=s\nlocal function point(t,c,up,phase,slot) return {time=t,cid=c,up=up,phase=phase,slot=slot} end\ns.points={\n point(32.360,3632,false,\"p2\",0),point(63.532,3632,true,\"p2\",0),\n point(100.594,3632,false,\"p2\",0),point(151.516,3632,true,\"p2\",0),point(188.313,3632,false,\"p2\",0),\n point(197.610,3458,true,\"p3\",0),point(309.438,3458,false,\"p3\",0),\n point(326.703,11318,true,\"eyes\",0),point(326.703,11317,true,\"eyes\",1),\n point(385.313,11317,false,\"eyes\",1),point(390.156,11318,false,\"eyes\",0),\n point(410.234,3642,true,\"intermission\",0),point(447.891,3642,false,\"intermission\",0),\n point(447.891,11320,true,\"intermission\",0),point(458.609,11320,false,\"intermission\",0),\n point(473.656,3632,true,\"p5\",0),point(505.719,3632,false,\"p5\",0),\n point(528.750,3632,true,\"p5\",0),point(566.234,3632,false,\"p5\",0),\n point(612.344,3632,true,\"p5\",0),point(643.328,3632,false,\"p5\",0),\n point(653.656,3458,true,\"p6\",0),point(653.656,4954,true,\"p6\",1),\n point(694.531,3458,false,\"p6\",0),point(708.047,3458,true,\"p6\",0),\n point(719.484,4954,false,\"p6\",1),point(735.172,4954,true,\"p6\",1),\n point(797.766,3458,false,\"p6\",0),point(797.766,4954,false,\"p6\",1),\n point(812.313,3458,true,\"p6\",0),point(812.313,4954,true,\"p6\",1),\n point(820.688,4954,false,\"p6\",1),point(822.094,3458,false,\"p6\",0),\n point(874.250,11319,true,\"p7\",0),point(1095.550,11319,false,\"p7\",0),\n}\ns.lifetimes={{0,0,5},{0,6,7},{0,8,11},{1,9,10},{0,12,13},{0,14,15},\n {0,16,21},{0,22,33},{1,23,32},{0,34,35}}\ns.windows={{0,0,1},{0,2,3},{0,4,5},{0,6,7},{0,8,11},{1,9,10},\n {0,12,13},{0,14,15},{0,16,17},{0,18,19},{0,20,21},\n {0,22,24},{0,25,28},{0,30,33},{1,23,26},{1,27,29},{1,31,32},{0,34,35}}\ns.buffStarts={{0,5.157},{0,5.297},{4,-1.437},{4,1.047},{6,77.249},{6,77.812},{12,2.985},{12,5.438},{18,5.031},{18,7.547},{22,3.547},{22,3.703},{22,125.657},{22,127.016},{34,25.063},{34,30.328},{34,145.063},{34,150.328},{34,265.063},{34,270.328}}\nfunction s.at(i) return i==0 and 0 or s.points[i].time end\ns.windows[#s.windows+1]={0,24,24,1.313,10.297}\ns.windows[#s.windows+1]={1,26,26,1.360,10.454}\ns.windows[#s.windows+1]={0,28,28,1.312,7.406}\ns.windows[#s.windows+1]={1,29,29,1.312,7.406}\nfunction s.windowStart(w) return s.at(w[2])+(w[4] or 0) end\nfunction s.windowEnd(w) return s.at(w[3])+(w[5] or 0) end\nfunction s.rebuildPersonalStop()\n acr.clearAutoSimPhases(\"Stun\")\n local a=s.wb2ActualStopAt or s.at(28)+(s.wb2StopOffset or 5.609)\n local b=s.wb2TouchdownAt or math.min(s.at(30),s.at(31))\n if b>a then acr.addAutoSimPhase(\"Stun\",a,b) end\nend\nfunction s.available(slot,now)\n for _,w in ipairs(s.windows) do\n  if w[1]==slot and now>=s.windowStart(w) and now<s.windowEnd(w) then return true end\n end\n return false\nend\nfunction s.rebuildBuffs()\n s.rebuildCasterMovement()\n acr.clearAutoSimPhases(\"RaidBuff\")\n local windows={}\n local kill=s.points[35].time\n for _,v in ipairs(s.buffStarts) do\n  local a=s.at(v[1])+v[2]\n  local b=math.min(a+20,kill)\n  if b>a then windows[#windows+1]={a,b} end\n end\n table.sort(windows,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(windows) do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"RaidBuff\",first,last,1.3) end\nend\nfunction s.rebuildAOE()\n acr.clearAutoSimPhases(\"Line25Yd\")\n for _,primary in ipairs(s.windows) do\n  if primary[1]==0 then\n   for _,secondary in ipairs(s.windows) do\n    if secondary[1]==1 then\n     local a=math.max(s.windowStart(primary),s.windowStart(secondary))\n     local b=math.min(s.windowEnd(primary),s.windowEnd(secondary))\n     if b>a then acr.addAutoSimPhase(\"Line25Yd\",a,b,2) end\n    end\n   end\n  end\n end\nend\ns.blmCasterWindows={\n {1,3.622,7.460},\n {1,10.002,18.244},\n {1,18.932,25.300},\n {1,25.983,28.244},\n {3,3.911,9.101},\n {3,16.860,22.342},\n {3,28.848,31.754},\n {3,47.530,51.473},\n {5,0.395,4.723},\n {6,22.015,23.979},\n {6,28.874,31.797},\n {6,37.875,39.845},\n {6,50.288,55.577},\n {6,64.205,68.482},\n {7,0.684,2.598},\n {9,19.626,22.857},\n {9,44.927,48.157},\n {9,48.812,52.633},\n {10,8.105,10.704},\n {12,21.595,23.943},\n {12,26.402,28.417},\n {12,31.562,33.872},\n {17,3.377,6.992},\n {17,16.361,22.858},\n {19,2.319,5.261},\n {19,14.135,17.965},\n {19,18.319,20.880},\n {19,27.894,30.167},\n {20,23.239,25.893},\n {20,30.570,33.896},\n {23,30.356,33.877},\n {24,4.172,9.469},\n {24,11.922,16.094},\n {26,4.414,10.578},\n {26,11.410,28.063},\n {27,31.355,35.750},\n {27,39.768,41.900},\n {27,46.126,50.205},\n {27,51.800,53.981},\n {29,0.126,3.740},\n {29,10.038,12.520},\n {33,3.486,8.855},\n {34,25.920,29.815},\n {34,53.142,55.112},\n {34,59.698,68.782},\n {34,105.286,108.472},\n {34,126.379,131.037},\n {34,132.737,137.643},\n {34,139.302,148.308},\n {34,159.396,162.302},\n {34,184.707,189.293},\n {34,206.992,209.003},\n {34,209.723,212.068},\n}\nfunction s.rebuildCasterMovement()\n local player=TensorCore.mGetPlayer()\n if not player or player.job~=25 then return end\n acr.clearAutoSimPhases(\"CasterDowntime\")\n local now=acr.getAutoSimTime()\n local spans={}\n for _,w in ipairs(s.blmCasterWindows)do\n  local base=s.at(w[1]);local a,b=math.max(0,base+w[2]),base+w[3]\n  if b>math.max(a,now)then spans[#spans+1]={a,b}end\n end\n table.sort(spans,function(a,b)return a[1]<b[1]end)\n local first,last\n for _,w in ipairs(spans)do\n  if first and w[1]<=last then last=math.max(last,w[2])\n  else\n   if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\n   first,last=w[1],w[2]\n  end\n end\n if first then acr.addAutoSimPhase(\"CasterDowntime\",first,last)end\nend\n\nfunction s.rebuild()\n local kill=s.points[35].time\n acr.setAutoSimKillTime(kill)\n acr.clearAutoSimPhases(\"DotAvailability\",0);acr.clearAutoSimPhases(\"DotAvailability\",1)\n acr.clearAutoSimPhases(\"TargetLifetime\",0);acr.clearAutoSimPhases(\"TargetLifetime\",1)\n acr.clearAutoSimPhases(\"FullDowntime\")\n for _,v in ipairs(s.lifetimes) do\n  local a,b=s.at(v[2]),s.at(v[3])\n  if b>a then acr.addAutoSimPhase(\"TargetLifetime\",a,b,1,v[1]) end\n end\n local union={}\n for _,v in ipairs(s.windows) do\n  local a,b=s.windowStart(v),s.windowEnd(v)\n  if b>a then\n   local dotEnd=b\n   if v[1]==1 and v[2]==9 and s.leftEyeDotStopAt then dotEnd=math.min(dotEnd,s.leftEyeDotStopAt) end\n   if dotEnd>a then acr.addAutoSimPhase(\"DotAvailability\",a,dotEnd,1,v[1]) end\n   union[#union+1]={a,b}\n  end\n end\n table.sort(union,function(a,b)return a[1]<b[1]end)\n local previous=0\n for _,v in ipairs(union) do\n  if v[1]>previous then acr.addAutoSimPhase(\"FullDowntime\",previous,v[1]) end\n  previous=math.max(previous,v[2])\n end\n if previous<kill then acr.addAutoSimPhase(\"FullDowntime\",previous,kill) end\n s.rebuildAOE()\n s.rebuildPersonalStop()\n s.rebuildBuffs()\n acr.clearAutoSimUncertainty()\n local now=acr.getAutoSimTime()\n acr.addAutoSimUncertainty(now,1)\n local nextPoint=s.points[s.nextBoundary]\n if nextPoint and s.nextBoundary<35 and nextPoint.time-12>now then\n  acr.addAutoSimUncertainty(nextPoint.time-12,4)\n end\n if kill-25>now then acr.addAutoSimUncertainty(kill-25,20) end\nend\nfunction s.resync(i,now)\n local delta=now-s.points[i].time\n local first=i\n while first>s.nextBoundary and math.abs(s.points[first-1].time-s.points[i].time)<1 do first=first-1 end\n for n=first,#s.points do s.points[n].time=s.points[n].time+delta end\n s.nextBoundary=i+1;s.phase=s.points[i].phase\n s.rebuild()\nend\nlocal thordan=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3632,subgroup=\"Nearest\"})\nif thordan then s.primaryID=thordan.id;acr.setAutoSimTarget(0,thordan.id) end\nacr.clearAutoSimTarget(1)\ns.rebuild()\nself.used=true",
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
							actionLua = "local s=data.dsrBrdAutoSim\nif not s then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nif now<0 then self.used=true return end\nlocal cid,id,up=eventArgs.entityContentID,eventArgs.entityID,eventArgs.isTargetable\nlocal entity=TensorCore.mGetEntity(id)\nif up and (not entity or entity.hp.max<=0 or entity.hp.current<=0) then self.used=true return end\nif up and (cid==3458 or cid==4954) and s.nextBoundary>=22\n and s.nextBoundary<=34 and math.abs(entity.pos.z-100)>30 then self.used=true return end\nlocal best,distance\nfor i=math.max(1,s.nextBoundary-2),#s.points do\n local p=s.points[i]\n if p.cid==cid and p.up==up then\n  local d=math.abs(now-p.time)\n  if d<=30 and (i>=s.nextBoundary or d<1) and (not distance or d<distance) then best,distance=i,d end\n end\nend\nif not best then self.used=true return end\nlocal p=s.points[best]\nif up and (best==30 or best==31) and not s.wb2TouchdownAt then\n s.wb2TouchdownAt=now\n s.rebuildPersonalStop()\nend\nif up then\n if data.dsrBrdBalance then data.dsrBrdBalance.pins[p.slot]=false end\n if p.slot==0 then\n  s.primaryID=id\n  TensorCore.API.TensorACR.setAutoSimTarget(0,id)\n  if p.phase~=\"eyes\" and p.phase~=\"p6\" then\n   s.secondaryID=nil;TensorCore.API.TensorACR.clearAutoSimTarget(1)\n  end\n else\n  s.secondaryID=id;TensorCore.API.TensorACR.setAutoSimTarget(1,id)\n end\nend\nif best>=s.nextBoundary then\n if best==35 then s.nextBoundary=36 else s.resync(best,now) end\nend\nself.used=true",
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
	[127] =
	{

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
							actionLua = "local model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nif not model.eyesBudget then\n model.eyesBudget={yellow={},blue={},yellowCount=0,blueCount=0,hits=0,waves={},wave=0}\nend\nlocal s=model.eyesBudget\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nlocal w=s.waves[s.wave]\nif not w or now-w.time>2 then\n if s.wave>=4 then self.used=true return end\n s.wave=s.wave+1;w={time=now,targets={},count=0};s.waves[s.wave]=w\nend\nlocal id=eventArgs.targetID\nif not w.targets[id] and w.count<2 then\n w.targets[id]=true;w.count=w.count+1;s.hits=s.hits+1\nend\nself.used=true",
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
							actionLua = "local model=data.dsrBrdAutoSim\nif not model or model.phase~=\"eyes\" then self.used=true return end\nlocal s=model.eyesBudget\nif not s then self.used=true return end\nlocal acr=TensorCore.API.TensorACR\nlocal now=acr.getAutoSimTime()\nlocal left=model.secondaryID and TensorCore.mGetEntity(model.secondaryID)\nlocal right=model.primaryID and TensorCore.mGetEntity(model.primaryID)\ns.desiredID=nil;s.noSafeTarget=false\nif not left or left.hp.max<=0 or left.hp.current<=0 or not left.targetable then self.used=true return end\nif not s.startHP then\n if s.yellowCount<2 or s.blueCount<4 or now<s.orbsAt+0.5 then self.used=true return end\n if s.hits>0 then self.used=true return end\n s.maxHP=left.hp.max;s.startHP=left.hp.current\n s.diveHP=s.maxHP*0.40\n s.requiredHP=math.max(0,s.startHP-s.diveHP)\n s.startPercent=100*s.startHP/s.maxHP\n s.requiredPercent=100*s.requiredHP/s.maxHP\nend\ns.playerDamageHP=s.startHP-left.hp.current-s.diveHP*s.hits/8\nlocal covered=s.covered or s.playerDamageHP>=s.requiredHP\nif s.hits>=8 then covered=false end\nif covered~=s.covered then\n s.covered=covered\n model.leftEyeDotStopAt=covered and now or nil\n if covered then acr.clearAutoSimTarget(1)\n else acr.setAutoSimTarget(1,left.id) end\n model.rebuild()\nend\nif covered then\n local usable=right and right.targetable and right.attackable and right.hp.max>0\n  and right.hp.current>0 and math.max(0,right.distance2d-right.hitradius)<=25\n if usable then s.desiredID=right.id\n else s.noSafeTarget=true end\nend\nself.used=true",
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
	[208] =
	{

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
							actionLua = "local s = data.dsrBrdBalance\nif not s then\n    s = {margin=1, pins={[0]=false,[1]=false},\n        nidhoggOptions={contentid=3458,subgroup=\"Nearest\"},\n        hraesvelgrOptions={contentid=4954,subgroup=\"Nearest\"}}\n    data.dsrBrdBalance = s\n    function s.usable(e,slot)\n        local model=data.dsrBrdAutoSim\n        if not model or model.phase~=\"p6\" or not model.available(slot,TensorCore.API.TensorACR.getAutoSimTime()) then return false end\n        return e ~= nil and e.targetable and e.attackable and e.hp.max > 0\n            and e.hp.current > 0 and math.max(0,e.distance2d-e.hitradius) <= 25\n    end\n    function s.pin(slot,id)\n        if s.pins[slot] ~= id then\n            if id then TensorCore.API.TensorACR.setAutoSimTarget(slot,id)\n            else TensorCore.API.TensorACR.clearAutoSimTarget(slot) end\n            s.pins[slot] = id\n        end\n    end\nend\nif not s.nidhoggID then\n    local e = TensorCore.getEntityByGroup(\"ContentID\",s.nidhoggOptions)\n    if e then s.nidhoggID=e.id end\nend\nif not s.hraesvelgrID then\n    local e = TensorCore.getEntityByGroup(\"ContentID\",s.hraesvelgrOptions)\n    if e then s.hraesvelgrID=e.id end\nend\nlocal n = s.nidhoggID and TensorCore.mGetEntity(s.nidhoggID)\nlocal h = s.hraesvelgrID and TensorCore.mGetEntity(s.hraesvelgrID)\nlocal nu,hu = s.usable(n,0),s.usable(h,1)\nlocal current = TensorCore.mGetTarget()\nlocal chosen\nlocal nDot,hDot = nu,hu\nif nu and hu then\n    local gap=100*n.hp.current/n.hp.max-100*h.hp.current/h.hp.max\n    if gap > s.margin then chosen=n;hDot=false\n    elseif gap < -s.margin then chosen=h;nDot=false\n    elseif current and (current.id==n.id or current.id==h.id) then chosen=current\n    else chosen=gap>=0 and n or h end\nelseif nu then chosen=n\nelseif hu then chosen=h end\ns.desiredID=chosen and chosen.id or nil\ns.pin(0,nDot and n.id or nil)\ns.pin(1,hDot and h.id or nil)\nself.used=true",
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
	[233] =
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
							actionLua = "local s=data.dsrBrdAutoSim\nlocal player=TensorCore.mGetPlayer()\nif not s or s.phase~=\"p6\" or not player or eventArgs.entityID~=player.id then self.used=true return end\nlocal id=eventArgs.buffID\nif id~=2898 and id~=2899 then self.used=true return end\nlocal now=TensorCore.API.TensorACR.getAutoSimTime()\nif math.abs(now-s.at(28))>20 then self.used=true return end\nlocal margin=2\ns.wb2StopOffset=now+math.max(0,eventArgs.buffDuration-margin)-s.at(28)\ns.rebuildPersonalStop()\nself.used=true",
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
	[243] =
	{

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
	inheritedProfiles =
	{
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl
