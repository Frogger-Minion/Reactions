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
							actionLua = "if data.frog_draw_settings == nil or data.frog_draw_settings.version~=44 then\n local p={\n  version=44,\n  path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]],\n  default=\"R1 H1 M1 MT OT M2 H2 R2\",\n  styleItems={\"Tether\",\"Arrow\",\"Disabled\"},\n  brightCones=true,brightSide=\"Roster\",skyblindMode=\"Personal\",\n  styleRows={\n   {\"p1_playstation\",\"P1 PlayStation\"},{\"p1_brightwing\",\"Vault & Rewind cleaves\"},{\"p2_strength\",\"P2 Strength\"},\n   {\"p2_sanctity\",\"P2 Sanctity\"},{\"p3_dfg\",\"P3 Dive from Grace\"},{\"p3_enum\",\"P3 Enumeration\"},\n   {\"p4_eyes\",\"P4 Eyes\"},{\"p5_wrath\",\"P5 Wrath\"},{\"p5_doth\",\"P5 DOTH\"},{\"p6_vow\",\"P6 Mortal Vow\"},{\"p6_hw_party\",\"P6 Wings party\"},{\"p6_hw_tank\",\"P6 Wings tank\"},{\"p6_wb1\",\"P6 Wyrmsbreath 1\"},{\"p6_wb2\",\"P6 Wyrmsbreath 2\"},{\"p6_cauterize\",\"P6 Double Cauterize\"},\n   {\"p7_trinity\",\"P7 Trinity\"},{\"p7_akh\",\"P7 Akh Morn\"},{\"p7_giga\",\"P7 Gigaflare\"}\n  },\n  styles={},\n  wb1Anchors={\"H1\",\"M1\",\"H2\"},wb1Flex={\"R1\",\"M2\",\"R2\"},\n  wb2Default=\"H1 R1 M1 M2 H2 R2\",wb2Edit=\"H1 R1 M1 M2 H2 R2\",\n  wb1Roles={\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"},wb2R1North=false,\n  cautMT=\"Nidhogg\",\n  cautItems={\"Nidhogg\",\"Hraesvelgr\",\"Fixed West\",\"Fixed East\"},\n  cautOpposite={\"Hraesvelgr\",\"Nidhogg\",\"Fixed East\",\"Fixed West\"},\n  autoOrderDefault=\"M R H\",\n  autoOrderEdit=\"M R H\",\n  elementDraws=true,\n  akhStrategy=\"6-1-1\",\n  akhStrategyItems={\"6-1-1\",\"3-3-2\"},\n  autoMode=\"Personal\",\n  autoModeItems={\"Personal\",\"Shotcaller\",\"Disabled\"},\n  dothMode=\"Configured conga\",\n  dothModeItems={\"Configured conga\",\"Live positions\"},\n  akhAfahHP=false,dragonHP=true,\n  vowTTSMode=\"Personal\",\n  vowDefault=\"T T M R\",\n  vowEdit=\"T T M R\",\n  vowGroups={T={\"MT\",\"OT\"},M={\"M1\",\"M2\"},R={\"R1\",\"R2\"}},\n  strategyItems={\"Westhogg\",\"Easthogg\"},\n  strategy=\"NAUR\",\n  eyesStrategy=\"Square\",\n  holdItems={\"On\",\"Off\"},\n  customHold=false,\n  roles={MT=true,OT=true,H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n }\n function p.parse(text)\n  if type(text)~=\"string\" then return nil,\"Enter all eight roles.\" end\n  local order,seen={},{}\n  for role in string.upper(text):gmatch(\"[^%s,]+\") do\n   if not p.roles[role] then return nil,\"Unknown role: \"..role end\n   if seen[role] then return nil,\"Duplicate role: \"..role end\n   seen[role]=true; order[#order+1]=role\n  end\n  if #order~=8 then return nil,\"Enter each of MT OT H1 H2 M1 M2 R1 R2 once.\" end\n  return order,table.concat(order,\" \")\n end\n function p.parseVow(text)\n  local order={}\n  for token in string.upper(text or \"\"):gmatch(\"[^%s,]+\") do\n   if not p.vowGroups[token] then return nil,\"Vow order uses T, M or R. Healers cannot receive.\" end\n   order[#order+1]=token\n  end\n  if #order~=4 then return nil,\"Enter four Vow passes.\" end\n  for _,initial in ipairs({\"M1\",\"M2\",\"R1\",\"R2\"}) do\n   local used={[initial]=true}\n   for _,token in ipairs(order) do\n    local chosen\n    for _,role in ipairs(p.vowGroups[token]) do\n     if not used[role] then chosen=role; break end\n    end\n    if not chosen then return nil,\"Vow order runs out of eligible receivers.\" end\n    used[chosen]=true\n   end\n  end\n  return order,table.concat(order,\" \")\n end\n function p.parseAuto(text)\n  if type(text)~=\"string\" then return nil,\"Auto order uses M, R and H once each.\" end\n  local compact=string.upper(text):gsub(\"[%s,]\",\"\")\n  if #compact~=3 then return nil,\"Enter M, R and H once each.\" end\n  local order,seen={},{}\n  for token in compact:gmatch(\".\") do\n   if token~=\"M\" and token~=\"R\" and token~=\"H\" then return nil,\"Auto order only accepts M, R and H.\" end\n   if seen[token] then return nil,\"Duplicate auto role: \"..token end\n   seen[token]=true; order[#order+1]=token\n  end\n  return order,table.concat(order,\" \")\n end\n function p.validatePairs(text)\n  local roles,seen={},{}\n  for role in (text or \"\"):gmatch(\"%S+\") do\n   if not (role==\"H1\" or role==\"H2\" or role==\"M1\" or role==\"M2\" or role==\"R1\" or role==\"R2\") or seen[role] then return nil,\"Each WB1 role must appear once.\" end\n   seen[role]=true;roles[#roles+1]=role\n  end\n  if #roles~=6 then return nil,\"Assign three anchor/flex pairs.\" end\n  return roles\n end\n function p.lineupPoints(roles)\n  local roster=AnyoneCore and AnyoneCore.Roster\n  if not roster or not roster.isReady() then return nil,\"Set the AnyoneCore roster first.\" end\n  local members=roster.members();local party=AnyoneCore.API.getAgnosticPartyList()\n  if type(members)~=\"table\" or type(party)~=\"table\" then return nil,\"Party roster unavailable.\" end\n  local slots={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}\n  local points,used={},{}\n  local cx,cz=0,0\n  for _,role in ipairs(roles)do\n   local member=members[slots[role]]\n   if not member then return nil,\"Missing roster role: \"..role end\n   local candidate,count=nil,0\n   for _,a in pairs(party)do\n    if a.name==member.name and a.job==member.job then candidate=a;count=count+1 end\n   end\n   if count==0 then\n    local sameJob=0;for _,m in pairs(members)do if m.job==member.job then sameJob=sameJob+1 end end\n    if sameJob==1 then for _,a in pairs(party)do if a.job==member.job then candidate=a;count=count+1 end end end\n   end\n   if count~=1 or used[candidate.id] then return nil,\"Cannot uniquely match \"..role..\" to the party.\" end\n   local actor=TensorCore.mGetEntity(candidate.id)\n   if not actor or not actor.alive then return nil,\"All lineup players must be present and alive.\" end\n   used[actor.id]=true\n   points[#points+1]={role=role,x=actor.pos.x,z=actor.pos.z};cx=cx+actor.pos.x;cz=cz+actor.pos.z\n  end\n  return points\n end\n function p.captureLineup(roles)\n  local points,message=p.lineupPoints(roles)\n  if not points then return nil,message end\n  local cx,cz=0,0\n  for _,v in ipairs(points)do cx=cx+v.x;cz=cz+v.z end\n  cx=cx/#points;cz=cz/#points\n  local xx,xz,zz=0,0,0\n  for _,v in ipairs(points)do local x,z=v.x-cx,v.z-cz;xx=xx+x*x;xz=xz+x*z;zz=zz+z*z end\n  local h=0.5*math.atan2(2*xz,xx-zz)\n  local ux,uz=math.cos(h),math.sin(h)\n  local eastWest=math.abs(ux)>=math.abs(uz)\n  if (eastWest and ux<0) or (not eastWest and uz<0)then ux=-ux;uz=-uz end\n  local width=0\n  for _,v in ipairs(points)do\n   v.rank=(v.x-cx)*ux+(v.z-cz)*uz\n   width=math.max(width,math.abs((v.x-cx)*uz-(v.z-cz)*ux))\n  end\n  table.sort(points,function(a,b)return a.rank<b.rank end)\n  if width>3 then return nil,\"Form a single lineup before capturing.\" end\n  local order={}\n  for i,v in ipairs(points)do\n   if i>1 and v.rank-points[i-1].rank<0.3 then return nil,\"Lineup overlaps; separate the players or drag the boxes.\" end\n   order[i]=v.role\n  end\n  return order,eastWest and \"Captured W to E. Reverse if needed.\" or \"Captured N to S. Reverse if needed.\"\n end\n function p.captureDOTH()\n  local points,message=p.lineupPoints({\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})\n  if not points then return nil,message end\n  table.sort(points,function(a,b)return a.x<b.x end)\n  local order={}\n  for i,v in ipairs(points)do\n   if i>1 and v.x-points[i-1].x<0.3 then return nil,\"Separate players west to east before capturing DOTH.\" end\n   order[i]=v.role\n  end\n  return order,\"Captured DOTH west to east.\"\n end\n function p.captureWB1()\n  local points,message=p.lineupPoints(p.wb1Roles)\n  if not points then return nil,message end\n  local marks={}\n  for i=1,8 do\n   local x,y,z,active=Argus.getWaymarkInfo(i)\n   if active then\n    local near={}\n    for _,v in ipairs(points)do near[#near+1]={role=v.role,d=(v.x-x)^2+(v.z-z)^2}end\n    table.sort(near,function(a,b)return a.d<b.d end)\n    if near[2].d<=36 and near[2].d-near[1].d>=0.25 then\n     marks[#marks+1]={x=x,z=z,anchor=near[1].role,flex=near[2].role,cost=near[1].d+near[2].d}\n    end\n   end\n  end\n  local best,second,chosen=math.huge,math.huge,nil\n  for a=1,#marks-2 do for b=a+1,#marks-1 do for c=b+1,#marks do\n   local tri={marks[a],marks[b],marks[c]}\n   local area=math.abs((tri[2].x-tri[1].x)*(tri[3].z-tri[1].z)-(tri[3].x-tri[1].x)*(tri[2].z-tri[1].z))\n   local used,valid,cost={},area>2,0\n   for _,m in ipairs(tri)do\n    if used[m.anchor] or used[m.flex]then valid=false end\n    used[m.anchor]=true;used[m.flex]=true;cost=cost+m.cost\n   end\n   if valid then\n    if cost<best then second=best;best=cost;chosen=tri elseif cost<second then second=cost end\n   end\n  end end end\n  if not chosen or second-best<0.25 then return nil,\"Stand in three clear anchor/flex pairs beside the triangle markers.\" end\n  table.sort(chosen,function(a,b)return a.x<b.x end)\n  if chosen[2].x-chosen[1].x<1 or chosen[3].x-chosen[2].x<1 then return nil,\"The three WB1 markers must define left, middle and right.\" end\n  local order={}\n  for _,m in ipairs(chosen)do order[#order+1]=m.anchor;order[#order+1]=m.flex end\n  return order,\"Captured closest anchor and second-closest flex at each triangle marker.\"\n end\n function p.save(text)\n  local order,normalized=p.parse(text)\n  if not order then p.message=normalized; return false end\n  local vowOrder,vowText=p.parseVow(p.vowEdit)\n  if not vowOrder then p.message=vowText; return false end\n  local autoOrder,autoText=p.parseAuto(p.autoOrderEdit)\n  if not autoOrder then p.message=autoText; return false end\n  local pairText=table.concat({p.wb1Anchors[1],p.wb1Flex[1],p.wb1Anchors[2],p.wb1Flex[2],p.wb1Anchors[3],p.wb1Flex[3]},\" \")\n  local pairsOK,pairError=p.validatePairs(pairText)\n  if not pairsOK then p.message=pairError;return false end\n  local wb2=p.validatePairs(p.wb2Edit)\n  if not wb2 then p.message=\"WB2 requires each non-tank role once.\";return false end\n  local wb2Text=table.concat(wb2,\" \")\n  local nextSettings={}\n  for k,v in pairs(p.settings) do nextSettings[k]=v end\n  nextSettings.p6_vow_melee=p.vowMelee or \"M1\"\n  nextSettings.p6_hw_wall=p.hwWall or \"T1\"\n  nextSettings.p6_hw_north=p.hwNorth or \"T1\"\n  nextSettings.p6_wb1_pairs=pairText\n  nextSettings.p6_wb2_r1_north=p.wb2R1North\n  nextSettings.p6_wb2_order=wb2Text\n  nextSettings.p6_wb2_strategy=p.wb2Strategy or \"Static\"\n  nextSettings.doth_conga=normalized\n  nextSettings.doth_order_mode=p.dothMode==\"Live positions\" and \"Live positions\" or \"Configured conga\"\n  nextSettings.vow_pass_order=vowText\n  nextSettings.p6_vow_tts_mode=p.vowTTSMode\n  nextSettings.p6_akh_afah_hp=p.akhAfahHP\n  nextSettings.p6_dragon_hp_window=p.dragonHP\n  nextSettings.p4_eyes_strategy=p.eyesStrategy==\"Trapezoid\" and \"Trapezoid\" or \"Square\"\n  nextSettings.p1_brightwing_cones=p.brightCones\n  nextSettings.p1_brightwing_side=p.brightSide\n  nextSettings.p1_skyblind_mode=p.skyblindMode\n  nextSettings.p3_custom_hold=p.customHold\n  nextSettings.p3_strategy=p.strategy==\"LPDU\" and \"LPDU\" or \"NAUR\"\n  nextSettings.p7_element_draws=p.elementDraws\n  nextSettings.p7_akh_strategy=p.akhStrategy==\"3-3-2\" and \"3-3-2\" or \"6-1-1\"\n  nextSettings.p7_auto_order=autoText\n  nextSettings.p7_auto_mode=p.autoMode\n  nextSettings.p6_cauterize_mt=p.cautMT\n  nextSettings.draw_styles={}\n  for _,row in ipairs(p.styleRows) do\n   local choice=p.styles[row[1]]\n   nextSettings.draw_styles[row[1]]=choice==\"Disabled\" and \"Disabled\" or choice==\"Arrow\" and \"Arrow\" or \"Tether\"\n  end\n  local ok,err=pcall(FileSave,p.path,nextSettings)\n  local readOK,saved=pcall(FileLoad,p.path)\n  local stylesOK=readOK and type(saved)==\"table\" and type(saved.draw_styles)==\"table\"\n  if stylesOK then\n   for _,row in ipairs(p.styleRows) do\n    if saved.draw_styles[row[1]]~=nextSettings.draw_styles[row[1]] then stylesOK=false break end\n   end\n  end\n  if not ok or not readOK or (type(saved)==\"table\" and (saved.p6_wb1_pairs~=pairText or saved.p6_wb2_r1_north~=p.wb2R1North)) or type(saved)~=\"table\" or saved.doth_conga~=normalized or saved.p6_wb2_order~=wb2Text or saved.doth_order_mode~=nextSettings.doth_order_mode or saved.p7_element_draws~=nextSettings.p7_element_draws or saved.p7_akh_strategy~=nextSettings.p7_akh_strategy or saved.p7_auto_order~=autoText or saved.p7_auto_mode~=nextSettings.p7_auto_mode or saved.p6_cauterize_mt~=nextSettings.p6_cauterize_mt or not stylesOK or saved.p3_strategy~=nextSettings.p3_strategy or saved.p3_custom_hold~=nextSettings.p3_custom_hold or saved.p1_brightwing_cones~=nextSettings.p1_brightwing_cones or saved.p1_brightwing_side~=nextSettings.p1_brightwing_side or saved.p1_skyblind_mode~=nextSettings.p1_skyblind_mode or saved.p4_eyes_strategy~=nextSettings.p4_eyes_strategy or saved.vow_pass_order~=vowText or saved.p6_vow_tts_mode~=nextSettings.p6_vow_tts_mode or saved.p6_akh_afah_hp~=nextSettings.p6_akh_afah_hp or saved.p6_dragon_hp_window~=nextSettings.p6_dragon_hp_window or saved.p6_hw_wall~=nextSettings.p6_hw_wall or saved.p6_hw_north~=nextSettings.p6_hw_north or saved.p6_wb2_strategy~=nextSettings.p6_wb2_strategy or saved.p6_vow_melee~=nextSettings.p6_vow_melee then\n   p.message=\"Save failed: \"..tostring(err or saved); return false\n  end\n  p.settings=nextSettings\n  if not p.elementDraws then\n   local element=data.frog_p7_element\n   if element and element.draw then Argus.deleteTimedShape(element.draw); element.draw=nil end\n  end\n  p.autoOrderEdit=autoText\n  p.vowEdit=vowText\n  p.order,p.saved,p.edit=order,normalized,normalized\n  p.message=\"Saved.\"\n  return true\n end\n p.order,p.saved=p.parse(p.default)\n p.edit=p.saved\n p.settings={}\n if FileExists(p.path) then\n  local ok,settings=pcall(FileLoad,p.path)\n  local order,normalized\n  if ok and type(settings)==\"table\" then\n   p.settings=settings\n   order,normalized=p.parse(settings.doth_conga)\n  end\n  if order then p.order,p.saved,p.edit=order,normalized,normalized\n  else p.message=\"Invalid settings file; using defaults. Apply to repair.\" end\n else\n  local previous=data.frog_draw_settings\n  p.save(previous and previous.saved or p.default)\n end\n for _,row in ipairs(p.styleRows) do\n  local styles=p.settings.draw_styles\n  local choice=type(styles)==\"table\" and styles[row[1]]\n  p.styles[row[1]]=choice==\"Disabled\" and \"Disabled\" or choice==\"Arrow\" and \"Arrow\" or \"Tether\"\n end\n local pairRoles=p.validatePairs(p.settings.p6_wb1_pairs or \"H1 R1 M1 M2 H2 R2\")\n if pairRoles then for lane=1,3 do p.wb1Anchors[lane]=pairRoles[lane*2-1];p.wb1Flex[lane]=pairRoles[lane*2] end end\n p.vowMelee=p.settings.p6_vow_melee==\"M2\" and \"M2\" or \"M1\"\n p.hwWall=p.settings.p6_hw_wall==\"T2\" and \"T2\" or \"T1\"\n p.hwNorth=p.settings.p6_hw_north==\"T2\" and \"T2\" or \"T1\"\n p.wb2Strategy=p.settings.p6_wb2_strategy==\"5-1\" and \"5-1\" or \"Static\"\n p.wb2R1North=p.settings.p6_wb2_r1_north==true\n local wb2=p.validatePairs(p.settings.p6_wb2_order or \"\")\n p.wb2Edit=wb2 and table.concat(wb2,\" \") or (p.wb2R1North and \"H1 R2 M1 M2 H2 R1\" or p.wb2Default)\n local autoOrder,autoText=p.parseAuto(p.settings.p7_auto_order or p.autoOrderDefault)\n p.autoOrderEdit=autoOrder and autoText or p.autoOrderDefault\n if not autoOrder then p.message=\"Invalid auto order; Save to use M R H.\" end\n p.elementDraws=p.settings.p7_element_draws~=false\n p.akhStrategy=p.settings.p7_akh_strategy==\"3-3-2\" and \"3-3-2\" or \"6-1-1\"\n p.autoMode=p.settings.p7_auto_mode==\"Shotcaller\" and \"Shotcaller\" or p.settings.p7_auto_mode==\"Disabled\" and \"Disabled\" or \"Personal\"\n local vowOrder,vowText=p.parseVow(p.settings.vow_pass_order or p.vowDefault)\n p.vowEdit=vowOrder and vowText or p.vowDefault\n p.akhAfahHP=p.settings.p6_akh_afah_hp==true\n p.dragonHP=p.settings.p6_dragon_hp_window~=false\n p.vowTTSMode=p.settings.p6_vow_tts_mode==\"Shotcaller\" and \"Shotcaller\" or p.settings.p6_vow_tts_mode==\"Disabled\" and \"Disabled\" or \"Personal\"\n if not vowOrder then p.message=\"Invalid Vow order; Save to use T T M R.\" end\n p.strategy=p.settings.p3_strategy==\"LPDU\" and \"LPDU\" or \"NAUR\"\n p.eyesStrategy=p.settings.p4_eyes_strategy==\"Trapezoid\" and \"Trapezoid\" or \"Square\"\n p.brightCones=p.settings.p1_brightwing_cones~=false\n p.brightSide=p.settings.p1_brightwing_side==\"Left\"and \"Left\"or p.settings.p1_brightwing_side==\"Right\"and \"Right\"or \"Roster\"\n p.skyblindMode=p.settings.p1_skyblind_mode==\"Shotcaller\"and \"Shotcaller\"or p.settings.p1_skyblind_mode==\"Disabled\"and \"Disabled\"or \"Personal\"\n p.customHold=p.settings.p3_custom_hold==true\n p.dothMode=p.settings.doth_order_mode==\"Live positions\" and \"Live positions\" or \"Configured conga\"\n for _,value in ipairs(p.cautItems) do\n  if p.settings.p6_cauterize_mt==value then p.cautMT=value; break end\n end\n local previous=data.frog_draw_settings\n if previous then\n  for _,key in ipairs({\"edit\",\"vowEdit\",\"autoOrderEdit\",\"elementDraws\",\"akhStrategy\",\"autoMode\",\"strategy\",\"eyesStrategy\",\"brightCones\",\"brightSide\",\"skyblindMode\",\"customHold\",\"dothMode\",\"cautMT\",\"vowTTSMode\",\"akhAfahHP\",\"dragonHP\",\"vowMelee\",\"hwWall\",\"hwNorth\",\"wb1Anchors\",\"wb1Flex\",\"wb2Strategy\",\"wb2R1North\",\"wb2Edit\",\"message\"}) do\n   if previous[key]~=nil then p[key]=previous[key] end\n  end\n  for _,row in ipairs(p.styleRows) do\n   if previous.styles and previous.styles[row[1]] then p.styles[row[1]]=previous.styles[row[1]] end\n  end\n end\n data.frog_draw_settings=p\nend\n\nlocal p=data.frog_draw_settings\nif p.strategyItems[1]~=\"Westhogg\" then\n p.strategyItems[1]=\"Westhogg\"; p.strategyItems[2]=\"Easthogg\"\nend\nlocal visible=GUI:Begin(\"Frog Draws\",nil,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n GUI:TextUnformatted(\"Preset\")\n for i,region in ipairs({\"NA\",\"EU\",\"JP\"}) do\n  GUI:SameLine()\n  if GUI:Button(region..\"##region_preset\") then\n   if region==\"JP\" then\n    p.message=\"JP preset is a placeholder; no settings changed.\"\n   else\n    p.strategy=region==\"NA\" and \"NAUR\" or \"LPDU\"\n    p.eyesStrategy=region==\"NA\" and \"Square\" or \"Trapezoid\"\n    p.wb2Strategy=region==\"EU\" and \"5-1\" or \"Static\"\n    p.cautMT=region==\"EU\" and \"Fixed West\" or \"Nidhogg\"\n    p.wb1Anchors=region==\"EU\" and {\"H1\",\"M1\",\"R1\"} or {\"H1\",\"M1\",\"H2\"}\n    p.wb1Flex=region==\"EU\" and {\"H2\",\"M2\",\"R2\"} or {\"R1\",\"M2\",\"R2\"}\n    p.message=region..\" preset: \"..(region==\"NA\" and \"Westhogg / square Eyes\" or \"Easthogg / trapezoid Eyes\")..\" / WB1 pairs. Unsaved changes\"\n   end\n  end\n  if GUI:IsItemHovered() then GUI:SetTooltip(region==\"JP\" and \"Placeholder; no settings will change.\" or \"Apply \"..region..\" defaults. Save to apply.\") end\n end\n GUI:Separator()\n if GUI:Button(\"Open AnyoneCore roster\") then\n  local popup=AnyoneCore and AnyoneCore.RosterPopup\n  if popup and type(popup.openManual)==\"function\" then\n   local ok,err=pcall(popup.openManual)\n   if not ok then p.message=\"Roster could not open: \"..tostring(err) end\n  else p.message=\"AnyoneCore roster is unavailable\" end\n end\n GUI:Separator()\n local function changed(field,value)\n  if value~=nil and value~=p[field] then p[field]=value; p.message=\"Unsaved changes\" end\n end\n local function choice(id,label,index,items)\n  local selected=GUI:Combo(\"##\"..id,index,items)\n  GUI:SameLine(); GUI:TextUnformatted(label)\n  return selected\n end\n local function style(key,label)\n  local value=p.styles[key]\n  local index=value==\"Disabled\" and 3 or value==\"Arrow\" and 2 or 1\n  local selected=choice(key,label,index,p.styleItems)\n  local valueNew=p.styleItems[selected]\n  if valueNew and valueNew~=value then p.styles[key]=valueNew; p.message=\"Unsaved changes\" end\n end\n local function order(field,id,label,width,default)\n  GUI:PushItemWidth(width)\n  changed(field,GUI:InputText(\"##\"..id,p[field]))\n  GUI:PopItemWidth()\n  GUI:SameLine(); GUI:TextUnformatted(label)\n  if GUI:Button(\"Reset##\"..id) then changed(field,default) end\n end\n local function lineup(id,text,defaults,valid)\n  p.lineupWidgets=p.lineupWidgets or {}\n  local w=p.lineupWidgets[id]\n  if not w or w.text~=text then\n   local values=valid(text)\n   if not values then values=valid(defaults)end\n   w={text=text,values=values};p.lineupWidgets[id]=w\n  end\n  local captured=false;local changedOrder=false;local note\n  if GUI:Button(\"Capture lineup##\"..id)then\n   local expected=valid(defaults)\n   local values,message\n   if id==\"wb1\"then values,message=p.captureWB1()elseif id==\"doth\"then values,message=p.captureDOTH()else values,message=p.captureLineup(expected)end\n   if values then w.values=values;captured=true;changedOrder=true;note=message else p.message=message end\n  end\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Capture the live lineup. DOTH: west to east. Drag onto a box centre to swap; use its left/right edge to insert before/after.\")end\n  GUI:SameLine()\n  if GUI:Button(\"Reverse##\"..id)then\n   local values=w.values\n   for i=1,math.floor(#values/2)do values[i],values[#values-i+1]=values[#values-i+1],values[i]end\n   changedOrder=true\n  end\n  local drop\n  for i,role in ipairs(w.values)do\n   local label=role\n   local width=36\n   if id==\"wb1\"then\n    if i%2==1 then\n     GUI:Separator()\n     GUI:TextUnformatted(({\"Left pair\",\"Middle pair\",\"Right pair\"})[math.floor((i+1)/2)])\n    else GUI:SameLine()end\n    label=(i%2==1 and \"Anchor: \" or \"Flex: \")..role\n    width=110\n   elseif id==\"wb2\"then\n    if i%2==1 then GUI:Separator()else GUI:SameLine()end\n    label=({\"North wall: \",\"SW outer: \",\"SW inner: \",\"NE inner: \",\"South wall: \",\"NE outer: \"})[i]..role\n    width=145\n   elseif i>1 then GUI:SameLine()end\n   GUI:Button(label..\"##\"..id..\"_\"..role,width,26)\n   if GUI:IsItemClicked(0)then p.lineupDrag={id=id,index=i}end\n   local ax,ay=GUI:GetItemRectMin();local bx,by=GUI:GetItemRectMax()\n   if p.lineupDrag and p.lineupDrag.id==id and GUI:IsMouseHoveringRect(ax,ay,bx,by,true)then\n    drop=i\n    local mx=GUI:GetMousePos()\n    local fraction=(mx-ax)/math.max(1,bx-ax)\n    p.lineupDropMode=fraction<0.25 and \"before\" or fraction>0.75 and \"after\" or \"swap\"\n    GUI:SetTooltip(p.lineupDropMode==\"swap\" and \"Swap with \"..role or (p.lineupDropMode==\"before\" and \"Insert before \" or \"Insert after \")..role)\n   end\n  end\n  if p.lineupDrag and p.lineupDrag.id==id and GUI:IsMouseReleased(0)then\n   local from=p.lineupDrag.index\n   if drop and drop~=from then\n    if p.lineupDropMode==\"swap\"then\n     w.values[from],w.values[drop]=w.values[drop],w.values[from]\n     changedOrder=true\n    else\n     local slot=drop+(p.lineupDropMode==\"after\" and 1 or 0)\n     if from<slot then slot=slot-1 end\n     if slot~=from then table.insert(w.values,slot,table.remove(w.values,from));changedOrder=true end\n    end\n   end\n   p.lineupDrag=nil;p.lineupDropMode=nil\n  end\n  if changedOrder then\n   w.text=table.concat(w.values,\" \")\n   p.message=note or \"Unsaved changes\"\n   return w.text,captured,note\n  end\n  return text,false\n end\n GUI:PushItemWidth(145)\n if GUI:CollapsingHeader(\"Vault & Rewind\") then\n  style(\"p1_playstation\",\"PlayStation\")\n   style(\"p1_brightwing\",\"Brightwing guidance\")\n   local selected=choice(\"p1_brightwing_cones\",\"Brightwing telegraphs\",p.brightCones and 1 or 2,p.holdItems)\n   changed(\"brightCones\",selected==1)\n   selected=choice(\"p1_brightwing_side\",\"Bait side (facing north)\",p.brightSide==\"Left\"and 2 or p.brightSide==\"Right\"and 3 or 1,{\"Roster\",\"Left\",\"Right\"})\n   changed(\"brightSide\",({\"Roster\",\"Left\",\"Right\"})[selected])\n   selected=choice(\"p1_skyblind_mode\",\"Skyblind Move callout\",p.skyblindMode==\"Shotcaller\"and 2 or p.skyblindMode==\"Disabled\"and 3 or 1,p.autoModeItems)\n   changed(\"skyblindMode\",p.autoModeItems[selected])\n end\n if GUI:CollapsingHeader(\"P2 - Thordan\") then\n  style(\"p2_strength\",\"Strength\")\n  style(\"p2_sanctity\",\"Sanctity\")\n end\n if GUI:CollapsingHeader(\"P3 - Nidhogg\") then\n  style(\"p3_dfg\",\"Dive from Grace\")\n   style(\"p3_enum\",\"Enumeration towers\")\n  local selected=choice(\"p3_strategy\",\"Strategy\",p.strategy==\"LPDU\" and 2 or 1,p.strategyItems)\n  changed(\"strategy\",selected==2 and \"LPDU\" or \"NAUR\")\n  selected=choice(\"p3_custom_hold\",\"Lock face / stop actions\",p.customHold and 1 or 2,p.holdItems)\n  changed(\"customHold\",selected==1)\n end\n if GUI:CollapsingHeader(\"P4 - Eyes\") then\n  style(\"p4_eyes\",\"Orbs and Mirage Dive\")\n   local selected=choice(\"p4_eyes_strategy\",\"Mirage priority\",p.eyesStrategy==\"Trapezoid\" and 2 or 1,{\"Square\",\"North to South\"})\n   changed(\"eyesStrategy\",selected==2 and \"Trapezoid\" or \"Square\")\n   if p.eyesStrategy==\"Trapezoid\" then GUI:TextUnformatted(\"North to south / G1 north / G2 south\") end\n end\n if GUI:CollapsingHeader(\"P5 - Dark Thordan\") then\n  style(\"p5_wrath\",\"Wrath Of The Heavens\")\n  style(\"p5_doth\",\"Death Of The Heavens\")\n  local selected=choice(\"doth_order_mode\",\"DOTH order\",p.dothMode==\"Live positions\" and 2 or 1,p.dothModeItems)\n  changed(\"dothMode\",p.dothModeItems[selected])\n  GUI:TextUnformatted(\"DOTH order - drag to rearrange\")\n  local value,captured,note=lineup(\"doth\",p.edit,p.default,p.parse)\n  if value~=p.edit then p.dothMode=\"Configured conga\" end\n  changed(\"edit\",value)\n  if captured then p.dothMode=\"Configured conga\";if p.save(p.edit)then p.message=note..\" Saved.\"end end\n end\n if GUI:CollapsingHeader(\"P6 - Double Dragons\") then\n  local dragonHP=choice(\"p6_dragon_hp_window\",\"Dragon HP window\",p.dragonHP and 1 or 2,p.holdItems)\n  changed(\"dragonHP\",dragonHP==1)\n  local afahHP=choice(\"p6_akh_afah_hp\",\"Akh Afah HP callout\",p.akhAfahHP and 1 or 2,p.holdItems)\n  changed(\"akhAfahHP\",afahHP==1)\n  style(\"p6_vow\",\"Mortal Vow\")\n  local melee=choice(\"p6_vow_melee\",\"Preferred melee pass\",p.vowMelee==\"M2\" and 2 or 1,{\"M1\",\"M2\"})\n  changed(\"vowMelee\",melee==2 and \"M2\" or \"M1\")\n  local vowMode=choice(\"p6_vow_tts_mode\",\"Vow callouts\",p.vowTTSMode==\"Personal\" and 1 or p.vowTTSMode==\"Disabled\" and 3 or 2,p.autoModeItems)\n  changed(\"vowTTSMode\",p.autoModeItems[vowMode])\n  if p.styles.p6_vow~=\"Disabled\" then\n   order(\"vowEdit\",\"vow_order\",\"Vow passes (T / M / R)\",145,p.vowDefault)\n  end\n  local me=TensorCore.mGetPlayer()\n  local isTank=me and (me.job==19 or me.job==21 or me.job==32 or me.job==37)\n  if isTank then\n   local enabled=choice(\"p6_hw_tank\",\"Hallowed Wings tank paths\",p.styles.p6_hw_tank==\"Disabled\" and 2 or 1,{\"On\",\"Off\"})\n   p.styles.p6_hw_tank=enabled==2 and \"Disabled\" or \"Tether\"\n   local tankItems={\"MT\",\"OT\"}\n   local north=choice(\"p6_hw_north\",\"First wings: northmost\",p.hwNorth==\"T2\" and 2 or 1,tankItems)\n   changed(\"hwNorth\",north==2 and \"T2\" or \"T1\")\n   local wall=choice(\"p6_hw_wall\",\"Second wings: wall\",p.hwWall==\"T2\" and 2 or 1,tankItems)\n   changed(\"hwWall\",wall==2 and \"T2\" or \"T1\")\n  else\n   local enabled=choice(\"p6_hw_party\",\"Hallowed Wings party arrow\",p.styles.p6_hw_party==\"Disabled\" and 2 or 1,{\"On\",\"Off\"})\n   p.styles.p6_hw_party=enabled==2 and \"Disabled\" or \"Arrow\"\n  end\n  style(\"p6_wb1\",\"Wyrmsbreath 1\")\n  GUI:TextUnformatted(\"WB1 pairs - anchor stays, flex adjusts\")\n  local pairsText=table.concat({p.wb1Anchors[1],p.wb1Flex[1],p.wb1Anchors[2],p.wb1Flex[2],p.wb1Anchors[3],p.wb1Flex[3]},\" \")\n  local value,captured,note=lineup(\"wb1\",pairsText,\"H1 R1 M1 M2 H2 R2\",p.validatePairs)\n  if value~=pairsText then\n   local roles=p.validatePairs(value)\n   for i=1,3 do p.wb1Anchors[i]=roles[i*2-1];p.wb1Flex[i]=roles[i*2]end\n   p.message=\"Unsaved changes\"\n  end\n  if captured and p.save(p.edit)then p.message=note..\" Saved.\"end\n  GUI:TextUnformatted(\"Anchors hold; flexers match opposite colours.\")\n  style(\"p6_wb2\",\"Wyrmsbreath 2\")\n  local strat=choice(\"p6_wb2_strategy\",\"WB2 strategy\",p.wb2Strategy==\"5-1\" and 2 or 1,{\"Static\",\"5-1\"})\n  changed(\"wb2Strategy\",strat==2 and \"5-1\" or \"Static\")\n  if p.wb2Strategy==\"Static\" then\n  GUI:TextUnformatted(\"WB2 fixed spots - drag roles between labelled positions\")\n  local value,captured,note=lineup(\"wb2\",p.wb2Edit,p.wb2Default,p.validatePairs)\n  changed(\"wb2Edit\",value)\n  if captured and p.save(p.edit)then p.message=note..\" Saved.\"end\n  else\n   GUI:TextUnformatted(\"North W-E: M1 R1 H2 R2 M2 | South: H1\")\n  end\n  style(\"p6_cauterize\",\"Double Cauterize\")\n  if p.styles.p6_cauterize~=\"Disabled\" then\n   local index=1\n   for i,value in ipairs(p.cautItems) do if value==p.cautMT then index=i; break end end\n   local selected=choice(\"p6_cauterize_mt\",\"MT takes\",index,p.cautItems)\n   changed(\"cautMT\",p.cautItems[selected])\n   GUI:TextUnformatted(\"OT takes: \"..p.cautOpposite[selected])\n  end\n end\n if GUI:CollapsingHeader(\"P7 - Dragon-King\") then\n  style(\"p7_trinity\",\"Trinity\")\n  style(\"p7_akh\",\"Akh Morn\")\n  if p.styles.p7_akh~=\"Disabled\" then\n   local selected=choice(\"p7_akh_strategy\",\"Akh Morn groups\",p.akhStrategy==\"3-3-2\" and 2 or 1,p.akhStrategyItems)\n   changed(\"akhStrategy\",p.akhStrategyItems[selected])\n   if p.akhStrategy==\"3-3-2\" then GUI:TextUnformatted(\"G1 NW / G2 NE / tanks S\") end\n  end\n  style(\"p7_giga\",\"Gigaflare\")\n  local selected=choice(\"p7_element_draws\",\"Flames / ice\",p.elementDraws and 1 or 2,p.holdItems)\n  changed(\"elementDraws\",selected==1)\n  selected=choice(\"p7_auto_mode\",\"Auto callouts\",p.autoMode==\"Shotcaller\" and 2 or p.autoMode==\"Disabled\" and 3 or 1,p.autoModeItems)\n  changed(\"autoMode\",p.autoModeItems[selected])\n  if p.autoMode~=\"Disabled\" then\n   GUI:PushItemWidth(145)\n   changed(\"autoOrderEdit\",GUI:InputText(\"##p7_auto_order\",p.autoOrderEdit))\n   GUI:PopItemWidth()\n   GUI:SameLine(); GUI:TextUnformatted(\"Auto order (M / R / H; G1 first)\")\n   local valid,err=p.parseAuto(p.autoOrderEdit)\n   if not valid then GUI:TextUnformatted(err) end\n  end\n end\n GUI:PopItemWidth()\n GUI:Separator()\n if GUI:Button(\"Save\") then p.save(p.edit) end\n if p.message then GUI:SameLine(); GUI:TextUnformatted(p.message) end\nend\nGUI:End()\nself.used=true\n",
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
				name = "[Settings] Draw Settings",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 9999,
				timerStartOffset = -30,
				uuid = "40ce343b-d6ae-f0e8-8fed-38b54bcd6171",
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
							actionLua = "for i=1,8 do\n    TensorCore.sendParsedChatMessage(\"/mk clear <\"..i..\">\")\nend\nself.used=true",
							name = "Clear marks on party slots 1–8",
							uuid = "6ed63eb5-3e32-bb19-a820-654b57bceb0c",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 9,
				name = "[Utility] Clear Markers",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2000,
				timerStartOffset = -30,
				uuid = "25d4e420-2f4e-3384-ab70-6b380f888099",
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
							actionLua = "MoogleTelegraphs.Settings.aoeIDUserBlacklist[26381] = {label = \"Dive from Grace\", source = \"Frog DSR Draws\"}\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[25316] = {label = \"Pure of Heart\", source = \"Frog DSR Draws\"}\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[27966] = {label = \"Nidhogg Cauterize\", source = \"Frog DSR Draws\"}\nMoogleTelegraphs.Settings.aoeIDUserBlacklist[27967] = {label = \"Hraesvelgr Cauterize\", source = \"Frog DSR Draws\"}\nself.used=true",
							conditions =
							{

								{
									"48ef1c90-d8bc-938e-ae26-c649c6101609",
									true,
								},
							},
							name = "Apply Moogle blacklists",
							uuid = "d0fce8fe-02c3-2b28-b03b-2fb250d06a13",
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
							conditionLua = "return MoogleTelegraphs~=nil and MoogleTelegraphs.Settings~=nil and MoogleTelegraphs.Settings.aoeIDUserBlacklist~=nil",
							name = "Moogle blacklist available",
							uuid = "48ef1c90-d8bc-938e-ae26-c649c6101609",
							version = 3,
						},
					},
				},
				name = "[Misc] Moogle Blacklists",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 20,
				timerStartOffset = -30,
				uuid = "73e05307-d9bf-c298-9fce-37c535298435",
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
							actionLua = "local old=eventArgs.oldData\nlocal s=old and old.frog_p7_guidance\nif s and s.draw then Argus.deleteTimedShape(s.draw) end\nlocal element=old and old.frog_p7_element\nif element and element.draw then Argus.deleteTimedShape(element.draw) end\nlocal e=old and old.frog_enum_v1\nif e and e.arrow then Argus.deleteTimedShape(e.arrow) end\nlocal c=old and old.frog_charibert_v1\nif c and c.cones then for _,id in ipairs(c.cones)do Argus.deleteTimedShape(id)end end\nlocal doth=old and old.frog_doth_v1\nif doth and doth.lineupMismatch then\n data.frog_doth_notice={open=true,partial=doth.lineupUnclear==true}\nend\nself.used=true",
							name = "P7 Draw Cleanup",
							uuid = "5b0d291d-4a92-a3fc-9b0f-6098e06be23f",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 9,
				name = "[Draw] Draw Cleanup",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1800,
				timerStartOffset = -30,
				uuid = "6803b18f-f8c5-5bfe-8b99-4ec5a6f812fb",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "0f0ef9e7-4c2d-6d8f-b8f1-cbc2487ccc81",
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
							actionLua = "ACR_TensorMagnum3_Hotbar_Potion=false\nself.used=true",
							conditions =
							{

								{
									"8937d431-b31a-b954-ab58-1c4775287f14",
									true,
								},
							},
							name = "Clear potion on wipe",
							uuid = "903ee1c2-db31-6775-ab4d-2fabfb408299",
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
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "8937d431-b31a-b954-ab58-1c4775287f14",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 9,
				name = "[MCH] Wipe potion queue cleanup",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2000,
				timerStartOffset = -30,
				uuid = "83716412-ffb1-27dc-9b56-d9076813a8c3",
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
							actionLua = "local release=eventArgs.timeQueued+eventArgs.time*1000+13000\nTensorCore.API.TensorACR.holdActionUntil(2878,release,3)\nTensorCore.API.TensorACR.holdActionUntil(17209,release,3)\ndata.frog_mch_p2_burst_delay=true\nself.used=true\n",
							conditions =
							{

								{
									"7eb03be4-5158-011b-ab41-25624d08d479",
									true,
								},

								{
									"157b43d5-835d-f480-b7db-1fdd05493aaf",
									true,
								},

								{
									"31612ab5-9670-aee6-87df-1f6c968ca890",
									true,
								},
							},
							endIfUsed = true,
							name = "Hold opener burst until 13 seconds",
							uuid = "17c0da87-125a-6bdb-a576-c36c78cced72",
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
							conditionLua = "for _,e in pairs(TensorCore.entityList(\"contentid=3632\"))do if e.targetable then return true end end return false",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							name = "Thordan checkpoint countdown",
							spellIDList =
							{
								16498,
							},
							uuid = "7eb03be4-5158-011b-ab41-25624d08d479",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "157b43d5-835d-f480-b7db-1fdd05493aaf",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return eventArgs.time>0",
							dequeueIfLuaFalse = true,
							name = "Countdown available",
							uuid = "31612ab5-9670-aee6-87df-1f6c968ca890",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 16,
				loop = true,
				name = "[MCH] P2 opening Wildfire and Hypercharge delay",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 305,
				timerStartOffset = -30,
				uuid = "2c30bf99-8a4e-7818-a5c8-b304c7973ed9",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "a0223adb-cbb9-200d-937a-918ffef58631",
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
							actionLua = "local p=TensorCore.mGetPlayer()\nif not p or eventArgs.entityID~=p.id then self.used=true return end\ndata.frog_mnk_downtime=data.frog_mnk_downtime or {known=false,solar=false,lunar=false,remaining=0,chakra=0}\nlocal s=data.frog_mnk_downtime\nlocal t=Now()\nlocal id=eventArgs.spellID\nif id==69 then\n s.remaining=3;s.pbUntil=t+20000;s.chakra=0;s.chakraUntil=0\nelseif id==25769 then\n s.known=true;s.solar=false;s.lunar=false;s.remaining=0;s.chakra=0\nelseif id==25768 or id==3545 then\n if id==25768 then s.solar=true else s.lunar=true end\n s.remaining=0;s.chakra=0\nelse\n if s.remaining>0 and t<=(s.pbUntil or 0) then\n  s.remaining=s.remaining-1;s.chakra=s.chakra+1;s.chakraUntil=t+20000\n else s.remaining=0 end\nend\nself.used=true",
							conditions =
							{

								{
									"dccac2be-8ebd-60e7-8f6f-1c57556bee41",
									true,
								},

								{
									"bdf60141-9aea-8f90-8fb4-88de1fc9ab59",
									true,
								},
							},
							name = "Track successful own Monk casts",
							uuid = "9a1d5204-8f1c-ae0f-b9dd-0b51ce6b97a1",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "dccac2be-8ebd-60e7-8f6f-1c57556bee41",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "53a754c9-78e9-a84f-9d87-58aa2860a992",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "b54e0f28-3f95-7c08-98a8-b30a5ff8e767",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							eventArgOptionType = 3,
							eventArgType = 2,
							spellIDList =
							{
								69,
								53,
								54,
								56,
								61,
								66,
								70,
								74,
								16473,
								25767,
								3545,
								25768,
								25769,
							},
							uuid = "bdf60141-9aea-8f90-8fb4-88de1fc9ab59",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				eventType = 2,
				name = "[MNK] Observe PB and Nadi",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2000,
				uuid = "460283a1-4bb5-f6a4-9af2-7d9be41c6608",
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
							actionLua = "data.frog_mnk_downtime=nil\nself.used=true",
							conditions =
							{

								{
									"665ddbeb-02b4-58c8-8a9d-227267a1b1a3",
									true,
								},
							},
							name = "Invalidate Nadi observation",
							uuid = "4210dada-5be0-e670-bbf2-5d23fb5e675f",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "665ddbeb-02b4-58c8-8a9d-227267a1b1a3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "2c89dc9f-bccc-9230-86f5-59687ae1f5b3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "54354083-9f70-66a8-ba01-efb9ac2ddbf2",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				eventType = 10,
				name = "[MNK] Reset PB observation on death",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 2000,
				uuid = "f3250246-daa3-a4df-a0f0-b9b4339ffa98",
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
							actionLua = "local release=Now()+13000\nTensorCore.API.TensorACR.holdActionUntil(2878,release)\nTensorCore.API.TensorACR.holdActionUntil(17209,release)\ndata.frog_mch_p2_burst_delay=true\nself.used=true",
							conditions =
							{

								{
									"e470a783-97d4-9527-ab8b-65b0be85e7ae",
									true,
								},

								{
									"46e64b1e-ce78-4f9f-ba2e-8d3b9d77ab5a",
									true,
								},

								{
									"3ae370fa-8fb1-f89e-afba-2acca80eb27e",
									true,
								},
							},
							endIfUsed = true,
							name = "Hold opener burst until 13 seconds",
							uuid = "4190b12d-e668-b787-844f-6eccbf0a4165",
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
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "46e64b1e-ce78-4f9f-ba2e-8d3b9d77ab5a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return eventArgs.entityID==TensorCore.mGetPlayer().id and eventArgs.targetContentID==3632 and not data.frog_mch_p2_burst_delay",
							dequeueIfLuaFalse = true,
							name = "Own first Drill on Thordan",
							uuid = "3ae370fa-8fb1-f89e-afba-2acca80eb27e",
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
							name = "Opening Drill",
							spellIDList =
							{
								16498,
							},
							uuid = "e470a783-97d4-9527-ab8b-65b0be85e7ae",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 2,
				name = "[MCH] P2 burst hold fallback after full P1",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 305,
				timerStartOffset = -1,
				uuid = "8499b489-ed5a-9514-a57d-42d94cffe205",
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
							actionLua = "local notice=data.frog_doth_notice\nif not notice or not notice.open or TensorReactions_CurrentTimer>0 then self.used=true return end\nGUI:SetNextWindowPosCenter(GUI.SetCond_Always)\nlocal visible\nvisible,notice.open=GUI:Begin(\"Conga check\",notice.open,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n GUI:TextUnformatted(\"Conga mismatch\")\n GUI:TextUnformatted(notice.partial and \"Used observed lineup (partial)\" or \"Used observed lineup\")\nend\nGUI:End()\nself.used=true",
							name = "Quiet conga notice",
							uuid = "aea88e62-f150-4a74-8bac-e4309386da02",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 13,
				name = "[Draw] DOTH wipe notice",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1800,
				timerStartOffset = -30,
				uuid = "1244bcf8-7511-e96f-9d32-1f118bd60517",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p1_playstation\")==\"Disabled\" then self.used=true return end\n\nlocal player = TensorCore.mGetPlayer()\nlocal state = data.playstation_symbol_tether\nif not player or not player.pos or not state or not state.symbols then\n    self.used = true\n    return\nend\n\nlocal marker = state.symbols[player.id]\nif marker ~= 281 and marker ~= 282 and marker ~= 283 and marker ~= 284 then\n    self.used = true\n    return\nend\n\n\n\nif state.rosterResolved ~= true then\n    local rosterMembers = AnyoneCore.Roster.members()\n    local agnosticParty = AnyoneCore.API.getAgnosticPartyList()\n    if type(rosterMembers) ~= \"table\" or type(agnosticParty) ~= \"table\" then\n        self.used = true\n        return\n    end\n\n    local actorByJob, actorJobCount, rosterJobCount = {}, {}, {}\n    for _, actor in pairs(agnosticParty) do\n        if actor ~= nil and actor.id ~= nil and actor.job ~= nil then\n            actorByJob[actor.job] = actor\n            actorJobCount[actor.job] = (actorJobCount[actor.job] or 0) + 1\n        end\n    end\n    for _, member in pairs(rosterMembers) do\n        if member ~= nil and member.job ~= nil then\n            rosterJobCount[member.job] = (rosterJobCount[member.job] or 0) + 1\n        end\n    end\n    local actorByNameJob = {}\n    for _, actor in pairs(agnosticParty) do\n        if actor ~= nil and actor.id ~= nil and actor.name ~= nil and actor.job ~= nil then\n            local key = tostring(actor.name) .. \"\\31\" .. tostring(actor.job)\n            actorByNameJob[key] = actor\n        end\n    end\n\n    local definitions = {\n        {name = \"MT\", rosterSlot = \"T1\"},\n        {name = \"OT\", rosterSlot = \"T2\"},\n        {name = \"H1\", rosterSlot = \"H1\"},\n        {name = \"H2\", rosterSlot = \"H2\"},\n        {name = \"M1\", rosterSlot = \"M1\"},\n        {name = \"M2\", rosterSlot = \"M2\"},\n        {name = \"R1\", rosterSlot = \"R1\"},\n        {name = \"R2\", rosterSlot = \"R2\"}\n    }\n\n    state.roleByID = {}\n    for _, definition in ipairs(definitions) do\n        local member = rosterMembers[definition.rosterSlot]\n        if member == nil or member.name == nil or member.job == nil then\n            state.roleByID = nil\n            self.used = true\n            return\n        end\n\n        local key = tostring(member.name) .. \"\\31\" .. tostring(member.job)\n        local actor = actorByNameJob[key]\n        if actor == nil and actorJobCount[member.job] == 1 and rosterJobCount[member.job] == 1 then\n            actor = actorByJob[member.job]\n        end\n        if actor == nil or actor.id == nil then\n            state.roleByID = nil\n            self.used = true\n            return\n        end\n\n        state.roleByID[actor.id] = definition.name\n    end\n\n    state.rosterResolved = true\nend\n\nlocal role = state.roleByID and state.roleByID[player.id]\nif role == nil then\n    self.used = true\n    return\nend\n\nlocal targetX = nil\nlocal targetZ = nil\n\n\n\nlocal isTank = role == \"MT\" or role == \"OT\"\nlocal isHealer = role == \"H1\" or role == \"H2\"\nlocal isDPS = role == \"M1\" or role == \"M2\"\n    or role == \"R1\" or role == \"R2\"\n\nif isTank then\n    if marker == 284 then\n        targetX = 100.0\n        targetZ = 78.0\n    elseif marker == 283 then\n        targetX = 122.0\n        targetZ = 78.0\n    end\nelseif isHealer then\n    if marker == 284 then\n        targetX = 100.0\n        targetZ = 122.0\n    elseif marker == 282 then\n        targetX = 122.0\n        targetZ = 122.0\n    end\nelseif isDPS then\n    if marker == 282 then\n        targetX = 78.0\n        targetZ = 78.0\n    elseif marker == 283 then\n        targetX = 78.0\n        targetZ = 122.0\n    elseif marker == 281 then\n        local otherCircleX = nil\n        for entityID, otherMarker in pairs(state.symbols) do\n            if entityID ~= player.id and otherMarker == 281 then\n                local other = TensorCore.mGetEntity(entityID)\n                if other ~= nil and other.pos ~= nil then\n                    otherCircleX = other.pos.x\n                    break\n                end\n            end\n        end\n\n        if otherCircleX ~= nil then\n            local myWest = math.abs(player.pos.x - 78.0)\n            local myEast = math.abs(player.pos.x - 122.0)\n            local otherWest = math.abs(otherCircleX - 78.0)\n            local otherEast = math.abs(otherCircleX - 122.0)\n\n            \n            if (myWest + otherEast) <= (myEast + otherWest) then\n                targetX = 78.0\n            else\n                targetX = 122.0\n            end\n            targetZ = 100.0\n        end\n    end\nend\n\nif targetX ~= nil and targetZ ~= nil then\n    local drawer = TensorCore.getMoogleDrawer()\n    frogGuide.draw(\"p1_playstation\",drawer,\n        player.pos.x, player.pos.y, player.pos.z,\n        targetX, player.pos.y, targetZ,\n        8.0, 3.0\n    )\nend\n\nself.used = true",
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
	[26] =
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
							actionLua = "local t=TensorReactions_CurrentTimer\nlocal base=200\nlocal s=data.frog_charibert_v1\nif not s or s.base~=base or (s.last and t<s.last-1)then\n s={base=base,seen={},cones={}};data.frog_charibert_v1=s\nend\ns.last=t\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then self.used=true return end\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings\nif not settings then\n if not s.settings then\n  local path=GetLuaModsPath()..[[TensorReactions\\FrogDrawsSettings.lua]]\n  s.settings=FileExists(path)and FileLoad(path)or {}\n end\n settings=s.settings\nend\ns.mode=settings.draw_styles and settings.draw_styles.p1_brightwing or \"Tether\"\nlocal callMode=settings.p1_skyblind_mode or \"Personal\"\nlocal boss\nfor _,e in pairs(TensorCore.entityList(\"contentid=3642,targetable,alive\")or{})do boss=e;break end\nif not boss then\n s.x,s.z=nil,nil\n for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n s.cones={};self.used=true return\nend\nlocal party={}\nfor _,e in pairs(TensorCore.getEntityGroupList(\"Party\")or{})do\n if e.pos and e.hp.current>0 then\n  local dx,dz=e.pos.x-boss.pos.x,e.pos.z-boss.pos.z\n  party[#party+1]={id=e.id,e=e,d=dx*dx+dz*dz}\n end\nend\ntable.sort(party,function(a,b)return a.d<b.d or (a.d==b.d and a.id<b.id)end)\nlocal expected=t<base+15.9 and 0 or math.min(4,math.floor((t-base-15.9)/5)+1)\ns.hits=math.max(s.hits or 0,expected)\nif settings.p1_brightwing_cones~=false and s.hits<4 and #party>=2 then\n local key=party[1].id..\":\"..party[2].id\n if s.coneKey~=key or not s.refresh or Now()-s.refresh>=650 then\n  for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n  s.cones={};s.coneKey=key;s.refresh=Now()\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  local drawer=TensorCore.getCachedFlatDrawer(GUI:ColorConvertFloat4ToU32(1,0,0,.12),GUI:ColorConvertFloat4ToU32(1,0,0,.5),GUI:ColorConvertFloat4ToU32(1,0,0,.8),GUI:ColorConvertFloat4ToU32(1,0,0,.9),1,0,flags)\n  for i=1,2 do\n   local id=drawer:addTimedConeOnEnt(1000,boss.id,18,math.pi/6,party[i].id,0,false,true,0,false,flags)\n   if id then s.cones[#s.cones+1]=id end\n  end\n end\nelse\n for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n s.cones={}\nend\nlocal meBuff\nfor _,v in ipairs(party)do\n local buff=TensorCore.getBuff(v.e,2661)\n if v.id==p.id then meBuff=buff end\n if callMode==\"Shotcaller\" or (callMode==\"Personal\" and v.id==p.id)then\n  if buff and buff.duration>0 then\n   s.seen[v.id]={expiry=t+buff.duration}\n  elseif s.seen[v.id]then\n   local seen=s.seen[v.id];s.seen[v.id]=nil\n   if t>=seen.expiry-.4 then\n    if not s.lastAlert or Now()-s.lastAlert>1000 then\n     TensorCore.addAlertText(3000,\"Move\",1.5,2,true);s.lastAlert=Now()\n    end\n    if v.id==p.id then s.returnUntil=t+1.5 end\n   end\n  end\n end\nend\nfor id in pairs(s.seen)do\n local e=TensorCore.mGetEntity(id)\n if not e or e.hp.current<=0 then s.seen[id]=nil end\nend\nif p.hp.current<=0 then s.x,s.z=nil,nil;self.used=true return end\nif not s.role and AnyoneCore and AnyoneCore.Roster and AnyoneCore.Roster.isReady()then\n local members=AnyoneCore.Roster.members()\n local agnostic=AnyoneCore.API.getAgnosticPartyList()\n local counts,rcounts={},{}\n for _,v in pairs(agnostic)do if v.job then counts[v.job]=(counts[v.job]or 0)+1 end end\n for _,v in pairs(members)do if v.job then rcounts[v.job]=(rcounts[v.job]or 0)+1 end end\n for _,role in ipairs({\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n  local key=role==\"MT\"and \"T1\"or role==\"OT\"and \"T2\"or role\n  local m=members[key]\n  for _,v in pairs(agnostic)do\n   if m and v.id==p.id and m.job==v.job and (m.name==v.name or(counts[v.job]==1 and rcounts[v.job]==1))then s.role=role end\n  end\n end\nend\ns.x,s.z=nil,nil\nif s.mode==\"Disabled\"or not s.role then self.used=true return end\nlocal role=s.role\nlocal tank=role==\"MT\"or role==\"OT\"\nlocal melee=role:sub(1,1)==\"M\"and not tank\nif meBuff then\n if tank then\n  s.x,s.z=boss.pos.x,boss.pos.z+boss.hitradius*.5\n elseif melee then\n  local radius=boss.hitradius+2.9\n  local a,b=boss.pos.h+3*math.pi/4,boss.pos.h-3*math.pi/4\n  local ax,az=boss.pos.x+math.sin(a)*radius,boss.pos.z+math.cos(a)*radius\n  local bx,bz=boss.pos.x+math.sin(b)*radius,boss.pos.z+math.cos(b)*radius\n  if (ax-boss.pos.x)^2+(az-(boss.pos.z-5))^2<(bx-boss.pos.x)^2+(bz-(boss.pos.z-5))^2 then s.x,s.z=ax,az else s.x,s.z=bx,bz end\n else\n  s.x,s.z=boss.pos.x+7,boss.pos.z-5\n end\nelseif s.returnUntil and t<s.returnUntil then\n s.x,s.z=boss.pos.x,boss.pos.z-5\nelse\n local wave=s.hits+1\n local own=role:sub(1,1)==\"H\"and 1 or melee and 2 or role:sub(1,1)==\"R\"and 3 or 4\n if wave==own and wave<=4 then\n  local side=settings.p1_brightwing_side or \"Roster\"\n  local left=side==\"Left\"or(side~=\"Right\"and(role==\"MT\"or role:sub(-1)==\"1\"))\n  s.x,s.z=boss.pos.x+(left and -2.5 or 2.5),boss.pos.z+.5\n end\nend\nself.used=true\n\n",
							name = "Brightwing helper",
							uuid = "d85d7537-7150-d353-a732-a3c2ab693fe2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 200,
				name = "[Draw] Brightwing helper",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 38.5,
				uuid = "762f1e9e-2330-a14b-b277-146f28789355",
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
							actionLua = "local s=data.frog_charibert_v1\nif not s or not s.x or not s.z or s.mode==\"Disabled\"then self.used=true return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then self.used=true return end\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,flags)\nif s.mode==\"Arrow\"then\n local dx,dz=s.x-p.pos.x,s.z-p.pos.z\n local length=math.sqrt(dx*dx+dz*dz)\n if length>.2 then local tip=math.min(2,length*.35);drawer:addArrow(p.pos.x,p.pos.y+.08,p.pos.z,math.atan2(dx,dz),length-tip,.75,tip,1.5,false,flags)end\nelse drawer:addLine(p.pos.x,p.pos.y+.08,p.pos.z,s.x,.08,s.z,3,1)end\nself.used=true\n",
							name = "Brightwing guidance",
							uuid = "b1748db8-04f6-2d07-a6f5-5e66e2662be7",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 200,
				name = "[Draw] Brightwing guidance",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 38.5,
				uuid = "bbb4f324-9e53-125e-baa1-88ff500ccdae",
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
							actionLua = "local s=data.frog_charibert_v1\nif not s or s.base~=200 then s={base=200,seen={},cones={}};data.frog_charibert_v1=s end\nlocal now=Now()\nif not s.lastHit or now-s.lastHit>1200 then s.hits=math.min(4,(s.hits or 0)+1);s.lastHit=now end\nself.used=true",
							conditions =
							{

								{
									"0209fe23-448b-8263-9158-90f45156fe2b",
									true,
								},
							},
							name = "Track paired cleaves",
							uuid = "5f245047-c9ce-dad1-a412-ddd965757db7",
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
							eventSpellID = 25369,
							name = "Brightwing",
							uuid = "0209fe23-448b-8263-9158-90f45156fe2b",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 200,
				name = "[Draw] Brightwing capture",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 38.5,
				uuid = "fded49f1-5344-87e5-a77e-e33aca33eb8c",
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
				name = "Local fixes",
				uuid = "6335c1c7-3fc7-0a95-a341-6f6b8d2243ed",
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
							actionID = 16501,
							atomicPriority = true,
							conditions =
							{

								{
									"f8b6b454-9b42-b26e-8ce7-cd5e6b457d9c",
									true,
								},

								{
									"9ab9ba2e-0690-2c58-b284-e686909bfd3f",
									true,
								},

								{
									"a03e4804-7aee-e3eb-92b2-2225ff6bfdd5",
									true,
								},

								{
									"0257359b-3350-abf8-ad1b-6e186feaf5ba",
									true,
								},

								{
									"75494fca-8941-8ace-8f53-39f08978d4d4",
									true,
								},
							},
							endIfUsed = true,
							name = "Early opener Queen",
							uuid = "161af7f0-924d-4492-82bc-f0040b63b080",
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
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "f8b6b454-9b42-b26e-8ce7-cd5e6b457d9c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "9ab9ba2e-0690-2c58-b284-e686909bfd3f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 6,
							gaugeIndex = 2,
							gaugeValue = 50,
							name = "Battery >=50",
							uuid = "a03e4804-7aee-e3eb-92b2-2225ff6bfdd5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.contentid==3632 and t.targetable and t.attackable and t.hp.current>0",
							name = "P2 Thordan available",
							uuid = "0257359b-3350-abf8-ad1b-6e186feaf5ba",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return TensorReactions_CurrentTimer<321.5",
							dequeueIfLuaFalse = true,
							name = "P2 opener still active",
							uuid = "75494fca-8941-8ace-8f53-39f08978d4d4",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				mechanicTime = 291.5,
				name = "[MCH] Prioritise Queen in P2 opener",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 30,
				uuid = "63e244a9-3773-7ed7-9d7a-b393e8dd4bad",
				version = 2,
			},
		},
	},
	[45] =
	{

		{
			data =
			{
				displayPath = "",
				name = "P2 Strength",
				uuid = "84752f65-8de3-3f49-84f4-159cd5acce83",
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
							actionLua = "local s=data.frog_strength_spreads\nif s then\n if not s.resolved then s.resolved={}end\n for _,id in ipairs(eventArgs.hitTargets)do s.resolved[id]=true end\nend\nself.used=true\n",
							conditions =
							{

								{
									"3523282e-03c7-eaff-a184-be4ffc4be15a",
									true,
								},
							},
							name = "[Strength] Clear resolved spread tether",
							uuid = "c98f4408-9e73-c12a-beb4-b9a3d6858479",
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
							name = "Lightning spread hit",
							spellIDList =
							{
								25549,
							},
							uuid = "3523282e-03c7-eaff-a184-be4ffc4be15a",
							version = 3,
						},
					},
				},
				displayPath = "P2 Strength",
				eventType = 2,
				loop = true,
				mechanicTime = 317.5,
				name = "[Strength] Clear resolved spread tether",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 13.5,
				uuid = "152b6b72-1694-f667-b1aa-a9b65a9c00b3",
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
							actionLua = "local e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e then self.used=true return end\nlocal s=data.frog_strength_spreads\nlocal t=TensorReactions_CurrentTimer\nif not s or (s.lastTime and t<s.lastTime-1)then s={axes={},count=0};data.frog_strength_spreads=s end\ns.lastTime=t\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nif dx*dx+dz*dz<300 then self.used=true return end\nlocal axis=math.floor(math.atan2(dx,-dz)/(math.pi/4)+0.5)%4\nif not s.axes[axis]then s.axes[axis]=true;s.count=s.count+1 end\nif s.count==3 then for i=0,3 do if not s.axes[i]then s.safeAxis=i;break end end end\nself.used=true\n",
							conditions =
							{

								{
									"65bb060d-cf82-336d-8a3f-80e808bfdd6e",
									true,
								},
							},
							name = "[Strength] Initial triangle safe axis",
							uuid = "e5889e00-92f1-9e2a-9d96-88aaff8a3948",
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
							name = "Spiral Thrust",
							spellIDList =
							{
								25556,
							},
							uuid = "65bb060d-cf82-336d-8a3f-80e808bfdd6e",
							version = 3,
						},
					},
				},
				displayPath = "P2 Strength",
				eventType = 3,
				loop = true,
				mechanicTime = 317.5,
				name = "[Strength] Initial triangle safe axis",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 13.5,
				uuid = "6712a2b1-a8e6-5824-831a-4fba31a8417e",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\n\nlocal s=data.frog_strength_spreads\nif not s or s.finished or s.safeAxis==nil then self.used=true return end\nlocal guide=data.frog_draw_style_v5\nif guide.mode(\"p2_strength\")==\"Disabled\"then self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.hp.current<=0 or (s.resolved and s.resolved[player.id]) then self.used=true return end\nlocal role=AnyoneCore.Roster.mySlot()\nif role==\"MT\"then role=\"T1\"elseif role==\"OT\"then role=\"T2\"end\nlocal group,radial,lateral\nif role==\"T1\"or role==\"H1\"or role==\"M1\"or role==\"R1\"then group=1\nelseif role==\"T2\"or role==\"H2\"or role==\"M2\"or role==\"R2\"then group=2\nelse self.used=true return end\nif role==\"T1\"or role==\"T2\"then radial=12;lateral=0\nelseif role==\"H1\"or role==\"H2\"then radial=19;lateral=0\nelseif role==\"M1\"or role==\"M2\"then radial=19.15;lateral=6.5\nelse radial=19.15;lateral=-6.5 end\nlocal angle=(s.safeAxis+(group==1 and 4 or 0))*math.pi/4\nlocal dx,dz=math.sin(angle),-math.cos(angle)\n\nlocal x=100+radial*dx-lateral*dz\nlocal z=100+radial*dz+lateral*dx\nlocal d=TensorCore.getStaticDrawer(0xFFFF6626,1,0,guide.flags)\nd:addCircle(x,player.pos.y+0.05,z,0.6,false,guide.flags)\nif (player.pos.x-x)^2+(player.pos.z-z)^2>1 then\n guide.draw(\"p2_strength\",d,player.pos.x,player.pos.y,player.pos.z,x,player.pos.y+0.05,z,8,2)\nend\nself.used=true\n\n",
							name = "[Strength] Initial triangle spread tether",
							uuid = "637beb4e-91d0-a8e3-936e-433d5b62ea65",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "P2 Strength",
				eventType = 12,
				mechanicTime = 317.5,
				name = "[Strength] Initial triangle spread tether",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 13.5,
				uuid = "ff4d71f3-44b6-4ad5-9fbb-84791052e65a",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog",
				uuid = "df1b48dd-d707-a1cc-9f7c-035ffcb6cf41",
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
							actionLua = "data.frog_strength_marker_v2 = data.frog_strength_marker_v2 or {hidden={}, visible={}, ids={}}\nlocal s = data.frog_strength_marker_v2\nif s.called then self.used = true return end\nlocal cid = eventArgs.entityContentID\ns.ids[cid] = eventArgs.entityID\ns.visible[cid] = eventArgs.isVisible\nif not eventArgs.isVisible then s.hidden[cid] = true end\nif not s.hidden[3634] or not s.hidden[3635] or not s.visible[3634] or not s.visible[3635] then\n    self.used = true\n    return\nend\nlocal adelphel = TensorCore.mGetEntity(s.ids[3634])\nlocal janlenoux = TensorCore.mGetEntity(s.ids[3635])\nif not adelphel or not janlenoux then return end\nlocal nx = 100 - (adelphel.pos.x + janlenoux.pos.x) / 2\nlocal nz = 100 - (adelphel.pos.z + janlenoux.pos.z) / 2\nlocal radius = math.sqrt(nx * nx + nz * nz)\nif radius < 1 then return end\nnx, nz = nx / radius, nz / radius\nlocal ex, ez = -nz, nx\nlocal aSide = (adelphel.pos.x - 100) * ex + (adelphel.pos.z - 100) * ez\nlocal jSide = (janlenoux.pos.x - 100) * ex + (janlenoux.pos.z - 100) * ez\nif math.abs(aSide - jSide) < 1 then return end\nlocal px, pz = 100 + nx * 23, 100 + nz * 23\nlocal nearest, best\nfor id = 1, 8 do\n    local x, y, z, active = Argus.getWaymarkInfo(id)\n    if active then\n        local mx, mz = x - px, z - pz\n        local distance = mx * mx + mz * mz\n        if not best or distance < best then\n            nearest, best = id, distance\n        end\n    end\nend\nif not nearest then s.called = true\nself.used = true return end\nlocal labels = \"ABCD1234\"\nlocal marker = labels:sub(nearest, nearest)\nTensorCore.addAlertText(8000, \"Thordan: \" .. marker, 1.5, 2, false)\nTensorCore.sendTTS(\"Thordan at \" .. marker)\ns.called = true\nself.used = true",
							conditions =
							{

								{
									"40fd4f13-8ad8-c07b-a655-ba3f318cc939",
									true,
								},

								{
									"e5fc71d7-3c3e-4275-84c4-8b37509df1f5",
									true,
								},

								{
									"f9fa721e-3b01-9324-86bc-2f83fcfceaa7",
									true,
								},
							},
							name = "Track Adelphel appearance",
							uuid = "3c4d397a-bd12-24ad-9920-3493f1c70d5a",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "data.frog_strength_marker_v2 = data.frog_strength_marker_v2 or {hidden={}, visible={}, ids={}}\nlocal s = data.frog_strength_marker_v2\nif s.called then self.used = true return end\nlocal cid = eventArgs.entityContentID\ns.ids[cid] = eventArgs.entityID\ns.visible[cid] = eventArgs.isVisible\nif not eventArgs.isVisible then s.hidden[cid] = true end\nif not s.hidden[3634] or not s.hidden[3635] or not s.visible[3634] or not s.visible[3635] then\n    self.used = true\n    return\nend\nlocal adelphel = TensorCore.mGetEntity(s.ids[3634])\nlocal janlenoux = TensorCore.mGetEntity(s.ids[3635])\nif not adelphel or not janlenoux then return end\nlocal nx = 100 - (adelphel.pos.x + janlenoux.pos.x) / 2\nlocal nz = 100 - (adelphel.pos.z + janlenoux.pos.z) / 2\nlocal radius = math.sqrt(nx * nx + nz * nz)\nif radius < 1 then return end\nnx, nz = nx / radius, nz / radius\nlocal ex, ez = -nz, nx\nlocal aSide = (adelphel.pos.x - 100) * ex + (adelphel.pos.z - 100) * ez\nlocal jSide = (janlenoux.pos.x - 100) * ex + (janlenoux.pos.z - 100) * ez\nif math.abs(aSide - jSide) < 1 then return end\nlocal px, pz = 100 + nx * 23, 100 + nz * 23\nlocal nearest, best\nfor id = 1, 8 do\n    local x, y, z, active = Argus.getWaymarkInfo(id)\n    if active then\n        local mx, mz = x - px, z - pz\n        local distance = mx * mx + mz * mz\n        if not best or distance < best then\n            nearest, best = id, distance\n        end\n    end\nend\nif not nearest then s.called = true\nself.used = true return end\nlocal labels = \"ABCD1234\"\nlocal marker = labels:sub(nearest, nearest)\nTensorCore.addAlertText(8000, \"Thordan: \" .. marker, 1.5, 2, false)\nTensorCore.sendTTS(\"Thordan at \" .. marker)\ns.called = true\nself.used = true",
							conditions =
							{

								{
									"40fd4f13-8ad8-c07b-a655-ba3f318cc939",
									true,
								},

								{
									"e5fc71d7-3c3e-4275-84c4-8b37509df1f5",
									true,
								},

								{
									"fa84ae78-3785-412e-a1c5-4b8ab8137c35",
									true,
								},
							},
							name = "Track Janlenoux appearance",
							uuid = "07010ebe-137d-ad48-be3f-9b4e454a0d39",
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
							eventEntityContentID = 3634,
							name = "Adelphel visibility",
							uuid = "f9fa721e-3b01-9324-86bc-2f83fcfceaa7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 3635,
							name = "Janlenoux visibility",
							uuid = "fa84ae78-3785-412e-a1c5-4b8ab8137c35",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "40fd4f13-8ad8-c07b-a655-ba3f318cc939",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "e5fc71d7-3c3e-4275-84c4-8b37509df1f5",
							version = 3,
						},
					},
				},
				displayPath = "Frog",
				eventType = 22,
				loop = true,
				mechanicTime = 317.5,
				name = "[Callout] Strength Thordan marker",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 30,
				timerStartOffset = -2,
				uuid = "4a88f319-cc9c-b59f-8890-8565a357b71d",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p2_strength\")==\"Disabled\" then self.used=true return end\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.pos == nil then\n    return\nend\n\ndata.frog_bash_guide = data.frog_bash_guide or {}\nlocal state = data.frog_bash_guide\n\nif state.role == nil then\n    local mySlot = AnyoneCore.Roster.mySlot()\n    if mySlot == \"MT\" then\n        state.role = \"T1\"\n    elseif mySlot == \"OT\" then\n        state.role = \"T2\"\n    elseif mySlot ~= nil then\n        state.role = mySlot\n    end\nend\n\nif state.role == nil then\n    local roster = AnyoneCore.Roster.members()\n    local party = AnyoneCore.API.getAgnosticPartyList()\n    if type(roster) ~= \"table\" or type(party) ~= \"table\" then\n        return\n    end\n\n    for slot, member in pairs(roster) do\n        if member ~= nil then\n            local exact\n            local unique\n            local partyCount = 0\n            local rosterCount = 0\n\n            for _, rosterMember in pairs(roster) do\n                if rosterMember ~= nil and rosterMember.job == member.job then\n                    rosterCount = rosterCount + 1\n                end\n            end\n\n            for _, partyMember in pairs(party) do\n                if partyMember ~= nil and partyMember.job == member.job then\n                    partyCount = partyCount + 1\n                    unique = partyMember\n                    if partyMember.name == member.name then\n                        exact = partyMember\n                    end\n                end\n            end\n\n            local resolved = exact or\n                (partyCount == 1 and rosterCount == 1 and unique)\n            if resolved ~= nil and resolved.id == player.id then\n                if slot == \"MT\" then\n                    state.role = \"T1\"\n                elseif slot == \"OT\" then\n                    state.role = \"T2\"\n                else\n                    state.role = slot\n                end\n                break\n            end\n        end\n    end\n\n    if state.role == nil then\n        self.used = true\n        return\n    end\nend\n\n\nif state.findActor == nil then\n    function state.findActor(id, cid, filter)\n        local entity = id and TensorCore.mGetEntity(id)\n        if entity and entity.contentid == cid and entity.pos and Argus.isEntityVisible(entity.id) then\n            return entity\n        end\n        for _, candidate in pairs(TensorCore.entityList(filter) or {}) do\n            if candidate.pos and Argus.isEntityVisible(candidate.id) then\n                return candidate\n            end\n        end\n    end\nend\n\nlocal isMT = state.role == \"T1\" or state.role == \"MT\"\nlocal isOT = state.role == \"T2\" or state.role == \"OT\"\nlocal flags = (Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n\nif not isMT and not isOT then\n    local thordan\n    local best = 100\n    for _, entity in pairs(TensorCore.entityList(\"contentid=3632\") or {}) do\n        if entity.pos and Argus.isEntityVisible(entity.id) then\n            local distance2 = (entity.pos.x-100)^2 + (entity.pos.z-100)^2\n            if distance2 > best then\n                best = distance2\n                thordan = entity\n            end\n        end\n    end\n    if not thordan then return end\n    local dx = thordan.pos.x-player.pos.x\n    local dz = thordan.pos.z-player.pos.z\n    local capture = data.frog_bash\n    if not capture or not capture.defams or (capture.defamCount or 0)<3 then self.used=true return end\n    local isDefamation = capture.defams[player.id]==true\n    \n    if not isDefamation and TensorReactions_CurrentTimer >= 345.4 then\n        self.used = true\n        return\n    end\n    if isDefamation then\n        if not state.defamPoints or state.defamBossID~=thordan.id then\n            local nx,nz=thordan.pos.x-100,thordan.pos.z-100\n            local length=math.sqrt(nx*nx+nz*nz)\n            if length<10 then self.used=true return end\n            nx,nz=nx/length,nz/length\n            local ex,ez=-nz,nx\n            \n            state.defamPoints={\n                {x=100+20*ex-1.5*nx,z=100+20*ez-1.5*nz},\n                {x=100-20*ex-1.5*nx,z=100-20*ez-1.5*nz},\n                {x=100-20*nx,z=100-20*nz}}\n            state.defamBossID=thordan.id\n        end\n        capture.defamAssignments=capture.defamAssignments or {}\n        local destination=capture.defamAssignments[player.id]\n        local bestDistance\n        if not destination then\n        for _,point in ipairs(state.defamPoints)do\n            local distance=(player.pos.x-point.x)^2+(player.pos.z-point.z)^2\n            local closest=true\n            for id in pairs(capture.defams)do\n                if id~=player.id then\n                    local other=TensorCore.mGetEntity(id)\n                    if not other then self.used=true return end\n                    local otherDistance=(other.pos.x-point.x)^2+(other.pos.z-point.z)^2\n                    if otherDistance<distance-0.0001 or (math.abs(otherDistance-distance)<=0.0001 and id<player.id)then closest=false;break end\n                end\n            end\n            if closest and (not point.ownerID or point.ownerID==player.id) and (not bestDistance or distance<bestDistance)then destination=point;bestDistance=distance end\n        end\n        if destination then\n            capture.defamAssignments[player.id]=destination\n            destination.ownerID=player.id\n        end\n        end\n        \n        if not destination then self.used=true return end\n        dx,dz=destination.x-player.pos.x,destination.z-player.pos.z\n    end\n    local directionLength=math.sqrt(dx*dx+dz*dz)\n    if directionLength>0.1 then\n        \n        local guideLength=directionLength\n        local tipLength=math.min(2,guideLength*0.35)\n        local drawer=TensorCore.getCachedDrawer(nil,nil,0xFF00FF00,nil,1.5,0,flags)\n        if frogGuide.mode(\"p2_strength\")==\"Arrow\" then\n            local arrowDrawer=TensorCore.getStaticDrawer(0xFFFF6626,1.5,0,flags)\n            arrowDrawer:addArrow(player.pos.x,player.pos.y,player.pos.z,math.atan2(dx,dz),\n                guideLength-tipLength,0.75,tipLength,1.5,false,flags)\n        else\n            drawer:addLine(player.pos.x,player.pos.y,player.pos.z,\n                player.pos.x+dx/directionLength*guideLength,player.pos.y,\n                player.pos.z+dz/directionLength*guideLength,8,2)\n        end\n    end\n    self.used = true\n    return\nend\n\nlocal adelphel = state.findActor(state.adelphelID,3634,\"contentid=3634\")\nlocal janlenoux = state.findActor(state.janlenouxID,3635,\"contentid=3635\")\nif not adelphel or not janlenoux then return end\nstate.adelphelID,state.janlenouxID = adelphel.id,janlenoux.id\n\n\n\nlocal nx = 100-(adelphel.pos.x+janlenoux.pos.x)/2\nlocal nz = 100-(adelphel.pos.z+janlenoux.pos.z)/2\nlocal radius = math.sqrt(nx*nx+nz*nz)\nif radius < 1 then return end\nnx,nz=nx/radius,nz/radius\nlocal ex,ez=-nz,nx\nlocal aSide=(adelphel.pos.x-100)*ex+(adelphel.pos.z-100)*ez\nlocal jSide=(janlenoux.pos.x-100)*ex+(janlenoux.pos.z-100)*ez\nif math.abs(aSide-jSide)<1 then return end\nlocal west = aSide<jSide and adelphel or janlenoux\nlocal east = aSide<jSide and janlenoux or adelphel\nlocal knight = isMT and west or east\nstate.knightID = knight.id\n\n\nlocal tethers = Argus.getTethersOnEnt(knight.id)\nfor _, tether in pairs(tethers or {}) do\n    if tether.type == 84 and tether.partnerid == player.id then\n        self.used = true\n        return\n    end\nend\nlocal capture = data.frog_bash\nif capture and capture.holders and capture.holders[knight.id] == player.id then\n    self.used = true\n    return\nend\n\nfrogGuide.draw(\"p2_strength\",TensorCore.getCachedDrawer(nil,nil,0xFFFF8000,nil,1.5,0,flags),\n    player.pos.x,player.pos.y,player.pos.z,\n    knight.pos.x,knight.pos.y,knight.pos.z,8,2)\nself.used = true\n",
							name = "Shield Bash role guidance",
							uuid = "4018cefd-a34c-2b01-8d77-83359b2e16fe",
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
				name = "[Draw] Arrow to Relative-West Knight",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.6,
				timerStartOffset = -4,
				uuid = "52ad2556-54fb-1211-8925-7b8a895ed059",
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
							actionLua = "data.frog_bash=data.frog_bash or {}\nlocal s=data.frog_bash\nif not s.defams then s.defams={};s.defamCount=0 end\nif not s.defams[eventArgs.entityID]then s.defams[eventArgs.entityID]=true;s.defamCount=s.defamCount+1 end\nself.used=true\n",
							conditions =
							{

								{
									"fc3ff382-6e26-86b6-9abc-80a1863de952",
									true,
								},
							},
							name = "Capture Shield Bash Defamation",
							uuid = "a0774854-1a39-2f8a-9497-c5a1dd18de70",
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
								330,
							},
							name = "Defamation Marker",
							uuid = "fc3ff382-6e26-86b6-9abc-80a1863de952",
							version = 3,
						},
					},
				},
				eventType = 4,
				loop = true,
				mechanicTime = 335.3,
				name = "[Draw] Shield Bash Defamation Capture",
				timeRange = true,
				timelineIndex = 50,
				timerEndOffset = 13.60000038147,
				uuid = "ab430d1d-e935-6288-909f-9fda143ffeb4",
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
							actionLua = "local cid = eventArgs.entityContentID\nif cid ~= 3633 and cid ~= 3634 and cid ~= 3635 then\n    self.used = true\n    return\nend\n\nlocal state = data.sam_sanctity_flex\nif state == nil then\n    state = {}\n    data.sam_sanctity_flex = state\nend\n\n\n\n\nif cid == 3633 then\n    state = {\n        captureInitialized = true,\n        markers = {},\n        zephirinLocked = false,\n        knightBias = nil,\n        zephirinID = eventArgs.entityID,\n        adelphelID = state.adelphelID,\n        janlenouxID = state.janlenouxID\n    }\n    data.sam_sanctity_flex = state\nelseif state.captureInitialized ~= true then\n    state.captureInitialized = true\n    state.markers = {}\n    state.zephirinLocked = false\n    state.knightBias = nil\nend\n\nif cid == 3634 then\n    state.adelphelID = eventArgs.entityID\nelseif cid == 3635 then\n    state.janlenouxID = eventArgs.entityID\nend\n\nself.used = true",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p2_sanctity\")==\"Disabled\" then self.used=true return end\n\nlocal state = data.sam_sanctity_flex\nif state == nil or state.markers == nil or\n   state.zephirinID == nil or state.adelphelID == nil or state.janlenouxID == nil then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nlocal zephirin = TensorCore.mGetEntity(state.zephirinID)\nlocal adelphel = TensorCore.mGetEntity(state.adelphelID)\nlocal janlenoux = TensorCore.mGetEntity(state.janlenouxID)\nif player == nil or player.pos == nil or\n   zephirin == nil or zephirin.pos == nil or\n   adelphel == nil or adelphel.pos == nil or\n   janlenoux == nil or janlenoux.pos == nil then\n    return\nend\n\nlocal mySlot = AnyoneCore.Roster.mySlot()\nif mySlot == nil then\n    return\nend\n\nlocal groupOneSlots = {\n    T1 = true,\n    H1 = true,\n    M1 = true,\n    R1 = true\n}\nlocal partnerSlots = {\n    T1 = \"T2\",\n    T2 = \"T1\",\n    H1 = \"H2\",\n    H2 = \"H1\",\n    M1 = \"M2\",\n    M2 = \"M1\",\n    R1 = \"R2\",\n    R2 = \"R1\"\n}\n\nlocal baseGroup\nif groupOneSlots[mySlot] == true then\n    baseGroup = 1\nelseif partnerSlots[mySlot] ~= nil then\n    baseGroup = 2\nelse\n    return\nend\n\nlocal otherSlot = partnerSlots[mySlot]\nlocal otherID = nil\n\n\n\n\nlocal rosterMembers = AnyoneCore.Roster.members()\nlocal agnosticParty = AnyoneCore.API.getAgnosticPartyList()\nif type(rosterMembers) == \"table\" and type(agnosticParty) == \"table\" then\n    local partner = rosterMembers[otherSlot]\n    if partner ~= nil and partner.name ~= nil and partner.job ~= nil then\n        local actorByJob = {}\n        local actorJobCount = {}\n        local rosterJobCount = {}\n\n        for _, actor in pairs(agnosticParty) do\n            if actor ~= nil and actor.id ~= nil and actor.job ~= nil then\n                actorJobCount[actor.job] = (actorJobCount[actor.job] or 0) + 1\n                actorByJob[actor.job] = actor\n            end\n        end\n\n        for _, member in pairs(rosterMembers) do\n            if member ~= nil and member.job ~= nil then\n                rosterJobCount[member.job] = (rosterJobCount[member.job] or 0) + 1\n            end\n        end\n\n        local partnerKey = tostring(partner.name) .. \"\\31\" .. tostring(partner.job)\n        for _, actor in pairs(agnosticParty) do\n            if actor ~= nil and actor.id ~= nil\n                and actor.name ~= nil and actor.job ~= nil\n                and tostring(actor.name) .. \"\\31\" .. tostring(actor.job) == partnerKey then\n                otherID = actor.id\n                break\n            end\n        end\n\n        if otherID == nil and actorJobCount[partner.job] == 1 and\n           rosterJobCount[partner.job] == 1 then\n            local uniqueActor = actorByJob[partner.job]\n            if uniqueActor ~= nil then\n                otherID = uniqueActor.id\n            end\n        end\n    end\nend\n\nlocal playerMarker = state.markers[player.id]\nlocal otherMarker = nil\nif otherID ~= nil then\n    otherMarker = state.markers[otherID]\nend\n\nlocal finalGroup = baseGroup\nif playerMarker == 50 then\n    finalGroup = 1\nelseif playerMarker == 51 then\n    finalGroup = 2\nelseif otherMarker == 50 then\n    finalGroup = 2\nelseif otherMarker == 51 then\n    finalGroup = 1\nend\n\nif state.zephirinLocked ~= true then\n    local zx = zephirin.pos.x - 100.0\n    local zz = zephirin.pos.z - 100.0\n    if math.abs(zx) < 8.0 or math.abs(zz) < 8.0 then\n        return\n    end\n    state.zephirinX = zephirin.pos.x\n    state.zephirinZ = zephirin.pos.z\n    state.zephirinLocked = true\nend\n\nif state.knightBias == nil then\n    local west, east\n    if math.abs(adelphel.pos.x - 95.0) <= 0.75 and\n       math.abs(janlenoux.pos.x - 105.0) <= 0.75 then\n        west, east = adelphel, janlenoux\n    elseif math.abs(janlenoux.pos.x - 95.0) <= 0.75 and\n           math.abs(adelphel.pos.x - 105.0) <= 0.75 then\n        west, east = janlenoux, adelphel\n    else\n        return\n    end\n\n    if math.abs(west.pos.z - 100.0) > 0.75 or\n       math.abs(east.pos.z - 100.0) > 0.75 or\n       west.pos.h == nil or east.pos.h == nil then\n        return\n    end\n\n    if math.abs(west.pos.h) > 1.5 and math.abs(east.pos.h) < 1.5 then\n        state.knightBias = 1\n    elseif math.abs(west.pos.h) < 1.5 and math.abs(east.pos.h) > 1.5 then\n        state.knightBias = -1\n    else\n        return\n    end\nend\n\nlocal dx = state.zephirinX - 100.0\nlocal dz = state.zephirinZ - 100.0\nlocal radius = math.sqrt(dx * dx + dz * dz)\nif radius <= 0.0 then\n    return\nend\n\nlocal directionX = dx / radius\nlocal directionZ = dz / radius\nif finalGroup == 1 then\n    directionX = -directionX\n    directionZ = -directionZ\nend\n\nlocal biasRadians = state.knightBias * 0.2094395102\nlocal cosine = math.cos(biasRadians)\nlocal sine = math.sin(biasRadians)\nlocal adjustedX = directionX * cosine - directionZ * sine\nlocal adjustedZ = directionX * sine + directionZ * cosine\nlocal targetX = 100.0 + adjustedX * 20.25\nlocal targetZ = 100.0 + adjustedZ * 20.25\n\nif state.drawer == nil then\n    state.drawer = TensorCore.getCachedFlatDrawer(\n        nil, nil, 0xFF0000FF, nil, 1.0, 0, 0\n    )\nend\n\nfrogGuide.draw(\"p2_sanctity\",state.drawer,\n    player.pos.x, player.pos.y, player.pos.z,\n    targetX, 0.05, targetZ,\n    8.0, 2.0\n)\n\nself.used = true\n",
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
							actionLua = "\nlocal state = data.sam_sanctity_draw\nif state == nil then\n    state = {}\n    data.sam_sanctity_draw = state\nend\n\nif state.predictionDrawn == true then\n    self.used = true\n    return\nend\n\nlocal now = TensorReactions_CurrentTimer or 0.0\nlocal predictionEnd = 399.3\nlocal arenaEnd = 404.9\nlocal predictionTimeout = math.floor((predictionEnd - now) * 1000.0)\nlocal arenaTimeout = math.floor((arenaEnd - now) * 1000.0)\nif arenaTimeout <= 0 then\n    self.used = true\n    return\nend\n\nlocal centerX, centerY, centerZ = 100.0, 0.0, 100.0\nlocal arenaRadius, orbRadius, laneWidth = 21.0, 9.0, 8.0\nlocal channel, drawHeight = 1, 0.05\nlocal baseFlags =\n    Argus2.RenderFlags.FLAG_OCCLUSION_BASE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal occludeFlags =\n    Argus2.RenderFlags.FLAG_OCCLUDE |\n    Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n\nif state.baseDrawn ~= true then\n    local base = TensorCore.getStaticFlatDrawer(0x5500FF00, 1.0, channel, baseFlags)\n    base:setHeightOffset(drawHeight)\n    base:addTimedCircle(arenaTimeout, centerX, centerY, centerZ, arenaRadius, 0, false, true, baseFlags)\n    state.baseDrawn = true\nend\n\nif predictionTimeout <= 0 then\n    self.used = true\n    return\nend\n\nif state.entityIDs == nil or\n   state.entityIDs[3634] == nil or state.entityIDs[3635] == nil then\n    self.used = true\n    return\nend\n\nlocal adelphel = TensorCore.mGetEntity(state.entityIDs[3634])\nlocal janlenoux = TensorCore.mGetEntity(state.entityIDs[3635])\nif adelphel == nil or janlenoux == nil or\n   adelphel.pos == nil or janlenoux.pos == nil or\n   adelphel.pos.x == nil or janlenoux.pos.x == nil or\n   adelphel.pos.z == nil or janlenoux.pos.z == nil or\n   adelphel.pos.h == nil or janlenoux.pos.h == nil then\n    self.used = true\n    return\nend\n\nlocal west, east\nif adelphel.pos.x < 100.0 and janlenoux.pos.x > 100.0 then\n    west, east = adelphel, janlenoux\nelseif janlenoux.pos.x < 100.0 and adelphel.pos.x > 100.0 then\n    west, east = janlenoux, adelphel\nelse\n    self.used = true\n    return\nend\n\nif math.abs(west.pos.x - 95.0) > 0.5 or math.abs(west.pos.z - 100.0) > 0.5 or\n   math.abs(east.pos.x - 105.0) > 0.5 or math.abs(east.pos.z - 100.0) > 0.5 then\n    self.used = true\n    return\nend\n\n\n\nstate.armed = true\n\nlocal westFacingPi = math.abs(west.pos.h) > 1.5\nlocal eastFacingZero = math.abs(east.pos.h) < 1.5\nlocal pattern\n\nif westFacingPi and eastFacingZero then\n    pattern = {\n        {\n            start = {x = 95.0, z = 100.0},\n            finish = {x = 100.0, z = 79.0},\n            orbs = {\n                {x = 95.000, z = 100.000},\n                {x = 97.502, z = 89.494},\n                {x = 100.000, z = 79.000}\n            }\n        },\n        {\n            start = {x = 105.0, z = 100.0},\n            finish = {x = 100.0, z = 121.0},\n            orbs = {\n                {x = 105.000, z = 100.000},\n                {x = 102.498, z = 110.506},\n                {x = 100.000, z = 121.000}\n            }\n        }\n    }\nelseif (not westFacingPi) and (not eastFacingZero) then\n    pattern = {\n        {\n            start = {x = 95.0, z = 100.0},\n            finish = {x = 100.0, z = 121.0},\n            orbs = {\n                {x = 95.000, z = 100.000},\n                {x = 97.502, z = 110.506},\n                {x = 100.000, z = 121.000}\n            }\n        },\n        {\n            start = {x = 105.0, z = 100.0},\n            finish = {x = 100.0, z = 79.0},\n            orbs = {\n                {x = 105.000, z = 100.000},\n                {x = 102.498, z = 89.494},\n                {x = 100.000, z = 79.000}\n            }\n        }\n    }\nelse\n    self.used = true\n    return\nend\n\nlocal cut = TensorCore.getStaticFlatDrawer(0x00000000, 0.0, channel, occludeFlags)\ncut:setHeightOffset(drawHeight)\n\nfor _, dash in ipairs(pattern) do\n    local dx = dash.finish.x - dash.start.x\n    local dz = dash.finish.z - dash.start.z\n    local length = math.sqrt(dx * dx + dz * dz)\n    local heading = TensorCore.getHeadingToTarget(dash.start, dash.finish)\n    cut:addTimedCenteredRect(\n        predictionTimeout,\n        (dash.start.x + dash.finish.x) * 0.5,\n        centerY,\n        (dash.start.z + dash.finish.z) * 0.5,\n        length,\n        laneWidth,\n        heading,\n        0,\n        false,\n        true,\n        occludeFlags\n    )\n\n    for _, orb in ipairs(dash.orbs) do\n        cut:addTimedCircle(\n            predictionTimeout,\n            orb.x,\n            centerY,\n            orb.z,\n            orbRadius,\n            0,\n            false,\n            true,\n            occludeFlags\n        )\n    end\nend\n\nstate.predictionDrawn = true\nself.used = true\n",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p2_sanctity\")==\"Disabled\" then self.used=true return end\n\nlocal state = data.sam_hiemal_meteor\nif state == nil\n    or state.towersResolved ~= true\n    or state.towerByID == nil then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    return\nend\n\nlocal tower = state.towerByID[player.id]\nif tower == nil then\n    return\nend\n\nlocal drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, 0xFF0000FF, nil, 1.1, 0, 0\n)\n\nfrogGuide.draw(\"p2_sanctity\",drawer,\n    player.pos.x, player.pos.y, player.pos.z,\n    tower.x, tower.y or 0.05, tower.z,\n    8.0, 2.0\n)\n\nself.used=true\n",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\n\nlocal state = data.sam_hiemal_meteor\nif state == nil or state.marked == nil or state.markerCount < 2 then\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    return\nend\n\nif state.slotOrder == nil then\n    state.slotOrder = {\"MT\", \"OT\", \"H1\", \"H2\", \"M1\", \"M2\", \"R1\", \"R2\"}\n    state.definitions = {\n        {name = \"MT\", cardinal = \"N\"},\n        {name = \"OT\", cardinal = \"S\"},\n        {name = \"H1\", cardinal = \"W\"},\n        {name = \"H2\", cardinal = \"E\"},\n        {name = \"M1\", cardinal = \"W\"},\n        {name = \"M2\", cardinal = \"E\"},\n        {name = \"R1\", cardinal = \"N\"},\n        {name = \"R2\", cardinal = \"S\"}\n    }\nend\n\nif state.meteorSolverVersion ~= 5 then\n    state.meteorSolverVersion = 5\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.towerByID = nil\nend\n\nif state.assignmentsReady ~= true then\nlocal rosterSlotByName = {\n    MT = \"T1\",\n    OT = \"T2\",\n    H1 = \"H1\",\n    H2 = \"H2\",\n    M1 = \"M1\",\n    M2 = \"M2\",\n    R1 = \"R1\",\n    R2 = \"R2\"\n}\nlocal refreshedSlots = {}\nlocal refreshedInitialCardinal = {}\nlocal rosterIDs = {}\n\n\n\n\nlocal rosterMembers = AnyoneCore.Roster.members()\nlocal agnosticParty = AnyoneCore.API.getAgnosticPartyList()\nif type(rosterMembers) ~= \"table\" or type(agnosticParty) ~= \"table\" then\n    return\nend\n\nlocal actorByJob, actorJobCount, rosterJobCount = {}, {}, {}\nfor _, actor in pairs(agnosticParty) do\n    if actor.id ~= nil and actor.job ~= nil then\n        actorByJob[actor.job] = actor\n        actorJobCount[actor.job] = (actorJobCount[actor.job] or 0) + 1\n    end\nend\nfor _, member in pairs(rosterMembers) do\n    if member.job ~= nil then\n        rosterJobCount[member.job] = (rosterJobCount[member.job] or 0) + 1\n    end\nend\nlocal actorByNameJob = {}\nfor _, actor in pairs(agnosticParty) do\n    if actor ~= nil and actor.id ~= nil and actor.name ~= nil and actor.job ~= nil then\n        local key = tostring(actor.name) .. \"\\31\" .. tostring(actor.job)\n        actorByNameJob[key] = actor\n    end\nend\n\nfor _, definition in ipairs(state.definitions) do\n    local rosterSlot = rosterSlotByName[definition.name]\n    local member = rosterMembers[rosterSlot]\n    if member == nil or member.name == nil or member.job == nil then\n        return\n    end\n\n    local key = tostring(member.name) .. \"\\31\" .. tostring(member.job)\n    local actor = actorByNameJob[key]\n    \n    if actor == nil and actorJobCount[member.job] == 1 and rosterJobCount[member.job] == 1 then\n        actor = actorByJob[member.job]\n    end\n    if actor == nil or actor.id == nil then\n        return\n    end\n\n    local kind\n    if definition.name == \"MT\" or definition.name == \"OT\"\n        or definition.name == \"H1\" or definition.name == \"H2\" then\n        kind = \"SUPPORT\"\n    else\n        kind = \"DPS\"\n    end\n\n    local id = actor.id\n    refreshedSlots[definition.name] = {\n        id = id,\n        cardinal = definition.cardinal,\n        kind = kind\n    }\n    refreshedInitialCardinal[id] = definition.cardinal\n    rosterIDs[#rosterIDs + 1] = definition.name .. \"=\" .. tostring(id)\nend\n\nlocal rosterSignature = table.concat(rosterIDs, \":\")\nif state.rosterSignature ~= rosterSignature then\n    state.rosterSignature = rosterSignature\n    state.assignmentsReady = false\n    state.towersResolved = false\n    state.finalCardinal = nil\n    state.rotatedFrom = nil\n    state.meteorPlayers = nil\n    state.towerByID = nil\n    state.quadrants = nil\nend\n\nstate.slots = refreshedSlots\nstate.initialCardinal = refreshedInitialCardinal\n\nlocal meteorPlayers = {}\nlocal meteorKind = nil\nfor _, slotName in ipairs(state.slotOrder) do\n    local slot = state.slots[slotName]\n    if slot ~= nil and state.marked[slot.id] == true then\n        meteorPlayers[#meteorPlayers + 1] = slot\n        if meteorKind == nil then\n            meteorKind = slot.kind\n        elseif meteorKind ~= slot.kind then\n            return\n        end\n    end\nend\n\nif #meteorPlayers < 2 or meteorKind == nil then\n    return\nend\n\nif state.assignmentsReady ~= true then\n    state.finalCardinal = {}\n    state.rotatedFrom = {}\n    state.meteorPlayers = meteorPlayers\n\n    local occupied = {N = false, S = false}\n    for _, slot in ipairs(state.slotOrder) do\n        local entry = state.slots[slot]\n        state.finalCardinal[entry.id] = entry.cardinal\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"N\" or entry.cardinal == \"S\") then\n            occupied[entry.cardinal] = true\n        end\n    end\n\n    \n    \n    \n    \n    for _, slotName in ipairs(state.slotOrder) do\n        local entry = state.slots[slotName]\n        if state.marked[entry.id] == true\n            and (entry.cardinal == \"W\" or entry.cardinal == \"E\") then\n            local target = entry.cardinal == \"W\" and \"N\" or \"S\"\n            if occupied[target] == true then\n                target = target == \"N\" and \"S\" or \"N\"\n            end\n            state.finalCardinal[entry.id] = target\n            state.rotatedFrom[target] = entry.cardinal\n            occupied[target] = true\n        end\n    end\n\n    \n    \n    for target, originalCardinal in pairs(state.rotatedFrom) do\n        for _, slotName in ipairs(state.slotOrder) do\n            local entry = state.slots[slotName]\n            if entry.kind == meteorKind\n                and state.marked[entry.id] ~= true\n                and entry.cardinal == target then\n                state.finalCardinal[entry.id] = originalCardinal\n                break\n            end\n        end\n    end\n\n    state.meteorKind = meteorKind\n    state.assignmentsReady = true\nend\n\nend \n\nlocal fixedSpot = {\n    N = {x = 100.0, z = 89.5},\n    E = {x = 110.5, z = 100.0},\n    S = {x = 100.0, z = 110.5},\n    W = {x = 89.5, z = 100.0}\n}\n\nlocal drawer = TensorCore.getCachedFlatDrawer(\n    nil, nil, 0xFF0000FF, nil, 1.0, 0, 0\n)\n\nif TensorReactions_CurrentTimer < 415.2 then\n    local initialCardinal = state.finalCardinal[player.id]\n    if initialCardinal ~= nil then\n        local destination = fixedSpot[initialCardinal]\n        if destination ~= nil then\n            frogGuide.draw(\"p2_sanctity\",drawer,\n                player.pos.x, player.pos.y, player.pos.z,\n                destination.x, destination.y or 0.05, destination.z,\n                8.0, 2.0\n            )\n        end\n    end\nend\n\nif state.towersResolved ~= true then\n    if state.towerCount ~= 8 then return end\n    local outer = {N = {}, E = {}, S = {}, W = {}}\n    local inner = {}\n    local cardinals = {\"N\", \"E\", \"S\", \"W\"}\n    local axis = {N = {0,-1}, E = {1,0}, S = {0,1}, W = {-1,0}}\n    local function inside(t)\n        local x,z = t.x-100,t.z-100\n        return x*x+z*z < 64\n    end\n    local function lateral(t,c)\n        local a = axis[c]\n        return -(t.x-100)*a[2]+(t.z-100)*a[1]\n    end\n    local function distance(a,b)\n        return (a.x-b.x)^2+(a.z-b.z)^2\n    end\n    for _,t in pairs(state.towers) do\n        if inside(t) then\n            inner[#inner+1] = t\n        else\n            local x,z = t.x-100,t.z-100\n            local c\n            if math.abs(z)>=math.abs(x) then c=z<0 and \"N\" or \"S\"\n            else c=x>0 and \"E\" or \"W\" end\n            outer[c][#outer[c]+1]=t\n        end\n    end\n    \n    local function order(a,b)\n        if a.x ~= b.x then return a.x < b.x end\n        return a.z < b.z\n    end\n    table.sort(inner,order)\n    for _,c in ipairs(cardinals) do table.sort(outer[c],order) end\n    local assigned,used = {},{}\n    local first,second = state.meteorPlayers[1],state.meteorPlayers[2]\n    local c1,c2 = state.finalCardinal[first.id],state.finalCardinal[second.id]\n    if not ((c1==\"N\" and c2==\"S\") or (c1==\"S\" and c2==\"N\")) then return end\n    local bestA,bestB,bestCenters,bestDistance,bestPreference = nil,nil,-1,-1,-math.huge\n    for _,a in ipairs(outer[c1]) do\n        for _,b in ipairs(outer[c2]) do\n            \n            local centers = (math.abs(lateral(a,c1))<0.5 and 1 or 0)\n                +(math.abs(lateral(b,c2))<0.5 and 1 or 0)\n            local d=math.sqrt(distance(a,b))\n            \n            \n            \n            local preference=lateral(a,c1)+lateral(b,c2)\n            if d>bestDistance+0.1 or (math.abs(d-bestDistance)<=0.1 and\n                (centers>bestCenters or\n                    (centers==bestCenters and preference>bestPreference))) then\n                bestA,bestB,bestCenters,bestDistance,bestPreference=a,b,centers,d,preference\n            end\n        end\n    end\n    if bestA==nil or bestB==nil then return end\n    assigned[first.id],assigned[second.id]=bestA,bestB\n    used[bestA],used[bestB]=true,true\n    local innerPlayers={}\n    for _,c in ipairs(cardinals) do\n        local other,meteorRole\n        for _,name in ipairs(state.slotOrder) do\n            local entry=state.slots[name]\n            if state.finalCardinal[entry.id]==c then\n                if entry.kind==state.meteorKind then meteorRole=entry else other=entry end\n            end\n        end\n        if other==nil or meteorRole==nil or #outer[c]<1 then return end\n        if #outer[c]==1 then\n            \n            local t=outer[c][1]\n            if assigned[meteorRole.id]~=nil and assigned[meteorRole.id]~=t then return end\n            assigned[meteorRole.id]=t\n            used[t]=true\n            innerPlayers[#innerPlayers+1]={id=other.id,cardinal=c}\n        else\n            \n            \n            \n            if assigned[meteorRole.id]==nil then\n                for _,t in ipairs(outer[c]) do\n                    if not used[t] and math.abs(lateral(t,c))<0.5 then\n                        assigned[meteorRole.id]=t\n                        used[t]=true\n                        break\n                    end\n                end\n            end\n            \n            local best\n            for _,t in ipairs(outer[c]) do\n                if not used[t] and (best==nil or lateral(t,c)<lateral(best,c)) then best=t end\n            end\n            if best==nil then return end\n            assigned[other.id]=best\n            used[best]=true\n            if assigned[meteorRole.id]==nil then\n                local remaining\n                for _,t in ipairs(outer[c]) do\n                    if not used[t] then remaining=t break end\n                end\n                if remaining==nil then return end\n                assigned[meteorRole.id]=remaining\n                used[remaining]=true\n            end\n        end\n    end\n    if #innerPlayers~=#inner then return end\n    \n    \n    local picks,bestPicks={},nil\n    local bestClaims,bestTravel=-1,math.huge\n    local function search(i,claims,travel)\n        if i>#innerPlayers then\n            if claims>bestClaims or (claims==bestClaims and travel<bestTravel) then\n                bestClaims,bestTravel=claims,travel\n                bestPicks={}\n                for k,t in ipairs(picks) do bestPicks[k]=t end\n            end\n            return\n        end\n        local a=axis[innerPlayers[i].cardinal]\n        for _,t in ipairs(inner) do\n            if not used[t] then\n                local x,z=t.x-100,t.z-100\n                local forward=x*a[1]+z*a[2]\n                local side=-x*a[2]+z*a[1]\n                local angle=math.atan2(side,forward)\n                if angle<0 then angle=angle+2*math.pi end\n                local claim=(forward>0.5 and side>0.5) and 1 or 0\n                picks[i]=t\n                used[t]=true\n                search(i+1,claims+claim,travel+angle)\n                used[t]=nil\n                picks[i]=nil\n            end\n        end\n    end\n    search(1,0,0)\n    if bestPicks==nil then return end\n    for i,entry in ipairs(innerPlayers) do assigned[entry.id]=bestPicks[i] end\n    \n    local check={}\n    for _,name in ipairs(state.slotOrder) do\n        local entry=state.slots[name]\n        local t=assigned[entry.id]\n        if t==nil or check[t] then return end\n        check[t]=true\n        if entry.kind==state.meteorKind and inside(t) then return end\n        if entry.kind~=state.meteorKind and #outer[state.finalCardinal[entry.id]]==1\n            and not inside(t) then return end\n    end\n    state.quadrants=outer\n    state.towerByID=assigned\n    state.towersResolved=true\nend\nself.used=true\n",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p2_sanctity\")==\"Disabled\" then self.used=true return end\n\nlocal state = data.sam_hiemal_meteor\nif state == nil\n    or state.marked == nil\n    or state.markerCount < 2\n    or state.slots == nil\n    or state.slotOrder == nil\n    or state.initialCardinal == nil\n    or state.finalCardinal == nil\n    or state.meteorKind == nil then\n    self.used = true\n    return\nend\n\nlocal player = TensorCore.mGetPlayer()\nif player == nil or player.id == nil or player.pos == nil then\n    self.used = true\n    return\nend\n\nlocal playerKind = nil\nfor _, slotName in ipairs(state.slotOrder) do\n    local slot = state.slots[slotName]\n    if slot ~= nil and slot.id == player.id then\n        playerKind = slot.kind\n        break\n    end\nend\n\nlocal target = nil\nlocal isMeteor = state.marked[player.id] == true\nlocal resolvedCardinal = state.finalCardinal[player.id]\nlocal startingCardinal = state.initialCardinal[player.id]\n\n\nlocal finalTower = {\n    N = {x = 100.000, z = 82.000},\n    NE = {x = 112.728, z = 87.272},\n    E = {x = 118.000, z = 100.000},\n    SE = {x = 112.728, z = 112.728},\n    S = {x = 100.000, z = 118.000},\n    SW = {x = 87.272, z = 112.728},\n    W = {x = 82.000, z = 100.000},\n    NW = {x = 87.272, z = 87.272}\n}\n\nif playerKind == state.meteorKind then\n    if isMeteor then\n        \n        if resolvedCardinal == \"N\" then\n            target = finalTower.S\n        elseif resolvedCardinal == \"S\" then\n            target = finalTower.N\n        end\n    else\n        \n        if resolvedCardinal == \"E\" then\n            target = finalTower.E\n        elseif resolvedCardinal == \"W\" then\n            target = finalTower.W\n        end\n    end\nelse\n    \n    if startingCardinal == \"N\" then\n        target = finalTower.NE\n    elseif startingCardinal == \"E\" then\n        target = finalTower.SE\n    elseif startingCardinal == \"S\" then\n        target = finalTower.SW\n    elseif startingCardinal == \"W\" then\n        target = finalTower.NW\n    end\nend\n\nif target == nil then\n    self.used = true\n    return\nend\n\nif state.finalDrawer == nil then\n    state.finalDrawer = TensorCore.getCachedFlatDrawer(nil, nil, 0xFF0000FF, nil, 1.0, 0, 0)\nend\n\nfrogGuide.draw(\"p2_sanctity\",state.finalDrawer,\n    player.pos.x, player.pos.y, player.pos.z,\n    target.x, 0.05, target.z,\n    8.0, 2.0\n)\n\nself.used = true\n",
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
	[82] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "bc32cf22-ae16-829b-a643-10a0944def43",
			},
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "f865b9f9-6b8c-b58e-bd53-ba7f5ca6f1ed",
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
							actionLua = "local s=data.frog_mnk_downtime\nif not s then self.used=true return end\nif Now()>(s.pbUntil or 0) then s.remaining=0 end\nif Now()>(s.chakraUntil or 0) then s.chakra=0 end\ns.prep={key=\"Sanctity Blitz preparation\",start=Now(),solar=not s.solar,blitz=(s.solar and s.lunar) and 25769 or ((not s.solar) and 25768 or 3545)}\nself.used=true",
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"88bee733-0b76-6112-9448-983bfc1b85c9",
									true,
								},

								{
									"354217f8-3ec1-1964-980a-7c03edbf18ba",
									true,
								},
							},
							name = "Choose missing Nadi once",
							uuid = "a31705f3-2778-ac68-924c-04462536dabc",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 69,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"67e4b75d-4e15-1f11-bd6e-7326022208f6",
									true,
								},

								{
									"354217f8-3ec1-1964-980a-7c03edbf18ba",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "ee09da83-1eb5-13be-97ab-dcad6ebbe9db",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"a11de2e6-1ef5-dcad-8352-63b0409ab99f",
									true,
								},
							},
							uuid = "e5822efe-add7-ae07-a338-004d4dc6cdaf",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 16473,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"d6067bb8-1b4d-835e-8599-a510b6a8b1a5",
									true,
								},

								{
									"2be86509-c650-e0b6-a5f9-066b43a0b432",
									true,
								},
							},
							uuid = "be558299-f982-607c-a125-788e4fac0a23",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"d6067bb8-1b4d-835e-8599-a510b6a8b1a5",
									true,
								},

								{
									"01e64533-fc0a-b086-bf57-50c7a7af9039",
									true,
								},
							},
							uuid = "9bbe431b-70e9-84fb-b937-8a4f83e0bf91",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 70,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"f2eca9c5-171c-3b7a-96fd-0aa8a6d84387",
									true,
								},

								{
									"2be86509-c650-e0b6-a5f9-066b43a0b432",
									true,
								},
							},
							uuid = "fc633811-d3dc-3efa-bd34-1cb7fb4a52a1",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"3c282dca-0764-f9fe-8fc6-c3400fe465b0",
									true,
								},

								{
									"e4c06415-72ce-cf30-8e2c-e51e7943c62f",
									true,
								},

								{
									"0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
									true,
								},

								{
									"36a1686a-06f6-c55f-86c6-fd0b3d32be59",
									true,
								},

								{
									"f2eca9c5-171c-3b7a-96fd-0aa8a6d84387",
									true,
								},

								{
									"01e64533-fc0a-b086-bf57-50c7a7af9039",
									true,
								},
							},
							uuid = "7c794613-79a5-d7a3-93a2-0d37874cd70e",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "3c282dca-0764-f9fe-8fc6-c3400fe465b0",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "e4c06415-72ce-cf30-8e2c-e51e7943c62f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "0c5a2957-d196-4b2a-9bb6-e11f2d03671a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn not t or not t.targetable or not t.attackable or t.hp.current<=0",
							name = "No attackable current target",
							uuid = "36a1686a-06f6-c55f-86c6-fd0b3d32be59",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nif not s or not s.known then return false end\nlocal t=Now()\nreturn (s.remaining==0 or t>(s.pbUntil or 0)) and (s.chakra==0 or t>(s.chakraUntil or 0))",
							name = "Nadi known; no pending PB or Blitz",
							uuid = "88bee733-0b76-6112-9448-983bfc1b85c9",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 69,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "354217f8-3ec1-1964-980a-7c03edbf18ba",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"Sanctity Blitz preparation\" and Now()-s.prep.start<10000 and ((s.remaining==0 or Now()>(s.pbUntil or 0)) and s.chakra==0)",
							name = "PB stage 0",
							uuid = "67e4b75d-4e15-1f11-bd6e-7326022208f6",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"Sanctity Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==3 and s.chakra==0 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 1",
							uuid = "a11de2e6-1ef5-dcad-8352-63b0409ab99f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"Sanctity Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==2 and s.chakra==1 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 2",
							uuid = "d6067bb8-1b4d-835e-8599-a510b6a8b1a5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"Sanctity Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==1 and s.chakra==2 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 3",
							uuid = "f2eca9c5-171c-3b7a-96fd-0aa8a6d84387",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.solar",
							name = "Prepare Solar Nadi",
							uuid = "2be86509-c650-e0b6-a5f9-066b43a0b432",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and not s.prep.solar",
							name = "Prepare Lunar or Phantom",
							uuid = "01e64533-fc0a-b086-bf57-50c7a7af9039",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 439.2,
				name = "[MNK] Sanctity Blitz preparation",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = -0.2,
				timerStartOffset = -13,
				uuid = "e21e6ecf-d6a4-590b-bb15-eb4cb8294221",
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
							actionID = 25768,
							conditions =
							{

								{
									"24979f9a-dc30-179f-838b-cf6dd69ee14e",
									true,
								},

								{
									"3108d8f2-a969-362e-b306-aa666826eb4d",
									true,
								},

								{
									"dab33b10-91e5-2db1-95a7-f579262e7574",
									true,
								},

								{
									"2c3729a3-75eb-b768-a767-f696b5494c89",
									true,
								},

								{
									"83fe5685-2250-2b3e-a3c7-62c95e344550",
									true,
								},

								{
									"68e8a8ba-f949-9f22-a742-175e22b9f40d",
									true,
								},
							},
							uuid = "81237a2b-1018-b3fe-b95b-33911a896e3d",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 3545,
							conditions =
							{

								{
									"24979f9a-dc30-179f-838b-cf6dd69ee14e",
									true,
								},

								{
									"3108d8f2-a969-362e-b306-aa666826eb4d",
									true,
								},

								{
									"dab33b10-91e5-2db1-95a7-f579262e7574",
									true,
								},

								{
									"2c3729a3-75eb-b768-a767-f696b5494c89",
									true,
								},

								{
									"83fe5685-2250-2b3e-a3c7-62c95e344550",
									true,
								},

								{
									"128964e9-ec60-87fe-bdf6-25a65293dfa3",
									true,
								},
							},
							uuid = "97cd7937-d823-a3d1-b0d7-a3ecbcb7f9cb",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25769,
							conditions =
							{

								{
									"24979f9a-dc30-179f-838b-cf6dd69ee14e",
									true,
								},

								{
									"3108d8f2-a969-362e-b306-aa666826eb4d",
									true,
								},

								{
									"dab33b10-91e5-2db1-95a7-f579262e7574",
									true,
								},

								{
									"2c3729a3-75eb-b768-a767-f696b5494c89",
									true,
								},

								{
									"83fe5685-2250-2b3e-a3c7-62c95e344550",
									true,
								},

								{
									"00b186cb-9065-1d2c-afb9-515b80a2b807",
									true,
								},
							},
							targetType = "Current Target",
							uuid = "3e970b83-1b9d-cd03-a15e-90faf5128edf",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "24979f9a-dc30-179f-838b-cf6dd69ee14e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "3108d8f2-a969-362e-b306-aa666826eb4d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "dab33b10-91e5-2db1-95a7-f579262e7574",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.targetable and t.attackable and t.hp.current>0 and t.distance2d<=5+t.hitradius",
							name = "Live target in Blitz range",
							uuid = "2c3729a3-75eb-b768-a767-f696b5494c89",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"Sanctity Blitz preparation\" and s.chakra==3 and Now()<=(s.chakraUntil or 0)",
							name = "Our Blitz is prepared",
							uuid = "83fe5685-2250-2b3e-a3c7-62c95e344550",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25768",
							name = "Prepared Blitz 25768",
							uuid = "68e8a8ba-f949-9f22-a742-175e22b9f40d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==3545",
							name = "Prepared Blitz 3545",
							uuid = "128964e9-ec60-87fe-bdf6-25a65293dfa3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25769",
							name = "Prepared Blitz 25769",
							uuid = "00b186cb-9065-1d2c-afb9-515b80a2b807",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 439.2,
				name = "[MNK] Sanctity Blitz preparation release",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 8,
				uuid = "09f9b098-0c9a-174f-b90e-705932facb73",
				version = 2,
			},
		},
	},
	[86] =
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
							actionLua = "\n\nif eventArgs.entityContentID~=3632 then self.used=true return end\nlocal id=eventArgs.spellID\nif id~=25536 and id~=25537 then self.used=true return end\nlocal boss=TensorCore.mGetEntity(eventArgs.entityID)\nif not boss then self.used=true return end\nlocal p=boss.pos\nlocal h=eventArgs.heading\nlocal turn=id==25537 and math.pi/3 or -math.pi/3\nlocal color=GUI:ColorConvertFloat4ToU32(1,0,0,0.9)\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n\nlocal function cone(duration,delay,heading)\n Argus2.addTimedConeFilled(duration,p.x,p.y,p.z,40,2*math.pi/3,heading,30,\n  color,color,nil,delay,nil,nil,nil,1,1.5,0.5,2,false,true,0,true,flags)\nend\ncone(800,0,h+turn)\ncone(1000,800,h-turn)\ncone(1000,1800,h+math.pi)\nself.used=true",
							name = "Broad Swing Cones",
							uuid = "68134a2d-a1ab-9224-a935-da6bb6dabed6",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 2,
				loop = true,
				mechanicTime = 465.3,
				name = "[Draw] P2 Broad Swing Timed Cones",
				timeRange = true,
				timelineIndex = 86,
				timerEndOffset = 15,
				timerStartOffset = -5,
				uuid = "6d3b62a4-bd8f-e044-857a-b2c1fd5d91a0",
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
							actionLua = "local old = data.frog_dfg_v2\nlocal s = {line=old and old.line or {}, positions={}, jump={}, side={}, placement={}, planned={}, towers={{},{},{}}, placed={}, resolved={0,0,0}, towerByCaster={}, resolvedCasters={{},{},{}}, stacks=0, geirLocked={}, ready=false}\ndata.frog_dfg_v2 = s\n\nlocal settings=data.frog_draw_settings and data.frog_draw_settings.settings\nif not settings then\n    local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n    if FileExists(path) then\n        local ok,saved=pcall(FileLoad,path)\n        if ok and type(saved)==\"table\" then settings=saved end\n    end\nend\ns.strategy=settings and settings.p3_strategy==\"LPDU\" and \"LPDU\" or \"NAUR\"\ns.faceSign=s.strategy==\"LPDU\" and 1 or -1\ns.customHold=settings~=nil and settings.p3_custom_hold==true\nlocal boss = TensorCore.mGetEntity(eventArgs.entityID)\nif not boss or not boss.pos or not boss.hitradius or boss.hitradius <= 0 then self.used=true return end\ns.bossID=boss.id\ns.center={x=boss.pos.x,y=boss.pos.y,z=boss.pos.z}\ns.radius=boss.hitradius\ns.drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\nlocal party=TensorCore.getEntityGroupList(\"Party\")\nfor _,e in pairs(party or {}) do\n    s.positions[e.id]={x=e.pos.x,y=e.pos.y,z=e.pos.z}\nend\nfunction s.assign()\n    if s.ready then return end\n    local counts={0,0,0}\n    local highs={true,true,true}\n    for id,p in pairs(s.positions) do\n        local line=s.line[id]\n        if not line then return end\n        local e=TensorCore.mGetEntity(id)\n        if not e then return end\n        if not s.jump[id] then\n            if TensorCore.hasBuff(e,2755) then s.jump[id]=1\n            elseif TensorCore.hasBuff(e,2756) then s.jump[id]=2\n            elseif TensorCore.hasBuff(e,2757) then s.jump[id]=3 end\n        end\n        if not s.jump[id] then return end\n        counts[line]=counts[line]+1\n        if s.jump[id]~=1 then highs[line]=false end\n    end\n    if counts[1]~=3 or counts[2]~=2 or counts[3]~=3 then return end\n    local westSecond\n    for id,p in pairs(s.positions) do\n        if s.line[id]==2 and (not westSecond or p.x<s.positions[westSecond].x or (p.x==s.positions[westSecond].x and id<westSecond)) then westSecond=id end\n    end\n    for id,p in pairs(s.positions) do\n        local line,jump=s.line[id],s.jump[id]\n        local side\n        if not highs[line] then\n            if jump==1 then side=\"S\"\n            elseif jump==2 then side=s.strategy==\"LPDU\" and \"W\" or \"E\"\n            else side=s.strategy==\"LPDU\" and \"E\" or \"W\" end\n        elseif line==2 then side=id==westSecond and \"W\" or \"E\"\n        else\n            local dx,dz=p.x-s.center.x,p.z-s.center.z\n            if -dx>=dz and dx<=0 then side=\"W\" elseif dx>=dz then side=\"E\" else side=\"S\" end\n        end\n        s.side[id]=side\n        local r=s.radius\n        local x,z=s.center.x,s.center.z\n        if line==2 then\n            local q=(r+1)/math.sqrt(2)\n            x=x+(side==\"W\" and -q or q); z=z-q\n        elseif side==\"W\" then x=x-r elseif side==\"E\" then x=x+r else z=z+r end\n        \n        local tx=x\n        if jump==2 then\n            tx=x+14*s.faceSign\n        elseif jump==3 then\n            tx=x-14*s.faceSign\n        end\n        s.placement[id]={x=x,y=s.center.y+0.05,z=z}\n        s.planned[id]={x=tx,y=s.center.y+0.05,z=z}\n    end\n    s.ready=true\nend\nfunction s.tower(wave,side)\n    local best,score,owner\n    \n    for id,p in pairs(s.planned) do\n        if s.line[id]==wave then\n            local t=s.towers[wave][id] or p\n            local v=side==\"W\" and -t.x or side==\"E\" and t.x or t.z\n            if not best or v>score then best,score,owner=t,v,id end\n        end\n    end\n    return best,owner\nend\nfunction s.guide(id)\n    local line,side=s.line[id],s.side[id]\n    if not s.ready or not line or not side then return nil end\n    if line==1 then\n        if not s.placed[id] then return s.placement[id],\"place1\" end\n        if side==\"S\" then\n            if s.stacks<2 then return nil,\"stack\" end\n            if s.resolved[3]<3 then return s.tower(3,\"S\"),\"soak3\" end\n        else\n            \n            \n            for other,wave in pairs(s.line) do\n                if wave==2 and not s.placed[other] then return nil,\"stack\" end\n            end\n            local tower,owner=s.tower(2,side)\n            if not owner then return nil,\"stack\" end\n            \n            if not s.geirLocked[owner] then return tower,\"soak2\" end\n            if s.stacks<2 then return nil,\"stack\" end\n        end\n    elseif line==2 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if not s.placed[id] then return s.placement[id],\"place2\" end\n        if s.stacks<2 then return nil,\"stack\" end\n        if s.resolved[3]<3 then return s.tower(3,side),\"soak3\" end\n    elseif line==3 then\n        if s.stacks<1 then return nil,\"stack\" end\n        if s.resolved[1]<3 then return s.tower(1,side),\"soak1\" end\n        if not s.placed[id] then return s.placement[id],\"place3\" end\n    end\n    return nil,\"done\"\nend\ns.assign()\nself.used=true",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p3_dfg\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_dfg_v2\nif not s or not s.ready then self.used=true return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then self.used=true return end\nlocal target,stage=s.guide(p.id)\ns.stage=stage\nif stage==\"stack\" then\n    local boss=TensorCore.mGetEntity(s.bossID)\n    if boss and boss.pos and boss.hitradius then\n        local x,y,z=TensorCore.getPosInDirection(boss.pos,boss.pos.h,boss.hitradius,true)\n        frogGuide.draw(\"p3_dfg\",s.drawer,p.pos.x,p.pos.y,p.pos.z,x,y+0.05,z,8,1.5)\n    end\nelseif target then\n    frogGuide.draw(\"p3_dfg\",s.drawer,p.pos.x,p.pos.y,p.pos.z,target.x,target.y,target.z,8,1.5)\nend\nself.used=true",
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
							actionLua = "local s=data.frog_dfg_v2\nif not s then self.used=true return end\nlocal id=eventArgs.targetID\nlocal wave=s.line[id]\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not wave or not e or not e.pos then self.used=true return end\nif s.placed[id] then self.used=true return end\nlocal x,y,z=e.pos.x,e.pos.y,e.pos.z\nif eventArgs.spellID~=26382 then\n    \n    x,y,z=TensorCore.getPosInDirection(e.pos,eventArgs.heading,14,true)\nend\nlocal t={x=x,y=y+0.05,z=z}\ns.towers[wave][id]=t\ns.towerByCaster[eventArgs.entityID]={wave=wave,id=id}\ns.placed[id]=true\nself.used=true",
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

					{
						data =
						{
							aType = "Lua",
							actionLua = "local c=data.frog_dfg_control\nif c and c.active and c.arrow and not c.resolvedAt then c.resolvedAt=Now() end\nself.used=true",
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

								{
									"a67772f7-b8fe-a879-827d-b762a662ff6b",
									true,
								},
							},
							name = "Confirm own placement snapshot",
							uuid = "f95c636d-6d2e-0fbc-9df8-249851e1b7e4",
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

					{
						data =
						{
							category = "Lua",
							conditionLua = "local p=TensorCore.mGetPlayer()\nreturn p~=nil and eventArgs.targetID==p.id",
							dequeueIfLuaFalse = true,
							name = "Own jump target",
							uuid = "a67772f7-b8fe-a879-827d-b762a662ff6b",
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
							actionLua = "if not self.softStarted then\n    local p=TensorCore.mGetPlayer()\n    local buff=TensorCore.getBuff(p,2756) or TensorCore.getBuff(p,2757)\n    if not buff then return end\n    local arrow=TensorCore.hasAnyBuff(p,2756,2757)\n    local solver=data.frog_dfg_v2\n    local heading=solver and solver.strategy==\"LPDU\" and math.pi/2 or -math.pi/2\n    data.frog_dfg_control={expires=Now()+buff.duration*1000,arrow=arrow,active=true,heading=heading}\n    if arrow then\n        TensorCore.API.TensorACR.setLockFaceHeading(heading)\n        TensorCore.API.TensorACR.setHardLockFace(false)\n        TensorCore.API.TensorACR.toggleLockFace(true)\n    end\n    self.softStarted=true\nend\nlocal c=data.frog_dfg_control\nif not c or not c.active or not c.arrow then self.used=true return end\nif Now()<c.expires-2000 then return end\nTensorCore.API.TensorACR.setLockFaceHeading(c.heading)\nTensorCore.API.TensorACR.setHardLockFace(true)\nself.used=true",
							conditions =
							{

								{
									"a38ad0d7-85a4-dbb1-b038-0acf8ad32097",
									true,
								},

								{
									"e0cd7562-14e4-5b79-b3a4-e6c4a92937ca",
									true,
								},
							},
							name = "Normal facing then hard at -2s",
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
							actionLua = "local c=data.frog_dfg_control\nif c then\n    if c.arrow then\n        TensorCore.API.TensorACR.toggleLockFace(false)\n        TensorCore.API.TensorACR.setHardLockFace(false)\n    end\n    c.active=false\nend\nself.used=true",
							conditions =
							{

								{
									"7f000f46-8cb1-a1b7-bd89-347e0c53852e",
									true,
								},

								{
									"8b9c249b-beeb-2252-aa39-07446f00b9e6",
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
							buffDuration = 5,
							buffIDList =
							{
								2756,
								2757,
							},
							category = "Self",
							comparator = 2,
							matchAnyBuff = true,
							name = "Arrow jump expires <=5s",
							uuid = "e0cd7562-14e4-5b79-b3a4-e6c4a92937ca",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local c=data.frog_dfg_control\nif not c or not c.active or not c.arrow or c.resolvedAt then return false end\nlocal now=Now()\nreturn now>=c.expires-250 and now<c.expires+2000",
							name = "Snapshot -0.25s",
							uuid = "4323bed3-2a75-8a4f-9f85-e18c9b46cb4b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local c=data.frog_dfg_control\nif not c or not c.active then return false end\nlocal now=Now()\nreturn (c.resolvedAt~=nil and now>=c.resolvedAt+100) or now>=c.expires+2000",
							name = "Own jump +0.1s / timeout +2s",
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

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_dfg_v2\nreturn s~=nil and s.customHold==true",
							name = "Custom P3 hold enabled",
							uuid = "a38ad0d7-85a4-dbb1-b038-0acf8ad32097",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local c=data.frog_dfg_control\nreturn c~=nil and c.active==true and Now()>=c.expires+2000",
							name = "Facing release +2s",
							uuid = "8b9c249b-beeb-2252-aa39-07446f00b9e6",
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
							actionLua = "local old=eventArgs.oldData\nlocal c=old and old.frog_dfg_control\nif c and c.active then\n    if c.arrow then\n        TensorCore.API.TensorACR.toggleLockFace(false)\n        TensorCore.API.TensorACR.setHardLockFace(false)\n    end\n    c.active=false\nend\nself.used=true",
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
							actionLua = "local old=data\nlocal c=old and old.frog_dfg_control\nif c and c.active then\n    if c.arrow then\n        TensorCore.API.TensorACR.toggleLockFace(false)\n        TensorCore.API.TensorACR.setHardLockFace(false)\n    end\n    c.active=false\nend\nself.used=true",
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
	[118] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "ff94127e-fbb5-65f7-b47b-5a54bfe862b3",
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
							actionLua = "ACR_TensorMagnum3_Hotbar_Potion=false\nself.used=true",
							conditions =
							{

								{
									"dd5ac10e-6d68-cc64-a158-14bf7e310cff",
									true,
								},

								{
									"149789f1-6649-b1b7-bffc-f0820db9201f",
									true,
								},
							},
							name = "Clear pending potion",
							uuid = "4f2b4bc4-5b9f-53ad-a3c5-1f7398ebe4c9",
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
									"dd5ac10e-6d68-cc64-a158-14bf7e310cff",
									true,
								},

								{
									"149789f1-6649-b1b7-bffc-f0820db9201f",
									true,
								},
							},
							endIfUsed = true,
							name = "Use Dexterity potion",
							usePot = true,
							uuid = "fd6a2b0a-f4e2-2d7a-9ddd-8d1167dcb598",
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
							conditionLua = "return TensorReactions_CurrentTimer>=676.9 and TensorReactions_CurrentTimer<681.9",
							dequeueIfLuaFalse = true,
							name = "Potion window still active",
							uuid = "dd5ac10e-6d68-cc64-a158-14bf7e310cff",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "149789f1-6649-b1b7-bffc-f0820db9201f",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				mechanicTime = 676.9,
				name = "[MCH] P3 bounded potion",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 5,
				uuid = "52614b55-e58e-6bc7-844d-fab0741112ee",
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
							actionLua = "ACR_TensorMagnum3_Hotbar_Potion=false\nself.used=true",
							conditions =
							{

								{
									"c359bd80-c6dd-e9ae-a315-be15ef814be7",
									true,
								},
							},
							name = "Expire pending potion",
							uuid = "20a59689-b651-40e9-a5da-80f99bc5f936",
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
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "c359bd80-c6dd-e9ae-a315-be15ef814be7",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				mechanicTime = 676.9,
				name = "[MCH] P3 potion queue cleanup",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 6,
				timerStartOffset = 5,
				uuid = "a8febc22-a4d2-fd15-904f-6ac3ef3539bf",
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
							actionLua = "local t=TensorReactions_CurrentTimer\nlocal s=data.frog_enum_v1\nif not s or (s.last and t<s.last-1) then s={towers={},tethers={},sources={}};data.frog_enum_v1=s end\ns.last=t\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then self.used=true return end\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings\nif not settings then\n local path=GetLuaModsPath()..[[TensorReactions\\FrogDrawsSettings.lua]]\n settings=FileExists(path) and FileLoad(path) or {}\nend\nlocal mode=settings.draw_styles and settings.draw_styles.p3_enum or \"Tether\"\ns.mode=mode\nif not s.role then\n local roster=AnyoneCore and AnyoneCore.Roster\n if not roster or not roster.isReady() then self.used=true return end\n local members=roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n local byName,byJob,counts,rcounts={},{},{},{}\n for _,e in pairs(party)do\n  if e.name and e.job and e.id then byName[e.name..\"\\31\"..e.job]=e;byJob[e.job]=e;counts[e.job]=(counts[e.job]or 0)+1 end\n end\n for _,e in pairs(members)do if e.job then rcounts[e.job]=(rcounts[e.job]or 0)+1 end end\n s.slots={}\n for _,role in ipairs({\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n  local key=role==\"MT\" and \"T1\" or role==\"OT\" and \"T2\" or role\n  local m=members[key]\n  local e=m and byName[m.name..\"\\31\"..m.job]\n  if not e and m and counts[m.job]==1 and rcounts[m.job]==1 then e=byJob[m.job] end\n  if not e then s.slots=nil;self.used=true return end\n  s.slots[role]=e.id\n  if e.id==p.id then s.role=role end\n end\n if not s.role then self.used=true return end\nend\nif not s.solved then\n for _,e in pairs(TensorCore.entityList(\"contentid=3458\")or{})do\n  local a=e.castinginfo\n  if a and a.channelingid>=26391 and a.channelingid<=26394 then\n   local i=e.pos.z<100 and (e.pos.x<100 and 1 or 2) or (e.pos.x<100 and 4 or 3)\n   s.towers[i]={id=e.id,x=e.pos.x,z=e.pos.z,n=a.channelingid-26390}\n   s.ends=t+math.max(0,a.casttime-a.channeltime)\n  end\n end\n local counts={};local total=0\n for i=1,4 do if not s.towers[i]then self.used=true return end;counts[i]=s.towers[i].n;total=total+counts[i]end\n if total~=8 then self.used=true return end\n local pairs={{\"H1\",\"M1\"},{\"R1\",\"MT\"},{\"H2\",\"M2\"},{\"R2\",\"OT\"}}\n local destinations,filled={},{0,0,0,0}\n for i,pair in ipairs(pairs)do\n  destinations[pair[1]]=i\n  local dest=i\n  if counts[i]==1 then\n   dest=nil\n   for _,step in ipairs({1,-1,2})do local j=(i-1+step)%4+1;if counts[j]>2 then dest=j;break end end\n  end\n  if not dest then self.used=true return end\n  destinations[pair[2]]=dest;filled[i]=filled[i]+1;filled[dest]=filled[dest]+1\n end\n for i=1,4 do if filled[i]~=counts[i]then self.used=true return end end\n s.destinations=destinations;s.index=destinations[s.role]\n local home={H1=1,M1=1,R1=2,MT=2,H2=3,M2=3,R2=4,OT=4}\n s.callout=s.index==home[s.role] and \"STAY\" or ({\"Northwest\",\"Northeast\",\"Southeast\",\"Southwest\"})[s.index]\n s.solved=true\n if mode~=\"Disabled\" then TensorCore.addAlertText(4000,s.callout,1.5,2,true)end\nend\nif not s.ends or t>s.ends+8 then\n s.x,s.z=nil,nil\n if s.arrow then Argus.deleteTimedShape(s.arrow);s.arrow=nil end\n self.used=true return\nend\nlocal tower=s.towers[s.index]\nlocal phase=t<s.ends and \"tower\" or \"post\"\nlocal x,z=tower.x,tower.z\nlocal anchor=s.role:sub(1,1)==\"H\" or s.role:sub(1,1)==\"R\"\nif phase==\"post\" then\n local tethered=s.sources and s.sources[tower.id]\n local clone=TensorCore.mGetEntity(tower.id)\n local casting=clone and clone.castinginfo\n if casting and casting.channelingid==26378 then s.baited=true end\n if anchor and not tethered and not s.baited and t<s.ends+4 then\n  local dx,dz=tower.x-100,tower.z-100;local length=math.sqrt(dx*dx+dz*dz)\n  x,z=tower.x+dx/length,tower.z+dz/length;phase=\"bait\"\n else\n  local boss\n  for _,e in pairs(TensorCore.entityList(\"contentid=3458,targetable,alive\")or{})do boss=e;break end\n  if not boss then self.used=true return end\n  local radius=boss.hitradius+2.5\n  local options={{boss.pos.x-radius,boss.pos.z},{boss.pos.x+radius,boss.pos.z}}\n  local best,score\n  for _,point in ipairs(options)do\n   local safe=true\n   for _,role in ipairs({\"MT\",\"OT\"})do\n    local id=s.slots[role]\n    if s.tethers[id]then local tank=TensorCore.mGetEntity(id);if tank and tank.pos and (point[1]-tank.pos.x)^2+(point[2]-tank.pos.z)^2<42.25 then safe=false end end\n   end\n   local distance=(point[1]-p.pos.x)^2+(point[2]-p.pos.z)^2\n   if safe and (not score or distance<score)then best,score=point,distance end\n  end\n  if not best then s.x,s.z=nil,nil;self.used=true return end\n  x,z=best[1],best[2];phase=\"side\"\n end\nend\ns.x,s.z=x,z\nlocal key=mode..\":\"..phase..\":\"..string.format(\"%.2f:%.2f\",x,z)\nif s.drawKey~=key then\n if s.arrow then Argus.deleteTimedShape(s.arrow);s.arrow=nil end\n s.drawKey=key\n if mode==\"Arrow\" then\n  local dx,dz=x-100,z-100;local length=math.sqrt(dx*dx+dz*dz)\n  if length>0.2 then\n   local duration=math.max(.1,(phase==\"tower\" and s.ends or phase==\"bait\" and s.ends+4 or s.ends+8)-t)*1000\n   local drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n   s.arrow=drawer:addTimedArrow(duration,100,.08,100,math.atan2(dx,dz),math.max(.1,length-2),.75,2,1.5,0,false,Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n  end\n end\nend\nself.used=true\n",
							name = "Enumeration solver",
							uuid = "1afe4ce5-754c-8c01-87cd-c70fc14b8bce",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 676.9,
				name = "[Draw] Enumeration solver",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 9,
				timerStartOffset = -7,
				uuid = "64610df9-3d77-a313-9010-8db736983b7c",
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
							actionLua = "local s=data.frog_enum_v1\nif not s or s.mode~=\"Tether\" or not s.x or not s.z then self.used=true return end\nlocal p=TensorCore.mGetPlayer()\nif p and p.pos and p.hp.current>0 then\n local drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n drawer:addLine(p.pos.x,p.pos.y+.08,p.pos.z,s.x,.08,s.z,3,1)\nend\nself.used=true\n",
							name = "Enumeration tether",
							uuid = "906f7dd0-5825-0c93-9fd8-8e447772caec",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 676.9,
				name = "[Draw] Enumeration tether",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 9,
				timerStartOffset = -7,
				uuid = "5454f2f0-59c2-c99f-a618-f4935d5f118b",
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
							actionLua = "data.frog_enum_v1=data.frog_enum_v1 or {towers={},tethers={},sources={}}\nlocal s=data.frog_enum_v1\ns.tethers=s.tethers or {};s.sources=s.sources or {}\nif eventArgs.oldTargetID and eventArgs.oldTargetID>0 then s.tethers[eventArgs.oldTargetID]=nil end\nif eventArgs.newTargetID and eventArgs.newTargetID>0 then\n s.tethers[eventArgs.newTargetID]=true;s.sources[eventArgs.sourceEntityID]=eventArgs.newTargetID\nend\nself.used=true",
							conditions =
							{

								{
									"e7ed0112-196a-daac-af49-d1ca3ddb43b4",
									true,
								},
							},
							name = "Track tethered clones and tanks",
							uuid = "35cfa557-ec2a-4d6c-8b55-2fe4cee1ec00",
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
							eventIntValue = 84,
							name = "Soul Tether",
							uuid = "e7ed0112-196a-daac-af49-d1ca3ddb43b4",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 676.9,
				name = "[Draw] Enumeration tethers",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 9,
				timerStartOffset = -7,
				uuid = "11dfda81-82f8-3921-be5f-75bcfa1b4e71",
				version = 2,
			},
		},
	},
	[120] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "6eea2996-27ca-b9bf-93d8-69a12b2c7bee",
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
							actionLua = "local id=eventArgs.sourceEntityID\nlocal t=TensorReactions_CurrentTimer\ndata.frog_local_clone_circle=data.frog_local_clone_circle or {}\nlocal marks=data.frog_local_clone_circle\nif marks[id] and t>=marks[id] and t-marks[id]<12 then self.used=true return end\nlocal duration=math.max(0.1,683.9-t)*1000\nlocal fill=GUI:ColorConvertFloat4ToU32(0.7,0.2,1,0.3)\nlocal outline=GUI:ColorConvertFloat4ToU32(0.7,0.2,1,0.95)\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal drawer=TensorCore.getCachedFlatDrawer(fill,fill,fill,outline,2,0,flags)\ndrawer:addTimedCircleOnEnt(duration,id,1.5,0,false,true,flags)\nmarks[id]=t\nself.used=true",
							conditions =
							{

								{
									"909462b3-dfdf-823e-b1ac-f5329ccbd849",
									true,
								},

								{
									"6b556506-c3f6-3f85-b0bd-3e2625756e52",
									true,
								},
							},
							name = "[Draw] Tethered Clone",
							uuid = "a395e612-b17e-0832-b24d-cd789c6b0df4",
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
							eventIntValue = 84,
							name = "Soul tether",
							uuid = "909462b3-dfdf-823e-b1ac-f5329ccbd849",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return eventArgs.sourceEntityContentID==3458 and Argus.getEntityModel(eventArgs.sourceEntityID)==12606",
							dequeueIfLuaFalse = true,
							name = "Nidhogg clone",
							uuid = "6b556506-c3f6-3f85-b0bd-3e2625756e52",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 15,
				loop = true,
				mechanicTime = 683.9,
				name = "[Draw] Tethered Clone",
				timeRange = true,
				timelineIndex = 120,
				timerStartOffset = -10,
				uuid = "017d5642-eb78-0da0-8682-a870397877b3",
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
							actionLua = "local t = TensorReactions_CurrentTimer\nlocal s = data.frog_eyes_v1\nif s == nil or (s.lastTime and t < s.lastTime - 1) then\n    s = {}\n    data.frog_eyes_v1 = s\nend\ns.lastTime = t\nif not s.initialized then\n    s.initialized = true\n    s.yellow = s.yellow or {}\n    s.blue = s.blue or {}\n    s.waves = s.waves or {}\n    s.wave = s.wave or 0\n    s.solvedWave = 0\n    s.slots = {}\n    s.roleByID = {}\n    s.station = {}\n    s.pairs = {}\n    s.roleOrder = {\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"}\n    s.rosterNames = {MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}\n    s.partner = {MT=\"H1\",OT=\"H2\",M1=\"R1\",M2=\"R2\",H1=\"MT\",H2=\"OT\",R1=\"M1\",R2=\"M2\"}\n    s.leftQuery = {contentid=11317}\n    s.rightQuery = {contentid=11318}\n    function s.resolveRoster()\n        local members = AnyoneCore.Roster.members()\n        local party = AnyoneCore.API.getAgnosticPartyList()\n        if type(members) ~= \"table\" or type(party) ~= \"table\" then return false end\n        local byName,byJob,counts,rcounts = {},{},{},{}\n        for _,a in pairs(party) do\n            if a.id and a.name and a.job then\n                byName[a.name..\"\\31\"..a.job]=a\n                byJob[a.job]=a\n                counts[a.job]=(counts[a.job] or 0)+1\n            end\n        end\n        for _,m in pairs(members) do\n            if m.job then rcounts[m.job]=(rcounts[m.job] or 0)+1 end\n        end\n        local seen={}\n        for _,role in ipairs(s.roleOrder) do\n            local m=members[s.rosterNames[role]]\n            if not m or not m.name or not m.job then return false end\n            local a=byName[m.name..\"\\31\"..m.job]\n            if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n            if not a or seen[a.id] then return false end\n            seen[a.id]=true\n            s.slots[role]=a.id\n            s.roleByID[a.id]=role\n        end\n        return true\n    end\n    function s.point(x,z,label)\n        s.targetID=nil\n        s.x,s.z,s.label=x,z,label\n    end\n    function s.person(id,label)\n        s.x,s.z=nil,nil\n        s.targetID,s.label=id,label\n    end\n    \n    \n    function s.rank(a,b,cx,cz)\n        local aa=( -math.atan2(a.x-cx,-(a.z-cz)))%(2*math.pi)\n        local bb=( -math.atan2(b.x-cx,-(b.z-cz)))%(2*math.pi)\n        if aa<bb or (aa==bb and a.id<b.id) then return a,b end\n        return b,a\n    end\nend\ns.x,s.z,s.targetID,s.label=nil,nil,nil,nil\ns.callout=nil\nif not s.rosterReady then\n    if s.rosterRetry and t<s.rosterRetry then self.used=true return end\n    s.rosterRetry=t+1\n    s.rosterReady=s.resolveRoster()\n    if not s.rosterReady then s.reason=\"Roster unresolved\"; self.used=true return end\nend\nlocal player=TensorCore.mGetPlayer()\nif not player or not player.pos then self.used=true return end\nlocal role=s.roleByID[player.id]\nif not role then s.reason=\"Self absent from roster\"; self.used=true return end\ns.myRole=role\nlocal left=s.leftID and TensorCore.mGetEntity(s.leftID) or TensorCore.getEntityByGroup(\"ContentID\",s.leftQuery)\nlocal right=s.rightID and TensorCore.mGetEntity(s.rightID) or TensorCore.getEntityByGroup(\"ContentID\",s.rightQuery)\nif not left or not right or not left.pos or not right.pos then\n    s.reason=\"Waiting for eyes\"; self.used=true return\nend\ns.leftID,s.rightID=left.id,right.id\nlocal tank=role==\"MT\" or role==\"OT\"\nlocal melee=role==\"M1\" or role==\"M2\"\nlocal yellowRole=tank or melee\nlocal support=tank or role==\"H1\" or role==\"H2\"\nlocal eye=support and left or right\nlocal north=role==\"H1\" or role==\"R1\"\nlocal sign=north and -1 or 1\nlocal buddy=s.slots[s.partner[role]]\nlocal red=TensorCore.hasBuff(player,2775)\nlocal blue=TensorCore.hasBuff(player,2776)\nlocal clock=t-(s.soulTime or 756.9)\ns.reason=nil\n\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings or (data.frog_draw_style_v5 and data.frog_draw_style_v5.settings)\nlocal trapezoid=settings and settings.p4_eyes_strategy==\"Trapezoid\"\nlocal function rankDive(a,b)\n    if trapezoid then\n        if a.z<b.z or (a.z==b.z and a.id<b.id) then return a,b end\n        return b,a\n    end\n    return s.rank(a,b,right.pos.x,right.pos.z)\nend\n\nwhile s.solvedWave < s.wave do\n    local n=s.solvedWave+1\n    local w=s.waves[n]\n    if not w or #w<2 then break end\n    local ccw,cw=rankDive(w[1],w[2])\n    if n==1 then s.firstPair={ccw.id,cw.id} end\n    s.pairs={}\n    if n<4 then\n        local takers\n        if n==1 then takers={s.slots.MT,s.slots.OT}\n        elseif n==2 then takers={s.slots.M1,s.slots.M2}\n        else takers=s.firstPair end\n        if takers and takers[1] and takers[2] then\n            s.pairs[1]={giver=ccw.id,taker=takers[1],x=ccw.x,z=ccw.z}\n            s.pairs[2]={giver=cw.id,taker=takers[2],x=cw.x,z=cw.z}\n        end\n    end\n    s.solvedWave=n\nend\n\nif s.wave>0 then\n    if s.solvedWave>=4 then s.label=\"Eyes complete\"; self.used=true return end\n    for _,pair in ipairs(s.pairs) do\n        if not pair.done then\n            if TensorCore.hasBuff(pair.taker,2775) and TensorCore.hasBuff(pair.giver,2776) then\n                pair.done=true\n                s.station[pair.taker]={x=pair.x,z=pair.z}\n                s.station[pair.giver]=nil\n            end\n        end\n        if not pair.done and (player.id==pair.giver or player.id==pair.taker) then\n            s.person(player.id==pair.giver and pair.taker or pair.giver,\"Mirage handoff\")\n            self.used=true return\n        end\n    end\n    \n    if blue and not red then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    self.used=true return\nend\n\n\n\nif yellowRole then\n    if not s.yellow[player.id] and TensorCore.hasBuff(player,2902) then s.yellow[player.id]=true end\n    if not s.blue[buddy] and TensorCore.hasBuff(buddy,2902) then s.blue[buddy]=true end\nelse\n    if not s.yellow[buddy] and TensorCore.hasBuff(buddy,2902) then s.yellow[buddy]=true end\n    if not s.blue[player.id] and TensorCore.hasBuff(player,2902) then s.blue[player.id]=true end\nend\n\nif (yellowRole and red) or (not yellowRole and blue)\n    or s.yellow[player.id] or s.yellow[buddy] or s.blue[player.id] or s.blue[buddy] then\n    s.initialSettled=true\nend\n\nlocal myYellow = yellowRole and s.yellow[player.id] or s.yellow[buddy]\nlocal myBlue = yellowRole and s.blue[buddy] or s.blue[player.id]\n\n\nif yellowRole and (myYellow or myBlue) then\n    if blue then s.orbHandoffComplete=true end\n    if not s.orbHandoffComplete then\n        s.person(buddy,\"Pass Clawbound\")\n    elseif not tank or left.hp.percent<=45 then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    self.used=true return\nend\nif myBlue then\n    if tank and left.hp.percent>45 then\n        s.point(left.pos.x,left.pos.z,\"Left eye until 45%\")\n    elseif yellowRole then\n        if (player.pos.x-right.pos.x)^2+(player.pos.z-right.pos.z)^2>1 then\n            s.point(right.pos.x,right.pos.z,\"Wait under right eye\")\n        end\n    end\n    \nelseif myYellow then\n    local giver=yellowRole and player.id or buddy\n    local receiver=yellowRole and buddy or player.id\n    local exchanged=TensorCore.hasBuff(giver,2776) and TensorCore.hasBuff(receiver,2775)\n    if not exchanged then\n        s.person(buddy,\"Pass Clawbound\")\n    elseif not yellowRole and clock>=28 then\n        s.point(eye.pos.x,eye.pos.z+sign*7,\"Blue orb\")\n        s.callout=\"POP NOW\"\n    elseif yellowRole then\n        s.point(eye.pos.x,eye.pos.z,\"Wait for blue orb\")\n    else\n        s.point(eye.pos.x,eye.pos.z+sign*eye.hitradius,\"Wait for blue orb\")\n    end\nelse\n    if not s.initialSettled and (s.hatebound or red or blue) and ((yellowRole and blue) or (not yellowRole and red)) then\n        s.point(100,100,\"Initial color swap\")\n    elseif yellowRole and clock>=22 and red then\n        s.point(eye.pos.x+(support and 7 or -7),eye.pos.z,\"Yellow orb\")\n        s.callout=\"SOAK NOW\"\n    elseif yellowRole then\n        s.point(eye.pos.x,eye.pos.z,\"Initial waiting spot\")\n    else\n        s.point(eye.pos.x,eye.pos.z+sign*eye.hitradius,\"Initial waiting spot\")\n    end\nend\nself.used=true\n",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p4_eyes\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_eyes_v1\nif not s or not s.initialized then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then return end\nlocal x,z=s.x,s.z\nlocal y=0.05\nif s.targetID then\n    local target=TensorCore.mGetEntity(s.targetID)\n    if not target or not target.pos then return end\n    x,y,z=target.pos.x,target.pos.y,target.pos.z\nend\nif not x or not z then return end\n\nlocal drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\nfrogGuide.draw(\"p4_eyes\",drawer,p.pos.x,p.pos.y,p.pos.z,x,y,z,8,2)\nself.used=true",
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
							alertScale = 1.5,
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
							alertScale = 1.5,
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

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "9f0b0b66-b393-06c8-9e34-50735259f239",
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
							actionLua = "local eye=TensorCore.getEntityByGroup(\"ContentID\",{contentid=11317,subgroup=\"Nearest\"})\nif not eye or not eye.alive or not eye.targetable then return end\nlocal color=GUI:ColorConvertFloat4ToU32(0.2,1,0.4,0.9)\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal drawer=TensorCore.getCachedFlatDrawer(0,0,0,color,2,0,flags)\ndrawer:addTimedCircleOnEnt(1100,eye.id,eye.hitradius+3,0,false,true,flags)\nself.used=true",
							name = "[Draw] Left Eye Melee",
							uuid = "23092174-ece2-dc4a-8f2d-0fc48b71393e",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "Local fixes",
				loop = true,
				mechanicTime = 757,
				name = "[Draw] Left Eye Melee",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 127,
				timerEndOffset = 67,
				timerStartOffset = -10,
				uuid = "84f641bd-607a-0089-84f6-fcb123a7bfa5",
				version = 2,
			},
		},
	},
	[128] =
	{

		{
			data =
			{
				actions =
				{

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "Move to left eye",
							conditions =
							{

								{
									"8bba0590-7e47-4264-bb35-d5e36d60fe01",
									true,
								},

								{
									"17775026-575a-d225-a455-ac7448f47e12",
									true,
								},

								{
									"708e21fe-7cab-54e3-8329-dc2ca8faff1c",
									true,
								},
							},
							name = "Move to left eye",
							uuid = "bbee5d9e-3488-3211-ba45-6e18cb47e579",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 5,
							name = "Within hitbox +5",
							partyTargetType = "Detection Target",
							uuid = "f6af0753-f19b-46a2-ba00-9f9e2a3b43cd",
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
									"f6af0753-f19b-46a2-ba00-9f9e2a3b43cd",
									false,
								},
							},
							filterTargetType = "ContentID",
							name = "Left Eye",
							partyTargetContentID = 11317,
							uuid = "708e21fe-7cab-54e3-8329-dc2ca8faff1c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "8bba0590-7e47-4264-bb35-d5e36d60fe01",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()==\"T1\"",
							name = "MT roster",
							uuid = "17775026-575a-d225-a455-ac7448f47e12",
							version = 3,
						},
					},
				},
				mechanicTime = 772.7,
				name = "[Tank] MT left eye",
				timeRange = true,
				timelineIndex = 128,
				timerEndOffset = -4.4,
				timerStartOffset = -5,
				uuid = "4b8ca00d-00c3-a7fb-89ab-94c645e5f2e7",
				version = 2,
			},
		},
	},
	[137] =
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
							actionLua = "local t=TensorReactions_CurrentTimer\nlocal base=900\nlocal s=data.frog_charibert_v1\nif not s or s.base~=base or (s.last and t<s.last-1)then\n s={base=base,seen={},cones={}};data.frog_charibert_v1=s\nend\ns.last=t\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos then self.used=true return end\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings\nif not settings then\n if not s.settings then\n  local path=GetLuaModsPath()..[[TensorReactions\\FrogDrawsSettings.lua]]\n  s.settings=FileExists(path)and FileLoad(path)or {}\n end\n settings=s.settings\nend\ns.mode=settings.draw_styles and settings.draw_styles.p1_brightwing or \"Tether\"\nlocal callMode=settings.p1_skyblind_mode or \"Personal\"\nlocal boss\nfor _,e in pairs(TensorCore.entityList(\"contentid=3642,targetable,alive\")or{})do boss=e;break end\nif not boss then\n s.x,s.z=nil,nil\n for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n s.cones={};self.used=true return\nend\nlocal party={}\nfor _,e in pairs(TensorCore.getEntityGroupList(\"Party\")or{})do\n if e.pos and e.hp.current>0 then\n  local dx,dz=e.pos.x-boss.pos.x,e.pos.z-boss.pos.z\n  party[#party+1]={id=e.id,e=e,d=dx*dx+dz*dz}\n end\nend\ntable.sort(party,function(a,b)return a.d<b.d or (a.d==b.d and a.id<b.id)end)\nlocal expected=t<base+15.9 and 0 or math.min(4,math.floor((t-base-15.9)/5)+1)\ns.hits=math.max(s.hits or 0,expected)\nif settings.p1_brightwing_cones~=false and s.hits<4 and #party>=2 then\n local key=party[1].id..\":\"..party[2].id\n if s.coneKey~=key or not s.refresh or Now()-s.refresh>=650 then\n  for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n  s.cones={};s.coneKey=key;s.refresh=Now()\n  local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n  local drawer=TensorCore.getCachedFlatDrawer(GUI:ColorConvertFloat4ToU32(1,0,0,.12),GUI:ColorConvertFloat4ToU32(1,0,0,.5),GUI:ColorConvertFloat4ToU32(1,0,0,.8),GUI:ColorConvertFloat4ToU32(1,0,0,.9),1,0,flags)\n  for i=1,2 do\n   local id=drawer:addTimedConeOnEnt(1000,boss.id,18,math.pi/6,party[i].id,0,false,true,0,false,flags)\n   if id then s.cones[#s.cones+1]=id end\n  end\n end\nelse\n for _,id in ipairs(s.cones)do Argus.deleteTimedShape(id)end\n s.cones={}\nend\nlocal meBuff\nfor _,v in ipairs(party)do\n local buff=TensorCore.getBuff(v.e,2661)\n if v.id==p.id then meBuff=buff end\n if callMode==\"Shotcaller\" or (callMode==\"Personal\" and v.id==p.id)then\n  if buff and buff.duration>0 then\n   s.seen[v.id]={expiry=t+buff.duration}\n  elseif s.seen[v.id]then\n   local seen=s.seen[v.id];s.seen[v.id]=nil\n   if t>=seen.expiry-.4 then\n    if not s.lastAlert or Now()-s.lastAlert>1000 then\n     TensorCore.addAlertText(3000,\"Move\",1.5,2,true);s.lastAlert=Now()\n    end\n    if v.id==p.id then s.returnUntil=t+1.5 end\n   end\n  end\n end\nend\nfor id in pairs(s.seen)do\n local e=TensorCore.mGetEntity(id)\n if not e or e.hp.current<=0 then s.seen[id]=nil end\nend\nif p.hp.current<=0 then s.x,s.z=nil,nil;self.used=true return end\nif not s.role and AnyoneCore and AnyoneCore.Roster and AnyoneCore.Roster.isReady()then\n local members=AnyoneCore.Roster.members()\n local agnostic=AnyoneCore.API.getAgnosticPartyList()\n local counts,rcounts={},{}\n for _,v in pairs(agnostic)do if v.job then counts[v.job]=(counts[v.job]or 0)+1 end end\n for _,v in pairs(members)do if v.job then rcounts[v.job]=(rcounts[v.job]or 0)+1 end end\n for _,role in ipairs({\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})do\n  local key=role==\"MT\"and \"T1\"or role==\"OT\"and \"T2\"or role\n  local m=members[key]\n  for _,v in pairs(agnostic)do\n   if m and v.id==p.id and m.job==v.job and (m.name==v.name or(counts[v.job]==1 and rcounts[v.job]==1))then s.role=role end\n  end\n end\nend\ns.x,s.z=nil,nil\nif s.mode==\"Disabled\"or not s.role then self.used=true return end\nlocal role=s.role\nlocal tank=role==\"MT\"or role==\"OT\"\nlocal melee=role:sub(1,1)==\"M\"and not tank\nif meBuff then\n if tank then\n  s.x,s.z=boss.pos.x,boss.pos.z+boss.hitradius*.5\n elseif melee then\n  local radius=boss.hitradius+2.9\n  local a,b=boss.pos.h+3*math.pi/4,boss.pos.h-3*math.pi/4\n  local ax,az=boss.pos.x+math.sin(a)*radius,boss.pos.z+math.cos(a)*radius\n  local bx,bz=boss.pos.x+math.sin(b)*radius,boss.pos.z+math.cos(b)*radius\n  if (ax-boss.pos.x)^2+(az-(boss.pos.z-5))^2<(bx-boss.pos.x)^2+(bz-(boss.pos.z-5))^2 then s.x,s.z=ax,az else s.x,s.z=bx,bz end\n else\n  s.x,s.z=boss.pos.x+7,boss.pos.z-5\n end\nelseif s.returnUntil and t<s.returnUntil then\n s.x,s.z=boss.pos.x,boss.pos.z-5\nelse\n local wave=s.hits+1\n local own=role:sub(1,1)==\"H\"and 1 or melee and 2 or role:sub(1,1)==\"R\"and 3 or 4\n if wave==own and wave<=4 then\n  local side=settings.p1_brightwing_side or \"Roster\"\n  local left=side==\"Left\"or(side~=\"Right\"and(role==\"MT\"or role:sub(-1)==\"1\"))\n  s.x,s.z=boss.pos.x+(left and -2.5 or 2.5),boss.pos.z+.5\n end\nend\nself.used=true\n\n",
							name = "Brightwing helper",
							uuid = "4e1dcb58-ae5e-7b3c-8631-2a3173f96f9b",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 900,
				name = "[Draw] Brightwing helper",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 137,
				timerEndOffset = 38.5,
				uuid = "444c0dfe-ccab-6348-93fa-3b044847ab55",
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
							actionLua = "local s=data.frog_charibert_v1\nif not s or not s.x or not s.z or s.mode==\"Disabled\"then self.used=true return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then self.used=true return end\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,flags)\nif s.mode==\"Arrow\"then\n local dx,dz=s.x-p.pos.x,s.z-p.pos.z\n local length=math.sqrt(dx*dx+dz*dz)\n if length>.2 then local tip=math.min(2,length*.35);drawer:addArrow(p.pos.x,p.pos.y+.08,p.pos.z,math.atan2(dx,dz),length-tip,.75,tip,1.5,false,flags)end\nelse drawer:addLine(p.pos.x,p.pos.y+.08,p.pos.z,s.x,.08,s.z,3,1)end\nself.used=true\n",
							name = "Brightwing guidance",
							uuid = "48530ebc-c949-a169-a0ab-6c5ffdfea341",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 900,
				name = "[Draw] Brightwing guidance",
				timeRange = true,
				timelineIndex = 137,
				timerEndOffset = 38.5,
				uuid = "9f1f917a-f9fa-1500-8d11-8baaacca4a77",
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
							actionLua = "local s=data.frog_charibert_v1\nif not s or s.base~=900 then s={base=900,seen={},cones={}};data.frog_charibert_v1=s end\nlocal now=Now()\nif not s.lastHit or now-s.lastHit>1200 then s.hits=math.min(4,(s.hits or 0)+1);s.lastHit=now end\nself.used=true",
							conditions =
							{

								{
									"ca6cd6a2-70b0-b9da-9c3f-48c91cd2a77d",
									true,
								},
							},
							name = "Track paired cleaves",
							uuid = "a592fad8-4088-8a8a-9895-a46c2ec83c63",
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
							eventSpellID = 25369,
							name = "Brightwing",
							uuid = "ca6cd6a2-70b0-b9da-9c3f-48c91cd2a77d",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 900,
				name = "[Draw] Brightwing capture",
				timeRange = true,
				timelineIndex = 137,
				timerEndOffset = 38.5,
				uuid = "69ad1586-64d7-2daf-9621-7e3c5f3e7339",
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
							actionLua = "data.frog_wrath_v1=data.frog_wrath_v1 or {}\nlocal s=data.frog_wrath_v1\ns.phase=2\nif s.arrow then Argus.deleteTimedShape(s.arrow) s.arrow=nil end\nlocal p=TensorCore.mGetPlayer()\nlocal guide=data.frog_draw_style_v5\nif p and p.pos and p.hp.current>0 and s.nx and not s.crossoverCalled\n    and guide and guide.mode(\"p5_wrath\")~=\"Disabled\" then\n local kx,kz\n if p.id==s.ignID then kx,kz=s.ignX,s.ignZ\n elseif p.id==s.vellID then kx,kz=s.vellX,s.vellZ end\n local ex,ez=-s.nz,s.nx\n \n if kx and (kx-100)*ex+(kz-100)*ez<0 then\n  local dx,dz=-0.9238795325*s.nx-0.3826834324*ex,-0.9238795325*s.nz-0.3826834324*ez\n  local drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,guide.flags)\n  s.arrow=drawer:addTimedArrow(8000,100+dx*2,0.08,100+dz*2,math.atan2(dx,dz),12,0.75,3,1.5,0,false,guide.flags)\n  TensorCore.addAlertText(5000,\"Move away from nothings\",1.5,2,true)\n  s.crossoverCalled=true\n end\nend\nself.used=true",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p5_wrath\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_wrath_v1\nlocal ex,ez=-s.nz,s.nx\nif frogGuide.mode(\"p5_wrath\")==\"Tether\" then\n s.unmarkedLineUntil=TensorReactions_CurrentTimer+8\nelse\n local drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,frogGuide.flags)\n s.arrow=drawer:addTimedArrow(8000,100+ex*5,0.08,100+ez*5,math.atan2(ex,ez),8,1.5,3,4,0,false,frogGuide.flags)\nend\nself.used=true\n",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p5_wrath\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_wrath_v1\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then return end\nlocal x,z\nlocal radius=19.5\nif s.phase==1 and s.nx then\n    local kx,kz\n    if p.id==s.vellID then kx,kz=s.vellX,s.vellZ\n    elseif p.id==s.ignID then kx,kz=s.ignX,s.ignZ end\n    if kx then\n        local ex,ez=-s.nz,s.nx\n        local side=(-kx+100)*ex+(-kz+100)*ez\n        local sign=side<0 and -1 or 1\n        local c,t=0.9238795325,0.3826834324\n        x,z=100+radius*(-c*s.nx+sign*t*ex),100+radius*(-c*s.nz+sign*t*ez)\n    elseif p.id==s.defamID then\n        \n        local ex,ez=-s.nz,s.nx\n        x,z=100+radius*(0.5*s.nx-0.8660254038*ex),100+radius*(0.5*s.nz-0.8660254038*ez)\n    end\nelseif s.phase==2 and p.id==s.diveID and s.gx then\n    local dx,dz=s.gx-100,s.gz-100\n    local length=math.sqrt(dx*dx+dz*dz)\n    if length>0 then x,z=100-radius*dx/length,100-radius*dz/length end\nend\nif not x and s.phase==1 and s.unmarkedLineUntil\n    and TensorReactions_CurrentTimer<s.unmarkedLineUntil\n    and s.nx and p.id~=s.vellID and p.id~=s.ignID and p.id~=s.defamID then\n    local ex,ez=-s.nz,s.nx\n    x,z=100+19.5*ex,100+19.5*ez\nend\nif x then\n    \n    local drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\n    frogGuide.draw(\"p5_wrath\",drawer,p.pos.x,p.pos.y,p.pos.z,x,0.08,z,8,2)\nend\nself.used=true",
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

		{
			data =
			{
				actions =
				{

					{
						data =
						{
							aType = "Lua",
							actionLua = "local s = data.frog_wrath_v1\nif s then s.phase = 3 end\nself.used = true",
							conditions =
							{

								{
									"043d56f1-911b-30b3-82d4-6edd863b5aa6",
									true,
								},
							},
							name = "End Dive Bait Guidance",
							uuid = "4a1a0d0a-6444-4607-815e-ab1797db3136",
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
							name = "Cauterize starts",
							spellIDList =
							{
								27533,
								27534,
							},
							uuid = "043d56f1-911b-30b3-82d4-6edd863b5aa6",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1024.8,
				name = "[Draw] Wrath Dive Bait Lock-in",
				timeRange = true,
				timelineIndex = 154,
				timerEndOffset = 26.2,
				timerStartOffset = 5.2,
				uuid = "4495bce3-340a-78ac-857b-0b4bf11a1ae5",
				version = 2,
			},
		},
	},
	[172] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "abb189e0-cbb7-b229-b06e-918aa0a35243",
			},
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "6ca04656-0bb9-7dd3-91f0-6ec2d70bb209",
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
							actionID = 69,
							conditions =
							{

								{
									"a22d0722-da75-cfd4-9b8c-ddd4008296b5",
									true,
								},

								{
									"d5cbb4cd-3f41-e03f-bdf1-67dec76554f5",
									true,
								},

								{
									"55a3f0dd-a72f-f51e-9b8f-1478fa0c8b86",
									true,
								},

								{
									"23caaa82-f17e-3265-84cd-2d2d4660e07b",
									true,
								},

								{
									"d6b9230c-61f1-1c24-aca8-c0f0aff1948a",
									true,
								},

								{
									"0755c7ec-85eb-1eaf-9aae-13e5c5d40f94",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "3c3837f3-5296-8a33-b8df-e1ce20522815",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "a22d0722-da75-cfd4-9b8c-ddd4008296b5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "d5cbb4cd-3f41-e03f-bdf1-67dec76554f5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "55a3f0dd-a72f-f51e-9b8f-1478fa0c8b86",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn not t or not t.targetable or not t.attackable or t.hp.current<=0",
							name = "No attackable target",
							uuid = "23caaa82-f17e-3265-84cd-2d2d4660e07b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.known and (s.remaining==0 or Now()>(s.pbUntil or 0)) and (s.chakra==0 or Now()>(s.chakraUntil or 0))",
							name = "No pending PB or Blitz",
							uuid = "d6b9230c-61f1-1c24-aca8-c0f0aff1948a",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 69,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0755c7ec-85eb-1eaf-9aae-13e5c5d40f94",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1051.2,
				name = "[MNK] Wrath early PB",
				timeRange = true,
				timelineIndex = 172,
				timerEndOffset = -1,
				timerStartOffset = -5,
				uuid = "6221ad09-2632-7e13-93b8-957c23f8a3dd",
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
							actionLua = "if data.frog_draw_settings == nil then\n local p={\n  version=3,\n  path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]],\n  default=\"R1 H1 M1 MT OT M2 H2 R2\",\n  roles={MT=true,OT=true,H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n }\n function p.parse(text)\n  if type(text)~=\"string\" then return nil,\"Enter all eight roles.\" end\n  local order,seen={},{}\n  for role in string.upper(text):gmatch(\"[^%s,]+\") do\n   if not p.roles[role] then return nil,\"Unknown role: \"..role end\n   if seen[role] then return nil,\"Duplicate role: \"..role end\n   seen[role]=true; order[#order+1]=role\n  end\n  if #order~=8 then return nil,\"Enter each of MT OT H1 H2 M1 M2 R1 R2 once.\" end\n  return order,table.concat(order,\" \")\n end\n function p.save(text)\n  local order,normalized=p.parse(text)\n  if not order then p.message=normalized; return false end\n  local nextSettings={}\n  for k,v in pairs(p.settings) do nextSettings[k]=v end\n  nextSettings.doth_conga=normalized\n  local ok,err=pcall(FileSave,p.path,nextSettings)\n  local readOK,saved=pcall(FileLoad,p.path)\n  if not ok or not readOK or type(saved)~=\"table\" or saved.doth_conga~=normalized then\n   p.message=\"Save failed: \"..tostring(err or saved); return false\n  end\n  p.settings=nextSettings\n  p.order,p.saved,p.edit=order,normalized,normalized\n  p.message=\"Saved. Used when DOTH begins.\"\n  return true\n end\n p.order,p.saved=p.parse(p.default)\n p.edit=p.saved\n p.settings={}\n if FileExists(p.path) then\n  local ok,settings=pcall(FileLoad,p.path)\n  local order,normalized\n  if ok and type(settings)==\"table\" then\n   p.settings=settings\n   order,normalized=p.parse(settings.doth_conga)\n  end\n  if order then p.order,p.saved,p.edit=order,normalized,normalized\n  else p.message=\"Invalid settings file; using defaults. Apply to repair.\" end\n else\n  local previous=data.frog_draw_settings\n  p.save(previous and previous.saved or p.default)\n end\n data.frog_draw_settings=p\nend\nlocal s = {\n orderMode=data.frog_draw_settings.settings.doth_order_mode==\"Live positions\" and \"Live positions\" or \"Configured conga\",\n phase=1, doom={}, markers={}, markerPos={}, dives={}, puddles={}, puddleByID={},\n slots={}, roleByID={}, dirty=true,\n order={},\n rosterSlots={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"},\n doomOrder={},clearOrder={}\n}\nfor i,role in ipairs(data.frog_draw_settings.order) do s.order[i]=role end\ndata.frog_doth_v1=s\nfunction s.resolveRoster()\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if type(members)~=\"table\" or type(party)~=\"table\" then return false end\n local byName,byJob,counts,rcounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a\n   byJob[a.job]=a\n   counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(members) do\n  if m.job then rcounts[m.job]=(rcounts[m.job] or 0)+1 end\n end\n local seen={}\n for _,role in ipairs(s.order) do\n  local m=members[s.rosterSlots[role]]\n  if not m or not m.name or not m.job then return false end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n  if not a or seen[a.id] then return false end\n  seen[a.id]=true\n  s.slots[role]=a.id\n  s.roleByID[a.id]=role\n end\n return true\nend\nfunction s.point(e,n,label)\n s.x=100+s.ex*e+s.nx*n\n s.z=100+s.ez*e+s.nz*n\n s.label=label\nend\n\ns.cleanseSlots={}\ns.cleanseAnchors={{e=-20,n=0},{e=-12,n=-16},{e=12,n=-16},{e=20,n=0}}\nfunction s.mapPuddles()\n for i=1,4 do s.cleanseSlots[i]=nil end\n for _,p in ipairs(s.puddles) do\n  local e=(p.x-100)*s.ex+(p.z-100)*s.ez\n  local n=(p.x-100)*s.nx+(p.z-100)*s.nz\n  local best,bestD,tied\n  for i,a in ipairs(s.cleanseAnchors) do\n   local d=(e-a.e)^2+(n-a.n)^2\n   if not bestD or d<bestD-0.0001 then best,bestD,tied=i,d,false\n   elseif math.abs(d-bestD)<=0.0001 then tied=true end\n  end\n  \n  if best and not tied and n<=1 and bestD<80 then\n   if s.cleanseSlots[best]==nil then s.cleanseSlots[best]=p\n   else s.cleanseSlots[best]=false end\n  end\n end\nend\nfunction s.puddlePoint(index,opposite,label)\n local p=s.cleanseSlots[index]\n if not p then\n  s.reason=p==false and \"Ambiguous cleanse in assigned slot\" or \"Waiting for assigned cleanse puddle\"\n  return\n end\n if opposite then s.x,s.z=200-p.x,200-p.z else s.x,s.z=p.x,p.z end\n s.label=label\nend\nfunction s.pairSide(id,marker,axis)\n local mine=s.markerPos[id]\n if not mine then return nil end\n local my=(mine.x-100)*(axis==\"east\" and s.ex or s.nx)+(mine.z-100)*(axis==\"east\" and s.ez or s.nz)\n for other,m in pairs(s.markers) do\n  if other~=id and m==marker then\n   local p=s.markerPos[other]\n   if not p then return nil end\n   local v=(p.x-100)*(axis==\"east\" and s.ex or s.nx)+(p.z-100)*(axis==\"east\" and s.ez or s.nz)\n   return my<v or (my==v and id<other)\n  end\n end\n return nil\nend\ns.rosterReady=s.resolveRoster()\nself.used=true",
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
							actionLua = "local s=data.frog_doth_v1\nif not s or s.nx then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nlocal r=math.sqrt(dx*dx+dz*dz)\n\nif r<8 or r>10 then self.used=true return end\ns.nx,s.nz=dx/r,dz/r\ns.ex,s.ez=-s.nz,s.nx\ns.dirty=true\nself.used=true",
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
							actionLua = "local s=data.frog_doth_v1\nif not s or s.nx then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\nlocal dx,dz=e.pos.x-100,e.pos.z-100\nlocal r=math.sqrt(dx*dx+dz*dz)\n\nif r<8 or r>10 then self.used=true return end\ns.nx,s.nz=dx/r,dz/r\ns.ex,s.ez=-s.nz,s.nx\ns.dirty=true\nself.used=true",
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
							actionLua = "local s=data.frog_doth_v1\nif s then\n if s.orderMode==\"Live positions\" and not s.positionSnapshot then\n  \n  s.positionSnapshot={}\n  local party=AnyoneCore.API.getAgnosticPartyList()\n  if type(party)==\"table\" then\n   for _,a in pairs(party) do\n    if a.id then\n     local e=TensorCore.mGetEntity(a.id)\n     if e and e.pos then s.positionSnapshot[a.id]={x=e.pos.x,z=e.pos.z} end\n    end\n   end\n  end\n end\n s.doom[eventArgs.entityID]=true\n s.dirty=true\nend\nself.used=true",
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
							actionLua = "local s=data.frog_doth_v1\nif not s then self.used=true return end\nlocal t=TensorReactions_CurrentTimer\nif s.lastTick and t<s.lastTick-1 then data.frog_doth_v1=nil; self.used=true return end\ns.lastTick=t\nif not s.rosterReady then\n if not s.retryAt or t>=s.retryAt then s.retryAt=t+1; s.rosterReady=s.resolveRoster(); s.dirty=true end\nend\nif not s.checkLineup then\n function s.checkLineup(now)\n  if s.lineupChecked or not s.verifyAt or now<s.verifyAt then return end\n  s.lineupChecked=true\n  if s.phase~=1 or now>s.verifyAt+0.5 or not s.rosterReady or not s.nx or not s.assigned then\n   s.lineupUnclear=true\n   return\n  end\n  local groups={{},{}}\n  s.finalPositions={}\n  for _,role in ipairs(s.order) do\n   local id=s.slots[role]\n   local entity=id and TensorCore.mGetEntity(id)\n   if entity and entity.pos and entity.hp.current>0 then\n    local pos=entity.pos\n    local entry={id=id,role=role,e=(pos.x-100)*s.ex+(pos.z-100)*s.ez,n=(pos.x-100)*s.nx+(pos.z-100)*s.nz}\n    s.finalPositions[id]={x=pos.x,z=pos.z}\n    local group=s.doom[id] and 1 or 2\n    groups[group][#groups[group]+1]=entry\n   end\n  end\n  local mismatch,unclear=false,false\n  for group,entries in ipairs(groups) do\n   local valid=#entries==4\n   local order\n   if valid then\n    table.sort(entries,function(a,b) if a.n==b.n then return a.id<b.id end return group==1 and a.n>b.n or group==2 and a.n<b.n end)\n    local inner={entries[1],entries[2]}\n    local outer={entries[3],entries[4]}\n    local gap=(inner[2].n-outer[1].n)*(group==1 and 1 or -1)\n    valid=gap>=4\n    for _,pair in ipairs({inner,outer}) do\n     table.sort(pair,function(a,b) return a.e<b.e end)\n     if pair[1].e> -3 or pair[2].e<3 then valid=false end\n    end\n    if valid then order={outer[1].id,inner[1].id,inner[2].id,outer[2].id} end\n   end\n   if valid then\n    local previous=group==1 and s.doomOrder or s.clearOrder\n    local changed=false\n    for i=1,4 do if previous[i]~=order[i] then changed=true end end\n    if changed then\n     mismatch=true\n     if group==1 then s.doomOrder=order else s.clearOrder=order end\n    end\n   else unclear=true end\n  end\n  s.lineupMismatch=mismatch\n  s.lineupUnclear=unclear\n  if mismatch then\n   s.myDoom=s.doom[TensorCore.mGetPlayer().id]==true\n   local order=s.myDoom and s.doomOrder or s.clearOrder\n   for rank,id in ipairs(order) do if id==TensorCore.mGetPlayer().id then s.myRank=rank end end\n   s.baiter=s.myDoom and (s.myRank==1 or s.myRank==4)\n   s.dirty=true\n  elseif unclear then\n  end\n end\nend\ns.checkLineup(t)\nif not s.dirty then self.used=true return end\ns.x,s.z,s.label,s.reason=nil,nil,nil,nil\nif not s.rosterReady then s.reason=\"Waiting for Anyone roster\"; self.used=true return end\nif not s.nx then s.reason=\"Waiting for Guerrique arrival\"; self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player then self.used=true return end\ns.myRole=s.roleByID[player.id]\nif not s.myRole then s.reason=\"Self absent from roster\"; self.used=true return end\nif not s.assigned then\n if s.orderMode==\"Live positions\" and not s.liveOrderLocked then\n  if not s.positionSnapshot then s.reason=\"Waiting for Doom position snapshot\"; self.used=true return end\n  local sorted={}\n  for i,role in ipairs(s.order) do\n   local p=s.positionSnapshot[s.slots[role]]\n   if not p then s.reason=\"Missing player in Doom position snapshot\"; self.used=true return end\n   sorted[#sorted+1]={role=role,e=(p.x-100)*s.ex+(p.z-100)*s.ez,tie=i}\n  end\n  table.sort(sorted,function(a,b) if a.e==b.e then return a.tie<b.tie end return a.e<b.e end)\n  for i,p in ipairs(sorted) do s.order[i]=p.role end\n  s.liveOrderLocked=true\n end\n local d=0\n for _,role in ipairs(s.order) do if s.doom[s.slots[role]] then d=d+1 end end\n if d~=4 then s.reason=\"Waiting for all four dooms\"; self.used=true return end\n local di,ci=0,0\n for _,role in ipairs(s.order) do\n  local id=s.slots[role]\n  if s.doom[id] then di=di+1; s.doomOrder[di]=id else ci=ci+1; s.clearOrder[ci]=id end\n end\n s.assigned=true\n s.myDoom=s.doom[player.id]==true\n local order=s.myDoom and s.doomOrder or s.clearOrder\n for rank,id in ipairs(order) do if id==player.id then s.myRank=rank end end\n s.baiter=s.myDoom and (s.myRank==1 or s.myRank==4)\nend\ns.mapPuddles()\nlocal rank=s.myRank\nif s.phase==1 then\n if rank==1 then s.point(s.myDoom and -10.5 or -20,0,\"West spread\")\n elseif rank==4 then s.point(s.myDoom and 10.5 or 20,0,\"East spread\")\n else s.point(rank==2 and -12 or 12,s.myDoom and 16 or -16,\"Offset diagonal spread\") end\nelseif s.phase==2 then\n if s.baiter then s.point(rank==1 and -10.5 or 10.5,0,\"Bait circle\")\n else s.point(0,s.myDoom and -2 or 2,s.myDoom and \"Doom south\" or \"Non-doom north\") end\nelseif s.phase==3 then\n local marker=s.markers[player.id]\n if s.myDoom then\n  if marker==281 then\n   local west=s.pairSide(player.id,281,\"east\")\n   if west==nil and (rank==1 or rank==4) then west=rank==1 end\n   if west~=nil then s.puddlePoint(west and 1 or 4,false,\"Circle cleanse\") end\n  elseif marker==282 or marker==283 then\n   if rank==2 or rank==3 then\n    s.puddlePoint(rank,false,rank==2 and \"Inner doom southwest cleanse\" or \"Inner doom southeast cleanse\")\n   else s.reason=\"Non-circle doom is not an inner conga rank\" end\n  end\n else\n  if marker==282 or marker==283 then\n   local partnerRank\n   for i=2,3 do\n    if s.markers[s.doomOrder[i]]==marker then\n     if partnerRank then\n      s.reason=\"Ambiguous doom symbol partner\"; self.used=true return\n     end\n     partnerRank=i\n    end\n   end\n   if not partnerRank then s.reason=\"Waiting for matching inner doom marker\"; self.used=true return end\n   if s.cleanseSlots[partnerRank] then\n    s.puddlePoint(partnerRank,true,\"Opposite matching doom cleanse\")\n   else\n    s.point(partnerRank==2 and 12 or -12,16,\"Opposite matching inner doom\")\n   end\n  elseif marker==284 then\n   local south=s.pairSide(player.id,284,\"north\")\n   if south~=nil then s.point(0,south and -20 or 20,south and \"Cross south\" or \"Cross north\") end\n  end\n end\nend\ns.dirty=false\nself.used=true",
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
							alertScale = 1.5,
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p5_doth\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_doth_v1\nlocal p=TensorCore.mGetPlayer()\nif s and s.x and s.z and s.phase<4 and p and p.pos and p.hp.current>0 then\n local drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\n frogGuide.draw(\"p5_doth\",drawer,p.pos.x,p.pos.y,p.pos.z,s.x,0.08,s.z,8,2)\nend\nself.used=true",
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

		{
			data =
			{
				actions =
				{

					{
						data =
						{
							aType = "Lua",
							actionLua = "local s=data.frog_doth_v1\nif s and s.phase==1 and not s.lineupChecked then\n s.verifyAt=TensorReactions_CurrentTimer+math.max(0,eventArgs.channelTimeMax-0.7)\nend\nself.used=true",
							conditions =
							{

								{
									"0edbefb0-2eeb-aad1-b517-119f38e590a9",
									true,
								},
							},
							name = "Schedule final position snapshot",
							uuid = "4e87daf7-6688-c51d-8508-2072e26c832f",
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
							name = "DOTH Spear",
							spellIDList =
							{
								27539,
							},
							uuid = "0edbefb0-2eeb-aad1-b517-119f38e590a9",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1085.1,
				name = "[Draw] DOTH final lineup check",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 20,
				uuid = "2c68eafa-1e76-2af5-97fb-4e82e9c77d18",
				version = 2,
			},
		},
	},
	[194] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "f5a527e9-07e2-9ac6-9169-ef65226c0d64",
			},
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "20aba979-a19b-a4ec-8a82-48cb1d408783",
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
							actionLua = "local s=data.frog_mnk_downtime\nif not s then self.used=true return end\nif Now()>(s.pbUntil or 0) then s.remaining=0 end\nif Now()>(s.chakraUntil or 0) then s.chakra=0 end\ns.prep={key=\"DOTH comet Blitz preparation\",start=Now(),solar=not s.solar,blitz=(s.solar and s.lunar) and 25769 or ((not s.solar) and 25768 or 3545)}\nself.used=true",
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"3b5ef3b1-ec78-8390-95a8-77e1bb9919c2",
									true,
								},

								{
									"3c4892ad-17df-9198-acef-d21e9f25da20",
									true,
								},
							},
							name = "Choose missing Nadi once",
							uuid = "5015d0c7-8fe6-527f-96f1-540967322ece",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 69,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"dd1ba15a-5718-0763-87c9-decae2d2696a",
									true,
								},

								{
									"3c4892ad-17df-9198-acef-d21e9f25da20",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "7dec280b-816e-2621-8fb8-4e7a751df67d",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"71679f5b-095d-af68-8798-ae2abefa223f",
									true,
								},
							},
							uuid = "5f5e84e4-f955-86ee-94c6-6e3921dd1091",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 16473,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"e0c16651-1e4f-2908-b222-0c21f4910408",
									true,
								},

								{
									"52bc8036-3cb9-fed9-8de8-d7f19156830b",
									true,
								},
							},
							uuid = "562efe5f-fde7-ffc9-8964-9ff405442472",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"e0c16651-1e4f-2908-b222-0c21f4910408",
									true,
								},

								{
									"d0308bb9-8d60-e009-9fe4-c4671c42af60",
									true,
								},
							},
							uuid = "f962f62c-1993-46d4-916b-9c42f4190c6b",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 70,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"97f1cf4f-9d87-74a0-af3e-b413a5eb408f",
									true,
								},

								{
									"52bc8036-3cb9-fed9-8de8-d7f19156830b",
									true,
								},
							},
							uuid = "0523c107-7729-964a-bed5-0fedac3ddfbf",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"67fec0f1-0279-2352-8c67-c491ec95cd27",
									true,
								},

								{
									"3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
									true,
								},

								{
									"3b6f787d-5761-1dc7-8e11-4c10a53e8749",
									true,
								},

								{
									"a7b90a11-5df6-e717-b834-9d6b0553f377",
									true,
								},

								{
									"97f1cf4f-9d87-74a0-af3e-b413a5eb408f",
									true,
								},

								{
									"d0308bb9-8d60-e009-9fe4-c4671c42af60",
									true,
								},
							},
							uuid = "73da15c3-e454-7a7d-8b15-ccc2a9ba754e",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "67fec0f1-0279-2352-8c67-c491ec95cd27",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "3390cf16-4070-e7f6-b2d1-3aec18aa67f9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "3b6f787d-5761-1dc7-8e11-4c10a53e8749",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn not t or not t.targetable or not t.attackable or t.hp.current<=0",
							name = "No attackable current target",
							uuid = "a7b90a11-5df6-e717-b834-9d6b0553f377",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nif not s or not s.known then return false end\nlocal t=Now()\nreturn (s.remaining==0 or t>(s.pbUntil or 0)) and (s.chakra==0 or t>(s.chakraUntil or 0))",
							name = "Nadi known; no pending PB or Blitz",
							uuid = "3b5ef3b1-ec78-8390-95a8-77e1bb9919c2",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 69,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "3c4892ad-17df-9198-acef-d21e9f25da20",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and Now()-s.prep.start<10000 and ((s.remaining==0 or Now()>(s.pbUntil or 0)) and s.chakra==0)",
							name = "PB stage 0",
							uuid = "dd1ba15a-5718-0763-87c9-decae2d2696a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==3 and s.chakra==0 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 1",
							uuid = "71679f5b-095d-af68-8798-ae2abefa223f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==2 and s.chakra==1 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 2",
							uuid = "e0c16651-1e4f-2908-b222-0c21f4910408",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==1 and s.chakra==2 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 3",
							uuid = "97f1cf4f-9d87-74a0-af3e-b413a5eb408f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.solar",
							name = "Prepare Solar Nadi",
							uuid = "52bc8036-3cb9-fed9-8de8-d7f19156830b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and not s.prep.solar",
							name = "Prepare Lunar or Phantom",
							uuid = "d0308bb9-8d60-e009-9fe4-c4671c42af60",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1120.2,
				name = "[MNK] DOTH comet Blitz preparation",
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = -0.2,
				timerStartOffset = -11.5,
				uuid = "1e68811b-a3d6-2d34-a42a-3864dbd8148a",
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
							actionID = 25768,
							conditions =
							{

								{
									"0ab42809-e7d3-c2b4-8a4a-b4d9175589f6",
									true,
								},

								{
									"448ffc71-c19d-0ba1-8abb-0c51c42ff0bf",
									true,
								},

								{
									"1040d906-652c-49a9-a41b-724d0fdbbee0",
									true,
								},

								{
									"fb422b25-5a1b-4a40-9481-55ac3c0f5c52",
									true,
								},

								{
									"b33ec153-7345-d4ff-9d01-25cda411a3ec",
									true,
								},

								{
									"97b9347d-af28-57ec-8755-827853fac179",
									true,
								},
							},
							uuid = "b6da5980-411a-b663-886d-67630cdc4ccc",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 3545,
							conditions =
							{

								{
									"0ab42809-e7d3-c2b4-8a4a-b4d9175589f6",
									true,
								},

								{
									"448ffc71-c19d-0ba1-8abb-0c51c42ff0bf",
									true,
								},

								{
									"1040d906-652c-49a9-a41b-724d0fdbbee0",
									true,
								},

								{
									"fb422b25-5a1b-4a40-9481-55ac3c0f5c52",
									true,
								},

								{
									"b33ec153-7345-d4ff-9d01-25cda411a3ec",
									true,
								},

								{
									"78c2b57b-5fbd-d9c7-bfc9-254690357346",
									true,
								},
							},
							uuid = "5dd8bab1-8006-4286-b602-06d8a8f237c9",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25769,
							conditions =
							{

								{
									"0ab42809-e7d3-c2b4-8a4a-b4d9175589f6",
									true,
								},

								{
									"448ffc71-c19d-0ba1-8abb-0c51c42ff0bf",
									true,
								},

								{
									"1040d906-652c-49a9-a41b-724d0fdbbee0",
									true,
								},

								{
									"fb422b25-5a1b-4a40-9481-55ac3c0f5c52",
									true,
								},

								{
									"b33ec153-7345-d4ff-9d01-25cda411a3ec",
									true,
								},

								{
									"733df91a-2a7b-380a-af2c-59a206a461fa",
									true,
								},
							},
							targetType = "Current Target",
							uuid = "3c53b1c7-5e6b-5cd2-b464-f3ba095a9217",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "0ab42809-e7d3-c2b4-8a4a-b4d9175589f6",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "448ffc71-c19d-0ba1-8abb-0c51c42ff0bf",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "1040d906-652c-49a9-a41b-724d0fdbbee0",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.targetable and t.attackable and t.hp.current>0 and t.distance2d<=5+t.hitradius",
							name = "Live target in Blitz range",
							uuid = "fb422b25-5a1b-4a40-9481-55ac3c0f5c52",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and s.chakra==3 and Now()<=(s.chakraUntil or 0)",
							name = "Our Blitz is prepared",
							uuid = "b33ec153-7345-d4ff-9d01-25cda411a3ec",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25768",
							name = "Prepared Blitz 25768",
							uuid = "97b9347d-af28-57ec-8755-827853fac179",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==3545",
							name = "Prepared Blitz 3545",
							uuid = "78c2b57b-5fbd-d9c7-bfc9-254690357346",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25769",
							name = "Prepared Blitz 25769",
							uuid = "733df91a-2a7b-380a-af2c-59a206a461fa",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1120.2,
				name = "[MNK] DOTH comet Blitz preparation release",
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = 8,
				uuid = "6442f25e-2032-e5f7-9e8b-d29876189ce4",
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
							actionID = 7395,
							conditions =
							{

								{
									"300dcf2e-30b2-42e9-a0e0-13272bd05d01",
									true,
								},

								{
									"12bd0c4f-7368-90fc-be2b-efd62b81e8ed",
									true,
								},

								{
									"aa3dbade-a16a-830c-b30d-44fc654f7b00",
									true,
								},

								{
									"ee5bce04-0870-0645-b0ee-d9ca3e00c44b",
									true,
								},

								{
									"d3cbc99b-250b-dee4-b39c-26195aba7fc3",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "db102cf8-4084-73de-a8ab-35b76b04cdfc",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "300dcf2e-30b2-42e9-a0e0-13272bd05d01",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "12bd0c4f-7368-90fc-be2b-efd62b81e8ed",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "aa3dbade-a16a-830c-b30d-44fc654f7b00",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"DOTH comet Blitz preparation\" and s.chakra==3 and Now()<=(s.chakraUntil or 0)",
							name = "Our comet preparation is active",
							uuid = "ee5bce04-0870-0645-b0ee-d9ca3e00c44b",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 7395,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "d3cbc99b-250b-dee4-b39c-26195aba7fc3",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1120.2,
				name = "[MNK] DOTH pre-comet Riddle of Fire",
				timeRange = true,
				timelineIndex = 194,
				timerEndOffset = -1,
				timerStartOffset = -3.2,
				uuid = "2a768dac-903d-f7b8-b7ce-22668e3c403c",
				version = 2,
			},
		},
	},
	[203] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "e63f80fc-2211-b476-9b95-56812303f472",
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
							actionLua = "local s=data.frog_mch_p6_balance\nif not s then\n s={nOptions={contentid=3458,subgroup=\"Nearest\"},hOptions={contentid=4954,subgroup=\"Nearest\"}}\n data.frog_mch_p6_balance=s\nend\nlocal n=TensorCore.getEntityByGroup(\"ContentID\",s.nOptions)\nlocal h=TensorCore.getEntityByGroup(\"ContentID\",s.hOptions)\nlocal function usable(e)\n return e and e.targetable and e.attackable and e.hp.max>0 and e.hp.current>0\n  and math.abs(e.pos.z-100)<=30 and math.max(0,e.distance2d-e.hitradius)<=25\nend\nlocal nu,hu=usable(n),usable(h)\nlocal t=TensorCore.mGetTarget()\nlocal chosen\nif nu and hu then\n local gap=100*n.hp.current/n.hp.max-100*h.hp.current/h.hp.max\n s.gap=gap\n if gap>=2 then chosen=n\n elseif gap<= -2 then chosen=h end\nelseif nu and (not t or not usable(t)) then chosen=n\nelseif hu and (not t or not usable(t)) then chosen=h end\ns.desiredID=chosen and chosen.id or nil\nself.used=true\n",
							conditions =
							{

								{
									"3cdba6e9-afb9-a872-9d90-bbb14a2841df",
									true,
								},
							},
							name = "[MCH] P6 HP safety guard",
							uuid = "3bd6e65a-a9ba-f53d-b6bf-e93b4b720082",
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
									"5fb76ed8-915e-c0fa-81ac-78d1cc957265",
									true,
								},

								{
									"3cdba6e9-afb9-a872-9d90-bbb14a2841df",
									true,
								},
							},
							name = "Correct unsafe HP split",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "3151f5b1-8b3a-12c7-b4be-f33e9a6822c4",
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
							conditionLua = "local s=data.frog_mch_p6_balance\nlocal t=TensorCore.mGetTarget()\nreturn s and s.desiredID and eventArgs.detectionTargetID==s.desiredID and (not t or t.id~=s.desiredID)",
							name = "Dragon outside HP buffer",
							uuid = "72e5c47b-7d11-fe11-80a8-cf6c5e55c6d8",
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
									"72e5c47b-7d11-fe11-80a8-cf6c5e55c6d8",
									true,
								},
							},
							filterTargetSubtype = "Highest HP",
							filterTargetType = "Enemy",
							name = "Correct dragon",
							uuid = "5fb76ed8-915e-c0fa-81ac-78d1cc957265",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "MACHINIST",
							name = "Machinist",
							uuid = "3cdba6e9-afb9-a872-9d90-bbb14a2841df",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				loop = true,
				mechanicTime = 1217.6,
				name = "[MCH] P6 HP safety guard",
				throttleTime = 200,
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 200,
				uuid = "8c7180dd-3c17-6055-b503-d4cbeeefc73a",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "afe1cc31-8f6d-2d96-b4c3-fb8ae341b904",
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
							actionID = 7396,
							conditions =
							{

								{
									"5a43bc25-a0b0-fbbe-8bc5-c94290ddacdc",
									true,
								},

								{
									"0708317e-ddbf-d822-805c-90f618b1061c",
									true,
								},

								{
									"020a6479-e523-3cbf-99ae-626fea9e94df",
									true,
								},

								{
									"d447fc27-f7ed-6f5e-be58-1e752e931a6d",
									true,
								},

								{
									"0023a36b-2e3f-4b3a-94d1-d6ca9ff12159",
									true,
								},
							},
							uuid = "b1f1c35b-0611-82ad-8178-573093bebcd4",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "5a43bc25-a0b0-fbbe-8bc5-c94290ddacdc",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "0708317e-ddbf-d822-805c-90f618b1061c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "020a6479-e523-3cbf-99ae-626fea9e94df",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.targetable and t.attackable and t.hp.current>0",
							name = "Live dragon selected",
							uuid = "d447fc27-f7ed-6f5e-be58-1e752e931a6d",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 7396,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "0023a36b-2e3f-4b3a-94d1-d6ca9ff12159",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				loop = true,
				mechanicTime = 1217.6,
				name = "[MNK] P6 Brotherhood on cooldown",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 139.1,
				uuid = "112c39f1-95bc-8432-b8be-db72b8250761",
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
							actionID = 7395,
							conditions =
							{

								{
									"3346e467-3705-f87a-be71-21ce276963d3",
									true,
								},

								{
									"83286149-b325-19e5-9bb3-4e527bebdb22",
									true,
								},

								{
									"214af066-4236-f0b5-886e-0ae059c08c3f",
									true,
								},

								{
									"f1c8aaf9-31ff-a3e0-9765-41f370ca506d",
									true,
								},

								{
									"ad385b72-5541-f187-a0fd-74a99b4df426",
									true,
								},

								{
									"78b8af20-5e0c-b860-bc10-e4f67bc3bb52",
									true,
								},
							},
							endIfUsed = true,
							uuid = "45ced26e-a62b-5f22-8031-9e604b115bcc",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7395,
							conditions =
							{

								{
									"3346e467-3705-f87a-be71-21ce276963d3",
									true,
								},

								{
									"83286149-b325-19e5-9bb3-4e527bebdb22",
									true,
								},

								{
									"214af066-4236-f0b5-886e-0ae059c08c3f",
									true,
								},

								{
									"f1c8aaf9-31ff-a3e0-9765-41f370ca506d",
									true,
								},

								{
									"d8636e84-d9a4-01fc-917a-09a8be213794",
									true,
								},

								{
									"78b8af20-5e0c-b860-bc10-e4f67bc3bb52",
									true,
								},
							},
							endIfUsed = true,
							ignoreWeaveRules = true,
							uuid = "6f6c9f1a-f467-2cda-8f78-5628f89f8ad0",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "3346e467-3705-f87a-be71-21ce276963d3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "83286149-b325-19e5-9bb3-4e527bebdb22",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "214af066-4236-f0b5-886e-0ae059c08c3f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.targetable and t.attackable and t.hp.current>0 and t.distance2d<=3+t.hitradius",
							name = "Melee uptime",
							uuid = "ad385b72-5541-f187-a0fd-74a99b4df426",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 7395,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "78b8af20-5e0c-b860-bc10-e4f67bc3bb52",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 7,
							name = "In combat",
							uuid = "f1c8aaf9-31ff-a3e0-9765-41f370ca506d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn not t or not t.targetable or not t.attackable or t.hp.current<=0 or t.distance2d>3+t.hitradius",
							name = "Personal downtime",
							uuid = "d8636e84-d9a4-01fc-917a-09a8be213794",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				loop = true,
				mechanicTime = 1217.6,
				name = "[MNK] P6 Riddle of Fire on cooldown",
				throttleTime = 250,
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 139.1,
				uuid = "93ae4200-66d4-aab0-a980-cc8e624f672a",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog",
				uuid = "9a92662f-deaa-97fe-ba42-3efea21eea5e",
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
							actionLua = "local s=data.frog_dragon_hp_v1\nif not s then\n    s={nextUpdate=0,enabled=true}\n    local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n    if FileExists(path) then\n        local ok,settings=pcall(FileLoad,path)\n        if ok and type(settings)==\"table\" then s.enabled=settings.p6_dragon_hp_window~=false end\n    end\n    function s.formatHP(value)\n        local text=string.format(\"%.0f\",value)\n        local count\n        repeat text,count=text:gsub(\"^(%-?%d+)(%d%d%d)\",\"%1,%2\") until count==0\n        return text\n    end\n    data.frog_dragon_hp_v1=s\nend\nlocal menu=data.frog_draw_settings\nlocal enabled=s.enabled\nif menu then enabled=menu.settings.p6_dragon_hp_window~=false end\nif not enabled then self.used=true return end\nlocal now=Now()\nif now>=s.nextUpdate then\n    s.nextUpdate=now+250\n    local hrae=s.hraeID and TensorCore.mGetEntity(s.hraeID)\n    local nidd=s.niddID and TensorCore.mGetEntity(s.niddID)\n    if not hrae then hrae=TensorCore.getEntityByGroup(\"ContentID\",{contentid=4954,subgroup=\"Nearest\",noAliveCheck=true}) end\n    if not nidd then nidd=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3458,subgroup=\"Nearest\",noAliveCheck=true}) end\n    s.hrae,s.nidd=nil,nil\n    s.hraeText,s.niddText=\"HRAE   --\",\"NIDD   --\"\n    if hrae and hrae.hp.max>0 then\n        s.hraeID=hrae.id\n        s.hrae=100*hrae.hp.current/hrae.hp.max\n        s.hraeText=string.format(\"HRAE  %6.2f%%   %s / %s\",s.hrae,s.formatHP(hrae.hp.current),s.formatHP(hrae.hp.max))\n    end\n    if nidd and nidd.hp.max>0 then\n        s.niddID=nidd.id\n        s.nidd=100*nidd.hp.current/nidd.hp.max\n        s.niddText=string.format(\"NIDD  %6.2f%%   %s / %s\",s.nidd,s.formatHP(nidd.hp.current),s.formatHP(nidd.hp.max))\n    end\n    s.advice=nil\n    s.high=nil\n    if s.hrae and s.nidd then\n        if math.abs(s.hrae-s.nidd)<=3.5 then s.advice=\"KEEP EVEN\"\n        else s.high=s.hrae>s.nidd and \"HRAE\" or \"NIDD\";s.advice=\"HIT \"..s.high end\n    end\nend\nif not s.hrae and not s.nidd then self.used=true return end\nif s.hrae==0 and s.nidd==0 then self.used=true return end\nGUI:SetNextWindowPos(360,220,GUI.SetCond_FirstUseEver)\nlocal visible=GUI:Begin(\"Dragon HP\",nil,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n    if s.high==\"HRAE\" then GUI:TextColored(1,0.8,0.25,1,s.hraeText) else GUI:TextUnformatted(s.hraeText) end\n    if s.high==\"NIDD\" then GUI:TextColored(1,0.8,0.25,1,s.niddText) else GUI:TextUnformatted(s.niddText) end\n    if s.advice then\n        GUI:Separator()\n        if s.high then GUI:TextColored(1,0.8,0.25,1,s.advice)\n        else GUI:TextColored(0.4,1,0.5,1,s.advice) end\n    end\nend\nGUI:End()\nself.used=true",
							conditions =
							{

								{
									"5332f441-3979-2eaa-9100-55447f493aa9",
									true,
								},

								{
									"3b970fa1-fed0-d6c8-bb9a-9d928eabd211",
									true,
								},
							},
							name = "Dragon HP window",
							uuid = "b2fab4fc-b480-d44d-8ee2-9780701d7434",
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
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "5332f441-3979-2eaa-9100-55447f493aa9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "3b970fa1-fed0-d6c8-bb9a-9d928eabd211",
							version = 3,
						},
					},
				},
				displayPath = "Frog",
				eventType = 13,
				mechanicTime = 1217.6,
				name = "[Draw] Dragon HP",
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 315.1,
				uuid = "358e89b7-a73f-dd64-a010-13afcf9f5f21",
				version = 2,
			},
		},
	},
	[205] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "bec9b432-726e-569e-b1fc-cbcf85f14938",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal s=data.frog_wb1_pairs\nif not s then self.used=true return end\ns.stay=false\nlocal guide=data.frog_draw_style_v5\nif guide.mode(\"p6_wb1\")==\"Disabled\" or not s.solution then self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.hp.current<=0 then self.used=true return end\nif s.drawPlayerID~=player.id then s.anchorPoint=nil;s.drawPlayerID=player.id end\nlocal x,y,z\nlocal destination=s.solution[player.id]\n\ns.personalAnchor=destination;s.anchorLane=s.anchors and s.anchors[player.id]\nif destination and (not s.anchors or not s.anchors[destination] or s.colors[destination]==s.colors[player.id])then self.used=true return end\nif s.personalAnchor then\n local anchor=TensorCore.mGetEntity(s.personalAnchor)\n if not anchor or anchor.hp.current<=0 then self.used=true return end\n x,y,z=anchor.pos.x,anchor.pos.y,anchor.pos.z\nelseif s.anchorLane then\n if not s.anchorPoint then s.anchorPoint={x=player.pos.x,y=player.pos.y,z=player.pos.z} end\n x,y,z=s.anchorPoint.x,s.anchorPoint.y,s.anchorPoint.z\nelse self.used=true return end\nlocal distance=(player.pos.x-x)^2+(player.pos.z-z)^2\ns.stay=distance<=1\nlocal color=s.stay and 0xFF40E080 or 0xFFFF6626\nlocal d=TensorCore.getStaticDrawer(color,1,0,guide.flags)\n\nd:addCircle(x,y+0.05,z,0.8,false,guide.flags)\nd:addCircle(x,y+0.06,z,0.15,false,guide.flags)\nif not s.stay then guide.draw(\"p6_wb1\",d,player.pos.x,player.pos.y,player.pos.z,x,y+0.05,z,8,2) end\nself.used=true",
							name = "[Draw] Wyrmsbreath 1 flex guidance",
							uuid = "4e1d99fa-88f2-aa96-b19a-3584523efbb8",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "Local fixes",
				eventType = 12,
				loop = true,
				mechanicTime = 1235.1,
				name = "[Draw] Wyrmsbreath 1 flex guidance",
				timeRange = true,
				timelineIndex = 205,
				timerStartOffset = -8,
				uuid = "07fd8dec-f07d-e54a-9500-57992f4ebff8",
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
							actionLua = "local s=data.frog_wb1_pairs\nif not s then self.used=true return end\nlocal menu=data.frog_draw_settings\nif not s.saved then\n s.saved={}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then local ok,v=pcall(FileLoad,path);if ok and type(v)==\"table\" then s.saved=v end end\nend\nlocal settings=menu and menu.settings or s.saved\nlocal text=settings.p6_wb1_pairs or \"H1 R1 M1 M2 H2 R2\"\nlocal styles=settings.draw_styles\nif styles and styles.p6_wb1==\"Disabled\" then s.personalAnchor=nil;self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nlocal members=AnyoneCore.Roster.members()\nlocal sameRoster=s.roleOrder and type(members)==\"table\"\nif sameRoster then\n for i,role in ipairs(s.roleOrder)do\n  local m=members[role]\n  if not m or m.name~=s.rosterNames[i] or m.job~=s.rosterJobs[i]then sameRoster=false;break end\n end\nend\nif sameRoster and player and s.playerID==player.id and s.signature==text and s.solvedVersion==s.colorVersion then self.used=true return end\nif Now()<s.settleUntil then self.used=true return end\ns.personalAnchor=nil;s.anchorLane=nil;s.solution=nil;s.anchors=nil\nlocal roles,seen={},{}\nfor role in text:gmatch(\"%S+\") do\n if (role~=\"H1\" and role~=\"H2\" and role~=\"M1\" and role~=\"M2\" and role~=\"R1\" and role~=\"R2\") or seen[role] then s.reason=\"Invalid pair assignments\";self.used=true return end\n seen[role]=true;roles[#roles+1]=role\nend\nif #roles~=6 then s.reason=\"Assign all six non-tank roles\";self.used=true return end\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nif type(members)~=\"table\" or type(party)~=\"table\" then self.used=true return end\nlocal byName,byJob,counts,rcounts={},{},{},{}\nfor _,a in pairs(party) do\n if a.id and a.name and a.job then byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job]or 0)+1 end\nend\nfor _,m in pairs(members) do if m.job then rcounts[m.job]=(rcounts[m.job]or 0)+1 end end\nlocal ids,used={},{}\ns.roleOrder=roles;s.rosterNames={};s.rosterJobs={}\nfor i,role in ipairs(roles) do\n local m=members[role]\n if not m or not m.name or not m.job then s.reason=\"Roster unresolved\";self.used=true return end\n s.rosterNames[i]=m.name;s.rosterJobs[i]=m.job\n local a=byName[m.name..\"\\31\"..m.job]\n if not a and counts[m.job]==1 and rcounts[m.job]==1 then a=byJob[m.job] end\n if not a or used[a.id] or not s.colors[a.id] then s.reason=\"Waiting for six colours / roster\";self.used=true return end\n used[a.id]=true;ids[i]=a.id\nend\nlocal best,bestCost\nfor _,p in ipairs({{1,2,3},{1,3,2},{2,1,3},{2,3,1},{3,1,2},{3,2,1}}) do\n local valid,cost=true,0\n for lane=1,3 do\n  if s.colors[ids[lane*2-1]]==s.colors[ids[p[lane]*2]] then valid=false;break end\n  cost=cost+(lane==p[lane] and 0 or 100)+math.abs(lane-p[lane])\n end\n if valid and (not bestCost or cost<bestCost) then best=p;bestCost=cost end\nend\nif not best then s.reason=\"No opposite-colour matching\";self.used=true return end\ns.solution={};s.anchors={}\nfor lane=1,3 do\n local anchor,flex=ids[lane*2-1],ids[best[lane]*2]\n s.solution[flex]=anchor;s.anchors[anchor]=lane\nend\nif player then\n s.playerID=player.id\n s.personalAnchor=s.solution[player.id];s.anchorLane=s.anchors[player.id]\n if s.personalAnchor and (not s.anchors[s.personalAnchor] or s.colors[s.personalAnchor]==s.colors[player.id])then s.personalAnchor=nil;s.reason=\"Invalid personal pair\" end\nend\ns.signature=text;s.solvedVersion=s.colorVersion;s.reason=nil\nself.used=true\n",
							name = "[Draw] Wyrmsbreath 1 opposite-colour pairs",
							uuid = "31552416-e055-c019-8433-e04f11a659d9",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "Local fixes",
				loop = true,
				mechanicTime = 1235.1,
				name = "[Draw] Wyrmsbreath 1 opposite-colour pairs",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 205,
				timerStartOffset = -8,
				uuid = "dc5439e7-0717-4744-a654-3899a6931e5e",
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
							actionLua = "local s=data.frog_wb1_pairs\nlocal t=TensorReactions_CurrentTimer\nif not s or (s.lastTime and t<s.lastTime-1) then s={colors={},colorVersion=0};data.frog_wb1_pairs=s end\ns.lastTime=t\nlocal id,color=eventArgs.sourceEntityID,eventArgs.newTargetContentID\nif s.colors[id]~=color then s.colors[id]=color;s.colorVersion=s.colorVersion+1;s.settleUntil=Now()+150 end\nself.used=true",
							conditions =
							{

								{
									"bc8dffc9-b10d-bd37-a1ca-35f8079c1293",
									true,
								},
							},
							name = "[Draw] Wyrmsbreath 1 colour capture",
							uuid = "c069e9e0-c6fd-48c6-a6d1-14cba820d98a",
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
							conditionLua = "local id=eventArgs.newTetherID\nlocal c=eventArgs.newTargetContentID\nreturn eventArgs.sourceEntityContentID==0 and id>=193 and id<=196 and (c==3458 or c==4954)",
							dequeueIfLuaFalse = true,
							name = "Player-to-dragon colour tether",
							uuid = "bc8dffc9-b10d-bd37-a1ca-35f8079c1293",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 15,
				loop = true,
				mechanicTime = 1235.1,
				name = "[Draw] Wyrmsbreath 1 colour capture",
				timeRange = true,
				timelineIndex = 205,
				timerStartOffset = -8,
				uuid = "21ebba5a-a1d1-fdea-8d70-aa94b7472a22",
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
							alertDuration = 1000,
							alertScale = 1,
							alertText = "Wyrmsbreath 1: STAY",
							conditions =
							{

								{
									"dfe989eb-56f2-2973-922c-03a5a464849a",
									true,
								},
							},
							name = "Stay confirmation",
							uuid = "715604eb-7dd2-1f2b-bc7e-d5b6695f86f3",
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
							conditionLua = "local s=data.frog_wb1_pairs\nlocal g=data.frog_draw_style_v5\nreturn s and s.stay==true and g and g.mode(\"p6_wb1\")~=\"Disabled\"",
							name = "Pair solved; in position",
							uuid = "dfe989eb-56f2-2973-922c-03a5a464849a",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				loop = true,
				mechanicTime = 1235.1,
				name = "[Draw] Wyrmsbreath 1 Stay confirmation",
				throttleTime = 1000,
				timeRange = true,
				timelineIndex = 205,
				timerStartOffset = -8,
				uuid = "8c3d5484-0d74-e2ec-a312-ac5c7162404d",
				version = 2,
			},
		},
	},
	[206] =
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
							actionLua = "data.frog_war_wb1 = { nidhogg = false, hraesvelgr = false }\nself.used = true",
							conditions =
							{

								{
									"bcc1eed9-6c48-2a17-917e-b74fcbf2ddd8",
									true,
								},

								{
									"6ec0fb9a-326d-238f-b763-04edcd434a19",
									true,
								},
							},
							name = "Reset mouth glows",
							uuid = "aef51fdf-0470-0839-87ed-f5451d4504b0",
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
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "bcc1eed9-6c48-2a17-917e-b74fcbf2ddd8",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "6ec0fb9a-326d-238f-b763-04edcd434a19",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.9,
				name = "[Tank] Reset",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -9,
				timerStartOffset = -12,
				uuid = "6c31f69a-cca4-26f4-8aab-21b6961bfd0b",
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
							actionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\ndata.frog_war_wb1 = data.frog_war_wb1 or {}\nlocal s = data.frog_war_wb1\nif s.drawGuidance == nil then\n    function s.drawGuidance()\n        if s.guidanceDrawn or s.nidhoggSpell == nil or s.hraesvelgrSpell == nil then return end\n        local player = TensorCore.mGetPlayer()\n        if not player or not player.pos then return end\n        local other = TensorCore.getEntityByGroup(\"Other Tank\")\n        local role = tankRole()\n        if not role then return end\n        local drawer = TensorCore.getStaticDrawer(0xE0FF8800, 2, 0, Argus2.RenderFlags.FLAG_WARP_TERRAIN + Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n        local duration = 7200\n        local shared = s.nidhoggSpell == 27955 and s.hraesvelgrSpell == 27957\n        local mtx, mtz, otx, otz\n        if shared then\n            mtx, mtz, otx, otz = 100, 100, 100, 100\n        else\n            mtx, mtz, otx, otz = 87, 87, 113, 87\n        end\n        if role==\"T2\" then mtx,mtz,otx,otz=otx,otz,mtx,mtz end\n        drawer:addTimedCircle(duration, mtx, 0, mtz, 1.0)\n        drawer:addTimedLine(duration, player.pos.x, player.pos.y, player.pos.z, mtx, 0, mtz, 0.5, 0.8)\n        if other and other.pos then\n            if not shared then drawer:addTimedCircle(duration, otx, 0, otz, 1.0) end\n            drawer:addTimedLine(duration, other.pos.x, other.pos.y, other.pos.z, otx, 0, otz, 0.5, 0.8)\n        end\n        s.guidanceDrawn = true\n    end\nend\ns.nidhoggSpell = eventArgs.spellID\ns.nidhogg = eventArgs.spellID == 27955\ns.drawGuidance()\nself.used = true",
							conditions =
							{

								{
									"30a7ab31-8230-cfaa-9e51-c1ed3bd3fae7",
									true,
								},

								{
									"6b5ee226-40d8-d440-9d86-4f1b841a8a09",
									true,
								},

								{
									"9eab25b8-1167-014e-b989-4264a5049e58",
									true,
								},
							},
							name = "Capture Nidhogg cast",
							uuid = "3b85e1a8-8136-5d86-9e9f-4e3a4820fd37",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\ndata.frog_war_wb1 = data.frog_war_wb1 or {}\nlocal s = data.frog_war_wb1\nif s.drawGuidance == nil then\n    function s.drawGuidance()\n        if s.guidanceDrawn or s.nidhoggSpell == nil or s.hraesvelgrSpell == nil then return end\n        local player = TensorCore.mGetPlayer()\n        if not player or not player.pos then return end\n        local other = TensorCore.getEntityByGroup(\"Other Tank\")\n        local role = tankRole()\n        if not role then return end\n        local drawer = TensorCore.getStaticDrawer(0xE0FF8800, 2, 0, Argus2.RenderFlags.FLAG_WARP_TERRAIN + Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n        local duration = 7200\n        local shared = s.nidhoggSpell == 27955 and s.hraesvelgrSpell == 27957\n        local mtx, mtz, otx, otz\n        if shared then\n            mtx, mtz, otx, otz = 100, 100, 100, 100\n        else\n            mtx, mtz, otx, otz = 87, 87, 113, 87\n        end\n        if role==\"T2\" then mtx,mtz,otx,otz=otx,otz,mtx,mtz end\n        drawer:addTimedCircle(duration, mtx, 0, mtz, 1.0)\n        drawer:addTimedLine(duration, player.pos.x, player.pos.y, player.pos.z, mtx, 0, mtz, 0.5, 0.8)\n        if other and other.pos then\n            if not shared then drawer:addTimedCircle(duration, otx, 0, otz, 1.0) end\n            drawer:addTimedLine(duration, other.pos.x, other.pos.y, other.pos.z, otx, 0, otz, 0.5, 0.8)\n        end\n        s.guidanceDrawn = true\n    end\nend\ns.hraesvelgrSpell = eventArgs.spellID\ns.hraesvelgr = eventArgs.spellID == 27957\ns.drawGuidance()\nself.used = true",
							conditions =
							{

								{
									"30a7ab31-8230-cfaa-9e51-c1ed3bd3fae7",
									true,
								},

								{
									"6b5ee226-40d8-d440-9d86-4f1b841a8a09",
									true,
								},

								{
									"56ee7bdc-61e1-af7b-92f0-904aaebf9ce3",
									true,
								},
							},
							name = "Capture Hraesvelgr cast",
							uuid = "8e5176a9-2d86-1801-89d6-6f592e43e90a",
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
							name = "Nidhogg 27954/27955",
							spellIDList =
							{
								27954,
								27955,
							},
							uuid = "9eab25b8-1167-014e-b989-4264a5049e58",
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
							name = "Hraesvelgr 27956/27957",
							spellIDList =
							{
								27956,
								27957,
							},
							uuid = "56ee7bdc-61e1-af7b-92f0-904aaebf9ce3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "30a7ab31-8230-cfaa-9e51-c1ed3bd3fae7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "6b5ee226-40d8-d440-9d86-4f1b841a8a09",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1235.9,
				name = "[Tank] Buster Capture + Spots",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -3.0999999046326,
				timerStartOffset = -9,
				uuid = "fcc02e61-1eb1-13ee-8bdd-680e972b0f84",
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
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "Shared buster",
							conditions =
							{

								{
									"56bc9f5c-4b68-d10c-9804-38b6868b55d5",
									true,
								},

								{
									"83b33c08-4162-b3a1-9526-e54dc595b0ab",
									true,
								},

								{
									"619bfcb8-3f98-4a07-9456-e593fe8fa30a",
									true,
								},
							},
							endIfUsed = true,
							name = "Shared buster",
							uuid = "31afcf1d-3986-99f0-859b-345de3e9d20f",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "Buster on you",
							conditions =
							{

								{
									"56bc9f5c-4b68-d10c-9804-38b6868b55d5",
									true,
								},

								{
									"83b33c08-4162-b3a1-9526-e54dc595b0ab",
									true,
								},

								{
									"110a6e6b-c612-168d-8c41-31a540e8de45",
									true,
								},
							},
							endIfUsed = true,
							name = "Buster on you",
							uuid = "35064076-f80b-9e86-bf30-ed7d1f30c93d",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "Buster on other tank",
							conditions =
							{

								{
									"56bc9f5c-4b68-d10c-9804-38b6868b55d5",
									true,
								},

								{
									"83b33c08-4162-b3a1-9526-e54dc595b0ab",
									true,
								},

								{
									"bfd133b5-badd-1cae-8fbf-82f3b1f7d04b",
									true,
								},
							},
							endIfUsed = true,
							name = "Buster on other tank",
							uuid = "b0a02c40-f1c1-c784-b0ed-edcdf19b5907",
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
							conditionLua = "local s=data.frog_war_wb1\nreturn s~=nil and s.nidhogg==true and s.hraesvelgr==true",
							name = "Shared buster",
							uuid = "619bfcb8-3f98-4a07-9456-e593fe8fa30a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nlocal r=tankRole()\nlocal s=data.frog_war_wb1\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil and ((r==\"T1\" and (s.hraesvelgr==true and s.nidhogg~=true)) or (r==\"T2\" and (s.nidhogg==true and s.hraesvelgr~=true)))",
							name = "Buster on you",
							uuid = "110a6e6b-c612-168d-8c41-31a540e8de45",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nlocal r=tankRole()\nlocal s=data.frog_war_wb1\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil and ((r==\"T1\" and (s.nidhogg==true and s.hraesvelgr~=true)) or (r==\"T2\" and (s.hraesvelgr==true and s.nidhogg~=true)))",
							name = "Buster on other tank",
							uuid = "bfd133b5-badd-1cae-8fbf-82f3b1f7d04b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "56bc9f5c-4b68-d10c-9804-38b6868b55d5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "83b33c08-4162-b3a1-9526-e54dc595b0ab",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.9,
				name = "[Tank] Buster Callout",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "b33a7136-f6fa-5760-911d-ae59f808c03d",
				version = 2,
			},
		},
	},
	[207] =
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
							actionLua = "local s=data.frog_vow_v1\nif not self.started then\n local settings=data.frog_draw_settings and data.frog_draw_settings.settings\n if not settings then\n  local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n  if FileExists(path) then\n   local ok,saved=pcall(FileLoad,path)\n   if ok and type(saved)==\"table\" then settings=saved end\n  end\n end\n s={bossID=eventArgs.entityID,holder=eventArgs.targetID,initial=eventArgs.targetID,\n    passAt=Now()+34000,passes=0,seen={[eventArgs.targetID]=true},order={},slots={},ready=false,done=false,\n    groups={T={\"MT\",\"OT\"},M={\"M1\",\"M2\"},R={\"R1\",\"R2\"}},\n    roleKeys={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}}\n if settings and settings.p6_vow_melee==\"M2\" then s.groups.M={\"M2\",\"M1\"} end\n local orderText=settings and settings.vow_pass_order or \"T T M R\"\n if type(orderText)~=\"string\" then orderText=\"T T M R\" end\n for token in string.upper(orderText):gmatch(\"[^%s,]+\") do\n  if not s.groups[token] then s.done=true end\n  s.order[#s.order+1]=token\n end\n if #s.order~=4 then s.done=true end\n function s.choose()\n  s.receiver=nil\n  if not s.ready or s.done or s.passes>=4 then return end\n  \n  if s.passes==3 then s.receiver=s.slots.R2; return end\n  local candidates=s.groups[s.order[s.passes+1]]\n  for _,role in ipairs(candidates or {}) do\n   local id=s.slots[role]\n   if role~=\"H1\" and role~=\"H2\" and id and not s.seen[id] then s.receiver=id; return end\n  end\n end\n data.frog_vow_v1=s\n self.started=true\nend\nif s.done then self.used=true return end\n\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nif type(members)~=\"table\" or type(party)~=\"table\" then return end\nlocal byNameJob,byJob,partyCount,rosterCount={},{},{},{}\nfor _,actor in pairs(party) do\n if actor and actor.id and actor.job and actor.name then\n  byNameJob[tostring(actor.name)..\"\\31\"..tostring(actor.job)]=actor\n  byJob[actor.job]=actor\n  partyCount[actor.job]=(partyCount[actor.job] or 0)+1\n end\nend\nfor _,member in pairs(members) do\n if member and member.job then rosterCount[member.job]=(rosterCount[member.job] or 0)+1 end\nend\n\nlocal missing=false\nfor job in pairs(rosterCount) do if not partyCount[job] then missing=true break end end\nif missing then\n for _,actor in pairs(EntityList(\"\")) do\n  if actor and actor.id and actor.job and actor.name and actor.hp.current<=0\n   and rosterCount[actor.job] and not party[actor.id] then\n   byNameJob[tostring(actor.name)..\"\\31\"..tostring(actor.job)]=actor\n   byJob[actor.job]=actor\n   partyCount[actor.job]=(partyCount[actor.job] or 0)+1\n  end\n end\nend\nlocal used={}\nfor role,key in pairs(s.roleKeys) do\n local member=members[key]\n if not member or not member.name or not member.job then return end\n local actor=byNameJob[tostring(member.name)..\"\\31\"..tostring(member.job)]\n if not actor and partyCount[member.job]==1 and rosterCount[member.job]==1 then actor=byJob[member.job] end\n if not actor or used[actor.id] then return end\n s.slots[role]=actor.id\n used[actor.id]=true\nend\nif not used[s.initial] then return end\ns.ready=true\ns.choose()\nself.used=true",
							conditions =
							{

								{
									"b6549934-2e6f-6871-9101-c4f67acfdd3b",
									true,
								},
							},
							name = "[Draw] Mortal Vow Assignment Capture",
							uuid = "4977331d-ee1e-b6c5-a557-756da0e05be5",
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
							eventSpellID = 27952,
							name = "Initial Mortal Vow",
							uuid = "b6549934-2e6f-6871-9101-c4f67acfdd3b",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1243.1,
				name = "[Draw] Mortal Vow Assignment Capture",
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 158.6,
				timerStartOffset = -5,
				uuid = "75468594-1190-acdd-97da-b53332268b43",
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
							actionLua = "local s=data.frog_vow_v1\nif not s or s.done then self.used=true return end\nlocal id=eventArgs.entityID\nif id~=s.holder then\n if s.seen[id] and not (s.passes==3 and id==s.slots.R2) then\n  \n  s.done=true\n  s.receiver=nil\n else\n  s.passAt=Now()+34000\n  s.holder=id\n  s.seen[id]=true\n  s.passes=s.passes+1\n  if s.passes>=4 then s.done=true end\n  s.choose()\n end\nend\nself.used=true",
							conditions =
							{

								{
									"c0ecccec-8d8f-48c9-ad67-756217321951",
									true,
								},

								{
									"2cdb9ee1-0d45-8df5-9f30-bcba233e0d48",
									true,
								},
							},
							name = "[Draw] Mortal Vow Transfer Capture",
							uuid = "ddba0b9b-5948-caa5-9113-66583fc79a44",
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
							eventBuffID = 2896,
							name = "Mortal Vow debuff",
							uuid = "c0ecccec-8d8f-48c9-ad67-756217321951",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_vow_v1\nif not s or not s.ready then return false end\nfor _,id in pairs(s.slots) do\n if id==eventArgs.entityID then return true end\nend\nreturn false",
							name = "Mapped Vow recipient",
							uuid = "2cdb9ee1-0d45-8df5-9f30-bcba233e0d48",
							version = 3,
						},
					},
				},
				eventType = 8,
				loop = true,
				mechanicTime = 1243.1,
				name = "[Draw] Mortal Vow Transfer Capture",
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 158.6,
				timerStartOffset = -5,
				uuid = "1de71efc-297c-9413-a1b9-afb354dec20c",
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
							actionLua = "\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\n\nself.used=true\nlocal s=data.frog_vow_v1\nif not s or not s.ready or s.done or s.passes>=4 then return end\nlocal boss=TensorCore.mGetEntity(s.bossID)\nif not boss then return end\nif boss.hp.current<=0 then s.done=true; s.receiver=nil; return end\nif frogGuide.mode(\"p6_vow\")==\"Disabled\" then return end\nlocal player=TensorCore.mGetPlayer()\nif not player or not player.pos or player.hp.current<=0 then return end\nif player.id~=s.holder and player.id~=s.receiver then return end\nlocal holder=TensorCore.mGetEntity(s.holder)\nlocal receiver=s.receiver and TensorCore.mGetEntity(s.receiver)\nif not holder or not receiver or not holder.pos or not receiver.pos\n or receiver.hp.current<=0 then return end\nlocal buff=TensorCore.getBuff(holder,2896)\nif not buff or buff.duration<=0 or buff.duration>10 then return end\nlocal dx,dz=holder.pos.x-receiver.pos.x,holder.pos.z-receiver.pos.z\n\nif dx*dx+dz*dz<=25 then return end\nlocal target=player.id==s.holder and receiver or holder\nlocal drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,frogGuide.flags)\nfrogGuide.draw(\"p6_vow\",drawer,player.pos.x,player.pos.y,player.pos.z,\n target.pos.x,target.pos.y,target.pos.z,8,2)\n",
							name = "[Draw] Mortal Vow Personal Guidance",
							uuid = "5761dae7-72c7-a6ef-b3a4-83f75fd1765d",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1243.1,
				name = "[Draw] Mortal Vow Personal Guidance",
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 158.6,
				timerStartOffset = -5,
				uuid = "27e0136f-a29f-afa4-91b8-0f9689614736",
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
							actionLua = "local s=data.frog_vow_v1\nlocal labels={MT=\"main tank\",OT=\"off tank\",M1=\"melee 1\",M2=\"melee 2\",R1=\"ranged 1\",R2=\"ranged 2\",H1=\"healer 1\",H2=\"healer 2\"}\nlocal from,to\nfor role,id in pairs(s.slots) do\n if id==s.holder then from=labels[role] end\n if id==s.receiver then to=labels[role] end\nend\nif not from or not to then return end\nTensorCore.addAlertText(5000,from..\" to \"..to,1.5,2,true)\ns.ttsPass=s.passes\nself.used=true",
							conditions =
							{

								{
									"7b8c4e3b-31a1-42dc-9ac3-8172b3364f98",
									true,
								},
							},
							name = "Call Vow recipient",
							uuid = "a16e054f-0609-e4b9-a3a2-872d2c7d7fac",
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
							conditionLua = "local s=data.frog_vow_v1\nif not s or not s.ready or s.done or s.passes>=4 or not s.receiver or s.ttsPass==s.passes then return false end\nlocal g=data.frog_draw_style_v5\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings or g and g.settings or {}\nlocal mode=settings.p6_vow_tts_mode or \"Personal\"\nif mode==\"Disabled\" then return false end\nif mode==\"Personal\" then\n local player=TensorCore.mGetPlayer()\n if not player or player.id~=s.receiver and player.id~=s.holder then return false end\nend\nlocal holder=TensorCore.mGetEntity(s.holder)\nlocal receiver=TensorCore.mGetEntity(s.receiver)\nif not holder or not receiver or receiver.hp.current<=0 then return false end\nlocal buff=TensorCore.getBuff(holder,2896)\nlocal early=mode==\"Shotcaller\" and 10 or 5\nreturn buff~=nil and buff.duration>0 and buff.duration<=early",
							name = "Vow pass warning",
							uuid = "7b8c4e3b-31a1-42dc-9ac3-8172b3364f98",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1243.1,
				name = "[Callout] Mortal Vow Recipient",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 207,
				timerEndOffset = 158.6,
				timerStartOffset = -5,
				uuid = "209b208f-2719-b2a3-a9fa-e260d1405aed",
				version = 2,
			},
		},
	},
	[208] =
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
							actionLua = "local hrae=TensorCore.getEntityByGroup(\"ContentID\",{contentid=4954,subgroup=\"Nearest\"})\nlocal nidd=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3458,subgroup=\"Nearest\"})\nif not hrae or not nidd or hrae.hp.max<=0 or nidd.hp.max<=0 or hrae.hp.current<=0 or nidd.hp.current<=0 then self.used=true return end\nlocal h=100*hrae.hp.current/hrae.hp.max\nlocal n=100*nidd.hp.current/nidd.hp.max\nlocal advice=\"KEEP THEM EVEN\"\nif math.abs(h-n)>3.5 then advice=h>n and \"HIT HRAE\" or \"HIT NIDD\" end\nTensorCore.sendParsedChatMessage(string.format(\"/e HRAE %.2f%% | NIDD %.2f%% | %s\",h,n,advice))\nself.used=true",
							conditions =
							{

								{
									"6d42e5a1-3794-9889-aca6-f66eb972a436",
									true,
								},
							},
							name = "Akh Afah HP advice",
							uuid = "ac88fa5b-5ba4-99e1-bfc7-748e40f0c58e",
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
							conditionLua = "local menu=data.frog_draw_settings\nif menu then return menu.settings.p6_akh_afah_hp==true end\nif not data.frog_afah_hp_settings then\n local settings={}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,saved=pcall(FileLoad,path)\n  if ok and type(saved)==\"table\" then settings=saved end\n end\n data.frog_afah_hp_settings=settings\nend\nreturn data.frog_afah_hp_settings.p6_akh_afah_hp==true",
							dequeueIfLuaFalse = true,
							name = "HP callout enabled",
							uuid = "6d42e5a1-3794-9889-aca6-f66eb972a436",
							version = 3,
						},
					},
				},
				mechanicTime = 1254.2,
				name = "[Callout] Akh Afah HP 1",
				timelineIndex = 208,
				timerOffset = -13,
				uuid = "f40cd0cd-fe88-0832-8d60-06d3e2339b6c",
				version = 2,
			},
		},
	},
	[211] =
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
							actionLua = "self.used=true\nlocal id=eventArgs.spellID\nlocal s=data.frog_hw\nif id==27966 then\n if s and s.phase==1 then\n  local e=TensorCore.mGetEntity(eventArgs.entityID)\n  if e then s.diveSide=e.pos.x<100 and 1 or -1;s.revision=s.revision+1 end\n end\n return\nend\nif id==27947 or id==27949 then\n if s and s.phase==2 then s.hot=id==27947 and \"Wing\" or \"Tail\";s.revision=s.revision+1 end\n return\nend\nif s and s.arrow then Argus.deleteTimedShape(s.arrow) end\nlocal boss=TensorCore.mGetEntity(eventArgs.entityID)\nif not boss then return end\ns={id=id,phase=TensorReactions_CurrentTimer<1300 and 1 or 2,revision=1,\n expires=TensorReactions_CurrentTimer+eventArgs.channelTimeMax+1.4,\n axis=boss.pos.x>=100 and 1 or -1,near=id==27939 or id==27942,\n side=(id==27939 or id==27940) and -1 or 1}\nfunction s.point(tank,wall,north)\n local a=s.axis\n local zside=s.side*a\n local function point(x,dz)return 100+a*x,100+zside*dz end\n if s.phase==1 then\n  if not s.diveSide and (not s.nextDiveProbe or Now()>=s.nextDiveProbe) then\n   s.nextDiveProbe=Now()+100\n   for _,e in pairs(TensorCore.entityList(\"contentid=3458\")) do\n    if math.abs(e.pos.z-100)>28 and math.abs(e.pos.x-100)>5 then s.diveSide=e.pos.x<100 and 1 or -1;break end\n   end\n  end\n  if not s.diveSide then return end\n  local safe=s.diveSide*a\n  local close=safe>0 and 17 or -2\n  local far=safe>0 and 2 or -17\n  if not tank then return point(s.near and far or close,10) end\n  local dz=north and (zside<0 and 19 or 6) or (zside<0 and 6 or 19)\n  return point(s.near and close or far,dz)\n end\n if not s.hot then return end\n if not tank then return point(s.near and -1 or 17,s.hot==\"Wing\" and 2.5 or 15) end\n local x=wall and (s.near and 21 or -21) or (s.near and 8 or -6)\n return point(x,s.hot==\"Wing\" and (wall and 3.25 or 1.5) or (wall and 12 or 17))\nend\ndata.frog_hw=s\n\n",
							conditions =
							{

								{
									"793050e8-db49-b76c-92d7-bc8867dcd0bd",
									true,
								},
							},
							name = "Wings capture",
							uuid = "9fb0616b-e074-bf31-be1e-068f35f74f28",
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
							spellIDList =
							{
								27939,
								27940,
								27942,
								27943,
								27947,
								27949,
								27966,
							},
							uuid = "793050e8-db49-b76c-92d7-bc8867dcd0bd",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1268.7,
				name = "[Draw] Wings capture",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 80,
				timerStartOffset = -15,
				uuid = "528fa0d3-8b8c-0fed-93f6-c3de32d9d16a",
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
							actionLua = "self.used=true\nlocal s=data.frog_hw\nif not s or TensorReactions_CurrentTimer>=s.expires then return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.hp.current<=0 then return end\nlocal p=data.frog_draw_settings\nif not p then return end\nlocal styles=p.settings.draw_styles or {}\nif styles.p6_hw_party==\"Disabled\" then return end\nlocal x,z=s.point(false)\nif not x then return end\nlocal key=tostring(s.revision)..\":\"..x..\":\"..z\nif s.arrowKey==key then return end\nif s.arrow then Argus.deleteTimedShape(s.arrow);s.arrow=nil end\ns.arrowKey=key\nlocal dx,dz=x-100,z-100\nlocal length=math.sqrt(dx*dx+dz*dz)\nlocal drawer=TensorCore.getStaticDrawer(0xFF00FFFF,1,0,Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\ns.arrow=drawer:addTimedArrow(math.max(1,(s.expires-TensorReactions_CurrentTimer)*1000),100,0.08,100,math.atan2(dx,dz),math.max(0.1,length-2),0.6,2,1.5,0,false,Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n",
							conditions =
							{

								{
									"0a910dec-5543-29ad-b923-4360a4b64c3c",
									false,
								},
							},
							name = "Wings party",
							uuid = "ba8ed4fc-e247-e3ff-80bd-b8c094dbe92f",
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
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							uuid = "0a910dec-5543-29ad-b923-4360a4b64c3c",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1268.7,
				name = "[Draw] Wings party",
				throttleTime = 100,
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 80,
				timerStartOffset = -15,
				uuid = "04bed977-37fe-bc6f-bf11-f7332290addb",
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
							actionLua = "self.used=true\nlocal s=data.frog_hw\nif not s or TensorReactions_CurrentTimer>=s.expires then return end\nlocal p=data.frog_draw_settings\nif not p then return end\nlocal function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nlocal player=TensorCore.mGetPlayer()\nif not player or player.hp.current<=0 then return end\nif s.rolePlayer~=player.id then s.rolePlayer=player.id;s.role=nil;s.roleRetry=nil end\nif not s.role and (not s.roleRetry or Now()>=s.roleRetry) then\n s.roleRetry=Now()+500\n s.role=tankRole()\nend\nlocal role=s.role\nif not role then return end\nlocal x,z=s.point(true,role==(p.hwWall or \"T1\"),role==(p.hwNorth or \"T1\"))\nif not x then return end\nlocal styles=p.settings.draw_styles or {}\nif styles.p6_hw_tank==\"Disabled\" then return end\nlocal flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY\nlocal drawer=TensorCore.getStaticDrawer(0xFF00FFFF,1,0,flags)\ndrawer:addCircle(x,0.08,z,0.35,false,flags)\ndrawer:addLine(player.pos.x,player.pos.y,player.pos.z,x,0.08,z,8,2)\n",
							conditions =
							{

								{
									"d8cc3c2c-eab7-0829-9763-4ead255a3fee",
									true,
								},
							},
							name = "Wings tanks",
							uuid = "3168ba20-76c2-9bcc-8df1-5c546cd1d0c1",
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
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							uuid = "d8cc3c2c-eab7-0829-9763-4ead255a3fee",
							version = 3,
						},
					},
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1268.7,
				name = "[Draw] Wings tanks",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 80,
				timerStartOffset = -15,
				uuid = "7aca9c61-59cb-985d-ba64-01d4bf6beab1",
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
							actionLua = "self.used=true\nlocal s=data.frog_hw\nif s and s.arrow then Argus.deleteTimedShape(s.arrow) end\ndata.frog_hw=nil\n",
							conditions =
							{

								{
									"1bb9b162-1af7-a233-ac95-2d5e4d881c8b",
									true,
								},
							},
							name = "Wings clear",
							uuid = "61cd3d80-d7cd-1541-ab3b-bf0f905a36b4",
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
							spellIDList =
							{
								27945,
							},
							uuid = "1bb9b162-1af7-a233-ac95-2d5e4d881c8b",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1268.7,
				name = "[Draw] Wings clear",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 80,
				timerStartOffset = -15,
				uuid = "7a233f25-1aef-5b79-9021-1e130fdb46d6",
				version = 2,
			},
		},
	},
	[213] =
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
							actionLua = "data.frog_wroth_start_v1={orbs={},seen={},count=0,stage=\"collecting\"}\nlocal s=data.frog_wroth_start_v1\nfunction s.tryDraw()\n    if s.stage~=\"collecting\" or s.count<6 or (s.diveX==nil and not s.dive) or not s.akhEnd then return end\n    local remaining=s.akhEnd-Now()\n    if remaining<=0 then s.stage=\"expired\" return end\n    \n    local tx,tz=0,0\n    for i=4,6 do tx=tx+s.orbs[i].x tz=tz+s.orbs[i].z end\n    tx,tz=200-tx/3,200-tz/3\n    \n    if math.abs(math.abs(tx-100)-13)>1 or math.abs(math.abs(tz-100)-13)>1 then\n        s.stage=\"unrecognised pattern\" return\n    end\n    local diveX=s.diveX or s.dive.x\n    \n    if math.abs(diveX-100)<=2 then diveX=100\n    elseif math.abs(diveX-89)<=2 then diveX=89\n    elseif math.abs(diveX-111)<=2 then diveX=111\n    else return end\n    \n    \n    local x=79\n    if math.abs(x-diveX)<=12 then x=200-x end\n    if math.abs(x-diveX)<=12 then return end\n    local z=tz>100 and 113 or 87\n    local dx,dz\n    \n    for i=1,3 do\n        local orb=s.orbs[i]\n        if math.abs(x-orb.x)<=4 or math.abs(z-orb.z)<=4 then\n            s.stage=\"no verified first-wave-safe start\" return\n        end\n    end\n    dx,dz=x-100,z-100\n    local length=math.sqrt(dx*dx+dz*dz)\n    local flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n    local drawer=TensorCore.getStaticDrawer(0xFF33FF33,1,0,flags)\n    drawer:setGradient(0,1,0)\n    s.arrow=drawer:addTimedArrow(remaining,100,0.08,100,math.atan2(dx,dz),length-3,1.5,3,4,0,false,flags)\n    drawer:setGradient() \n    s.startX,s.startZ=x,z\n    s.stage=\"guiding\"\n    local direction=(z<100 and \"north\" or \"south\")..(x<100 and \"west\" or \"east\")\n    local markerNames={\"A\",\"B\",\"C\",\"D\",\"1\",\"2\",\"3\",\"4\"}\n    local marker,best=nil,math.huge\n    for id=1,8 do\n        local mx,my,mz,active=Argus.getWaymarkInfo(id)\n        if active and (mx-100)*(x-100)>0 and (mz-100)*(z-100)>0 then\n            local distance=(mx-x)^2+(mz-z)^2\n            if distance<best then marker,best=markerNames[id],distance end\n        end\n    end\n    local message=\"Wroth start: \"..(marker and marker..\", \" or \"\")..direction\n    TensorCore.addAlertText(8000,(marker and marker..\", \" or \"\")..direction,1.5,2,false)\n    TensorCore.sendTTS(message)\nend\nself.used=true",
							conditions =
							{

								{
									"45d8514e-1e80-26f4-b4a9-7af21505f39e",
									true,
								},
							},
							name = "Initialize Wroth starting-point solver",
							uuid = "b1231be6-4197-ca46-8243-fa162aa5734d",
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
							eventSpellID = 27973,
							name = "Wroth Flames 27973",
							uuid = "45d8514e-1e80-26f4-b4a9-7af21505f39e",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 1282.7,
				name = "[Draw] Wroth Start Setup",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 1,
				timerStartOffset = -5,
				uuid = "20858df7-dd6b-d8fb-9d50-cd29fabab34e",
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
							actionLua = "local s=data.frog_wroth_start_v1\nif not s then self.used=true return end\nif s.seen[eventArgs.entityID] or s.count>=9 then self.used=true return end\nlocal entity=TensorCore.mGetEntity(eventArgs.entityID)\nif not entity or not entity.pos then return end\ns.count=s.count+1\ns.seen[eventArgs.entityID]=true\ns.orbs[s.count]={x=entity.pos.x,z=entity.pos.z}\ns.tryDraw()\nself.used=true",
							conditions =
							{

								{
									"b5b0d057-a675-5a4c-a2c3-88187fd409eb",
									true,
								},
							},
							name = "Capture orb spawn order",
							uuid = "ca2fc4ce-303c-98e8-9355-4cb14a6db0d8",
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
							eventEntityContentID = 3459,
							name = "Scarlet Price 3459",
							uuid = "b5b0d057-a675-5a4c-a2c3-88187fd409eb",
							version = 3,
						},
					},
				},
				eventType = 5,
				loop = true,
				mechanicTime = 1282.7,
				name = "[Draw] Wroth Orb Order and Start Arrow",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 10.699999809265,
				uuid = "a174b377-08ab-7323-995a-a1d31955d057",
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
							actionLua = "local s=data.frog_wroth_start_v1\nif not s then self.used=true return end\ns.dive={x=eventArgs.x,z=eventArgs.z,sin=math.sin(eventArgs.heading),cos=math.cos(eventArgs.heading),width=eventArgs.aoeWidth,length=eventArgs.aoeLength}\ns.tryDraw()\nself.used=true",
							conditions =
							{

								{
									"a09a4459-4950-d7ae-bbf0-1b14adcea33d",
									true,
								},
							},
							name = "Capture Cauterize rectangle",
							uuid = "9b346afa-27e5-591c-99ff-62a0d69a5b0f",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "local s=data.frog_wroth_start_v1\nif not s or s.akhEnd then self.used=true return end\nlocal timer=eventArgs.duration*1000\ns.akhEnd=Now()+timer\nlocal player=TensorCore.mGetPlayer()\nif AnyoneCore and player then\n    AnyoneCore.addWorldTextCountdownOnEnt(timer,player.id,AnyoneCore.white,true,1.5,2)\nend\ns.tryDraw()\nself.used=true",
							conditions =
							{

								{
									"a40633aa-ccc8-cc02-87ab-cf826530106e",
									true,
								},
							},
							name = "First Akh Morn world countdown",
							uuid = "81159089-fa23-9996-ad6f-77c86abc4c28",
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
							conditionLua = "return eventArgs.aoeID==27967 and eventArgs.contentID==4954",
							dequeueIfLuaFalse = true,
							name = "Hraesvelgr Cauterize 27967",
							uuid = "a09a4459-4950-d7ae-bbf0-1b14adcea33d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return eventArgs.aoeID==27974 and (eventArgs.contentID==3458 or eventArgs.contentID==4954)",
							dequeueIfLuaFalse = true,
							name = "First Akh Morn 27974",
							uuid = "a40633aa-ccc8-cc02-87ab-cf826530106e",
							version = 3,
						},
					},
				},
				eventType = 18,
				loop = true,
				mechanicTime = 1282.7,
				name = "[Draw] Wroth Cauterize and Akh Morn Countdown",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 10.699999809265,
				uuid = "9162dbb8-ebbd-ce21-a38c-b8bf30031945",
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
							actionLua = "local s=data.frog_wroth_start_v1\nif not s or s.stage~=\"collecting\" then self.used=true return end\nlocal e=TensorCore.mGetEntity(eventArgs.entityID)\nif not e or not e.pos then return end\n\nif math.abs(e.pos.z-100)<30 then self.used=true return end\nlocal x=e.pos.x\nif math.abs(x-100)<=2 then x=100\nelseif math.abs(x-89)<=2 then x=89\nelseif math.abs(x-111)<=2 then x=111\nelse self.used=true return end\ns.diveX=x\ns.tryDraw()\nself.used=true",
							conditions =
							{

								{
									"cfbd98aa-c590-0d46-94c9-0b0e6462fdaf",
									true,
								},

								{
									"791d4b83-2c48-dc10-ab2f-2553672fee69",
									true,
								},
							},
							name = "Capture dive side on arrival",
							uuid = "245a125f-ee49-e3dd-ba2d-2af1cb7d3dab",
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
							conditionLua = "return eventArgs.entityContentID==4954",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventEntityContentID = 4954,
							name = "Hraesvelgr",
							uuid = "cfbd98aa-c590-0d46-94c9-0b0e6462fdaf",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 3,
							name = "Reappeared",
							uuid = "791d4b83-2c48-dc10-ab2f-2553672fee69",
							version = 3,
						},
					},
				},
				eventType = 22,
				loop = true,
				mechanicTime = 1282.7,
				name = "[Draw] Wroth Dragon Arrival",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 10.7,
				uuid = "f5e84434-d959-37d6-9c9f-d2ca171bc691",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "ff443817-93b3-b3c4-9568-9b87370472bc",
			},
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "2f2b9ddd-a97f-9906-aeb7-f7b593eec85e",
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
							actionID = 7395,
							conditions =
							{

								{
									"cfc6b924-194e-b3ae-aa06-6ccdfde196fe",
									true,
								},

								{
									"f1cebb54-94f1-6fdb-9f95-5a7bdf0ecf17",
									true,
								},

								{
									"20159954-9ed3-e9ae-9d35-8a757872daf2",
									true,
								},

								{
									"ed405a61-fcc9-422f-b45e-c0012d093b3a",
									true,
								},

								{
									"b7d0ef42-2ccd-4fab-9c98-7e94463958b6",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "0bd7d4cc-d47a-0d0e-9c32-cf9d4d6b6a9b",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "cfc6b924-194e-b3ae-aa06-6ccdfde196fe",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "f1cebb54-94f1-6fdb-9f95-5a7bdf0ecf17",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "20159954-9ed3-e9ae-9d35-8a757872daf2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.hp.current>0 and (not t.targetable or not t.attackable or t.distance2d>3+t.hitradius)",
							name = "Live dragon; personal melee gap",
							uuid = "ed405a61-fcc9-422f-b45e-c0012d093b3a",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 7395,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "b7d0ef42-2ccd-4fab-9c98-7e94463958b6",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				enabled = false,
				mechanicTime = 1282.7,
				name = "[MNK] Wroth downtime Riddle of Fire",
				timeRange = true,
				timelineIndex = 213,
				timerEndOffset = 18,
				uuid = "ee53b245-be71-0bbf-9fe8-291d530c988c",
				version = 2,
			},
		},
	},
	[223] =
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
							actionLua = "local hrae=TensorCore.getEntityByGroup(\"ContentID\",{contentid=4954,subgroup=\"Nearest\"})\nlocal nidd=TensorCore.getEntityByGroup(\"ContentID\",{contentid=3458,subgroup=\"Nearest\"})\nif not hrae or not nidd or hrae.hp.max<=0 or nidd.hp.max<=0 or hrae.hp.current<=0 or nidd.hp.current<=0 then self.used=true return end\nlocal h=100*hrae.hp.current/hrae.hp.max\nlocal n=100*nidd.hp.current/nidd.hp.max\nlocal advice=\"KEEP THEM EVEN\"\nif math.abs(h-n)>3.5 then advice=h>n and \"HIT HRAE\" or \"HIT NIDD\" end\nTensorCore.sendParsedChatMessage(string.format(\"/e HRAE %.2f%% | NIDD %.2f%% | %s\",h,n,advice))\nself.used=true",
							conditions =
							{

								{
									"693ecf25-8dcc-d9c4-a349-cb0153b91404",
									true,
								},
							},
							name = "Akh Afah HP advice",
							uuid = "168514d0-961c-30c8-a89f-1519bab16943",
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
							conditionLua = "local menu=data.frog_draw_settings\nif menu then return menu.settings.p6_akh_afah_hp==true end\nif not data.frog_afah_hp_settings then\n local settings={}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,saved=pcall(FileLoad,path)\n  if ok and type(saved)==\"table\" then settings=saved end\n end\n data.frog_afah_hp_settings=settings\nend\nreturn data.frog_afah_hp_settings.p6_akh_afah_hp==true",
							dequeueIfLuaFalse = true,
							name = "HP callout enabled",
							uuid = "693ecf25-8dcc-d9c4-a349-cb0153b91404",
							version = 3,
						},
					},
				},
				mechanicTime = 1323.7,
				name = "[Callout] Akh Afah HP 2",
				timelineIndex = 223,
				timerOffset = -13,
				uuid = "a5c4a381-5733-b0c7-b3d4-5c82148a4550",
				version = 2,
			},
		},
	},
	[232] =
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
							actionLua = "data.frog_war_wb2 = data.frog_war_wb2 or {}\nlocal s=data.frog_war_wb2\ns.nidhoggSpell=eventArgs.spellID\ns.nidhogg=eventArgs.spellID==27955\nself.used=true",
							conditions =
							{

								{
									"77ba191a-5e07-594c-923d-74d7c383046d",
									true,
								},

								{
									"8900ab43-dac1-c867-9590-60d88b049b90",
									true,
								},

								{
									"3d1e1148-05ba-3342-b80a-269f3264d856",
									true,
								},
							},
							name = "Capture nidhogg",
							uuid = "3d7ef5c0-8713-c4d2-ab44-7068b4d169b9",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "data.frog_war_wb2 = data.frog_war_wb2 or {}\nlocal s=data.frog_war_wb2\ns.hraesvelgrSpell=eventArgs.spellID\ns.hraesvelgr=eventArgs.spellID==27957\nself.used=true",
							conditions =
							{

								{
									"77ba191a-5e07-594c-923d-74d7c383046d",
									true,
								},

								{
									"8900ab43-dac1-c867-9590-60d88b049b90",
									true,
								},

								{
									"d8f48834-6cf8-189e-8da3-c890f714f5fc",
									true,
								},
							},
							name = "Capture hraesvelgr",
							uuid = "dcb39db8-72ec-8939-8744-5fb344cd2469",
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
							name = "Nidhogg 27954/27955",
							spellIDList =
							{
								27954,
								27955,
							},
							uuid = "3d1e1148-05ba-3342-b80a-269f3264d856",
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
							name = "Hraesvelgr 27956/27957",
							spellIDList =
							{
								27956,
								27957,
							},
							uuid = "d8f48834-6cf8-189e-8da3-c890f714f5fc",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "77ba191a-5e07-594c-923d-74d7c383046d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "8900ab43-dac1-c867-9590-60d88b049b90",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1355.7,
				name = "[Tank] Cast Capture",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = -0.1,
				timerStartOffset = -9,
				uuid = "25698f24-3485-aa92-bfb7-f69e7329b799",
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
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "SHARED",
							conditions =
							{

								{
									"55e596ea-dfc0-b5bd-be1e-cbea420d1f89",
									true,
								},

								{
									"eab46f8c-3289-7607-8ad1-92c3495f9f42",
									true,
								},

								{
									"29e90dc5-9819-b917-8ce5-d86d36a45bf7",
									true,
								},
							},
							endIfUsed = true,
							name = "SHARED",
							uuid = "3d26aec5-aca6-191d-bc89-b16894a95211",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "ON ME",
							conditions =
							{

								{
									"55e596ea-dfc0-b5bd-be1e-cbea420d1f89",
									true,
								},

								{
									"eab46f8c-3289-7607-8ad1-92c3495f9f42",
									true,
								},

								{
									"e6855cd7-0b2a-4f9c-8979-2ac0ba44430b",
									true,
								},
							},
							endIfUsed = true,
							name = "ON ME",
							uuid = "288a7109-af00-190c-9ccb-3968dac3b68c",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertPriority = 2,
							alertScale = 1.5,
							alertTTS = true,
							alertText = "ON OTHER TANK",
							conditions =
							{

								{
									"55e596ea-dfc0-b5bd-be1e-cbea420d1f89",
									true,
								},

								{
									"eab46f8c-3289-7607-8ad1-92c3495f9f42",
									true,
								},

								{
									"9a4b81c1-6445-d9fa-9e14-399f0516cce9",
									true,
								},
							},
							endIfUsed = true,
							name = "ON OTHER TANK",
							uuid = "c25261fc-69a5-2222-918c-869c98f02994",
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
							conditionLua = "local s=data.frog_war_wb2\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil and s.nidhogg==true and s.hraesvelgr==true",
							name = "SHARED",
							uuid = "29e90dc5-9819-b917-8ce5-d86d36a45bf7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nlocal r=tankRole()\nlocal s=data.frog_war_wb2\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil and ((r==\"T1\" and (s.nidhoggSpell==27954 and s.hraesvelgrSpell==27957)) or (r==\"T2\" and (s.nidhoggSpell==27955 and s.hraesvelgrSpell==27956)))",
							name = "ON ME",
							uuid = "e6855cd7-0b2a-4f9c-8979-2ac0ba44430b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nlocal r=tankRole()\nlocal s=data.frog_war_wb2\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil and ((r==\"T1\" and (s.nidhoggSpell==27955 and s.hraesvelgrSpell==27956)) or (r==\"T2\" and (s.nidhoggSpell==27954 and s.hraesvelgrSpell==27957)))",
							name = "ON OTHER TANK",
							uuid = "9a4b81c1-6445-d9fa-9e14-399f0516cce9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "55e596ea-dfc0-b5bd-be1e-cbea420d1f89",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "eab46f8c-3289-7607-8ad1-92c3495f9f42",
							version = 3,
						},
					},
				},
				mechanicTime = 1355.7,
				name = "[Tank] Buster Callout",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "d7368f12-8472-7449-bd77-599d7c41b95b",
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
							actionLua = "self.used=true\nlocal now=TensorReactions_CurrentTimer\nlocal s=data.frog_wb2_busters\nif not s or math.abs(now-s.at)>5 then s={at=now};data.frog_wb2_busters=s end\nif eventArgs.spellID==27954 or eventArgs.spellID==27955 then s.nidd=eventArgs.spellID\nelse s.hrae=eventArgs.spellID end",
							conditions =
							{

								{
									"830edf1c-2677-3934-88be-953e5663b117",
									true,
								},
							},
							name = "WB2 buster variant",
							uuid = "24497276-ac94-a014-a042-16ba50da4d7c",
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
							spellIDList =
							{
								27954,
								27955,
								27956,
								27957,
							},
							uuid = "830edf1c-2677-3934-88be-953e5663b117",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1355.7,
				name = "[Draw] WB2 buster capture",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 0.5,
				timerStartOffset = -15,
				uuid = "f1c1aad8-d778-2369-ad90-4ed672027d0a",
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
							actionLua = "self.used=true\nlocal now=TensorReactions_CurrentTimer\nlocal s=data.frog_wb2_tethers\nif not s or math.abs(now-s.at)>12 then s={at=now,colors={}};data.frog_wb2_tethers=s end\nif s.colors[eventArgs.sourceEntityID]~=eventArgs.newTargetContentID then\n s.colors[eventArgs.sourceEntityID]=eventArgs.newTargetContentID\n s.plan=nil\nend\n",
							conditions =
							{

								{
									"56cef1fd-366c-1c75-bc0b-3da972424f3d",
									true,
								},
							},
							name = "Capture Nidhogg tether",
							uuid = "0cdeb8fe-820d-bac4-937a-c364f7e884eb",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "self.used=true\nlocal now=TensorReactions_CurrentTimer\nlocal s=data.frog_wb2_tethers\nif not s or math.abs(now-s.at)>12 then s={at=now,colors={}};data.frog_wb2_tethers=s end\nif s.colors[eventArgs.sourceEntityID]~=eventArgs.newTargetContentID then\n s.colors[eventArgs.sourceEntityID]=eventArgs.newTargetContentID\n s.plan=nil\nend\n",
							conditions =
							{

								{
									"f754ca29-3e42-0742-84a7-af7a3a17e259",
									true,
								},
							},
							name = "Capture Hraesvelgr tether",
							uuid = "792da29a-edf4-a4ea-9039-a632c47eafeb",
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
							eventArgType = 7,
							eventTargetContentID = 3458,
							uuid = "56cef1fd-366c-1c75-bc0b-3da972424f3d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgOptionType = 2,
							eventArgType = 7,
							eventTargetContentID = 4954,
							uuid = "f754ca29-3e42-0742-84a7-af7a3a17e259",
							version = 3,
						},
					},
				},
				eventType = 15,
				loop = true,
				mechanicTime = 1355.7,
				name = "[Draw] WB2 tether capture",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = 1,
				timerStartOffset = -15,
				uuid = "ebf7b497-eebb-d3e3-9334-3a06c5ece0f3",
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
							actionLua = "if data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\n\nself.used=true\nlocal s=data.frog_wb2_v1\nif not s then\n s={slots={},roleKeys={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"},\n spots={MT={85.25,87.75},OT={115.28,110.83},H1={99.87,80.74},H2={99.96,119.40},\n M1={96.85,110.37},M2={103.93,89.59},R1={93.25,118.12},R2={106.80,81.32}}}\n function s.clear()\n  if s.line then Argus.deleteTimedShape(s.line); s.line=nil end\n  if s.ring then Argus.deleteTimedShape(s.ring); s.ring=nil end\n  if s.dot then Argus.deleteTimedShape(s.dot); s.dot=nil end\n end\n data.frog_wb2_v1=s\nend\nif not s.frameMode then s.clear(); s.frameMode=true end\nlocal mode=frogGuide.mode(\"p6_wb2\")\nlocal player=TensorCore.mGetPlayer()\nlocal remaining=(1356.5-TensorReactions_CurrentTimer)*1000\nif mode==\"Disabled\" or not player or player.hp.current<=0 or remaining<=0 then s.clear(); return end\nif s.playerID~=player.id then\n s.clear(); s.spot=nil; s.playerID=player.id\nend\nlocal menu=data.frog_draw_settings\nlocal r1North=menu and menu.wb2R1North or (not menu and frogGuide.settings.p6_wb2_r1_north==true)\nlocal orderText=menu and menu.settings.p6_wb2_order or (not menu and frogGuide.settings.p6_wb2_order)\nif s.orderText~=orderText then\n s.orderText=orderText;s.spot=nil;s.slotByRole=nil\n local roles,seen={},{}\n local allowed={H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n local valid=type(orderText)==\"string\"\n if valid then\n  for role in orderText:gmatch(\"%S+\")do\n   if not allowed[role] or seen[role] then valid=false;break end\n   seen[role]=true;roles[#roles+1]=role\n  end\n end\n if valid and #roles==6 then\n  local fixed={\"H1\",\"R1\",\"M1\",\"M2\",\"H2\",\"R2\"};s.slotByRole={}\n  for i,role in ipairs(roles)do s.slotByRole[role]=fixed[i]end\n end\nend\nif s.r1North~=r1North then s.spot=nil;s.r1North=r1North end\nif not s.spot then\n local now=Now()\n if s.nextRoster and now<s.nextRoster then return end\n s.nextRoster=now+500\n local members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nif type(members)~=\"table\" or type(party)~=\"table\" then return end\nlocal byNameJob,byJob,partyCount,rosterCount={},{},{},{}\nfor _,actor in pairs(party) do\n if actor and actor.id and actor.job and actor.name then\n  byNameJob[tostring(actor.name)..\"\\31\"..tostring(actor.job)]=actor\n  byJob[actor.job]=actor\n  partyCount[actor.job]=(partyCount[actor.job] or 0)+1\n end\nend\nfor _,member in pairs(members) do\n if member and member.job then rosterCount[member.job]=(rosterCount[member.job] or 0)+1 end\nend\nlocal used={}\nfor role,key in pairs(s.roleKeys) do\n local member=members[key]\n if not member or not member.name or not member.job then return end\n local actor=byNameJob[tostring(member.name)..\"\\31\"..tostring(member.job)]\n if not actor and partyCount[member.job]==1 and rosterCount[member.job]==1 then actor=byJob[member.job] end\n if not actor or used[actor.id] then return end\n s.slots[role]=actor.id\n used[actor.id]=true\nend\n\n for role,id in pairs(s.slots) do\n  if id==player.id then s.role=role;local spotRole=role;if s.slotByRole and s.slotByRole[role] then spotRole=s.slotByRole[role] elseif s.r1North and role==\"R1\" then spotRole=\"R2\" elseif s.r1North and role==\"R2\" then spotRole=\"R1\" end;s.spot=s.spots[spotRole]; break end\n end\n if not s.spot then return end\nend\nlocal strategy=menu and menu.settings.p6_wb2_strategy or frogGuide.settings.p6_wb2_strategy\nlocal x,z=s.spot[1],s.spot[2]\nif strategy==\"5-1\" and s.role~=\"MT\" and s.role~=\"OT\" then\n local t=data.frog_wb2_tethers\n if not t then return end\n if not t.plan then\n  local colors={}\n  for _,role in ipairs({\"H1\",\"H2\",\"M1\",\"R1\",\"R2\",\"M2\"}) do colors[role]=t.colors[s.slots[role]] end\nlocal function assign(colors)\n local counts={[3458]=0,[4954]=0}\n for _,role in ipairs({\"H1\",\"H2\",\"M1\",\"R1\",\"R2\",\"M2\"}) do\n  local cid=colors[role]\n  if not counts[cid] then return end\n  counts[cid]=counts[cid]+1\n end\n if counts[3458]~=3 or counts[4954]~=3 then return end\n local healerSlot=3\n if colors.H1==colors.H2 then healerSlot=colors.H2==3458 and 4 or 2 end\n local available={}\n for i=1,5 do if i~=healerSlot then available[#available+1]=i end end\n local roles={\"M1\",\"R1\",\"R2\",\"M2\"}\n local defaults={M1=1,R1=2,R2=4,M2=5}\n local best,bestScore\n local chosen,used={},{}\n local function visit(index,score)\n  if index==5 then\n   if not bestScore or score<bestScore then\n    bestScore=score;best={H1=6,H2=healerSlot}\n    for role,slot in pairs(chosen) do best[role]=slot end\n   end\n   return\n  end\n  local role=roles[index]\n  for _,slot in ipairs(available) do\n   local legal=slot==3 or (slot<3 and colors[role]==4954) or (slot>3 and colors[role]==3458)\n   if not used[slot] and legal then\n    local melee=role==\"M1\" or role==\"M2\"\n    local outer=slot==1 or slot==5\n    local cost=math.abs(slot-defaults[role])+(melee~=outer and 20 or 0)\n    used[slot]=true;chosen[role]=slot\n    visit(index+1,score+cost)\n    used[slot]=nil;chosen[role]=nil\n   end\n  end\n end\n visit(1,0)\n return best\nend\n\n  t.plan=assign(colors)\n end\n if not t.plan then return end\n local slot=t.plan[s.role]\n if slot and slot<=5 then\n  local theta=math.rad(-45+(slot-1)*22.5)\n  x,z=100+19.1*math.sin(theta),100-19.1*math.cos(theta)\n elseif s.role==\"H1\" then\n  local b=data.frog_wb2_busters\n  if not b or not b.nidd or not b.hrae then return end\n  local ax,ay,az,active=Argus.getWaymarkInfo(5)\n  x,z=active and ax or 100,active and az or 119.5\n  local marker\n  if b.nidd==27954 and b.hrae==27957 then marker=4\n  elseif b.nidd==27955 and b.hrae==27956 then marker=6\n  elseif not (b.nidd==27955 and b.hrae==27957) then return end\n  if marker then\n   local tx,ty,tz,on=Argus.getWaymarkInfo(marker)\n   if not on then return end\n   local dx,dz=tx-x,tz-z\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length>0 then x,z=x+2*dx/length,z+2*dz/length end\n  end\n end\nend\nlocal flags=frogGuide.flags\nlocal ring=TensorCore.getCachedDrawer(0x00FF6626,0x00FF6626,0x00FF6626,0xFFFF6626,2,0,flags)\nring:addCircle(x,0.05,z,0.6,false,flags)\nlocal drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,flags)\ndrawer:addCircle(x,0.06,z,0.15,false,flags)\nlocal dx,dz=x-player.pos.x,z-player.pos.z\nif dx*dx+dz*dz<=1 then return end\nfrogGuide.draw(\"p6_wb2\",drawer,player.pos.x,player.pos.y,player.pos.z,x,0.05,z,8,2)\n",
							name = "Personal fixed spot and proximity guidance",
							uuid = "6b0e76b6-f527-49d8-bf15-7735b6a37364",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1356.5,
				name = "[Draw] Wyrmsbreath 2 Fixed Spots",
				timeRange = true,
				timelineIndex = 233,
				timerStartOffset = -8,
				uuid = "df791e7b-33bc-51ba-a11d-855883a34444",
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
							actionLua = "local player=TensorCore.mGetPlayer()\nlocal boiling=TensorCore.getBuff(player,2898)\nlocal pyretic=TensorCore.getBuff(player,960)\ndata.frog_wb2_hold={expires=Now()+(boiling and boiling.duration or 0)*1000,sawPyretic=pyretic~=nil}\nself.used=true",
							conditions =
							{

								{
									"3b470fca-b0bb-8099-ba21-5ed9116a86fd",
									true,
								},
							},
							name = "Capture Boiling transition",
							uuid = "491ca33f-0e05-6a62-90ca-cce12b09f77c",
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
									"b473ff67-cfe9-b640-8631-5a4059f3d003",
									true,
								},
							},
							name = "Stop All Actions",
							stopAllActions = true,
							uuid = "5c91c650-d4ab-5f9f-a9a0-519bb6ff00ab",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "local model=data.dsrBrdAutoSim\nif model and model.phase==\"p6\" then\n model.wb2ActualStopAt=TensorCore.API.TensorACR.getAutoSimTime()\n model.rebuildPersonalStop()\nend\nself.used=true",
							conditions =
							{

								{
									"540278bc-84a0-6f1d-ab0a-af54ca50ddb6",
									true,
								},
							},
							name = "Record AutoSim stop start",
							uuid = "eaf9229e-88b9-b6ed-a497-c57431daef24",
							version = 2.1,
						},
						inheritedIndex = 3,
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "data.frog_wb2_hold.sawPyretic=true\nself.used=true",
							conditions =
							{

								{
									"540278bc-84a0-6f1d-ab0a-af54ca50ddb6",
									true,
								},

								{
									"382e42e3-c30f-66d1-a28d-2d258df6fe25",
									true,
								},
							},
							name = "Observe Pyretic",
							uuid = "e2497d6e-f63f-e86c-9612-204dd464ed5d",
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
									"540278bc-84a0-6f1d-ab0a-af54ca50ddb6",
									true,
								},

								{
									"c07995c8-9a52-5e98-b92c-c426d13bff97",
									true,
								},
							},
							endIfUsed = true,
							name = "Resume All Actions",
							resumeAllActions = true,
							uuid = "113d0379-4e32-1fd9-9b86-2e7c3e72e1ed",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							buffCheckType = 3,
							buffDuration = 2,
							buffID = 2898,
							category = "Self",
							comparator = 2,
							name = "Boiling <=2s",
							uuid = "4703b73d-0ebe-000f-9005-e2c337c451be",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 960,
							category = "Self",
							name = "Pyretic active",
							uuid = "382e42e3-c30f-66d1-a28d-2d258df6fe25",
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
									"4703b73d-0ebe-000f-9005-e2c337c451be",
									true,
								},

								{
									"382e42e3-c30f-66d1-a28d-2d258df6fe25",
									true,
								},
							},
							matchAnyBuff = true,
							name = "Boiling soon or Pyretic",
							partyTargetNumber = 0,
							uuid = "3b470fca-b0bb-8099-ba21-5ed9116a86fd",
							version = 3,
						},
					},

					{
						data =
						{
							actionUUID = "491ca33f-0e05-6a62-90ca-cce12b09f77c",
							category = "Action",
							name = "Hold armed",
							uuid = "b473ff67-cfe9-b640-8631-5a4059f3d003",
							version = 3,
						},
					},

					{
						data =
						{
							actionUUID = "5c91c650-d4ab-5f9f-a9a0-519bb6ff00ab",
							category = "Action",
							name = "Stop issued",
							uuid = "540278bc-84a0-6f1d-ab0a-af54ca50ddb6",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_wb2_hold\nreturn s~=nil and s.hitHrae==true",
							name = "Hit by Hraesvelgr Cauterize",
							uuid = "c07995c8-9a52-5e98-b92c-c426d13bff97",
							version = 3,
						},
					},
				},
				mechanicTime = 1356.5,
				name = "[Opti] Wyrmsbreath 2 Pyretic Hold",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = 45.200000762939,
				uuid = "bdd90e87-11a0-0dab-ae66-0d6e513e0267",
				version = 2,
			},
		},
	},
	[234] =
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
							actionLua = "self.used=true\nlocal cid=eventArgs.entityContentID\nif not ((cid==3458 and eventArgs.spellID==27966) or (cid==4954 and eventArgs.spellID==27967)) then return end\nlocal boss=TensorCore.mGetEntity(eventArgs.entityID)\nlocal player=TensorCore.mGetPlayer()\nif not boss or not player or boss.pos.z>=80 then return end\nlocal s=data.frog_p6_cauterize\nif s and s.hit then s=nil end\nif not s then\n s={dragons={},settings={}}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then s.settings=settings end\n end\n data.frog_p6_cauterize=s\nend\n\ns.dragons[cid]={x=boss.pos.x,y=boss.pos.y,z=boss.pos.z,radius=boss.hitradius}\nif TensorCore.getBuff(player,2898) or TensorCore.getBuff(player,960) then s.element=\"Fire\"\nelseif TensorCore.getBuff(player,2899) then s.element=\"Ice\" end\nlocal wb=data.frog_wb2_v1\nif wb and wb.playerID==player.id then s.role=wb.role end\nif not s.role then\n local members=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if type(members)~=\"table\" or type(party)~=\"table\" then return end\n local keys={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}\n for role,key in pairs(keys) do\n  local member=members[key]\n  if member and member.name and member.job then\n   local match,count=nil,0\n   for _,actor in pairs(party) do\n    if actor.job==member.job and actor.name==member.name then match=actor; count=count+1 end\n   end\n   \n   if count==0 then\n    local rosterCount=0\n    for _,other in pairs(members) do if other.job==member.job then rosterCount=rosterCount+1 end end\n    if rosterCount==1 then\n     for _,actor in pairs(party) do\n      if actor.job==member.job then match=actor; count=count+1 end\n     end\n    end\n   end\n   if count==1 and match.id==player.id then s.role=role; break end\n  end\n end\nend\n",
							name = "Double Cauterize Capture",
							uuid = "6cdf2383-12d3-4f0e-9ee9-239f4510638c",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1369,
				name = "[Draw] Double Cauterize Capture",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 2,
				timerStartOffset = -8,
				uuid = "87df69e5-6e9b-1f30-9ade-fdd37deb1974",
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
							actionLua = "self.used=true\nlocal s=data.frog_p6_cauterize\nif not s or s.hit then return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.hp.current<=0 then return end\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings or s.settings\nlocal styles=settings.draw_styles\nlocal mode=styles and styles.p6_cauterize or \"Tether\"\nif mode==\"Disabled\" then return end\nlocal n,h=s.dragons[3458],s.dragons[4954]\nif not n or not h then return end\nlocal dragon\nlocal tank=s.role==\"MT\" or s.role==\"OT\"\nif tank then\n local assignment=settings.p6_cauterize_mt or \"Nidhogg\"\n if assignment==\"Hraesvelgr\" then dragon=h\n elseif assignment==\"Fixed West\" then dragon=n.x<h.x and n or h\n elseif assignment==\"Fixed East\" then dragon=n.x>h.x and n or h\n else dragon=n end\n if s.role==\"OT\" then dragon=dragon==n and h or n end\nelseif s.element==\"Fire\" then dragon=h\nelseif s.element==\"Ice\" then dragon=n\nelse return end\n\n\nlocal opposite=dragon==n and h or n\nlocal channel=Argus2.getNextUnusedChannel(true)\nif channel then\n local left=math.max(79,dragon.x-11)\n local right=math.min(121,dragon.x+11)\n local flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\n if right>left then\n  Argus.addRectFilled((left+right)/2,0.05,79,42,right-left,0,\n   0x9900FF00,0xCC00FF00,1,false,1.5,0.5,2,false,\n   flags+Argus2.RenderFlags.FLAG_OCCLUSION_BASE,channel)\n  Argus.addRectFilled(opposite.x,0.05,opposite.z,80,22,0,\n   0xFFFFFFFF,nil,nil,true,0,1,0,false,\n   flags+Argus2.RenderFlags.FLAG_OCCLUDE,channel)\n end\nend\nlocal x,z\nif tank then\n \n x,z=dragon.x,80.5\nelse\n if not dragon.radius or dragon.radius<=0 then return end\n \n x,z=dragon.x,dragon.z+dragon.radius\nend\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nif not s.drawer then s.drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,flags) end\ns.drawer:addCircle(x,0.06,z,0.3,false,flags)\nlocal p=player.pos\nlocal dx,dz=x-p.x,z-p.z\nlocal length=math.sqrt(dx*dx+dz*dz)\nif length<=0.6 then return end\nif mode==\"Arrow\" then\n local tip=math.min(2,length*0.35)\n s.drawer:addArrow(p.x,p.y+0.08,p.z,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,flags)\nelse\n s.drawer:addLine(p.x,p.y,p.z,x,0.06,z,8,2)\nend\n",
							name = "Double Cauterize Guidance",
							uuid = "6d993d90-8f1f-13e0-933d-65a9f87cd211",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1369,
				name = "[Draw] Double Cauterize Guidance",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 2,
				timerStartOffset = -8,
				uuid = "5abcd529-7fc3-8f73-9f06-1fbb25c713ca",
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
							actionLua = "self.used=true\nlocal cid=eventArgs.entityContentID\nif not ((cid==3458 and eventArgs.spellID==27966) or (cid==4954 and eventArgs.spellID==27967)) then return end\nlocal player=TensorCore.mGetPlayer()\nif not player then return end\nfor _,id in ipairs(eventArgs.hitTargets) do\n if id==player.id then\n  local s=data.frog_p6_cauterize\n  if s then s.hit=true end\n  local hold=data.frog_wb2_hold\n  if cid==4954 and hold then hold.hitHrae=true end\n  return\n end\nend\n",
							name = "Double Cauterize Hit Tracking",
							uuid = "f5df93b6-d37b-626d-98a2-5d018660c3b8",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1369,
				name = "[Opti] Double Cauterize Hit Tracking",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = 3,
				timerStartOffset = -8,
				uuid = "5064c709-5e23-26d6-b0eb-eb0fe95e9753",
				version = 2,
			},
		},
	},
	[243] =
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
							actionLua = "if eventArgs.entityContentID~=11319 then self.used=true return end\nlocal aura=eventArgs.newActiveAura1\nif aura~=1119 and aura~=1120 then self.used=true return end\nif eventArgs.oldActiveAura1==aura then self.used=true return end\ndata.frog_p7_element=data.frog_p7_element or {}\nlocal s=data.frog_p7_element\nif s.draw then Argus.deleteTimedShape(s.draw); s.draw=nil end\ns.bossID=eventArgs.entityID\ns.element=aura==1120 and \"ice\" or \"fire\"\n\nlocal menu=data.frog_draw_settings\nif not menu and not s.settings then\n s.settings={}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then s.settings=settings end\n end\nend\nlocal settings=menu and menu.settings or s.settings\nif settings and settings.p7_element_draws==false then self.used=true return end\nlocal flags=Argus2.RenderFlags.FLAG_WARP_TERRAIN\nlocal color=GUI:ColorConvertFloat4ToU32(1,0,0,0.9)\nlocal outline=GUI:ColorConvertFloat4ToU32(1,0,0,1)\nlocal drawer=TensorCore.getCachedDrawer(color,nil,color,outline,3.5,0,flags)\ndrawer.gradientDistance=1.5\ndrawer.gradientMinOpacity=0.5\ndrawer.gradientIntensity=2\nif aura==1120 then\n s.draw=drawer:addTimedDonutOnEnt(12000,s.bossID,8,50,0,false,false,flags)\nelse\n s.draw=drawer:addTimedCircleOnEnt(12000,s.bossID,8,0,false,false,flags)\nend\nself.used=true",
							name = "P7 Fire Ice Telegraph",
							uuid = "77197fac-bfd1-5e27-8f74-f25535e17933",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 25,
				loop = true,
				mechanicTime = 1542.1,
				name = "[Draw] P7 Fire Ice Telegraph",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "588a5d0c-7ffb-684c-928e-7318d0f5a1b4",
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
							actionLua = "if eventArgs.entityContentID==11319 and (eventArgs.spellID==28049 or eventArgs.spellID==28050) then\n local s=data.frog_p7_element\n if s then\n  if s.draw then Argus.deleteTimedShape(s.draw); s.draw=nil end\n  s.element=nil\n end\nend\nself.used=true",
							name = "P7 Fire Ice Resolution",
							uuid = "bbd65037-fe25-85f1-aab4-4a46acceabee",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1542.1,
				name = "[Draw] P7 Fire Ice Resolution",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "58eaf718-4d20-ba31-ab09-331d56058692",
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
							actionLua = "if not data.frog_p7_guidance then\n local s={\n  roles={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"},\n  order={\"M1\",\"M2\",\"R1\",\"R2\",\"H1\",\"H2\"},\n  times={1561.2,1565.3,1585.8,1589.9,1619,1623.1,1640.2,1644.3,1665.9,1670,1699.1,1703.2,1720.2,1724.3},\n  slots={},byID={},byNameJob={},byJob={},partyCount={},rosterCount={},used={},\n  settings={},resolved=0,flags=Argus2.RenderFlags.FLAG_RENDER_OVERLAY+Argus2.RenderFlags.FLAG_WARP_TERRAIN\n }\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then s.settings=settings end\n end\n function s.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or s.settings\n  local styles=settings and settings.draw_styles\n  local mode=styles and styles[key]\n  if mode==\"Arrow\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function s.autoMode()\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or s.settings\n  local mode=settings and settings.p7_auto_mode\n  if mode==\"Shotcaller\" or mode==\"Disabled\" then return mode end\n  return \"Personal\"\n end\n function s.clear()\n  if s.draw then Argus.deleteTimedShape(s.draw); s.draw=nil end\n  s.drawMode=nil\n end\n function s.drawTo(player,key,x,y,z)\n  local mode=s.mode(key)\n  if mode==\"Disabled\" then s.clear(); return end\n  local p=player.pos\n  local dx,dz=x-p.x,z-p.z\n  local length=math.sqrt(dx*dx+dz*dz)\n  if length<0.2 then s.clear(); return end\n  if s.drawMode~=mode then s.clear() end\n  s.drawMode=mode\n  if mode==\"Arrow\" then\n   if not s.arrow then s.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,s.flags) end\n   local tip=math.min(2,length*0.35)\n   local heading=math.atan2(dx,dz)\n   s.arrow:addArrow(p.x,p.y+0.08,p.z,heading,length-tip,0.75,tip,1.5,false,s.flags)\n  else\n   if not s.line then s.line=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0) end\n   s.line:addLine(p.x,p.y,p.z,x,y,z,8,2)\n  end\n end\n function s.nearestAuto(t)\n  local best,delta\n  for i,at in ipairs(s.times) do\n   local d=math.abs(t-at)\n   if not delta or d<delta then best,delta=i,d end\n  end\n  if delta and delta<2 then return best end\n end\n data.frog_p7_guidance=s\nend\nlocal s=data.frog_p7_guidance\nif s.akhStrategyVersion~=1 then\n function s.tower(role,n)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or s.settings\n  if settings.p7_akh_strategy==\"3-3-2\" or n==1 then\n   if role==\"MT\" or role==\"OT\" then return 29454 end\n   if role==\"H1\" or role==\"M1\" or role==\"R1\" then return 29453 end\n   return 29452\n  end\n  if role~=\"MT\" and role~=\"OT\" then return 29453 end\n  if not s.warRole then return end\n  if n==2 then return role==s.warRole and 29454 or 29452 end\n  return role==s.warRole and 29452 or 29454\n end\n s.akhStrategyVersion=1\nend\nif s.ready then self.used=true return end\nlocal t=TensorReactions_CurrentTimer\nif s.nextRoster and t<s.nextRoster then return end\ns.nextRoster=t+1\nlocal members=AnyoneCore.Roster.members()\nlocal party=AnyoneCore.API.getAgnosticPartyList()\nif type(members)~=\"table\" or type(party)~=\"table\" then return end\nfor k in pairs(s.byNameJob) do s.byNameJob[k]=nil end\nfor k in pairs(s.byJob) do s.byJob[k]=nil end\nfor k in pairs(s.partyCount) do s.partyCount[k]=nil end\nfor k in pairs(s.rosterCount) do s.rosterCount[k]=nil end\nfor k in pairs(s.used) do s.used[k]=nil end\nfor _,actor in pairs(party) do\n if actor and actor.id and actor.job and actor.name then\n  s.byNameJob[tostring(actor.name)..\"\\31\"..tostring(actor.job)]=actor\n  s.byJob[actor.job]=actor\n  s.partyCount[actor.job]=(s.partyCount[actor.job] or 0)+1\n end\nend\nfor _,member in pairs(members) do\n if member and member.job then s.rosterCount[member.job]=(s.rosterCount[member.job] or 0)+1 end\nend\nfor role,key in pairs(s.roles) do\n local member=members[key]\n if not member or not member.name or not member.job then return end\n local actor=s.byNameJob[tostring(member.name)..\"\\31\"..tostring(member.job)]\n if not actor and s.partyCount[member.job]==1 and s.rosterCount[member.job]==1 then actor=s.byJob[member.job] end\n if not actor or s.used[actor.id] then return end\n s.slots[role]=actor.id; s.used[actor.id]=true\nend\nfor role,id in pairs(s.slots) do\n s.byID[id]=role\n local actor=TensorCore.mGetEntity(id)\n if (role==\"MT\" or role==\"OT\") and actor and actor.job==21 then s.warRole=role end\nend\ns.ready=true\nself.used=true",
							name = "P7 Role Setup",
							uuid = "2ac20662-9b81-c9d4-9a86-92b2c7b122ed",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1542.1,
				name = "[Draw] P7 Role Setup",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "d404a5bc-972e-dc82-b369-707d02a2f410",
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
							actionLua = "local s=data.frog_p7_guidance\nif not s or eventArgs.entityContentID~=11319 then self.used=true return end\nlocal id=eventArgs.spellID\nlocal t=TensorReactions_CurrentTimer\nif id==28051 or id==28057 or id==28059 then s.bossID=eventArgs.entityID end\nif id==29452 or id==29453 or id==29454 then\n local n=t<1610 and 1 or t<1690 and 2 or 3\n if not s.akh or s.akh.n~=n then s.akh={n=n,towers={},expires=t+20} end\n local entity=TensorCore.mGetEntity(eventArgs.entityID)\n if entity then\n  local p=entity.pos\n  s.akh.towers[id]={x=p.x,y=p.y,z=p.z}\n end\nelseif id==28058 or id==28114 or id==28115 then\n local n=t<1640 and 1 or 2\n if not s.giga or s.giga.n~=n then s.giga={n=n,spots={},step=1,expires=t+19} end\n local entity=TensorCore.mGetEntity(eventArgs.entityID)\n if entity then\n  local p=entity.pos\n  local index=id==28058 and 1 or id==28114 and 2 or 3\n  s.giga.spots[index]={x=p.x,y=p.y,z=p.z}\n end\nend\nself.used=true",
							name = "P7 Tower and Flare Capture",
							uuid = "5a29233b-dcc9-53c0-8e5b-c4bc6e9ae0b9",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1542.1,
				name = "[Draw] P7 Tower and Flare Capture",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "d9da5c3b-3609-9d19-802a-f96e73cb9c29",
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
							actionLua = "local s=data.frog_p7_guidance\nif not s or eventArgs.entityContentID~=11319 then self.used=true return end\nlocal id=eventArgs.spellID\nlocal t=TensorReactions_CurrentTimer\nif id==28062 then\n s.bossID=eventArgs.entityID\nelseif id==28065 then\n local i=s.nearestAuto(t)\n if i then\n  s.resolved=math.max(s.resolved,i)\n  if s.activeAuto==i then s.clear(); s.activeAuto=nil end\n end\nelseif id==28053 then\n if s.akh then s.akh.lastPending=true end\nelseif id==28054 or id==28055 then\n if s.akh and s.akh.lastPending then s.akh=nil; s.clear() end\nelseif id==28058 then\n if s.giga then s.giga.step=2 end\nelseif id==28114 then\n if s.giga then s.giga.step=3 end\nelseif id==28115 then\n if s.giga then s.giga=nil; s.clear() end\nend\nself.used=true",
							name = "P7 Mechanic Progress",
							uuid = "eba8d740-5540-f819-8af9-e3180e9000c7",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 2,
				loop = true,
				mechanicTime = 1542.1,
				name = "[Draw] P7 Mechanic Progress",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "5a3885b5-14f8-562c-b113-f1d5e3fababb",
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
							actionLua = "local s=data.frog_p7_guidance\nif not s then self.used=true return end\nlocal t=TensorReactions_CurrentTimer\nif s.lastTime and t<s.lastTime-2 then\n s.clear(); s.akh=nil; s.giga=nil; s.resolved=0; s.warned=nil; s.moved=nil; s.activeAuto=nil\nend\ns.lastTime=t\nlocal player=TensorCore.mGetPlayer()\nlocal element=data.frog_p7_element\nlocal bossID=s.bossID or (element and element.bossID)\nlocal boss=bossID and TensorCore.mGetEntity(bossID)\nif not s.ready or not player or not player.alive or not boss or not boss.alive then s.clear(); self.used=true return end\nlocal role=s.byID[player.id]\nlocal bp=boss.pos\nlocal key,x,y,z\nlocal menu=data.frog_draw_settings\nlocal settings=menu and menu.settings or s.settings\nlocal storedMode=settings and settings.p7_auto_mode\nlocal autoMode=storedMode==\"Shotcaller\" and \"Shotcaller\" or storedMode==\"Disabled\" and \"Disabled\" or \"Personal\"\n\nlocal storedOrder=settings and settings.p7_auto_order or \"M R H\"\nif s.autoOrderSource~=storedOrder then\n local compact=type(storedOrder)==\"string\" and string.upper(storedOrder):gsub(\"[%s,]\",\"\") or \"\"\n local order,seen={},{}\n local valid=#compact==3\n for token in compact:gmatch(\".\") do\n  if (token~=\"M\" and token~=\"R\" and token~=\"H\") or seen[token] then valid=false; break end\n  seen[token]=true; order[#order+1]=token..\"1\"; order[#order+1]=token..\"2\"\n end\n s.order=valid and order or {\"M1\",\"M2\",\"R1\",\"R2\",\"H1\",\"H2\"}\n s.autoOrderSource=storedOrder\nend\n\nfor i,at in ipairs(s.times) do\n if i>s.resolved and t>=at-6 and t<=at+1 then\n  local autoRole=s.order[(i-1)%6+1]\n  local personal=role==autoRole\n  local callEnabled=autoMode==\"Shotcaller\" or autoMode==\"Personal\" and personal\n  if callEnabled and s.warned~=i then\n   local text=autoMode==\"Shotcaller\" and autoRole..\" auto\" or \"Take next auto\"\n   TensorCore.addAlertText(3500,text,1.5,2,true,75); s.warned=i\n  end\n  if personal and autoMode~=\"Disabled\" and t>=at-2.2 then\n   if autoMode==\"Personal\" and s.moved~=i then\n    TensorCore.addAlertText(2200,\"Move in\",1.5,2,true,75); s.moved=i\n   end\n   s.activeAuto=i\n   key,x,y,z=\"p7_trinity\",bp.x,bp.y,bp.z\n  end\n  break\n end\nend\nif not role then s.clear(); self.used=true return end\nlocal elementName=element and element.element\n\n\nif elementName then\n local buff=TensorCore.getBuff(boss,2056)\n if buff and buff.stacks==299 then elementName=\"ice\"\n elseif buff and buff.stacks==298 then elementName=\"fire\" end\nend\nif not key and s.akh and t<s.akh.expires and (elementName or s.akh.elementKnown) then\n s.akh.elementKnown=true\n local towerID=s.tower(role,s.akh.n)\n local tower=towerID and s.akh.towers[towerID]\n if tower then\n  local dx,dz=tower.x-bp.x,tower.z-bp.z\n  local length=math.sqrt(dx*dx+dz*dz)\n  if length>0.1 then\n   local radius=elementName==\"fire\" and 9 or elementName==\"ice\" and 7 or length\n   key,x,y,z=\"p7_akh\",bp.x+dx/length*radius,tower.y,bp.z+dz/length*radius\n  end\n end\nelseif not key and s.giga and t<s.giga.expires and (elementName or s.giga.elementKnown) then\n s.giga.elementKnown=true\n local spot=s.giga.spots[s.giga.step]\n if spot then\n  local dx,dz=bp.x-spot.x,bp.z-spot.z\n  local length=math.sqrt(dx*dx+dz*dz)\n  if length>0.1 then\n   local meleeRadius=boss.hitradius+3.5\n   local radius=elementName==\"ice\" and math.min(7,meleeRadius) or meleeRadius\n   key,x,y,z=\"p7_giga\",bp.x+dx/length*radius,bp.y,bp.z+dz/length*radius\n  end\n end\nend\nif key then s.drawTo(player,key,x,y,z) else s.clear() end\nself.used=true",
							name = "P7 Personal Guidance",
							uuid = "d418bbe1-e588-6c68-a7fb-b5773ca6a74a",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 12,
				loop = true,
				mechanicTime = 1542.1,
				name = "[Draw] P7 Personal Guidance",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 210,
				timerStartOffset = -5,
				uuid = "36b39445-1b58-5601-9cf0-58dc33461b9e",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "b0039054-0676-5b76-9d34-dacc88b49437",
			},
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "Local fixes",
				name = "Monk downtime",
				uuid = "33515d2f-db8e-0323-a1e3-aad84580fd85",
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
							actionLua = "local s=data.frog_mnk_downtime\nif not s then self.used=true return end\nif Now()>(s.pbUntil or 0) then s.remaining=0 end\nif Now()>(s.chakraUntil or 0) then s.chakra=0 end\ns.prep={key=\"P7 transition Blitz preparation\",start=Now(),solar=not s.solar,blitz=(s.solar and s.lunar) and 25769 or ((not s.solar) and 25768 or 3545)}\nself.used=true",
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"4d1ed524-e359-9c16-8235-b3c5db9ff513",
									true,
								},

								{
									"8a9ca9fe-c5c7-65db-98f9-0e0a31b85676",
									true,
								},
							},
							name = "Choose missing Nadi once",
							uuid = "ea3f884f-aee7-2581-b1af-378f9d9323da",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 69,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"c40a64af-7756-8712-be24-2a7997974e8d",
									true,
								},

								{
									"8a9ca9fe-c5c7-65db-98f9-0e0a31b85676",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "81fc5cb6-75be-c983-92c9-c13a039b713c",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"ef00b399-5cae-c2c1-b080-ba382339414e",
									true,
								},
							},
							uuid = "3978c1cd-d9f2-3cd9-a024-2b214267c42c",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 16473,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"35f0cb76-2f6f-f21a-8c0d-1fa86a1ca97c",
									true,
								},

								{
									"48027bdd-2c2e-0340-a5ff-64f3b6fdc121",
									true,
								},
							},
							uuid = "f36a3478-20f4-92c2-a75f-cd73c1b202d2",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"35f0cb76-2f6f-f21a-8c0d-1fa86a1ca97c",
									true,
								},

								{
									"caaf041d-84bf-358e-accd-6d048c77de94",
									true,
								},
							},
							uuid = "10d89634-297a-fc60-bf0b-330c2ffc55df",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 70,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"48c33ee3-21d0-4a90-9f72-f420ee505ab9",
									true,
								},

								{
									"48027bdd-2c2e-0340-a5ff-64f3b6fdc121",
									true,
								},
							},
							uuid = "914d8268-8e66-85b0-9c05-0bbc5b4681ea",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25767,
							conditions =
							{

								{
									"fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
									true,
								},

								{
									"f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
									true,
								},

								{
									"e6f007b7-8da1-8e61-a872-7912408ac2bf",
									true,
								},

								{
									"4613c2d8-c5ef-c31f-ae22-534a89f7203d",
									true,
								},

								{
									"48c33ee3-21d0-4a90-9f72-f420ee505ab9",
									true,
								},

								{
									"caaf041d-84bf-358e-accd-6d048c77de94",
									true,
								},
							},
							uuid = "40452d3d-ff74-58c7-9490-c727d04fcf69",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "fa687da8-b60e-5e8f-9ab6-6156a7b9f31d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "f2cc40a3-a3b7-085e-9c2e-e3394cb91f64",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "e6f007b7-8da1-8e61-a872-7912408ac2bf",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn not t or not t.targetable or not t.attackable or t.hp.current<=0",
							name = "No attackable current target",
							uuid = "4613c2d8-c5ef-c31f-ae22-534a89f7203d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nif not s or not s.known then return false end\nlocal t=Now()\nreturn (s.remaining==0 or t>(s.pbUntil or 0)) and (s.chakra==0 or t>(s.chakraUntil or 0))",
							name = "Nadi known; no pending PB or Blitz",
							uuid = "4d1ed524-e359-9c16-8235-b3c5db9ff513",
							version = 3,
						},
					},

					{
						data =
						{
							actionID = 69,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							uuid = "8a9ca9fe-c5c7-65db-98f9-0e0a31b85676",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"P7 transition Blitz preparation\" and Now()-s.prep.start<10000 and ((s.remaining==0 or Now()>(s.pbUntil or 0)) and s.chakra==0)",
							name = "PB stage 0",
							uuid = "c40a64af-7756-8712-be24-2a7997974e8d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"P7 transition Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==3 and s.chakra==0 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 1",
							uuid = "ef00b399-5cae-c2c1-b080-ba382339414e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"P7 transition Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==2 and s.chakra==1 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 2",
							uuid = "35f0cb76-2f6f-f21a-8c0d-1fa86a1ca97c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"P7 transition Blitz preparation\" and Now()-s.prep.start<10000 and s.remaining==1 and s.chakra==2 and Now()<=(s.pbUntil or 0)",
							name = "PB stage 3",
							uuid = "48c33ee3-21d0-4a90-9f72-f420ee505ab9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.solar",
							name = "Prepare Solar Nadi",
							uuid = "48027bdd-2c2e-0340-a5ff-64f3b6fdc121",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and not s.prep.solar",
							name = "Prepare Lunar or Phantom",
							uuid = "caaf041d-84bf-358e-accd-6d048c77de94",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1542.1,
				name = "[MNK] P7 transition Blitz preparation",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = -0.2,
				timerStartOffset = -11.5,
				uuid = "dfec9f59-c52a-f253-9839-517b96ef0734",
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
							actionID = 25768,
							conditions =
							{

								{
									"d37bf234-d47e-1bbb-9267-865a1e0150bb",
									true,
								},

								{
									"1ed23268-7cf5-0923-b8e0-a280b3bd40d5",
									true,
								},

								{
									"de667b7c-e4eb-d7e3-8f55-e79caa7d37f2",
									true,
								},

								{
									"f1980c40-80a4-39bd-a6b5-0f392d6bf256",
									true,
								},

								{
									"8c60c961-f344-9f24-8a28-ab91a9f52e38",
									true,
								},

								{
									"bc625f75-701e-87f4-882c-0fe9ea379fc1",
									true,
								},
							},
							uuid = "f49cad9b-5b0c-f8f2-8b1c-cc280cc43cb6",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 3545,
							conditions =
							{

								{
									"d37bf234-d47e-1bbb-9267-865a1e0150bb",
									true,
								},

								{
									"1ed23268-7cf5-0923-b8e0-a280b3bd40d5",
									true,
								},

								{
									"de667b7c-e4eb-d7e3-8f55-e79caa7d37f2",
									true,
								},

								{
									"f1980c40-80a4-39bd-a6b5-0f392d6bf256",
									true,
								},

								{
									"8c60c961-f344-9f24-8a28-ab91a9f52e38",
									true,
								},

								{
									"0f4eab7e-8549-754f-b5de-2809507a483b",
									true,
								},
							},
							uuid = "8f9a9788-82a8-e429-885f-e949328dd0dd",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 25769,
							conditions =
							{

								{
									"d37bf234-d47e-1bbb-9267-865a1e0150bb",
									true,
								},

								{
									"1ed23268-7cf5-0923-b8e0-a280b3bd40d5",
									true,
								},

								{
									"de667b7c-e4eb-d7e3-8f55-e79caa7d37f2",
									true,
								},

								{
									"f1980c40-80a4-39bd-a6b5-0f392d6bf256",
									true,
								},

								{
									"8c60c961-f344-9f24-8a28-ab91a9f52e38",
									true,
								},

								{
									"7b68832b-537a-6dfb-8df8-6ad1ba0a176e",
									true,
								},
							},
							targetType = "Current Target",
							uuid = "249d6041-7a81-3a38-94c5-b8692d3d5a06",
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
							jobValue = "MONK",
							name = "Monk only",
							uuid = "d37bf234-d47e-1bbb-9267-865a1e0150bb",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "1ed23268-7cf5-0923-b8e0-a280b3bd40d5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return gACRSelectedProfiles[20] == \"RikuMNK3\"",
							name = "RikuMNK3",
							uuid = "de667b7c-e4eb-d7e3-8f55-e79caa7d37f2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorCore.mGetTarget()\nreturn t and t.targetable and t.attackable and t.hp.current>0 and t.distance2d<=5+t.hitradius",
							name = "Live target in Blitz range",
							uuid = "f1980c40-80a4-39bd-a6b5-0f392d6bf256",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.key==\"P7 transition Blitz preparation\" and s.chakra==3 and Now()<=(s.chakraUntil or 0)",
							name = "Our Blitz is prepared",
							uuid = "8c60c961-f344-9f24-8a28-ab91a9f52e38",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25768",
							name = "Prepared Blitz 25768",
							uuid = "bc625f75-701e-87f4-882c-0fe9ea379fc1",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==3545",
							name = "Prepared Blitz 3545",
							uuid = "0f4eab7e-8549-754f-b5de-2809507a483b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_mnk_downtime\nreturn s and s.prep and s.prep.blitz==25769",
							name = "Prepared Blitz 25769",
							uuid = "7b68832b-537a-6dfb-8df8-6ad1ba0a176e",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes/Monk downtime",
				mechanicTime = 1542.1,
				name = "[MNK] P7 transition Blitz preparation release",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 8,
				uuid = "834ed73d-0de1-f664-a35b-0840fab54d58",
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
							actionLua = "data.frog_war_p7_reverse=true\nself.used=true",
							conditions =
							{

								{
									"ed24d7de-a8c6-72f4-bbf0-e0097aedd607",
									true,
								},

								{
									"5f4d3523-bb4c-b773-9e1b-cb5be97cf430",
									true,
								},

								{
									"583bf58b-bb66-cf96-9ff7-43577eaafe39",
									true,
								},
							},
							name = "Latch reversed assignment",
							uuid = "3a203f7f-6c64-a107-8819-e8b5c0678653",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Alert",
							alertDuration = 4000,
							alertTTS = true,
							alertText = "P7 tank handoffs reversed",
							conditions =
							{

								{
									"ed24d7de-a8c6-72f4-bbf0-e0097aedd607",
									true,
								},

								{
									"5f4d3523-bb4c-b773-9e1b-cb5be97cf430",
									true,
								},

								{
									"583bf58b-bb66-cf96-9ff7-43577eaafe39",
									true,
								},
							},
							uuid = "c4fda260-e7ae-93a1-a9df-50b359122436",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							buffCheckType = 4,
							buffID = 3135,
							buffStacks = 2,
							category = "Self",
							name = "Two light stacks",
							uuid = "583bf58b-bb66-cf96-9ff7-43577eaafe39",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 14,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank job",
							uuid = "ed24d7de-a8c6-72f4-bbf0-e0097aedd607",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local function tankRole()\n local player=TensorCore.mGetPlayer()\n local roster=AnyoneCore.Roster.members()\n local party=AnyoneCore.API.getAgnosticPartyList()\n if not player or type(roster)~=\"table\" or type(party)~=\"table\" then return end\n local byName,byJob,counts,rosterCounts={},{},{},{}\n for _,a in pairs(party) do\n  if a.id and a.name and a.job then\n   byName[a.name..\"\\31\"..a.job]=a;byJob[a.job]=a;counts[a.job]=(counts[a.job] or 0)+1\n  end\n end\n for _,m in pairs(roster) do if m.job then rosterCounts[m.job]=(rosterCounts[m.job] or 0)+1 end end\n local resolved={}\n for _,slot in ipairs({\"T1\",\"T2\"}) do\n  local m=roster[slot]\n  if not m or not m.name or not m.job then return end\n  local a=byName[m.name..\"\\31\"..m.job]\n  if not a and counts[m.job]==1 and rosterCounts[m.job]==1 then a=byJob[m.job] end\n  if not a then return end\n  resolved[slot]=a.id\n end\n if resolved.T1==resolved.T2 then return end\n if resolved.T1==player.id then return \"T1\" elseif resolved.T2==player.id then return \"T2\" end\nend\nreturn tankRole()~=nil",
							name = "Tank roster",
							uuid = "5f4d3523-bb4c-b773-9e1b-cb5be97cf430",
							version = 3,
						},
					},
				},
				mechanicTime = 1542.1,
				name = "[Tank] Reverse Handoffs",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 25.5,
				timerStartOffset = 22,
				uuid = "36863a32-8986-d9d2-9755-142811bee923",
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
