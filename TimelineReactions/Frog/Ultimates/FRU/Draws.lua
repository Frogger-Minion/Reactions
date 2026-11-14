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
							actionLua = "data.frog_fru_open_element=\"Lightning\" self.used=true",
							conditions = 
							{
								
								{
									"7a8d8099-ea09-96d5-9fbe-6d407166b0d4",
									true,
								},
								
								{
									"21a7efff-bb01-f27c-b8a1-488dca19f58a",
									true,
								},
							},
							name = "Protean Lightning",
							uuid = "32b2895e-c7b0-bacb-bc8f-3fcf0f7c4fe2",
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
							eventIntValue = 2267,
							name = "Lightning",
							uuid = "7a8d8099-ea09-96d5-9fbe-6d407166b0d4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventArgType = 3,
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "21a7efff-bb01-f27c-b8a1-488dca19f58a",
							version = 3,
						},
					},
				},
				eventType = 27,
				mechanicTime = 13.7,
				name = "[Draw] Protean Lightning",
				timeRange = true,
				timelineIndex = 1,
				timerStartOffset = -13.7,
				uuid = "19d5f15e-a26f-da0b-a96b-84e1006f0079",
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
							actionLua = "data.frog_fru_open_element=\"Fire\" self.used=true",
							conditions = 
							{
								
								{
									"85174258-3e32-23cb-a0eb-65546c0ac266",
									true,
								},
								
								{
									"e6569cdd-c0a7-354b-bf06-9f761d324033",
									true,
								},
							},
							name = "Protean Fire",
							uuid = "89908ae9-3ceb-2b57-a4c4-8a1f1cdffd4b",
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
							eventIntValue = 2268,
							name = "Fire",
							uuid = "85174258-3e32-23cb-a0eb-65546c0ac266",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventArgType = 3,
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "e6569cdd-c0a7-354b-bf06-9f761d324033",
							version = 3,
						},
					},
				},
				eventType = 27,
				mechanicTime = 13.7,
				name = "[Draw] Protean Fire",
				timeRange = true,
				timelineIndex = 1,
				timerStartOffset = -13.7,
				uuid = "90129f50-c5ac-6d9c-91d7-2673943ee6fe",
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
							actionLua = "\nif data.frog_fru_role then self.used=true return end\nif not AnyoneCore then return end\nlocal s=data.frog_fru_roster\nif not s then\n s={keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"},nextCheck=0}\n data.frog_fru_roster=s\nend\nif Now()<s.nextCheck then return end\ns.nextCheck=Now()+1000\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nlocal me=TensorCore.mGetPlayer()\nif not me or type(members)~=\"table\" or type(party)~=\"table\" then return end\nfor _,key in ipairs(s.keys) do\n local member=members[key]\n if member and member.job then\n  local count,match=0,nil\n  for _,actor in pairs(party) do\n   if actor.job==member.job and actor.name==member.name then count=count+1; match=actor end\n  end\n  if count==0 then\n   local n=0\n   for _,other in pairs(members) do if other.job==member.job then n=n+1 end end\n   if n==1 then\n    for _,actor in pairs(party) do if actor.job==member.job then count=count+1; match=actor end end\n   end\n  end\n  if count==1 and match.id==me.id then\n   data.frog_fru_role={key=key,group=key:sub(2,2)==\"1\" and 1 or 2}\n   self.used=true; return\n  end\n end\nend\n",
							name = "Draw Roles",
							uuid = "12fce293-b61a-17c7-8f89-04ce8f41b59e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 13.7,
				name = "[Utility] Draw Roles",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 35.3,
				timerStartOffset = -13.7,
				uuid = "b2ae5e24-6d15-71fa-8c02-2e2b3a256944",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "P3 Apocalypse",
				uuid = "ccb3d835-b10d-7581-a558-f2a7101a37aa",
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
							actionLua = "local pref=FrogDrawMenuPreferences\nif not pref or pref.version~=3 then\n pref={version=3,permanent=false,selected=\"fru\",path=GetLuaModsPath()..[[TensorReactions\\FrogDrawMenuHostSettings.lua]]}\n local ok,saved=pcall(FileLoad,pref.path)\n if ok and type(saved)==\"table\"then pref.permanent=saved.permanent==true;pref.selected=saved.selected==\"dsr\"and\"dsr\"or\"fru\"end\n function pref.save()\n  local value={permanent=pref.permanent,selected=pref.selected}\n  local ok,err=pcall(FileSave,pref.path,value)\n  local readOK,saved=pcall(FileLoad,pref.path)\n  if not ok or not readOK or type(saved)~=\"table\"or saved.permanent~=value.permanent or saved.selected~=value.selected then pref.message=\"Save failed: \"..tostring(err);return false end\n  pref.message=nil;return true\n end\n function pref.inDuty()\n  return InInstance()\n end\n function pref.visible()\n  return pref.permanent or (TensorReactions_CurrentTimer or 0)<30\n end\n function pref.draw()\n  local permanent=GUI:Checkbox(\"Keep draws menu open during pulls\",pref.permanent)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Keep this menu visible after 30 seconds into the pull. Saves automatically.\")end\n  if permanent~=pref.permanent then pref.permanent=permanent;pref.save()end\n  if pref.message then GUI:TextUnformatted(pref.message)end\n end\n FrogDrawMenuPreferences=pref\nend\nlocal timelineMenu=true\nif not pref.visible()then self.used=true return end\nlocal host=FrogDrawMenuHost\nif host and host.protocolVersion==2 and os.time()-host.lastSeen<=2 then\n if host.claim(\"fru\",\"timeline\")then host.reloadFRU()end\n host.settings.fru=FrogFRUDrawSettings\nend\nlocal p=FrogFRUDrawSettings\nif not p or p.menuVersion~=2 then self.used=true return end\nif not p.somberChoices or p.somberChoices[4]~=\"T2 then T1\" then p.somberChoices={\"T1 then T2\",\"T1 both\",\"T2 both\",\"T2 then T1\"} end\nif not p.p1UiReady then\n if not p.p1Version then\n  p.skyStackGroups=p.region==\"EU\" and \"Light parties\" or \"Roles\"\n  p.skyTetherMode=p.region==\"EU\" and \"Light party\" or p.region==\"NA\" and \"Fixed\" or \"Roles\"\n end\n p.p1UiReady=true\nend\nif not p.ui or p.ui.version~=7 then\n local ui={version=7,scopes={\"This phase\",\"All phases\"},tankLabels={\"MT\",\"OT\"},somberLabels={\"MT then OT\",\"MT both\",\"OT both\",\"OT then MT\"}}\n ui.colors={{\"Text\",.91,.92,.90,1},{\"WindowBg\",.11,.11,.11,1},{\"Border\",.29,.31,.28,1},{\"TitleBg\",.13,.13,.13,1},{\"TitleBgActive\",.15,.15,.15,1},{\"FrameBg\",.18,.19,.18,1},{\"FrameBgHovered\",.23,.28,.23,1},{\"FrameBgActive\",.23,.32,.24,1},{\"Header\",.21,.23,.21,1},{\"HeaderHovered\",.23,.32,.23,1},{\"HeaderActive\",.29,.40,.28,1},{\"CheckMark\",.56,.76,.49,1},{\"Button\",.21,.23,.21,1},{\"ButtonHovered\",.29,.31,.28,1},{\"ButtonActive\",.34,.37,.32,1}}\n function ui.push()\n  for _,c in ipairs(ui.colors)do GUI:PushStyleColor(GUI[\"Col_\"..c[1]],c[2],c[3],c[4],c[5])end\n  GUI:PushStyleVar(GUI.StyleVar_WindowRounding,0)\n  GUI:PushStyleVar(GUI.StyleVar_FrameRounding,0)\n  GUI:PushStyleVar(GUI.StyleVar_FrameBorderSize,1)\n  GUI:PushStyleVar(GUI.StyleVar_FramePadding,5*ui.scale,3*ui.scale)\n  GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,6*ui.scale,6*ui.scale)\n end\n function ui.pop() GUI:PopStyleVar(5);GUI:PopStyleColor(#ui.colors) end\n function ui.label(text)\n  GUI:AlignFirstTextHeightToWidgets();GUI:TextUnformatted(text);GUI:SameLine(ui.column)\n end\n function ui.combo(label,id,index,items,width)\n  ui.label(label)\n  GUI:PushItemWidth(width or ui.width)\n  local nextIndex=GUI:Combo(\"##fru.\"..id,index,items)\n  GUI:PopItemWidth()\n  return nextIndex\n end\n function ui.check(label,id,value)\n  ui.label(label)\n  local nextValue=GUI:Checkbox(\"##fru.\"..id,value)\n  if nextValue~=value then p.message=\"Unsaved changes\" end\n  return nextValue\n end\n function ui.sharedMode()\n  local common\n  if p.quickStyleScope==2 then\n   for _,row in ipairs(p.rows)do local value=p.styles[row[1]];if common and common~=value then return nil end;common=value end\n  else\n   for _,key in ipairs(p.groups[p.phase])do local value=p.styles[key];if common and common~=value then return nil end;common=value end\n  end\n  return common\n end\n p.ui=ui\nend\nlocal ui=p.ui\nui.scale=math.max(1,GUI:GetWindowFontSize()/14)\nui.column=146*ui.scale;ui.width=246*ui.scale\np.quickStyleScope=p.quickStyleScope or 1\nGUI:SetNextWindowSize(410*ui.scale,470*ui.scale,GUI.SetCond_FirstUseEver)\nui.push()\nlocal visible=GUI:Begin(\"Frog / FRU Draws\",nil,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n if timelineMenu then pref.draw();GUI:Separator()end\n p.phase=ui.combo(\"Phase\",\"phase\",p.phase,p.phases)\n p.presetChoice=ui.combo(\"Preset\",\"preset\",p.presetChoice,p.regions,174*ui.scale)\n if GUI:IsItemHovered()then GUI:SetTooltip(\"Regional assignments and Akh Morn defaults.\")end\n GUI:SameLine(ui.column+180*ui.scale)\n if GUI:Button(\"Apply##fru.preset\",66*ui.scale,22*ui.scale)then p.apply(p.regions[p.presetChoice])end\n if GUI:IsItemHovered()then GUI:SetTooltip(\"Apply preset changes between pulls.\")end\n GUI:PushStyleColor(GUI.Col_Text,.62,.69,.61,1)\n GUI:TextUnformatted(\"Active preset: \"..p.region)\n GUI:PopStyleColor(1)\n GUI:Separator()\n if GUI:Button(\"Open AnyoneCore roster\") then\n  local popup=AnyoneCore and AnyoneCore.RosterPopup\n  if popup and type(popup.openManual)==\"function\" then\n   local ok,err=pcall(popup.openManual)\n   if not ok then p.message=\"Roster could not open: \"..tostring(err) end\n  else p.message=\"AnyoneCore roster is unavailable\" end\n end\n GUI:Separator()\n ui.label(\"Quick style\")\n local common=ui.sharedMode()\n for i,mode in ipairs(p.modes)do\n  if i>1 then GUI:SameLine(ui.column+(i-1)*84*ui.scale)end\n  local selected=common==mode\n  if selected then GUI:PushStyleColor(GUI.Col_Button,.29,.40,.28,1)end\n  local pressed=GUI:Button(mode..\"##quick_style\",78*ui.scale,22*ui.scale)\n  if GUI:IsItemHovered()then GUI:SetTooltip(mode==\"Tether\" and \"Follows you to the current mechanic destination.\" or mode==\"Arrow\" and \"Timed arrow to the next mechanic destination.\" or \"Hides guidance for the selected scope.\")end\n  if selected then GUI:PopStyleColor(1)end\n  if pressed then\n   if p.quickStyleScope==2 then\n    for _,row in ipairs(p.rows)do p.styles[row[1]]=mode end\n   else\n    for _,key in ipairs(p.groups[p.phase])do p.styles[key]=mode end\n   end\n   p.sync();p.message=(p.quickStyleScope==2 and \"All phases: \" or \"This phase: \")..mode..\" / unsaved\"\n  end\n end\n local arrowVisible=false\n if p.quickStyleScope==2 then\n  for _,row in ipairs(p.rows)do if p.styles[row[1]]==\"Arrow\"then arrowVisible=true;break end end\n else\n  for _,key in ipairs(p.groups[p.phase])do if p.styles[key]==\"Arrow\"then arrowVisible=true;break end end\n end\n if arrowVisible then\n  local appearanceItems={\"Solid\",\"Gradient\"}\n  local appearance=appearanceItems[ui.combo(\"Arrow appearance\",\"arrow_appearance\",p.arrowAppearance==\"Gradient\" and 2 or 1,appearanceItems)] or \"Solid\"\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Solid fill or a colour gradient. Applies to all FRU arrows.\")end\n  if appearance~=p.arrowAppearance then p.arrowAppearance=appearance;p.message=\"Unsaved changes\" end\n end\n p.quickStyleScope=ui.combo(\"Style scope\",\"style_scope\",p.quickStyleScope,ui.scopes)\n p.calloutModes=p.calloutModes or {\"Both\",\"Text only\",\"Sound only\",\"Off\"}\n local calloutIndex=1\n for i,mode in ipairs(p.calloutModes)do if mode==p.calloutOutput then calloutIndex=i end end\n local callout=p.calloutModes[ui.combo(\"Callouts\",\"callouts\",calloutIndex,p.calloutModes)]\n if GUI:IsItemHovered()then GUI:SetTooltip(\"Our callouts: text, voice, both or off.\")end\n if callout~=p.calloutOutput then p.calloutOutput=callout;p.message=\"Unsaved changes\"end\n GUI:Separator()\n if GUI:CollapsingHeader(\"Individual mechanic styles##fru.\"..p.phase)then\n for _,key in ipairs(p.groups[p.phase])do\n  local index=1\n  for i,mode in ipairs(p.modes)do if p.styles[key]==mode then index=i end end\n  local selected=ui.combo(p.labels[key],\"style.\"..key,index,p.modes)\n  if GUI:IsItemHovered()then GUI:SetTooltip(p.modes[selected]==\"Tether\" and \"Live tether to your assigned destination.\" or p.modes[selected]==\"Arrow\" and \"Timed arrow for each movement step.\" or \"Hides this mechanic guidance.\")end\n  if p.styles[key]~=p.modes[selected]then p.styles[key]=p.modes[selected];p.sync();p.message=\"Unsaved changes\"end\n end\n GUI:Spacing()\n GUI:Separator()\n GUI:Spacing()\n end\n if p.phase==1 then\n  local groupItems={\"Roles\",\"Light parties\"}\n  local groupIndex=ui.combo(\"Stack groups\",\"sky_stack_groups\",p.skyStackGroups==\"Light parties\" and 2 or 1,groupItems)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Roles: supports north / DPS south. Light party: G1 north / G2 south.\")end\n  local groups=groupItems[groupIndex]\n  local modes={\"Fixed\",\"Light party\",\"Roles\"}\n  local current=p.skyTetherMode==\"Roles\" and 3 or p.skyTetherMode==\"Light party\" and 2 or 1\n  local mode=modes[ui.combo(\"Tether assignment\",\"sky_fixed_tether\",current,modes)] or modes[current]\n  if GUI:IsItemHovered()then\n   local hint=mode==\"Fixed\" and \"Short tether south; other tether north.\" or mode==\"Light party\" and \"G1 north / G2 south. Flex: T > M > R > H.\" or p.region==\"JP\" and \"Marked priority north to south: H1 H2 MT OT M1 M2 R1 R2.\" or \"Supports north / DPS south; marked players split by role priority.\"\n   GUI:SetTooltip(hint)\n  end\n  if groups~=p.skyStackGroups or mode~=p.skyTetherMode then\n   p.skyStackGroups=groups;p.skyTetherMode=mode;p.message=\"Unsaved changes\"\n   local state=data.frog_fru_sky_prey\n   if state then\n    state.ready=false;state.dirty=true;state.nextPoll=0;state.destination=nil\n    if p.release then p.release(data,\"frog_fru_sky_prey\")end\n    if state.poll and p.assignSkyStacks then\n     state.assign=function()return p.assignSkyStacks(state)end\n     state.assignmentVersion=3;state.poll()\n    end\n   end\n  end\n  p.skyKB=ui.check(\"Utopian KB Cancel\",\"sky_kb\",p.skyKB)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Queues KB cancel for the Utopian fire knockback just before stacks.\")end\n local towerPlayer=TensorCore.mGetPlayer()\n if towerPlayer and (towerPlayer.job==19 or towerPlayer.job==21 or towerPlayer.job==32 or towerPlayer.job==37) then\n  GUI:Separator()\n  local choices={\"Stacked\",\"MT north\",\"OT north\"}\n  local current=p.towerTank==\"Stacked\" and 1 or p.towerTank==\"OT north\" and 3 or 2\n  local choice=choices[ui.combo(\"Tower tanks\",\"tower_tanks\",current,choices)] or choices[current]\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Opposite the towers. Stacked stays together. Split tanks wait at the wall through the buster; movement helpers are off.\")end\n  if choice~=p.towerTank then p.towerTank=choice;p.message=\"Unsaved changes\";local state=data.frog_fru_towers;if state and state.update then state.update()end end\n  if p.towerTank==\"Stacked\" then\n  p.towerLightningGap=ui.check(\"Lightning gap close\",\"tower_lightning_gap\",p.towerLightningGap==true)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Uses your tank gap closer after Burnout resolves.\")end\n  p.towerFireKB=ui.check(\"Fire KB cancel\",\"tower_fire_kb\",p.towerFireKB==true)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Queues the ACR gap-closer KB cancel 0.5s before Blastburn.\")end\n  end\n end\n elseif p.phase==2 then\n  p.darkCrystalCones=ui.check(\"Dark crystal cones\",\"dark_crystal_cones\",p.darkCrystalCones)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Shows dark-crystal cone baits and locked directions.\")end\n elseif p.phase==3 then\n  local role=ui.combo(\"Dance bait\",\"dance_bait\",p.bait==\"T2\" and 2 or 1,ui.tankLabels)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Designated tank for the Darkest Dance jump bait.\")end\n  if p.bait~=p.tanks[role]then p.bait=p.tanks[role];p.message=\"Unsaved changes\"end\n  p.kb=ui.check(\"Dance KB Cancel\",\"movement_kb\",p.kb)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Queues a supported gap-closer KB cancel 0.5s before the knockback.\")end\n elseif p.phase==4 then\n  local index=p.somber==\"T1 both\" and 2 or p.somber==\"T2 both\" and 3 or p.somber==\"T2 then T1\" and 4 or 1\n  local somber=ui.combo(\"Somber baits\",\"somber\",index,ui.somberLabels)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"First tank baits far; second baits close. Both assigns one tank to both hits.\")end\n  if p.somber~=p.somberChoices[somber]then p.somber=p.somberChoices[somber];p.message=\"Unsaved changes\"end\n  if p.region==\"JP\" then\n   p.ctMarkBlue=ui.check(\"CT blue auto marks\",\"ct_blue_marks\",p.ctMarkBlue==true)\n   if GUI:IsItemHovered()then GUI:SetTooltip(\"Attack 1-4: H1 > MT > OT > M1 > M2 > R1 > R2 > H2. Only one party member should enable this. Marks placed here clear on wipe.\")end\n  end\n  GUI:Separator()\n  local first=ui.combo(\"Akh Morn 1\",\"akh1_setup\",p.akh==\"6-2\" and 3 or p.akh==\"4-4\" and 2 or 1,p.formations)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"First Akh Morn: 7-1 solo, 4-4 light parties, or 6-2 tanks together.\")end\n  if p.akh~=p.formations[first]then p.akh=p.formations[first];p.message=\"Unsaved changes\"end\n  if p.akh==\"7-1\" then\n   local tank=ui.combo(\"AM1 Solo Tank\",\"akh1_solo\",p.akhSolo==\"T1\" and 1 or 2,ui.tankLabels)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Tank taking the first Akh Morn alone.\")end\n   if p.akhSolo~=p.tanks[tank]then p.akhSolo=p.tanks[tank];p.message=\"Unsaved changes\"end\n  end\n  local second=ui.combo(\"Akh Morn 2\",\"akh2_setup\",p.ctAkh==\"6-2\" and 3 or p.ctAkh==\"4-4\" and 2 or 1,p.formations)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Second Akh Morn after CT: solo, light parties, or tanks together.\")end\n  if p.ctAkh~=p.formations[second]then p.ctAkh=p.formations[second];p.message=\"Unsaved changes\"end\n  if p.ctAkh==\"7-1\" then\n   local tank=ui.combo(\"AM2 Solo Tank\",\"akh2_solo\",p.ctSolo==\"T1\" and 1 or 2,ui.tankLabels)\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Tank taking the second Akh Morn alone.\")end\n   if p.ctSolo~=p.tanks[tank]then p.ctSolo=p.tanks[tank];p.message=\"Unsaved changes\"end\n  end\n\n end\n GUI:Separator()\n if GUI:Button(\"Save settings\",118*ui.scale,24*ui.scale)then p.save()end\n if p.message then GUI:TextWrapped(p.message)end\nend\nGUI:End()\nui.pop()\nself.used=true\n",
							conditions = 
							{
								
								{
									"c24f1d4a-b616-53a6-8a7f-108d7e3a2c61",
									true,
								},
							},
							name = "FRU strategy settings",
							uuid = "e5095df5-2645-b49b-944b-2ea4f42e8dc6",
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
							localmapid = 1238,
							name = "FRU map",
							uuid = "c24f1d4a-b616-53a6-8a7f-108d7e3a2c61",
							version = 3,
						},
					},
				},
				displayPath = "P3 Apocalypse",
				eventType = 13,
				loop = true,
				mechanicTime = 13.7,
				name = "[FRU] Draw menu",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1800,
				timerStartOffset = -14,
				uuid = "5a8a63d7-1757-ef6d-acb7-c058dde39bd2",
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
							actionLua = "if not FrogFRUDrawSettings or FrogFRUDrawSettings.menuVersion~=2 or FrogFRUDrawSettings.visualVersion~=30 or FrogFRUDrawSettings.p1Version~=3 or FrogFRUDrawSettings.ctMarkVersion~=1 then\n local old=FrogFRUDrawSettings\n local path=GetLuaModsPath()..[[TensorReactions\\FrogFRUDrawSettings.lua]]\n if type(old)~=\"table\" then\n  local ok,value=pcall(FileLoad,path)\n  old=ok and type(value)==\"table\" and value or {}\n end\n local p={menuVersion=2,visualVersion=30,path=path,open=true,phase=old.phase or 1,region=old.region or \"NA\",bait=old.bait or \"T1\",kb=old.kb~=false,skyKB=old.skyKB~=false,akh=old.akh or \"7-1\",ctAkh=old.ctAkh or old.akh or \"7-1\",akhSolo=old.akhSolo or \"T2\",ctSolo=old.ctSolo or (old.akhSolo==\"T1\" and \"T2\" or \"T1\"),somber=old.somber or (old.somberBoth and \"T1 both\" or \"T1 then T2\"),styles={}}\n p.calloutOutput=old.calloutOutput or \"Both\"\n p.calloutModes={\"Both\",\"Text only\",\"Sound only\",\"Off\"}\n p.ctMarkVersion=1;p.ctMarkBlue=old.ctMarkBlue==true;p.ctOwned=old.ctOwned\n p.arrowAppearance=old.arrowAppearance==\"Gradient\" and \"Gradient\" or \"Solid\"\n p.towerTank=old.towerTank==\"Stacked\" and \"Stacked\" or old.towerTank==\"OT north\" and \"OT north\" or \"MT north\"\n p.towerLightningGap=old.towerLightningGap==true;p.towerFireKB=old.towerFireKB==true\n p.p1Version=3\n p.skyStackGroups=(old.skyStackGroups==\"Roles\" or old.skyStackGroups==\"Light parties\") and old.skyStackGroups or (p.region==\"EU\" and \"Light parties\" or \"Roles\")\n p.skyTetherMode=old.skyTetherMode\n if p.skyTetherMode~=\"Fixed\" and p.skyTetherMode~=\"Light party\" and p.skyTetherMode~=\"Roles\" then\n  if old.skyFixedTether~=nil then p.skyTetherMode=old.skyFixedTether and \"Fixed\" or \"Light party\"\n  else p.skyTetherMode=p.region==\"EU\" and \"Light party\" or p.region==\"NA\" and \"Fixed\" or \"Roles\" end\n end\n p.darkCrystalCones=old.darkCrystalCones~=false\n p.regions={\"NA\",\"EU\",\"JP\",\"Elemental\"}\n p.phases={\"P1 / Fatebreaker\",\"P2 / Usurper\",\"P3 / Oracle\",\"P4 / Reunion\",\"P5 / Pandora\"}\n p.modes={\"Tether\",\"Arrow\",\"Disabled\"}\n p.formations={\"7-1\",\"4-4\",\"6-2\"}\n p.tanks={\"T1\",\"T2\"}\n p.somberChoices={\"T1 then T2\",\"T1 both\",\"T2 both\",\"T2 then T1\"}\n p.rows={{\"proteans\",\"Proteans\"},{\"sky\",\"Utopian Sky\"},{\"skyCleaves\",\"Sky cleaves\"},{\"skyStacks\",\"Sky stacks\"},{\"faith\",\"Fall of Faith\"},{\"towers\",\"Towers\"},{\"dd\",\"Diamond Dust\"},{\"mm\",\"Mirror Mirror\"},{\"lr\",\"Light Rampant\"},{ \"intermission\",\"Intermission\"},{\"ur\",\"UR\"},{\"apoc\",\"Apocalypse\"},{\"darklit\",\"Darklit\"},{\"akhRhai\",\"Akh Rhai\"},{\"somber\",\"Somber Dance\"},{\"akh1\",\"Akh Morn 1\"},{\"afah1\",\"Morn Afah 1\"},{\"ct\",\"Crystallize Time\"},{\"akh2\",\"Akh Morn 2\"},{\"afah2\",\"Morn Afah 2\"},{\"p5_fulgent\",\"Fulgent Blade\"},{\"p5_paradise\",\"Paradise / Wings\"},{\"p5_polar\",\"Polarizing Strikes\"}}\n p.groups={{\"proteans\",\"sky\",\"skyCleaves\",\"skyStacks\",\"faith\",\"towers\"},{\"dd\",\"mm\",\"lr\",\"intermission\"},{\"ur\",\"apoc\"},{\"akhRhai\",\"darklit\",\"somber\",\"akh1\",\"afah1\",\"ct\",\"akh2\",\"afah2\"},{\"p5_fulgent\",\"p5_paradise\",\"p5_polar\"}}\n p.labels={}\n for _,row in ipairs(p.rows)do\n  local key=row[1];p.labels[key]=row[2]\n  local mode=type(old.styles)==\"table\" and old.styles[key]\n  if key==\"intermission\" and mode==nil and type(old.styles)==\"table\" then mode=old.styles.lr end\n  if mode~=\"Arrow\" and mode~=\"Tether\" and mode~=\"Disabled\" then\n   local enabled=old[key]~=false\n   if key==\"apoc\" then enabled=old.mode~=\"Disabled\" end\n   if key:sub(1,3)==\"p5_\" then mode=old.p5Mode or \"Tether\";enabled=old.p5~=false end\n   mode=enabled and (mode or \"Tether\") or \"Disabled\"\n  end\n  p.styles[key]=mode\n end\n function p.styleFor(key) return p.styles[key] or \"Tether\" end\n function p.sync()\n  p.p5Strategy=p.region==\"JP\" and \"Mana\" or p.region\n  p.dd=p.styles.dd~=\"Disabled\";p.mm=p.styles.mm~=\"Disabled\";p.lr=p.styles.lr~=\"Disabled\"\n  p.skyStacks=p.styles.skyStacks~=\"Disabled\"\n  p.mode=p.styles.apoc==\"Disabled\" and \"Disabled\" or \"Tether\"\n  p.darklit=false\n  for _,key in ipairs({\"darklit\",\"akhRhai\",\"somber\",\"akh1\",\"afah1\"})do if p.styles[key]~=\"Disabled\" then p.darklit=true end end\n  p.ct=p.styles.ct~=\"Disabled\" or p.styles.akh2~=\"Disabled\" or p.styles.afah2~=\"Disabled\"\n  p.p5=p.styles.p5_fulgent~=\"Disabled\" or p.styles.p5_paradise~=\"Disabled\" or p.styles.p5_polar~=\"Disabled\"\n  p.p5Mode=\"Tether\"\n end\n function p.assignSkyStacks(s)\n if not s.safeSide or not s.rosterReady then return false end\n local short,long=s.sources[s.safeSide],s.sources[-s.safeSide]\n if not short or not long or short.target==long.target then return false end\n local prefs=FrogFRUDrawSettings or {}\n local region=prefs.region or \"NA\"\n local groups=prefs.skyStackGroups or (region==\"EU\" and \"Light parties\" or \"Roles\")\n local mode=prefs.skyTetherMode or \"Fixed\"\n local fixed=mode==\"Fixed\"\n local shortRole,longRole\n for _,key in ipairs(s.keys) do\n  local r=s.records[key]\n  local support=key:sub(1,1)==\"T\" or key:sub(1,1)==\"H\"\n  r.north=groups==\"Light parties\" and key:sub(2)==\"1\" or groups~=\"Light parties\" and support\n  r.flex=nil;r.prey=nil\n  if r.id==short.target then shortRole=key end\n  if r.id==long.target then longRole=key end\n end\n if not shortRole or not longRole then return false end\n local a,b=s.records[shortRole],s.records[longRole]\n local northRole,southRole=longRole,shortRole\n if mode==\"Roles\" then\n  local order=region==\"JP\" and {\"H1\",\"H2\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\"} or {\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n  local first\n  for _,key in ipairs(order) do\n   if key==shortRole or key==longRole then first=key;break end\n  end\n  local other=first==shortRole and longRole or shortRole\n  local bothSupport=(first:sub(1,1)==\"T\" or first:sub(1,1)==\"H\") and (other:sub(1,1)==\"T\" or other:sub(1,1)==\"H\")\n  northRole=region~=\"JP\" and bothSupport and other or first\n  southRole=northRole==shortRole and longRole or shortRole\n elseif mode==\"Light party\" then\n  local shortNorth=shortRole:sub(2)==\"1\"\n  local longNorth=longRole:sub(2)==\"1\"\n  if shortNorth~=longNorth then northRole=shortNorth and shortRole or longRole\n  else\n   local first\n   for _,key in ipairs({\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\",\"H1\",\"H2\"}) do if key==shortRole or key==longRole then first=key;break end end\n   if shortNorth then northRole=first==shortRole and longRole or shortRole\n   else northRole=first end\n  end\n  southRole=northRole==shortRole and longRole or shortRole\n end\n s.records[northRole].north=true;s.records[southRole].north=false\n a.prey=true;b.prey=true\n local northCount=0\n for _,key in ipairs(s.keys) do if s.records[key].north then northCount=northCount+1 end end\n if northCount~=4 then\n  local flexOrder=(mode==\"Light party\" or groups==\"Light parties\") and {\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\",\"H1\",\"H2\"} or {\"T1\",\"M1\",\"T2\",\"M2\",\"R1\",\"R2\",\"H1\",\"H2\"}\n  for _,key in ipairs(flexOrder) do\n   local r=s.records[key]\n   if not r.prey and r.north==(northCount>4) then r.north=not r.north;r.flex=true;break end\n  end\n end\n local north=0\n for _,key in ipairs(s.keys) do if s.records[key].north then north=north+1 end end\n if north~=4 then return false end\n s.northTarget=s.records[northRole].id;s.southTarget=s.records[southRole].id\n s.assignedGroups=groups;s.assignedFixed=fixed\n s.ready=true;s.dirty=false;return true\nend\n function p.clearCTMarks()\n  local pending=false\n  for marker,id in pairs(p.ctOwned or {})do\n   local actor=TensorCore.mGetEntity(id)\n   if actor and actor.marker==marker then\n    local action=ActionList:Get(12,marker)\n    if action then action:Cast(id)end\n    pending=true\n   elseif actor then p.ctOwned[marker]=nil\n   else pending=true end\n  end\n  p.ctCleanupTries=(p.ctCleanupTries or 0)+1\n  p.ctCleanupAt=pending and p.ctCleanupTries<4 and Now()+600 or nil\n  if not pending then p.ctOwned=nil end\n end\n function p.document()\n  local value={calloutOutput=p.calloutOutput,towerTank=p.towerTank,towerLightningGap=p.towerLightningGap,towerFireKB=p.towerFireKB,arrowAppearance=p.arrowAppearance,menuVersion=2,ctMarkBlue=p.ctMarkBlue,skyStackGroups=p.skyStackGroups,skyTetherMode=p.skyTetherMode,darkCrystalCones=p.darkCrystalCones,region=p.region,bait=p.bait,kb=p.kb,skyKB=p.skyKB,akh=p.akh,ctAkh=p.ctAkh,akhSolo=p.akhSolo,ctSolo=p.ctSolo,somber=p.somber,styles={}}\n  for _,row in ipairs(p.rows)do value.styles[row[1]]=p.styles[row[1]] end\n  return value\n end\n function p.callout(text)\n  local mode=p.calloutOutput or \"Both\"\n  if mode==\"Both\" or mode==\"Text only\" then TensorCore.addAlertText(2500,text,1,2,false,75) end\n  if mode==\"Both\" or mode==\"Sound only\" then TensorCore.sendTTS(text,75) end\n end\n function p.save()\n  p.sync()\n  local value=p.document()\n  local ok,result=pcall(FileSave,p.path,value)\n  if not ok or result==false then p.message=\"Save failed\";return false end\n  local readOK,saved=pcall(FileLoad,p.path)\n  if not readOK or type(saved)~=\"table\" or type(saved.styles)~=\"table\" then p.message=\"Save verification failed\";return false end\n  for key,v in pairs(value)do if key~=\"styles\" and saved[key]~=v then p.message=\"Save verification failed\";return false end end\n  for key,v in pairs(value.styles)do if saved.styles[key]~=v then p.message=\"Save verification failed\";return false end end\n  p.message=\"Saved\";return true\n end\n function p.apply(region)\n  p.towerTank=\"MT north\"\n  p.skyStackGroups=region==\"EU\" and \"Light parties\" or \"Roles\"\n  p.skyTetherMode=region==\"NA\" and \"Fixed\" or region==\"EU\" and \"Light party\" or \"Roles\"\n  p.region=region;p.akh=region==\"Elemental\" and \"4-4\" or \"7-1\";p.ctAkh=p.akh\n  p.akhSolo=region==\"JP\" and \"T1\" or \"T2\";p.ctSolo=p.akhSolo==\"T1\" and \"T2\" or \"T1\"\n  local members=AnyoneCore and AnyoneCore.Roster.members() or {}\n  local mt=members and members.T1\n  local mtPaladin=mt and mt.job==19\n  p.bait=region==\"JP\" and (mtPaladin and \"T1\" or \"T2\") or \"T1\"\n  p.somber=\"T1 then T2\"\n  if region==\"JP\" or region==\"EU\" then p.somber=mtPaladin and \"T2 both\" or \"T1 both\" end\n  if region==\"EU\" then\n   p.akhSolo=mtPaladin and \"T1\" or \"T2\"\n   p.ctSolo=mtPaladin and \"T2\" or \"T1\"\n  end\n  p.sync()\n  if p.save() then p.message=region..\" preset applied.\" end\n end\n function p.release(context,key)\n  local states=context.frog_fru_guidance_v2\n  local state=states and states[key]\n  if state and state.uuid then Argus.deleteTimedShape(state.uuid) end\n  if state and state.halo then Argus.deleteTimedShape(state.halo) end\n  if states then states[key]=nil end\n end\n function p.cleanup(context)\n  local states=context.frog_fru_guidance_v2\n  if not states then return end\n  local now=Now()\n  for key,state in pairs(states)do\n   if now-state.seen>500 or p.styleFor(state.style)~=\"Arrow\" then p.release(context,key) end\n  end\n end\n function p.markerFor(style,owner)\n  if style==\"lr\" then\n   local assignment=owner.assignments and owner.assignments[owner.role]\n   return assignment~=nil and not assignment.bait and not assignment.done\n  end\n  if style==\"mm\" then return owner.phase==\"pairs\" or owner.phase==\"spread\" end\n  if style==\"darklit\" then return owner.stage==0 or owner.stage==1 end\n  if style==\"apoc\" then return owner.stage==0 or owner.stage==3 or owner.stage==6 end\n  if style==\"ct\" then return owner.finished==true and not owner.spread and not owner.spiritDone end\n  return style==\"skyStacks\" or style==\"faith\" or style==\"towers\" or style==\"ur\" or style==\"akhRhai\" or style==\"akh1\" or style==\"akh2\" or style==\"afah1\" or style==\"afah2\"\n end\n function p.arrowDrawer(color,flags,countdown,style)\n  local drawer\n  if p.arrowAppearance==\"Gradient\" and countdown~=false then\n   local start=color\n   local mid=style and style:sub(1,3)==\"p5_\" and 0xFFD02090 or color==0xFFFF40FF and 0xFFA020FF or 0xFF0088FF\n   local finish=style and style:sub(1,3)==\"p5_\" and 0xFF4000FF or color==0xFFFF40FF and 0xFF4000FF or 0xFF0000FF\n   drawer=TensorCore.getCachedDrawer(start,mid,finish,0xFFFFFFFF,2,0,flags)\n  else\n   drawer=TensorCore.getCachedDrawer(color,color,color,0xFFFFFFFF,2,0,flags)\n  end\n  drawer.gradientMinOpacity=0.6\n  return drawer\n end\n function p.castDeadline(context,owner,ids)\n  local times=context.frog_fru_arrow_casts\n  if not times then return end\n  local floor=owner.start or owner.started or 0\n  local deadline\n  for _,id in ipairs(ids)do\n   local cast=times[id]\n   if cast and cast.at>=floor and cast.at<=Now() then\n    deadline=deadline and math.min(deadline,cast.deadline) or cast.deadline\n   end\n  end\n  return deadline\n end\n function p.guide(context,key,style,owner,player,x,y,z,label,ttl,width)\n  local mode=p.styleFor(style)\n  if mode==\"Arrow\" then y=0 end\n  if mode==\"Disabled\" then p.release(context,key);return end\n  local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  local distance=(player.pos.x-x)^2+(player.pos.z-z)^2\n  local arrival=(owner.arrivalRadius or .8)^2\n  local drawer=TensorCore.getStaticDrawer(distance<=arrival and 0xFF40E080 or 0xFF00FFFF,1,0,flags)\n  if mode==\"Arrow\" then\n   local color=style:sub(1,3)==\"p5_\" and 0xFF40FF40 or style==\"ur\" and 0xFFFF40FF or 0xFF00FFFF\n   local holding=owner.arrowHoldAfterDeadline and owner.arrowDeadline and Now()>=owner.arrowDeadline\n   if holding then color=style:sub(1,3)==\"p5_\" and 0xFF4000FF or style==\"ur\" and 0xFFFF0080 or 0xFF0000FF end\n   drawer=p.arrowDrawer(color,flags,owner.arrowDeadline~=nil and not holding,style)\n  end\n  if mode==\"Tether\" and p.markerFor(style,owner) then drawer:addCircle(x,y,z,.6,false,flags) end\n  if mode==\"Tether\" then\n   p.release(context,key)\n   if distance>arrival then drawer:addLine(player.pos.x,player.pos.y+.07,player.pos.z,x,y,z,width or 6,2)\n   elseif owner.keepVisible then\n    local h=owner.heading or 0\n    drawer:addLine(x-math.sin(h)*2,y,z-math.cos(h)*2,x,y,z,width or 6,2)\n   end\n   return\n  end\n  local states=context.frog_fru_guidance_v2\n  if not states then states={};context.frog_fru_guidance_v2=states end\n  local now=Now();local holding=owner.arrowHoldAfterDeadline and owner.arrowDeadline and now>=owner.arrowDeadline\n  local stage=tostring(p.arrowAppearance)..\":\"..tostring(owner.arrowStage or owner.stage or owner.phase or owner.step or owner.nextHit or \"\")..\":\"..tostring(label or \"\")..\":\"..tostring(owner.arrowDeadline or \"\")..\":\"..tostring(holding)\n  local state=states[key]\n  local anchor=state and state.owner==owner and state.label==label and state.style==style and now>=state.seen and {x=state.x,y=state.y,z=state.z} or nil\n  if state and (state.owner~=owner or state.stage~=stage or now<state.seen) then p.release(context,key);state=nil end\n  if distance<=arrival and not owner.keepVisible then\n   if state and state.uuid then Argus.deleteTimedShape(state.uuid);state.uuid=nil end\n   if not state then state={owner=owner,stage=stage,style=style};states[key]=state end\n   state.arrived=true;state.tx=x;state.tz=z;state.seen=now;return\n  end\n  if state and state.arrived then\n   if (state.tx or x)-x==0 and (state.tz or z)-z==0 then state.seen=now;return end\n   p.release(context,key);state=nil\n  end\n  local ox,oy,oz=player.pos.x,player.pos.y+.08,player.pos.z\n  if not state and owner.keepVisible and distance<=arrival then\n   local h=owner.heading or 0\n   ox=x-math.sin(h)*2;oy=y;oz=z-math.cos(h)*2\n  end\n  if state then ox,oy,oz=state.x,state.y,state.z elseif anchor then ox,oy,oz=anchor.x,anchor.y,anchor.z end\n  if owner.arrowFromCenter or style==\"faith\" or style==\"sky\" or style==\"towers\" or (style==\"skyStacks\" and not state and not anchor) then ox=100;oy=y;oz=100 end\n  if style==\"intermission\" and owner.crystalOrigin then ox=owner.crystalOrigin.x;oz=owner.crystalOrigin.z end\n  oy=y\n  local dx,dz=x-ox,z-oz;local length=math.sqrt(dx*dx+dz*dz)\n  if length<4 then\n   local h=length>.05 and math.atan2(dx,dz) or owner.heading or math.atan2(x-100,z-100)\n   ox=x-math.sin(h)*4;oy=y;oz=z-math.cos(h)*4\n   dx=x-ox;dz=z-oz;length=4\n  end\n  if length<.05 then return end\n  local tip=math.min(2,length*.35);local heading=math.atan2(dx,dz)\n  local deadline=owner.arrowDeadline\n  if deadline and now>=deadline and not holding then p.release(context,key);return end\n  local duration=deadline and not holding and math.max(1,deadline-now) or 180000\n  local haloDrawer\n  if style:sub(1,3)==\"p5_\" then haloDrawer=TensorCore.getCachedDrawer(0,0,0,0xFF101010,6,0,flags) end\n  if state and ((state.tx-x)^2+(state.tz-z)^2>.0625 or (state.x-ox)^2+(state.y-oy)^2+(state.z-oz)^2>.0001) then\n   if state.halo and not haloDrawer:updateTimedArrow(state.halo,nil,ox,oy,oz,heading,length-tip,.75,tip,1.5,0,false,flags) then p.release(context,key);state=nil end\n   if state and not drawer:updateTimedArrow(state.uuid,nil,ox,oy,oz,heading,length-tip,.75,tip,1.5,0,false,flags) then p.release(context,key);state=nil end\n   if state then state.refreshed=now;state.tx=x;state.tz=z;state.x=ox;state.y=oy;state.z=oz end\n  end\n  if not state then\n   local halo=haloDrawer and haloDrawer:addTimedArrow(duration,ox,oy,oz,heading,length-tip,.75,tip,1.5,0,false,flags)\n   local uuid=drawer:addTimedArrow(duration,ox,oy,oz,heading,length-tip,.75,tip,1.5,0,false,flags)\n   if not uuid then if halo then Argus.deleteTimedShape(halo) end;return end\n   state={uuid=uuid,halo=halo,owner=owner,stage=stage,style=style,label=label,x=ox,y=oy,z=oz,tx=x,tz=z,refreshed=now};states[key]=state\n  end\n  state.seen=now\n end\n function p.drawSpreads(owner,style)\n  if p.styleFor(style)==\"Disabled\" then return end\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  if not p.spreadDrawer then p.spreadDrawer=TensorCore.getCachedDrawer(0x300040FF,nil,0x300040FF,0xD06080FF,2,0,flags) end\n  for _,key in ipairs(owner.keys)do\n   local record=owner.records[key]\n   local actor=record and TensorCore.mGetEntity(record.id)\n   if actor and actor.pos and actor.hp.current>0 then\n    p.spreadDrawer:addCircle(actor.pos.x,actor.pos.y+.04,actor.pos.z,5,false,flags)\n   end\n  end\n end\n p.sync();p.presetChoice=1\n for i,region in ipairs(p.regions)do if p.region==region then p.presetChoice=i end end\n FrogFRUDrawSettings=p\nend\nlocal p=FrogFRUDrawSettings\nif p.skyKBVersion~=2 then\n local allowed={\n  [25]={[155]=1}, \n  [24]={[37008]=1}, \n  [38]={[16010]=1}, \n  [41]={[34646]=1}, \n  [20]={[25762]=1}, \n  [39]={[24401]=1,[24402]=2}, \n  [22]={[94]=1}, \n  [40]={[24295]=1}, \n  [30]={[2262]=1}, \n  [42]={[34684]=1},\n }\n function p.skyKBCancel(player)\n  if p.skyKB~=true or not player then return end\n  local jobActions=allowed[player.job];if not jobActions then return end\n  local selected,rank,name\n  for _,t in pairs(TensorCore.API.TensorACR.getHotbarToggles() or {})do\n   local n=type(t.name)==\"function\" and t.name() or t.name\n   local r=jobActions[t.id]\n   if t.enabled~=false and r and type(n)==\"string\" and n:find(\"KB Cancel\",1,true) and type(t.var)==\"string\"then\n    if not selected or r<rank or (r==rank and n<name)then selected,rank,name=t,r,n end\n   end\n  end\n  return selected\n end\n p.skyKBVersion=2\nend\nif p.banishVersion~=2 then\n function p.drawBanish(kind,deadline,style,state,role)\n  if (kind~=\"pairs\" and kind~=\"spread\")or not deadline or Now()>deadline+700 or p.styleFor(style)==\"Disabled\" then return end\n  if not AnyoneCore or not AnyoneCore.Roster.isReady()then return end\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  if kind==\"spread\" then\n   if not p.spreadDrawer then p.spreadDrawer=TensorCore.getCachedDrawer(0x300040FF,nil,0x300040FF,0xD06080FF,2,0,flags)end\n   for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n    local id=AnyoneCore.Roster.idOf(key);local actor=id and TensorCore.mGetEntity(id)\n    if actor and actor.pos and actor.hp.current>0 then p.spreadDrawer:addCircle(actor.pos.x,actor.pos.y+.04,actor.pos.z,5,false,flags)end\n   end\n   return\n  end\n  local me=TensorCore.mGetPlayer()\n  if not me or not me.pos or me.hp.current<=0 then return end\n  local partnerRole\n  if state and role and AnyoneCore.Roster.idOf(role)==me.id then\n   if style==\"mm\" and state.partners then partnerRole=state.partners[role]\n   elseif style==\"lr\" and state.pairAnchor then\n    local anchor=state.pairAnchor[role]\n    if anchor then\n     for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n      if key~=role and state.pairAnchor[key]==anchor then\n       if partnerRole then partnerRole=nil;break end\n       partnerRole=key\n      end\n     end\n    end\n   end\n  end\n  local id=partnerRole and AnyoneCore.Roster.idOf(partnerRole)\n  local partner=id and id~=me.id and TensorCore.mGetEntity(id)\n  local ready=partner and partner.pos and partner.hp.current>0 and (me.pos.x-partner.pos.x)^2+(me.pos.z-partner.pos.z)^2<=4.5^2\n  flags=flags+Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  if not p.banishRangeOutline then p.banishRangeOutline=TensorCore.getCachedDrawer(0,0,0,0xF0101010,6,0,flags)end\n  if not p.banishRangeGood then p.banishRangeGood=TensorCore.getCachedDrawer(0,0,0,0xFF40E080,3,0,flags)end\n  if not p.banishRangeBad then p.banishRangeBad=TensorCore.getCachedDrawer(0,0,0,0xFF4040FF,3,0,flags)end\n  p.banishRangeOutline:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n  local drawer=ready and p.banishRangeGood or p.banishRangeBad\n  drawer:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n end\n p.banishVersion=2\nend\nif p.ctCleanupAt and Now()>=p.ctCleanupAt then p.clearCTMarks()end\nlocal state=data.frog_fru_sky_prey\nif state and state.assignmentVersion~=3 then\n state.assign=function()return p.assignSkyStacks(state)end\n state.assignmentVersion=3;state.dirty=true;state.nextPoll=0;state.destination=nil\n p.release(data,\"frog_fru_sky_prey\")\nend\n\np.cleanup(data)\nself.used=true\n",
							name = "Initialise draw settings and clean expired guidance",
							uuid = "a6d4ac5f-a80a-a8e5-aa79-486278c2a9b7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 13.7,
				name = "[FRU] Draw settings runtime",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1800,
				timerStartOffset = -14,
				uuid = "ee516eef-9c3c-a9eb-830e-52b51dbb7a83",
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
							actionLua = "local existing=data.frog_fru_clock_wait\nif existing and existing.stage==\"opening\" then self.used=true return end\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not actor then return end\ndata.frog_fru_clock_wait={stage=\"opening\",x=actor.pos.x,y=actor.pos.y,z=actor.pos.z,radius=actor.hitradius+2,arrowDeadline=Now()+eventArgs.channelTimeMax*1000,arrowHoldAfterDeadline=true,keepVisible=true}\nself.used=true",
							conditions = 
							{
								
								{
									"9844785d-e77c-512d-91a1-ab58202aa8b6",
									true,
								},
							},
							name = "[Clocks] Opening setup",
							uuid = "43f2bc6e-f9e9-7b51-8eed-0cdeda382ee5",
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
							eventSpellID = 40148,
							name = "Cyclonic Break",
							uuid = "9844785d-e77c-512d-91a1-ab58202aa8b6",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 13.7,
				name = "[Clocks] Opening setup",
				timeRange = true,
				timelineIndex = 1,
				timerStartOffset = -8,
				uuid = "fcd11fcb-3d15-22e7-95a5-2f88eebaded6",
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
							actionLua = "local s=data.frog_fru_clock_wait\nlocal prefs=FrogFRUDrawSettings\nif not s or not prefs or not prefs.guide then return end\nlocal key=\"frog_fru_clock_wait\"\nlocal nextState=s.stage==\"opening\" and data.frog_fru_proteans or data.frog_fru_sky\nlocal ready=nextState and ((s.stage==\"opening\" and nextState.ready) or (s.stage==\"sky\" and nextState.active and nextState.tx and nextState.tz))\nif ready then prefs.release(data,key);data.frog_fru_clock_wait=nil;return end\nlocal role=data.frog_fru_role\nlocal me=TensorCore.mGetPlayer()\nif not role or not me or me.hp.current<=0 then prefs.release(data,key);return end\nif not s.angles then s.angles={T1=math.pi,T2=math.pi/2,H1=-math.pi/2,H2=0,M1=-math.pi/4,M2=math.pi/4,R1=-3*math.pi/4,R2=3*math.pi/4} end\nif (FrogFRUDrawSettings or {}).region==\"JP\" then s.angles.T2=0;s.angles.H2=math.pi/2 end\nlocal h=s.angles[role.key]\nif not h then prefs.release(data,key);return end\nlocal radius=s.radius\nlocal style=\"proteans\"\nif s.stage==\"opening\" then\n if (TensorCore.isRanged(me) or ((FrogFRUDrawSettings or {}).region==\"JP\" and role.key==\"T2\")) and data.frog_fru_open_element==\"Lightning\" then radius=math.max(radius+6,15) end\nelse\n radius=19\n if role.key==\"T2\" then h=s.angles.T1-37*math.pi/180 elseif role.key==\"R2\" then h=s.angles.T2 end\n if (me.job==23 or me.job==31 or me.job==38) and math.abs(math.sin(h))>.01 then h=h+(math.sin(h)<0 and 1 or -1)*8*math.pi/180 end\n style=\"sky\"\nend\nlocal x,z=s.x+math.sin(h)*radius,s.z+math.cos(h)*radius\nif s.stage==\"opening\" then\n if not s.tx then s.tx=x;s.tz=z end\n x,z=s.tx,s.tz;s.keepVisible=true\nend\nprefs.guide(data,key,style,s,me,x,s.y+.07,z,\"Clock spot\",nil,8)\nself.used=true",
							name = "[Clocks] Setup guidance",
							uuid = "a785f38f-19d1-8e54-aa5f-04959d2647a5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 13.7,
				name = "[Clocks] Setup guidance",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 36.3,
				timerStartOffset = -13.7,
				uuid = "17649a8c-1c77-0a20-afe2-e94aa66725dc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Intermission",
				uuid = "0b4beed3-4395-94f6-af50-2d2910739ca1",
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
							actionLua = "local old=eventArgs.oldData\nlocal s=old and old.frog_fru_intermission\nif s and s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\nif old and FrogFRUDrawSettings and FrogFRUDrawSettings.release then FrogFRUDrawSettings.release(old,\"frog_fru_intermission_crystal\")end\nself.used=true",
							name = "Clear knockback arrow",
							uuid = "cedd51b6-a13e-76cd-a038-75ebd73125a9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Intermission",
				eventType = 9,
				mechanicTime = 13.7,
				name = "[Intermission] Clear knockback arrow",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1900,
				timerStartOffset = -30,
				uuid = "b7172da2-8898-8e46-927d-8148fcc52093",
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
							actionLua = "local request=FrogFRUTowerKBRequest\nif request then _G[request.var]=request.previous;FrogFRUTowerKBRequest=nil end\nself.used=true",
							name = "Restore KB request",
							uuid = "89507d2b-566e-876d-8bd8-274055a85ff6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 9,
				mechanicTime = 13.7,
				name = "[Towers] Clear movement wipe",
				timelineIndex = 1,
				uuid = "815fa5b3-da14-3e84-88d6-5ab8b22ef4c1",
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
							actionLua = "local request=FrogFRUTowerKBRequest\nif request then _G[request.var]=request.previous;FrogFRUTowerKBRequest=nil end\nself.used=true",
							name = "Restore KB request",
							uuid = "7c9cdbdb-1170-cd24-b44f-5cfc4d397d97",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 10,
				mechanicTime = 13.7,
				name = "[Towers] Clear movement death",
				timelineIndex = 1,
				uuid = "15d90b3f-d014-afc0-a22f-aead63e0e2c7",
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
							actionLua = "local request=FrogFRUTowerKBRequest\nif request then _G[request.var]=request.previous;FrogFRUTowerKBRequest=nil end\nself.used=true",
							name = "Restore KB request",
							uuid = "78be9776-5509-3304-8963-3a203753303e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 11,
				mechanicTime = 13.7,
				name = "[Towers] Clear movement mapchange",
				timelineIndex = 1,
				uuid = "2365ab45-7d45-d468-befc-455f1f1a9fa8",
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
							actionLua = "local e=eventArgs\nif not e.channelTimeMax or e.channelTimeMax<=0 then self.used=true;return end\nlocal now=Now()\nlocal times=data.frog_fru_arrow_casts\nif not times then times={};data.frog_fru_arrow_casts=times end\nlocal deadline=now+e.channelTimeMax*1000\nlocal old=times[e.spellID]\nif old and math.abs(old.at-now)<250 then deadline=math.min(old.deadline,deadline) end\ntimes[e.spellID]={at=now,deadline=deadline}\nif e.spellID==40299 then\n local s=data.frog_fru_ct\n local actor=TensorCore.mGetEntity(e.entityID)\n if s and actor and actor.pos then\n  s.floorAoes=s.floorAoes or {}\n  s.floorAoes[e.entityID]={x=actor.pos.x,z=actor.pos.z,untilAt=now+e.channelTimeMax*1000+400}\n  s.nextPoll=0\n end\n if s and s.finished and (s.maelstromCount or 0)<2 then\n  s.firstMaelstromDeadline=s.firstMaelstromDeadline and math.min(s.firstMaelstromDeadline,deadline) or deadline\n  s.nextPoll=0\n end\nend\nif e.spellID==40137 or e.spellID==40140 then\n local s=data.frog_fru_faith\n local actor=TensorCore.mGetEntity(e.entityID)\n if s and s.active and actor and actor.pos then\n  local index\n  if e.entityContentID==9707 then index=1;s.selectionDeadline=now+8200\n  elseif actor.pos.z<90 then index=actor.pos.x<95 and 2 or actor.pos.x>105 and 4 or 3 end\n  if index then s.liftDeadlines=s.liftDeadlines or {};s.liftDeadlines[index]=deadline+1000 end\n end\nend\nif e.spellID==40219 then\n local s=data.frog_fru_lr_end\n local orb=s and s.orbs[e.entityID]\n if orb then\n  s.orbDeadlines=s.orbDeadlines or {}\n  local previous=s.orbDeadlines[orb.wave]\n  s.orbDeadlines[orb.wave]=previous and math.min(previous,deadline) or deadline\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"efd26863-a834-3b1a-8a6b-22ebce4909e7",
									true,
								},
							},
							name = "Read mechanic deadlines",
							uuid = "1a610f6c-ca5e-a27c-a375-ee65f5589a96",
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
							name = "Guidance casts",
							spellIDList = 
							{
								40158,
								40129,
								40133,
								40122,
								40123,
								40124,
								40125,
								40126,
								40127,
								40131,
								40135,
								40202,
								40203,
								40200,
								40201,
								40193,
								40194,
								40219,
								40220,
								40221,
								40189,
								40291,
								40286,
								40288,
								40273,
								40181,
								40237,
								40239,
								40187,
								40227,
								40228,
								40283,
								40249,
								40304,
								40310,
								40313,
								40233,
								40316,
								40234,
								40212,
								40330,
								40164,
								40162,
								40137,
								40140,
								40161,
								40298,
								40299,
							},
							uuid = "efd26863-a834-3b1a-8a6b-22ebce4909e7",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 13.7,
				name = "[Draws] Cast deadlines",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1800,
				timerStartOffset = -14,
				uuid = "efd0f6e5-2800-ce8c-b302-690b6490aaba",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Diamond Dust",
				uuid = "1364cbc9-227b-60ae-b8f8-803208d02968",
			},
			objectType = "folder",
		},
	},
	
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
							actionLua = "\nlocal me=TensorCore.mGetPlayer()\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not me or not actor then return end\nlocal s=data.frog_fru_proteans\nif not s then\n local boss=TensorCore.getEntityByGroup(\"ContentID\",{contentid=9707,subgroup=\"Nearest\"})\n if not boss then return end\n s={angles={},count=0,x=actor.pos.x,y=actor.pos.y,z=actor.pos.z,\n    radius=boss.hitradius+(TensorCore.isMelee(me) and .5 or 2),origin=math.atan2(me.pos.x-actor.pos.x,me.pos.z-actor.pos.z),step=0}\n s.direction=TensorCore.isDPS(me) and -1 or 1\n if (FrogFRUDrawSettings or {}).region==\"JP\" and data.frog_fru_open_element==\"Lightning\" then s.direction=-1 end\n if (TensorCore.isRanged(me) or ((FrogFRUDrawSettings or {}).region==\"JP\" and data.frog_fru_role and data.frog_fru_role.key==\"T2\")) and data.frog_fru_open_element==\"Lightning\" then\n  s.radius=math.max(s.radius+6,15)\n end\n data.frog_fru_proteans=s\nend\nif not s.angles[eventArgs.entityID] then s.count=s.count+1 end\ns.angles[eventArgs.entityID]=eventArgs.heading\nif s.count>=8 and not s.ready then\n local nearest,best=math.huge,nil\n for id,h in pairs(s.angles) do\n  local diff=math.abs((h-s.origin+math.pi)%(2*math.pi)-math.pi)\n  if diff<nearest then nearest=diff; best=id end\n end\n s.actorID=best; s.base=s.angles[best]\n local gap=2*math.pi\n for id,h in pairs(s.angles) do\n  local d=((h-s.base)*s.direction)%(2*math.pi)\n  if id~=best and d<gap then gap=d end\n end\n s.dodge=s.base+s.direction*gap/2\n s.tx=s.x+math.sin(s.dodge)*s.radius\n s.tz=s.z+math.cos(s.dodge)*s.radius\n s.ready=true; s.active=true;s.arrowDeadline=Now()+2050;s.arrowHoldAfterDeadline=true;s.keepVisible=true\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"682f53ee-27c3-76f7-9f89-1852f9221712",
									true,
								},
							},
							name = "Protean Capture",
							uuid = "429be2ff-649d-7861-b42b-7db1f248a3e2",
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
							eventSpellID = 40145,
							name = "Initial cleaves",
							uuid = "682f53ee-27c3-76f7-9f89-1852f9221712",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 14.4,
				name = "[Draw] Protean Capture",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 1.1,
				timerStartOffset = -0.9,
				uuid = "5c50d986-4cb8-fc87-9f48-bcde9ad1be04",
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
							actionLua = "\nlocal s=data.frog_fru_proteans\ns.step=s.step+1\nif s.step>=3 then s.active=false\n local prefs=FrogFRUDrawSettings;if prefs and prefs.release then prefs.release(data,\"frog_fru_proteans\") end\nelse\n s.arrowDeadline=Now()+2050\n local h=s.step==1 and s.base or s.dodge\n s.tx=s.x+math.sin(h)*s.radius\n s.tz=s.z+math.cos(h)*s.radius\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"d29fb9a7-29d8-d4df-827d-f4519930c3f9",
									true,
								},
								
								{
									"2e5486aa-70af-33ae-ad65-8cb937cd1e37",
									true,
								},
							},
							name = "Protean Steps",
							uuid = "0b696463-460d-f9d2-a065-acf36a28708f",
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
							eventSpellID = 40146,
							name = "Repeated cleaves",
							uuid = "d29fb9a7-29d8-d4df-827d-f4519930c3f9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "local s=data.frog_fru_proteans\nreturn (s~=nil and s.ready==true and s.active==true and eventArgs.entityID==s.actorID)",
							dequeueIfLuaFalse = true,
							name = "Assigned cleave",
							uuid = "2e5486aa-70af-33ae-ad65-8cb937cd1e37",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 14.4,
				name = "[Draw] Protean Steps",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 7.1,
				timerStartOffset = 0.6,
				uuid = "b3818014-f0c5-2799-b236-db22006dea90",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_proteans\nlocal player=TensorCore.mGetPlayer()\nif not prefs or not prefs.guide then self.used=true return end\nif not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then prefs.release(data,\"frog_fru_proteans\");self.used=true return end\nlocal style=\"proteans\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_proteans\");self.used=true return end\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\nprefs.guide(data,\"frog_fru_proteans\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Proteans",
							uuid = "2823ce9e-ede9-88a9-9a2f-dcd320d6bd1a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 14.4,
				name = "[Draw] Proteans",
				timeRange = true,
				timelineIndex = 2,
				timerEndOffset = 7.1,
				timerStartOffset = -0.4,
				uuid = "af1302b7-05c2-6ef6-80a8-e13b257184fd",
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
							actionLua = "local s=data.frog_fru_sky if not s then s={axes={},count=0,y=0}; data.frog_fru_sky=s end s.element=\"Lightning\" self.used=true",
							conditions = 
							{
								
								{
									"e008cb7c-a624-cefd-8d42-64ae56705c8d",
									true,
								},
								
								{
									"89f34d79-f3bc-f371-9dad-4724cdd46b29",
									true,
								},
							},
							name = "Sky Lightning",
							uuid = "433240e3-7547-78b3-af8b-a6de046d4b08",
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
							eventIntValue = 2267,
							name = "Lightning",
							uuid = "e008cb7c-a624-cefd-8d42-64ae56705c8d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventArgType = 3,
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "89f34d79-f3bc-f371-9dad-4724cdd46b29",
							version = 3,
						},
					},
				},
				eventType = 27,
				mechanicTime = 34.9,
				name = "[Draw] Sky Lightning",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 1.1,
				timerStartOffset = -5.9,
				uuid = "ec1950c3-1f24-6d89-9ac0-a368d6c2377c",
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
							actionLua = "local s=data.frog_fru_sky if not s then s={axes={},count=0,y=0}; data.frog_fru_sky=s end s.element=\"Fire\" self.used=true",
							conditions = 
							{
								
								{
									"7da11d4b-2c5f-e295-b2aa-b9340a9c715c",
									true,
								},
								
								{
									"ba8a6ef3-aa3b-3236-9cbd-2310065a0154",
									true,
								},
							},
							name = "Sky Fire",
							uuid = "bfa6191e-2db0-1476-a387-f341a417e37c",
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
							eventIntValue = 2268,
							name = "Fire",
							uuid = "7da11d4b-2c5f-e295-b2aa-b9340a9c715c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventArgType = 3,
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "ba8a6ef3-aa3b-3236-9cbd-2310065a0154",
							version = 3,
						},
					},
				},
				eventType = 27,
				mechanicTime = 34.9,
				name = "[Draw] Sky Fire",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 1.1,
				timerStartOffset = -5.9,
				uuid = "89f6c22c-09b8-65f2-a921-52709e3d99f1",
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
							actionLua = "\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not actor then return end\nlocal s=data.frog_fru_sky\nif not s then s={axes={},count=0,y=0}; data.frog_fru_sky=s end\nlocal h=math.atan2(actor.pos.x-100,actor.pos.z-100)\nlocal axis=math.floor(h/(math.pi/4)+0.5)%4\nif not s.axes[axis] then s.axes[axis]=true; s.count=s.count+1 end\nself.used=true\n",
							conditions = 
							{
								
								{
									"af4fbf9d-75f4-45d2-87d3-e69c3d22ebb2",
									true,
								},
								
								{
									"0b706f9f-21d3-ab8b-ae86-ce1fc4e69ab7",
									true,
								},
							},
							name = "Sky Capture",
							uuid = "63b72030-c9a7-2461-87f5-9edbb0d951b7",
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
							eventArgType = 4,
							eventIntValue = 210,
							name = "Gunblade raised",
							uuid = "af4fbf9d-75f4-45d2-87d3-e69c3d22ebb2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9708,
							name = "Image",
							uuid = "0b706f9f-21d3-ab8b-ae86-ce1fc4e69ab7",
							version = 3,
						},
					},
				},
				eventType = 23,
				loop = true,
				mechanicTime = 34.9,
				name = "[Draw] Sky Capture",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 8.1,
				timerStartOffset = 3.1,
				uuid = "d8aafb48-6c74-91ae-b395-d9ec4f25446a",
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
							actionLua = "\nlocal s=data.frog_fru_sky\nlocal role=data.frog_fru_role\nif not s or not role or not s.element or s.count~=3 then return end\nlocal axis\nfor i=0,3 do if not s.axes[i] then axis=i; break end end\nif not axis then return end\nlocal h=axis*math.pi/4\nlocal nearest,bestID,activeCount=math.huge,nil,0\nfor i=1,8 do\n local x,y,z,active=Argus.getWaymarkInfo(i)\n if active then\n  activeCount=activeCount+1\n  local mh=math.atan2(x-100,z-100)\n  local d=math.abs((mh-h+math.pi)%(2*math.pi)-math.pi)\n  if d<nearest then nearest=d; bestID=i end\n end\nend\n\n\nlocal group1=false\nif activeCount>0 then\n if not bestID or nearest>math.pi/16 then return end\n group1=bestID==1 or bestID==4 or bestID==5 or bestID==8\nend\nif (role.group==1)~=group1 then h=h+math.pi end\nlocal radial,lateral=14,0\nif s.element==\"Lightning\" then\n local kind=role.key:sub(1,1)\n local region=(FrogFRUDrawSettings or {}).region\n local tanksOuter=region==\"EU\" or region==\"JP\"\n if kind==\"T\" then radial=tanksOuter and 19.3 or 12.5\n elseif kind==\"H\" then radial=tanksOuter and 12.5 or 19.3\n elseif kind==\"M\" then radial=18; lateral=6\n elseif kind==\"R\" then radial=18; lateral=-6\n else return end\nend\n\n\ns.tx=100+math.sin(h)*radial-math.cos(h)*lateral\ns.tz=100+math.cos(h)*radial+math.sin(h)*lateral\ns.active=true\nself.used=true\n",
							name = "Sky Position",
							uuid = "b98ffd11-ae2d-c459-9211-e5b071860a8b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 34.9,
				name = "[Draw] Sky Position",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 14.9,
				timerStartOffset = 4.1,
				uuid = "50547c38-d948-c2ce-af35-41e8d863813b",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_sky\nlocal player=TensorCore.mGetPlayer()\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then if prefs and prefs.release then prefs.release(data,\"frog_fru_sky\") end;self.used=true return end\nlocal style=\"sky\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_sky\");self.used=true return end\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\ns.keepVisible=true;s.arrowHoldAfterDeadline=true\ns.arrowDeadline=prefs.castDeadline and prefs.castDeadline(data,s,{40158}) or nil\nprefs.guide(data,\"frog_fru_sky\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Utopian Sky",
							uuid = "06feb2a3-0498-ed5a-8ebb-3e6da2a16377",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 34.9,
				name = "[Draw] Utopian Sky",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 15.3,
				timerStartOffset = 4.1,
				uuid = "c3482533-307f-6794-9733-6c24296101bf",
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
							actionLua = "data.frog_fru_clock_wait={stage=\"sky\",x=100,y=0,z=100,arrowDeadline=Now()+5200,arrowHoldAfterDeadline=true,keepVisible=true}\nself.used=true",
							conditions = 
							{
								
								{
									"ae10297c-250b-5d39-a311-9d521ae88d3c",
									true,
								},
								
								{
									"0b074ef3-5f25-c17c-ac79-34d1113d231a",
									true,
								},
							},
							name = "[Clocks] Boss jump setup",
							uuid = "5c8aac3d-7318-debf-a0bb-362b20077816",
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
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "ae10297c-250b-5d39-a311-9d521ae88d3c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							eventBoolValue = 2,
							name = "Untargetable",
							uuid = "0b074ef3-5f25-c17c-ac79-34d1113d231a",
							version = 3,
						},
					},
				},
				eventType = 26,
				loop = true,
				mechanicTime = 34.9,
				name = "[Clocks] Boss jump setup",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = 3,
				timerStartOffset = -1,
				uuid = "4258e2be-9072-e78c-90cd-011e6e61af92",
				version = 2,
			},
		},
	},
	[12] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P1 Utopian Sky",
				uuid = "b6753814-873f-a09a-88d2-b91442eeb7e7",
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
							actionLua = "data.frog_fru_sky_cyclonic_element=\"Fire\"\nself.used=true",
							conditions = 
							{
								
								{
									"a5ba38cc-6ca6-a791-b979-6229575f7fd7",
									true,
								},
							},
							name = "Cyclonic Fire",
							uuid = "06bc0db8-fdcf-d5c6-ad32-e5e5854a89fb",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "data.frog_fru_sky_cyclonic_element=\"Lightning\"\nself.used=true",
							conditions = 
							{
								
								{
									"0f01d520-372a-0900-ba32-388ef7de2544",
									true,
								},
							},
							name = "Cyclonic Lightning",
							uuid = "e46d0691-eaa7-d0e3-b4d3-1ece46681dea",
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
							eventSpellID = 40329,
							name = "fire",
							uuid = "a5ba38cc-6ca6-a791-b979-6229575f7fd7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40330,
							name = "thunder",
							uuid = "0f01d520-372a-0900-ba32-388ef7de2544",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 3,
				loop = true,
				mechanicTime = 50,
				name = "[Sky Cleaves] Read Cyclonic element",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 1,
				timerStartOffset = -2,
				uuid = "6e186369-5bc6-a14e-b583-32e75a2b5791",
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
							actionLua = "local role=data.frog_fru_role\nlocal me=TensorCore.mGetPlayer()\nif not role or not me then self.used=true return end\nlocal s=data.frog_fru_sky_cleaves\nif s and Now()-s.start<2000 then self.used=true return end\nlocal angles={T1=math.pi,T2=math.pi/2,H1=-math.pi/2,H2=0,M1=-math.pi/4,M2=math.pi/4,R1=-3*math.pi/4,R2=3*math.pi/4}\nif (FrogFRUDrawSettings or {}).region==\"JP\" then angles.T2=0;angles.H2=math.pi/2 end\nlocal h=angles[role.key];if not h then self.used=true return end\nlocal ranged=role.key:sub(1,1)==\"H\" or role.key:sub(1,1)==\"R\"\nif (FrogFRUDrawSettings or {}).region==\"JP\" and data.frog_fru_sky_cyclonic_element==\"Lightning\" and role.key==\"T2\" then ranged=true end\nlocal s={start=Now(),angles={},count=0,origin=h,step=0,x=100,y=0,z=100,ranged=ranged,\n element=data.frog_fru_sky_cyclonic_element,direction=(role.key:sub(1,1)==\"T\" or role.key:sub(1,1)==\"H\")and 1 or -1,active=true}\nif (FrogFRUDrawSettings or {}).region==\"JP\" and s.element==\"Lightning\" then s.direction=-1 end\nlocal prefs=FrogFRUDrawSettings or {}\nlocal groups=prefs.skyStackGroups or (prefs.region==\"EU\" and \"Light parties\" or \"Roles\")\nlocal north\nif groups==\"Light parties\" then north=role.key:sub(2)==\"1\"\nelse north=role.key:sub(1,1)==\"T\" or role.key:sub(1,1)==\"H\" end\ns.exitH=north and math.pi or 0\ns.radius=ranged and 15 or 8\ns.tx=100+math.sin(h)*s.radius;s.tz=100+math.cos(h)*s.radius\nlocal cast=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40330]\nif cast and cast.at>=s.start-2500 then s.arrowDeadline=cast.deadline+800 end\ns.arrowHoldAfterDeadline=true;s.keepVisible=true\ndata.frog_fru_sky_cleaves=s\nif data.frog_fru_sky then data.frog_fru_sky.active=false end\nself.used=true",
							conditions = 
							{
								
								{
									"17323722-84cc-74b3-8e2b-2f80a6610b9e",
									true,
								},
							},
							name = "Post-Fire cleave clocks",
							uuid = "b80cea2e-2010-df35-8517-7fca3d2118d6",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local role=data.frog_fru_role\nlocal me=TensorCore.mGetPlayer()\nif not role or not me then self.used=true return end\nlocal s=data.frog_fru_sky_cleaves\nif s and Now()-s.start<2000 then self.used=true return end\nlocal angles={T1=math.pi,T2=math.pi/2,H1=-math.pi/2,H2=0,M1=-math.pi/4,M2=math.pi/4,R1=-3*math.pi/4,R2=3*math.pi/4}\nif (FrogFRUDrawSettings or {}).region==\"JP\" then angles.T2=0;angles.H2=math.pi/2 end\nlocal h=angles[role.key];if not h then self.used=true return end\nlocal ranged=role.key:sub(1,1)==\"H\" or role.key:sub(1,1)==\"R\"\nif (FrogFRUDrawSettings or {}).region==\"JP\" and data.frog_fru_sky_cyclonic_element==\"Lightning\" and role.key==\"T2\" then ranged=true end\nlocal s={start=Now(),angles={},count=0,origin=h,step=0,x=100,y=0,z=100,ranged=ranged,\n element=data.frog_fru_sky_cyclonic_element,direction=(role.key:sub(1,1)==\"T\" or role.key:sub(1,1)==\"H\")and 1 or -1,active=true}\nif (FrogFRUDrawSettings or {}).region==\"JP\" and s.element==\"Lightning\" then s.direction=-1 end\nlocal prefs=FrogFRUDrawSettings or {}\nlocal groups=prefs.skyStackGroups or (prefs.region==\"EU\" and \"Light parties\" or \"Roles\")\nlocal north\nif groups==\"Light parties\" then north=role.key:sub(2)==\"1\"\nelse north=role.key:sub(1,1)==\"T\" or role.key:sub(1,1)==\"H\" end\ns.exitH=north and math.pi or 0\ns.radius=ranged and 15 or 8\ns.tx=100+math.sin(h)*s.radius;s.tz=100+math.cos(h)*s.radius\nlocal cast=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40330]\nif cast and cast.at>=s.start-2500 then s.arrowDeadline=cast.deadline+800 end\ns.arrowHoldAfterDeadline=true;s.keepVisible=true\ndata.frog_fru_sky_cleaves=s\nif data.frog_fru_sky then data.frog_fru_sky.active=false end\nself.used=true",
							conditions = 
							{
								
								{
									"41e67ac0-f20e-556b-9053-80010beed367",
									true,
								},
							},
							name = "Post-Thunder cleave clocks",
							uuid = "1545996b-e0b4-d596-a064-be03703f30b2",
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
							eventSpellID = 40159,
							name = "fire",
							uuid = "17323722-84cc-74b3-8e2b-2f80a6610b9e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40160,
							name = "thunder",
							uuid = "41e67ac0-f20e-556b-9053-80010beed367",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 50,
				name = "[Sky Cleaves] Return to modified clocks after stack/spread",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 3,
				timerStartOffset = -1,
				uuid = "18dca247-f421-067f-9d8a-6f00ff300a85",
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
							actionLua = "local s=data.frog_fru_sky_cleaves\nif not s or s.ready then self.used=true return end\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not actor then self.used=true return end\ns.x,s.y,s.z=actor.pos.x,actor.pos.y,actor.pos.z\nif not s.angles[eventArgs.entityID]then s.count=s.count+1 end\ns.angles[eventArgs.entityID]=eventArgs.heading\nif s.count==8 then\n local nearest,best=math.huge,nil\n for id,h in pairs(s.angles)do local diff=math.abs((h-s.origin+math.pi)%(2*math.pi)-math.pi);if diff<nearest then nearest=diff;best=id end end\n s.actorID=best;s.base=s.angles[best]\n local gap=2*math.pi\n for id,h in pairs(s.angles)do local d=((h-s.base)*s.direction)%(2*math.pi);if id~=best and d<gap then gap=d end end\n s.dodge=s.base+s.direction*gap/2\n s.radius=s.element==\"Fire\" and 8 or (s.ranged and 15 or 8)\n s.tx=s.x+math.sin(s.dodge)*s.radius;s.tz=s.z+math.cos(s.dodge)*s.radius\n s.currentH=s.dodge\n s.arrowDeadline=Now()+2000\n s.ready=true\nend\nself.used=true",
							conditions = 
							{
								
								{
									"5b567a6b-7581-d32a-9af7-c899ba566124",
									true,
								},
							},
							name = "Resolve cleave dodge and pair/spread",
							uuid = "876092d6-d4a3-29be-899d-67185a2207aa",
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
							eventSpellID = 40145,
							name = "first",
							uuid = "5b567a6b-7581-d32a-9af7-c899ba566124",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 50,
				name = "[Sky Cleaves] Capture first cleave directions",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 8,
				timerStartOffset = 4,
				uuid = "cee0bf76-3ff7-e21a-879c-33a4a893be29",
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
							actionLua = "local s=data.frog_fru_sky_cleaves\nif not s or not s.ready or not s.active or s.angles[eventArgs.entityID]==nil then self.used=true return end\nif not s.repeatCounts then s.repeatCounts={};s.repeatTimes={};s.finalActors={} end\nlocal id=eventArgs.entityID\nlocal now=Now()\nif s.repeatTimes[id] and now-s.repeatTimes[id]<500 then self.used=true return end\ns.repeatTimes[id]=now\nlocal wave=(s.repeatCounts[id] or 0)+1\ns.repeatCounts[id]=wave\n\n\nif wave==3 and not s.finalActors[id] then\n s.finalActors[id]=true;s.finalCount=(s.finalCount or 0)+1\nend\nlocal h=nil\nif id==s.actorID and wave<3 then\n s.step=wave;s.arrowDeadline=now+2000\n local best,bestRemaining,bestMove=nil,math.huge,math.huge\n for _,angle in pairs(s.angles)do\n  local candidate=angle\n  if wave==2 then\n   \n   local gap=2*math.pi\n   for _,other in pairs(s.angles)do\n    local delta=(other-angle)%(2*math.pi)\n    if delta>0.001 and delta<gap then gap=delta end\n   end\n   candidate=angle+gap/2\n  end\n  local move=math.abs((candidate-s.currentH+math.pi)%(2*math.pi)-math.pi)\n  local remaining=math.abs((candidate-s.exitH+math.pi)%(2*math.pi)-math.pi)\n  if move<=math.pi/4+0.05 and (remaining<bestRemaining-0.001 or (math.abs(remaining-bestRemaining)<=0.001 and move<bestMove))then\n   best=candidate;bestRemaining=remaining;bestMove=move\n  end\n end\n h=best\nelseif (s.finalCount or 0)>=8 and not s.exitReady then\n s.step=3;s.exitReady=true;h=s.exitH\n local cast=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40164];s.arrowDeadline=cast and cast.deadline\nend\nif h then\n \n \n local radius=(s.exitReady or s.step>=1) and math.max(s.radius,14) or s.radius\n s.currentH=h;s.tx=s.x+math.sin(h)*radius;s.tz=s.z+math.cos(h)*radius\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"9dfc4c0b-3aec-5bef-b9ae-e32fc85ceebd",
									true,
								},
							},
							name = "Final gap dodge before N/S exit",
							uuid = "67b95877-0895-27f3-b1c0-05dd83ec3aa3",
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
							eventSpellID = 40146,
							name = "repeat",
							uuid = "9dfc4c0b-3aec-5bef-b9ae-e32fc85ceebd",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 50,
				name = "[Sky Cleaves] Track four cleaves then N/S exit",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 14,
				timerStartOffset = 7,
				uuid = "d47fde49-0bfb-1bc3-8a5c-58c6355e69af",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_sky_cleaves\nlocal player=TensorCore.mGetPlayer()\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>17000 then if prefs and prefs.release then prefs.release(data,\"frog_fru_sky_cleaves\") end;self.used=true return end\nlocal style=\"skyCleaves\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_sky_cleaves\");self.used=true return end\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\nprefs.guide(data,\"frog_fru_sky_cleaves\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw Utopian cleave destination",
							uuid = "8b895210-9a78-c337-9b7f-f24b7b069173",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 12,
				loop = true,
				mechanicTime = 50,
				name = "[Sky Cleaves] Clock and cleave tether",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 16.200000762939,
				timerStartOffset = -1,
				uuid = "db14f2a0-bb85-8946-b2c0-15d55018d5c4",
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
							actionLua = "data.frog_fru_sky_cleaves=nil\ndata.frog_fru_sky_cyclonic_element=nil\nlocal prefs=FrogFRUDrawSettings\nfor _,key in ipairs({\"frog_fru_proteans\",\"frog_fru_sky\",\"frog_fru_clock_wait\",\"frog_fru_faith\",\"frog_fru_towers\",\"frog_fru_sky_cleaves\",\"frog_fru_sky_prey\"})do\n if prefs and prefs.release then prefs.release(data,key) end\n data[key]=nil\nend\nself.used=true",
							name = "Reset Sky cleave state",
							uuid = "3b078268-c425-31f6-b86e-404a57d0040c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 9,
				mechanicTime = 50,
				name = "[Sky Cleaves] Reset wipe",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 1800,
				timerStartOffset = -51,
				uuid = "62f55e2a-e460-2ab8-9713-4fa7b90386e6",
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
							actionLua = "data.frog_fru_sky_cleaves=nil\ndata.frog_fru_sky_cyclonic_element=nil\nlocal prefs=FrogFRUDrawSettings\nfor _,key in ipairs({\"frog_fru_proteans\",\"frog_fru_sky\",\"frog_fru_clock_wait\",\"frog_fru_faith\",\"frog_fru_towers\",\"frog_fru_sky_cleaves\",\"frog_fru_sky_prey\"})do\n if prefs and prefs.release then prefs.release(data,key) end\n data[key]=nil\nend\nself.used=true",
							name = "Reset Sky cleave state",
							uuid = "bab1c075-3157-7073-b58f-c2b3ba531893",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 16,
				mechanicTime = 50,
				name = "[Sky Cleaves] Reset countdown",
				timeRange = true,
				timelineIndex = 12,
				timerEndOffset = 1800,
				timerStartOffset = -51,
				uuid = "377be9a4-d495-47ae-898f-1b5f37b84ab8",
				version = 2,
			},
		},
	},
	[19] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P1 Utopian Sky",
				uuid = "1d9a88a1-8b83-8f90-8a2d-25954ac31189",
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
							actionLua = "data.frog_fru_sky_kb={kbAt=Now()+2000}\nself.used=true",
							conditions = 
							{
								
								{
									"2801adcc-1a24-9ed9-960d-bfe55429f976",
									true,
								},
							},
							name = "Schedule Blastburn cancel",
							uuid = "4d796c8b-bc1a-397d-95df-456765c42ecb",
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
							eventSpellID = 40161,
							name = "fire",
							uuid = "2801adcc-1a24-9ed9-960d-bfe55429f976",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 72.5,
				name = "[Sky KB] Time Fire knockback from Burnt Strike",
				timeRange = true,
				timelineIndex = 19,
				timerStartOffset = -3,
				uuid = "73f66cc9-3e25-ee5c-96c1-4f808d052a6c",
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
							actionLua = "local s=data.frog_fru_sky_kb\nlocal request=FrogFRUSkyKBRequest\nlocal now=Now()\nlocal p=TensorCore.mGetPlayer()\nlocal prefs=FrogFRUDrawSettings or {}\nif request and (not s or not p or p.hp.current<=0 or p.job~=request.job or prefs.skyKB==false or now>=request.expires)then\n _G[request.var]=request.previous;FrogFRUSkyKBRequest=nil\nend\nif not s or not p or p.hp.current<=0 or prefs.skyKB==false or s.resolved or s.requested or now<s.kbAt-500 or now>=s.kbAt then self.used=true return end\n\nlocal selected=prefs.skyKBCancel and prefs.skyKBCancel(p)\nif selected then\n s.requested=true\n if _G[selected.var]~=true then\n  FrogFRUSkyKBRequest={var=selected.var,previous=_G[selected.var],job=p.job,expires=s.kbAt+1500}\n  _G[selected.var]=true\n end\nend\nself.used=true\n",
							name = "Queue current-job movement KB Cancel",
							uuid = "720349b9-e913-87b4-94d4-5e7895bfa93f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				loop = true,
				mechanicTime = 72.5,
				name = "[Sky KB] Queue non-enemy movement cancel",
				throttleTime = 50,
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 4,
				timerStartOffset = -3,
				uuid = "7808b643-7df5-5144-b428-c648ba7da47b",
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
							actionLua = "local s=data.frog_fru_sky_kb\nif s then s.resolved=true end\nself.used=true",
							conditions = 
							{
								
								{
									"b9c89fcd-9373-9c89-bc8e-812e105b5331",
									true,
								},
							},
							name = "Mark knockback resolved",
							uuid = "5d46e73a-53a2-411a-b08e-2bcddf642e6a",
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
							eventSpellID = 40162,
							name = "blast",
							uuid = "b9c89fcd-9373-9c89-bc8e-812e105b5331",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 72.5,
				name = "[Sky KB] Record Blastburn resolution",
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 4,
				timerStartOffset = -3,
				uuid = "abbcec44-5700-db99-926e-c5a9ce690034",
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
							actionLua = "local r=FrogFRUSkyKBRequest\nif r then _G[r.var]=r.previous;FrogFRUSkyKBRequest=nil end\ndata.frog_fru_sky_kb=nil\nself.used=true",
							name = "Clear Sky KB request",
							uuid = "2eac3af7-d361-7cc0-82a8-9e583693e1a9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 9,
				mechanicTime = 72.5,
				name = "[Sky KB] Clear owned request - wipe",
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 1800,
				timerStartOffset = -73,
				uuid = "ddd93d5d-edf7-1069-a1c9-dc191c577e24",
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
							actionLua = "local r=FrogFRUSkyKBRequest\nif r then _G[r.var]=r.previous;FrogFRUSkyKBRequest=nil end\ndata.frog_fru_sky_kb=nil\nself.used=true",
							name = "Clear Sky KB request",
							uuid = "7308128c-9e6c-ca76-a97c-2d7e62aa36c7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 16,
				mechanicTime = 72.5,
				name = "[Sky KB] Clear owned request - countdown",
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 1800,
				timerStartOffset = -73,
				uuid = "8489af8e-ed41-0533-a77f-9929e64ac799",
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
							actionLua = "local r=FrogFRUSkyKBRequest\nif r then _G[r.var]=r.previous;FrogFRUSkyKBRequest=nil end\ndata.frog_fru_sky_kb=nil\nself.used=true",
							name = "Clear Sky KB request",
							uuid = "1b6392df-b4f6-0fdf-aa0c-93bbfa8c011d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 11,
				mechanicTime = 72.5,
				name = "[Sky KB] Clear owned request - map",
				timeRange = true,
				timelineIndex = 19,
				timerEndOffset = 1800,
				timerStartOffset = -73,
				uuid = "487ac274-4b5e-af2a-801f-56b489b141f7",
				version = 2,
			},
		},
	},
	[20] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P1 Utopian Sky",
				uuid = "9db398c1-4891-3e82-aedd-927fa8bfcdb1",
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
							actionLua = "local actor=TensorCore.mGetEntity(eventArgs.primaryEntityID)\nif not actor then self.used=true return end\nlocal dx,dz=actor.pos.x-100,actor.pos.z-100\nif dx*dx+dz*dz<4 or dx*dx+dz*dz>144 then self.used=true return end\nlocal s={start=Now(),records={},sources={},nextPoll=0,safeContentID=9711}\ndata.frog_fru_sky_prey=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members();local party=AnyoneCore.API.getAgnosticPartyList();local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\"then return false end\n local records,used={},{}\n for _,key in ipairs(s.keys)do\n  local m=members[key];if not m or not m.name or not m.job then return false end\n  local a,count=nil,0\n  for _,p in pairs(party)do if p.name==m.name and p.job==m.job then a=p;count=count+1 end end\n  if count==0 then\n   local copies=0;for _,v in pairs(members)do if v.job==m.job then copies=copies+1 end end\n   if copies==1 then for _,p in pairs(party)do if p.job==m.job then a=p;count=count+1 end end end\n  end\n  if count~=1 or used[a.id]then return false end\n  used[a.id]=true;records[key]={id=a.id}\n  if a.id==me.id then s.myRole=key end\n end\n if not s.myRole then return false end\n s.records=records;s.rosterReady=true;return true\nend\nfunction s.assign()\n local prefs=FrogFRUDrawSettings\n return prefs and prefs.assignSkyStacks and prefs.assignSkyStacks(s) or false\nend\nfunction s.poll()\n local now=Now();if now<s.nextPoll then return end\n s.nextPoll=now+100;s.destination=nil\n local p=TensorCore.mGetPlayer();local prefs=FrogFRUDrawSettings or {}\n if not p or p.hp.current<=0 or s.done or now-s.start>25000 or prefs.skyStacks==false then return end\n if not s.rosterReady then s.capture()end\n if not s.ready or s.dirty then if not s.assign()then return end end\n if not s.allow then return end\n if not s.guidanceTakenOver then\n  local previous=data.frog_fru_sky_cleaves\n  if previous then previous.active=false end\n  if prefs.release then prefs.release(data,\"frog_fru_sky_cleaves\") end\n  s.guidanceTakenOver=true\n end\n local r=s.records[s.myRole];if not r then return end\n local targetID=r.north and s.northTarget or s.southTarget\n if s.kbDone and (targetID==p.id or not s.lifted or not s.lifted[targetID]) then return end\n if not s.kbDone then\n  local aoeSide=(s.safeSide==-1 and not r.north) or (s.safeSide==1 and r.north)\n  local cancel=aoeSide and prefs.skyKBCancel and prefs.skyKBCancel(p)\n  local offset=cancel and 4 or 5.5\n  s.destination={x=s.midDone and 100 or 100+s.safeSide*8,y=0.07,z=100+(r.north and -offset or offset),label=r.north and \"North KB spot\" or \"South KB spot\"}\n else\n  local target=TensorCore.mGetEntity(targetID)\n  if not target or target.hp.current<=0 then return end\n  s.destination={x=target.pos.x,y=target.pos.y+0.07,z=target.pos.z,label=(r.flex and \"Flex: \" or \"\")..(r.north and \"North Prey stack\" or \"South Prey stack\")}\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"ba3d8bc5-507f-6c39-8ce2-707e3b2ea257",
									true,
								},
								
								{
									"b943ebc6-2ff4-f9b9-bad2-645eee1557f4",
									true,
								},
							},
							name = "Fire cue: lightning circles safe",
							uuid = "60f2a8c2-fd8e-c114-a953-7af01d29b0ba",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local actor=TensorCore.mGetEntity(eventArgs.primaryEntityID)\nif not actor then self.used=true return end\nlocal dx,dz=actor.pos.x-100,actor.pos.z-100\nif dx*dx+dz*dz<4 or dx*dx+dz*dz>144 then self.used=true return end\nlocal s={start=Now(),records={},sources={},nextPoll=0,safeContentID=9710}\ndata.frog_fru_sky_prey=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members();local party=AnyoneCore.API.getAgnosticPartyList();local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\"then return false end\n local records,used={},{}\n for _,key in ipairs(s.keys)do\n  local m=members[key];if not m or not m.name or not m.job then return false end\n  local a,count=nil,0\n  for _,p in pairs(party)do if p.name==m.name and p.job==m.job then a=p;count=count+1 end end\n  if count==0 then\n   local copies=0;for _,v in pairs(members)do if v.job==m.job then copies=copies+1 end end\n   if copies==1 then for _,p in pairs(party)do if p.job==m.job then a=p;count=count+1 end end end\n  end\n  if count~=1 or used[a.id]then return false end\n  used[a.id]=true;records[key]={id=a.id}\n  if a.id==me.id then s.myRole=key end\n end\n if not s.myRole then return false end\n s.records=records;s.rosterReady=true;return true\nend\nfunction s.assign()\n local prefs=FrogFRUDrawSettings\n return prefs and prefs.assignSkyStacks and prefs.assignSkyStacks(s) or false\nend\nfunction s.poll()\n local now=Now();if now<s.nextPoll then return end\n s.nextPoll=now+100;s.destination=nil\n local p=TensorCore.mGetPlayer();local prefs=FrogFRUDrawSettings or {}\n if not p or p.hp.current<=0 or s.done or now-s.start>25000 or prefs.skyStacks==false then return end\n if not s.rosterReady then s.capture()end\n if not s.ready or s.dirty then if not s.assign()then return end end\n if not s.allow then return end\n if not s.guidanceTakenOver then\n  local previous=data.frog_fru_sky_cleaves\n  if previous then previous.active=false end\n  if prefs.release then prefs.release(data,\"frog_fru_sky_cleaves\") end\n  s.guidanceTakenOver=true\n end\n local r=s.records[s.myRole];if not r then return end\n local targetID=r.north and s.northTarget or s.southTarget\n if s.kbDone and (targetID==p.id or not s.lifted or not s.lifted[targetID]) then return end\n if not s.kbDone then\n  local aoeSide=(s.safeSide==-1 and not r.north) or (s.safeSide==1 and r.north)\n  local cancel=aoeSide and prefs.skyKBCancel and prefs.skyKBCancel(p)\n  local offset=cancel and 4 or 5.5\n  s.destination={x=s.midDone and 100 or 100+s.safeSide*8,y=0.07,z=100+(r.north and -offset or offset),label=r.north and \"North KB spot\" or \"South KB spot\"}\n else\n  local target=TensorCore.mGetEntity(targetID)\n  if not target or target.hp.current<=0 then return end\n  s.destination={x=target.pos.x,y=target.pos.y+0.07,z=target.pos.z,label=(r.flex and \"Flex: \" or \"\")..(r.north and \"North Prey stack\" or \"South Prey stack\")}\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"ba3d8bc5-507f-6c39-8ce2-707e3b2ea257",
									true,
								},
								
								{
									"e2ba29ac-efcd-2c2e-a6fb-6b46911207ad",
									true,
								},
							},
							name = "Lightning cue: fire circles safe",
							uuid = "edacc9b3-2918-d34a-b61f-9fae47da1ee9",
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
							eventArgType = 3,
							eventEntityContentID = 9708,
							name = "clone",
							uuid = "ba3d8bc5-507f-6c39-8ce2-707e3b2ea257",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventIntValue = 2268,
							name = "fire",
							uuid = "b943ebc6-2ff4-f9b9-bad2-645eee1557f4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventIntValue = 2267,
							name = "lightning",
							uuid = "e2ba29ac-efcd-2c2e-a6fb-6b46911207ad",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 27,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Read off-centre clone element",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = -17,
				timerStartOffset = -24,
				uuid = "df5058ff-c5f6-c179-8c22-240b0b626630",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s and eventArgs.entityContentID==s.safeContentID then\n local a=TensorCore.mGetEntity(eventArgs.entityID)\n if a and math.abs(a.pos.x-100)>8 then s.safeSide=a.pos.x<100 and -1 or 1;s.dirty=true;s.nextPoll=0;s.poll() end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"20913117-ce5f-35fa-95bd-0e7cb5cbae9d",
									true,
								},
							},
							name = "Record safe flame side",
							uuid = "cf6948da-3e8e-c2dc-9e61-c4cfeecd13a8",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_sky_prey\nif s and eventArgs.entityContentID==s.safeContentID then\n local a=TensorCore.mGetEntity(eventArgs.entityID)\n if a and math.abs(a.pos.x-100)>8 then s.safeSide=a.pos.x<100 and -1 or 1;s.dirty=true;s.nextPoll=0;s.poll() end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"07d08c16-54c3-a236-8ce7-0619f87b4c74",
									true,
								},
							},
							name = "Record safe lightning side",
							uuid = "f6329c90-75f5-c98a-a946-90bcdec5b8b4",
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
							eventEntityContentID = 9710,
							name = "flame",
							uuid = "20913117-ce5f-35fa-95bd-0e7cb5cbae9d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9711,
							name = "levin",
							uuid = "07d08c16-54c3-a236-8ce7-0619f87b4c74",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 5,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Read safe east/west circle side",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = -10,
				timerStartOffset = -17,
				uuid = "dca1ec23-fe9f-3d27-81fb-af37b0b01f99",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s then\n local a=TensorCore.mGetEntity(eventArgs.sourceEntityID)\n if a and a.pos.z>105 and math.abs(a.pos.x-100)>10 then\n  local side=a.pos.x<100 and -1 or 1\n  s.sources[side]={source=eventArgs.sourceEntityID,target=eventArgs.newTargetID};s.dirty=true;s.nextPoll=0;s.destination=nil\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"3d40706a-6667-dc62-85d4-aca1963b6a01",
									true,
								},
								
								{
									"96de13f9-94e8-7009-b9ac-15a6fd1903af",
									true,
								},
							},
							name = "Store short/long tether targets",
							uuid = "3c869452-4c68-ab82-9145-6ba43ee86f5e",
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
							eventEntityContentID = 9708,
							name = "clone",
							uuid = "3d40706a-6667-dc62-85d4-aca1963b6a01",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 249,
							name = "fire",
							uuid = "96de13f9-94e8-7009-b9ac-15a6fd1903af",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 15,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Record fixed SW and SE targets",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = -2,
				timerStartOffset = -16,
				uuid = "8538f301-0db5-4dc4-baab-36a207872c13",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s and not s.allow then s.allow=true;s.nextPoll=0;s.poll() end\nself.used=true",
							conditions = 
							{
								
								{
									"08fc739a-4fff-28e7-8081-2b1695f37a89",
									true,
								},
							},
							name = "Resolve line",
							uuid = "f2de66b9-3fff-4b22-b3ec-92e0d93f77ed",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_sky_prey\nif s and not s.kbDone then s.kbDone=true;s.nextPoll=0;s.poll() end\nself.used=true",
							conditions = 
							{
								
								{
									"c21e0f40-a514-5868-87ae-e3c226e72aa4",
									true,
								},
							},
							name = "Resolve kb",
							uuid = "4f70cbd1-93c8-0430-b75c-423b91a6774b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_sky_prey\nif s then for _,v in pairs(s.sources)do if v.source==eventArgs.entityID and v.target~=eventArgs.targetID then v.target=eventArgs.targetID;s.dirty=true end end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"4a7c302e-4b14-550e-a7ac-758bff6a5423",
									true,
								},
							},
							name = "Resolve lock",
							uuid = "445d61db-e923-a752-a39c-ba7a76612229",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_sky_prey\nif s then s.done=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"9116c32a-5acd-278d-941e-9538ec845577",
									true,
								},
							},
							name = "Resolve resolve",
							uuid = "c4b04c7d-dda3-2485-902c-3a0a8299fff2",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_sky_prey\nif s and not s.midDone then s.midDone=true;s.nextPoll=0;s.poll() end\nself.used=true",
							conditions = 
							{
								
								{
									"3ec17ba9-c3bf-5120-a7ff-b5683d87a338",
									true,
								},
							},
							name = "Resolve mid",
							uuid = "10d970b3-ed8c-d188-be0b-f0b3bd43e482",
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
							eventSpellID = 40164,
							name = "line",
							uuid = "08fc739a-4fff-28e7-8081-2b1695f37a89",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40162,
							name = "kb",
							uuid = "c21e0f40-a514-5868-87ae-e3c226e72aa4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40171,
							name = "lock",
							uuid = "4a7c302e-4b14-550e-a7ac-758bff6a5423",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40167,
							name = "resolve",
							uuid = "9116c32a-5acd-278d-941e-9538ec845577",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40161,
							name = "mid",
							uuid = "3ec17ba9-c3bf-5120-a7ff-b5683d87a338",
							version = 3,
						},
					},
				},
				displayPath = "P1 Utopian Sky",
				eventType = 2,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Track line, KB, lock-in and stack",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 2,
				timerStartOffset = -16,
				uuid = "849eff51-9c9f-f0fe-ad9c-e77aed7b88ab",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s then s.poll()end\nself.used=true",
							name = "Update assigned Prey destination",
							uuid = "64690697-d4e1-117f-908e-518a20862ea0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Resolve role and fixed-tether stack",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 2,
				timerStartOffset = -16,
				uuid = "ca8def41-f3b7-1247-8c94-6e771d2d453b",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_sky_prey\nlocal player=TensorCore.mGetPlayer()\nif prefs and prefs.release and s and not s.destination then prefs.release(data,\"frog_fru_sky_prey\") end\nif not prefs or not prefs.guide or not s or not s.destination or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>25000 then if prefs and prefs.release then prefs.release(data,\"frog_fru_sky_prey\") end;self.used=true return end\nlocal style=\"skyStacks\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_sky_prey\");self.used=true return end\nlocal targetID=s.records[s.myRole] and (s.records[s.myRole].north and s.northTarget or s.southTarget)\ns.keepVisible=true;s.arrowHoldAfterDeadline=s.kbDone==true\nlocal fireCast=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40161]\nlocal fireEnd=fireCast and fireCast.at>=s.start-1000 and fireCast.deadline or nil\ns.arrowDeadline=s.kbDone and s.stackDeadlines and s.stackDeadlines[targetID] or (not s.kbDone and fireEnd and (fireEnd+2000))\nlocal point=s.destination\nlocal x,y,z=point.x,point.y or .07,point.z\nlocal label=point.label\nprefs.guide(data,\"frog_fru_sky_prey\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw role/fixed-tether stack target",
							uuid = "5cbab778-6078-c881-b738-0fb25afa85fc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 12,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Tether to assigned Prey stack",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 0.7,
				timerStartOffset = -16,
				uuid = "6a58d59f-984e-9981-9a29-7730d5549a2b",
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
							actionLua = "data.frog_fru_sky_prey=nil\nself.used=true",
							name = "Clear Sky stack state",
							uuid = "226b72e8-ac9c-8b98-bf69-45a8d29cf73a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 9,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Clear state - wipe",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 1800,
				timerStartOffset = -79,
				uuid = "b9bee952-9919-47bb-90fc-26cfeec40a2d",
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
							actionLua = "data.frog_fru_sky_prey=nil\nself.used=true",
							name = "Clear Sky stack state",
							uuid = "c548a98a-1058-889a-88a9-93de5537b779",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 16,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Clear state - countdown",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 1800,
				timerStartOffset = -79,
				uuid = "f29dc9e7-ae36-68ce-9d4f-e3550839ce39",
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
							actionLua = "data.frog_fru_sky_prey=nil\nlocal prefs=FrogFRUDrawSettings\nfor _,key in ipairs({\"frog_fru_proteans\",\"frog_fru_sky\",\"frog_fru_clock_wait\",\"frog_fru_faith\",\"frog_fru_towers\",\"frog_fru_sky_cleaves\",\"frog_fru_sky_prey\"})do\n if prefs and prefs.release then prefs.release(data,key) end\n data[key]=nil\nend\nself.used=true",
							name = "Clear Sky stack state",
							uuid = "8c24c402-85f7-94d6-a764-5598b86fbe03",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P1 Utopian Sky",
				eventType = 11,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Clear state - map",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 1800,
				timerStartOffset = -79,
				uuid = "7f2d5ccd-bcfc-d3cb-bca7-b1d0782c9ef4",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s then s.allow=true;s.nextPoll=0;s.poll() end\nself.used=true",
							conditions = 
							{
								
								{
									"0fb16efc-f597-8c60-8241-05c6219ecc38",
									true,
								},
							},
							name = "Begin safe element-side guidance",
							uuid = "334304aa-64ab-51f9-b341-eaeab3bee6c3",
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
							eventSpellID = 40161,
							name = "Middle Burnt Strike",
							uuid = "0fb16efc-f597-8c60-8241-05c6219ecc38",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Begin safe-side guidance",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 2,
				timerStartOffset = -16,
				uuid = "2a3a305a-ca15-adbf-b319-70ef0b89468a",
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
							actionLua = "local s=data.frog_fru_sky_prey\nif s then\n if not s.lifted then s.lifted={} end\n s.lifted[eventArgs.entityID]=true\n if eventArgs.buffDuration and eventArgs.buffDuration>0 then\n  s.stackDeadlines=s.stackDeadlines or {};s.stackDeadlines[eventArgs.entityID]=Now()+eventArgs.buffDuration*1000\n end\n s.nextPoll=0\n s.poll()\nend\nself.used=true",
							conditions = 
							{
								
								{
									"fdad43a3-4f41-4719-a21b-a18644d62474",
									true,
								},
							},
							name = "Enable lifted stack guidance",
							uuid = "20a436b2-2031-87fd-b274-f5fcb1cb6e68",
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
							eventBuffID = 2304,
							name = "Floating Fetters",
							uuid = "fdad43a3-4f41-4719-a21b-a18644d62474",
							version = 3,
						},
					},
				},
				eventType = 8,
				loop = true,
				mechanicTime = 78.5,
				name = "[Sky Stacks] Wait for Floating Fetters",
				timeRange = true,
				timelineIndex = 20,
				timerEndOffset = 2,
				timerStartOffset = -8,
				uuid = "4c993536-c315-a775-bea9-aea01994bf1b",
				version = 2,
			},
		},
	},
	[23] = 
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
							actionLua = "\nlocal s=data.frog_fru_faith\nif not s then\n s={order=(FrogFRUDrawSettings and FrogFRUDrawSettings.region~=\"NA\") and {\"H1\",\"H2\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\"} or {\"R1\",\"H1\",\"M1\",\"T1\",\"T2\",\"M2\",\"H2\",\"R2\"},\n    roster={},byID={},targets={},elements={},anchorX={},anchorZ={},\n    bossSelector={contentid=9707,subgroup=\"Nearest\"},\n    fillSide={},fillBait={},scratch={},count=0,nextRoster=0,nextHit=1,y=0,active=true}\n data.frog_fru_faith=s\nend\nif s.lineupVersion~=3 then\n s.lineupVersion=3\n function s.solve()\n  if not s.ready then return end\n  s.tx=nil;s.tz=nil\n  local boss=TensorCore.getEntityByGroup(\"ContentID\",s.bossSelector)\n  if not boss then s.tx=nil;s.tz=nil;return end\n  local bx,bz=boss.pos.x,boss.pos.z\n  local innerRadius=boss.hitradius+2\n  s.y=boss.pos.y\n  local eu=FrogFRUDrawSettings and (FrogFRUDrawSettings.region==\"EU\" or FrogFRUDrawSettings.region==\"Elemental\")\n  local mine=s.byID[s.playerID]\n  if not mine then return end\n  s.followID=nil\n  local myTether\n  for i=1,4 do if s.targets[i]==s.playerID then myTether=i; break end end\n  if not myTether and s.count<4 then\n   local base=(mine-4.5)*1.6\n   if eu then\n   local me=TensorCore.mGetEntity(s.playerID)\n   local line=s.waitLine\n   local candidates={}\n   local before,after\n   for rank=1,8 do\n    local id=s.roster[rank]\n    local marked=false\n    for i=1,4 do if s.targets[i]==id then marked=true;break end end\n    if not marked then\n     local actor=TensorCore.mGetEntity(id)\n     if actor and actor.pos and actor.hp.current>0 then\n      local x,z=actor.pos.x,actor.pos.z\n      if x>=bx-12 and x<=bx-3 and math.abs(z-bz)<=12 then\n       candidates[#candidates+1]=x\n       if rank<mine then before=z\n       elseif rank>mine and not after then after=z end\n      end\n     end\n    end\n   end\n   if not line then\n    line={x=bx-innerRadius,z=me and me.pos and me.pos.z or bz+base}\n    s.waitLine=line\n   end\n   if #candidates>=3 and not line.fitted then\n    table.sort(candidates)\n    local n=#candidates\n    local x=n%2==1 and candidates[(n+1)/2]or(candidates[n/2]+candidates[n/2+1])/2\n    line.x=math.max(bx-12,math.min(bx-boss.hitradius-.5,x));line.fitted=true\n   end\n   local low,high=bz-12,bz+12\n   if before then low=math.max(low,before+1)end\n   if after then high=math.min(high,after-1)end\n   if low<=high then\n    local along=me and me.pos and me.pos.z or line.z\n    line.z=math.max(low,math.min(high,along))\n   end\n   s.tx=line.x;s.tz=line.z\n   return\n   end\n   local offset=s.waitOffset or 0\n   local low,high=-1.2,1.2\n   for rank=1,8 do\n    local id=s.roster[rank]\n    if id~=s.playerID then\n     local marked=false\n     for i=1,4 do if s.targets[i]==id then marked=true;break end end\n     if not marked then\n      local actor=TensorCore.mGetEntity(id)\n      if actor and actor.pos and actor.hp.current>0 then\n       local along=eu and actor.pos.z-bz or actor.pos.x-bx\n       local across=eu and actor.pos.x-(bx-innerRadius) or actor.pos.z-(bz+5.5)\n       if math.abs(across)<2.4 and math.abs(along-base)<6 then\n        if rank<mine then low=math.max(low,along+1.2-base)\n        else high=math.min(high,along-1.2-base) end\n       end\n      end\n     end\n    end\n   end\n   if low<=high then\n    local wanted=math.max(low,math.min(high,offset))\n    local change=wanted-offset\n    if math.abs(change)>.15 then offset=offset+math.max(-.35,math.min(.35,change)) end\n   end\n   s.waitOffset=offset\n   if eu then s.tx=bx-innerRadius;s.tz=bz+base+offset\n   else s.tx=bx+base+offset;s.tz=bz+5.5 end\n   return\n  end\n  local visible=not (s.lifted and s.lifted[s.playerID])\n  if s.keepVisible~=visible then\n   s.keepVisible=visible\n   local prefs=FrogFRUDrawSettings\n   if prefs and prefs.release then prefs.release(data,\"frog_fru_faith\")end\n  end\n  if myTether then\n   if s.lifted and s.lifted[s.playerID]then return end\n   if myTether>=3 and s.nextHit>myTether then return end\n   local side=myTether%2==1 and 1 or 2\n   local firstResolved=s.nextHit>side\n   local firstOnSide=myTether<=2\n   local inner=(firstOnSide and not firstResolved) or (not firstOnSide and firstResolved)\n   local radius=boss.hitradius+(inner and 0 or 3)\n   local direction=side==1 and -1 or 1\n   s.heading=eu and (direction<0 and 0 or math.pi) or (direction<0 and math.pi/2 or -math.pi/2)\n   s.label=\"Tether \"..myTether..(inner and \": move in\" or \": move out\")\n   if eu then s.tx=bx;s.tz=bz+direction*radius\n   else s.tx=bx+direction*radius;s.tz=bz end\n   return\n  end\n  if s.count==4 and not s.assigned then\n   local n=0\n   for rank=1,8 do\n    local id=s.roster[rank]\n    local marked=false\n    for i=1,4 do if s.targets[i]==id then marked=true; break end end\n    if not marked then n=n+1; s.scratch[n]=id end\n   end\n   if n~=4 then return end\n   for i=1,4 do\n    local id=s.scratch[i]\n    s.fillSide[id]=i<=2 and 1 or 2\n    s.fillBait[id]=(i==1 or i==4) and -1 or 1\n   end\n   s.assigned=true\n  end\n  local side=myTether and (myTether%2==1 and 1 or 2) or s.fillSide[s.playerID]\n  if not side then return end\n  local current=side\n  if s.nextHit>current then current=current+2 end\n  if current>4 or s.nextHit>current then return end\n  local direction=side==1 and -1 or 1\n  local fire=s.elements[current]==\"Fire\"\n  local radius=boss.hitradius+(fire and 1.5 or 0.5)\n  local northSouth=fire and 0 or (s.fillBait[s.playerID] or 0)*2.5\n  if eu then s.tx=bx-northSouth;s.tz=bz+direction*radius\n  else s.tx=bx+direction*radius;s.tz=bz+northSouth end\n  s.followID=s.targets[current];s.followFire=fire;s.followNS=northSouth;s.followEU=eu\n end\nend\nif s.ready then\n local me=TensorCore.mGetPlayer()\n if me then s.playerID=me.id end\n if s.active then s.solve() end\n self.used=true return\nend\nif Now()<s.nextRoster then return end\ns.nextRoster=Now()+1000\nif not AnyoneCore then return end\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nlocal me=TensorCore.mGetPlayer()\nif not me or type(members)~=\"table\" or type(party)~=\"table\" then return end\nfor i,key in ipairs(s.order) do\n local member=members[key]\n if not member or not member.job then return end\n local count,match=0,nil\n for _,actor in pairs(party) do\n  if actor.job==member.job and actor.name==member.name then count=count+1; match=actor end\n end\n if count==0 then\n  local n=0\n  for _,other in pairs(members) do if other.job==member.job then n=n+1 end end\n  if n==1 then\n   for _,actor in pairs(party) do if actor.job==member.job then count=count+1; match=actor end end\n  end\n end\n if count~=1 then return end\n for j=1,i-1 do if s.roster[j]==match.id then return end end\n s.roster[i]=match.id\nend\nfor i=1,8 do s.byID[s.roster[i]]=i end\ns.playerID=me.id; s.ready=true\ns.solve()\nself.used=true\n",
							name = "Faith Roles",
							uuid = "c57364f9-df06-5eac-bcf4-60d860b69752",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				loop = true,
				mechanicTime = 101.5,
				name = "[Utility] Faith Roles",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 16,
				timerStartOffset = -13.5,
				uuid = "cc113249-3c94-7063-80b2-885dd088f4d7",
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
							actionLua = "\nlocal s=data.frog_fru_faith\nif not s then return end\nlocal actor=TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif not actor then return end\nlocal index\nif eventArgs.sourceEntityContentID==9707 then index=1\nelseif actor.pos.z<90 then\n if actor.pos.x<95 then index=2\n elseif actor.pos.x>105 then index=4\n else index=3 end\nend\nif index then\n if not s.targets[index] then s.count=s.count+1 end\n s.targets[index]=eventArgs.newTargetID\n s.elements[index]=\"Fire\"\n s.solve()\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"e98d57aa-9469-4655-bc65-b73e155ab4ee",
									true,
								},
								
								{
									"4b8b7478-742a-51c4-9597-5845b6afdb2d",
									true,
								},
							},
							name = "Faith Fire",
							uuid = "e1141e8d-6841-28b2-a3c8-da58341a3b20",
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
							eventIntValue = 249,
							name = "Fire",
							uuid = "e98d57aa-9469-4655-bc65-b73e155ab4ee",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.sourceEntityContentID==9707 or eventArgs.sourceEntityContentID==9708",
							dequeueIfLuaFalse = true,
							name = "Fatebreaker source",
							uuid = "4b8b7478-742a-51c4-9597-5845b6afdb2d",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 101.5,
				name = "[Draw] Faith Fire",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 2.5,
				timerStartOffset = -11.5,
				uuid = "dd1d0f41-6346-239c-b5d3-5fbead6d3ed9",
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
							actionLua = "\nlocal s=data.frog_fru_faith\nif not s then return end\nlocal actor=TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif not actor then return end\nlocal index\nif eventArgs.sourceEntityContentID==9707 then index=1\nelseif actor.pos.z<90 then\n if actor.pos.x<95 then index=2\n elseif actor.pos.x>105 then index=4\n else index=3 end\nend\nif index then\n if not s.targets[index] then s.count=s.count+1 end\n s.targets[index]=eventArgs.newTargetID\n s.elements[index]=\"Lightning\"\n s.solve()\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"233846af-a1b4-6bfe-9065-6cac8af170c6",
									true,
								},
								
								{
									"a819bedf-81a9-0b2b-8c59-d0d9a4fa23c9",
									true,
								},
							},
							name = "Faith Lightning",
							uuid = "d78feb37-3010-ebcb-945b-33a26530da62",
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
							eventIntValue = 287,
							name = "Lightning",
							uuid = "233846af-a1b4-6bfe-9065-6cac8af170c6",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "return eventArgs.sourceEntityContentID==9707 or eventArgs.sourceEntityContentID==9708",
							dequeueIfLuaFalse = true,
							name = "Fatebreaker source",
							uuid = "a819bedf-81a9-0b2b-8c59-d0d9a4fa23c9",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 101.5,
				name = "[Draw] Faith Lightning",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 2.5,
				timerStartOffset = -11.5,
				uuid = "25871e92-54bb-1efd-bc97-52049ad269a8",
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
							actionLua = "\nlocal s=data.frog_fru_faith\nif not s then return end\nfor i=1,4 do\n if s.targets[i]==eventArgs.targetID then\n  local actor=TensorCore.mGetEntity(eventArgs.targetID)\n  if not actor then return end\n  s.anchorX[i]=actor.pos.x; s.anchorZ[i]=actor.pos.z\n  s.lifted=s.lifted or {};s.lifted[eventArgs.targetID]=i\n  s.solve(); break\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"ccf2c772-d649-7569-b827-46709b77f729",
									true,
								},
							},
							name = "Faith Positions",
							uuid = "7001d27e-0bf5-7178-b65e-99bdb583f935",
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
							eventSpellID = 40171,
							name = "Floating Fetters",
							uuid = "ccf2c772-d649-7569-b827-46709b77f729",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 101.5,
				name = "[Draw] Faith Positions",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 12,
				timerStartOffset = -0.5,
				uuid = "43f41682-d567-1a99-adaf-9042b0856169",
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
							actionLua = "\nlocal s=data.frog_fru_faith\nif not s then return end\nlocal t=TensorReactions_CurrentTimer\nif not s.lastHit or t-s.lastHit>1 then\n s.lastHit=t; s.nextHit=s.nextHit+1\n if s.lifted then for id,index in pairs(s.lifted)do if index<s.nextHit then s.lifted[id]=nil end end end\n local mine\n for i=1,4 do if s.targets[i]==s.playerID then mine=i;break end end\n local side=mine and (mine%2==1 and 1 or 2) or (s.fillSide and s.fillSide[s.playerID])\n if s.nextHit>4 then s.active=false;s.tx=nil;s.tz=nil\n else s.solve() end\n if s.nextHit>4 or (side and s.nextHit>side+2) then\n  s.tx=nil;s.tz=nil\n  local prefs=FrogFRUDrawSettings\n  if prefs and prefs.release then prefs.release(data,\"frog_fru_faith\") end\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"b0810a93-dd5f-b4e5-bb2e-f0a77a2f659c",
									true,
								},
							},
							name = "Faith Steps",
							uuid = "9c0aa7e0-960d-f824-bbd5-5e08dd38f0a3",
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
							name = "Stack or cones",
							spellIDList = 
							{
								40143,
								40156,
							},
							uuid = "b0810a93-dd5f-b4e5-bb2e-f0a77a2f659c",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 101.5,
				name = "[Draw] Faith Steps",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 30,
				timerStartOffset = -13.5,
				uuid = "2cf264cd-d316-25b2-8bd5-814ce9179094",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nif not prefs or not prefs.guide then self.used=true return end\nif prefs.styleFor(\"faith\")==\"Disabled\" then prefs.release(data,\"frog_fru_faith\");self.used=true return end\n\nlocal s=data.frog_fru_faith\nif not s or not s.active or not s.tx or not s.tz then prefs.release(data,\"frog_fru_faith\");self.used=true return end\nif s and s.active and s.tx and s.tz then\n local me=TensorCore.mGetPlayer()\n if me and me.pos and me.hp.current>0 then\n  local tx,tz=s.tx,s.tz\n\n  local f=s.followID and TensorCore.mGetEntity(s.followID)\n  if f and f.pos then\n   if s.followFire then\n    local side=s.fillSide and s.fillSide[me.id]\n    if side then\n     local behind=side==1 and -2.5 or 2.5\n     if s.followEU then tx,tz=f.pos.x,f.pos.z+behind\n     else tx,tz=f.pos.x+behind,f.pos.z end\n    end\n   elseif s.followEU then tx,tz=f.pos.x-s.followNS,f.pos.z\n   else tx,tz=f.pos.x,f.pos.z+s.followNS end\n  end\n  s.keepVisible=true;s.arrowHoldAfterDeadline=false\n  local mine\n  for i=1,4 do if s.targets[i]==me.id then mine=i;break end end\n  local groupSide=mine and (mine%2==1 and 1 or 2) or (s.fillSide and s.fillSide[me.id])\n  local deadline,clockKey\n  if groupSide then\n   local groupHit=s.nextHit>groupSide and groupSide+2 or groupSide\n   local target=s.targets[groupHit]\n   local lifting=mine==groupHit\n   clockKey=\"faith:\"..groupSide..\":\"..groupHit..(lifting and \":lift\" or \":stack\")\n   if lifting then deadline=s.liftDeadlines and s.liftDeadlines[groupHit]\n   else deadline=(s.deadlines and s.deadlines[target]) or (s.liftDeadlines and s.liftDeadlines[groupHit] and s.liftDeadlines[groupHit]+3400) end\n  else clockKey=\"faith:selection\";deadline=s.selectionDeadline end\n  if s.arrowClockKey~=clockKey then\n   s.arrowClockKey=clockKey;s.arrowClockDeadline=deadline\n  elseif not s.arrowClockDeadline then s.arrowClockDeadline=deadline end\n  s.arrowStage=clockKey;s.arrowDeadline=s.arrowClockDeadline\n  if not s.arrowDeadline then prefs.release(data,\"frog_fru_faith\");self.used=true;return end\n  prefs.guide(data,\"frog_fru_faith\",\"faith\",s,me,tx,(s.y or 0)+.05,tz,s.label,nil,8)\n else prefs.release(data,\"frog_fru_faith\") end\nend\nself.used=true",
							name = "Fall of Faith",
							uuid = "3b8049b9-d526-4aaf-9473-ada114d93d24",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 101.5,
				name = "[Draw] Fall of Faith",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 16,
				timerStartOffset = -13.5,
				uuid = "77cda1a8-2c67-93b5-bfe0-724b6b2dd177",
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
							actionLua = "local s=data.frog_fru_faith\nif s and s.active and eventArgs.buffDuration and eventArgs.buffDuration>0 then\n for i=1,4 do\n  if s.targets[i]==eventArgs.entityID then\n   s.deadlines=s.deadlines or {};s.deadlines[eventArgs.entityID]=Now()+eventArgs.buffDuration*1000\n   break\n  end\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"8084ef16-5390-8179-8c21-84b7c43d00be",
									true,
								},
							},
							name = "Read live stack expiration",
							uuid = "64f89a61-f76d-0b65-9fd8-49e29b2e62b1",
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
							eventBuffID = 2304,
							name = "Floating Fetters",
							uuid = "8084ef16-5390-8179-8c21-84b7c43d00be",
							version = 3,
						},
					},
				},
				eventType = 8,
				loop = true,
				mechanicTime = 101.5,
				name = "[Faith] Read stack deadline",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = 17,
				timerStartOffset = -2,
				uuid = "f9cd993d-848d-0faf-9fdd-87b765b4064c",
				version = 2,
			},
		},
	},
	[32] = 
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
							actionLua = "\nlocal s=data.frog_fru_towers\nif not s then\n s={towers={},sorted={},count=0,nextRoster=0,lineX=100,y=0,\n    capacity={[40135]=1,[40131]=1,[40125]=2,[40122]=2,[40126]=3,[40123]=3,[40124]=4,[40127]=4},\n    fixed={H1=1,R2=2,H2=3},flex={M1=1,M2=2,R1=3},\n    roles={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}}\n local region=(FrogFRUDrawSettings or {}).region\n if region==\"JP\" then s.fixed={H1=1,H2=2,R2=3};s.flex={M1=1,M2=2,R1=3}\n elseif region==\"EU\" or region==\"Elemental\" then s.flex={M1=1,R1=2,M2=3} end\n data.frog_fru_towers=s\n function s.lessZ(a,b) return a.z<b.z end\n function s.update()\n  if s.done or not s.role or not s.mode or s.count~=3 then return end\n  if s.role==\"T1\" or s.role==\"T2\" then\n   if not s.variantConfirmed then s.active=false;s.tx=nil;s.tz=nil;return end\n   local total,n=0,0\n   for _,tower in pairs(s.towers)do n=n+1;s.sorted[n]=tower;total=total+tower.capacity end\n   if n~=3 or total~=6 then return end\n   table.sort(s.sorted,s.lessZ)\n   local side=s.sorted[2].x<s.lineX and -1 or 1\n   for i=1,3 do if (s.sorted[i].x<s.lineX and -1 or 1)~=side then return end end\n   local prefs=FrogFRUDrawSettings or {}\n   local layout=prefs.towerTank or \"MT north\"\n   local north=(layout==\"MT north\" and s.role==\"T1\") or (layout==\"OT north\" and s.role==\"T2\")\n   local tower=layout==\"Stacked\" and s.sorted[2] or s.sorted[north and 1 or 3]\n   s.tx=2*s.lineX-tower.x;s.tz=layout==\"Stacked\" and 100 or tower.z;s.y=tower.y\n   if s.mode==\"Fire\" then\n    if not s.knockbackDone then s.tx=s.lineX-side*(s.initialDone and 1 or 6)\n    elseif layout==\"Stacked\" then s.tx=s.lineX-side*6 end\n   end\n   s.keepVisible=true;s.active=true;s.label=layout==\"Stacked\" and \"Tanks stacked\" or north and \"Tank north\" or \"Tank south\"\n   s.stage=s.mode==\"Lightning\" and \"Lightning:\"..layout or (s.mode or \"\")..\":\"..tostring(s.initialDone)..\":\"..tostring(s.knockbackDone)..\":\"..layout\n   return\n  end\n  if not s.assigned then\n   local n,total=0,0\n   for _,tower in pairs(s.towers) do n=n+1; s.sorted[n]=tower; total=total+tower.capacity end\n   if total~=6 then return end\n   table.sort(s.sorted,s.lessZ)\n   local index=s.fixed[s.role]\n   if not index then\n    local rank=s.flex[s.role]\n    if not rank then return end\n    for i=1,3 do\n     local vacancies=s.sorted[i].capacity-1\n     if rank<=vacancies then index=i; break end\n     rank=rank-vacancies\n    end\n   end\n   if not index then return end\n   s.assigned=s.sorted[index]\n   s.side=s.assigned.x<s.lineX and -1 or 1\n   for i=1,3 do\n    if (s.sorted[i].x<s.lineX and -1 or 1)~=s.side then s.assigned=nil; return end\n   end\n  end\n  local tower=s.assigned\n  s.tx=tower.x; s.tz=tower.z; s.y=tower.y\n  if s.mode==\"Fire\" and not s.knockbackDone then\n   s.tx=s.lineX+s.side*(s.initialDone and 1 or 6)\n  end\n  s.active=true\n end\nend\nif s.role then self.used=true return end\nlocal cached=data.frog_fru_role\nif cached then s.role=cached.key; s.update(); self.used=true return end\nlocal faith=data.frog_fru_faith\nlocal me=TensorCore.mGetPlayer()\nif not me then return end\nif faith and faith.ready and faith.byID[me.id] then\n s.role=faith.order[faith.byID[me.id]]; s.update(); self.used=true; return\nend\nif Now()<s.nextRoster then return end\ns.nextRoster=Now()+1000\nif not AnyoneCore then return end\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nif type(members)~=\"table\" or type(party)~=\"table\" then return end\nfor _,role in ipairs(s.roles) do\n local member=members[role]\n if member and member.job then\n  local count,match=0,nil\n  for _,actor in pairs(party) do\n   if actor.job==member.job and actor.name==member.name then count=count+1; match=actor end\n  end\n  if count==0 then\n   local n=0\n   for _,other in pairs(members) do if other.job==member.job then n=n+1 end end\n   if n==1 then\n    for _,actor in pairs(party) do if actor.job==member.job then count=count+1; match=actor end end\n   end\n  end\n  if count==1 and match.id==me.id then\n   s.role=role; s.update(); self.used=true; return\n  end\n end\nend\n",
							name = "Tower Roles",
							uuid = "57cdbadc-f96d-891a-bbd6-75bf5a92b268",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				mechanicTime = 140.9,
				name = "[Utility] Tower Roles",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 4.1,
				timerStartOffset = -10.9,
				uuid = "d6c5f596-9b36-3150-ae5f-527826d6a843",
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
							actionLua = "\nlocal s=data.frog_fru_towers\nif not s then return end\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not actor then return end\nif eventArgs.spellID==40130 then\n s.fireKBAt=s.fireKBAt or Now()+eventArgs.channelTimeMax*1000\n self.used=true;return\nelseif eventArgs.spellID==40134 then\n s.lightningAt=s.lightningAt or Now()+eventArgs.channelTimeMax*1000\n self.used=true;return\nelseif eventArgs.spellID==40129 or eventArgs.spellID==40133 then s.bossID=eventArgs.entityID end\nlocal capacity=s.capacity[eventArgs.spellID]\nif capacity then\n local tower=s.towers[eventArgs.entityID]\n if not tower then\n  tower={id=eventArgs.entityID}; s.towers[eventArgs.entityID]=tower; s.count=s.count+1\n end\n tower.x=actor.pos.x; tower.y=actor.pos.y; tower.z=actor.pos.z; tower.capacity=capacity;tower.deadline=Now()+eventArgs.channelTimeMax*1000\nelseif eventArgs.spellID==40129 or eventArgs.spellID==40133 then\n s.variantConfirmed=true\n s.mode=eventArgs.spellID==40129 and \"Fire\" or \"Lightning\"\n s.lineX=actor.pos.x\nend\ns.update()\nself.used=true\n",
							conditions = 
							{
								
								{
									"85b3db52-ad9c-c3ee-bc8f-48826ba3d29a",
									true,
								},
								
								{
									"70ffbe7a-abea-1695-b984-2cba9ff8e0db",
									true,
								},
							},
							name = "Tower Capture",
							uuid = "e67bead7-4586-ff16-a915-bdd0bfdd4c37",
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
							name = "Towers and element",
							spellIDList = 
							{
								40122,
								40123,
								40124,
								40125,
								40126,
								40127,
								40131,
								40135,
								40129,
								40133,
								40130,
								40134,
							},
							uuid = "85b3db52-ad9c-c3ee-bc8f-48826ba3d29a",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 9707,
							name = "Fatebreaker",
							uuid = "70ffbe7a-abea-1695-b984-2cba9ff8e0db",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 140.9,
				name = "[Draw] Tower Capture",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = -1.9,
				timerStartOffset = -8.9,
				uuid = "fa58750b-c1bc-936d-9462-f469a42e3e5e",
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
							actionLua = "local s=data.frog_fru_towers\nif not s then return end\nif eventArgs.spellID==40169 then\n if s.role==\"T1\" or s.role==\"T2\" then s.done=true;s.active=false;s.tx=nil;s.tz=nil end\nelseif eventArgs.spellID==40129 then s.initialDone=true;s.update()\nelseif eventArgs.spellID==40130 then s.knockbackDone=true;s.update()\nelseif eventArgs.spellID==40133 then s.initialDone=true;s.update()\nelseif eventArgs.spellID==40134 then s.lightningDone=true;s.lightningResolvedAt=Now();s.update()\nelseif s.towers[eventArgs.entityID] then\n s.resolved=s.resolved or {}\n s.resolved[eventArgs.entityID]=true\n local count=0;for _ in pairs(s.resolved)do count=count+1 end\n if s.assigned and eventArgs.entityID==s.assigned.id then s.done=true;s.active=false end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"73435931-58d5-4ca1-b20b-21567663cb70",
									true,
								},
							},
							name = "Tower Steps",
							uuid = "833f5f95-244f-3f24-a674-c3e99103f641",
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
							name = "Fire and tower resolves",
							spellIDList = 
							{
								40122,
								40123,
								40124,
								40125,
								40126,
								40127,
								40131,
								40135,
								40129,
								40130,
								40133,
								40134,
								40169,
							},
							uuid = "73435931-58d5-4ca1-b20b-21567663cb70",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 140.9,
				name = "[Draw] Tower Steps",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 7.1,
				timerStartOffset = -3.9,
				uuid = "1c0ea3b0-9bd9-81e3-af9f-1142e09dad45",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_towers\nlocal player=TensorCore.mGetPlayer()\nif s and (s.role==\"T1\" or s.role==\"T2\") and not s.variantConfirmed then\n if prefs and prefs.release then prefs.release(data,\"frog_fru_towers\") end\n self.used=true;return\nend\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then if prefs and prefs.release then prefs.release(data,\"frog_fru_towers\") end;self.used=true return end\nif not s.busterDeadline and AnyoneCore and AnyoneCore.Roster.isReady() then\n for _,role in ipairs({\"T1\",\"T2\"})do\n  local id=AnyoneCore.Roster.idOf(role)\n  local actor=TensorCore.mGetEntity(id)\n  local buff=actor and TensorCore.getBuff(actor,4166)\n  if buff and buff.duration>0 then s.busterID=id;s.busterDeadline=Now()+buff.duration*1000;break end\n end\nend\nlocal style=\"towers\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_towers\");self.used=true return end\nlocal x,y,z=s.tx,s.y or 0,s.tz\nlocal tank=s.role==\"T1\" or s.role==\"T2\"\nlocal label=s.label\ns.keepVisible=true;s.arrowHoldAfterDeadline=false\ns.arrowStage=nil;s.arrowDeadline=nil\nif tank then\n local mechanicDone=s.mode==\"Fire\" and s.knockbackDone or s.mode==\"Lightning\" and s.lightningDone\n if mechanicDone then\n  s.arrowStage=\"tower-buster:\"..tostring(s.busterID);s.arrowDeadline=s.busterDeadline;label=\"Tank buster resolution\"\n else\n  s.arrowStage=\"tower-mechanic:\"..s.mode;s.arrowDeadline=s.mode==\"Fire\" and s.fireKBAt or s.lightningAt\n  label=s.mode==\"Fire\" and \"Fire knockback\" or \"Lightning cleave\"\n end\n if not s.arrowDeadline or Now()>=s.arrowDeadline then prefs.release(data,\"frog_fru_towers\");self.used=true;return end\nelseif s.mode==\"Fire\" and not s.knockbackDone then\n s.arrowStage=\"tower-fire-knockback\";s.arrowDeadline=s.fireKBAt;label=\"Fire knockback\"\nelseif s.assigned then s.arrowDeadline=s.assigned.deadline\nelse for id,tower in pairs(s.towers)do if not (s.resolved and s.resolved[id]) and tower.deadline then s.arrowDeadline=math.max(s.arrowDeadline or 0,tower.deadline)end end end\nprefs.guide(data,\"frog_fru_towers\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Tower Flex",
							uuid = "d6e834ed-8189-2f17-b6a6-148806ecdd86",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				eventType = 12,
				mechanicTime = 140.9,
				name = "[Draw] Tower Flex",
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 7.1,
				timerStartOffset = -8.9,
				uuid = "7a511b1f-34c0-9b96-b4b8-0ea04521cf2f",
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
							actionLua = "local s=data.frog_fru_towers\nlocal p=TensorCore.mGetPlayer()\nlocal prefs=FrogFRUDrawSettings or {}\nlocal now=Now()\nlocal request=FrogFRUTowerKBRequest\nif request and (not p or p.hp.current<=0 or not s or s.done or not prefs.towerFireKB or prefs.towerTank~=\"Stacked\" or now>=request.expires) then\n _G[request.var]=request.previous;FrogFRUTowerKBRequest=nil\nend\nif prefs.towerTank~=\"Stacked\" then self.used=true;return end\nif not p or p.hp.current<=0 or not s or s.done or (s.role~=\"T1\" and s.role~=\"T2\") then self.used=true;return end\nif prefs.towerLightningGap and s.mode==\"Lightning\" and s.lightningDone and not s.gapUsed and now<(s.lightningResolvedAt or 0)+1000 then\n local ids={[19]=16461,[21]=7386,[32]=36926,[37]=36934}\n local id=ids[p.job]\n local boss=s.bossID and TensorCore.mGetEntity(s.bossID)\n local action=id and ActionList:Get(1,id)\n if boss and boss.hp.current>0 and action and action:IsReady(boss.id) and action:Cast(boss.id) then s.gapUsed=true end\nend\nif prefs.towerFireKB and s.mode==\"Fire\" and s.fireKBAt and not s.knockbackDone and not s.kbRequested and now>=s.fireKBAt-500 and now<s.fireKBAt then\n local selected\n for _,toggle in pairs(TensorCore.API.TensorACR.getHotbarToggles() or {})do\n  local name=type(toggle.name)==\"function\" and toggle.name() or toggle.name\n  if toggle.enabled~=false and type(name)==\"string\" and name:find(\"KB Cancel\",1,true) and type(toggle.var)==\"string\" then\n   if not selected or toggle.var<selected.var then selected=toggle end\n  end\n end\n if selected then\n  s.kbRequested=true\n  if _G[selected.var]~=true then FrogFRUTowerKBRequest={var=selected.var,previous=_G[selected.var],expires=s.fireKBAt+1000};_G[selected.var]=true end\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"fc13c5c2-bb99-85e2-a83c-85c3022a2137",
									true,
								},
							},
							name = "Optional tower movement",
							uuid = "2bfd3e3d-2013-3b52-a148-cc1687f9a733",
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
							conditionType = 9,
							dequeueIfLuaFalse = true,
							name = "Tank only",
							partyTargetType = "Tank",
							uuid = "fc13c5c2-bb99-85e2-a83c-85c3022a2137",
							version = 3,
						},
					},
				},
				mechanicTime = 140.9,
				name = "[Towers] Tank movement",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 32,
				timerEndOffset = 7.1,
				timerStartOffset = -9,
				uuid = "16e9e664-e1f7-aecb-8721-9af43cf752a2",
				version = 2,
			},
		},
	},
	[44] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Diamond Dust",
				uuid = "a62b23f6-47cf-554d-8471-35af14a7a338",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nif prefs and prefs.dd==false then self.used=true return end\nlocal s=data.frog_fru_dd\nif s and s.active then self.used=true return end\ns={active=true,started=Now(),clockAt=Now()+math.max(0,eventArgs.channelTimeMax-1.5)*1000,\n cx=100,cz=100,y=0,marked={},markerCount=0,needles={},needleCount=0,puddles={},holyCount=0,\n phase=\"resolve\",kickDone=false,coneDone=false,dropped=false,kbDone=false,\n angles={T1=math.pi,T2=math.pi/2,H1=-math.pi/2,H2=0,M1=-math.pi/4,M2=math.pi/4,R1=-3*math.pi/4,R2=3*math.pi/4},\n partners={T1=\"R1\",R1=\"T1\",T2=\"R2\",R2=\"T2\",H1=\"M1\",M1=\"H1\",H2=\"M2\",M2=\"H2\"}}\nif (FrogFRUDrawSettings or {}).region==\"JP\" then s.angles.T2=0;s.angles.H2=math.pi/2 end\ndata.frog_fru_dd=s\nfunction s.clear()\n if s.line then Argus.deleteTimedShape(s.line);s.line=nil end\n if s.circle then Argus.deleteTimedShape(s.circle);s.circle=nil end\n if s.routeLine then Argus.deleteTimedShape(s.routeLine);s.routeLine=nil end\n if s.routeCircle then Argus.deleteTimedShape(s.routeCircle);s.routeCircle=nil end\n s.tx=nil;s.tz=nil\nend\nfunction s.point(h,r,label)\n s.tx=s.cx+math.sin(h)*r;s.tz=s.cz+math.cos(h)*r;s.label=label\nend\nfunction s.safe(x,z)\n for _,p in ipairs(s.puddles) do\n  if (x-p.x)^2+(z-p.z)^2<6.6^2 then return false end\n end\n return true\nend\nfunction s.farPoint(nearReflection)\n if not s.refAngle then return end\n local ideal=s.refAngle+(nearReflection and 0 or math.pi)\n for i=0,89 do\n  for sign=-1,1,2 do\n   local h=ideal+sign*i*math.pi/180\n   local x=s.cx+math.sin(h)*16;local z=s.cz+math.cos(h)*16\n   if s.safe(x,z) then s.tx=x;s.tz=z;s.label=nearReflection and \"Preposition: closest clear spot behind reflection\" or \"Preposition: closest clear spot opposite reflection\";return end\n  end\n end\n s.tx=nil;s.tz=nil;s.label=\"No clear preposition found\"\nend\nfunction s.slide(wantBack,me,oracle,label)\n local token=s.phase..tostring(s.comboPreview and 2 or s.comboStep or 0)\n if s.slideToken==token then s.tx=s.slideX;s.tz=s.slideZ;s.label=label;return end\n local fx,fz=math.sin(oracle.pos.h),math.cos(oracle.pos.h)\n local idealX=s.cx+fx*(wantBack and -16 or 16)\n local idealZ=s.cz+fz*(wantBack and -16 or 16)\n local best=math.huge;local bx,bz=nil,nil\n for i=0,359 do\n  local h=i*math.pi/180\n  local x=me.pos.x+math.sin(h)*32;local z=me.pos.z+math.cos(h)*32\n  local dx,dz=x-oracle.pos.x,z-oracle.pos.z\n  local dot=dx*fx+dz*fz;local cross=dx*fz-dz*fx\n  local safeSide=wantBack and dot<0 and math.abs(cross)<-dot*0.9 or not wantBack and dot>0\n  if safeSide and (x-s.cx)^2+(z-s.cz)^2<19.3^2 and s.safe(x,z) then\n   local score=(x-idealX)^2+(z-idealZ)^2\n   if score<best then best=score;bx=x;bz=z end\n  end\n end\n s.tx=bx;s.tz=bz;s.label=bx and label or \"No clear slide from current position\"\n if bx then s.slideToken=token;s.slideX=bx;s.slideZ=bz end\nend\nfunction s.solve()\n s.nextX=nil;s.nextZ=nil\n local role=data.frog_fru_role\n local me=TensorCore.mGetPlayer()\n if not role or not me or not s.angles[role.key] then s.tx=nil;s.tz=nil;return end\n s.playerID=me.id;s.role=role.key\n local oracle=s.reflectionID and TensorCore.mGetEntity(s.reflectionID)\n if oracle and s.kickDone and not s.refAngle then\n  local dx,dz=oracle.pos.x-s.cx,oracle.pos.z-s.cz\n  if dx*dx+dz*dz>25 then s.refAngle=math.atan2(dx,dz) end\n end\n if Now()<s.clockAt then s.tx=nil;s.tz=nil;return end\n if s.phase==\"stack\" then s.clear();return end\n if s.phase==\"awaitStack\" then s.tx=nil;s.tz=nil;return end\n if s.phase==\"combo\" then\n  if not oracle then s.tx=nil;s.tz=nil;return end\n  local wantBack=(s.comboKind==\"Stillness\" and s.comboStep==1) or (s.comboKind==\"Silence\" and s.comboStep==2)\n  local fx,fz=math.sin(oracle.pos.h),math.cos(oracle.pos.h)\n  local dx,dz=me.pos.x-oracle.pos.x,me.pos.z-oracle.pos.z\n  local dot=dx*fx+dz*fz;local cross=dx*fz-dz*fx\n  local alreadySafe=wantBack and dot<0 and math.abs(cross)<-dot*0.9 or not wantBack and dot>0\n  if s.comboStep==1 and s.comboFirstAt and Now()>=s.comboFirstAt-500 and alreadySafe then\n   s.comboPreview=true;wantBack=not wantBack;alreadySafe=false\n  end\n  local token=s.phase..tostring(s.comboPreview and 2 or s.comboStep or 0)\n  if s.slideToken==token then\n   s.tx=s.slideX;s.tz=s.slideZ\n  elseif alreadySafe then\n   s.tx=me.pos.x;s.tz=me.pos.z;s.label=\"Hold: cleave safe\"\n   s.slideToken=token;s.slideX=s.tx;s.slideZ=s.tz\n  else s.slide(wantBack,me,oracle,wantBack and \"Slide behind reflection\" or \"Slide away from reflection\") end\n  return\n end\n if s.phase==\"preIce\" then\n  if s.ice then\n   if s.slideToken==\"preIce0\" then\n    s.tx=s.slideX;s.tz=s.slideZ\n   elseif oracle and s.refAngle and (me.pos.x-s.cx)*math.sin(s.refAngle)+(me.pos.z-s.cz)*math.cos(s.refAngle)>0 then\n    s.slide(false,me,oracle,\"Slide across before combo\")\n   else s.tx=nil;s.tz=nil;s.label=\"Hold: wait for combo\" end\n  else s.farPoint(s.endNearReflection) end\n  return\n end\n if s.kbDone then\n  if not s.kbAngle then s.tx=nil;s.tz=nil;return end\n  if not s.needlesDone or not s.refAngle then s.point(s.kbAngle,18.5,\"Land and wait for starbursts\");return end\n  if not s.rotation then\n   local delta=(s.refAngle-s.kbAngle+math.pi)%(2*math.pi)-math.pi\n   s.cursed=math.abs(math.sin(delta))<0.2\n   local region=(FrogFRUDrawSettings or {}).region\n   if region==\"EU\" or region==\"JP\" then s.rotation=math.abs(delta+math.pi/4)<0.2 and 1 or -1\n   else s.rotation=s.cursed and -1 or (delta>0 and -1 or 1) end\n  end\n  local arc=s.cursed and 3*math.pi/4 or math.pi/2\n  local middle=s.kbAngle+s.rotation*arc/2\n  local finish=s.kbAngle+s.rotation*arc\n  local mx=s.cx+math.sin(middle)*18.5;local mz=s.cz+math.cos(middle)*18.5\n  s.endNearReflection=math.cos(finish-s.refAngle)>0\n  s.farPoint(s.endNearReflection)\n  local ex,ez=s.tx,s.tz\n  if not ex then return end\n  if not s.midPassed then\n   local dx,dz=me.pos.x-s.cx,me.pos.z-s.cz\n   local progress=((math.atan2(dx,dz)-s.kbAngle+math.pi)%(2*math.pi)-math.pi)*s.rotation\n   local reached=(me.pos.x-mx)^2+(me.pos.z-mz)^2<=2^2\n   if reached or (dx*dx+dz*dz>1 and progress>=arc/2 and progress<=arc+math.pi/2) then s.midPassed=true end\n  end\n  if s.midPassed then s.tx=ex;s.tz=ez\n  else s.tx=mx;s.tz=mz;s.nextX=ex;s.nextZ=ez end\n  s.label=s.cursed and \"Puddles: clockwise at drop pace\" or \"Puddles: rotate away at drop pace\"\n  return\n end\n if s.firstCards==nil or not s.kick or s.markerCount<4 then s.point(s.angles[role.key],6,\"Diamond Dust clocks\");return end\n local marked=s.marked[me.id]==true\n local support=role.key:sub(1,1)==\"T\" or role.key:sub(1,1)==\"H\"\n local wantCards=marked~=s.firstCards\n local h=s.angles[(support==wantCards) and role.key or s.partners[role.key]]\n if prefs and prefs.region==\"JP\" then h=s.angles[role.key]-(support~=wantCards and math.pi/4 or 0) end\n if not s.kbAngle and s.firstG1Angle then s.kbAngle=s.firstG1Angle+(role.key:sub(2,2)==\"1\" and 0 or math.pi) end\n if marked and s.dropped or not marked and s.coneDone then\n  if s.kbAngle then s.point(s.kbAngle,6,\"Knockback: first-circle safe lane\") end\n elseif marked then\n  local radius=s.kick==\"Axe\" and 19 or (s.kickDone and 12 or 3.4)\n  s.point(h,radius,s.kickDone and \"Hold for own Frigid Stone hit\" or \"Marked: colour-pair position\")\n elseif s.kick==\"Axe\" and not s.kickDone then s.point(h,16.5,\"Unmarked: bait just outside Axe Kick\")\n else s.point(h,.5,s.kickDone and \"Move in now; finish cone bait\" or \"Unmarked: close cone bait\") end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"313e9a9b-8c9f-8296-8ee8-aa9f34591ebb",
									true,
								},
							},
							name = "Initialize NA colour-pair route",
							uuid = "74ca1649-d80c-841e-ab2f-a9a5147f02de",
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
							name = "Diamond Dust events",
							spellIDList = 
							{
								40197,
							},
							uuid = "313e9a9b-8c9f-8296-8ee8-aa9f34591ebb",
							version = 3,
						},
					},
				},
				displayPath = "P2 Diamond Dust",
				eventType = 3,
				mechanicTime = 235.3,
				name = "[DD] Initialize route",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 1,
				timerStartOffset = -7,
				uuid = "40ebeab3-a741-ee05-a51e-b227aba8d3da",
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
							actionLua = "local s=data.frog_fru_dd\nif not s or not s.active then self.used=true return end\nlocal id=eventArgs.spellID\nif id==40198 and not s.kbAt then s.kbAt=Now()+13000 end\nif id==40208 and not s.iceAt then s.iceAt=Now()+14200 end\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif not actor then self.used=true return end\nif id==40198 and s.firstCards==nil then\n local dx,dz=actor.pos.x-s.cx,actor.pos.z-s.cz\n if dx*dx+dz*dz>25 then\n  s.firstCards=math.abs(dx)<1 or math.abs(dz)<1\n  local mana=(FrogFRUDrawSettings or {}).region==\"JP\"\n  local flip\n  if mana then flip=dz>0.1 or (math.abs(dz)<=0.1 and dx>0)\n  else flip=dx>0.1 or (math.abs(dx)<=0.1 and dz>0) end\n  if flip then dx=-dx;dz=-dz end\n  s.firstG1Angle=math.atan2(dx,dz)\n end\nelseif id==40202 or id==40203 then\n s.kick=id==40202 and \"Axe\" or \"Scythe\";s.reflectionID=actor.id\n s.cx=actor.pos.x;s.cz=actor.pos.z;s.y=actor.pos.y\nelseif id==40193 or id==40194 then\n s.arrowHoldAfterDeadline=false;s.comboKind=id==40193 and \"Stillness\" or \"Silence\";s.comboStep=1;s.comboFirstAt=Now()+eventArgs.channelTimeMax*1000;s.comboSecondAt=s.comboFirstAt+2400;s.comboPreview=false;s.phase=\"combo\";s.reflectionID=actor.id\nelseif id==40210 then\n s.phase=\"awaitStack\";s.clear()\n local prefs=FrogFRUDrawSettings\n if prefs and prefs.release then prefs.release(data,\"frog_fru_dd\")end\nend\ns.solve()\nself.used=true\n",
							conditions = 
							{
								
								{
									"68545003-a25d-2178-9b00-cd843b1317e5",
									true,
								},
							},
							name = "Read icicles, kicks and slide order",
							uuid = "63bbe11f-7349-b65c-b44e-37d5e17eb5e3",
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
							name = "Diamond Dust events",
							spellIDList = 
							{
								40198,
								40202,
								40203,
								40193,
								40194,
								40210,
								40208,
							},
							uuid = "68545003-a25d-2178-9b00-cd843b1317e5",
							version = 3,
						},
					},
				},
				displayPath = "P2 Diamond Dust",
				eventType = 3,
				loop = true,
				mechanicTime = 235.3,
				name = "[DD] Read icicles, kicks and slide order",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 50,
				uuid = "8e9b774e-123d-f701-b609-3f611040ca7f",
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
							actionLua = "local s=data.frog_fru_dd\nif s and s.active and not s.marked[eventArgs.entityID] then\n s.marked[eventArgs.entityID]=true;s.markerCount=s.markerCount+1;s.solve()\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"43434c6a-138b-6421-a1b7-1d2ad106c912",
									true,
								},
							},
							name = "Track Frigid Stone prey markers",
							uuid = "672b8887-c182-a9d2-82bb-a85bf390de4b",
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
							eventMarkerID = 345,
							name = "Frigid Stone prey",
							uuid = "43434c6a-138b-6421-a1b7-1d2ad106c912",
							version = 3,
						},
					},
				},
				displayPath = "P2 Diamond Dust",
				eventType = 4,
				loop = true,
				mechanicTime = 235.3,
				name = "[DD] Track Frigid Stone prey markers",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 9,
				timerStartOffset = 1,
				uuid = "5098f253-be70-62a9-9af8-ff4312afc718",
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
							actionLua = "local s=data.frog_fru_dd\nif not s or not s.active then self.used=true return end\nlocal id=eventArgs.spellID\nlocal me=TensorCore.mGetPlayer()\nlocal own=false\nif me then for i=1,8 do local target=eventArgs.hitTargets[i];if target==nil then break end; if target==me.id then own=true;break end end end\nif id==40202 or id==40203 then s.kickDone=true\nelseif id==40206 then\n if own then s.coneDone=true end\nelseif id==40199 and own then s.dropped=true\nelseif id==40207 then s.kbDone=true\nelseif id==40200 or id==40201 then s.needlesDone=true\nelseif id==40209 then\n if eventArgs.castPosX and eventArgs.castPosZ then\n  s.puddles[#s.puddles+1]={x=eventArgs.castPosX,z=eventArgs.castPosZ}\n end\n if not s.lastHoly or Now()-s.lastHoly>700 then\n  s.lastHoly=Now();s.holyCount=s.holyCount+1\n  if s.holyCount>=4 then s.phase=\"preIce\" end\n end\nelseif id==40184 then s.ice=true\nelseif (id==40193 or id==40194) and s.phase==\"combo\" and s.comboStep==1 then s.comboStep=2\nelseif (id==40195 or id==40196) and s.phase==\"combo\" then s.arrowHoldAfterDeadline=false;s.phase=\"awaitStack\";s.tx=nil;s.tz=nil\nelseif id==40211 then s.active=false;s.clear() end\nif s.active then s.solve() end\nself.used=true\n",
							conditions = 
							{
								
								{
									"1c0662b0-cb5c-257f-b2da-f3f5684a064c",
									true,
								},
							},
							name = "Advance on mechanic resolution",
							uuid = "647df50c-ff7a-1e56-81de-f0c3269c9447",
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
							name = "Diamond Dust events",
							spellIDList = 
							{
								40202,
								40203,
								40206,
								40199,
								40207,
								40200,
								40201,
								40209,
								40184,
								40193,
								40194,
								40195,
								40196,
								40211,
							},
							uuid = "1c0662b0-cb5c-257f-b2da-f3f5684a064c",
							version = 3,
						},
					},
				},
				displayPath = "P2 Diamond Dust",
				eventType = 2,
				loop = true,
				mechanicTime = 235.3,
				name = "[DD] Advance on mechanic resolution",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 50,
				uuid = "e1eab5a4-47c0-4ab0-9ba4-af04ffb1d638",
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
							actionLua = "local s=data.frog_fru_dd\nif not s then self.used=true return end\nif s.line or s.circle or s.routeLine or s.routeCircle then s.clear() end\nlocal prefs=FrogFRUDrawSettings\nif s.phase==\"stack\" or s.phase==\"awaitStack\" then\n s.clear()\n if prefs and prefs.release then prefs.release(data,\"frog_fru_dd\")end\n self.used=true return\nend\nlocal me=TensorCore.mGetPlayer()\nif not s.active or not me or me.hp.current<=0 or Now()-s.started>60000 or (prefs and prefs.dd==false) then\n s.clear();self.used=true return\nend\ns.solve()\nself.used=true\n",
							name = "Update Diamond Dust position",
							uuid = "a1970ba3-30e0-5090-9316-e3135004f134",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Diamond Dust",
				loop = true,
				mechanicTime = 235.3,
				name = "[DD] Update personal destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 50,
				timerStartOffset = -7,
				uuid = "cab39077-416d-4e4c-9f77-6ef0ec17c3e6",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_dd\nlocal player=TensorCore.mGetPlayer()\nlocal key=\"frog_fru_dd\"\nlocal routeKey=\"frog_fru_dd_next\"\nif not prefs or not prefs.guide then self.used=true return end\nif not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>60000 then\n prefs.release(data,key);prefs.release(data,routeKey);self.used=true return\nend\nlocal style=\"dd\"\nlocal mode=prefs.styleFor(style)\nif mode==\"Disabled\" then prefs.release(data,key);prefs.release(data,routeKey);self.used=true return end\ns.keepVisible=s.phase~=\"preIce\"\nlocal leg=s.midPassed==true\nif s.drawLeg~=nil and s.drawLeg~=leg then prefs.release(data,key) end\ns.drawLeg=leg\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\ns.arrowStage=nil;s.arrowHoldAfterDeadline=false;s.arrowDeadline=nil\nif prefs.castDeadline then\n if not s.kbDone and label==\"Knockback: first-circle safe lane\" then s.arrowStage=\"dd-knockback\";s.arrowDeadline=s.kbAt\n elseif not s.ice and ((s.kbDone and s.needlesDone) or s.phase==\"preIce\") then\n  local final=s.midPassed or s.phase==\"preIce\"\n  s.arrowStage=final and \"dd-puddle-final\" or \"dd-puddle-first\";s.arrowDeadline=s.iceAt\n  if final then label=\"Puddles: final position\" end\n elseif s.phase==\"combo\" then\n  s.arrowHoldAfterDeadline=true\n  s.arrowDeadline=(s.comboPreview or s.comboStep==2) and s.comboSecondAt or s.comboFirstAt\n elseif s.phase==\"resolve\" and not s.kbDone and not s.kickDone and s.kick then s.arrowDeadline=prefs.castDeadline(data,s,{40202,40203})\n elseif s.kbDone and not s.needlesDone then s.arrowDeadline=prefs.castDeadline(data,s,{40200,40201}) end\nend\nprefs.guide(data,key,style,s,player,x,y,z,label,nil,6)\nif s.nextX and s.nextZ then\n if mode==\"Tether\" then\n  prefs.release(data,routeKey)\n  local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  local drawer=TensorCore.getStaticDrawer(0xFF00FFFF,1,0,flags)\n  drawer:addLine(x,y,z,s.nextX,y,s.nextZ,3,1)\n else\n  if not s.routeOrigin then s.routeOrigin={pos={}} end\n  local pos=s.routeOrigin.pos\n  pos.x=x;pos.y=y;pos.z=z\n  if not s.routeOwner then s.routeOwner={keepVisible=true,stage=\"puddle-route\"}end\n  s.routeOwner.arrowDeadline=nil\n  prefs.guide(data,routeKey,style,s.routeOwner,s.routeOrigin,s.nextX,y,s.nextZ,\"Route endpoint\",nil,3)\n end\nelse prefs.release(data,routeKey) end\nself.used=true",
							name = "Render tether and chained waypoints every frame",
							uuid = "9536ecf5-0e2d-71e8-8ef5-40947913ac64",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Diamond Dust",
				eventType = 12,
				mechanicTime = 235.3,
				name = "[DD] Draw personal tether and route",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 50,
				timerStartOffset = -7,
				uuid = "80a321e0-53e4-435f-912c-f770413617a6",
				version = 2,
			},
		},
	},
	[68] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Mirror Mirror",
				uuid = "bb2b3dc7-01d3-2575-84e5-d05d5f3884a8",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nif prefs and prefs.mm==false then self.used=true return end\nif data.frog_fru_mm and data.frog_fru_mm.active then self.used=true return end\nlocal s={active=true,started=Now(),phase=\"bluePull\",red={},firstHits={},firstCount=0,redHits={},redCount=0,\n slots={H1=1,R1=2,R2=3,H2=4,T1=1,M1=2,M2=3,T2=4},\n partners={T1=\"M1\",M1=\"T1\",T2=\"M2\",M2=\"T2\",H1=\"R1\",R1=\"H1\",H2=\"R2\",R2=\"H2\"},\n points={},bossSelector={contentid=12809,subgroup=\"Nearest\"}}\ndata.frog_fru_mm=s\nfunction s.angle(dir) return math.pi-(dir-1)*math.pi/4 end\nfunction s.delta(a,b) return (a-b+math.pi)%(2*math.pi)-math.pi end\nfunction s.isMelee(role) return role==\"T1\" or role==\"T2\" or role==\"M1\" or role==\"M2\" end\nfunction s.at(h,r) s.tx=100+math.sin(h)*r;s.tz=100+math.cos(h)*r end\n                                                                                        \nfunction s.makeFan(h,v,radii)\n local points={};local x,z=100+20*math.sin(h),100+20*math.cos(h)\n for i=1,4 do local radius=radii and radii[i] or 3.2;points[i]={x=x+radius*math.sin(h+v[i]),z=z+radius*math.cos(h+v[i]),h=h+v[i]} end\n return points\nend\nfunction s.crossMargin(h,points,other)\n local x,z=100+20*math.sin(h),100+20*math.cos(h);local margin=math.pi\n for i=1,4 do for j=1,4 do\n  local bearing=math.atan2(other[j].x-x,other[j].z-z)\n  margin=math.min(margin,math.abs(s.delta(points[i].h,bearing)))\n end end\n return margin\nend\nfunction s.layout()\n if not s.blue or #s.red~=2 then return end\n local blue=s.angle(s.blue);local r1,r2=s.angle(s.red[1]),s.angle(s.red[2])\n local d1,d2=math.abs(s.delta(r1,blue)),math.abs(s.delta(r2,blue))\n local ranged\n if math.abs(d1-d2)<0.001 then\n  ranged=(blue-r1)%(2*math.pi)<(blue-r2)%(2*math.pi) and 1 or 2\n else ranged=d1<d2 and 1 or 2 end\n s.rangedDir=s.red[ranged];s.meleeDir=s.red[3-ranged]\n local mh,rh=s.angle(s.meleeDir),s.angle(s.rangedDir)\n local function fan(h,other)\n  if s.delta(other,h)>0 then\n   return s.makeFan(h,{100*math.pi/180,math.pi,5*math.pi/4,260*math.pi/180},{3.2,2.4,2.8,3.2})\n  end\n  return s.makeFan(h,{100*math.pi/180,3*math.pi/4,math.pi,260*math.pi/180},{3.2,2.8,2.4,3.2})\n end\n local melee=fan(mh,rh)\n local rangedPoints=fan(rh,mh)\n local best=math.min(s.crossMargin(mh,melee,rangedPoints),s.crossMargin(rh,rangedPoints,melee))\n s.layoutMargin=best\n if best<20*math.pi/180 then s.layoutReady=false;return end\n s.meleePoints=melee;s.rangedPoints=rangedPoints;s.layoutReady=true\nend\nfunction s.solve()\n s.tx=nil;s.tz=nil;s.partnerID=nil;s.precise=false\n local prefs=FrogFRUDrawSettings\n if not s.active or (prefs and prefs.mm==false) or Now()-s.started>41000 then return end\n local role=data.frog_fru_role and data.frog_fru_role.key\n if not role or not s.slots[role] or not s.blue then return end\n local boss=s.bossID and TensorCore.mGetEntity(s.bossID) or TensorCore.getEntityByGroup(\"ContentID\",s.bossSelector)\n local melee=s.isMelee(role);local blue=s.angle(s.blue)\n if s.phase==\"pairs\" then\n  if AnyoneCore and AnyoneCore.Roster.isReady() then s.partnerID=AnyoneCore.Roster.idOf(s.partners[role]) end\n  local partner=s.partnerID and TensorCore.mGetEntity(s.partnerID)\n  if partner then s.tx=partner.pos.x;s.tz=partner.pos.z;s.y=partner.pos.y end\n  return\n elseif s.phase==\"spread\" then\n  if not melee or not boss then return end\n  local left=role==\"T1\" or role==\"M1\"\n  local front=role==\"T1\" or role==\"T2\"\n  local h=boss.pos.h+(left and 1 or -1)*(front and math.pi/4 or 3*math.pi/4)\n  s.tx=boss.pos.x+math.sin(h)*(boss.hitradius+2.5)\n  s.tz=boss.pos.z+math.cos(h)*(boss.hitradius+2.5);s.y=boss.pos.y\n  return\n elseif s.phase==\"bluePull\" and role==\"T1\" then\n  s.at(blue+math.pi,19);s.label=\"Pull Shiva opposite blue mirror\"\n  return\n elseif s.phase==\"blueBait\" or s.phase==\"bluePull\" then\n  local h=melee and blue+math.pi or blue\n  local p=(melee and s.blueMeleePoints or s.blueRangedPoints)[(not melee and prefs and prefs.region==\"EU\") and (5-s.slots[role]) or s.slots[role]]\n  local x,z=p.x,p.z\n  if melee and boss then\n   x=x-(100+20*math.sin(h))+boss.pos.x\n   z=z-(100+20*math.cos(h))+boss.pos.z\n  end\n  s.precise=true;s.tx=x;s.tz=z;s.y=boss and boss.pos.y or 0;s.label=s.phase==\"bluePull\" and \"Prepare first protean bait\" or \"First protean bait\";return\n elseif s.phase==\"redPull\" or s.phase==\"redBait\" then\n  if not s.layoutReady then return end\n  if role==\"T1\" and s.phase==\"redPull\" and s.redBaitAt and Now()<s.redBaitAt then\n   s.at(s.angle(s.meleeDir),19);s.label=\"Pull Shiva to melee red mirror\";return\n  end\n  local slot=s.slots[role]\n  if melee and prefs and prefs.region==\"EU\" then\n   local toward=s.delta(s.angle(s.rangedDir),s.angle(s.meleeDir))>0\n   if role==\"T1\" then slot=toward and 1 or 4\n   elseif role==\"T2\" then slot=toward and 4 or 1\n   elseif role==\"M1\" then slot=toward and 2 or 3\n   else slot=toward and 3 or 2 end\n  end\n  if not melee and prefs and prefs.region==\"EU\" then\n   if role==\"R1\" then slot=4 elseif role==\"H1\" then slot=3 elseif role==\"H2\" then slot=2 else slot=1 end\n  end\n  local p=(melee and s.meleePoints or s.rangedPoints)[slot]\n  s.precise=true;s.tx=p.x;s.tz=p.z;s.y=0;s.label=\"Red protean bait: leave inter-group gap\"\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"32e4d7fb-f796-2b83-85da-fb51545f5d36",
									true,
								},
							},
							name = "Initialize mirror guidance",
							uuid = "f4e07b5a-f130-c336-b004-bc5130389766",
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
							name = "Mirror mechanic casts",
							spellIDList = 
							{
								40179,
							},
							uuid = "32e4d7fb-f796-2b83-85da-fb51545f5d36",
							version = 3,
						},
					},
				},
				displayPath = "P2 Mirror Mirror",
				eventType = 3,
				mechanicTime = 292.6,
				name = "[Mirrors] Initialize mirror guidance",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 1,
				timerStartOffset = -4,
				uuid = "71265117-da78-f2a4-9268-0c010f600062",
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
							actionLua = "local s=data.frog_fru_mm\nif not s or not s.active then self.used=true return end\nlocal a=eventArgs;local dir=a.a1\nif dir>=1 and dir<=8 then\n if a.a2==256 and a.a3==512 then\n  local seen=false;for _,d in ipairs(s.red) do if d==dir then seen=true end end\n  if not seen and #s.red<2 then s.red[#s.red+1]=dir;s.layout() end\n elseif a.a2==1 and a.a3==2 then\n  s.blue=dir;s.layout()\n  local h=s.angle(dir)\n                                                                               \n  s.blueMeleePoints=s.makeFan(h+math.pi,{math.pi/4,3*math.pi/4,-3*math.pi/4,-math.pi/4},{2.4,2.4,2.4,2.4})\n  s.blueRangedPoints=s.makeFan(h,{100*math.pi/180,3*math.pi/4,5*math.pi/4,260*math.pi/180},{2.4,2.8,2.8,2.4})\n end\nend\ns.solve();self.used=true",
							name = "Read mirror colours and directions",
							uuid = "c9f1f19f-7b76-2a8f-a878-62722941442a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Mirror Mirror",
				eventType = 14,
				loop = true,
				mechanicTime = 292.6,
				name = "[Mirrors] Read mirror colours and directions",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 35,
				timerStartOffset = -4,
				uuid = "c7be1e0b-c411-2de6-b491-98d0ada53aa7",
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
							actionLua = "local s=data.frog_fru_mm\nif not s or not s.active then self.used=true return end\nlocal a=eventArgs\nif a.spellID==40203 and a.entityContentID==12809 then\n s.bossID=a.entityID;s.phase=\"blueBait\";s.blueDeadline=Now()+a.channelTimeMax*1000\nelseif a.spellID==40205 then\n local deadline=Now()+a.channelTimeMax*1000\n s.redDeadline=s.redDeadline and math.min(s.redDeadline,deadline) or deadline\n local at=Now()+math.max(0,a.channelTimeMax-2)*1000\n s.redBaitAt=s.redBaitAt and math.min(s.redBaitAt,at) or at\nelseif (a.spellID==40220 or a.spellID==40221) and a.entityContentID==12809 then\n s.bossID=a.entityID;s.phase=a.spellID==40220 and \"pairs\" or \"spread\";s.banishDeadline=Now()+a.channelTimeMax*1000\nend\ns.solve();self.used=true\n",
							conditions = 
							{
								
								{
									"164fa057-6126-e4ef-b03a-0c1281bfb8e5",
									true,
								},
							},
							name = "Read kick and Banish casts",
							uuid = "5fdb1618-70b7-d7a7-904d-6ae285112eef",
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
							name = "Mirror mechanic casts",
							spellIDList = 
							{
								40203,
								40205,
								40220,
								40221,
							},
							uuid = "164fa057-6126-e4ef-b03a-0c1281bfb8e5",
							version = 3,
						},
					},
				},
				displayPath = "P2 Mirror Mirror",
				eventType = 3,
				loop = true,
				mechanicTime = 292.6,
				name = "[Mirrors] Read kick and Banish casts",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 35,
				timerStartOffset = -4,
				uuid = "11397877-deea-0ed3-8aa3-df70565bfd31",
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
							actionLua = "local s=data.frog_fru_mm\nif not s or not s.active then self.used=true return end\nlocal a=eventArgs\nif a.spellID==40206 then\n if s.phase==\"blueBait\" and not s.firstHits[a.entityID] then\n  s.firstHits[a.entityID]=true;s.firstCount=s.firstCount+1\n  if s.firstCount>=8 then s.phase=\"redPull\" end\n elseif (s.phase==\"redPull\" or s.phase==\"redBait\") and s.redBaitAt and Now()>=s.redBaitAt and not s.redHits[a.entityID] then\n  s.redHits[a.entityID]=true;s.redCount=s.redCount+1\n  if s.redCount>=8 then s.phase=\"awaitBanish\" end\n end\nelseif a.spellID==40220 or a.spellID==40221 or a.spellID==40222 or a.spellID==40223 then\n s.active=false\nend\ns.solve();self.used=true\n",
							conditions = 
							{
								
								{
									"8451a42b-1974-74a7-9603-1596281f370c",
									true,
								},
							},
							name = "Advance after protean volleys",
							uuid = "b274dfc0-ab89-ad0f-8f22-622778365960",
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
							name = "Mirror mechanic casts",
							spellIDList = 
							{
								40206,
								40220,
								40221,
								40222,
								40223,
							},
							uuid = "8451a42b-1974-74a7-9603-1596281f370c",
							version = 3,
						},
					},
				},
				displayPath = "P2 Mirror Mirror",
				eventType = 2,
				loop = true,
				mechanicTime = 292.6,
				name = "[Mirrors] Advance after protean volleys",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 35,
				timerStartOffset = -4,
				uuid = "d8096ab9-8478-21a5-be7f-055292b40e52",
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
							actionLua = "local s=data.frog_fru_mm\nif s then s.solve() end\nself.used=true\n",
							name = "Update personal mirror destination",
							uuid = "b5b5559b-035f-941c-a93f-2d856b07ea84",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Mirror Mirror",
				loop = true,
				mechanicTime = 292.6,
				name = "[Mirrors] Update personal mirror destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 35,
				timerStartOffset = -4,
				uuid = "46bd902e-c38b-d08f-b86f-f1d44b895474",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_mm\nlocal player=TensorCore.mGetPlayer()\nif prefs and s and s.active and prefs.banishVersion~=2 then\n local p=prefs\nif p.banishVersion~=2 then\n function p.drawBanish(kind,deadline,style,state,role)\n  if (kind~=\"pairs\" and kind~=\"spread\")or not deadline or Now()>deadline+700 or p.styleFor(style)==\"Disabled\" then return end\n  if not AnyoneCore or not AnyoneCore.Roster.isReady()then return end\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  if kind==\"spread\" then\n   if not p.spreadDrawer then p.spreadDrawer=TensorCore.getCachedDrawer(0x300040FF,nil,0x300040FF,0xD06080FF,2,0,flags)end\n   for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n    local id=AnyoneCore.Roster.idOf(key);local actor=id and TensorCore.mGetEntity(id)\n    if actor and actor.pos and actor.hp.current>0 then p.spreadDrawer:addCircle(actor.pos.x,actor.pos.y+.04,actor.pos.z,5,false,flags)end\n   end\n   return\n  end\n  local me=TensorCore.mGetPlayer()\n  if not me or not me.pos or me.hp.current<=0 then return end\n  local partnerRole\n  if state and role and AnyoneCore.Roster.idOf(role)==me.id then\n   if style==\"mm\" and state.partners then partnerRole=state.partners[role]\n   elseif style==\"lr\" and state.pairAnchor then\n    local anchor=state.pairAnchor[role]\n    if anchor then\n     for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n      if key~=role and state.pairAnchor[key]==anchor then\n       if partnerRole then partnerRole=nil;break end\n       partnerRole=key\n      end\n     end\n    end\n   end\n  end\n  local id=partnerRole and AnyoneCore.Roster.idOf(partnerRole)\n  local partner=id and id~=me.id and TensorCore.mGetEntity(id)\n  local ready=partner and partner.pos and partner.hp.current>0 and (me.pos.x-partner.pos.x)^2+(me.pos.z-partner.pos.z)^2<=4.5^2\n  flags=flags+Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  if not p.banishRangeOutline then p.banishRangeOutline=TensorCore.getCachedDrawer(0,0,0,0xF0101010,6,0,flags)end\n  if not p.banishRangeGood then p.banishRangeGood=TensorCore.getCachedDrawer(0,0,0,0xFF40E080,3,0,flags)end\n  if not p.banishRangeBad then p.banishRangeBad=TensorCore.getCachedDrawer(0,0,0,0xFF4040FF,3,0,flags)end\n  p.banishRangeOutline:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n  local drawer=ready and p.banishRangeGood or p.banishRangeBad\n  drawer:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n end\n p.banishVersion=2\nend\nend\nif prefs and prefs.drawBanish and s and s.active then prefs.drawBanish(s.phase,s.banishDeadline,\"mm\",s,data.frog_fru_role and data.frog_fru_role.key)end\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then if prefs and prefs.release then prefs.release(data,\"frog_fru_mm\")end;self.used=true return end\nlocal role=data.frog_fru_role and data.frog_fru_role.key\nif s.phase==\"bluePull\" and (role==\"T1\" or role==\"T2\" or role==\"M1\" or role==\"M2\") then\n prefs.release(data,\"frog_fru_mm\");self.used=true return\nend\nlocal style=\"mm\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_mm\");self.used=true return end\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\nif s.phase==\"blueBait\" then s.arrowDeadline=s.blueDeadline\nelseif s.phase==\"redPull\" or s.phase==\"redBait\" then\n local role=data.frog_fru_role\n if role and role.key==\"T1\" and s.redBaitAt and Now()<s.redBaitAt then s.arrowDeadline=s.redBaitAt\n else s.arrowDeadline=s.redDeadline end\nelseif s.phase==\"pairs\" or s.phase==\"spread\" then s.arrowDeadline=s.banishDeadline\nelse s.arrowDeadline=nil end\ns.keepVisible=not s.precise\ns.arrivalRadius=s.precise and .2 or nil\nif s.precise then\n local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local near=(player.pos.x-x)^2+(player.pos.z-z)^2<=.04\n local drawer=TensorCore.getStaticDrawer(near and 0xFF40E080 or 0xFF00FFFF,1,0,flags)\n drawer:addCircle(x,y+.035,z,.12,true,flags)\nend\nprefs.guide(data,\"frog_fru_mm\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw personal mirror tether",
							uuid = "54682bbb-b8fd-f4e7-a02e-45001a558818",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Mirror Mirror",
				eventType = 12,
				mechanicTime = 292.6,
				name = "[Mirrors] Draw personal mirror tether",
				timeRange = true,
				timelineIndex = 68,
				timerEndOffset = 35,
				timerStartOffset = -4,
				uuid = "1f0a745d-d635-388b-a602-608034f9bcc3",
				version = 2,
			},
		},
	},
	[80] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Light Rampant",
				uuid = "1efa6649-b5f1-f63d-b80c-7f73317e00f8",
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
							actionLua = "local s=data.frog_fru_lr\nif not s or not s.active or not s.assigned then self.used=true return end\nlocal a=eventArgs\nif a.spellID==40218 then\n local id=a.targetID;local role=s.byID[id]\n if role and s.baits[role] and (not s.lastHammer[id] or Now()-s.lastHammer[id]>700) then\n  s.lastHammer[id]=Now();s.hammers[id]=(s.hammers[id] or 0)+1\n  if s.hammers[id]>=5 then s.assignments[role].done=true end\n end\nelseif a.spellID==40213 and a.castPosX and a.castPosZ then\n for _,p in pairs(s.assignments) do\n  if not p.bait and (p.x-a.castPosX)^2+(p.z-a.castPosZ)^2<2^2 then p.done=true end\n end\nend\ns.solve();self.used=true\n",
							conditions = 
							{
								
								{
									"dd23670e-b733-99f1-9775-f57c46a38c2b",
									true,
								},
							},
							name = "Advance own towers and puddles",
							uuid = "21214ea8-d3bf-3157-a4de-4e3612716659",
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
							name = "First-stage resolutions",
							spellIDList = 
							{
								40213,
								40218,
							},
							uuid = "dd23670e-b733-99f1-9775-f57c46a38c2b",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 2,
				loop = true,
				mechanicTime = 331.8,
				name = "[LR] Advance own towers and puddles",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 16,
				timerStartOffset = -7.5,
				uuid = "ca77f00a-ec1b-2340-8746-d3d660ba8e3b",
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
							actionLua = "local s=data.frog_fru_lr\nif not s or not s.active then self.used=true return end\nlocal role=s.byID[eventArgs.entityID]\nif role and not s.baits[role] then s.baits[role]=true;s.baitCount=s.baitCount+1;s.assign();s.solve() end\nself.used=true\n",
							conditions = 
							{
								
								{
									"631218ed-38e6-d088-b969-4cac8558af25",
									true,
								},
							},
							name = "Assign first towers and puddles",
							uuid = "2ebc7632-da89-3de7-adb8-1640c8413723",
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
							eventMarkerID = 375,
							name = "Puddle marker",
							uuid = "631218ed-38e6-d088-b969-4cac8558af25",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 4,
				loop = true,
				mechanicTime = 331.8,
				name = "[LR] Assign first towers and puddles",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 16,
				timerStartOffset = -7.5,
				uuid = "206fa616-d248-d8b9-b994-b0145d4e9a9a",
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
							actionLua = "if FrogFRUDrawSettings and FrogFRUDrawSettings.lr==false then self.used=true return end\nif data.frog_fru_lr then self.used=true return end\nif not AnyoneCore then return end\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nlocal me=TensorCore.mGetPlayer()\nif not me or type(members)~=\"table\" or type(party)~=\"table\" then return end\nlocal keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nlocal candidates,seen={},{}\nfor _,actor in pairs(party)do\n if not seen[actor.id] then candidates[#candidates+1]=actor;seen[actor.id]=true end\nend\nif not seen[me.id] then candidates[#candidates+1]=me end\nif #candidates~=8 then return end\nlocal ids,used={},{}\nlocal myRole\nfor _,key in ipairs(keys)do\n local member=members[key]\n if not member or not member.job then return end\n local match,count=nil,0\n for _,actor in ipairs(candidates)do\n  if actor.name==member.name and actor.job==member.job then match=actor;count=count+1 end\n end\n if count==0 then\n  local copies=0\n  for _,other in ipairs(keys)do if members[other] and members[other].job==member.job then copies=copies+1 end end\n  if copies==1 then\n   for _,actor in ipairs(candidates)do if actor.job==member.job then match=actor;count=count+1 end end\n  end\n end\n if count~=1 or used[match.id] then return end\n ids[key]=match.id;used[match.id]=true\n if match.id==me.id then myRole=key end\nend\nif not myRole then return end\nlocal s={active=true,started=Now(),ids={},byID={},baits={},baitCount=0,assignments={},hammers={},lastHammer={},\n order={\"H1\",\"H2\",\"T1\",\"T2\",\"M2\",\"M1\",\"R2\",\"R1\"},\n columns={H1=1,H2=2,T1=3,T2=4,R1=1,R2=2,M1=3,M2=4},\n starts={H1={95.5,98.7},H2={98.5,97.5},T1={101.5,97.5},T2={104.5,98.7},R1={95.5,101.3},R2={98.5,102.5},M1={101.5,102.5},M2={104.5,101.3}},\n towers={{113.856,92},{100,116},{86.144,92},{113.856,108},{100,84},{86.144,108}}}\nlocal region=(FrogFRUDrawSettings or {}).region\nif region==\"JP\" or region==\"Elemental\" then\n s.order={\"H1\",\"H2\",\"T1\",\"T2\",\"R2\",\"R1\",\"M2\",\"M1\"}\n s.columns={H1=1,H2=2,T1=3,T2=4,M1=1,M2=2,R1=3,R2=4}\nend\nif region==\"JP\" then s.towers={{83.806,90.65},{100,118.7},{116.194,90.65},{83.806,109.35},{100,81.3},{116.194,109.35}} end\nfor _,role in ipairs(s.order) do\n local id=ids[role]\n if not id or id==0 then return end\n s.ids[role]=id;s.byID[id]=role\nend\ns.role=myRole\nif not s.starts[s.role] then return end\nlocal boss=TensorCore.getEntityByGroup(\"ContentID\",{contentid=12809,subgroup=\"Nearest\"})\nlocal bx,bz=boss and boss.pos.x or 100,boss and boss.pos.z or 100\nlocal minimum=(boss and boss.hitradius or 0)+2.25\nlocal function line(first,last,roles,north)\n local ax,ay,az,aa=Argus.getWaymarkInfo(first)\n local ex,ey,ez,ea=Argus.getWaymarkInfo(last)\n local x,z,ux,uz=100,north and 86 or 114,1,0\n if aa and ea then\n  x=(ax+ex)/2;z=(az+ez)/2\n  local length=math.sqrt((ex-ax)^2+(ez-az)^2)\n  if length>0.1 then ux=(ex-ax)/length;uz=(ez-az)/length end\n end\n local dx,dz=x-bx,z-bz;local length=math.sqrt(dx*dx+dz*dz)\n if length<minimum then\n  if length<0.1 then dx,dz,length=0,north and -1 or 1,1 end\n  x=bx+dx/length*minimum;z=bz+dz/length*minimum\n end\n for i,key in ipairs(roles)do\n  local offset=(i-2.5)*3\n  s.starts[key]={x+ux*offset,z+uz*offset}\n end\nend\nline(5,6,{\"H1\",\"H2\",\"T1\",\"T2\"},true)\nif region==\"Elemental\" then line(8,7,{\"M1\",\"M2\",\"R1\",\"R2\"},false)\nelseif region==\"JP\" then\n local ring={H1={94,98},H2={97,94},T1={103,94},T2={106,98},M1={94,102},M2={97,106},R1={103,106},R2={106,102}}\n for _,p in pairs(ring)do local dx,dz=p[1]-100,p[2]-100;local d=math.sqrt(dx*dx+dz*dz);p[1]=p[1]+dx/d*.75;p[2]=p[2]+dz/d*.75 end\n s.starts=ring\nelse line(8,7,{\"R1\",\"R2\",\"M1\",\"M2\"},false) end\ndata.frog_fru_lr=s\nfunction s.assign()\n if s.assigned or s.baitCount~=2 then return end\n local towers,baits={},{};local supports=0\n for i,role in ipairs(s.order) do\n  if s.baits[role] then baits[#baits+1]=role\n  else towers[#towers+1]=role;if i<=4 then supports=supports+1 end end\n end\n if supports==2 and region~=\"JP\" then table.insert(towers,1,table.remove(towers,6)) end\n for i,role in ipairs(towers) do s.assignments[role]={x=s.towers[i][1],z=s.towers[i][2],bait=false} end\n local a,b=baits[1],baits[2];local west\n if s.columns[a]==s.columns[b] then\n  west=(a:sub(1,1)==\"M\" or a:sub(1,1)==\"R\") and a or b\n else west=s.columns[a]<s.columns[b] and a or b end\n if region==\"JP\" then west=baits[1] end\n for _,role in ipairs(baits) do s.assignments[role]={x=role==west and 83 or 117,z=100,bait=true,west=role==west} end\n if region==\"EU\" then\n  local an=a:sub(1,1)==\"T\" or a:sub(1,1)==\"H\"\n  local bn=b:sub(1,1)==\"T\" or b:sub(1,1)==\"H\"\n  local north\n  if an~=bn then north=an and a or b\n  else north=s.columns[a]<s.columns[b] and a or b end\n  s.assignments[a].north=a==north\n  s.assignments[b].north=b==north\n end\n s.assigned=true\nend\nfunction s.solve()\n s.tx=nil;s.tz=nil;s.nextX=nil;s.nextZ=nil;s.stage=nil\n if not s.active or (FrogFRUDrawSettings and FrogFRUDrawSettings.lr==false) or Now()-s.started>24000 then return end\n if not s.assigned then s.stage=\"lineup\";local p=s.starts[s.role];s.tx=p[1];s.tz=p[2];return end\n local a=s.assignments[s.role]\n if not a or a.done then return end\n if not a.bait then s.stage=\"tower\";s.tx=a.x;s.tz=a.z;return end\n local n=s.hammers[s.ids[s.role]] or 0\n s.stage=n==0 and \"puddle-start\" or n<3 and \"puddle-cross\" or \"puddle-end\"\n if region==\"EU\" then\n  local dx=({0,5,9,8,5})[n+1]\n  local dz=({-9,-5,0,5,12})[n+1]\n  if dx then\n   local sign=a.north and 1 or -1\n   s.tx=100+sign*dx;s.tz=100+sign*dz;s.stage=\"eu-puddle-\"..n\n  end\n  return\n end\n if region==\"JP\" then\n  local angle=({-45,-45,-75,-115,-155,165})[math.min(n+1,6)]*math.pi/180+(a.west and 0 or math.pi)\n  local radius=n==0 and 3.5 or n==1 and 10 or n<5 and 13.5 or 17\n  s.tx=100+radius*math.sin(angle);s.tz=100+radius*math.cos(angle);return\n end\n if n==0 then s.tx=a.x;s.tz=100\n elseif n<3 then s.tx=a.west and 94 or 106;s.tz=100;s.nextX=a.west and 98 or 102;s.nextZ=a.west and 84 or 116\n elseif n<5 then s.tx=a.west and 98 or 102;s.tz=a.west and 84 or 116 end\nend\ns.solve();self.used=true\n",
							name = "Initialize 4-4 E-W lineup",
							uuid = "e7228721-519b-1bdd-93e2-1a1bbecc9dff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				loop = true,
				mechanicTime = 331.8,
				name = "[LR] Initialize lineup",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = -1,
				timerStartOffset = -7.5,
				uuid = "faa9bfe9-e7d2-e9b1-b053-578fd21564cd",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_lr\nlocal player=TensorCore.mGetPlayer()\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then if prefs and prefs.release then prefs.release(data,\"frog_fru_lr\")end;self.used=true return end\nlocal style=\"lr\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_lr\");self.used=true return end\ns.keepVisible=true;s.arrowFromCenter=s.stage==\"tower\"\ns.arrowHoldAfterDeadline=true\ns.arrowDeadline=nil\nif s.stage==\"lineup\" then\n s.arrowDeadline=prefs.castDeadline and prefs.castDeadline(data,s,{40212}) or nil\nelseif s.stage==\"tower\" then s.arrowDeadline=s.towerDeadline\nelse\n local id=s.ids[s.role]\n local count=s.hammers[id] or 0\n s.arrowDeadline=count==0 and s.firstHammerDeadline or s.lastHammer[id] and s.lastHammer[id]+1550 or nil\nend\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\nprefs.guide(data,\"frog_fru_lr\",style,s,player,x,y,z,label,nil,6)\n\nif s.nextX and s.nextZ then\n local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local drawer=TensorCore.getStaticDrawer(0xFF00FFFF,1,0,flags)\n drawer:addLine(x,y,z,s.nextX,y,s.nextZ,3,1)\nend\nself.used=true",
							name = "Draw first-stage tether",
							uuid = "0cc96cab-4be7-ee25-857d-1f4bea99a154",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				eventType = 12,
				mechanicTime = 331.8,
				name = "[LR] Draw first-stage tether",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 16,
				timerStartOffset = -7.5,
				uuid = "ca48e7ad-0982-5929-833e-995f55b3c627",
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
							actionLua = "local s=data.frog_fru_lr\nif s then s.solve() end\nself.used=true\n",
							name = "Update first-stage destination",
							uuid = "4ddf1026-7c73-6ec3-a30e-ede8e3680d9e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				loop = true,
				mechanicTime = 331.8,
				name = "[LR] Update first-stage destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 16,
				timerStartOffset = -7.5,
				uuid = "7ec9caa9-ad07-ff6a-bca9-b35cb6daf151",
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
							actionLua = "local s=data.frog_fru_lr\nif s and s.active then\n s.towerDeadline=Now()+11200\n s.firstHammerDeadline=Now()+8000\nend\nself.used=true",
							conditions = 
							{
								
								{
									"9171f7dd-688e-9762-872b-e4657292259a",
									true,
								},
							},
							name = "Start tower and puddle staging",
							uuid = "44ae2859-baad-da5f-89bc-053030d1ca39",
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
							eventSpellID = 40212,
							name = "Light Rampant resolves",
							uuid = "9171f7dd-688e-9762-872b-e4657292259a",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 2,
				loop = true,
				mechanicTime = 331.8,
				name = "[LR] Stage timing",
				timeRange = true,
				timelineIndex = 80,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "fafba511-3e00-3e2a-8471-b3d8db76ca85",
				version = 2,
			},
		},
	},
	[88] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Light Rampant",
				uuid = "ba5086e6-32b1-3576-8897-80db65ca80c1",
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
							actionLua = "local s=data.frog_fru_lr_end\nif not s then\n s={start=(data.frog_fru_lr and data.frog_fru_lr.started) or Now(),active=true,orbs={},waveCounts={0,0},stackHits={},stackCount=0,stackShapes={},bursts={},burstCount=0,banishHits={},banishCount=0,proteans={},proteanCount=0,\n angles={T1=math.pi,T2=math.pi/2,H1=-math.pi/2,H2=0,M1=-math.pi/4,M2=math.pi/4,R1=-3*math.pi/4,R2=3*math.pi/4},\n pairAnchor={T1=\"R1\",R1=\"R1\",T2=\"R2\",R2=\"R2\",H1=\"M1\",M1=\"M1\",H2=\"M2\",M2=\"M2\"}}\n if (FrogFRUDrawSettings or {}).region==\"JP\" then s.pairAnchor={T1=\"R1\",R1=\"R1\",T2=\"M2\",M2=\"M2\",H1=\"M1\",M1=\"M1\",H2=\"R2\",R2=\"R2\"} end\n if (FrogFRUDrawSettings or {}).region==\"JP\" then s.angles.T2=0;s.angles.H2=math.pi/2 end\n data.frog_fru_lr_end=s\nend\nif s.orbExitVersion~=1 then\n function s.recordOrb(id)\n  if s.orbs[id] then return end\n  local e=TensorCore.mGetEntity(id)\n  if not e or e.contentid~=9318 then return end\n  local now=Now()\n  if not s.orbStarted then s.orbStarted=now end\n  local wave=now-s.orbStarted<1800 and 1 or 2\n  if s.waveCounts[wave]>=3 then return end\n  s.waveCounts[wave]=s.waveCounts[wave]+1\n  s.orbs[id]={id=id,x=e.pos.x,z=e.pos.z,wave=wave,h=math.atan2(e.pos.x-100,e.pos.z-100)}\n end\n function s.burstPathClear(x,z,tx,tz,wave)\n  local vx,vz=tx-x,tz-z\n  local length2=vx*vx+vz*vz\n  for _,orb in pairs(s.orbs)do\n   if not s.bursts[orb.id] and (not wave or orb.wave==wave) then\n    local t=length2>0 and math.max(0,math.min(1,((orb.x-x)*vx+(orb.z-z)*vz)/length2)) or 0\n    local dx,dz=x+vx*t-orb.x,z+vz*t-orb.z\n    if dx*dx+dz*dz<11.5^2 then return false end\n   end\n  end\n  return true\n end\n function s.orbExitPoint(player,x,z,wave)\n  local px,pz=player.pos.x,player.pos.z\n  local vx,vz=x-px,z-pz\n  local length2=vx*vx+vz*vz\n  if length2<=.0001 then return x,z end\n  local exit=0\n  for _,orb in pairs(s.orbs)do\n   if not s.bursts[orb.id] and (not wave or orb.wave==wave) then\n    local dx,dz=px-orb.x,pz-orb.z\n    local c=dx*dx+dz*dz-11.5^2\n    if c<0 then\n     local dot=dx*vx+dz*vz\n     exit=math.max(exit,(-dot+math.sqrt(dot*dot-length2*c))/length2)\n    end\n   end\n  end\n  if exit>0 and exit<1 then\n   local t=math.min(1,exit+.25/math.sqrt(length2))\n   local tx,tz=px+vx*t,pz+vz*t\n   if s.burstPathClear(tx,tz,tx,tz,wave)then return tx,tz end\n  end\n  return x,z\n end\n function s.dodge(player)\n  if s.stackCount<2 or s.burstCount>=6 or s.waveCounts[1]~=3 or s.waveCounts[2]~=3 then return false end\n  local initial=data.frog_fru_lr\n  local own=initial and initial.assignments[initial.role]\n  if not own or not own.done then return false end\n  if not s.dodgeBase then\n   local h=math.atan2(player.pos.x-100,player.pos.z-100)\n   local best,delta\n   for _,orb in pairs(s.orbs)do\n    local d=math.abs((orb.h-h+math.pi)%(2*math.pi)-math.pi)\n    if not delta or d<delta then best=orb;delta=d end\n   end\n   if not best or delta>math.pi/6+.05 then return false end\n   local cw,step\n   for _,orb in pairs(s.orbs)do\n    if orb.id~=best.id then\n     local d=(best.h-orb.h)%(2*math.pi)\n     if not step or d<step then cw=orb;step=d end\n    end\n   end\n   if not cw or math.abs(step-math.pi/3)>.08 or cw.wave==best.wave then return false end\n   s.dodgeBase=best;s.dodgeCW=cw\n  end\n  local base,cw=s.dodgeBase,s.dodgeCW\n  local destination\n  local radius=19\n  if s.burstCount<3 then\n   destination=base.wave==2 and base or cw\n   s.stage=base.wave==2 and \"orb-wait\" or \"orb-move-over\"\n   s.label=base.wave==2 and \"Wait for first Burst\" or \"Wait in second-orb safe spot\"\n   if base.wave==1 then\n    local h=destination.h+math.pi/9\n    local x,z=100+math.sin(h)*19,100+math.cos(h)*19\n    if not s.burstPathClear(player.pos.x,player.pos.z,x,z,1)then\n     s.tx,s.tz=s.orbExitPoint(player,x,z,1)\n     s.heading=math.atan2(s.tx-player.pos.x,s.tz-player.pos.z);s.keepVisible=true\n     s.label=\"Move OUT of first Burst; stay outside\";return true\n    end\n    s.stage=\"orb-wait-second\"\n   end\n  else\n   local curse=TensorCore.getBuff(player,4158)\n   local light=TensorCore.getBuff(player,2257)\n   local tower=not curse and light and light.stacks==2\n   destination=base.wave==1 and base or cw\n   local innerX=tower and 100 or 100+math.sin(destination.h)*6\n   local innerZ=tower and 100 or 100+math.cos(destination.h)*6\n   if not s.burstPathClear(player.pos.x,player.pos.z,innerX,innerZ)then\n    s.tx,s.tz=s.orbExitPoint(player,100+math.sin(destination.h)*19,100+math.cos(destination.h)*19)\n    s.heading=math.atan2(s.tx-player.pos.x,s.tz-player.pos.z);s.keepVisible=true\n    s.stage=\"orb-dodge-out\";s.label=\"Move OUT of Burst first\";return true\n   end\n   if tower then s.stage=\"orb-tower-in\";return false end\n   radius=6\n   s.stage=\"orb-dodge-in\";s.label=\"Burst clear: move towards centre\"\n  end\n  local h=destination.h+(radius==19 and destination.id==cw.id and math.pi/9 or 0)\n  s.heading=h;s.keepVisible=true\n  s.tx=100+math.sin(h)*radius\n  s.tz=100+math.cos(h)*radius\n  return true\n end\n\n function s.banishPoint(role)\n  local h=s.angles[role]\n  if s.banishKind==\"pairs\" then h=s.angles[s.pairAnchor[role]]\n  elseif s.banishKind~=\"spread\" then return end\n  return 100+math.sin(h)*8,100+math.cos(h)*8\n end\n function s.solve()\n  s.tx=nil;s.tz=nil;s.previewX=nil;s.previewZ=nil;s.keepVisible=true\n  if not s.active or (FrogFRUDrawSettings and FrogFRUDrawSettings.lr==false) then return end\n  local p=TensorCore.mGetPlayer();local role=data.frog_fru_role and data.frog_fru_role.key\n  if not p or p.hp.current<=0 or not role or not s.angles[role] then return end\n  s.y=p.pos.y\n  local initial=data.frog_fru_lr\n  local own=initial and initial.assignments[initial.role]\n  if own and own.done and not own.bait and s.burstCount<3 and not (s.orbDeadlines and s.orbDeadlines[1])then\n   s.stage=\"orb-staging\";s.keepVisible=true;s.tx=100;s.tz=own.z<100 and 81 or 119;s.label=own.z<100 and \"Hold north for Burst\" or \"Hold south for Burst\";return\n  end\n  if s.dodge(p) then return end\n  if s.burstCount<3 then return end\n  if s.needsTower==nil and not s.towerDone then\n   local buff=TensorCore.getBuff(p,2257)\n   if not buff then return end\n   s.needsTower=buff.stacks==2\n  end\n  if s.needsTower and not s.towerDone then\n   s.tx=100;s.tz=100;s.label=\"2 stacks: centre tower\"\n   s.previewX,s.previewZ=s.banishPoint(role)\n   if s.previewX and not s.waitTowerCalled then FrogFRUDrawSettings.callout(\"Wait for tower\");s.waitTowerCalled=true end\n   return\n  end\n  if s.waitTowerCalled and s.towerDone and not s.moveCalled then FrogFRUDrawSettings.callout(\"Move\");s.moveCalled=true end\n  if s.burstCount<6 and not s.finalClocks then return end\n  if not s.finalClocks and s.banishKind~=\"pairs\" and s.banishKind~=\"spread\" then return end\n  local h=s.angles[role];local radius=8\n  if s.finalClocks then s.keepVisible=true;radius=6;s.label=\"Final House of Light clocks\"\n  elseif s.banishKind==\"pairs\" then s.keepVisible=true;h=s.angles[s.pairAnchor[role]];s.label=\"Banish: colour-pair stack\"\n  elseif s.banishKind==\"spread\" then s.label=\"Banish: spread clock\" end\n  s.heading=h;s.tx=100+math.sin(h)*radius;s.tz=100+math.cos(h)*radius\n end\n s.orbExitVersion=1\nend\ns.solve();self.used=true\n",
							name = "Centre tower and Banish destinations",
							uuid = "78152454-f82a-b285-a94b-78becf2be5cb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Centre tower and Banish destinations",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "2af694de-175a-baf0-a2d1-2a9cbd7a2bc1",
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
							actionLua = "local s=data.frog_fru_lr_end\nif not s or not s.active then self.used=true return end\nif (eventArgs.spellID==40220 or eventArgs.spellID==40221) and (s.stackCount or 0)<2 then self.used=true;return end\nif eventArgs.spellID==40220 then s.banishKind=\"pairs\";s.banishDeadline=Now()+eventArgs.channelTimeMax*1000\nelseif eventArgs.spellID==40221 then s.banishKind=\"spread\";s.banishDeadline=Now()+eventArgs.channelTimeMax*1000\nelseif eventArgs.spellID==40189 then s.finalClocks=true end\ns.solve();self.used=true\n",
							conditions = 
							{
								
								{
									"dbce59d0-b6bb-9f34-b1e1-3db45fd80320",
									true,
								},
							},
							name = "Read final Banish and protean casts",
							uuid = "72edcac2-a0de-e9ec-a42c-69c5e0f05426",
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
							name = "LR resolution casts",
							spellIDList = 
							{
								40220,
								40221,
								40189,
							},
							uuid = "dbce59d0-b6bb-9f34-b1e1-3db45fd80320",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 3,
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Read final Banish and protean casts",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "3007bef9-a780-6a98-b9f2-5da93d839bb3",
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
							actionLua = "local s=data.frog_fru_lr_end\nif not s or not s.active then self.used=true return end\nlocal a=eventArgs\nif a.spellID==40217 then\n if not s.stackHits[a.entityID] then s.stackHits[a.entityID]=true;s.stackCount=s.stackCount+1 end\n for _,id in pairs(s.stackShapes)do Argus.deleteTimedShape(id)end\n s.stackShapes={}\nelseif a.spellID==40219 and a.entityContentID==9318 and not s.bursts[a.entityID] then\n s.bursts[a.entityID]=true;s.burstCount=s.burstCount+1\nelseif a.spellID==40213 and a.castPosX and a.castPosZ and (a.castPosX-100)^2+(a.castPosZ-100)^2<4 then\n s.towerDone=true\nelseif a.spellID==40222 or a.spellID==40223 then\n if not s.banishHits[a.entityID] then s.banishHits[a.entityID]=true;s.banishCount=s.banishCount+1 end\n if s.banishCount>=(a.spellID==40222 and 4 or 8) then s.finalClocks=true end\nelseif a.spellID==40188 and not s.proteans[a.entityID] then\n s.proteans[a.entityID]=true;s.proteanCount=s.proteanCount+1\n if s.proteanCount>=8 then s.active=false end\nend\ns.solve();self.used=true\n",
							conditions = 
							{
								
								{
									"fad91aad-4a2f-ce8d-b996-c14ae0d4abc3",
									true,
								},
							},
							name = "Advance after tower and Banish hits",
							uuid = "4c82771b-0a75-6b35-ac67-ea66024db130",
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
							name = "LR resolution casts",
							spellIDList = 
							{
								40219,
								40213,
								40222,
								40223,
								40188,
								40217,
							},
							uuid = "fad91aad-4a2f-ce8d-b996-c14ae0d4abc3",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 2,
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Advance after tower and Banish hits",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "f0b2e019-5817-67da-b8ea-0a25fc85ceb3",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_lr_end\nlocal player=TensorCore.mGetPlayer()\nif prefs and s and s.active and prefs.banishVersion~=2 then\n local p=prefs\nif p.banishVersion~=2 then\n function p.drawBanish(kind,deadline,style,state,role)\n  if (kind~=\"pairs\" and kind~=\"spread\")or not deadline or Now()>deadline+700 or p.styleFor(style)==\"Disabled\" then return end\n  if not AnyoneCore or not AnyoneCore.Roster.isReady()then return end\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  if kind==\"spread\" then\n   if not p.spreadDrawer then p.spreadDrawer=TensorCore.getCachedDrawer(0x300040FF,nil,0x300040FF,0xD06080FF,2,0,flags)end\n   for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n    local id=AnyoneCore.Roster.idOf(key);local actor=id and TensorCore.mGetEntity(id)\n    if actor and actor.pos and actor.hp.current>0 then p.spreadDrawer:addCircle(actor.pos.x,actor.pos.y+.04,actor.pos.z,5,false,flags)end\n   end\n   return\n  end\n  local me=TensorCore.mGetPlayer()\n  if not me or not me.pos or me.hp.current<=0 then return end\n  local partnerRole\n  if state and role and AnyoneCore.Roster.idOf(role)==me.id then\n   if style==\"mm\" and state.partners then partnerRole=state.partners[role]\n   elseif style==\"lr\" and state.pairAnchor then\n    local anchor=state.pairAnchor[role]\n    if anchor then\n     for _,key in ipairs({\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n      if key~=role and state.pairAnchor[key]==anchor then\n       if partnerRole then partnerRole=nil;break end\n       partnerRole=key\n      end\n     end\n    end\n   end\n  end\n  local id=partnerRole and AnyoneCore.Roster.idOf(partnerRole)\n  local partner=id and id~=me.id and TensorCore.mGetEntity(id)\n  local ready=partner and partner.pos and partner.hp.current>0 and (me.pos.x-partner.pos.x)^2+(me.pos.z-partner.pos.z)^2<=4.5^2\n  flags=flags+Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  if not p.banishRangeOutline then p.banishRangeOutline=TensorCore.getCachedDrawer(0,0,0,0xF0101010,6,0,flags)end\n  if not p.banishRangeGood then p.banishRangeGood=TensorCore.getCachedDrawer(0,0,0,0xFF40E080,3,0,flags)end\n  if not p.banishRangeBad then p.banishRangeBad=TensorCore.getCachedDrawer(0,0,0,0xFF4040FF,3,0,flags)end\n  p.banishRangeOutline:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n  local drawer=ready and p.banishRangeGood or p.banishRangeBad\n  drawer:addCircle(me.pos.x,me.pos.y+.04,me.pos.z,5,false,flags)\n end\n p.banishVersion=2\nend\nend\nif prefs and prefs.drawBanish and s and s.active then prefs.drawBanish(s.banishKind,s.banishDeadline,\"lr\",s,data.frog_fru_role and data.frog_fru_role.key)end\nlocal previewKey=\"frog_fru_lr_banish_preview\"\nif prefs and prefs.release and (not s or not s.active or not s.previewX or not player or player.hp.current<=0 or prefs.styleFor(\"lr\")==\"Disabled\") then prefs.release(data,previewKey) end\nif not prefs or not prefs.guide or not s or not s.active or not s.tx or not s.tz or not player or not player.pos or player.hp.current<=0 then if prefs and prefs.release then prefs.release(data,\"frog_fru_lr_end\");prefs.release(data,previewKey)end;self.used=true return end\nlocal style=\"lr\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_lr_end\");self.used=true return end\nlocal x,y,z=s.tx,s.y or .07,s.tz\nlocal label=s.label\ns.arrowDeadline=nil\nif s.stage==\"orb-wait\" or s.stage==\"orb-move-over\" or s.stage==\"orb-wait-second\" then s.arrowDeadline=s.orbDeadlines and s.orbDeadlines[1]\nelseif (s.stage==\"orb-dodge-out\" or s.stage==\"orb-dodge-in\" or s.stage==\"orb-tower-in\") and s.burstCount<6 then s.arrowDeadline=s.orbDeadlines and s.orbDeadlines[2]\nelseif prefs.castDeadline and s.finalClocks then s.arrowDeadline=prefs.castDeadline(data,s,{40189})\nelseif prefs.castDeadline and s.banishKind and s.burstCount>=6 then s.arrowDeadline=s.banishDeadline end\nprefs.guide(data,\"frog_fru_lr_end\",style,s,player,x,y,z,label,nil,6)\nif s.previewX and s.previewZ then\n if not s.previewOwner then s.previewOwner={keepVisible=true,stage=\"banish-preview\"} end\n local owner=s.previewOwner\n owner.arrowDeadline=prefs.castDeadline and s.banishDeadline\n owner.arrowHoldAfterDeadline=false\n local origin={pos={x=100,y=y,z=100}}\n prefs.guide(data,previewKey,style,owner,origin,s.previewX,y,s.previewZ,\"After tower\",nil,3)\nelse prefs.release(data,previewKey) end\n\nif s.nextX and s.nextZ then\n local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local drawer=TensorCore.getStaticDrawer(0xFF00FFFF,1,0,flags)\n drawer:addLine(x,y,z,s.nextX,y,s.nextZ,3,1)\n drawer:addCircle(s.nextX,y,s.nextZ,.6,false,flags)\nend\nself.used=true",
							name = "Draw final LR tether",
							uuid = "9af30f22-b780-da26-bc0e-db1f27c351cf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				eventType = 12,
				mechanicTime = 348.7,
				name = "[LR] Draw final LR tether",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "8e9e3db5-59c9-42c1-9929-d8b6ba7a4000",
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
							actionLua = "local s=data.frog_fru_lr_end\nif s and s.active then s.recordOrb(eventArgs.entityID);s.solve() end\nself.used=true",
							conditions = 
							{
								
								{
									"8acc8175-aa2a-84af-9b9b-d6e8d986bbe2",
									true,
								},
							},
							name = "[LR] Track orb waves",
							uuid = "db85ac01-5c43-e872-b83e-65222bd52d6a",
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
							eventArgOptionType = 2,
							eventEntityContentID = 9318,
							name = "Holy Light",
							uuid = "8acc8175-aa2a-84af-9b9b-d6e8d986bbe2",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 5,
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Track orb waves",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "89c28320-325b-24d5-a2d1-88e5a47b0e39",
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
							actionLua = "local s=data.frog_fru_lr_end\nlocal prefs=FrogFRUDrawSettings\nif not s or not s.active or not prefs or prefs.lr==false or prefs.styleFor(\"lr\")==\"Disabled\" then self.used=true return end\nlocal player=TensorCore.mGetEntity(eventArgs.entityID)\nlocal buff=player and TensorCore.getBuff(player,4159)\nif not player or not player.alive or not buff or buff.duration<=0 then self.used=true return end\nif s.stackShapes[player.id] then Argus.deleteTimedShape(s.stackShapes[player.id]) end\nlocal flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal drawer=TensorCore.getStaticDrawer(0x6040E080,1,0,flags)\ns.stackShapes[player.id]=drawer:addTimedCircleOnEnt(math.min(buff.duration*1000,17000),player.id,5,0,false,true,flags)\nself.used=true",
							conditions = 
							{
								
								{
									"803056a2-63ba-1e1b-b93d-223215ecc4da",
									true,
								},
							},
							name = "[LR] Four-player stack circles",
							uuid = "7187fdf4-bbe1-5c68-ba2b-28ffff848f6e",
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
							eventArgType = 2,
							eventBuffID = 4159,
							name = "Weight of Light",
							uuid = "803056a2-63ba-1e1b-b93d-223215ecc4da",
							version = 3,
						},
					},
				},
				displayPath = "P2 Light Rampant",
				eventType = 8,
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Four-player stack circles",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 23,
				timerStartOffset = -20,
				uuid = "12366e3d-d750-0730-8b62-13333a3ec279",
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
							actionLua = "local old=eventArgs.oldData\nlocal s=old and old.frog_fru_lr_end\nif s then\n for _,id in pairs(s.stackShapes or {})do Argus.deleteTimedShape(id)end\nend\nself.used=true",
							name = "[LR] Clear stack circles",
							uuid = "913d00fb-65f7-fe03-80b3-d884da181cf4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Light Rampant",
				eventType = 9,
				loop = true,
				mechanicTime = 348.7,
				name = "[LR] Clear stack circles",
				timeRange = true,
				timelineIndex = 88,
				timerEndOffset = 1600,
				timerStartOffset = -400,
				uuid = "7e2a4b67-e44f-9638-8ee8-d3b16a1419d9",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P2 Intermission",
				uuid = "ef5ea160-06d2-c0dc-b65c-34e5b6b6531b",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nif not prefs then return end\nlocal s=data.frog_fru_intermission\nif not s then\n s={cones={},locks={},stage=\"knockback\",keepVisible=true,angles={T1=math.pi,T2=math.pi/2,M1=-math.pi/2,M2=0,R1=-3*math.pi/4,R2=3*math.pi/4,H1=-math.pi/4,H2=math.pi/4}}\n data.frog_fru_intermission=s\nend\nif (FrogFRUDrawSettings or {}).region==\"JP\" then s.angles.T2=0;s.angles.M2=math.pi/2;s.angles.H2=3*math.pi/4;s.angles.R2=math.pi/4 end\ns.tx=nil;s.tz=nil\nif s.preparing and not s.kbDone and prefs.styleFor(\"intermission\")~=\"Disabled\" then\n local role=data.frog_fru_role and data.frog_fru_role.key\n if not role and AnyoneCore then role=AnyoneCore.Roster.mySlot() end\n if role==\"MT\" then role=\"T1\" elseif role==\"OT\" then role=\"T2\" end\n local heading=s.angles[role]\n if heading then\n  local inner=role:sub(1,1)==\"H\" or role:sub(1,1)==\"R\"\n  local radius=inner and 2 or 3\n  s.heading=heading;s.tx=100+math.sin(heading)*radius;s.tz=100+math.cos(heading)*radius\n  s.label=inner and \"Knockback: inner intercardinal\" or \"Knockback: outer cardinal\"\n end\nend\nlocal remaining=s.kbUntilTimer and s.kbUntilTimer-TensorReactions_CurrentTimer or 0\nif s.preparing and not s.kbDone and s.tx and s.tz and prefs.styleFor(\"intermission\")==\"Arrow\" then\n local holding=remaining<=0\n if s.kbHolding~=holding then\n  if s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\n  s.kbHolding=holding\n end\n local player=TensorCore.mGetPlayer()\n if player and player.hp.current>0 then\n  local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  local color=holding and 0xFF0000FF or 0xFF00FFFF\n  local drawer=prefs.arrowDrawer and prefs.arrowDrawer(color,flags,not holding) or TensorCore.getCachedDrawer(color,color,color,0xFFFFFFFF,2,0,flags)\n  if not s.kbOrigin then s.kbOrigin={x=player.pos.x,y=0,z=player.pos.z}end\n  local o=s.kbOrigin\n  local dx,dz=s.tx-o.x,s.tz-o.z\n  local length=math.sqrt(dx*dx+dz*dz)\n  local heading=length>.05 and math.atan2(dx,dz) or s.heading\n  if length<4 then o.x=s.tx-math.sin(heading)*4;o.z=s.tz-math.cos(heading)*4;length=4 end\n  local duration=holding and 180000 or remaining*1000\n  local tip=math.min(2,length*.35)\n  if not s.kbArrow then\n   s.kbArrow=drawer:addTimedArrow(duration,o.x,o.y,o.z,heading,length-tip,.75,tip,1.5,0,false,flags)\n   s.kbRefreshed=Now()\n  end\n end\nelseif s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\nlocal seen={}\nif prefs.darkCrystalCones~=false then\n local crystals=TensorCore.getEntityGroupList(\"ContentID\",{contentid=13556})\n local players,used={},{}\n local me=TensorCore.mGetPlayer()\n if AnyoneCore then\n  for _,actor in pairs(AnyoneCore.API.getAgnosticPartyList() or {})do\n   if not used[actor.id] and #players<8 then\n    local p=TensorCore.mGetEntity(actor.id)\n    if p and p.hp.current>0 then players[#players+1]=p.id;used[p.id]=true end\n   end\n  end\n end\n if me and me.hp.current>0 and not used[me.id] and #players<8 then players[#players+1]=me.id end\n s.playerIDs=players\n local count=0\n for _,crystal in pairs(crystals or {})do\n  if crystal.hp.current>0 and count<4 then\n   count=count+1\n   local cone=s.cones[crystal.id] or {}\n   cone.key=string.format(\"%.2f:%.2f\",crystal.pos.x,crystal.pos.z)\n   s.cones[crystal.id]=cone;seen[crystal.id]=true\n  end\n end\nend\nfor id,cone in pairs(s.cones)do\n if not seen[id] then\n  if cone.uuid then Argus.deleteTimedShape(cone.uuid) end\n  s.cones[id]=nil\n end\nend\nfor key,lock in pairs(s.locks)do if TensorReactions_CurrentTimer>=lock.untilTimer+1 then s.locks[key]=nil end end\n\ns.crystalPoint=nil\nlocal liveLights=TensorCore.getEntityGroupList(\"ContentID\",{contentid=13555})\nfor _,a in pairs(liveLights or {})do\n if a.targetable and a.attackable and a.hp.current>0 then\n  s.crystalsObservedAt=s.crystalsObservedAt or Now()\n  if not s.kbDone then\n   s.kbDone=true;s.preparing=false\n   if s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\n   prefs.release(data,\"frog_fru_intermission\")\n  end\n  break\n end\nend\nif s.kbDone and prefs.styleFor(\"intermission\")~=\"Disabled\" then\n local me=TensorCore.mGetPlayer()\n local role=data.frog_fru_role and data.frog_fru_role.key\n if not role and AnyoneCore then role=AnyoneCore.Roster.mySlot() end\n if role==\"MT\" then role=\"T1\" elseif role==\"OT\"then role=\"T2\"end\n local heading=role and s.angles[role]\n if me and me.hp.current>0 and heading then\n  local melee=role:sub(1,1)==\"T\" or role:sub(1,1)==\"M\"\n  if s.veilUntil or next(s.lightGround or {})or next(s.darkRounds or {})then s.crystalMechanicsStarted=true end\n  local starting=not s.crystalMechanicsStarted\n  local lightHeading=melee and heading or heading-math.pi/4\n  local cx,cz=100+15*math.sin(lightHeading),100+15*math.cos(lightHeading)\n  local lights=liveLights\n  local light\n  for _,a in pairs(lights or {})do\n   if a.targetable and a.attackable and a.hp.current>0 and (a.pos.x-cx)^2+(a.pos.z-cz)^2<4 then light=a;break end\n  end\n  if starting and melee and not light then light={pos={x=cx,z=cz}}end\n  if not s.crystalOwner then s.crystalOwner={keepVisible=true}end\n  local owner=s.crystalOwner\n  local first=prefs.region==\"EU\" and -1 or 1\n  local x,z,label,deadline,stage\n  if melee and light then\n   if light.id then s.ownLightSeen=true end\n   owner.crystalOrigin={x=light.pos.x,z=light.pos.z}\n   local key=string.format(\"%.2f:%.2f\",light.pos.x,light.pos.z)\n   local ground=s.lightGround and s.lightGround[key]\n   local radial=math.sqrt((light.pos.x-100)^2+(light.pos.z-100)^2)\n   local radius=5\n   if radial>1 then\n    local ux,uz=(light.pos.x-100)/radial,(light.pos.z-100)/radial\n    local vx,vz=-uz,ux\n    s.lightSides=s.lightSides or {}\n    if not s.lightSides[key] then\n     local d=radius/math.sqrt(2)\n     local px,pz=light.pos.x+d*ux,light.pos.z+d*uz\n     local plus=(me.pos.x-px-d*vx)^2+(me.pos.z-pz-d*vz)^2\n     local minus=(me.pos.x-px+d*vx)^2+(me.pos.z-pz+d*vz)^2\n     s.lightSides[key]=plus<=minus and 1 or -1\n    end\n    first=s.lightSides[key]\n    s.lightPoints=s.lightPoints or {}\n    local point=s.lightPoints[key]\n    local function candidate(i)\n     local out=(i<=2 and 1 or -1)*radius/math.sqrt(2)\n     local side=(i==1 or i==4)and first or -first\n     return {x=light.pos.x+out*ux+side*radius/math.sqrt(2)*vx,z=light.pos.z+out*uz+side*radius/math.sqrt(2)*vz,index=i}\n    end\n    if not point then point=candidate(1);s.lightPoints[key]=point end\n    if ground and point.serial~=ground.serial then\n     local index=ground.serial<=4 and (ground.serial%2+1) or ((4-ground.serial)%4+1)\n     point=candidate(index);point.serial=ground.serial;s.lightPoints[key]=point\n    end\n    if ground and point.edgeSerial~=ground.serial then\n     local base=candidate(point.index)\n     point.x,point.z=base.x,base.z;point.blocked=false\n     local safeRadius=ground.radius+.15\n     if (point.x-ground.x)^2+(point.z-ground.z)^2<safeRadius^2 then\n      local dx,dz=ground.x-light.pos.x,ground.z-light.pos.z\n      local distance=math.sqrt(dx*dx+dz*dz)\n      local chosen,best\n      if distance>0 then\n       local cosine=(radius*radius+distance*distance-safeRadius*safeRadius)/(2*radius*distance)\n       if cosine>=-1 then\n        local offset=math.acos(math.min(1,cosine))+.001\n        local bearing=math.atan2(dx,dz)\n        local original=math.atan2(base.x-light.pos.x,base.z-light.pos.z)\n        for _,angle in ipairs({bearing-offset,bearing+offset})do\n         local change=math.abs((angle-original+math.pi)%(2*math.pi)-math.pi)\n         local px,pz=light.pos.x+radius*math.sin(angle),light.pos.z+radius*math.cos(angle)\n         if change<=math.pi/4 and (px-100)^2+(pz-100)^2<19.5^2 and (not best or change<best) then\n          chosen={x=px,z=pz};best=change\n         end\n        end\n       end\n      end\n      if chosen then point.x,point.z=chosen.x,chosen.z else point.blocked=true end\n     end\n     point.edgeSerial=ground.serial\n    end\n    if not point.blocked then x,z=point.x,point.z end\n    label=ground and \"Dodge locked light AOE\" or \"Bait light: wall side\"\n    deadline=ground and ground.deadline or s.firstLightAt or s.veilUntil\n    stage=\"light-ground:\"..key..\":\"..tostring(ground and ground.serial or 0)\n   end\n  elseif melee and (s.ownLightSeen or s.crystalsObservedAt and Now()-s.crystalsObservedAt>=500) then\n   owner.crystalOrigin=nil\n   x,z=100+1.5*math.sin(heading),100+1.5*math.cos(heading);label=\"Own light defeated: centre\";deadline=s.veilUntil;stage=\"veil\"\n  elseif not melee then\n   local darks=TensorCore.getEntityGroupList(\"ContentID\",{contentid=13556})\n   local dx,dz=100+8*math.sin(heading),100+8*math.cos(heading)\n   local dark\n   for _,a in pairs(darks or {})do\n    if a.hp.current>0 and(a.pos.x-dx)^2+(a.pos.z-dz)^2<4 then dark=a;break end\n   end\n   if starting and not dark then dark={pos={x=dx,z=dz}}end\n   if dark then\n    local key=string.format(\"%.2f:%.2f\",dark.pos.x,dark.pos.z)\n    local round=s.darkRounds and s.darkRounds[key]or 0\n    local ux,uz=math.sin(heading),math.cos(heading);local vx,vz=-uz,ux\n    local baitRadius=1\n    local baitX,baitZ=dark.pos.x+baitRadius*ux,dark.pos.z+baitRadius*uz\n    owner.crystalOrigin={x=baitX+4*ux,z=baitZ+4*uz}\n    local sideStep=math.max(1,(((me.hitradius or .5)+.15)+baitRadius*math.sin(math.pi/18))/math.cos(math.pi/18)+.1)\n    local lock=s.locks[key]\n    local function safePosition(px,pz)\n     if (px-100)^2+(pz-100)^2>=19.5^2 then return false end\n     for _,crystal in pairs(darks or {})do\n      if crystal.hp.current>0 then\n       local other=s.locks[string.format(\"%.2f:%.2f\",crystal.pos.x,crystal.pos.z)]\n       if other then\n        local dx,dz=px-crystal.pos.x,pz-crystal.pos.z\n        local distance=math.sqrt(dx*dx+dz*dz)\n        if distance<.1 then return false end\n        local margin=math.asin(math.min(1,((me.hitradius or .5)+.15)/distance))\n        if math.abs((math.atan2(dx,dz)-other.h+math.pi)%(2*math.pi)-math.pi)<=math.pi/18+margin then return false end\n       end\n      end\n     end\n     return true\n    end\n    local function safeAim()\n     local function clearCircle(cx,cz,radius)\n      local dx,dz=cx-dark.pos.x,cz-dark.pos.z\n      local distance=math.sqrt(dx*dx+dz*dz)\n      if distance<=radius then return false end\n      if distance>50+radius then return true end\n      local delta=math.abs((math.atan2(dx,dz)-heading+math.pi)%(2*math.pi)-math.pi)\n      return delta>math.pi/18+math.asin(math.min(1,radius/distance))\n     end\n     if not clearCircle(100,100,6)then return false end\n     for _,a in pairs(liveLights or {})do\n      if a.targetable and a.attackable and a.hp.current>0 and not clearCircle(a.pos.x,a.pos.z,(a.hitradius or 0)+.5)then return false end\n     end\n     return true\n    end\n    local dodging=lock and not safePosition(baitX,baitZ)\n    if dodging then\n     s.darkDodges=s.darkDodges or {}\n     local point=s.darkDodges[key]\n     local token=lock.at or lock.deadline or lock.untilTimer\n     if not point or point.token~=token or point.radius~=baitRadius or point.sideStep~=sideStep or not safePosition(point.x,point.z)then\n      point=nil\n      local best\n      for _,sign in ipairs({first,-first})do\n       local px,pz=baitX+sign*sideStep*vx,baitZ+sign*sideStep*vz\n       if safePosition(px,pz)then\n        local distance=(px-me.pos.x)^2+(pz-me.pos.z)^2\n        if not best or distance<best then point={x=px,z=pz,token=token,radius=baitRadius,sideStep=sideStep};best=distance end\n       end\n      end\n      s.darkDodges[key]=point\n     end\n     if point then x,z=point.x,point.z end\n    else\n     if s.darkDodges then s.darkDodges[key]=nil end\n     if safePosition(baitX,baitZ)and safeAim()then x,z=baitX,baitZ end\n    end\n    label=dodging and \"Dodge locked dark cone\"or\"Bait dark: aim at intercardinal\"\n    deadline=dodging and lock.deadline or (s.darkNext and s.darkNext[key])or s.firstDarkAt or s.veilUntil\n    stage=\"dark:\"..key..\":\"..round..(dodging and \":dodge\"or\":bait\")\n   end\n  end\n  local veils=TensorCore.getEntityGroupList(\"ContentID\",{contentid=9358})\n  local veil\n  for _,a in pairs(veils or {})do if a.hp.current>0 then veil=a;break end end\n  if x and (veil or starting)then\n   if starting then\n    label=melee and \"Start at assigned light crystal\"or\"Start at assigned dark crystal\"\n    stage=\"crystal-start:\"..role;deadline=nil\n   end\n   owner.arrowStage=stage;owner.arrowDeadline=deadline;owner.arrowHoldAfterDeadline=starting or melee and light~=nil\n   s.crystalPoint={x=x,z=z,label=label}\n  end\n end\nend\n\nself.used=true\n",
							name = "[Intermission] Update positions and cone targets",
							uuid = "0183c0b2-62fb-e0f0-9743-be76f6cdfde4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Intermission",
				loop = true,
				mechanicTime = 387.8,
				name = "[Intermission] Update positions and cone targets",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 100,
				timerStartOffset = -12,
				uuid = "6f982295-8035-d318-b4bd-81860b43dd08",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_intermission\nif not prefs or not s then self.used=true return end\nif s.preparing and not s.kbDone and s.tx and s.tz then\n local me=TensorCore.mGetPlayer()\n if me and me.hp.current>0 and prefs.styleFor(\"intermission\")==\"Tether\" then prefs.guide(data,\"frog_fru_intermission\",\"intermission\",s,me,s.tx,me.pos.y+.07,s.tz,s.label,nil,6) end\nelse prefs.release(data,\"frog_fru_intermission\") end\nfor _,cone in pairs(s.cones)do\n if cone.uuid then Argus.deleteTimedShape(cone.uuid);cone.uuid=nil end\nend\nlocal point=s.crystalPoint\nlocal me=TensorCore.mGetPlayer()\nif point and me and me.hp.current>0 then prefs.guide(data,\"frog_fru_intermission_crystal\",\"intermission\",s.crystalOwner,me,point.x,0,point.z,point.label,nil,6)\nelse prefs.release(data,\"frog_fru_intermission_crystal\")end\nlocal flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\nif not s.coneDrawers or s.coneDrawers.paletteVersion~=4 then\n local preview=TensorCore.getCachedDrawer(0x3000FFFF,0x3000FFFF,0x3000FFFF,0xFFFFFFFF,2,0,flags)\n local locked=TensorCore.getCachedDrawer(0x60FF40D0,0x60FF40D0,0x60FF40D0,0xFFFFFFFF,2.5,0,flags)\n s.coneDrawers={paletteVersion=4,preview=preview,locked=locked}\nend\nlocal players=s.framePlayers\nif not players then players={};s.framePlayers=players end\nlocal count=0\nfor _,id in ipairs(s.playerIDs or {})do\n local p=TensorCore.mGetEntity(id)\n if p and p.hp.current>0 then count=count+1;players[count]=p end\nend\nfor i=count+1,#players do players[i]=nil end\nif prefs.darkCrystalCones==false then self.used=true;return end\nfor id,cone in pairs(s.cones)do\n local crystal=TensorCore.mGetEntity(id)\n if crystal and crystal.hp.current>0 then\n  local x,y,z=crystal.pos.x,crystal.pos.y+.04,crystal.pos.z\n  local lock=s.locks[cone.key]\n  local locked=lock and TensorReactions_CurrentTimer<lock.untilTimer+1\n  local heading=locked and lock.h\n  if not heading then\n   local nearest,best=nil,math.huge\n   for _,p in ipairs(players)do\n    local distance=(p.pos.x-x)^2+(p.pos.z-z)^2\n    if distance<best then nearest=p;best=distance end\n   end\n   if nearest then heading=math.atan2(nearest.pos.x-x,nearest.pos.z-z) end\n  end\n  if heading then\n   local drawer=locked and s.coneDrawers.locked or s.coneDrawers.preview\n   drawer:addCone(x,y,z,50,math.pi/9,heading,false,flags)\n  end\n end\nend\nself.used=true",
							name = "[Intermission] Draw preposition and dark cones",
							uuid = "44676a3b-a7a7-6d40-8dad-449e0f73f292",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Intermission",
				eventType = 12,
				loop = true,
				mechanicTime = 387.8,
				name = "[Intermission] Draw preposition and dark cones",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 100,
				timerStartOffset = -12,
				uuid = "718ac61f-8a48-72a0-b142-22915ed5f044",
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
							actionLua = "local s=data.frog_fru_intermission\nif not s then\n s={cones={},locks={},stage=\"knockback\",keepVisible=true,angles={T1=math.pi,T2=math.pi/2,M1=-math.pi/2,M2=0,R1=-3*math.pi/4,R2=3*math.pi/4,H1=-math.pi/4,H2=math.pi/4}}\n data.frog_fru_intermission=s\nend\nif eventArgs.spellID==40224 and not s.preparing and not s.kbDone then\n s.preparing=true;s.kbDone=false\n s.kbUntilTimer=TensorReactions_CurrentTimer+13.34\n if s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\n if FrogFRUDrawSettings then FrogFRUDrawSettings.release(data,\"frog_fru_intermission\")end\nelseif eventArgs.spellID==40259 then\n s.veilUntil=Now()+eventArgs.channelTimeMax*1000;s.firstDarkAt=Now()+5350;s.firstLightAt=Now()+6200\nelseif eventArgs.spellID==40262 then\n local actor=TensorCore.mGetEntity(eventArgs.entityID)\n if actor then\n  local key=string.format(\"%.2f:%.2f\",actor.pos.x,actor.pos.z)\n  local old=s.locks[key]\n  if not old or Now()-(old.at or 0)>500 then\n   s.darkRounds=s.darkRounds or {};s.darkRounds[key]=(s.darkRounds[key] or 0)+1\n   s.darkNext=s.darkNext or {};s.darkNext[key]=Now()+5300\n   s.locks[key]={casterID=eventArgs.entityID,h=actor.pos.h,at=Now(),deadline=Now()+eventArgs.channelTimeMax*1000,untilTimer=TensorReactions_CurrentTimer+eventArgs.channelTimeMax}\n  end\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"4e690a9a-6405-dfbb-aa58-c1d0f1be0ff6",
									true,
								},
							},
							name = "[Intermission] Begin preparation and lock cones",
							uuid = "f8e516fd-b238-7487-b988-a60c0e8b32ac",
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
							name = "Intermission events",
							spellIDList = 
							{
								40224,
								40262,
								40259,
							},
							uuid = "4e690a9a-6405-dfbb-aa58-c1d0f1be0ff6",
							version = 3,
						},
					},
				},
				displayPath = "P2 Intermission",
				eventType = 3,
				loop = true,
				mechanicTime = 387.8,
				name = "[Intermission] Begin preparation and lock cones",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 100,
				timerStartOffset = -12,
				uuid = "5a8ca3e2-d69f-8457-8cd2-d4513dca2963",
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
							actionLua = "local s=data.frog_fru_intermission\nif s then\n if eventArgs.spellID==40225 then\n  s.kbDone=true;s.preparing=false;s.tx=nil;s.tz=nil\n  if s.kbArrow then Argus.deleteTimedShape(s.kbArrow);s.kbArrow=nil end\n  if FrogFRUDrawSettings then FrogFRUDrawSettings.release(data,\"frog_fru_intermission\") end\n elseif eventArgs.spellID==40262 then\n  local matched=false\n  for key,lock in pairs(s.locks)do\n   if lock.casterID==eventArgs.entityID then s.locks[key]=nil;matched=true end\n  end\n  if not matched then\n   local actor=TensorCore.mGetEntity(eventArgs.entityID)\n   if actor then\n    local key=string.format(\"%.2f:%.2f\",actor.pos.x,actor.pos.z)\n    local lock=s.locks[key]\n    if lock and not lock.casterID then s.locks[key]=nil end\n   end\n  end\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"dd689500-eb59-a1fe-b684-453f09afdfd6",
									true,
								},
							},
							name = "[Intermission] Finish knockback and cone casts",
							uuid = "7f723e55-b283-6431-9541-1097ffac6d5e",
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
							name = "Intermission events",
							spellIDList = 
							{
								40225,
								40262,
							},
							uuid = "dd689500-eb59-a1fe-b684-453f09afdfd6",
							version = 3,
						},
					},
				},
				displayPath = "P2 Intermission",
				eventType = 2,
				loop = true,
				mechanicTime = 387.8,
				name = "[Intermission] Finish knockback and cone casts",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 100,
				timerStartOffset = -12,
				uuid = "250ff46a-7b9b-4232-8aed-ae418a60bf27",
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
							actionLua = "local s=data.frog_fru_intermission\nif not s or eventArgs.aoeID~=40256 or eventArgs.contentID~=13555 or not eventArgs.isAreaTarget then return end\nlocal best,key\nfor _,p in ipairs({{85,100},{115,100},{100,85},{100,115}})do\n local d=(eventArgs.x-p[1])^2+(eventArgs.z-p[2])^2\n if not best or d<best then best=d;key=string.format(\"%.2f:%.2f\",p[1],p[2])end\nend\nif best>100 then return end\ns.lightGround=s.lightGround or {}\nlocal old=s.lightGround[key]\nif old and old.source==eventArgs.entityID and old.stamp==eventArgs.startTime then return end\ns.lightGround[key]={x=eventArgs.x,z=eventArgs.z,radius=eventArgs.aoeLength,deadline=Now()+(eventArgs.duration+eventArgs.delay)*1000,source=eventArgs.entityID,stamp=eventArgs.startTime,serial=(old and old.serial or 0)+1}\nself.used=true",
							name = "Track locked light AOE",
							uuid = "b22b30a3-4ae8-adfb-a80b-637b906a427a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P2 Intermission",
				eventType = 18,
				loop = true,
				mechanicTime = 387.8,
				name = "[Intermission] Light AOE dodge",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 100,
				timerStartOffset = -12,
				uuid = "46b60d4d-5391-bdeb-97ff-4b1d9083b201",
				version = 2,
			},
		},
	},
	[123] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P3 Ultimate Relativity",
				uuid = "e1307554-c0d9-17ae-962b-0840181d4693",
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
							actionLua = "local s={start=Now(),stage=0,fireWaves=0,laserWaves=0,fast={},rotations={},records={},nextPoll=0}\ndata.frog_fru_ur=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.assign(records)\n local support,dps={},{}\n for _,key in ipairs(s.keys) do\n  local r=records[key]\n  if not r then return false end\n  local kind=key:sub(1,1)\n  r.support=kind==\"T\" or kind==\"H\"\n  if r.support then\n   if r.order==3 then support[#support+1]=key else r.clock=r.order==2 and \"W\" or \"N\" end\n  else\n   if r.order==1 then dps[#dps+1]=key else r.clock=r.order==2 and \"E\" or \"S\" end\n  end\n end\n if #support~=2 or #dps~=2 then return false end\n for _,pair in ipairs({support,dps}) do\n  local a,b=records[pair[1]],records[pair[2]]\n  local ka,kb=pair[1]:sub(1,1),pair[2]:sub(1,1)\n  local left,right=a.support and \"NW\" or \"SW\",a.support and \"NE\" or \"SE\"\n  if ka==kb then\n   local preferred=(ka==\"H\" or ka==\"R\") and left or right\n   for _,key in ipairs(pair) do records[key].clock=key:sub(2,2)==\"2\" and preferred or (preferred==left and right or left) end\n  else\n   a.clock=(ka==\"H\" or ka==\"R\") and left or right\n   b.clock=(kb==\"H\" or kb==\"R\") and left or right\n  end\n end\n local region=(FrogFRUDrawSettings or {}).region\n if region==\"EU\" or region==\"Elemental\" or region==\"JP\" then\n  local order=region==\"EU\" and {\"H1\",\"T1\",\"T2\",\"H2\",\"R1\",\"M1\",\"M2\",\"R2\"} or {\"H1\",\"H2\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n  local rank={};for i,key in ipairs(order) do rank[key]=i end\n  table.sort(support,function(a,b)return rank[a]<rank[b] end);table.sort(dps,function(a,b)return rank[a]<rank[b] end)\n  records[support[1]].clock=\"NW\";records[support[2]].clock=\"NE\"\n  records[dps[1]].clock=\"SW\";records[dps[2]].clock=\"SE\"\n  if region==\"JP\" then\n   local player=TensorCore.mGetPlayer()\n   if not player then return false end\n   local function markedPair(pair,firstMark,left,right)\n    local first,second=records[pair[1]],records[pair[2]]\n    if player.id~=first.id and player.id~=second.id then return true end\n    local a,b=TensorCore.mGetEntity(first.id),TensorCore.mGetEntity(second.id)\n    local ma,mb=a and a.marker,b and b.marker\n    if ma==firstMark and mb==firstMark+1 then first.clock,second.clock=left,right\n    elseif mb==firstMark and ma==firstMark+1 then first.clock,second.clock=right,left\n    else return false end\n    return true\n   end\n   if not markedPair(support,6,\"SW\",\"SE\") or not markedPair(dps,1,\"NW\",\"NE\") then return false end\n   for _,r in pairs(records) do if r.support and r.order==1 then r.clock=\"S\" elseif not r.support and r.order==3 then r.clock=\"N\" end end\n  end\n end\n local q=math.sqrt(0.5)\n local clocks={N={0,1},NE={q,q},E={1,0},SE={q,-q},S={0,-1},SW={-q,-q},W={-1,0},NW={-q,q}}\n for _,r in pairs(records) do\n  local v=clocks[r.clock]\n  r.dx=v[1]*(-s.nz)+v[2]*s.nx\n  r.dz=v[1]*s.nx+v[2]*s.nz\n end\n return true\nend\nfunction s.poll()\n local now=Now()\n if now<s.nextPoll then return end\n s.nextPoll=now+100\n s.keepVisible=true\n s.destination=nil\n local me=TensorCore.mGetPlayer()\n if not me or me.hp.current<=0 or now-s.start>52000 or s.done then return end\n if not s.ready then\n  if not s.nx or not AnyoneCore then s.reason=\"Waiting for yellow Y / roster\" return end\n  local members=AnyoneCore.Roster.members()\n  local party=AnyoneCore.API.getAgnosticPartyList()\n  if type(members)~=\"table\" or type(party)~=\"table\" then return end\n  local byName,byJob,counts,rcounts={},{},{},{}\n  for _,a in pairs(party) do\n   if a.id and a.name and a.job then\n    local signature=a.name..\"\\31\"..a.job\n    byName[signature]=byName[signature] and false or a\n    byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n   end\n  end\n  for _,m in pairs(members) do if m.job then rcounts[m.job]=(rcounts[m.job] or 0)+1 end end\n  local records,used={},{}\n  for _,key in ipairs(s.keys) do\n   local m=members[key]\n   if not m or not m.name or not m.job then s.reason=\"Incomplete Anyone roster\" return end\n   local a=byName[m.name..\"\\31\"..m.job]\n   if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n   if not a or used[a.id] then s.reason=\"Ambiguous Anyone roster\" return end\n   used[a.id]=true\n   local old=s.records[key]\n   if old and old.id==a.id then records[key]=old else\n    local fire=TensorCore.getBuff(a,2455)\n    local ice=TensorCore.getBuff(a,2462)\n    local rewind=TensorCore.getBuff(a,2464)\n    if (not fire and not ice) or not rewind then s.reason=\"Waiting for UR debuffs\" return end\n    local support=key:sub(1,1)==\"T\" or key:sub(1,1)==\"H\"\n    local duration=fire and fire.duration+(now-s.start)/1000 or 0\n    local order=fire and (duration<16 and 1 or duration<26 and 2 or 3) or (support and 1 or 3)\n    records[key]={id=a.id,order=order,ice=ice~=nil,fireEnd=fire and now+fire.duration*1000 or nil,\n     eruption=TensorCore.hasBuff(a,2460),rewindEnd=now+rewind.duration*1000}\n   end\n  end\n  s.records=records\n  if not s.assign(records) then s.reason=\"Incomplete UR assignments\" return end\n  for key,r in pairs(records) do if r.id==me.id then s.myKey=key end end\n  if not s.myKey then s.reason=\"Player missing from Anyone roster\" return end\n  s.ready=true;s.reason=nil\n end\n local r=s.records[s.myKey]\n if r.id~=me.id then return end\n local phase=s.stage\n local radius,label=0,\"Stack middle\"\n local bait=false\n if phase==0 or phase==2 or phase==4 then\n  local wave=phase/2+1\n  if not r.ice and r.order==wave and r.fireEnd and (phase==0 or r.fireEnd-now<=7000) then radius=16;label=\"Spread fire: \"..r.clock end\n elseif phase==1 then\n  if r.order==3 then bait=true else radius=r.eruption and 9 or 1;label=r.eruption and \"Place eruption rewind OUT\" or \"Place water rewind IN\" end\n elseif phase==3 then\n  if r.order==1 then bait=true elseif r.order==3 then radius=1.5;label=\"Place eye rewind IN\" end\n elseif phase==5 then\n  if r.order==2 then bait=true else radius=-1;label=\"Middle; face out for rewind\" end\n elseif phase==6 then\n  s.reason=\"Face out; allow Return to resolve\";return\n elseif phase==7 then radius=0;label=\"Stack middle for Shell Crusher\" end\n local x,z=100+radius*r.dx,100+radius*r.dz\n if bait then\n  local nearest,best=nil,math.huge\n  local clocks=TensorCore.entityList(\"contentid=9825\")\n  for _,a in pairs(clocks) do\n   local distance=(a.pos.x-(100+9.5*r.dx))^2+(a.pos.z-(100+9.5*r.dz))^2\n   if distance<best then nearest=a;best=distance end\n  end\n  if not nearest or best>2 then s.reason=\"Waiting for assigned hourglass\" return end\n  local direction=s.rotations[nearest.id]\n  if not direction then s.reason=\"Waiting for beam rotation cue\" return end\n  local angle=-direction*math.pi*3/8\n  local c,t=math.cos(angle),math.sin(angle)\n  x=nearest.pos.x+1.5*(c*r.dx-t*r.dz)\n  z=nearest.pos.z+1.5*(t*r.dx+c*r.dz)\n  label=\"Bait beam: \"..r.clock\n end\n s.reason=nil;s.destination={x=x,y=0.07,z=z,label=label}\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"be0b837f-9a5d-4c31-bd88-561a9d8bfb23",
									true,
								},
							},
							name = "Initialize G1-adjust solver",
							uuid = "8b287013-032d-9977-bcde-0108370222a2",
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
							eventSpellID = 40266,
							name = "UR",
							uuid = "be0b837f-9a5d-4c31-bd88-561a9d8bfb23",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 2,
				mechanicTime = 532.4,
				name = "[UR] Initialize personal responsibilities",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 3,
				timerStartOffset = -3,
				uuid = "89cc2d30-0cbc-a94a-85f7-ed2ab3c240d5",
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
							actionLua = "local s=data.frog_fru_ur\nlocal source=TensorCore.mGetEntity(eventArgs.sourceEntityID)\nif s and source then\n s.fast[source.id]={x=source.pos.x-100,z=source.pos.z-100}\n local count,x,z=0,0,0\n for _,p in pairs(s.fast) do count=count+1;x=x+p.x;z=z+p.z end\n if count==3 then\n  local length=math.sqrt(x*x+z*z)\n  if length>0.5 then\n   local sign=(FrogFRUDrawSettings or {}).region==\"JP\" and -1 or 1\n   s.nx=sign*x/length;s.nz=sign*z/length\n   s.nextPoll=0;s.poll()\n  end\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"6e732a6a-0730-2190-8b9e-b8518868b3bd",
									true,
								},
								
								{
									"afc6c04a-723e-0307-bd35-1ca74616d0b7",
									true,
								},
							},
							name = "Record fast hourglasses",
							uuid = "c901f54f-f309-dc13-ab55-b281c2f3d28f",
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
							eventEntityContentID = 9825,
							name = "Hourglass",
							uuid = "6e732a6a-0730-2190-8b9e-b8518868b3bd",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgType = 5,
							eventIntValue = 134,
							name = "Fast yellow",
							uuid = "afc6c04a-723e-0307-bd35-1ca74616d0b7",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 15,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Orient yellow Y",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 12,
				timerStartOffset = -3,
				uuid = "52ed46e9-7425-f86f-aaae-a3846c58bd82",
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
							actionLua = "local s=data.frog_fru_ur\nif s then s.rotations[eventArgs.primaryEntityID]=1 end\nself.used=true",
							conditions = 
							{
								
								{
									"e6303811-dcce-84a1-b6fe-a8fd91c692ae",
									true,
								},
								
								{
									"6a161fed-262b-1f3b-af17-d7cf9f94ad0b",
									true,
								},
							},
							name = "Record clockwise beam",
							uuid = "71f873cd-c0ec-9359-92d0-0211e9016137",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ur\nif s then s.rotations[eventArgs.primaryEntityID]=-1 end\nself.used=true",
							conditions = 
							{
								
								{
									"e6303811-dcce-84a1-b6fe-a8fd91c692ae",
									true,
								},
								
								{
									"c3f6ceb2-f061-195a-9aec-5139bb5ba28a",
									true,
								},
							},
							name = "Record counterclockwise beam",
							uuid = "01f96d07-dde5-dc32-8e58-be72fa326c56",
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
							eventArgType = 3,
							eventEntityContentID = 9825,
							name = "Hourglass",
							uuid = "e6303811-dcce-84a1-b6fe-a8fd91c692ae",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventIntValue = 1233,
							name = "Clockwise",
							uuid = "6a161fed-262b-1f3b-af17-d7cf9f94ad0b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventIntValue = 1032,
							name = "Counterclockwise",
							uuid = "c3f6ceb2-f061-195a-9aec-5139bb5ba28a",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 27,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Record beam rotations",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 43,
				timerStartOffset = -3,
				uuid = "f441ac82-dbb8-d2d8-9a2c-cc7dbf192c40",
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
							actionLua = "local s=data.frog_fru_ur\nif s and (not s.lastFire or Now()-s.lastFire>3000) then\n s.lastFire=Now();s.fireWaves=math.min(3,s.fireWaves+1);s.stage=math.max(s.stage,s.fireWaves*2-1);s.nextPoll=0;s.destination=nil\nend\nself.used=true",
							conditions = 
							{
								
								{
									"a9e6cfe4-0c94-ac76-bd86-25183db958ff",
									true,
								},
							},
							name = "After fire and Unholy",
							uuid = "b216f588-870b-5e8a-a576-c3e4f4f39e19",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ur\nif s and (not s.lastLaser or Now()-s.lastLaser>3000) then\n s.lastLaser=Now();s.laserWaves=math.min(3,s.laserWaves+1);s.stage=math.max(s.stage,s.laserWaves*2);s.nextPoll=0;s.destination=nil\nend\nself.used=true",
							conditions = 
							{
								
								{
									"ea4a9706-49f0-9bd8-97d0-c30b0ce3279e",
									true,
								},
							},
							name = "After beam bait",
							uuid = "cb72506a-2a30-c7ed-b981-06ce50cac669",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ur\nif s then s.stage=7;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"243c97b1-a025-f0f9-a364-81dc5ba6c53c",
									true,
								},
							},
							name = "After rewind resolves",
							uuid = "2348a5f4-fae0-11c5-b186-467bfa8adc51",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ur\nif s then s.done=true;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"9d5e1d16-c6ae-362e-b36f-4190baf144b6",
									true,
								},
							},
							name = "Finish at Shell Crusher",
							uuid = "2997caf5-1b05-f9b9-b164-2ea3e0ebffd2",
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
							eventSpellID = 40277,
							name = "Unholy",
							uuid = "a9e6cfe4-0c94-ac76-bd86-25183db958ff",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40235,
							name = "Beam first hit",
							uuid = "ea4a9706-49f0-9bd8-97d0-c30b0ce3279e",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40278,
							name = "Shadoweye",
							uuid = "243c97b1-a025-f0f9-a364-81dc5ba6c53c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40287,
							name = "Shell Crusher",
							uuid = "9d5e1d16-c6ae-362e-b36f-4190baf144b6",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 2,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Advance on mechanic resolution",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 50,
				timerStartOffset = -3,
				uuid = "efc1caf3-ccb0-c722-ad83-b35507f3147b",
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
							actionLua = "local s=data.frog_fru_ur\nif s then s.poll() end\nself.used=true",
							name = "Update responsibility",
							uuid = "f5413079-3e36-e59b-94de-f3fdff4c20cb",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Resolve personal destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 50,
				uuid = "e53f2821-c7a2-d78c-a212-cdced1e423c4",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_ur\nlocal player=TensorCore.mGetPlayer()\nif not prefs or not prefs.guide or not s or not s.destination or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>52000 then if prefs and prefs.release then prefs.release(data,\"frog_fru_ur\")end;self.used=true return end\nlocal style=\"ur\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_ur\");self.used=true return end\nlocal point=s.destination\nlocal x,y,z=point.x,point.y or .07,point.z\nlocal label=point.label\ns.arrowDeadline=nil\nif s.stage==0 or s.stage==2 or s.stage==4 then\n local wave=s.stage/2+1\n for _,r in pairs(s.records)do\n  if r.order==wave and r.fireEnd then s.arrowDeadline=s.arrowDeadline and math.min(s.arrowDeadline,r.fireEnd) or r.fireEnd end\n end\nelseif prefs.castDeadline and (s.stage==1 or s.stage==3 or s.stage==5) then\n local deadline=prefs.castDeadline(data,s,{40291})\n local cast=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40291]\n if cast and cast.at>=(s.lastFire or s.start) then s.arrowDeadline=deadline end\nelseif prefs.castDeadline and s.stage==7 then s.arrowDeadline=prefs.castDeadline(data,s,{40286}) end\nprefs.guide(data,\"frog_fru_ur\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw personal destination",
							uuid = "30280256-50ea-71e3-8d66-9e1fb632e109",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 12,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Personal responsibility tether",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 50,
				uuid = "5f461cc5-4cf8-1f14-a7a5-df7dca5d6903",
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
							actionLua = "local s=data.frog_fru_laser_preview\nif not s then s={active={},players={}};data.frog_fru_laser_preview=s end\nlocal a=TensorCore.mGetEntity(eventArgs.entityID)\nif a then\n local key=string.format(\"%.1f:%.1f\",a.pos.x,a.pos.z)\n s.active[key]={id=a.id,ends=TensorReactions_CurrentTimer+eventArgs.channelTimeMax+.3}\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"d682b02f-92c1-d22b-a7b2-64db138e7d93",
									true,
								},
							},
							name = "Begin first-laser preview",
							uuid = "d2c0fa05-5ca4-a0be-8e9a-ed5d16249731",
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
							name = "Laser event",
							spellIDList = 
							{
								40291,
							},
							uuid = "d682b02f-92c1-d22b-a7b2-64db138e7d93",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 3,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Begin first-laser preview",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 45,
				uuid = "77b66f90-3add-9b12-8b5d-08a8f5e114b9",
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
							actionLua = "local s=data.frog_fru_laser_preview\nlocal a=TensorCore.mGetEntity(eventArgs.entityID)\nif s and a then s.active[string.format(\"%.1f:%.1f\",a.pos.x,a.pos.z)]=nil end\nself.used=true\n",
							conditions = 
							{
								
								{
									"e1e49003-fa39-d601-8c7f-72a8616042bd",
									true,
								},
							},
							name = "End first-laser preview",
							uuid = "842f1124-a01b-895f-acee-ad99991037fa",
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
							name = "Laser event",
							spellIDList = 
							{
								40235,
							},
							uuid = "e1e49003-fa39-d601-8c7f-72a8616042bd",
							version = 3,
						},
					},
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 2,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] End first-laser preview",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 45,
				uuid = "6b20ec55-4283-24b3-860a-e8269ce6af0c",
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
							actionLua = "local s=data.frog_fru_laser_preview\nif not s or not next(s.active) then self.used=true return end\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nlocal count=0\nlocal me=TensorCore.mGetPlayer()\nlocal found=false\nfor _,p in pairs(party)do\n if p.id and count<8 then\n  count=count+1;s.players[count]=p.id\n  if me and p.id==me.id then found=true end\n end\nend\nif me and not found and count<8 then count=count+1;s.players[count]=me.id end\nfor i=count+1,#s.players do s.players[i]=nil end\nself.used=true\n",
							name = "Cache laser bait candidates",
							uuid = "bda8839a-a2ac-c056-86d8-c578b8ab2ba9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Cache laser bait candidates",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 45,
				uuid = "96818013-2054-f50a-9a9b-43f631a5d87c",
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
							actionLua = "local s=data.frog_fru_laser_preview\nif not s then self.used=true return end\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nif not s.drawer then\n s.drawer=TensorCore.getCachedDrawer(0x7000C8FF,nil,0x7000C8FF,0xFF60DFFF,2,0,flags)\n s.drawer:setGradient(1,.25,1.2)\nend\nfor key,beam in pairs(s.active)do\n local a=TensorCore.mGetEntity(beam.id)\n if TensorReactions_CurrentTimer>=beam.ends or not a then s.active[key]=nil\n else\n  local nearest,best=nil,math.huge\n  for _,id in ipairs(s.players)do\n   local p=TensorCore.mGetEntity(id)\n   if p and p.hp.current>0 then\n    local distance=(p.pos.x-a.pos.x)^2+(p.pos.z-a.pos.z)^2\n    if distance<best then best=distance;nearest=p end\n   end\n  end\n  if nearest then\n   local h=math.atan2(nearest.pos.x-a.pos.x,nearest.pos.z-a.pos.z)\n   s.drawer:addRect(a.pos.x,a.pos.y+.04,a.pos.z,60,5,h,false,flags)\n  end\n end\nend\nself.used=true\n",
							name = "Predict first laser",
							uuid = "2d496803-be03-8113-a41e-3a9da7fdbd90",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 12,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Predict first laser",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 45,
				uuid = "8f7aae30-9502-2bf2-8017-32796c424525",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal state=data.frog_fru_ur\nlocal shapes=data.frog_fru_ur_aoes\nif not shapes then shapes={active={},drawn={}};data.frog_fru_ur_aoes=shapes end\nif not prefs or prefs.styleFor(\"ur\")==\"Disabled\" or not state or state.done then\n for _,shape in pairs(shapes.active)do Argus.deleteTimedShape(shape.uuid);if shape.innerHalo then Argus.deleteTimedShape(shape.innerHalo)end;if shape.innerRing then Argus.deleteTimedShape(shape.innerRing)end;if shape.outerRing then Argus.deleteTimedShape(shape.outerRing)end  end\n shapes.active={};shapes.drawn={};self.used=true return\nend\nif shapes.paletteVersion~=8 then\n for _,shape in pairs(shapes.active)do Argus.deleteTimedShape(shape.uuid);if shape.innerHalo then Argus.deleteTimedShape(shape.innerHalo)end;if shape.innerRing then Argus.deleteTimedShape(shape.innerRing)end;if shape.outerRing then Argus.deleteTimedShape(shape.outerRing)end  end\n shapes.active={};shapes.drawn={};shapes.paletteVersion=8\nend\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nfor _,record in pairs(state.records)do\n local actor=TensorCore.mGetEntity(record.id)\n for _,buffID in ipairs({2455,2462})do\n  local key=tostring(record.id)..\":\"..buffID\n  local buff=actor and actor.hp.current>0 and TensorCore.getBuff(actor,buffID)\n  local shape=shapes.active[key]\n  if buffID==2462 and (not buff or buff.duration>3) then\n   if shape then\n    Argus.deleteTimedShape(shape.uuid)\n    if shape.innerHalo then Argus.deleteTimedShape(shape.innerHalo)end\n    if shape.innerRing then Argus.deleteTimedShape(shape.innerRing)end\n    if shape.outerRing then Argus.deleteTimedShape(shape.outerRing)end\n   end\n   shapes.active[key]=nil;shapes.drawn[key]=nil;shape=nil\n  end\n  if shape and not buff then Argus.deleteTimedShape(shape.uuid);if shape.innerHalo then Argus.deleteTimedShape(shape.innerHalo)end;if shape.innerRing then Argus.deleteTimedShape(shape.innerRing)end;if shape.outerRing then Argus.deleteTimedShape(shape.outerRing)end  ;shapes.active[key]=nil end\n  if buff and buff.duration>0 and buff.duration<=3 and not shapes.drawn[key] then\n   local ice=buffID==2462\n   local outline=ice and 0xFFFF8000 or 0xFF0000FF\n   local start=ice and 0x28FFD040 or 0x2800FFFF\n   local middle=ice and 0x288040FF or 0x280088FF\n   local finish=0x280000FF\n   local drawer=TensorCore.getCachedDrawer(start,middle,finish,outline,2,0,flags)\n   if ice then drawer:setGradient(0,1,0) else drawer:setGradient(1.5,0.05,2) end\n   local duration=buff.duration*1000\n   local uuid\n   if ice then uuid=drawer:addTimedDonutOnEnt(duration,record.id,3,12,0,false,true,flags)\n   else uuid=drawer:addTimedCircleOnEnt(duration,record.id,8,0,false,true,flags)end\n   if uuid then\n    local entry={uuid=uuid,id=record.id}\n\n    shapes.active[key]=entry;shapes.drawn[key]=true\n   end\n  end\n  local active=shapes.active[key]\n  if buffID==2462 and active and buff and buff.duration>0 and buff.duration<=3 and (not active.innerHalo or not active.innerRing or not active.outerRing)then\n   local ringFlags=flags+Argus2.RenderFlags.FLAG_RENDER_UI\n   local halo=TensorCore.getCachedDrawer(0,0,0,0xFF101010,7,0,ringFlags)\n   local ring=TensorCore.getCachedDrawer(0,0,0,0xFFFF8000,3.5,0,ringFlags)\n   local duration=buff.duration*1000\n   if not active.innerHalo then active.innerHalo=halo:addTimedCircleOnEnt(duration,record.id,3,0,false,true,ringFlags)end\n   if not active.innerRing then active.innerRing=ring:addTimedCircleOnEnt(duration,record.id,3,0,false,true,ringFlags)end\n   if not active.outerRing then active.outerRing=ring:addTimedCircleOnEnt(duration,record.id,12,0,false,true,ringFlags)end\n  end\n end\nend\nself.used=true",
							name = "[UR] Fire and ice telegraphs",
							uuid = "4cbc3f3c-524e-2bfe-8cd9-008d62d2c6e6",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Fire and ice telegraphs",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 45,
				uuid = "7063bb20-8db9-797c-a5c6-c47b0c432a17",
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
							actionLua = "local old=eventArgs.oldData\nlocal shapes=old and old.frog_fru_ur_aoes\nif shapes then for _,shape in pairs(shapes.active)do Argus.deleteTimedShape(shape.uuid);if shape.innerHalo then Argus.deleteTimedShape(shape.innerHalo)end;if shape.innerRing then Argus.deleteTimedShape(shape.innerRing)end;if shape.outerRing then Argus.deleteTimedShape(shape.outerRing)end  end end\nself.used=true",
							name = "[UR] Clear debuff telegraphs",
							uuid = "76c1e9a4-7624-c1a4-b0d5-d8920a8b3070",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Ultimate Relativity",
				eventType = 9,
				loop = true,
				mechanicTime = 532.4,
				name = "[UR] Clear debuff telegraphs",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = 1400,
				timerStartOffset = -600,
				uuid = "90d1fe09-3920-2606-aa7d-696e1e1de1a9",
				version = 2,
			},
		},
	},
	[141] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P3 Apocalypse",
				uuid = "e6fe1079-cfc1-c409-8132-ffada52a1262",
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
							actionLua = "local s={start=Now(),bossID=eventArgs.entityID,stage=0,waterWaves=0,records={},nextPoll=0}\ndata.frog_fru_apoc=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.flex(records)\n local swapS,swapD={},{}\n for category=0,3 do\n  local a,b={},{}\n  for i,key in ipairs(s.keys) do\n   if records[key].water==category then\n    local bucket=i<=4 and a or b;bucket[#bucket+1]=key\n   end\n  end\n  if #a+#b~=2 then return false end\n  if #a==2 then swapS[#swapS+1]=a[1] end\n  if #b==2 then swapD[#swapD+1]=b[1] end\n end\n if #swapS~=#swapD then return false end\n local rank={};for i,key in ipairs(s.keys) do rank[key]=i;records[key].slot=key;records[key].group=i<=4 and 1 or 2 end\n table.sort(swapS,function(a,b)return rank[a]<rank[b]end)\n table.sort(swapD,function(a,b)return rank[a]<rank[b]end)\n for i,a in ipairs(swapS) do\n  local b=swapD[i]\n  records[a].slot=b;records[a].group=2\n  records[b].slot=a;records[b].group=1\n end\n if FrogFRUDrawSettings and FrogFRUDrawSettings.region==\"JP\" then\n  local priority={\"M1\",\"M2\",\"T1\",\"T2\",\"R1\",\"H1\",\"R2\",\"H2\"}\n  local slots={{\"T1\",\"T2\",\"H1\",\"H2\"},{\"M1\",\"M2\",\"R1\",\"R2\"}}\n  local nextSlot={1,1}\n  for _,role in ipairs(priority) do\n   local group=records[role].group\n   records[role].slot=slots[group][nextSlot[group]]\n   nextSlot[group]=nextSlot[group]+1\n  end\n end\n return true\nend\nfunction s.lightPattern(lights)\n local center,outer\n for _,a in pairs(lights) do\n  local r=(a.pos.x-100)^2+(a.pos.z-100)^2\n  if r<1 then center=a elseif r>100 and r<250 then outer=a end\n end\n if not center or not outer then return false end\n local radial=math.atan2(outer.pos.x-100,outer.pos.z-100)\n local delta=(outer.pos.h-radial+math.pi)%(2*math.pi)-math.pi\n if math.abs(math.abs(delta)-math.pi/2)>0.2 then return false end\n s.startHeading=center.pos.h;s.rotation=delta/2\n local angle=s.startHeading-s.rotation\n local x,z=math.sin(angle),math.cos(angle)\n if x>0.01 or (math.abs(x)<=0.01 and z>0) then x=-x;z=-z end\n if FrogFRUDrawSettings and FrogFRUDrawSettings.region==\"JP\" then\n  local east,south=outer.pos.x-100,outer.pos.z-100\n  if south>0.1 or (math.abs(south)<=0.1 and east>0) then radial=radial+math.pi end\n  x,z=math.sin(radial-s.rotation),math.cos(radial-s.rotation)\n end\n s.supportX=x;s.supportZ=z\n return true\nend\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local records,used={},{}\n local wet=0\n for i,key in ipairs(s.keys) do\n  local m=members[key]\n  if not m or not m.job or not m.name then return false end\n  local a,count=nil,0\n  for _,p in pairs(party) do if p.name==m.name and p.job==m.job then a=p;count=count+1 end end\n  if count==0 then\n   local rosterCount=0\n   for _,other in pairs(members) do if other.job==m.job then rosterCount=rosterCount+1 end end\n   if rosterCount==1 then for _,p in pairs(party) do if p.job==m.job then a=p;count=count+1 end end end\n  end\n  if count~=1 or used[a.id] then return false end\n  used[a.id]=true\n  local water=TensorCore.getBuff(a,2461)\n  if water then wet=wet+1 end\n  records[key]={id=a.id,waterEnd=water and Now()+water.duration*1000 or nil,water=water and (water.duration<16 and 1 or water.duration<33 and 2 or 3) or 0,\n   group=i<=4 and 1 or 2,slot=key}\n  if a.id==me.id then s.myRole=key end\n end\n if not s.myRole then return false end\n s.initialRecords=records\n if not s.waterAssigned or Now()-s.waterAssigned>5000 or wet~=6 then return false end\n if not s.flex(records) then return false end\n s.records=records;s.ready=true\n for _,v in pairs(records)do if v.water==1 and v.waterEnd then s.firstWaterAt=s.firstWaterAt and math.min(s.firstWaterAt,v.waterEnd) or v.waterEnd end end\n return true\nend\nfunction s.eruptionPoint(key)\n local ux,uz=s.supportX,s.supportZ\n local support=key:sub(1,1)==\"T\" or key:sub(1,1)==\"H\"\n if not support then ux=-ux;uz=-uz end\n local role=key:sub(1,1);local g1=key:sub(2,2)==\"1\"\n if role==\"H\" or role==\"R\" then\n  local side=g1 and 1 or -1\n  return 100+19*(math.cos(math.pi/12)*ux-side*math.sin(math.pi/12)*uz),100+19*(math.cos(math.pi/12)*uz+side*math.sin(math.pi/12)*ux)\n end\n local alt=(s.rotation<0 and not g1) or (s.rotation>0 and g1)\n if alt then\n  local c,t=math.cos(s.rotation),math.sin(s.rotation)\n  ux,uz=c*ux-t*uz,t*ux+c*uz\n end\n local radius=alt and (s.apocWaves or 0)>=2 and 4.5 or 9.5\n return 100+radius*ux,100+radius*uz\nend\nfunction s.baitPoint(me)\n if not s.startHeading then return end\n if not s.baitX then\n  local a=s.startHeading+math.pi/2\n  local bx,bz=17*math.sin(a),17*math.cos(a)\n  if (me.pos.x-100-bx)^2+(me.pos.z-100-bz)^2>(me.pos.x-100+bx)^2+(me.pos.z-100+bz)^2 then bx=-bx;bz=-bz end\n  s.baitX=100+bx;s.baitZ=100+bz\n end\n return s.baitX,s.baitZ\nend\nfunction s.poll()\n local now=Now()\n if now<s.nextPoll then return end\n s.nextPoll=now+100;s.keepVisible=true;s.destination=nil;s.spots=nil\n if s.baitPreview then s.baitPreview.active=false end\n local me=TensorCore.mGetPlayer()\n if not me or me.hp.current<=0 or s.done or now-s.start>65000 then return end\n if not s.ready then\n  s.capture()\n  if not s.ready and (s.stage~=0 or not s.initialRecords) then return end\n end\n local records=s.ready and s.records or s.initialRecords\n local r=records and s.myRole and records[s.myRole]\n if not r then return end\n local prefs=FrogFRUDrawSettings or {bait=\"T1\",kb=true,mode=\"Tether\"}\n if prefs.mode==\"Disabled\" or (prefs.styleFor and prefs.styleFor(\"apoc\")==\"Disabled\") then return end\n local dance=data.frog_fru_arrow_casts and data.frog_fru_arrow_casts[40181]\n local danceStarted=dance and dance.at>=s.start and dance.at<=now\n local slot=r.slot\n local box={H1={-8,-2},T1={-5,-2},H2={-8,2},T2={-5,2},M2={5,-2},R2={8,-2},M1={5,2},R1={8,2}}\n local spirit={H1={-14,-8},T1={-5,-8},H2={-14,8},T2={-5,8},M2={5,-8},R2={14,-8},M1={5,8},R1={14,8}}\n if prefs.region==\"EU\" then\n  spirit={T1={-2,-7},T2={-7,-2},H1={-2,-15},H2={-15,-2},M1={7,2},M2={2,7},R1={15,2},R2={2,15}}\n end\n if prefs.region==\"JP\" then\n  local early={T1={-2.7,-9.3},T2={-6.6,-6.7},H1={-5.8,-13.2},H2={-10.1,-10.6},M1={1.6,6.9},M2={5.5,4},R1={4.8,10.3},R2={9,7.4}}\n  spirit=s.stage==0 and early or {T1={2,-8},T2={-5.7,-3},H1={-2.8,-16.1},H2={-11.2,-11.6},M1={0,8},M2={8.4,3.8},R1={4.8,16.1},R2={13.6,11.1}}\n  for index,key in ipairs(s.keys) do\n   box[key]=index<=4 and {-6,-8.5} or {5,9.8}\n  end\n end\n local x,z,label\n if s.stage==0 then\n  if not s.ready then\n   local point=spirit[s.myRole]\n   s.destination={x=100+point[1],y=.07,z=100+point[2],label=\"Stay spread: wait for water\"}\n   return\n  end\n  local firstGroup=r.group==1\n  if prefs.region==\"EU\" then\n   local wx,wy,wz,active=Argus.getWaymarkInfo(firstGroup and 5 or 7)\n   if active then x,z=wx,wz else x,z=firstGroup and 93 or 107,firstGroup and 93 or 107 end\n  elseif prefs.region==\"JP\" then\n   x,z=firstGroup and 94 or 105,firstGroup and 91.5 or 109.8\n  else x,z=firstGroup and 93.5 or 106.5,100 end\n  label=s.ready and \"First water stack; flex applied\" or (firstGroup and \"Supports: preposition; wait for water\" or \"DPS: preposition; wait for water\")\n elseif s.stage==1 then\n  local p=spirit[slot];x=100+p[1];z=100+p[2];label=\"Spirit Taker spread\"\n  s.spots={}\n  for _,key in ipairs(s.keys)do local r=records[key];if r then local p=spirit[r.slot];s.spots[#s.spots+1]={x=100+p[1],z=100+p[2]}end end\n else\n  if not s.supportX then s.lightPattern(TensorCore.entityList(\"contentid=2011391\")) end\n  if not s.supportX then s.reason=\"Waiting for Apoc light entities\";return end\n  local perma=prefs.region==\"EU\" or prefs.region==\"JP\" or prefs.region==\"Elemental\"\n  local spreadRole=perma and r.slot or s.myRole\n  local originalSupport=spreadRole:sub(1,1)==\"T\" or spreadRole:sub(1,1)==\"H\"\n  local ux,uz=s.supportX,s.supportZ\n  if (s.stage==2 and not originalSupport) or (s.stage~=2 and r.group==2) then ux=-ux;uz=-uz end\n  if s.stage==2 then\n   x,z=s.eruptionPoint(spreadRole)\n   s.spots={}\n   for _,key in ipairs(s.keys)do local px,pz=s.eruptionPoint(perma and records[key].slot or key);s.spots[#s.spots+1]={x=px,z=pz}end\n   label=\"Static Dark Eruption spread\"\n  elseif s.stage==3 or s.stage==4 then\n   x=100+4.5*ux;z=100+4.5*uz;label=\"Water stack; flex applied\"\n   if s.stage==4 and s.myRole==prefs.bait and danceStarted then\n    x,z=s.baitPoint(me);label=\"Bait Darkest Dance\"\n    if x and not s.baitNowSpoken then s.baitNowSpoken=true;FrogFRUDrawSettings.callout(\"Bait now\") end\n   end\n  elseif s.stage==5 or s.stage==6 then\n   local boss=TensorCore.mGetEntity(s.bossID)\n   if not boss then return end\n   local dx,dz=100-boss.pos.x,100-boss.pos.z\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<5 then return end\n   dx=dx/length;dz=dz/length\n   local angle=(r.group==1 and 1 or -1)*math.pi*5/36\n   local c,t=math.cos(angle),math.sin(angle)\n   local vx,vz=c*dx-t*dz,t*dx+c*dz\n   if s.stage==5 then x=boss.pos.x+3*vx;z=boss.pos.z+3*vz;label=\"Knockback side; flex applied\"\n   else x=boss.pos.x+9.5*vx;z=boss.pos.z+9.5*vz;label=\"Final water stack; flex applied\" end\n  end\n end\n if x then s.reason=nil;s.destination={x=x,y=0.07,z=z,label=label} end\n if s.stage==3 and s.myRole==prefs.bait and danceStarted and s.destination then\n  local waterAt\n  for _,record in pairs(records)do\n   if record.group==r.group and record.water==2 and record.waterEnd then waterAt=record.waterEnd;break end\n  end\n  if waterAt and now>=math.max(waterAt-3000,dance.at) then\n   local bx,bz=s.baitPoint(me)\n   if bx then\n    local p=s.baitPreview\n    if not p then p={origin={pos={}},stage=\"dance-preview\",keepVisible=true,arrowHoldAfterDeadline=true};s.baitPreview=p end\n    p.active=true;p.x=bx;p.y=.07;p.z=bz;p.arrowDeadline=dance.deadline\n    p.origin.pos.x=x;p.origin.pos.y=.07;p.origin.pos.z=z\n    p.heading=math.atan2(bx-x,bz-z)\n    if not s.waitStackSpoken then s.waitStackSpoken=true;FrogFRUDrawSettings.callout(\"Wait for stack\") end\n   end\n  end\n end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"c30b3f37-5562-d714-b2f7-bef67ec4e904",
									true,
								},
							},
							name = "Initialize Apocalypse solver",
							uuid = "1f848b0c-d5a4-1c37-8e4b-fcd5ca0b9afa",
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
							eventSpellID = 40269,
							name = "Refrain",
							uuid = "c30b3f37-5562-d714-b2f7-bef67ec4e904",
							version = 3,
						},
					},
				},
				displayPath = "P3 Apocalypse",
				eventType = 2,
				mechanicTime = 604.5,
				name = "[Apoc] Initialize responsibilities",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "f127e1c1-34c8-ab75-b947-ffc4c7adf5b7",
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
							actionLua = "local s=data.frog_fru_apoc\nif s then\n local now=Now()\n local prefs=FrogFRUDrawSettings or {}\n if s.stage==3 and s.waterWaves==1 and s.myRole==prefs.bait then\n  local me=TensorCore.mGetPlayer()\n  if me then\n   for _,id in ipairs(eventArgs.hitTargets or {})do\n    if id==me.id then s.stage=4;break end\n   end\n  end\n end\n if not s.waterBatchAt or now-s.waterBatchAt>1000 then\n  s.waterBatchAt=now;s.waterHits={};s.waterHitCount=0\n end\n if not s.waterHits[eventArgs.entityID] then\n  s.waterHits[eventArgs.entityID]=true;s.waterHitCount=s.waterHitCount+1\n  if s.waterHitCount==2 then\n   s.lastWater=now;s.waterWaves=s.waterWaves+1\n   if s.waterWaves==1 then s.stage=1 elseif s.waterWaves==2 then s.stage=4 else s.done=true end\n   s.nextPoll=0;s.destination=nil\n  end\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"cc0a5f27-4111-4cd1-9ca4-6f062509ea55",
									true,
								},
							},
							name = "Advance water stack",
							uuid = "f101bed1-e020-3ddd-a3a1-b755cd6cbe45",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_apoc\nif s then s.stage=2;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"8ab99638-7682-0cf7-bd5e-b1cd525a2886",
									true,
								},
							},
							name = "After Spirit Taker",
							uuid = "8c8b4999-b0cb-9ca1-8bd9-97c638a87922",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_apoc\nif s then s.stage=3;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"accec569-6993-f8ec-a6b0-5a7822e8206b",
									true,
								},
							},
							name = "After eruption spreads",
							uuid = "9ea88de5-aadf-904d-a712-da69439e809a",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_apoc\nif s then s.stage=5;s.kbAt=Now()+2800;s.bossID=eventArgs.entityID;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"2c5a5ec5-230f-f19b-aacd-2448d9d9677f",
									true,
								},
							},
							name = "After Darkest Dance jump",
							uuid = "7b74f6ea-192c-c6cf-a806-420016c62975",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_apoc\nif s then s.stage=6;s.kbResolved=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"bbe5bdf6-56a1-8da7-80e9-77e2f8171f37",
									true,
								},
							},
							name = "After knockback",
							uuid = "6422d5ae-d26c-10c6-bf4f-5b9c7f0aa6d7",
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
							eventSpellID = 40271,
							name = "Water resolves",
							uuid = "cc0a5f27-4111-4cd1-9ca4-6f062509ea55",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40289,
							name = "spirit",
							uuid = "8ab99638-7682-0cf7-bd5e-b1cd525a2886",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40274,
							name = "eruption",
							uuid = "accec569-6993-f8ec-a6b0-5a7822e8206b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40182,
							name = "jump",
							uuid = "2c5a5ec5-230f-f19b-aacd-2448d9d9677f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40183,
							name = "knock",
							uuid = "bbe5bdf6-56a1-8da7-80e9-77e2f8171f37",
							version = 3,
						},
					},
				},
				displayPath = "P3 Apocalypse",
				eventType = 2,
				loop = true,
				mechanicTime = 604.5,
				name = "[Apoc] Advance resolved mechanics",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 60,
				timerStartOffset = -2,
				uuid = "c440e752-f474-d576-8741-e7ceb9f5b736",
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
							actionLua = "local s=data.frog_fru_apoc\nif s then s.keepVisible=true;s.poll() end\nself.used=true",
							name = "Update Apocalypse responsibility",
							uuid = "bf088051-826b-ba86-b2d1-25cf0ebba9d2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				loop = true,
				mechanicTime = 604.5,
				name = "[Apoc] Resolve personal position",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 60,
				uuid = "8d3fda8d-0924-4647-a9b4-082a2e7f3839",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_apoc\nlocal player=TensorCore.mGetPlayer()\nlocal preview=s and s.baitPreview\nif prefs and prefs.release and (not preview or not preview.active) then prefs.release(data,\"frog_fru_apoc_preview\")end\nif prefs and prefs.drawSpreads and s and not s.done and s.stage==1 and Now()-s.start<=65000 then\n prefs.drawSpreads(s,\"apoc\")\nend\nif not prefs or not prefs.guide then self.used=true return end\nif not s or not s.destination or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>65000 then prefs.release(data,\"frog_fru_apoc\");self.used=true return end\nlocal style=\"apoc\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_apoc\");self.used=true return end\nlocal point=s.destination\nlocal x,y,z=point.x,point.y or .07,point.z\nlocal label=point.label\ns.arrowHoldAfterDeadline=s.stage==2 or s.stage==3 or s.stage==4\ns.arrowDeadline=nil\nlocal wave=s.stage==0 and 1 or s.stage==3 and 2 or s.stage==6 and 3\nif wave then\n for _,r in pairs(s.records)do\n  if r.water==wave and r.waterEnd then s.arrowDeadline=s.arrowDeadline and math.min(s.arrowDeadline,r.waterEnd) or r.waterEnd end\n end\nelseif prefs.castDeadline then\n if s.stage==1 then s.arrowDeadline=prefs.castDeadline(data,s,{40288})\n elseif s.stage==2 then s.arrowDeadline=prefs.castDeadline(data,s,{40273})\n elseif s.stage==4 then s.arrowDeadline=prefs.castDeadline(data,s,{40181})\n elseif s.stage==5 then s.arrowDeadline=s.kbAt end\nend\nprefs.guide(data,\"frog_fru_apoc\",style,s,player,x,y,z,label,nil,6)\nif preview and preview.active then\n prefs.guide(data,\"frog_fru_apoc_preview\",style,preview,preview.origin,preview.x,preview.y,preview.z,\"Next: Darkest Dance bait\",nil,6)\nend\n\nif prefs.styleFor(style)==\"Tether\" and prefs.markerFor(style,s) and s.spots then\n local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local drawer=TensorCore.getStaticDrawer(0x9040E080,1,0,flags)\n for _,spot in ipairs(s.spots)do drawer:addCircle(spot.x,y,spot.z,.65,false,flags)end\nend\nself.used=true",
							name = "Draw Apocalypse destination",
							uuid = "ac159712-9645-aa48-b387-16994555a8f9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				eventType = 12,
				loop = true,
				mechanicTime = 604.5,
				name = "[Apoc] Personal position tether",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 60,
				uuid = "00e15cb5-f7e2-566a-83ba-0eceb00241e5",
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
							actionLua = "local request=FrogFRUApocKBRequest\nif request then _G[request.var]=request.previous;FrogFRUApocKBRequest=nil end\nself.used=true",
							name = "Clear owned KB Cancel request",
							uuid = "ead7595f-fc4a-b9b3-91f6-9292d8483003",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				eventType = 9,
				mechanicTime = 604.5,
				name = "[Apoc] Clear KB request - wipe",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 1800,
				timerStartOffset = -605,
				uuid = "1f24f4fb-6d04-ec44-9bc6-02a5a65a2395",
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
							actionLua = "local request=FrogFRUApocKBRequest\nif request then _G[request.var]=request.previous;FrogFRUApocKBRequest=nil end\nself.used=true",
							name = "Clear owned KB Cancel request",
							uuid = "15c211fe-6d19-1dec-a85d-ce613b4e2cbe",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				eventType = 16,
				mechanicTime = 604.5,
				name = "[Apoc] Clear KB request - countdown",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 1800,
				timerStartOffset = -605,
				uuid = "739ec2eb-fe86-c456-842f-f2480318d0b1",
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
							actionLua = "local request=FrogFRUApocKBRequest\nif request then _G[request.var]=request.previous;FrogFRUApocKBRequest=nil end\nself.used=true",
							name = "Clear owned KB Cancel request",
							uuid = "88530d6e-4f7e-d2ac-aa29-23b96c7ecffc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				eventType = 11,
				mechanicTime = 604.5,
				name = "[Apoc] Clear KB request - map",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 1800,
				timerStartOffset = -605,
				uuid = "a952632d-2026-3916-bc9e-b33f1225d78a",
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
							actionLua = "local s=data.frog_fru_apoc\nif s and (not s.lastApocWave or Now()-s.lastApocWave>1000)then\n s.lastApocWave=Now();s.apocWaves=(s.apocWaves or 0)+1;s.nextPoll=0\nend\nself.used=true",
							conditions = 
							{
								
								{
									"2e76aefb-6013-fa8e-850c-4571653a7b27",
									true,
								},
							},
							name = "Advance explosion wave",
							uuid = "d5e90e74-556a-d58d-b535-f6de7d44d145",
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
							eventSpellID = 40297,
							name = "Apocalypse hit",
							uuid = "2e76aefb-6013-fa8e-850c-4571653a7b27",
							version = 3,
						},
					},
				},
				displayPath = "P3 Apocalypse",
				eventType = 2,
				loop = true,
				mechanicTime = 604.5,
				name = "[Apoc] Track rotating explosions",
				timeRange = true,
				timelineIndex = 141,
				timerEndOffset = 60,
				uuid = "70e59782-21d2-7dd2-9619-031a8dcb8d5c",
				version = 2,
			},
		},
	},
	[142] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P3 Apocalypse",
				uuid = "f70193ec-a211-a4d7-83f7-6ffd4dd50765",
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
							actionLua = "local s=data.frog_fru_apoc\nif s then s.waterAssigned=Now();s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"ac4f53c5-6033-5932-a434-ae970a066c9b",
									true,
								},
							},
							name = "Allow water snapshot",
							uuid = "e2828d16-85e1-fd23-ad83-5c663eaa2618",
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
							eventSpellID = 40270,
							name = "Water cast",
							uuid = "ac4f53c5-6033-5932-a434-ae970a066c9b",
							version = 3,
						},
					},
				},
				displayPath = "P3 Apocalypse",
				eventType = 2,
				loop = true,
				mechanicTime = 612.6,
				name = "[Apoc] Water assignment begins",
				timeRange = true,
				timelineIndex = 142,
				timerEndOffset = 3,
				timerStartOffset = -2,
				uuid = "3ff608ba-a508-f28a-adec-11002213eb14",
				version = 2,
			},
		},
	},
	[150] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P3 Apocalypse",
				uuid = "aed84c8a-0b8c-f4bb-91a4-7a776788fd39",
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
							actionLua = "local s=data.frog_fru_apoc\nlocal request=FrogFRUApocKBRequest\nlocal now=Now()\nlocal prefs=FrogFRUDrawSettings\nlocal player=TensorCore.mGetPlayer()\nif request and (not s or not player or player.hp.current<=0 or (prefs and prefs.kb==false) or now>=request.expires) then\n _G[request.var]=request.previous\n FrogFRUApocKBRequest=nil\nend\nif s and player and player.hp.current>0 and (not prefs or prefs.kb~=false) and s.kbAt and not s.kbResolved and not s.kbRequested and now>=s.kbAt-500 and now<s.kbAt then\n \n local selected,selectedName,selectedRank\n for _,toggle in pairs(TensorCore.API.TensorACR.getHotbarToggles() or {}) do\n  local name=type(toggle.name)==\"function\" and toggle.name() or toggle.name\n  local rank=1\n  if player.job==22 then rank=toggle.id==36951 and 1 or toggle.id==94 and 2 or nil\n  elseif player.job==30 then rank=toggle.id==2262 and 1 or toggle.id==25777 and 2 or nil end\n  if rank and toggle.enabled~=false and type(name)==\"string\" and name:find(\"KB Cancel\",1,true) and type(toggle.var)==\"string\" then\n   if not selected or rank<selectedRank or (rank==selectedRank and ((name==\"Onslaught KB Cancel\" and selectedName~=\"Onslaught KB Cancel\") or (selectedName~=\"Onslaught KB Cancel\" and name<selectedName))) then\n    selected,selectedName,selectedRank=toggle,name,rank\n   end\n  end\n end\n if selected then\n  s.kbRequested=true\n  if _G[selected.var]~=true then\n   \n   FrogFRUApocKBRequest={var=selected.var,previous=_G[selected.var],expires=s.kbAt+2000}\n   _G[selected.var]=true\n  end\n end\nend\nself.used=true\n",
							name = "Queue current-job KB Cancel",
							uuid = "17b49c01-4836-5f51-b04a-6d1a0afcd73b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P3 Apocalypse",
				loop = true,
				mechanicTime = 644.3,
				name = "[Apoc] Queue gap-closer KB Cancel",
				throttleTime = 50,
				timeRange = true,
				timelineIndex = 150,
				timerEndOffset = 9,
				timerStartOffset = -5,
				uuid = "86b60243-d917-9805-b5f0-7ab7814b1222",
				version = 2,
			},
		},
	},
	[157] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P4 Darklit",
				uuid = "ad06b5b2-521e-8ca2-ac43-4e36bf2ef1f6",
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
							actionLua = "local s={start=Now(),stage=-1,records={},edges={},nextPoll=0}\ndata.frog_fru_darklit=s\ns.shivaID=eventArgs.entityID\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nlocal caster=eventArgs and TensorCore.mGetEntity(eventArgs.entityID)\nif caster and caster.pos and math.abs(caster.pos.z-100)>5 then\n s.spawnSide=caster.pos.z<100 and -1 or 1\nend\nfunction s.manaBait(role)\n if not s.spawnSide then return end\n if not s.baitSpots then\n  s.baitSpots={}\n  for _,side in ipairs({-1,1}) do\n   local x,z=100+side*7.07,100+s.spawnSide*7.07\n   local best=16\n   if Argus and Argus.getWaymarkInfo then\n    for i=1,8 do\n     local mx,_,mz,active=Argus.getWaymarkInfo(i)\n     if active and mx and mz then\n      local d=(mx-x)^2+(mz-z)^2\n      if d<best then best=d;s.baitSpots[side]={mx,mz} end\n     end\n    end\n   end\n   s.baitSpots[side]=s.baitSpots[side] or {x,z}\n  end\n end\n local spot=s.baitSpots[role==\"T1\" and s.spawnSide or -s.spawnSide]\n return spot[1],spot[2]\nend\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local records,used={},{}\n for _,key in ipairs(s.keys) do\n  local m=members[key]\n  if not m or not m.job or not m.name then return false end\n  local a,count=nil,0\n  for _,p in pairs(party) do if p.name==m.name and p.job==m.job then a=p;count=count+1 end end\n  if count==0 then\n   local copies=0\n   for _,other in pairs(members) do if other.job==m.job then copies=copies+1 end end\n   if copies==1 then for _,p in pairs(party) do if p.job==m.job then a=p;count=count+1 end end end\n  end\n  if count~=1 or used[a.id] then return false end\n  used[a.id]=true;records[key]={id=a.id}\n  if a.id==me.id then s.myRole=key end\n end\n if not s.myRole then return false end\n s.records=records;s.rosterReady=true;return true\nend\nfunction s.assign()\n local records=s.records\n local graph={};local edgeCount=0\n for a,b in pairs(s.edges) do\n  local ka,kb\n  for key,r in pairs(records) do if r.id==a then ka=key end;if r.id==b then kb=key end end\n  if not ka or not kb or ka==kb then return false end\n  graph[ka]=graph[ka] or {};graph[kb]=graph[kb] or {}\n  graph[ka][kb]=true;graph[kb][ka]=true;edgeCount=edgeCount+1\n end\n if edgeCount~=4 then return false end\n local healer,tank,dds=nil,nil,{}\n for _,key in ipairs(s.keys) do\n  local g=graph[key];records[key].chain=g~=nil\n  if g then\n   local degree=0;for _ in pairs(g)do degree=degree+1 end;if degree~=2 then return false end\n   local role=key:sub(1,1)\n   if role==\"H\" then if healer then return false end;healer=key\n   elseif role==\"T\" then if tank then return false end;tank=key\n   else dds[#dds+1]=key end\n  end\n end\n if not healer or not tank or #dds~=2 then return false end\n local west,east\n if dds[1]:sub(1,1)~=dds[2]:sub(1,1) then\n  west=dds[1]:sub(1,1)==\"R\" and dds[1] or dds[2];east=west==dds[1] and dds[2] or dds[1]\n elseif dds[1]:sub(1,1)==\"R\" then west=dds[2];east=dds[1]\n else west=dds[1];east=dds[2] end\n local region=(FrogFRUDrawSettings or {}).region\n if region==\"Elemental\" or region==\"JP\" then\n  local rank={M1=1,M2=2,R1=3,R2=4}\n  west=rank[dds[1]]<rank[dds[2]] and dds[1] or dds[2];east=west==dds[1] and dds[2] or dds[1]\n end\n local slots={[healer]={east=false,south=false},[tank]={east=true,south=false},[west]={east=false,south=true},[east]={east=true,south=true}}\n if graph[healer][tank] then\n  local swap=graph[tank][west] and west or graph[tank][east] and east\n  if not swap then return false end\n  slots[tank],slots[swap]=slots[swap],slots[tank]\n end\n for a,links in pairs(graph)do for b in pairs(links)do if slots[a].south==slots[b].south then return false end end end\n local baitDps={}\n for _,key in ipairs(s.keys)do\n  if not records[key].chain then\n   local role=key:sub(1,1)\n   if role==\"H\" then slots[key]={east=false,south=false}\n   elseif role==\"T\" then slots[key]={east=true,south=false}\n   else baitDps[#baitDps+1]=key end\n  end\n end\n if #baitDps~=2 then return false end\n local a,b=baitDps[1],baitDps[2]\n if region==\"Elemental\" or region==\"JP\" then\n  local rank={M1=1,M2=2,R1=3,R2=4}\n  slots[a]={east=rank[a]>rank[b],south=true};slots[b]={east=not slots[a].east,south=true}\n elseif a:sub(1,1)==b:sub(1,1) then\n  slots[a]={east=a:sub(1,1)==\"R\",south=true};slots[b]={east=not slots[a].east,south=true}\n else slots[a]={east=a:sub(1,1)==\"M\",south=true};slots[b]={east=b:sub(1,1)==\"M\",south=true} end\n for key,p in pairs(slots)do records[key].east=p.east;records[key].south=p.south end\n s.chainReady=true;return true\nend\nfunction s.captureWater()\n local waters={};local chained=0\n for _,key in ipairs(s.keys)do\n  local r=s.records[key];local p=TensorCore.mGetEntity(r.id)\n  if not p then return false end\n  if TensorCore.getBuff(p,2461) then waters[#waters+1]=key;if r.chain then chained=chained+1 end end\n end\n if #waters~=2 or chained~=1 then return false end\n local a,b=waters[1],waters[2]\n if s.records[a].south==s.records[b].south then\n  local flex=not s.records[a].chain and a or b\n  local side=s.records[flex].east\n  for _,key in ipairs(s.keys)do local r=s.records[key];if not r.chain and r.east==side then r.south=not r.south;r.waterFlex=true end end\n end\n for _,key in ipairs(waters)do s.records[key].water=true end\n s.waterReady=true;return true\nend\nfunction s.preposition(x,z,melee)\n local boss=TensorCore.mGetEntity(s.shivaID)\n if not boss or not boss.pos then return nil end\n local bx,bz=boss.pos.x,boss.pos.z\n local maximum=melee and boss.hitradius+2.5 or 20\n local function valid(px,pz)\n  if (px-100)^2+(pz-100)^2>19.3^2 or (px-bx)^2+(pz-bz)^2>maximum^2 then return false end\n  if s.rhaiUntil and Now()<s.rhaiUntil then\n   for _,p in pairs(s.rhaiPuddles or {})do\n    local radius=(p.x-100)^2+(p.z-100)^2<=5^2 and 5.5 or 4.5\n    if (px-p.x)^2+(pz-p.z)^2<radius^2 then return false end\n   end\n  end\n  return true\n end\n if valid(x,z)then return x,z end\n for _,p in pairs(s.rhaiPuddles or {})do\n  if (p.x-100)^2+(p.z-100)^2<=5^2 then\n   local dx,dz=x-p.x,z-p.z;local distance=math.sqrt(dx*dx+dz*dz)\n   if distance>0 and distance<5.5 then\n    local px,pz=p.x+dx*5.51/distance,p.z+dz*5.51/distance\n    if valid(px,pz)then return px,pz end\n   end\n  end\n end\n local bestX,bestZ,best\n for _,radius in ipairs({maximum,math.max(1,maximum-1.5),math.max(1,maximum-3)})do\n  for i=0,47 do\n   local h=i*math.pi/24\n   local px,pz=bx+radius*math.sin(h),bz+radius*math.cos(h)\n   if valid(px,pz)then\n    local score=(px-x)^2+(pz-z)^2\n    if not best or score<best then best=score;bestX=px;bestZ=pz end\n   end\n  end\n end\n return bestX,bestZ\nend\nfunction s.akhSoloPoint()\n local now=Now();local cached=s.meleePoint\n if now<(s.meleePointPoll or 0)then\n  if cached then return cached.x,cached.z end\n  return\n end\n s.meleePointPoll=now+100;s.meleePoint=nil\n local bosses={}\n for i,cid in ipairs({12809,9832})do\n  local id=s.meleeBossIDs and s.meleeBossIDs[i]\n  local actor=id and TensorCore.mGetEntity(id)\n  if not actor or not actor.pos or not actor.targetable or not actor.attackable or actor.hp.current<=0 or actor.hitradius<=1 then\n   actor=nil\n   for _,a in pairs(TensorCore.getEntityGroupList(\"ContentID\",{contentid=cid})or{})do\n    if a.pos and a.targetable and a.attackable and a.hp.current>0 and a.hitradius>1 then\n     if actor then return end\n     actor=a\n    end\n   end\n  end\n  if not actor then return end\n  bosses[i]=actor\n end\n local a,b=bosses[1],bosses[2]\n s.meleeBossIDs=s.meleeBossIDs or{}\n s.meleeBossIDs[1],s.meleeBossIDs[2]=a.id,b.id\n local ax,az,bx,bz=a.pos.x,a.pos.z,b.pos.x,b.pos.z\n local ra,rb=a.hitradius+3,b.hitradius+3\n if cached and cached.ax==ax and cached.az==az and cached.bx==bx and cached.bz==bz and cached.ra==ra and cached.rb==rb then s.meleePoint=cached;return cached.x,cached.z end\n local dx,dz=bx-ax,bz-az;local distance=math.sqrt(dx*dx+dz*dz)\n if distance<.01 or distance>ra+rb or distance<math.abs(ra-rb)then return end\n local along=(ra*ra-rb*rb+distance*distance)/(2*distance)\n local height=math.sqrt(math.max(0,ra*ra-along*along))\n local ux,uz=dx/distance,dz/distance\n local mx,mz=ax+along*ux,az+along*uz\n local x1,z1=mx-height*uz,mz+height*ux\n local x2,z2=mx+height*uz,mz-height*ux\n local x,z=x1,z1\n if z2>z1 then x,z=x2,z2 end\n if (x-100)^2+(z-100)^2>19.2^2 or (x-100)^2+(z-100)^2<7^2 then return end\n s.meleePoint={x=x,z=z,ax=ax,az=az,bx=bx,bz=bz,ra=ra,rb=rb}\n return x,z\nend\ns.meleePointVersion=1\nfunction s.poll()\n local now=Now();if now<s.nextPoll then return end\n s.nextPoll=now+100;s.destination=nil\n local me=TensorCore.mGetPlayer()\n if not me or me.hp.current<=0 or s.done or now-s.start>85000 then return end\n local prefs=FrogFRUDrawSettings or {}\n if prefs.darklit==false then return end\n if not s.rosterReady then s.capture() end\n local r=s.records[s.myRole];if not r then return end\n if not s.chainReady and s.assigned then s.assign() end\n if s.chainReady and not s.waterReady then s.captureWater() end\n local x,z,label\n if s.stage==-1 then\n  if prefs.region==\"JP\" then x,z=s.manaBait(s.myRole) else x,z=100,100 end\n  label=\"Stack to bait Akh Rhai\"\n elseif s.stage==0 then\n  local spots={H1={-6,-3},H2={-9,-1},T1={6,-3},T2={9,-1},R1={-9,5},R2={-6,8},M1={6,8},M2={9,5}}\n  if prefs.region==\"EU\" then spots={H1={-2,-6},H2={2,-6},T1={-6,-2},T2={-6,2},M1={2,4},M2={4,4},R1={6,2},R2={6,6}} end\n  if prefs.region==\"Elemental\" or prefs.region==\"JP\" then spots={H1={-6,-3},H2={-2,-5},T1={2,-5},T2={6,-3},M1={-6,3},M2={-2,5},R1={2,5},R2={6,3}} end\n  local p=spots[s.myRole];x,z=100+p[1],100+p[2]\n  local role=s.myRole:sub(1,1)\n  x,z=s.preposition(x,z,role==\"T\" or role==\"M\")\n  label=\"Darklit preposition\"\n elseif s.stage==1 or (s.spreadAt and now<s.spreadAt) then\n  if not s.chainReady then return end\n  local side=r.east and 1 or -1;local ns=r.south and 1 or -1\n  if r.chain then x,z=100+side*1.2,100+ns*9.3;label=\"Hold assigned tower\"\n  else\n   if not s.waterReady then return end\n   x,z=100+side*3.464,100+ns*2;label=r.waterFlex and \"Water swap / close protean bait\" or \"Close protean bait\"\n  end\n elseif s.stage==2 then\n  if not s.chainReady or not s.waterReady then return end\n  local side=r.east and 1 or -1;local ns=r.south and 1 or -1\n  if r.chain then x,z=100+side*7,100+ns*8\n  elseif s.myRole:sub(1,1)==\"H\" or s.myRole:sub(1,1)==\"T\" then x,z=100+side*15,100\n  else x,z=100+side*6.5,100 end\n  label=\"Spirit Taker spread\"\n elseif s.stage==3 then\n  if not s.waterReady or not s.safeSide then return end\n  x,z=100+s.safeSide*5,100+(r.south and 7.5 or -7.5);label=\"Safe wing side / water stack\"\n elseif s.stage==4 or s.stage==5 then\n  if s.myRole~=\"T1\" and s.myRole~=\"T2\" then return end\n  local boss=TensorCore.mGetEntity(s.gaiaID);if not boss then return end\n  local farRole=(prefs.somber==\"T2 both\" or prefs.somber==\"T2 then T1\") and \"T2\" or \"T1\"\n  local nearRole=(prefs.somber==\"T1 both\" or prefs.somber==\"T2 then T1\") and \"T1\" or (prefs.somberBoth and not prefs.somber and \"T1\" or \"T2\")\n  if s.stage==4 and s.myRole==farRole then\n   if not s.farX then s.farX=boss.pos.x>=100 and 82 or 118 end\n   x,z=s.farX,100;label=\"Arc out: Somber Dance far bait\"\n  elseif s.stage==5 and s.myRole==nearRole then x,z=boss.pos.x,boss.pos.z;label=\"Somber Dance close bait\"\n  else\n   local dx,dz=100-boss.pos.x,100-boss.pos.z;local dist=math.sqrt(dx*dx+dz*dz)\n   if dist<1 then x,z=100,94 else x,z=boss.pos.x+dx/dist*11,boss.pos.z+dz/dist*11 end\n   label=\"Keep clear of Somber Dance bait\"\n  end\n elseif s.stage==6 then\n  if prefs.akh==\"6-2\" then\n   local tank=s.myRole==\"T1\" or s.myRole==\"T2\"\n   x,z=100,tank and 112 or 100;label=tank and \"Akh Morn: two tanks\" or \"Akh Morn: six stack\"\n  elseif prefs.akh==\"4-4\" then x,z=100,s.myRole:sub(2,2)==\"1\" and 95 or 105;label=\"Akh Morn: roster light party\"\n  else\n   local solo=prefs.akhSolo or \"T2\"\n   x,z=100,100\n   if s.myRole==solo then\n    if prefs.region==\"JP\" then x,z=solo==\"T1\" and 88 or 112,100\n    else x,z=s.akhSoloPoint()end\n   end\n   label=s.myRole==solo and \"Akh Morn: solo tank\" or \"Akh Morn: seven stack\"\n  end\n elseif s.stage==7 then x,z=100,100;label=\"Morn Afah: full party stack\" end\n if x then s.destination={x=x,y=0.07,z=z,label=label} end\nend\nself.used=true\n",
							conditions = 
							{
								
								{
									"6c6c2181-c52a-a0ff-a5a4-5adfb5ff83d6",
									true,
								},
							},
							name = "Initialize Darklit solver",
							uuid = "a5ce9b98-a6d5-1ccd-8baf-84c19d3612a1",
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
							eventSpellID = 40246,
							name = "material",
							uuid = "6c6c2181-c52a-a0ff-a5a4-5adfb5ff83d6",
							version = 3,
						},
					},
				},
				displayPath = "P4 Darklit",
				eventType = 2,
				mechanicTime = 712.9,
				name = "[Darklit] Initialize responsibilities",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 2,
				timerStartOffset = -2,
				uuid = "4ebeb0dd-a983-e6e5-8d77-774817b02cd1",
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
							actionLua = "local s=data.frog_fru_darklit\nif s then\n if eventArgs.castPosX and eventArgs.castPosZ then\n  if not s.rhaiPuddles then s.rhaiPuddles={}end\n  s.rhaiPuddles[eventArgs.entityID]={x=eventArgs.castPosX,z=eventArgs.castPosZ}\n  s.rhaiUntil=Now()+6500\n end\n\nend\nself.used=true",
							conditions = 
							{
								
								{
									"aeccca02-eb94-d5b8-8fc8-cc06ec93ecd4",
									true,
								},
							},
							name = "Advance wingsout",
							uuid = "b33a8083-6774-8695-9f1a-84844c452dcc",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.assigned=true;s.stage=1;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"a3514dae-f558-9763-abbb-b9a67de38bc7",
									true,
								},
							},
							name = "Advance assign",
							uuid = "689ddaf9-48fa-fb9f-9fae-5ee7d5cd0fa1",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then if s.stage==1 then s.stage=2;s.spreadAt=Now()+500 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"91fed5ee-5679-6962-8fb8-fe1ad49d20e5",
									true,
								},
							},
							name = "Advance towers",
							uuid = "e607cd63-8636-7886-a916-3398c2bf4f1e",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.stage=3;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"90c42894-1996-8b56-bf7d-16a5646b4b0b",
									true,
								},
							},
							name = "Advance spread",
							uuid = "28babed4-9735-884b-a5ae-ca406b898c4b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.waterDone=true;if s.wingDone then s.stage=4 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"3eb1a7b0-19dc-69de-ab0a-3624715d0fe0",
									true,
								},
							},
							name = "Advance water",
							uuid = "fa18840a-49d8-e5a7-bbc4-4d7de19e55d2",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.wingDone=true;if s.waterDone then s.stage=4 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"5f314058-bdc3-6aae-8216-98008ba39a63",
									true,
								},
							},
							name = "Advance cleaveE",
							uuid = "d4d776b0-8234-ba69-8693-a05a7df60544",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.wingDone=true;if s.waterDone then s.stage=4 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"c66a939f-846f-fac5-be88-b32cf0628c42",
									true,
								},
							},
							name = "Advance cleaveW",
							uuid = "cc3a3079-4efc-4005-8055-065dc77b7239",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.stage=5;s.somberNearDeadline=Now()+3250;s.gaiaID=eventArgs.entityID;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"fd442211-a038-03f6-88ab-18c89b78b82d",
									true,
								},
							},
							name = "Advance far",
							uuid = "926621f3-019a-c58f-871b-c3e7488d6e16",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.stage=6;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"94281801-5173-2657-b36f-ea4cb8b16f06",
									true,
								},
							},
							name = "Advance near",
							uuid = "da3ac115-73f9-ddec-b1b8-04473e596e2c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s and (s.stage==6) and (not s.lastAkhPulse or Now()-s.lastAkhPulse>600) then\n s.lastAkhPulse=Now();s.akhPulses=(s.akhPulses or 0)+1\n if not s.akhDeadline then s.akhDeadline=Now()+4250 end\n if s.akhPulses>=5 then\n s.stage=7;s.afahDeadline=Now()+6150\n s.nextPoll=0;s.destination=nil\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"31c1ae73-231e-e740-be16-b93690232ae7",
									true,
								},
							},
							name = "Track Akh first hit",
							uuid = "16dc1185-2b2e-9c08-9859-ab9f0888e8d5",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s and (s.stage==6) and (not s.lastAkhPulse or Now()-s.lastAkhPulse>600) then\n s.lastAkhPulse=Now();s.akhPulses=(s.akhPulses or 0)+1\n if not s.akhDeadline then s.akhDeadline=Now()+4250 end\n if s.akhPulses>=5 then\n s.stage=7;s.afahDeadline=Now()+6150\n s.nextPoll=0;s.destination=nil\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"29e12a7c-173e-0bb5-9880-10b0a3ddd46d",
									true,
								},
							},
							name = "Track Akh repeat hits",
							uuid = "a3557b47-3f8c-ee8c-9f02-360f322106d8",
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
							eventSpellID = 40237,
							name = "Akh Rhai snapshot",
							uuid = "aeccca02-eb94-d5b8-8fc8-cc06ec93ecd4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40239,
							name = "assign",
							uuid = "a3514dae-f558-9763-abbb-b9a67de38bc7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40213,
							name = "towers",
							uuid = "91fed5ee-5679-6962-8fb8-fe1ad49d20e5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40289,
							name = "spread",
							uuid = "90c42894-1996-8b56-bf7d-16a5646b4b0b",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40271,
							name = "water",
							uuid = "3eb1a7b0-19dc-69de-ab0a-3624715d0fe0",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40227,
							name = "cleaveE",
							uuid = "5f314058-bdc3-6aae-8216-98008ba39a63",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40228,
							name = "cleaveW",
							uuid = "c66a939f-846f-fac5-be88-b32cf0628c42",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40284,
							name = "far",
							uuid = "fd442211-a038-03f6-88ab-18c89b78b82d",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40285,
							name = "near",
							uuid = "94281801-5173-2657-b36f-ea4cb8b16f06",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40247,
							name = "Akh first",
							uuid = "31c1ae73-231e-e740-be16-b93690232ae7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40248,
							name = "Akh repeats",
							uuid = "29e12a7c-173e-0bb5-9880-10b0a3ddd46d",
							version = 3,
						},
					},
				},
				displayPath = "P4 Darklit",
				eventType = 2,
				loop = true,
				mechanicTime = 712.9,
				name = "[Darklit] Advance resolved mechanics",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 73,
				timerStartOffset = -2,
				uuid = "e94bf4af-45e9-2dff-8fe9-1037ff7b79c6",
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
							actionLua = "local s=data.frog_fru_darklit\nif s then s.gaiaID=eventArgs.entityID;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"b3ea646b-ace7-e39e-bd63-a3c833a8e786",
									true,
								},
							},
							name = "Observe gaia",
							uuid = "cba20a95-3e32-4b5b-88f3-e98df1ead385",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.safeSide=1;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"e79717a0-74ba-e891-9384-71d8a9da3267",
									true,
								},
							},
							name = "Observe east",
							uuid = "36b4f34d-2c38-88ad-a9dd-553f4ffa43eb",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.safeSide=-1;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"68b8f797-837a-d1ea-9f36-cc8efbf8336f",
									true,
								},
							},
							name = "Observe west",
							uuid = "58182d96-4aec-1148-9609-61fabbbf07eb",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.stage=6;s.akhPulses=0;s.lastAkhPulse=nil;s.akhDeadline=Now()+eventArgs.channelTimeMax*1000+4500;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"82623d6b-f2dc-e672-b786-7e7c733f7c61",
									true,
								},
							},
							name = "Observe akh",
							uuid = "771800e1-24cc-ee87-a093-263986806aef",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_darklit\nif s then s.stage=7;s.afahDeadline=Now()+eventArgs.channelTimeMax*1000;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"212736f9-0452-e28f-8a88-6ef292dbca0e",
									true,
								},
							},
							name = "Observe afah",
							uuid = "6e10aeef-65bd-79f2-8a1f-55fe3f19a0e3",
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
							eventSpellID = 40301,
							name = "gaia",
							uuid = "b3ea646b-ace7-e39e-bd63-a3c833a8e786",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40227,
							name = "east",
							uuid = "e79717a0-74ba-e891-9384-71d8a9da3267",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40228,
							name = "west",
							uuid = "68b8f797-837a-d1ea-9f36-cc8efbf8336f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40247,
							name = "akh",
							uuid = "82623d6b-f2dc-e672-b786-7e7c733f7c61",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40304,
							name = "afah",
							uuid = "212736f9-0452-e28f-8a88-6ef292dbca0e",
							version = 3,
						},
					},
				},
				displayPath = "P4 Darklit",
				eventType = 3,
				loop = true,
				mechanicTime = 712.9,
				name = "[Darklit] Read bosses and wing side",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 73,
				timerStartOffset = -2,
				uuid = "a241b60a-891d-0ad0-b122-f59b28b89622",
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
							actionLua = "local s=data.frog_fru_darklit\nif s then s.poll() end\nself.used=true",
							name = "Update Darklit responsibility",
							uuid = "310cf471-773f-f2e5-84f1-287435d353fd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Darklit",
				loop = true,
				mechanicTime = 712.9,
				name = "[Darklit] Resolve personal destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 73,
				uuid = "47d5d061-bea1-f414-8a88-f678ba7da18c",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_darklit\nlocal player=TensorCore.mGetPlayer()\nif s and s.meleePointVersion~=1 then\nfunction s.akhSoloPoint()\n local now=Now();local cached=s.meleePoint\n if now<(s.meleePointPoll or 0)then\n  if cached then return cached.x,cached.z end\n  return\n end\n s.meleePointPoll=now+100;s.meleePoint=nil\n local bosses={}\n for i,cid in ipairs({12809,9832})do\n  local id=s.meleeBossIDs and s.meleeBossIDs[i]\n  local actor=id and TensorCore.mGetEntity(id)\n  if not actor or not actor.pos or not actor.targetable or not actor.attackable or actor.hp.current<=0 or actor.hitradius<=1 then\n   actor=nil\n   for _,a in pairs(TensorCore.getEntityGroupList(\"ContentID\",{contentid=cid})or{})do\n    if a.pos and a.targetable and a.attackable and a.hp.current>0 and a.hitradius>1 then\n     if actor then return end\n     actor=a\n    end\n   end\n  end\n  if not actor then return end\n  bosses[i]=actor\n end\n local a,b=bosses[1],bosses[2]\n s.meleeBossIDs=s.meleeBossIDs or{}\n s.meleeBossIDs[1],s.meleeBossIDs[2]=a.id,b.id\n local ax,az,bx,bz=a.pos.x,a.pos.z,b.pos.x,b.pos.z\n local ra,rb=a.hitradius+3,b.hitradius+3\n if cached and cached.ax==ax and cached.az==az and cached.bx==bx and cached.bz==bz and cached.ra==ra and cached.rb==rb then s.meleePoint=cached;return cached.x,cached.z end\n local dx,dz=bx-ax,bz-az;local distance=math.sqrt(dx*dx+dz*dz)\n if distance<.01 or distance>ra+rb or distance<math.abs(ra-rb)then return end\n local along=(ra*ra-rb*rb+distance*distance)/(2*distance)\n local height=math.sqrt(math.max(0,ra*ra-along*along))\n local ux,uz=dx/distance,dz/distance\n local mx,mz=ax+along*ux,az+along*uz\n local x1,z1=mx-height*uz,mz+height*ux\n local x2,z2=mx+height*uz,mz-height*ux\n local x,z=x1,z1\n if z2>z1 then x,z=x2,z2 end\n if (x-100)^2+(z-100)^2>19.2^2 or (x-100)^2+(z-100)^2<7^2 then return end\n s.meleePoint={x=x,z=z,ax=ax,az=az,bx=bx,bz=bz,ra=ra,rb=rb}\n return x,z\nend\ns.meleePointVersion=1\nend\nif prefs and prefs.drawSpreads and s and not s.done and s.stage==2 and Now()-s.start<=85000 then\n prefs.release(data,\"frog_fru_darklit\")\n prefs.drawSpreads(s,\"darklit\")\n self.used=true return\nend\nif not prefs or not prefs.guide then self.used=true return end\nif not s or not s.destination or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>85000 then prefs.release(data,\"frog_fru_darklit\");self.used=true return end\nif (s.stage==4 or s.stage==5) and s.myRole~=\"T1\" and s.myRole~=\"T2\" then prefs.release(data,\"frog_fru_darklit\");self.used=true return end\nlocal style=s.stage==6 and \"akh1\" or s.stage==7 and \"afah1\" or (s.stage==4 or s.stage==5) and \"somber\" or s.stage==-1 and \"akhRhai\" or \"darklit\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_darklit\");self.used=true return end\nif s.stage==-1 then prefs.release(data,\"frog_fru_darklit\");self.used=true return end\ns.keepVisible=true\nlocal point=s.destination\nlocal x,y,z=point.x,point.y or .07,point.z\nif prefs.region~=\"JP\" and s.stage==6 and (prefs.akh or \"7-1\")==\"7-1\" and s.myRole==(prefs.akhSolo or \"T2\") then\n x,z=s.akhSoloPoint()\n if not x then prefs.release(data,\"frog_fru_darklit\");self.used=true return end\nend\nlocal label=point.label\ns.arrowDeadline=nil;s.arrowHoldAfterDeadline=true\nif prefs.castDeadline then\n if s.stage==-1 then s.arrowDeadline=prefs.castDeadline(data,s,{40237})\n elseif s.stage==0 then s.arrowDeadline=prefs.castDeadline(data,s,{40239})\n elseif s.stage==1 then s.arrowDeadline=prefs.castDeadline(data,s,{40187})\n elseif s.stage==2 then s.arrowDeadline=prefs.castDeadline(data,s,{40288})\n elseif s.stage==3 then s.arrowDeadline=prefs.castDeadline(data,s,{40227,40228})\n elseif s.stage==4 then s.arrowDeadline=prefs.castDeadline(data,s,{40283})\n elseif s.stage==5 then s.arrowDeadline=s.somberNearDeadline\n elseif s.stage==6 then s.arrowDeadline=s.akhDeadline\n elseif s.stage==7 then s.arrowDeadline=s.afahDeadline or prefs.castDeadline(data,s,{40304}) end\nend\nprefs.guide(data,\"frog_fru_darklit\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw Darklit destination",
							uuid = "120e6659-7ffc-c805-8bae-56ed31190461",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Darklit",
				eventType = 12,
				loop = true,
				mechanicTime = 712.9,
				name = "[Darklit] Personal responsibility tether",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 73,
				uuid = "deece1e8-af34-ab68-8069-102a402ab59d",
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
							actionLua = "data.frog_fru_darklit=nil\nself.used=true",
							name = "Clear Darklit state",
							uuid = "95d5374b-b048-d9f7-8396-51632df4619f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Darklit",
				eventType = 9,
				mechanicTime = 712.9,
				name = "[Darklit] Clear state - wipe",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 1800,
				timerStartOffset = -713,
				uuid = "6ecd5c4d-d215-0fa4-bd45-55883e209f82",
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
							actionLua = "data.frog_fru_darklit=nil\nself.used=true",
							name = "Clear Darklit state",
							uuid = "ed1a9ead-9c6b-ca77-9579-99074814afff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Darklit",
				eventType = 16,
				mechanicTime = 712.9,
				name = "[Darklit] Clear state - countdown",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 1800,
				timerStartOffset = -713,
				uuid = "fa9faeea-5dc3-5498-b4b1-ba0ba7629b25",
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
							actionLua = "data.frog_fru_darklit=nil\nself.used=true",
							name = "Clear Darklit state",
							uuid = "5de89b40-2243-3e59-8d81-ecf66938399d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Darklit",
				eventType = 11,
				mechanicTime = 712.9,
				name = "[Darklit] Clear state - map",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 1800,
				timerStartOffset = -713,
				uuid = "812f340f-d7c7-e7be-b994-b4a33abd5b1f",
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
							actionLua = "local s=data.frog_fru_darklit\nif not s or s.done then self.used=true return end\nlocal actor=TensorCore.mGetEntity(eventArgs.entityID)\nif actor and actor.pos then\n if not s.rhaiPuddles then s.rhaiPuddles={}end\n s.rhaiPuddles[eventArgs.entityID]={x=actor.pos.x,z=actor.pos.z}\n s.rhaiUntil=Now()+eventArgs.channelTimeMax*1000+6500\nend\nif s.stage<0 then\n s.stage=0;s.nextPoll=0;s.destination=nil\nend\nself.used=true",
							conditions = 
							{
								
								{
									"d06c664d-f9c8-164e-9c49-53c783222e89",
									true,
								},
							},
							name = "Record Akh Rhai lock-in",
							uuid = "ff7c37a9-29c6-aabb-b608-19724d9bb0a5",
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
							eventSpellID = 40237,
							name = "Akh Rhai ground lock",
							uuid = "d06c664d-f9c8-164e-9c49-53c783222e89",
							version = 3,
						},
					},
				},
				displayPath = "P4 Darklit",
				eventType = 3,
				loop = true,
				mechanicTime = 712.9,
				name = "[Darklit] Record Akh Rhai lock-in",
				timeRange = true,
				timelineIndex = 157,
				timerEndOffset = 20,
				timerStartOffset = -2,
				uuid = "1602cedc-215b-08a3-b58d-82e0bd745b0d",
				version = 2,
			},
		},
	},
	[166] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P4 Darklit",
				uuid = "b604bba9-c56f-5c53-99db-36bfb83aa9a4",
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
							actionLua = "local s=data.frog_fru_darklit\nif s and not s.chainReady then s.edges[eventArgs.sourceEntityID]=eventArgs.newTargetID;s.nextPoll=0 end\nself.used=true",
							conditions = 
							{
								
								{
									"270d7743-4370-5b4e-b674-adc04924d8cd",
									true,
								},
							},
							name = "Record initial chain graph",
							uuid = "fa3aff8f-1a06-b8f7-bf23-17ececf47872",
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
							eventIntValue = 110,
							name = "Refulgent Chain",
							uuid = "270d7743-4370-5b4e-b674-adc04924d8cd",
							version = 3,
						},
					},
				},
				displayPath = "P4 Darklit",
				eventType = 15,
				loop = true,
				mechanicTime = 738.2,
				name = "[Darklit] Record chain links",
				timeRange = true,
				timelineIndex = 166,
				timerEndOffset = 10,
				timerStartOffset = -2,
				uuid = "83e29663-1add-1c97-8541-e2df96e0bbbe",
				version = 2,
			},
		},
	},
	[179] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "P4 Crystallize Time",
				uuid = "94735a39-dd31-0907-8382-f10ff5ed6812",
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
							actionLua = "local s={start=Now(),records={},nextPoll=0,headHits={[-1]=0,[1]=0},puddles={},maelstrom={},waves={ew=0,ns=0},lastWave={},kbCount=0}\ndata.frog_fru_ct=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local records,used={},{}\n for _,key in ipairs(s.keys)do\n  local m=members[key];if not m or not m.name or not m.job then return false end\n  local a,count=nil,0\n  for _,p in pairs(party)do if p.name==m.name and p.job==m.job then a=p;count=count+1 end end\n  if count==0 then\n   local copies=0;for _,v in pairs(members)do if v.job==m.job then copies=copies+1 end end\n   if copies==1 then for _,p in pairs(party)do if p.job==m.job then a=p;count=count+1 end end end\n  end\n  if count~=1 or used[a.id] then return false end\n  used[a.id]=true;records[key]={id=a.id}\n  if a.id==me.id then s.myRole=key end\n end\n if not s.myRole then return false end\n s.records=records;s.rosterReady=true;return true\nend\nfunction s.assign()\n local groups={redIce={},redWind={},blueIce={},blueWater={},blueUnholy={},blueEruption={}}\n local roles={}\n for _,key in ipairs(s.keys)do\n  local r=s.records[key];local a=TensorCore.mGetEntity(r.id);if not a then return false end\n  local red=TensorCore.getBuff(a,3263);local blue=TensorCore.getBuff(a,3264)\n  local kind\n  if red and not blue then\n   if TensorCore.getBuff(a,2462)then kind=\"redIce\" elseif TensorCore.getBuff(a,2463)then kind=\"redWind\" end\n  elseif blue and not red then\n   if TensorCore.getBuff(a,2462)then kind=\"blueIce\"\n   elseif TensorCore.getBuff(a,2461)then kind=\"blueWater\"\n   elseif TensorCore.getBuff(a,2454)then kind=\"blueUnholy\"\n   elseif TensorCore.getBuff(a,2460)then kind=\"blueEruption\" end\n  end\n  if not kind then return false end\n  roles[key]=kind;table.insert(groups[kind],key)\n end\n for kind,g in pairs(groups)do if #g~=(kind:sub(1,3)==\"red\" and 2 or 1)then return false end end\n local region=(FrogFRUDrawSettings or {}).region\n if region==\"JP\" or region==\"Elemental\" then\n  local order=region==\"JP\" and {\"H1\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\",\"H2\"} or {\"H1\",\"H2\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n  local rank={};for i,key in ipairs(order) do rank[key]=i end\n  table.sort(groups.redIce,function(a,b)return rank[a]<rank[b] end);table.sort(groups.redWind,function(a,b)return rank[a]<rank[b] end)\n end\n for _,kind in ipairs({\"redIce\",\"redWind\"})do\n  local a,b=groups[kind][1],groups[kind][2]\n  local sa=a:sub(1,1)==\"T\" or a:sub(1,1)==\"H\"\n  local sb=b:sub(1,1)==\"T\" or b:sub(1,1)==\"H\"\n  s.records[a].side=sa and -1 or 1;s.records[b].side=sb and -1 or 1\n  if region==\"JP\" or region==\"Elemental\" then s.records[a].side=-1;s.records[b].side=1\n  elseif sa==sb then s.records[a].side=-s.records[a].side;s.records[a].flex=true end\n end\n for key,kind in pairs(roles)do s.records[key].kind=kind end\n s.assigned=true;return true\nend\nfunction s.updateBlueMarks()\n local prefs=FrogFRUDrawSettings or {}\n if prefs.region~=\"JP\" or not s.assigned then return end\n local now=Now()\n local count,seen=0,{}\n local valid=true\n for _,key in ipairs(s.keys)do\n  local r=s.records[key]\n  if r.kind:sub(1,4)==\"blue\" then\n   count=count+1\n   local a=TensorCore.mGetEntity(r.id)\n   local mark=a and a.marker\n   if not mark or mark<1 or mark>4 or seen[mark] then valid=false\n   else seen[mark]=true end\n   r.cleanseMark=mark\n  end\n end\n if count~=4 then return end\n if valid then s.blueMarksReady=true;return end\n s.blueMarksReady=false\n if not prefs.ctMarkBlue or s.blueMarkFailed or now-s.start>24000 then return end\n if not s.blueMarkPlan then\n  local occupied={}\n  for _,key in ipairs(s.keys)do\n   local r=s.records[key];local a=TensorCore.mGetEntity(r.id)\n   if not a or a.hp.current<=0 then return end\n   local mark=a.marker or 0\n   if mark>=1 and mark<=4 then\n    if r.kind:sub(1,4)~=\"blue\" or occupied[mark] then s.blueMarkFailed=true;return end\n    occupied[mark]=r.id\n   elseif r.kind:sub(1,4)==\"blue\" and mark~=0 then s.blueMarkFailed=true;return end\n  end\n  local plan={}\n  for _,key in ipairs({\"H1\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\",\"H2\"})do\n   local r=s.records[key]\n   if r.kind:sub(1,4)==\"blue\" then\n    local a=TensorCore.mGetEntity(r.id);local mark=a.marker or 0\n    if mark==0 then\n     for i=1,4 do if not occupied[i] then mark=i;occupied[i]=r.id;break end end\n    end\n    plan[#plan+1]={id=r.id,mark=mark,tries=0}\n   end\n  end\n  s.blueMarkPlan=plan;s.blueMarkNext=now\n end\n if now<(s.blueMarkNext or 0)then return end\n for _,entry in ipairs(s.blueMarkPlan)do\n  local a=TensorCore.mGetEntity(entry.id)\n  if not a or a.hp.current<=0 then return end\n  if a.marker~=entry.mark then\n   if a.marker~=0 or entry.tries>=3 then s.blueMarkFailed=true;return end\n   local action=ActionList:Get(12,entry.mark)\n   if not action then s.blueMarkFailed=true;return end\n   prefs.ctOwned=prefs.ctOwned or {};prefs.ctOwned[entry.mark]=entry.id\n   action:Cast(entry.id)\n   entry.tries=entry.tries+1;s.blueMarkNext=now+700\n   return\n  end\n end\nend\nfunction s.cleansePoint(r)\n if not s.blueMarksReady or not r.cleanseMark or r.cleanseMark<1 or r.cleanseMark>4 then return end\n if not s.cleansePuddles then\n  local points={}\n  for _,key in ipairs({\"earlyW\",\"earlyE\",\"lateW\",\"lateE\"})do\n   local point=s.puddles[key];if not point then return end\n   points[#points+1]=point\n  end\n  table.sort(points,function(a,b)if math.abs(a.x-b.x)>.01 then return a.x>b.x else return a.z<b.z end end)\n  s.cleansePuddles=points\n end\n return s.cleansePuddles[r.cleanseMark]\nend\nfunction s.polar(side,angle,radius)\n local a=side*angle*math.pi/180\n return 100+radius*math.sin(a),100+radius*math.cos(a)\nend\nfunction s.akhSoloPoint()\n local now=Now();local cached=s.meleePoint\n if now<(s.meleePointPoll or 0)then\n  if cached then return cached.x,cached.z end\n  return\n end\n s.meleePointPoll=now+100;s.meleePoint=nil\n local bosses={}\n for i,cid in ipairs({12809,9832})do\n  local id=s.meleeBossIDs and s.meleeBossIDs[i]\n  local actor=id and TensorCore.mGetEntity(id)\n  if not actor or not actor.pos or not actor.targetable or not actor.attackable or actor.hp.current<=0 or actor.hitradius<=1 then\n   actor=nil\n   for _,a in pairs(TensorCore.getEntityGroupList(\"ContentID\",{contentid=cid})or{})do\n    if a.pos and a.targetable and a.attackable and a.hp.current>0 and a.hitradius>1 then\n     if actor then return end\n     actor=a\n    end\n   end\n  end\n  if not actor then return end\n  bosses[i]=actor\n end\n local a,b=bosses[1],bosses[2]\n s.meleeBossIDs=s.meleeBossIDs or{}\n s.meleeBossIDs[1],s.meleeBossIDs[2]=a.id,b.id\n local ax,az,bx,bz=a.pos.x,a.pos.z,b.pos.x,b.pos.z\n local ra,rb=a.hitradius+3,b.hitradius+3\n if cached and cached.ax==ax and cached.az==az and cached.bx==bx and cached.bz==bz and cached.ra==ra and cached.rb==rb then s.meleePoint=cached;return cached.x,cached.z end\n local dx,dz=bx-ax,bz-az;local distance=math.sqrt(dx*dx+dz*dz)\n if distance<.01 or distance>ra+rb or distance<math.abs(ra-rb)then return end\n local along=(ra*ra-rb*rb+distance*distance)/(2*distance)\n local height=math.sqrt(math.max(0,ra*ra-along*along))\n local ux,uz=dx/distance,dz/distance\n local mx,mz=ax+along*ux,az+along*uz\n local x1,z1=mx-height*uz,mz+height*ux\n local x2,z2=mx+height*uz,mz-height*ux\n local x,z=x1,z1\n if z2>z1 then x,z=x2,z2 end\n if (x-100)^2+(z-100)^2>19.2^2 or (x-100)^2+(z-100)^2<7^2 then return end\n s.meleePoint={x=x,z=z,ax=ax,az=az,bx=bx,bz=bz,ra=ra,rb=rb}\n return x,z\nend\nfunction s.windPoint(r)\n s.windSetupPoints=s.windSetupPoints or{}\n local cached=s.windSetupPoints[r.side]\n if cached then return cached.x,cached.z end\n local x,z=s.polar(r.side,40,19)\n local ix,iz=s.headPoint(r.side,false)\n for _,record in pairs(s.records)do\n  if record.kind==\"redIce\" and record.side==r.side then\n   local ice=TensorCore.mGetEntity(record.id)\n   if ice and ice.pos and (ice.pos.x-100)^2+(ice.pos.z-100)^2>=10^2 then ix,iz=ice.pos.x,ice.pos.z end\n   break\n  end\n end\n local cx,cz=100,111\n local clocks=TensorCore.entityList(\"contentid=9823\")or{}\n for _,clock in pairs(clocks)do\n  if clock.pos and math.abs(clock.pos.x-100)<1 and clock.pos.z>100 then cx,cz=clock.pos.x,clock.pos.z;break end\n end\n local dx,dz=x-cx,z-cz;local distance=math.sqrt(dx*dx+dz*dz)\n local radius=math.max(12.75,distance)\n local ux,uz=dx/distance,dz/distance\n local tx,tz=-uz,ux\n if tx*(x-ix)+tz*(z-iz)<0 then tx,tz=-tx,-tz end\n local targetX,targetZ=cx+radius*(ux*math.cos(1/radius)+tx*math.sin(1/radius)),cz+radius*(uz*math.cos(1/radius)+tz*math.sin(1/radius))\n local bestX,bestZ,best\n for i=0,100 do\n  local angle=i/(100*radius)\n  local px,pz=cx+radius*(ux*math.cos(angle)+tx*math.sin(angle)),cz+radius*(uz*math.cos(angle)+tz*math.sin(angle))\n  local clear=(px-100)^2+(pz-100)^2<=19.5^2 and (px-ix)^2+(pz-iz)^2>(x-ix)^2+(z-iz)^2\n  if clear then\n   for _,clock in pairs(clocks)do\n    if clock.pos and math.abs(clock.pos.x-100)<1 and (px-clock.pos.x)^2+(pz-clock.pos.z)^2<12.75^2-.0001 then clear=false;break end\n   end\n  end\n  if clear then\n   local score=(px-targetX)^2+(pz-targetZ)^2\n   if not best or score<best then best=score;bestX,bestZ=px,pz end\n  end\n end\n if not bestX then return x,z end\n s.windSetupPoints[r.side]={x=bestX,z=bestZ}\n return bestX,bestZ\nend\nfunction s.windGuidance(me,r,now)\n local x,z,label,stage,deadline\n if (s.maelstromCount or 0)>=4 or s.unholyDone then\n  x,z=s.headPoint(r.side,true);label=\"Late head intercept (+2y lead)\"\n elseif (s.maelstromCount or 0)>=2 then\n  x,z=s.polar(r.side,19,19);label=\"Wind: clear next floor AOE\"\n  stage=\"ct-wind-next-floor\"\n  for id,a in pairs(s.floorAoes or{})do\n   if not s.maelstrom[id] and now<=a.untilAt then\n    local at=a.untilAt-400\n    deadline=deadline and math.min(deadline,at)or at\n   end\n  end\n else\n  x,z=s.windPoint(r);label=\"Wind: clear ice; wait for floor explosion\"\n  stage=\"ct-wind-floor\";deadline=s.firstMaelstromDeadline\n end\n s.destination={x=x,y=.07,z=z,label=label};s.keepVisible=true;s.arrivalRadius=.2\n s.windArrowStage=stage;s.windArrowDeadline=deadline;s.filteredPoint=s.destination\nend\nfunction s.headPoint(side,late)\n if not late then return 100+side*13,100 end\n local x,z=s.polar(side,33,13)\n for _,h in pairs(TensorCore.entityList(\"contentid=9323\")or{})do\n  if h.hitradius and h.hitradius>0 and h.pos and h.pos.h and (h.pos.x<100 and -1 or 1)==side and h.pos.z>=108 and math.abs(h.pos.x-100)<=11 then\n   x=h.pos.x+2*math.sin(h.pos.h);z=h.pos.z+2*math.cos(h.pos.h)\n   break\n  end\n end\n return x,z\nend\nfunction s.pendingStack()\n local r=s.records and s.records[s.myRole]\n if not r or not r.kind then return end\n if r.kind==\"redIce\" then\n  if r.side==s.northSlow and not s.unholyDone then return \"unholy\" end\n elseif r.kind:sub(1,4)==\"blue\" then\n  if r.kind~=\"blueEruption\" and not s.aeroAt then return \"water\" end\n  if not s.unholyDone then return \"unholy\" end\n end\nend\nfunction s.corner(spread)\n if not s.originX or not s.originZ then\n  local foundX,foundZ,conflictX,conflictZ\n  for _,a in pairs(TensorCore.entityList(\"contentid=12809\")or{})do\n   if a.pos then\n    if math.abs(a.pos.x-100)>=18 and math.abs(a.pos.z-100)<=2 then\n     local sign=a.pos.x<100 and -1 or 1\n     if foundX and foundX~=sign then conflictX=true end;foundX=sign\n    elseif math.abs(a.pos.z-100)>=18 and math.abs(a.pos.x-100)<=2 then\n     local sign=a.pos.z<100 and -1 or 1\n     if foundZ and foundZ~=sign then conflictZ=true end;foundZ=sign\n    end\n   end\n  end\n  if not s.originX and not conflictX then s.originX=foundX end\n  if not s.originZ and not conflictZ then s.originZ=foundZ end\n end\n if not spread and (FrogFRUDrawSettings or {}).region==\"JP\" then\n  if not s.originZ then return end\n  local side=s.originZ\n  if s.myRole==\"T1\" then return 100+11*side,100+14*side end\n  if s.myRole==\"T2\" then return 100-11*side,100+14*side end\n  return 100,100+3.5*side\n end\n if not s.originX or not s.originZ then return end\n local fX,fZ=s.originX/math.sqrt(2),s.originZ/math.sqrt(2)\n local lX,lZ=fZ,-fX;local sign=s.myRole:sub(2,2)==\"1\" and 1 or -1\n local role=s.myRole:sub(1,1);local forward,left\n if spread then\n  if role==\"T\" then forward,left=17.7,4.95\n  elseif role==\"H\" then forward,left=4.2,4.2\n  elseif role==\"M\" then forward,left=-7.1,7.1\n  else forward,left=-3.5,16 end\n  return 100+forward*fX+sign*left*lX,100+forward*fZ+sign*left*lZ\n end\n forward=role==\"T\" and 1.5 or -1.5;left=role==\"T\" and 3 or 2\n return 100+8.5*s.originX+forward*fX+sign*left*lX,100+8.5*s.originZ+forward*fZ+sign*left*lZ\nend\nfunction s.waveKey(id,x,z)\n return tostring(id)..\":\"..string.format(\"%.1f:%.1f\",x,z)\nend\nfunction s.tidal(e,begin)\n local a=TensorCore.mGetEntity(e.entityID)\n local key=s.waveSources and s.waveSources[e.entityID]\n if begin then\n  if not a or not a.pos then return end\n  key=s.waveKey(e.entityID,a.pos.x,a.pos.z)\n  s.waveSources=s.waveSources or {};s.waveSources[e.entityID]=key\n  if math.abs(a.pos.x-100)>15 then s.originX=a.pos.x<100 and -1 or 1\n  elseif math.abs(a.pos.z-100)>15 then s.originZ=a.pos.z<100 and -1 or 1 end\n  if e.channelTimeMax and e.channelTimeMax>0 then\n   s.waveChannels=s.waveChannels or {};s.waveChannels[key]=Now()+e.channelTimeMax*1000\n  end\n else\n  if key then s.resolvedWaves=s.resolvedWaves or {};s.resolvedWaves[key]=true end\n  local h=e.heading;if type(h)~=\"number\"then return end\n  local axis=math.abs(math.sin(h))>.7 and \"ew\"or\"ns\";local now=Now()\n  if not s.lastWave[axis]or now-s.lastWave[axis]>500 then s.waves[axis]=s.waves[axis]+1;s.lastWave[axis]=now end\n end\nend\nfunction s.cleanseDestination(r)\n if (FrogFRUDrawSettings or{}).region==\"JP\"then return s.cleansePoint(r)end\n local key=({blueEruption=\"earlyW\",blueUnholy=\"earlyE\",blueIce=\"lateW\",blueWater=\"lateE\"})[r.kind]\n return key and s.puddles[key]\nend\nfunction s.floorPointClear(x,z,fromX,fromZ)\n local function clear(ax,az)\n  local px,pz=x,z\n  if fromX and fromZ then\n   local dx,dz=x-fromX,z-fromZ;local length=dx*dx+dz*dz\n   local t=length>0 and math.max(0,math.min(1,((ax-fromX)*dx+(az-fromZ)*dz)/length))or 0\n   px,pz=fromX+t*dx,fromZ+t*dz\n  end\n  return (px-ax)^2+(pz-az)^2>=12.75^2\n end\n for _,a in pairs(s.floorAoes or{})do\n  if Now()<=a.untilAt and not clear(a.x,a.z)then return false end\n end\n for _,a in pairs(TensorCore.entityList(\"contentid=9823\")or{})do\n  if a.pos and not s.maelstrom[a.id]and not clear(a.pos.x,a.pos.z)then return false end\n end\n return true\nend\nfunction s.waveIntersection(me,x,z,a)\n local sh,ch=math.sin(a.heading),math.cos(a.heading)\n local function localPoint(px,pz)local dx,dz=px-a.x,pz-a.z;return dx*ch-dz*sh,dx*sh+dz*ch end\n local sx,sz=localPoint(me.pos.x,me.pos.z);local tx,tz=localPoint(x,z)\n local margin=math.max(.5,me.hitradius or .5)+.25\n local half=a.aoeWidth/2+margin;local low,high=-margin,a.aoeLength+margin\n local inside=math.abs(sx)<=half and sz>=low and sz<=high\n local entry,leave=0,1\n local function clip(start,delta,minimum,maximum)\n  if math.abs(delta)<.00001 then return start>=minimum and start<=maximum end\n  local lo,hi=(minimum-start)/delta,(maximum-start)/delta\n  if lo>hi then lo,hi=hi,lo end\n  entry=math.max(entry,lo);leave=math.min(leave,hi)\n  return entry<=leave\n end\n if not clip(sx,tx-sx,-half,half)or not clip(sz,tz-sz,low,high)then return end\n return {inside=inside,entry=entry,sx=sx,low=low,high=high,sh=sh,ch=ch}\nend\nfunction s.dodgePoint(me,x,z,a,hit,wait)\n local candidates={}\n if hit.inside then\n  for _,forward in ipairs({hit.low-.75,hit.high+.75})do\n   local px=a.x+hit.sx*hit.ch+forward*hit.sh\n   local pz=a.z-hit.sx*hit.sh+forward*hit.ch\n   if math.abs(hit.sh)>.7 then\n    local limit=19.1^2-(px-100)^2\n    if limit>=0 then limit=math.sqrt(limit);pz=math.max(100-limit,math.min(100+limit,pz))end\n   else\n    local limit=19.1^2-(pz-100)^2\n    if limit>=0 then limit=math.sqrt(limit);px=math.max(100-limit,math.min(100+limit,px))end\n   end\n   candidates[#candidates+1]={x=px,z=pz}\n  end\n else\n  local dx,dz=x-me.pos.x,z-me.pos.z;local length=math.sqrt(dx*dx+dz*dz)\n  local t=length>.01 and math.max(0,hit.entry-.75/length)or 0\n  candidates[1]={x=me.pos.x+t*dx,z=me.pos.z+t*dz}\n end\n if wait then candidates[#candidates+1]=wait end\n for _,p in ipairs(candidates)do\n  local dx,dz=p.x-a.x,p.z-a.z\n  local side,forward=dx*hit.ch-dz*hit.sh,dx*hit.sh+dz*hit.ch\n  local outside=math.abs(side)>a.aoeWidth/2+.75 or forward<hit.low or forward>hit.high\n  if outside and (p.x-100)^2+(p.z-100)^2<=19.2^2 and s.floorPointClear(p.x,p.z)then return {x=p.x,z=p.z}end\n end\nend\nfunction s.firstBlockingWave(me,x,z,wait)\n local selected,best,blocked\n for _,a in ipairs(Argus.getCurrentAOEs())do\n  if a.aoeID==40252 or a.aoeID==40253 then\n   local hit=s.waveIntersection(me,x,z,a)\n   if hit then\n    blocked=true\n    local key=s.waveKey(a.entityID,a.x,a.z)\n    local deadline=s.waveChannels and s.waveChannels[key]\n    local rank=deadline or Now()+100000\n    if not best or rank<best then\n     local point=s.dodgePoint(me,x,z,a,hit,wait)\n     if point then\n      local axis=math.abs(math.sin(a.heading))>.7 and \"ew\"or\"ns\"\n      best=rank;selected={key=key,point=point,deadline=deadline,axis=axis,count=s.waves[axis]}\n     end\n    end\n   end\n  end\n end\n return selected,blocked\nend\nfunction s.waveFinished(wave)\n if s.resolvedWaves and s.resolvedWaves[wave.key]then return true end\n if s.waves[wave.axis]<=wave.count then return false end\n for _,a in ipairs(Argus.getCurrentAOEs())do\n  if (a.aoeID==40252 or a.aoeID==40253)and s.waveKey(a.entityID,a.x,a.z)==wave.key then return false end\n end\n return true\nend\nfunction s.showCTStep(seq,point,label,stage,deadline)\n if point then s.destination={x=point.x,y=.07,z=point.z,label=label}else s.destination=nil end\n s.windArrowStage=stage;s.windArrowDeadline=deadline;s.keepVisible=true;s.arrivalRadius=seq.phase==4 and .2 or .6\n s.filteredPoint=s.destination\nend\nfunction s.fixedSequence(me,r,now)\n local seq=s.sequence\n if not seq then\n  seq={phase=1,blue=r.kind:sub(1,4)==\"blue\",waveDone=s.waves.ew>=4}\n  s.sequence=seq\n end\n if seq.phase==4 then\n  if not seq.rewind then local x,z=s.corner(false);if x then seq.rewind={x=x,z=z}end end\n  s.showCTStep(seq,seq.rewind,\"Place rewind: tanks in front\",nil,nil);return\n end\n local blueBuff=seq.blue and TensorCore.getBuff(me,3264)\n if seq.blue and not blueBuff then seq.cleansed=true end\n if not seq.puddle and seq.blue and not seq.cleansed then\n  local p=s.cleanseDestination(r)\n  if p then seq.puddle={x=p.x,z=p.z}end\n end\n local rx,rz=s.corner(false)\n local goal\n if seq.blue and not seq.cleansed then goal=seq.puddle\n elseif rx then goal={x=rx,z=rz}end\n if seq.phase==1 then\n  local ex,ez,deadline=s.exitFloor(me,goal and goal.x or me.pos.x,goal and goal.z or me.pos.z,now)\n  if ex==false then s.destination=nil;s.filteredPoint=nil;return end\n  if ex then\n   seq.wait={x=ex,z=ez};s.showCTStep(seq,seq.wait,\"Exit active floor AOE first\",\"ct-floor-exit\",deadline);return\n  end\n  seq.wait=seq.wait or {x=me.pos.x,z=me.pos.z};seq.phase=2\n end\n if seq.phase==2 and not seq.blue and not seq.prepared then\n  if not seq.prepare then\n   local x,z\n   if r.kind==\"redWind\" then x,z=s.polar(s.northSlow,30,7)\n   elseif r.kind==\"redIce\" then x,z=s.polar(-s.northSlow,150,7)end\n   if x then seq.prepare={x=x,z=z}end\n  end\n  if seq.prepare and s.floorPointClear(seq.prepare.x,seq.prepare.z,me.pos.x,me.pos.z)then\n   seq.wait=seq.prepare;seq.prepared=true\n  end\n end\n if seq.phase==2 and not seq.waveDone and goal then\n  local wave,blocked=s.firstBlockingWave(me,goal.x,goal.z,seq.wait)\n  if wave then seq.wave=wave;seq.phase=3\n  elseif not blocked and s.waves.ew>=1 then seq.waveDone=true end\n end\n if seq.phase==3 and seq.wave and not seq.waveDone then\n  if s.waveFinished(seq.wave)then seq.waveDone=true\n  else s.showCTStep(seq,seq.wave.point,\"Dodge first wave\",\"ct-seq-dodge\",seq.wave.deadline);return end\n end\n if seq.waveDone then\n  if seq.blue and not seq.cleansed then\n   seq.phase=3\n   local point=seq.puddle and s.floorPointClear(seq.puddle.x,seq.puddle.z)and seq.puddle or seq.wave and seq.wave.point or seq.wait\n   s.showCTStep(seq,point,\"Collect assigned cleanse puddle\",\"ct-seq-cleanse\",nil);return\n  end\n  seq.phase=4;seq.rewind=rx and {x=rx,z=rz}or nil\n  s.showCTStep(seq,seq.rewind,\"Place rewind: tanks in front\",nil,nil);return\n end\n local point=seq.blue and seq.puddle and s.floorPointClear(seq.puddle.x,seq.puddle.z)and seq.puddle or seq.wait\n s.showCTStep(seq,point,seq.blue and \"Approach assigned cleanse puddle\"or\"Wait for first wave\",\"ct-seq-prepare\",nil)\nend\n\nfunction s.filterGuidance()\n local now=Now()\n if s.destination==s.filteredPoint and now<(s.guidancePollAt or 0)then return end\n s.guidancePollAt=now+100\n if not s.finished or s.akh or s.afah or s.kbCount>=2 or s.spread or (s.recordAt and now>=s.recordAt+150)then return end\n local me=TensorCore.mGetPlayer();local r=s.records and s.records[s.myRole]\n if not me or not me.pos or me.hp.current<=0 or not r or not r.kind or not s.northSlow then return end\n local heads=s.headHits[r.side]or 0\n if r.kind==\"redWind\" and heads<2 then s.windGuidance(me,r,now);return end\n if (r.kind==\"redIce\" and heads<1)or(r.kind==\"redWind\" and heads<2)then return end\n local pending=(not s.sequence or s.sequence.phase==1)and s.pendingStack()\n if pending then\n  local x,z,label\n  if pending==\"unholy\" then\n   x,z=s.polar(s.northSlow,140,19);label=r.kind==\"redIce\" and \"Join north Unholy stack\" or \"North Unholy stack\"\n  else\n   local groupSide=-s.northSlow\n   x,z=s.polar(groupSide,40,19);label=\"South purple: four-person water stack\"\n   if (s.maelstromCount or 0)>=2 then\n    for _,v in pairs(s.records)do\n     if v.kind==\"redWind\" and v.side==groupSide then\n      local wind=TensorCore.mGetEntity(v.id)\n      if wind and wind.pos then\n       local tx,tz=s.polar(s.northSlow,140,19);local dx,dz=tx-wind.pos.x,tz-wind.pos.z;local d=math.sqrt(dx*dx+dz*dz)\n       if d>0 then x,z=wind.pos.x+2*dx/d,wind.pos.z+2*dz/d end\n      end\n      break\n     end\n    end\n    label=\"Water stack / line up Aero knockback\"\n   end\n  end\n  s.destination={x=x,y=.07,z=z,label=label};s.keepVisible=true;s.arrivalRadius=.2\n  s.windArrowStage=nil;s.windArrowDeadline=nil;s.filteredPoint=s.destination\n  return\n end\n s.fixedSequence(me,r,now)\nend\nfunction s.exitFloor(me,nextX,nextZ,now)\n if s.pendingStack()then s.floorExitPlan=nil;s.floorInside=nil;return end\n local hazards,seen={},{}\n for id,a in pairs(s.floorAoes or {})do\n  if now>a.untilAt then s.floorAoes[id]=nil\n  else hazards[#hazards+1]=a;seen[id]=true end\n end\n for _,a in pairs(TensorCore.entityList(\"contentid=9823\")or{})do\n  if a.pos and not seen[a.id] and not s.maelstrom[a.id] then\n   hazards[#hazards+1]={x=a.pos.x,z=a.pos.z}\n  end\n end\n local inside,deadline=false,nil\n for _,a in ipairs(hazards)do\n  if (me.pos.x-a.x)^2+(me.pos.z-a.z)^2<12.75^2 then\n   inside=true\n   if a.untilAt then local at=a.untilAt-400;deadline=deadline and math.min(deadline,at)or at end\n  end\n end\n s.floorInside=inside\n if not inside then\n  s.floorExitPlan=nil\n  return\n end\n local r=s.records and s.records[s.myRole]\n local direction=r and r.kind==\"redWind\" and 1 or -1\n local plan=s.floorExitPlan\n if plan and plan.direction==direction then\n  local clear=true\n  for _,a in ipairs(hazards)do\n   if (plan.x-a.x)^2+(plan.z-a.z)^2<12.75^2 then clear=false;break end\n   local ax,az=me.pos.x-a.x,me.pos.z-a.z\n   if ax*ax+az*az>=12.75^2 then\n    local dx,dz=plan.x-me.pos.x,plan.z-me.pos.z\n    local length=dx*dx+dz*dz\n    if length>.001 then\n     local t=math.max(0,math.min(1,-(ax*dx+az*dz)/length))\n     if (ax+t*dx)^2+(az+t*dz)^2<12.75^2 then clear=false;break end\n    end\n   end\n  end\n  if clear then return plan.x,plan.z,deadline end\n end\n local best,x,z\n local lows,highs={},{}\n for degrees=0,359 do\n  local angle=degrees*math.pi/180\n  local ux,uz=math.sin(angle),math.cos(angle)\n  if uz*direction>=.15 then\n   local n=0\n   for _,a in ipairs(hazards)do\n    local ax,az=me.pos.x-a.x,me.pos.z-a.z\n    local along=ax*ux+az*uz\n    local disc=along*along-(ax*ax+az*az-12.75^2)\n    if disc>=0 then\n     local root=math.sqrt(disc)\n     local hi=-along+root\n     if hi>0 then n=n+1;lows[n]=math.max(0,-along-root);highs[n]=hi end\n    end\n   end\n   local reach=0\n   for pass=1,n+1 do\n    local previous=reach\n    for i=1,n do if lows[i]<=reach+.4 then reach=math.max(reach,highs[i])end end\n    if reach==previous then break end\n   end\n   local distance=reach+.4\n   local px,pz=me.pos.x+distance*ux,me.pos.z+distance*uz\n   if (px-100)^2+(pz-100)^2<=19.2^2 then\n    local clear=true\n    for _,a in ipairs(hazards)do if (px-a.x)^2+(pz-a.z)^2<12.75^2 then clear=false;break end end\n    if clear then\n     local score=distance+math.sqrt((px-nextX)^2+(pz-nextZ)^2)*.001\n     if not best or score<best then best=score;x,z=px,pz end\n    end\n   end\n  end\n end\n if x then s.floorExitPlan={x=x,z=z,direction=direction};return x,z,deadline end\n return false,false\nend\n\ns.floorRouteVersion=9\n\nfunction s.poll()\n local now=Now();if now<s.nextPoll then return end\n s.nextPoll=now+100;s.destination=nil;s.keepVisible=false;s.arrivalRadius=nil\n s.windArrowStage=nil;s.windArrowDeadline=nil\n local me=TensorCore.mGetPlayer();local prefs=FrogFRUDrawSettings or {}\n if not me or me.hp.current<=0 or now-s.start>95000 or prefs.ct==false or s.done then return end\n if not s.rosterReady then s.capture()end\n local r=s.records[s.myRole];if not r then return end\n local x,z,label\n if s.afah then x,z,label=100,100,\"Morn Afah: full party stack\"\n elseif s.kbCount>=2 or s.akh then\n  local mode=prefs.ctAkh or prefs.akh or \"7-1\"\n  if mode==\"6-2\" then\n   local tank=s.myRole==\"T1\" or s.myRole==\"T2\"\n   x,z=100,tank and 112 or 100;label=tank and \"Second Akh Morn: two tanks\" or \"Second Akh Morn: six stack\"\n  elseif mode==\"4-4\" then x,z,label=100,s.myRole:sub(2,2)==\"1\" and 95 or 105,\"Second Akh Morn: light party\"\n  else\n   local solo=prefs.ctSolo or (prefs.akhSolo==\"T1\" and \"T2\" or \"T1\")\n   x,z=100,100\n   if s.myRole==solo then\n    if prefs.region==\"JP\" then x,z=solo==\"T1\" and 88 or 112,100\n    else x,z=s.akhSoloPoint()end\n   end\n   label=s.myRole==solo and \"Second Akh Morn: solo tank\" or \"Second Akh Morn: seven stack\"\n  end\n elseif s.spiritDone then return\n elseif not s.finished then\n  local support=s.myRole:sub(1,1)==\"T\" or s.myRole:sub(1,1)==\"H\"\n  if prefs.region==\"Elemental\" or prefs.region==\"JP\" then\n   local order=prefs.region==\"JP\" and {\"H1\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\",\"H2\"} or {\"H1\",\"H2\",\"T1\",\"T2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n   for i,key in ipairs(order) do if key==s.myRole then x,z,label=100+(i-4.5)*1.5,100,\"CT priority lineup\" end end\n  else x,z,label=support and 96 or 104,100,\"CT: supports west / DPS east\" end\n else\n  if not s.assigned and not s.assign()then return end\n  s.updateBlueMarks()\n  local b=TensorCore.getBuff(me,4208)\n  if not s.recordObserved and b and b.duration and b.duration>0 then s.recordAt=now+b.duration*1000;s.recordObserved=true end\n  if TensorCore.getBuff(me,2452)then\n   s.spread=true\n   if not s.rewindSpreadCalled and prefs.callout then\n    prefs.callout(\"Spread\");s.rewindSpreadCalled=true\n   end\n  end\n  local rewindX,rewindZ=s.corner(false)\n  if s.spread or (s.recordAt and now>=s.recordAt+150)then\n   return\n  elseif not s.northSlow then return\n  elseif rewindX and not s.pendingStack() and ((r.kind==\"redIce\" and s.headHits[r.side]>=1) or (r.kind==\"redWind\" and s.headHits[r.side]>=2) or (r.kind:sub(1,4)==\"blue\" and not TensorCore.getBuff(me,3264))) then\n   x,z=rewindX,rewindZ;s.keepVisible=true;s.arrivalRadius=.2;label=\"Place rewind: tanks in front\"\n  elseif r.kind==\"redWind\" and s.headHits[r.side]>=2 then\n   x,z=s.polar(s.northSlow,30,6);s.keepVisible=true;label=\"Return to south circle\"\n  elseif r.kind==\"redIce\" and s.headHits[r.side]>=1 and s.unholyDone then\n   x,z=s.polar(-s.northSlow,150,6);s.keepVisible=true;label=\"Wait in north circle\"\n  elseif s.waves.ew>=3 then\n   local blue=r.kind:sub(1,4)==\"blue\"\n   if blue and not TensorCore.getBuff(me,3264)then r.cleansed=true end\n   if blue and not r.cleansed then\n    if prefs.region==\"JP\" then\n     local point=s.cleansePoint(r)\n     if point and ((point.x<100 and -1 or 1)==s.originX or s.waves.ew>=4)then\n      x,z,label=point.x,point.z,\"Cleanse: Attack \"..r.cleanseMark\n     end\n    else\n     local side=(r.kind==\"blueIce\" or r.kind==\"blueEruption\")and -1 or 1\n     local near=side==s.originX\n     if near or s.waves.ew>=4 then\n      local key=r.kind==\"blueEruption\" and \"earlyW\" or r.kind==\"blueUnholy\" and \"earlyE\" or r.kind==\"blueIce\" and \"lateW\" or \"lateE\"\n      local p=s.puddles[key];if p then x,z,label=p.x,p.z,\"Cleanse: \"..r.kind end\n     end\n    end\n   elseif prefs.region~=\"JP\" and s.waves.ns>=2 then x,z=s.corner(false);s.keepVisible=true;s.arrivalRadius=.2;label=\"Place rewind: tanks in front\" end\n  elseif s.unholyDone then\n   if s.waves.ew==0 then x,z=s.polar(r.kind==\"redWind\" and s.northSlow or -s.northSlow,r.kind==\"redWind\" and 30 or 150,6);label=\"Wait in \"..(r.kind==\"redWind\" and \"south\" or \"north\")..\" circle\" end\n   if r.kind==\"redWind\" and s.headHits[r.side]<2 then x,z=s.headPoint(r.side,true);label=\"Late head intercept (+2y lead)\" end\n  elseif r.kind==\"redIce\" then\n   if s.headHits[r.side]==0 then x,z=s.headPoint(r.side,false);label=r.flex and \"Flex: early head intercept\" or \"Early head intercept\"\n   elseif r.side==s.northSlow then x,z=s.polar(s.northSlow,140,19);label=\"Join north Unholy stack\"\n   elseif (s.maelstromCount or 0)>=4 then x,z=s.polar(-s.northSlow,150,6);label=\"Wait in north circle\"\n   else x,z=s.polar(r.side,80,19);label=\"Wait below second hourglass\" end\n  elseif r.kind==\"redWind\" then\n   s.windGuidance(me,r,now);return\n  elseif r.kind==\"blueEruption\" or s.aeroAt then\n   x,z=s.polar(s.northSlow,140,19);label=r.kind==\"blueEruption\" and \"Eruption: north purple intercard\" or \"North Unholy stack\"\n  else\n   local groupSide=-s.northSlow\n   x,z=s.polar(groupSide,40,19);label=\"South purple: four-person water stack\"\n   if (s.maelstromCount or 0)>=2 then\n    local wind\n    for _,v in pairs(s.records)do if v.kind==\"redWind\" and v.side==groupSide then wind=TensorCore.mGetEntity(v.id);break end end\n    if wind and wind.pos then\n     local tx,tz=s.polar(s.northSlow,140,19);local dx,dz=tx-wind.pos.x,tz-wind.pos.z;local d=math.sqrt(dx*dx+dz*dz)\n     if d>0 then x,z=wind.pos.x+2*dx/d,wind.pos.z+2*dz/d end\n    end\n    label=\"Water stack / line up Aero knockback\"\n   end\n  end\n end\n if x and (not s.sequence or s.sequence.phase==1) and s.finished and not s.afah and not s.akh and s.kbCount<2 then\n  local red=r.kind==\"redIce\" or r.kind==\"redWind\"\n  local heads=s.headHits[r.side]or 0\n  local headReady=not red or heads>=(r.kind==\"redIce\" and 1 or 2)\n  local requiredHead=label and label:find(\"head intercept\",1,true)\n  local waitingUnholy=label and label:find(\"Unholy stack\",1,true) and not s.unholyDone\n  local waitingWater=label and (label:find(\"water stack\",1,true)or label:find(\"Water stack\",1,true))and not s.waterDone\n  if headReady and not requiredHead and not waitingUnholy and not waitingWater and (s.waterDone or s.unholyDone or red)then\n   local ex,ez,deadline=s.exitFloor(me,x,z,now)\n   if ex==false then x,z=nil,nil\n   elseif ex then\n    x,z=ex,ez;label=\"Exit active floor AOE first\";s.keepVisible=true;s.arrivalRadius=.2\n    s.windArrowStage=\"ct-floor-exit\";s.windArrowDeadline=deadline\n   end\n  end\n end\n if x then s.destination={x=x,y=0.07,z=z,label=label}end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"cb0a12c8-f54a-c667-ba46-7a6b5160fe8a",
									true,
								},
							},
							name = "Initialize early-pop CT solver",
							uuid = "fbd1de9c-5051-bfb3-8c52-143d8151b774",
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
							eventSpellID = 40298,
							name = "ct",
							uuid = "cb0a12c8-f54a-c667-ba46-7a6b5160fe8a",
							version = 3,
						},
					},
				},
				displayPath = "P4 Crystallize Time",
				eventType = 3,
				mechanicTime = 798.9,
				name = "[CT] Initialize responsibilities",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 2,
				timerStartOffset = -11,
				uuid = "b1253ea0-1a67-e97e-be7a-d87f5f79428d",
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
							actionLua = "local s=data.frog_fru_ct\nif s then if not s.finished then s.finished=Now();s.recordAt=Now()+33000 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"524c5934-a5bb-e29b-be10-d7b7804344d9",
									true,
								},
							},
							name = "Resolve ct",
							uuid = "77f0d9c3-4290-3ab6-86d1-7906de13654b",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then if s.floorAoes then s.floorAoes[eventArgs.entityID]=nil end;if not s.maelstrom[eventArgs.entityID]then s.maelstrom[eventArgs.entityID]=true;s.maelstromCount=(s.maelstromCount or 0)+1 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"cbc10b6d-9d7c-929e-98d4-950294fdb3f7",
									true,
								},
							},
							name = "Resolve hourglass",
							uuid = "fd3f65ed-6956-2ac9-9760-d848242d74a0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then\n local x,z=eventArgs.castPosX,eventArgs.castPosZ\n if not x or not z or x<=70 or x>=130 or z<=70 or z>=130 then\n  local a=TensorCore.mGetEntity(eventArgs.entityID)\n  if a and a.pos then x,z=a.pos.x,a.pos.z end\n end\n if x and z and x>70 and x<130 and z>70 and z<130 then\n  local side=x<100 and -1 or 1\n  s.headHits[side]=math.max(z<104 and 1 or 2,s.headHits[side]or 0)\n end\n s.nextPoll=0;s.destination=nil\nend\nself.used=true",
							conditions = 
							{
								
								{
									"04730e9a-961f-2387-b2f0-95e6f55cbae2",
									true,
								},
							},
							name = "Resolve headfirst",
							uuid = "0a07ef3f-af08-ed02-822c-c444fbb4a4e7",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then local a=TensorCore.mGetEntity(eventArgs.entityID);if a and a.pos then local side=a.pos.x<100 and -1 or 1;s.headHits[side]=2 end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"74da0b35-dd81-7b44-b2d6-a47688f639e7",
									true,
								},
							},
							name = "Resolve headlast",
							uuid = "c2c83314-0e25-5098-9b23-d7c3f1cf6446",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.waterDone=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"e3d609aa-11eb-d679-94e8-2a72b677e0d5",
									true,
								},
							},
							name = "Resolve water",
							uuid = "e7f594bb-13ba-fd59-8a1a-2fa839144760",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then if not s.aeroAt then s.aeroAt=Now()end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"ba67a7df-77e0-9afe-bcc8-43869ee9b1f4",
									true,
								},
							},
							name = "Resolve aero",
							uuid = "7daa1a52-4f43-7146-a376-b351734bb317",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.unholyDone=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"1a2ea4a2-4a52-d5d4-9187-d4a21ffb22b8",
									true,
								},
							},
							name = "Resolve unholy",
							uuid = "4ec76816-3332-0a7a-8243-43d55bb29d24",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.tidal(eventArgs,false);s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"ce48f219-9c04-4884-af54-1b2a98e34031",
									true,
								},
							},
							name = "Resolve tidalfirst",
							uuid = "2ed73dd9-2e14-9609-940f-080c08247ef3",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.tidal(eventArgs,false);s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"b4938d72-ff30-e5f8-b68f-7da5b92c1225",
									true,
								},
							},
							name = "Resolve tidalnext",
							uuid = "db764a64-2f7d-8cc7-b766-7e2bae573b3c",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.spiritDone=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"3be753e9-3c3e-27c5-ae00-8b54628d2ae7",
									true,
								},
							},
							name = "Resolve spirit",
							uuid = "41a2fa86-5947-25ea-922c-32a93c1e6214",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then if not s.lastKB or Now()-s.lastKB>1500 then s.kbCount=s.kbCount+1;s.lastKB=Now()end;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"5b8479be-1397-d91a-802e-31751fa9b5b9",
									true,
								},
							},
							name = "Resolve knockback",
							uuid = "4e870472-5970-1057-8aae-4e585b379775",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.done=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"46cdd522-efcb-84f7-84db-d72fdaea4362",
									true,
								},
							},
							name = "Resolve end",
							uuid = "2ccf81b0-d05f-2e6d-9a6e-90c4ec95a6ba",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s and (s.akh and not s.afah) and (not s.lastAkhPulse or Now()-s.lastAkhPulse>600) then\n s.lastAkhPulse=Now();s.akhPulses=(s.akhPulses or 0)+1\n if not s.akhDeadline then s.akhDeadline=Now()+4250 end\n if s.akhPulses>=5 then\n s.afah=true;s.afahDeadline=Now()+6150\n s.nextPoll=0;s.destination=nil\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"e2df56ff-d522-4f43-9b7a-edcb1786ad5f",
									true,
								},
							},
							name = "Track Akh first hit",
							uuid = "73f4724a-0842-655d-a851-3c8a8cd4a1c0",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s and (s.akh and not s.afah) and (not s.lastAkhPulse or Now()-s.lastAkhPulse>600) then\n s.lastAkhPulse=Now();s.akhPulses=(s.akhPulses or 0)+1\n if not s.akhDeadline then s.akhDeadline=Now()+4250 end\n if s.akhPulses>=5 then\n s.afah=true;s.afahDeadline=Now()+6150\n s.nextPoll=0;s.destination=nil\n end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"3d40db04-ff95-0a5c-ba77-9a0ec73cc9ac",
									true,
								},
							},
							name = "Track Akh repeat hits",
							uuid = "0b5e1562-2ade-782f-a430-7a329eb07902",
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
							eventSpellID = 40298,
							name = "ct",
							uuid = "524c5934-a5bb-e29b-be10-d7b7804344d9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40299,
							name = "hourglass",
							uuid = "cbc10b6d-9d7c-929e-98d4-950294fdb3f7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40241,
							name = "headfirst",
							uuid = "04730e9a-961f-2387-b2f0-95e6f55cbae2",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40244,
							name = "headlast",
							uuid = "74da0b35-dd81-7b44-b2d6-a47688f639e7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40271,
							name = "water",
							uuid = "e3d609aa-11eb-d679-94e8-2a72b677e0d5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40280,
							name = "aero",
							uuid = "ba67a7df-77e0-9afe-bcc8-43869ee9b1f4",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40277,
							name = "unholy",
							uuid = "1a2ea4a2-4a52-d5d4-9187-d4a21ffb22b8",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40252,
							name = "tidalfirst",
							uuid = "ce48f219-9c04-4884-af54-1b2a98e34031",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40253,
							name = "tidalnext",
							uuid = "b4938d72-ff30-e5f8-b68f-7da5b92c1225",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40289,
							name = "spirit",
							uuid = "3be753e9-3c3e-27c5-ae00-8b54628d2ae7",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40332,
							name = "knockback",
							uuid = "5b8479be-1397-d91a-802e-31751fa9b5b9",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40250,
							name = "end",
							uuid = "46cdd522-efcb-84f7-84db-d72fdaea4362",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40247,
							name = "Akh first",
							uuid = "e2df56ff-d522-4f43-9b7a-edcb1786ad5f",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40248,
							name = "Akh repeats",
							uuid = "3d40db04-ff95-0a5c-ba77-9a0ec73cc9ac",
							version = 3,
						},
					},
				},
				displayPath = "P4 Crystallize Time",
				eventType = 2,
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Advance resolved mechanics",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 70,
				timerStartOffset = -11,
				uuid = "42b2158d-1070-2f89-be70-d02b875ce1b6",
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
							actionLua = "local s=data.frog_fru_ct\nif s then s.tidal(eventArgs,true);s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"cd4778f8-281b-abe0-bdd2-ab88123cc4b5",
									true,
								},
							},
							name = "Observe tidal",
							uuid = "3515ac6a-0dd4-aa67-8d0b-31e46f4b3603",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.spread=true;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"a644e736-f3c1-1bd4-ab76-17da778e289c",
									true,
								},
							},
							name = "Observe spirit",
							uuid = "151a28de-6a69-c07e-8b11-d11f044fc3bd",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.akh=true;s.akhPulses=0;s.lastAkhPulse=nil;s.akhDeadline=Now()+eventArgs.channelTimeMax*1000+4500;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"a568a42f-5de8-bc11-a0bc-4516461723ad",
									true,
								},
							},
							name = "Observe akh",
							uuid = "d1d04375-6ea7-435d-8e48-f23b2a97365d",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local s=data.frog_fru_ct\nif s then s.afah=true;s.afahDeadline=Now()+eventArgs.channelTimeMax*1000;s.nextPoll=0;s.destination=nil end\nself.used=true",
							conditions = 
							{
								
								{
									"a7102943-d589-eff8-8024-fa27b614f95b",
									true,
								},
							},
							name = "Observe afah",
							uuid = "b057347d-135e-db1c-8bec-909c8f3b3bae",
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
							eventSpellID = 40252,
							name = "tidal",
							uuid = "cd4778f8-281b-abe0-bdd2-ab88123cc4b5",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40288,
							name = "spirit",
							uuid = "a644e736-f3c1-1bd4-ab76-17da778e289c",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40247,
							name = "akh",
							uuid = "a568a42f-5de8-bc11-a0bc-4516461723ad",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 40304,
							name = "afah",
							uuid = "a7102943-d589-eff8-8024-fa27b614f95b",
							version = 3,
						},
					},
				},
				displayPath = "P4 Crystallize Time",
				eventType = 3,
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Read exawave origins and final stacks",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 70,
				timerStartOffset = -11,
				uuid = "b4037567-f43e-1dec-bb45-b56636e04dee",
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
							actionLua = "local s=data.frog_fru_ct\nif s and not s.northSlow and eventArgs.sourceEntityContentID==9823 then\n local a=TensorCore.mGetEntity(eventArgs.sourceEntityID)\n if a and a.pos and a.pos.z<100 then s.northSlow=a.pos.x<100 and -1 or 1;s.nextPoll=0 end\nend\nself.used=true",
							conditions = 
							{
								
								{
									"bcb40254-997f-118a-9ff5-85e0889c7697",
									true,
								},
							},
							name = "Store north purple hourglass",
							uuid = "88a08627-c5aa-4d90-83cd-49e1f9e926ac",
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
							eventIntValue = 133,
							name = "Slow hourglass",
							uuid = "bcb40254-997f-118a-9ff5-85e0889c7697",
							version = 3,
						},
					},
				},
				displayPath = "P4 Crystallize Time",
				eventType = 15,
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Read purple orientation",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 15,
				uuid = "81b43685-d8e5-6607-a184-89e4abb9e8db",
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
							actionLua = "local s=data.frog_fru_ct\nif s then\n local key=(eventArgs.z<104 and \"early\" or \"late\")..(eventArgs.x<100 and \"W\" or \"E\")\n s.puddles[key]={x=eventArgs.x,z=eventArgs.z};s.nextPoll=0\n local side=eventArgs.x<100 and -1 or 1\n s.headHits[side]=math.max(s.headHits[side],eventArgs.z<104 and 1 or 2)\nend\nself.used=true",
							conditions = 
							{
								
								{
									"f87c7648-b9aa-65bf-b55c-e6d3613c911d",
									true,
								},
							},
							name = "Store cleanse position",
							uuid = "22efd334-f4a7-df10-98a3-8b42dfe0cf25",
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
							eventIntValue = 2014529,
							name = "Cleanse puddle",
							uuid = "f87c7648-b9aa-65bf-b55c-e6d3613c911d",
							version = 3,
						},
					},
				},
				displayPath = "P4 Crystallize Time",
				eventType = 29,
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Record actual cleanse puddles",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 30,
				timerStartOffset = 5,
				uuid = "cd3ea08c-920f-3af5-9aad-45c0209f3865",
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
							actionLua = "local s=data.frog_fru_ct\nif s then s.poll()end\nself.used=true",
							name = "Update CT responsibility",
							uuid = "1d406c50-7025-5ce7-949e-7f67f6c76147",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Crystallize Time",
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Resolve personal destination",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 70,
				timerStartOffset = -11,
				uuid = "db8ee72d-45e7-7132-a83d-71e68a29fb9f",
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
							actionLua = "local prefs=FrogFRUDrawSettings\nlocal s=data.frog_fru_ct\nlocal player=TensorCore.mGetPlayer()\nif s and s.floorRouteVersion~=9 then\nfunction s.akhSoloPoint()\n local now=Now();local cached=s.meleePoint\n if now<(s.meleePointPoll or 0)then\n  if cached then return cached.x,cached.z end\n  return\n end\n s.meleePointPoll=now+100;s.meleePoint=nil\n local bosses={}\n for i,cid in ipairs({12809,9832})do\n  local id=s.meleeBossIDs and s.meleeBossIDs[i]\n  local actor=id and TensorCore.mGetEntity(id)\n  if not actor or not actor.pos or not actor.targetable or not actor.attackable or actor.hp.current<=0 or actor.hitradius<=1 then\n   actor=nil\n   for _,a in pairs(TensorCore.getEntityGroupList(\"ContentID\",{contentid=cid})or{})do\n    if a.pos and a.targetable and a.attackable and a.hp.current>0 and a.hitradius>1 then\n     if actor then return end\n     actor=a\n    end\n   end\n  end\n  if not actor then return end\n  bosses[i]=actor\n end\n local a,b=bosses[1],bosses[2]\n s.meleeBossIDs=s.meleeBossIDs or{}\n s.meleeBossIDs[1],s.meleeBossIDs[2]=a.id,b.id\n local ax,az,bx,bz=a.pos.x,a.pos.z,b.pos.x,b.pos.z\n local ra,rb=a.hitradius+3,b.hitradius+3\n if cached and cached.ax==ax and cached.az==az and cached.bx==bx and cached.bz==bz and cached.ra==ra and cached.rb==rb then s.meleePoint=cached;return cached.x,cached.z end\n local dx,dz=bx-ax,bz-az;local distance=math.sqrt(dx*dx+dz*dz)\n if distance<.01 or distance>ra+rb or distance<math.abs(ra-rb)then return end\n local along=(ra*ra-rb*rb+distance*distance)/(2*distance)\n local height=math.sqrt(math.max(0,ra*ra-along*along))\n local ux,uz=dx/distance,dz/distance\n local mx,mz=ax+along*ux,az+along*uz\n local x1,z1=mx-height*uz,mz+height*ux\n local x2,z2=mx+height*uz,mz-height*ux\n local x,z=x1,z1\n if z2>z1 then x,z=x2,z2 end\n if (x-100)^2+(z-100)^2>19.2^2 or (x-100)^2+(z-100)^2<7^2 then return end\n s.meleePoint={x=x,z=z,ax=ax,az=az,bx=bx,bz=bz,ra=ra,rb=rb}\n return x,z\nend\nfunction s.windPoint(r)\n s.windSetupPoints=s.windSetupPoints or{}\n local cached=s.windSetupPoints[r.side]\n if cached then return cached.x,cached.z end\n local x,z=s.polar(r.side,40,19)\n local ix,iz=s.headPoint(r.side,false)\n for _,record in pairs(s.records)do\n  if record.kind==\"redIce\" and record.side==r.side then\n   local ice=TensorCore.mGetEntity(record.id)\n   if ice and ice.pos and (ice.pos.x-100)^2+(ice.pos.z-100)^2>=10^2 then ix,iz=ice.pos.x,ice.pos.z end\n   break\n  end\n end\n local cx,cz=100,111\n local clocks=TensorCore.entityList(\"contentid=9823\")or{}\n for _,clock in pairs(clocks)do\n  if clock.pos and math.abs(clock.pos.x-100)<1 and clock.pos.z>100 then cx,cz=clock.pos.x,clock.pos.z;break end\n end\n local dx,dz=x-cx,z-cz;local distance=math.sqrt(dx*dx+dz*dz)\n local radius=math.max(12.75,distance)\n local ux,uz=dx/distance,dz/distance\n local tx,tz=-uz,ux\n if tx*(x-ix)+tz*(z-iz)<0 then tx,tz=-tx,-tz end\n local targetX,targetZ=cx+radius*(ux*math.cos(1/radius)+tx*math.sin(1/radius)),cz+radius*(uz*math.cos(1/radius)+tz*math.sin(1/radius))\n local bestX,bestZ,best\n for i=0,100 do\n  local angle=i/(100*radius)\n  local px,pz=cx+radius*(ux*math.cos(angle)+tx*math.sin(angle)),cz+radius*(uz*math.cos(angle)+tz*math.sin(angle))\n  local clear=(px-100)^2+(pz-100)^2<=19.5^2 and (px-ix)^2+(pz-iz)^2>(x-ix)^2+(z-iz)^2\n  if clear then\n   for _,clock in pairs(clocks)do\n    if clock.pos and math.abs(clock.pos.x-100)<1 and (px-clock.pos.x)^2+(pz-clock.pos.z)^2<12.75^2-.0001 then clear=false;break end\n   end\n  end\n  if clear then\n   local score=(px-targetX)^2+(pz-targetZ)^2\n   if not best or score<best then best=score;bestX,bestZ=px,pz end\n  end\n end\n if not bestX then return x,z end\n s.windSetupPoints[r.side]={x=bestX,z=bestZ}\n return bestX,bestZ\nend\nfunction s.windGuidance(me,r,now)\n local x,z,label,stage,deadline\n if (s.maelstromCount or 0)>=4 or s.unholyDone then\n  x,z=s.headPoint(r.side,true);label=\"Late head intercept (+2y lead)\"\n elseif (s.maelstromCount or 0)>=2 then\n  x,z=s.polar(r.side,19,19);label=\"Wind: clear next floor AOE\"\n  stage=\"ct-wind-next-floor\"\n  for id,a in pairs(s.floorAoes or{})do\n   if not s.maelstrom[id] and now<=a.untilAt then\n    local at=a.untilAt-400\n    deadline=deadline and math.min(deadline,at)or at\n   end\n  end\n else\n  x,z=s.windPoint(r);label=\"Wind: clear ice; wait for floor explosion\"\n  stage=\"ct-wind-floor\";deadline=s.firstMaelstromDeadline\n end\n s.destination={x=x,y=.07,z=z,label=label};s.keepVisible=true;s.arrivalRadius=.2\n s.windArrowStage=stage;s.windArrowDeadline=deadline;s.filteredPoint=s.destination\nend\nfunction s.headPoint(side,late)\n if not late then return 100+side*13,100 end\n local x,z=s.polar(side,33,13)\n for _,h in pairs(TensorCore.entityList(\"contentid=9323\")or{})do\n  if h.hitradius and h.hitradius>0 and h.pos and h.pos.h and (h.pos.x<100 and -1 or 1)==side and h.pos.z>=108 and math.abs(h.pos.x-100)<=11 then\n   x=h.pos.x+2*math.sin(h.pos.h);z=h.pos.z+2*math.cos(h.pos.h)\n   break\n  end\n end\n return x,z\nend\nfunction s.pendingStack()\n local r=s.records and s.records[s.myRole]\n if not r or not r.kind then return end\n if r.kind==\"redIce\" then\n  if r.side==s.northSlow and not s.unholyDone then return \"unholy\" end\n elseif r.kind:sub(1,4)==\"blue\" then\n  if r.kind~=\"blueEruption\" and not s.aeroAt then return \"water\" end\n  if not s.unholyDone then return \"unholy\" end\n end\nend\nfunction s.corner(spread)\n if not s.originX or not s.originZ then\n  local foundX,foundZ,conflictX,conflictZ\n  for _,a in pairs(TensorCore.entityList(\"contentid=12809\")or{})do\n   if a.pos then\n    if math.abs(a.pos.x-100)>=18 and math.abs(a.pos.z-100)<=2 then\n     local sign=a.pos.x<100 and -1 or 1\n     if foundX and foundX~=sign then conflictX=true end;foundX=sign\n    elseif math.abs(a.pos.z-100)>=18 and math.abs(a.pos.x-100)<=2 then\n     local sign=a.pos.z<100 and -1 or 1\n     if foundZ and foundZ~=sign then conflictZ=true end;foundZ=sign\n    end\n   end\n  end\n  if not s.originX and not conflictX then s.originX=foundX end\n  if not s.originZ and not conflictZ then s.originZ=foundZ end\n end\n if not spread and (FrogFRUDrawSettings or {}).region==\"JP\" then\n  if not s.originZ then return end\n  local side=s.originZ\n  if s.myRole==\"T1\" then return 100+11*side,100+14*side end\n  if s.myRole==\"T2\" then return 100-11*side,100+14*side end\n  return 100,100+3.5*side\n end\n if not s.originX or not s.originZ then return end\n local fX,fZ=s.originX/math.sqrt(2),s.originZ/math.sqrt(2)\n local lX,lZ=fZ,-fX;local sign=s.myRole:sub(2,2)==\"1\" and 1 or -1\n local role=s.myRole:sub(1,1);local forward,left\n if spread then\n  if role==\"T\" then forward,left=17.7,4.95\n  elseif role==\"H\" then forward,left=4.2,4.2\n  elseif role==\"M\" then forward,left=-7.1,7.1\n  else forward,left=-3.5,16 end\n  return 100+forward*fX+sign*left*lX,100+forward*fZ+sign*left*lZ\n end\n forward=role==\"T\" and 1.5 or -1.5;left=role==\"T\" and 3 or 2\n return 100+8.5*s.originX+forward*fX+sign*left*lX,100+8.5*s.originZ+forward*fZ+sign*left*lZ\nend\nfunction s.waveKey(id,x,z)\n return tostring(id)..\":\"..string.format(\"%.1f:%.1f\",x,z)\nend\nfunction s.tidal(e,begin)\n local a=TensorCore.mGetEntity(e.entityID)\n local key=s.waveSources and s.waveSources[e.entityID]\n if begin then\n  if not a or not a.pos then return end\n  key=s.waveKey(e.entityID,a.pos.x,a.pos.z)\n  s.waveSources=s.waveSources or {};s.waveSources[e.entityID]=key\n  if math.abs(a.pos.x-100)>15 then s.originX=a.pos.x<100 and -1 or 1\n  elseif math.abs(a.pos.z-100)>15 then s.originZ=a.pos.z<100 and -1 or 1 end\n  if e.channelTimeMax and e.channelTimeMax>0 then\n   s.waveChannels=s.waveChannels or {};s.waveChannels[key]=Now()+e.channelTimeMax*1000\n  end\n else\n  if key then s.resolvedWaves=s.resolvedWaves or {};s.resolvedWaves[key]=true end\n  local h=e.heading;if type(h)~=\"number\"then return end\n  local axis=math.abs(math.sin(h))>.7 and \"ew\"or\"ns\";local now=Now()\n  if not s.lastWave[axis]or now-s.lastWave[axis]>500 then s.waves[axis]=s.waves[axis]+1;s.lastWave[axis]=now end\n end\nend\nfunction s.cleanseDestination(r)\n if (FrogFRUDrawSettings or{}).region==\"JP\"then return s.cleansePoint(r)end\n local key=({blueEruption=\"earlyW\",blueUnholy=\"earlyE\",blueIce=\"lateW\",blueWater=\"lateE\"})[r.kind]\n return key and s.puddles[key]\nend\nfunction s.floorPointClear(x,z,fromX,fromZ)\n local function clear(ax,az)\n  local px,pz=x,z\n  if fromX and fromZ then\n   local dx,dz=x-fromX,z-fromZ;local length=dx*dx+dz*dz\n   local t=length>0 and math.max(0,math.min(1,((ax-fromX)*dx+(az-fromZ)*dz)/length))or 0\n   px,pz=fromX+t*dx,fromZ+t*dz\n  end\n  return (px-ax)^2+(pz-az)^2>=12.75^2\n end\n for _,a in pairs(s.floorAoes or{})do\n  if Now()<=a.untilAt and not clear(a.x,a.z)then return false end\n end\n for _,a in pairs(TensorCore.entityList(\"contentid=9823\")or{})do\n  if a.pos and not s.maelstrom[a.id]and not clear(a.pos.x,a.pos.z)then return false end\n end\n return true\nend\nfunction s.waveIntersection(me,x,z,a)\n local sh,ch=math.sin(a.heading),math.cos(a.heading)\n local function localPoint(px,pz)local dx,dz=px-a.x,pz-a.z;return dx*ch-dz*sh,dx*sh+dz*ch end\n local sx,sz=localPoint(me.pos.x,me.pos.z);local tx,tz=localPoint(x,z)\n local margin=math.max(.5,me.hitradius or .5)+.25\n local half=a.aoeWidth/2+margin;local low,high=-margin,a.aoeLength+margin\n local inside=math.abs(sx)<=half and sz>=low and sz<=high\n local entry,leave=0,1\n local function clip(start,delta,minimum,maximum)\n  if math.abs(delta)<.00001 then return start>=minimum and start<=maximum end\n  local lo,hi=(minimum-start)/delta,(maximum-start)/delta\n  if lo>hi then lo,hi=hi,lo end\n  entry=math.max(entry,lo);leave=math.min(leave,hi)\n  return entry<=leave\n end\n if not clip(sx,tx-sx,-half,half)or not clip(sz,tz-sz,low,high)then return end\n return {inside=inside,entry=entry,sx=sx,low=low,high=high,sh=sh,ch=ch}\nend\nfunction s.dodgePoint(me,x,z,a,hit,wait)\n local candidates={}\n if hit.inside then\n  for _,forward in ipairs({hit.low-.75,hit.high+.75})do\n   local px=a.x+hit.sx*hit.ch+forward*hit.sh\n   local pz=a.z-hit.sx*hit.sh+forward*hit.ch\n   if math.abs(hit.sh)>.7 then\n    local limit=19.1^2-(px-100)^2\n    if limit>=0 then limit=math.sqrt(limit);pz=math.max(100-limit,math.min(100+limit,pz))end\n   else\n    local limit=19.1^2-(pz-100)^2\n    if limit>=0 then limit=math.sqrt(limit);px=math.max(100-limit,math.min(100+limit,px))end\n   end\n   candidates[#candidates+1]={x=px,z=pz}\n  end\n else\n  local dx,dz=x-me.pos.x,z-me.pos.z;local length=math.sqrt(dx*dx+dz*dz)\n  local t=length>.01 and math.max(0,hit.entry-.75/length)or 0\n  candidates[1]={x=me.pos.x+t*dx,z=me.pos.z+t*dz}\n end\n if wait then candidates[#candidates+1]=wait end\n for _,p in ipairs(candidates)do\n  local dx,dz=p.x-a.x,p.z-a.z\n  local side,forward=dx*hit.ch-dz*hit.sh,dx*hit.sh+dz*hit.ch\n  local outside=math.abs(side)>a.aoeWidth/2+.75 or forward<hit.low or forward>hit.high\n  if outside and (p.x-100)^2+(p.z-100)^2<=19.2^2 and s.floorPointClear(p.x,p.z)then return {x=p.x,z=p.z}end\n end\nend\nfunction s.firstBlockingWave(me,x,z,wait)\n local selected,best,blocked\n for _,a in ipairs(Argus.getCurrentAOEs())do\n  if a.aoeID==40252 or a.aoeID==40253 then\n   local hit=s.waveIntersection(me,x,z,a)\n   if hit then\n    blocked=true\n    local key=s.waveKey(a.entityID,a.x,a.z)\n    local deadline=s.waveChannels and s.waveChannels[key]\n    local rank=deadline or Now()+100000\n    if not best or rank<best then\n     local point=s.dodgePoint(me,x,z,a,hit,wait)\n     if point then\n      local axis=math.abs(math.sin(a.heading))>.7 and \"ew\"or\"ns\"\n      best=rank;selected={key=key,point=point,deadline=deadline,axis=axis,count=s.waves[axis]}\n     end\n    end\n   end\n  end\n end\n return selected,blocked\nend\nfunction s.waveFinished(wave)\n if s.resolvedWaves and s.resolvedWaves[wave.key]then return true end\n if s.waves[wave.axis]<=wave.count then return false end\n for _,a in ipairs(Argus.getCurrentAOEs())do\n  if (a.aoeID==40252 or a.aoeID==40253)and s.waveKey(a.entityID,a.x,a.z)==wave.key then return false end\n end\n return true\nend\nfunction s.showCTStep(seq,point,label,stage,deadline)\n if point then s.destination={x=point.x,y=.07,z=point.z,label=label}else s.destination=nil end\n s.windArrowStage=stage;s.windArrowDeadline=deadline;s.keepVisible=true;s.arrivalRadius=seq.phase==4 and .2 or .6\n s.filteredPoint=s.destination\nend\nfunction s.fixedSequence(me,r,now)\n local seq=s.sequence\n if not seq then\n  seq={phase=1,blue=r.kind:sub(1,4)==\"blue\",waveDone=s.waves.ew>=4}\n  s.sequence=seq\n end\n if seq.phase==4 then\n  if not seq.rewind then local x,z=s.corner(false);if x then seq.rewind={x=x,z=z}end end\n  s.showCTStep(seq,seq.rewind,\"Place rewind: tanks in front\",nil,nil);return\n end\n local blueBuff=seq.blue and TensorCore.getBuff(me,3264)\n if seq.blue and not blueBuff then seq.cleansed=true end\n if not seq.puddle and seq.blue and not seq.cleansed then\n  local p=s.cleanseDestination(r)\n  if p then seq.puddle={x=p.x,z=p.z}end\n end\n local rx,rz=s.corner(false)\n local goal\n if seq.blue and not seq.cleansed then goal=seq.puddle\n elseif rx then goal={x=rx,z=rz}end\n if seq.phase==1 then\n  local ex,ez,deadline=s.exitFloor(me,goal and goal.x or me.pos.x,goal and goal.z or me.pos.z,now)\n  if ex==false then s.destination=nil;s.filteredPoint=nil;return end\n  if ex then\n   seq.wait={x=ex,z=ez};s.showCTStep(seq,seq.wait,\"Exit active floor AOE first\",\"ct-floor-exit\",deadline);return\n  end\n  seq.wait=seq.wait or {x=me.pos.x,z=me.pos.z};seq.phase=2\n end\n if seq.phase==2 and not seq.blue and not seq.prepared then\n  if not seq.prepare then\n   local x,z\n   if r.kind==\"redWind\" then x,z=s.polar(s.northSlow,30,7)\n   elseif r.kind==\"redIce\" then x,z=s.polar(-s.northSlow,150,7)end\n   if x then seq.prepare={x=x,z=z}end\n  end\n  if seq.prepare and s.floorPointClear(seq.prepare.x,seq.prepare.z,me.pos.x,me.pos.z)then\n   seq.wait=seq.prepare;seq.prepared=true\n  end\n end\n if seq.phase==2 and not seq.waveDone and goal then\n  local wave,blocked=s.firstBlockingWave(me,goal.x,goal.z,seq.wait)\n  if wave then seq.wave=wave;seq.phase=3\n  elseif not blocked and s.waves.ew>=1 then seq.waveDone=true end\n end\n if seq.phase==3 and seq.wave and not seq.waveDone then\n  if s.waveFinished(seq.wave)then seq.waveDone=true\n  else s.showCTStep(seq,seq.wave.point,\"Dodge first wave\",\"ct-seq-dodge\",seq.wave.deadline);return end\n end\n if seq.waveDone then\n  if seq.blue and not seq.cleansed then\n   seq.phase=3\n   local point=seq.puddle and s.floorPointClear(seq.puddle.x,seq.puddle.z)and seq.puddle or seq.wave and seq.wave.point or seq.wait\n   s.showCTStep(seq,point,\"Collect assigned cleanse puddle\",\"ct-seq-cleanse\",nil);return\n  end\n  seq.phase=4;seq.rewind=rx and {x=rx,z=rz}or nil\n  s.showCTStep(seq,seq.rewind,\"Place rewind: tanks in front\",nil,nil);return\n end\n local point=seq.blue and seq.puddle and s.floorPointClear(seq.puddle.x,seq.puddle.z)and seq.puddle or seq.wait\n s.showCTStep(seq,point,seq.blue and \"Approach assigned cleanse puddle\"or\"Wait for first wave\",\"ct-seq-prepare\",nil)\nend\n\nfunction s.filterGuidance()\n local now=Now()\n if s.destination==s.filteredPoint and now<(s.guidancePollAt or 0)then return end\n s.guidancePollAt=now+100\n if not s.finished or s.akh or s.afah or s.kbCount>=2 or s.spread or (s.recordAt and now>=s.recordAt+150)then return end\n local me=TensorCore.mGetPlayer();local r=s.records and s.records[s.myRole]\n if not me or not me.pos or me.hp.current<=0 or not r or not r.kind or not s.northSlow then return end\n local heads=s.headHits[r.side]or 0\n if r.kind==\"redWind\" and heads<2 then s.windGuidance(me,r,now);return end\n if (r.kind==\"redIce\" and heads<1)or(r.kind==\"redWind\" and heads<2)then return end\n local pending=(not s.sequence or s.sequence.phase==1)and s.pendingStack()\n if pending then\n  local x,z,label\n  if pending==\"unholy\" then\n   x,z=s.polar(s.northSlow,140,19);label=r.kind==\"redIce\" and \"Join north Unholy stack\" or \"North Unholy stack\"\n  else\n   local groupSide=-s.northSlow\n   x,z=s.polar(groupSide,40,19);label=\"South purple: four-person water stack\"\n   if (s.maelstromCount or 0)>=2 then\n    for _,v in pairs(s.records)do\n     if v.kind==\"redWind\" and v.side==groupSide then\n      local wind=TensorCore.mGetEntity(v.id)\n      if wind and wind.pos then\n       local tx,tz=s.polar(s.northSlow,140,19);local dx,dz=tx-wind.pos.x,tz-wind.pos.z;local d=math.sqrt(dx*dx+dz*dz)\n       if d>0 then x,z=wind.pos.x+2*dx/d,wind.pos.z+2*dz/d end\n      end\n      break\n     end\n    end\n    label=\"Water stack / line up Aero knockback\"\n   end\n  end\n  s.destination={x=x,y=.07,z=z,label=label};s.keepVisible=true;s.arrivalRadius=.2\n  s.windArrowStage=nil;s.windArrowDeadline=nil;s.filteredPoint=s.destination\n  return\n end\n s.fixedSequence(me,r,now)\nend\nfunction s.exitFloor(me,nextX,nextZ,now)\n if s.pendingStack()then s.floorExitPlan=nil;s.floorInside=nil;return end\n local hazards,seen={},{}\n for id,a in pairs(s.floorAoes or {})do\n  if now>a.untilAt then s.floorAoes[id]=nil\n  else hazards[#hazards+1]=a;seen[id]=true end\n end\n for _,a in pairs(TensorCore.entityList(\"contentid=9823\")or{})do\n  if a.pos and not seen[a.id] and not s.maelstrom[a.id] then\n   hazards[#hazards+1]={x=a.pos.x,z=a.pos.z}\n  end\n end\n local inside,deadline=false,nil\n for _,a in ipairs(hazards)do\n  if (me.pos.x-a.x)^2+(me.pos.z-a.z)^2<12.75^2 then\n   inside=true\n   if a.untilAt then local at=a.untilAt-400;deadline=deadline and math.min(deadline,at)or at end\n  end\n end\n s.floorInside=inside\n if not inside then\n  s.floorExitPlan=nil\n  return\n end\n local r=s.records and s.records[s.myRole]\n local direction=r and r.kind==\"redWind\" and 1 or -1\n local plan=s.floorExitPlan\n if plan and plan.direction==direction then\n  local clear=true\n  for _,a in ipairs(hazards)do\n   if (plan.x-a.x)^2+(plan.z-a.z)^2<12.75^2 then clear=false;break end\n   local ax,az=me.pos.x-a.x,me.pos.z-a.z\n   if ax*ax+az*az>=12.75^2 then\n    local dx,dz=plan.x-me.pos.x,plan.z-me.pos.z\n    local length=dx*dx+dz*dz\n    if length>.001 then\n     local t=math.max(0,math.min(1,-(ax*dx+az*dz)/length))\n     if (ax+t*dx)^2+(az+t*dz)^2<12.75^2 then clear=false;break end\n    end\n   end\n  end\n  if clear then return plan.x,plan.z,deadline end\n end\n local best,x,z\n local lows,highs={},{}\n for degrees=0,359 do\n  local angle=degrees*math.pi/180\n  local ux,uz=math.sin(angle),math.cos(angle)\n  if uz*direction>=.15 then\n   local n=0\n   for _,a in ipairs(hazards)do\n    local ax,az=me.pos.x-a.x,me.pos.z-a.z\n    local along=ax*ux+az*uz\n    local disc=along*along-(ax*ax+az*az-12.75^2)\n    if disc>=0 then\n     local root=math.sqrt(disc)\n     local hi=-along+root\n     if hi>0 then n=n+1;lows[n]=math.max(0,-along-root);highs[n]=hi end\n    end\n   end\n   local reach=0\n   for pass=1,n+1 do\n    local previous=reach\n    for i=1,n do if lows[i]<=reach+.4 then reach=math.max(reach,highs[i])end end\n    if reach==previous then break end\n   end\n   local distance=reach+.4\n   local px,pz=me.pos.x+distance*ux,me.pos.z+distance*uz\n   if (px-100)^2+(pz-100)^2<=19.2^2 then\n    local clear=true\n    for _,a in ipairs(hazards)do if (px-a.x)^2+(pz-a.z)^2<12.75^2 then clear=false;break end end\n    if clear then\n     local score=distance+math.sqrt((px-nextX)^2+(pz-nextZ)^2)*.001\n     if not best or score<best then best=score;x,z=px,pz end\n    end\n   end\n  end\n end\n if x then s.floorExitPlan={x=x,z=z,direction=direction};return x,z,deadline end\n return false,false\nend\n\n s.floorRouteVersion=9;s.nextPoll=0;s.guidancePollAt=0;s.filteredPoint=nil\nend\nif s and s.assigned and (not s.unholyDeadline or not s.waterDeadline) and Now()>=(s.stackDeadlinePoll or 0) then\n s.stackDeadlinePoll=Now()+100\n for _,record in pairs(s.records)do\n  local buffID=record.kind==\"blueUnholy\" and 2454 or record.kind==\"blueWater\" and 2461\n  local key=record.kind==\"blueUnholy\" and \"unholyDeadline\" or \"waterDeadline\"\n  if buffID and not s[key] then\n   local actor=TensorCore.mGetEntity(record.id)\n   local buff=actor and TensorCore.getBuff(actor,buffID)\n   if buff and buff.duration and buff.duration>0 then s[key]=Now()+buff.duration*1000 end\n  end\n end\nend\nif s and s.nextPoll==0 then s.poll() end\nif s then s.filterGuidance()end\nif prefs and prefs.drawSpreads and s and Now()-s.start<=95000 and not s.spiritDone and not s.done and s.kbCount<2 and not s.akh and not s.afah and (s.spread or (s.recordAt and Now()>=s.recordAt+150)) then\n prefs.release(data,\"frog_fru_ct\")\n prefs.drawSpreads(s,\"ct\")\n self.used=true return\nend\nif not prefs or not prefs.guide then self.used=true return end\nif not s or not s.destination or not player or not player.pos or player.hp.current<=0 or Now()-(s.start or s.started)>95000 then prefs.release(data,\"frog_fru_ct\");self.used=true return end\nlocal style=s.afah and \"afah2\" or (s.kbCount>=2 or s.akh) and \"akh2\" or \"ct\"\nif prefs.styleFor(style)==\"Disabled\" then prefs.release(data,\"frog_fru_ct\");self.used=true return end\ns.keepVisible=true\nlocal point=s.destination\nlocal x,y,z=point.x,point.y or .07,point.z\nif prefs.region~=\"JP\" and (s.kbCount>=2 or s.akh) and not s.afah and (prefs.ctAkh or prefs.akh or \"7-1\")==\"7-1\" and s.myRole==(prefs.ctSolo or (prefs.akhSolo==\"T1\" and \"T2\" or \"T1\")) then\n x,z=s.akhSoloPoint()\n if not x then prefs.release(data,\"frog_fru_ct\");self.used=true return end\nend\nlocal label=point.label\ns.arrowDeadline=nil;s.arrowHoldAfterDeadline=true\ns.arrowStage=s.windArrowStage\nif s.windArrowStage then s.arrowDeadline=s.windArrowDeadline;s.arrowHoldAfterDeadline=s.windArrowStage==\"ct-floor-exit\" or s.windArrowStage==\"ct-seq-dodge\" or s.windArrowStage==\"ct-wind-floor\" or s.windArrowStage==\"ct-wind-next-floor\"\nelseif s.afah then s.arrowDeadline=s.afahDeadline or (prefs.castDeadline and prefs.castDeadline(data,s,{40304}))\nelseif s.kbCount>=2 or s.akh then s.arrowDeadline=s.akhDeadline\nelseif not s.unholyDone and label and label:find(\"Unholy stack\",1,true) then s.arrowDeadline=s.unholyDeadline;s.arrowStage=\"ct-unholy-stack\"\nelseif not s.waterDone and label and (label:find(\"water stack\",1,true)or label:find(\"Water stack\",1,true)) then s.arrowDeadline=s.waterDeadline;s.arrowStage=\"ct-water-stack\"\nelseif prefs.castDeadline and not s.spiritDone and (s.spread or (s.recordAt and Now()>=s.recordAt+150)) then s.arrowDeadline=prefs.castDeadline(data,s,{40288})\nelseif s.finished and s.recordAt then s.arrowDeadline=s.recordAt\nelseif prefs.castDeadline then s.arrowDeadline=prefs.castDeadline(data,s,{40298}) end\nif label and label:find(\"head intercept\",1,true) then\n local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local marker=TensorCore.getCachedDrawer(0xB0FF40D0,0xB0FF40D0,0xB0FF40D0,0xFFFF40D0,2,0,flags)\n marker:addCircle(x,y+.03,z,.8,false,flags)\nend\nprefs.guide(data,\"frog_fru_ct\",style,s,player,x,y,z,label,nil,6)\n\nself.used=true",
							name = "Draw CT destination",
							uuid = "8200a635-5519-bb5b-a758-4924ac0ea6c7",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Crystallize Time",
				eventType = 12,
				loop = true,
				mechanicTime = 798.9,
				name = "[CT] Personal responsibility tether",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 70,
				timerStartOffset = -11,
				uuid = "63b6e701-8f7b-a41b-bf81-bae68510ba3e",
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
							actionLua = "local p=FrogFRUDrawSettings\nif p and p.clearCTMarks and p.ctOwned then p.ctCleanupTries=0;p.clearCTMarks()end\ndata.frog_fru_ct=nil\nself.used=true",
							name = "Clear CT state",
							uuid = "c57a084a-fe17-e1eb-9eec-44da5d9cfe9a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Crystallize Time",
				eventType = 9,
				mechanicTime = 798.9,
				name = "[CT] Clear state - wipe",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 1800,
				timerStartOffset = -799,
				uuid = "6198ee28-4667-f3af-9d92-b01760d3d277",
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
							actionLua = "data.frog_fru_ct=nil\nself.used=true",
							name = "Clear CT state",
							uuid = "8b11ede8-cfca-2eb1-8b33-a63b2b3e00ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Crystallize Time",
				eventType = 16,
				mechanicTime = 798.9,
				name = "[CT] Clear state - countdown",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 1800,
				timerStartOffset = -799,
				uuid = "7cae5f80-4f9e-121d-9842-c3b44731f393",
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
							actionLua = "data.frog_fru_ct=nil\nself.used=true",
							name = "Clear CT state",
							uuid = "f7b46ef4-32d7-343a-9e82-cb0c588a4223",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P4 Crystallize Time",
				eventType = 11,
				mechanicTime = 798.9,
				name = "[CT] Clear state - map",
				timeRange = true,
				timelineIndex = 179,
				timerEndOffset = 1800,
				timerStartOffset = -799,
				uuid = "845dc04c-fc74-97df-a85e-aba7e933d63d",
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
				name = "P5 Pandora",
				uuid = "df53fff3-836a-4f94-9794-806349eff32b",
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
							actionLua = "local old=data.frog_fru_p5\nif old and old.clear then old.clear() end\nif old and old.clearWings then old.clearWings() end\nlocal s={start=Now(),records={},lines={},lineIDs={},towers={},waves=0,cleaves=0,round=0,stage=\"fulgent\",nextRoster=0,nextLines=0}\ndata.frog_fru_p5=s\ns.keys={\"T1\",\"T2\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\nfunction s.clear()\n if s.arrow then Argus.deleteTimedShape(s.arrow);s.arrow=nil end\n local settings=FrogFRUDrawSettings\n if settings and settings.release then settings.release(data,\"frog_fru_p5\") end\n s.destination=nil;s.drawKey=nil;s.guideOwner=nil\nend\nfunction s.clearWings()\n local w=s.wingShapes\n if w then\n  if w.cone then Argus.deleteTimedShape(w.cone) end\n  if w.circle then Argus.deleteTimedShape(w.circle) end\n end\n s.wingShapes=nil\nend\nfunction s.updateWings()\n local prefs=FrogFRUDrawSettings or {}\n if s.stage~=\"paradise\" or not s.firstWing or prefs.p5==false or (prefs.styleFor and prefs.styleFor(\"p5_paradise\")==\"Disabled\") then s.clearWings();return end\n local boss=TensorCore.mGetEntity(s.bossID)\n if not boss or not boss.pos then s.clearWings();return end\n local now=Now()\n local w=s.wingShapes\n if not w then w={};s.wingShapes=w end\n local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n local cone=TensorCore.getCachedDrawer(0x302050FF,0x302050FF,0x302050FF,0xFF2050FF,2,0,flags)\n local circle=TensorCore.getCachedDrawer(0x604020FF,0x604020FF,0x604020FF,0xFF8000FF,3,0,flags)\n local first=s.firstWing==\"light\"\n local light=(s.cleaves==0)==first\n local finish=s.cleaves==0 and s.wingFirstDeadline or s.cleaveAt and s.cleaveAt+3750\n local target=s.cleaves==0 and s.wingAggro or boss.targetid\n if s.cleaves<2 and finish and now<finish and target and TensorCore.mGetEntity(target) then\n  if w.conePhase~=s.cleaves then if w.cone then Argus.deleteTimedShape(w.cone) end;w.cone=nil;w.conePhase=s.cleaves end\n  if not w.cone then\n   w.cone=cone:addTimedConeOnEnt(finish-now,s.bossID,40,5*math.pi/4,target,0,false,true,light and 3*math.pi/8 or -3*math.pi/8,false,flags)\n  elseif w.coneTarget~=target then\n   cone:updateTimedConeOnEnt(w.cone,nil,s.bossID,40,5*math.pi/4,target,0,false,true,light and 3*math.pi/8 or -3*math.pi/8,false,flags)\n  end\n  w.coneTarget=target\n elseif w.cone then Argus.deleteTimedShape(w.cone);w.cone=nil end\n local partner,kind\n for _,t in ipairs(Argus.getTethersOnEnt(s.bossID))do\n  if t.type==1 or t.type==2 then\n   local a=TensorCore.mGetEntity(t.partnerid)\n   if a and a.hp and a.hp.current>0 then partner=t.partnerid;kind=t.type;break end\n  end\n end\n local firstType=first and 2 or 1\n local circleFinish=kind==firstType and s.wingFirstDeadline or s.wingSecondDeadline\n circleFinish=circleFinish and circleFinish+750\n if partner and circleFinish and now<circleFinish and not (s.wingCirclesDone and s.wingCirclesDone[kind]) then\n  if w.circleType~=kind then if w.circle then Argus.deleteTimedShape(w.circle) end;w.circle=nil;w.circleType=kind end\n  if not w.circle then w.circle=circle:addTimedCircleOnEnt(circleFinish-now,partner,4,0,false,true,flags)\n  elseif w.circleTarget~=partner then circle:updateTimedCircleOnEnt(w.circle,nil,partner,4,0,false,true,flags) end\n  w.circleTarget=partner\n elseif w.circle then Argus.deleteTimedShape(w.circle);w.circle=nil end\nend\nfunction s.capture()\n if not AnyoneCore then return false end\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n local me=TensorCore.mGetPlayer()\n if not me or type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local records,used={},{}\n for _,key in ipairs(s.keys) do\n  local m=members[key];if not m or not m.name or not m.job then return false end\n  local actor,count=nil,0\n  for _,a in pairs(party) do if a.name==m.name and a.job==m.job then actor=a;count=count+1 end end\n  if count==0 then\n   local copies=0;for _,v in pairs(members) do if v.job==m.job then copies=copies+1 end end\n   if copies==1 then for _,a in pairs(party) do if a.job==m.job then actor=a;count=count+1 end end end\n  end\n  if count~=1 or used[actor.id] then return false end\n  used[actor.id]=true;records[key]={id=actor.id}\n  if actor.id==me.id then s.role=key end\n end\n if not s.role then return false end\n s.records=records;s.ready=true;return true\nend\nfunction s.point(x,z,label,key,ttl,hold)\n if s.polarDone and (s.stage==\"idle\" or s.stage==\"polar\")then s.clear();return end\n if not x or not z or (x-100)^2+(z-100)^2>361.001 then s.clear();return end\n local deadline\n if key==\"t:north\" then\n  deadline=nil\n elseif key:sub(1,2)==\"f:\" then\n  deadline=s.waves<=1 and s.fulgentFirstDeadline and s.fulgentFirstDeadline+2000 or s.bundleAt and s.bundleAt+2000\n elseif key:sub(1,4)==\"akh:\" then deadline=s.akhDeadline\n elseif s.stage==\"paradise\" then\n  if key==\"h:0\" then deadline=s.towers[1] and s.towers[1].deadline\n  elseif key==\"t:prepare\" then deadline=s.towers[1] and s.towers[1].spawned+2300\n  elseif key:sub(1,8)==\"d:tower:\" then\n   for _,tower in ipairs(s.towers)do if key==\"d:tower:\"..tower.index then deadline=tower.deadline;break end end\n  elseif key==\"h:1\" then deadline=s.wingSecondDeadline\n  elseif s.cleaves==0 then deadline=s.wingFirstDeadline\n  else deadline=s.cleaveAt and s.cleaveAt+3750 end\n elseif s.stage==\"polar\" then\n  if s.aftershock then deadline=s.baitAt and s.baitAt+2100\n  elseif s.round==0 then deadline=s.polarFirstDeadline\n  else deadline=s.afterAt and s.afterAt+2500 end\n end\n if s.drawKey~=key then\n  s.clear();s.drawKey=key\n  s.guideOwner={stage=key,keepVisible=true,arrowHoldAfterDeadline=true}\n end\n s.guideOwner.arrowHoldAfterDeadline=s.stage~=\"polar\"\n s.guideOwner.arrowDeadline=deadline\n s.destination={x=x,y=.08,z=z,label=label,hold=hold==true}\nend\nfunction s.addLine(a)\n if s.stage~=\"fulgent\" or not a or not a.pos or s.lineIDs[a.id] or #s.lines>=6 then return end\n local x,z=a.pos.x-100,a.pos.z-100;local r=math.sqrt(x*x+z*z)\n if r<1 or r>30 then return end\n for _,v in ipairs(s.lines) do if (v.x-a.pos.x)^2+(v.z-a.pos.z)^2<0.04 then return end end\n s.lineIDs[a.id]=true;s.lines[#s.lines+1]={x=a.pos.x,z=a.pos.z,nx=x/r,nz=z/r}\nend\nfunction s.fulgent()\n local w=s.waves;local first=w<3 and 1 or w<5 and 3 or 5\n local inset=(w==2 or w==4 or w>=6) and 8 or 12\n local a,b=s.lines[first],s.lines[first+1]\n if not a or not b then return end\n local ax,az=a.x-inset*a.nx,a.z-inset*a.nz\n local bx,bz=b.x-inset*b.nx,b.z-inset*b.nz\n local ux,uz=-a.nz,a.nx;local vx,vz=-b.nz,b.nx\n local cross=ux*vz-uz*vx;if math.abs(cross)<0.1 then return end\n local t=((bx-ax)*vz-(bz-az)*vx)/cross\n s.point(ax+t*ux,az+t*uz,\"Fulgent dodge\",\"f:\"..(w<=1 and 0 or w),nil)\nend\nfunction s.bossPoint(angle,radius)\n local b=TensorCore.mGetEntity(s.bossID)\n if not b or not b.pos or not b.pos.h then return end\n local h=b.pos.h+angle\n return b.pos.x+radius*math.sin(h),b.pos.z+radius*math.cos(h)\nend\nfunction s.safeTowerPoint(x,z)\n if s.towerOffsetSource~=s.towers or s.towerOffsetDeadline~=s.wingFirstDeadline or s.towerBiasGeometry~=3 then\n  s.towerBiasGeometry=3;s.towerOffsetSource=s.towers;s.towerOffsetDeadline=s.wingFirstDeadline;s.towerOffsets={}\n end\n local key=tostring(x)..\":\"..tostring(z)\n local saved=s.towerOffsets[key]\n if s.cleaves>=2 and saved then return saved.x,saved.z end\n if not s.firstWing then return x,z end\n local phase=math.min(s.cleaves,1)\n local boss=TensorCore.mGetEntity(s.bossID)\n local id=phase==0 and s.wingAggro or boss and boss.targetid\n local target=id and TensorCore.mGetEntity(id)\n if not boss or not boss.pos or not target or not target.pos then\n  if saved and saved.phase==phase then return saved.x,saved.z end\n  return\n end\n local light=(phase==0)==(s.firstWing==\"light\")\n local h=math.atan2(target.pos.x-boss.pos.x,target.pos.z-boss.pos.z)+(light and 1 or -1)*3*math.pi/8+math.pi\n local dx,dz=x-boss.pos.x,z-boss.pos.z\n local radius=math.sqrt(dx*dx+dz*dz)\n if radius<.01 then return end\n local vx,vz=dx/radius+math.sin(h),dz/radius+math.cos(h)\n local length=math.sqrt(vx*vx+vz*vz)\n if length<.01 then return end\n local px,pz=x+2*vx/length,z+2*vz/length\n s.towerOffsets[key]={x=px,z=pz,phase=phase}\n return px,pz\nend\ns.towerOffsetVersion=3\n\nfunction s.paradise()\n if not s.south then return end\n local role=s.role:sub(1,1)\n local south=s.south\n local function polar(a,r)return 100+r*math.sin(south+a),100+r*math.cos(south+a) end\n local strategy=(FrogFRUDrawSettings or {}).p5Strategy or \"NA\"\n if role==\"H\" and s.towerHits==0 then\n  local x,z=polar(0,7)\n  x,z=s.safeTowerPoint(x,z)\n  if x then s.point(x,z,\"First tower\",\"h:0\",nil,true)end\n  return\n end\n if not s.firstWing then\n  if strategy==\"Mana\" and s.role==\"T1\" then\n   local x,z=polar(math.pi,7)\n   s.point(x,z,\"Face Pandora north\",\"t:prepare\",nil,true)\n  end\n  return\n end\n local light=s.firstWing==\"light\"\n local offset=(light and 1 or -1)*math.pi/3\n if role==\"T\" then\n  if s.cleaves>=2 then return end\n  local first=s.role==\"T1\"\n  local angle,radius\n  if s.cleaves==0 then\n   if strategy==\"Mana\" and first then angle,radius=math.pi,7\n   elseif strategy==\"Mana\" then angle,radius=light and math.pi/3 or -math.pi/3,light and 19 or 2\n   elseif first then angle,radius=2*offset,7\n   elseif light then angle,radius=0.75*offset,19\n   else angle,radius=0,2 end\n  elseif first then angle,radius=math.pi,light and 2 or 19\n  else angle,radius=offset,7 end\n  local x,z=polar(angle,radius);s.point(x,z,\"Wing tank bait\",\"t:\"..s.cleaves,nil,true);return\n end\n if role==\"H\" then\n  if s.cleaves<2 then\n   local x,z=polar(math.pi,light and 7 or 5);s.point(x,z,\"Healers north\",\"h:1\",nil)\n  end\n  return\n end\n local east\n if strategy==\"Mana\" then\n  if s.cleaves==0 then\n   local x,z=polar(light and math.pi/2 or -math.pi/2,light and 7 or 8)\n   s.point(x,z,\"Bait on safe flank\",\"d:mana:wait\",nil)\n   return\n  end\n  east=(role==\"R\")==light\n elseif strategy==\"Elemental\" then east=role==\"M\"\n else east=s.role:sub(2)==\"2\" end\n if s.cleaves==0 then\n  local x,z=polar((east and 1 or -1)*40*math.pi/180,light and 5 or 7)\n  s.point(x,z,\"Wait for first cleave\",\"d:wait:\"..tostring(east),nil);return\n end\n local chosen\n for _,tower in ipairs(s.towers) do\n  if tower.index~=s.towers[1].index then\n   local side=(tower.x-100)*math.cos(south)-(tower.z-100)*math.sin(south)\n   if (side>0)==east then chosen=tower;break end\n  end\n end\n if not chosen or chosen.resolved then return end\n local x,z=s.safeTowerPoint(chosen.x,chosen.z)\n if x then s.point(x,z,\"DPS tower\",\"d:tower:\"..chosen.index,nil,true)end\nend\nfunction s.solve()\n s.destination=nil\n s.updateWings()\n if not s.ready then return end\n if s.northResetAt and (s.stage==\"paradise\" or s.stage==\"idle\") and s.role:sub(1,1)==\"T\" then\n  local boss=TensorCore.mGetEntity(s.bossID)\n  if not boss or not boss.pos or not boss.hitradius or boss.hitradius<=.5 then return end\n  s.point(boss.pos.x,boss.pos.z-math.min(5,boss.hitradius-.5),\"Face Pandora north\",\"t:north\",nil,true)\n  return\n end\n if s.stage==\"fulgent\" then\n  if s.akh and s.waves>6 then\n   local boss=TensorCore.mGetEntity(s.bossID)\n   if not boss or not boss.pos then return end\n   if not s.stackPoint then\n    local radius=boss.hitradius\n    if not radius or radius<=0 or not boss.pos.h then return end\n    local side=s.role:sub(2)==\"1\" and -1 or 1\n    local h=boss.pos.h\n    s.stackPoint={x=boss.pos.x+radius*math.sin(h+side*math.pi/4),z=boss.pos.z+radius*math.cos(h+side*math.pi/4),origin={pos={x=boss.pos.x+radius*math.sin(h),y=boss.pos.y,z=boss.pos.z+radius*math.cos(h)}}}\n   end\n   s.point(s.stackPoint.x,s.stackPoint.z,\"Akh Morn stack\",\"akh:fixed:\"..s.role,nil,true)\n   s.guideOwner.arrowOrigin=s.stackPoint.origin\n  elseif s.waves<=6 then s.fulgent() end\n elseif s.stage==\"paradise\" then s.paradise()\n elseif s.stage==\"polar\" then\n  if s.round>=4 then s.clear();return end\n  local x,z\n  if s.aftershock then x,z=s.bossPoint(math.pi,9)\n  else\n   local order=({T=0,M=1,R=2,H=3})[s.role:sub(1,1)]\n   local left=s.role:sub(2)==\"1\"\n   if s.round>order then left=not left end\n   local radius=s.round==order and 5 or 9.5\n   local boss=TensorCore.mGetEntity(s.bossID)\n   local me=TensorCore.mGetPlayer()\n   if not boss or not boss.pos or not me or not me.pos then return end\n   if s.round~=order and (TensorCore.hasBuff(me,2941) or TensorCore.hasBuff(me,4164) or TensorCore.hasBuff(me,3323)) then\n    local sign=left and 1 or -1\n    local h=boss.pos.h\n    local dx,dz=me.pos.x-boss.pos.x,me.pos.z-boss.pos.z\n    if (dx*math.cos(h)-dz*math.sin(h))*sign>0 then\n     local own=math.sqrt(dx*dx+dz*dz)\n     local nearest\n     for _,record in pairs(s.records)do\n      if record.id~=me.id then\n       local actor=TensorCore.mGetEntity(record.id)\n       if actor and actor.pos and actor.hp.current>0 then\n        local ax,az=actor.pos.x-boss.pos.x,actor.pos.z-boss.pos.z\n        if (ax*math.cos(h)-az*math.sin(h))*sign>0 then\n         local distance=math.sqrt(ax*ax+az*az)\n         nearest=nearest and math.min(nearest,distance) or distance\n        end\n       end\n      end\n     end\n     if not nearest then return end\n     if nearest>=own-.5 then\n      radius=math.max(radius,nearest+1)\n      if radius>19 then return end\n     end\n    end\n   end\n   x,z=s.bossPoint((left and 1 or -1)*3*math.pi/4,radius)\n  end\n  s.point(x,z,s.aftershock and \"Dodge aftershock\" or \"Polarizing line\",\"p:\"..s.round..\":\"..tostring(s.aftershock),nil,not s.aftershock)\n end\nend\ns.bossID=eventArgs.entityID\ns.capture()\nself.used=true",
							conditions = 
							{
								
								{
									"c6544c24-1331-a2cb-b8d5-6861faee9c4d",
									true,
								},
							},
							name = "Start Fulgent",
							uuid = "0df59873-e189-6171-a6ea-455c226623a4",
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
							name = "P5 casts",
							spellIDList = 
							{
								40306,
							},
							uuid = "c6544c24-1331-a2cb-b8d5-6861faee9c4d",
							version = 3,
						},
					},
				},
				displayPath = "P5 Pandora",
				eventType = 3,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Start Fulgent",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "7841ef88-e439-6fa4-9336-52905e35a635",
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
							actionLua = "local s=data.frog_fru_p5\nif not s then self.used=true;return end\nlocal e=eventArgs;local id=e.spellID\nlocal actor=TensorCore.mGetEntity(e.entityID)\nif id==40307 or id==40118 then\n s.addLine(actor)\n if s.stage==\"fulgent\" and not s.fulgentFirstDeadline then s.fulgentFirstDeadline=Now()+eventArgs.channelTimeMax*1000 end\nelseif id==40310 then s.akh=true;s.bossID=e.entityID;s.akhDeadline=Now()+eventArgs.channelTimeMax*1000\nelseif id==40319 then\n s.clear();s.polarDone=nil;s.stage=\"paradise\";s.northResetAt=nil;s.bossID=e.entityID;s.towers={};s.towerHits=0;s.cleaves=0;s.south=nil;s.firstWing=nil;s.wingFirstDeadline=nil;s.wingSecondDeadline=nil\nelseif id==40313 or id==40233 then\n s.wingFirstDeadline=Now()+eventArgs.channelTimeMax*1000+550;s.wingSecondDeadline=s.wingFirstDeadline+3750\n s.clearWings();s.wingAggro=actor and actor.targetid;s.wingCirclesDone={}\n s.firstWing=id==40313 and \"light\" or \"dark\";s.firstTank=s.records.T1 and s.records.T1.id;s.bossID=e.entityID\nelseif id==40316 then\n s.clear();s.polarDone=nil;s.stage=\"polar\";s.northResetAt=nil;s.round=0;s.aftershock=false;s.bossID=e.entityID;s.baitAt=nil;s.afterAt=nil;s.polarFirstDeadline=Now()+eventArgs.channelTimeMax*1000+950\nelseif id==40234 then s.bossID=e.entityID\nelseif id==40326 then s.clear();s.stage=\"idle\"\nend\ns.solve()\nself.used=true\n",
							conditions = 
							{
								
								{
									"377808fb-af56-e605-b386-37e654fef61c",
									true,
								},
							},
							name = "Read casts",
							uuid = "13005fb9-f16f-db41-9109-90b752f91225",
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
							name = "P5 casts",
							spellIDList = 
							{
								40307,
								40118,
								40310,
								40319,
								40313,
								40233,
								40316,
								40234,
								40326,
							},
							uuid = "377808fb-af56-e605-b386-37e654fef61c",
							version = 3,
						},
					},
				},
				displayPath = "P5 Pandora",
				eventType = 3,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Read casts",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "b21053c6-2978-8d45-acab-e2f401ec252a",
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
							actionLua = "local s=data.frog_fru_p5\nif not s then self.used=true;return end\nlocal id=eventArgs.spellID;local now=Now()\nif id==39879 or id==39880 then\n s.wingCirclesDone=s.wingCirclesDone or {};s.wingCirclesDone[id==39879 and 2 or 1]=true\n if s.stage==\"paradise\" and s.cleaves>=2 and s.wingCirclesDone[1] and s.wingCirclesDone[2] then s.northResetAt=now end\nelseif id==40307 or id==40118 or id==40308 or id==40309 then\n if s.stage==\"fulgent\" and (not s.bundleAt or now-s.bundleAt>1000) then s.waves=s.waves+1;s.bundleAt=now end\nelseif id==40311 or id==40312 then\n if s.stage==\"fulgent\" then s.clear();s.stage=\"idle\" end\nelseif id==40314 or id==40315 then\n if s.stage==\"paradise\" and (not s.cleaveAt or now-s.cleaveAt>1000) then if not s.role or (s.role:sub(1,1)~=\"M\" and s.role:sub(1,1)~=\"R\") then s.clear() end;s.cleaves=s.cleaves+1;s.cleaveAt=now end\nelseif id==40320 then\n if s.stage==\"paradise\" then\n  local a=TensorCore.mGetEntity(eventArgs.entityID)\n  if a and a.pos then\n   for _,t in ipairs(s.towers) do\n    if not t.resolved and (t.x-a.pos.x)^2+(t.z-a.pos.z)^2<4 then\n     t.resolved=true;s.towerHits=s.towerHits+1\n     if not s.role or (s.role:sub(1,1)~=\"M\" and s.role:sub(1,1)~=\"R\") or (s.destination and (s.destination.x-t.x)^2+(s.destination.z-t.z)^2<4) then s.clear() end\n     break\n    end\n   end\n  end\n  if s.towerHits>=3 then s.stage=\"idle\";s.clear() end\n end\nelseif id==40317 or id==40318 then\n if s.stage==\"polar\" and (not s.baitAt or now-s.baitAt>1000) then s.clear();s.aftershock=true;s.baitAt=now end\nelseif id==40119 or id==40120 then\n if s.stage==\"polar\" and (not s.afterAt or now-s.afterAt>1000) then\n  s.clear();s.round=s.round+1;s.afterAt=now;s.aftershock=false\n  if s.round>=4 then s.stage=\"idle\";s.polarDone=true;s.polarFirstDeadline=nil;s.baitAt=nil;s.afterAt=nil;s.northResetAt=nil;s.clear() end\n end\nend\ns.solve()\nself.used=true\n",
							conditions = 
							{
								
								{
									"04bdb376-0756-edc5-a0f1-bb60ac40a181",
									true,
								},
							},
							name = "Advance steps",
							uuid = "f8e0af4f-6cd8-2307-9323-c5d552c0e59d",
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
							name = "P5 casts",
							spellIDList = 
							{
								40307,
								40118,
								40308,
								40309,
								40311,
								40312,
								40314,
								40315,
								40320,
								40317,
								40318,
								40119,
								40120,
								39879,
								39880,
							},
							uuid = "04bdb376-0756-edc5-a0f1-bb60ac40a181",
							version = 3,
						},
					},
				},
				displayPath = "P5 Pandora",
				eventType = 2,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Advance steps",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "4ed0219a-6c4e-e5a6-8851-aea392aef146",
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
							actionLua = "local s=data.frog_fru_p5\nlocal e=eventArgs\nif not s or s.stage~=\"paradise\" or e.a1<51 or e.a1>53 or e.a2~=1 or e.a3~=2 then self.used=true;return end\nfor _,t in ipairs(s.towers) do if t.index==e.a1 then self.used=true;return end end\nlocal a=({[51]=-120,[52]=120,[53]=0})[e.a1]*math.pi/180\nlocal t={spawned=Now(),deadline=Now()+9500,index=e.a1,x=100+7*math.sin(a),z=100+7*math.cos(a)}\ns.towers[#s.towers+1]=t\nif #s.towers==1 then s.south=a end\ns.solve()\nself.used=true\n",
							name = "Read towers",
							uuid = "dbf0024d-bf91-9cab-a414-a830b891443e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				eventType = 14,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Read towers",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "4b5a5d67-51d9-2dbc-a013-59b2862b22a5",
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
							actionLua = "local s=data.frog_fru_p5\nif not s then self.used=true;return end\nlocal now=Now()\nif now<s.start or now-s.start>110000 then s.clear();if s.clearWings then s.clearWings() end;data.frog_fru_p5=nil;self.used=true;return end\nif not s.ready and now>=s.nextRoster then s.capture();s.nextRoster=now+1000 end\nif (FrogFRUDrawSettings or {}).p5==false or (FrogFRUDrawSettings or {}).p5Mode==\"Disabled\" then s.clear();if s.clearWings then s.clearWings() end\nelse s.solve() end\nself.used=true\n",
							name = "Solve positions",
							uuid = "552f1b1d-fac7-a361-ab42-85ef15e25f9f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Solve positions",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "c6a41ee7-fb19-15bf-aee0-9e2a67aa6242",
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
							actionLua = "local s=data.frog_fru_p5\nlocal settings=FrogFRUDrawSettings\nif s and s.towerOffsetVersion~=3 then\nfunction s.safeTowerPoint(x,z)\n if s.towerOffsetSource~=s.towers or s.towerOffsetDeadline~=s.wingFirstDeadline or s.towerBiasGeometry~=3 then\n  s.towerBiasGeometry=3;s.towerOffsetSource=s.towers;s.towerOffsetDeadline=s.wingFirstDeadline;s.towerOffsets={}\n end\n local key=tostring(x)..\":\"..tostring(z)\n local saved=s.towerOffsets[key]\n if s.cleaves>=2 and saved then return saved.x,saved.z end\n if not s.firstWing then return x,z end\n local phase=math.min(s.cleaves,1)\n local boss=TensorCore.mGetEntity(s.bossID)\n local id=phase==0 and s.wingAggro or boss and boss.targetid\n local target=id and TensorCore.mGetEntity(id)\n if not boss or not boss.pos or not target or not target.pos then\n  if saved and saved.phase==phase then return saved.x,saved.z end\n  return\n end\n local light=(phase==0)==(s.firstWing==\"light\")\n local h=math.atan2(target.pos.x-boss.pos.x,target.pos.z-boss.pos.z)+(light and 1 or -1)*3*math.pi/8+math.pi\n local dx,dz=x-boss.pos.x,z-boss.pos.z\n local radius=math.sqrt(dx*dx+dz*dz)\n if radius<.01 then return end\n local vx,vz=dx/radius+math.sin(h),dz/radius+math.cos(h)\n local length=math.sqrt(vx*vx+vz*vz)\n if length<.01 then return end\n local px,pz=x+2*vx/length,z+2*vz/length\n s.towerOffsets[key]={x=px,z=pz,phase=phase}\n return px,pz\nend\n s.towerOffsetVersion=3\n s.solve()\nend\nif not settings or not settings.guide then self.used=true;return end\nlocal p=TensorCore.mGetPlayer()\nif not s or not s.destination or not s.guideOwner or settings.p5==false or not p or not p.pos or p.hp.current<=0 then\n settings.release(data,\"frog_fru_p5\");self.used=true;return\nend\nif s.polarDone and (s.stage==\"idle\" or s.stage==\"polar\")then s.clear();self.used=true;return end\nif s.stage==\"polar\" then s.guideOwner.arrowHoldAfterDeadline=false end\nlocal style=s.stage==\"paradise\" and \"p5_paradise\" or s.stage==\"polar\" and \"p5_polar\" or \"p5_fulgent\"\nlocal t=s.destination\nlocal origin=settings.styleFor(style)==\"Arrow\" and s.guideOwner.arrowOrigin or p\nsettings.guide(data,\"frog_fru_p5\",style,s.guideOwner,origin or p,t.x,t.y,t.z,t.label,nil,6)\nself.used=true",
							name = "Personal tether",
							uuid = "f888caa5-c027-778f-890a-7425b6281269",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				eventType = 12,
				mechanicTime = 984.8,
				name = "[P5] Personal tether",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 290,
				timerStartOffset = -10,
				uuid = "b0c52bd8-3db8-f661-aa86-74209a93db49",
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
							actionLua = "data.frog_fru_arrow_casts=nil\nlocal s=data.frog_fru_p5\nif s and s.clear then s.clear() end\nif s and s.clearWings then s.clearWings() end\ndata.frog_fru_p5=nil\nself.used=true\n",
							name = "Clear on wipe",
							uuid = "6838d94b-2b3b-fa70-8664-fae04176a7ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				eventType = 9,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Clear on wipe",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 1800,
				timerStartOffset = -2000,
				uuid = "6edcf768-970d-50bc-b5c2-fb6f5d2e3631",
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
							actionLua = "data.frog_fru_arrow_casts=nil\nlocal s=data.frog_fru_p5\nif s and s.clear then s.clear() end\nif s and s.clearWings then s.clearWings() end\ndata.frog_fru_p5=nil\nself.used=true\n",
							name = "Clear on map",
							uuid = "3da349db-f2b0-c4c5-8957-69ca5d2a3152",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				eventType = 11,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Clear on map",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 1800,
				timerStartOffset = -2000,
				uuid = "2d72dfb5-aedc-8b74-983d-f235e5a6d80c",
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
							actionLua = "data.frog_fru_arrow_casts=nil\nlocal s=data.frog_fru_p5\nif s and s.clear then s.clear() end\nif s and s.clearWings then s.clearWings() end\ndata.frog_fru_p5=nil\nself.used=true\n",
							name = "Clear on countdown",
							uuid = "01242a61-bbcc-60f9-92e2-46c20873d612",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "P5 Pandora",
				eventType = 16,
				loop = true,
				mechanicTime = 984.8,
				name = "[P5] Clear on countdown",
				timeRange = true,
				timelineIndex = 209,
				timerEndOffset = 1800,
				timerStartOffset = -2000,
				uuid = "490f3e62-237c-b771-a478-55556c12e312",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "fru",
	version = "1.0.5",
}



return tbl