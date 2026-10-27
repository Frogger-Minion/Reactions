local tbl =
{

	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "a0b14b14-c9ba-55c0-285b-fbb24a044aa4",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Settings] Draw Settings",
				uuid = "22d12936-22d4-d931-a60b-b94f5e796a7e",
				version = 2,
			},
			inheritedObjectUUID = "40ce343b-d6ae-f0e8-8fed-38b54bcd6171",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Persistent Draw Priorities Menu",
								uuid = "60c32c03-37f0-88af-922b-400996d76f7f",
								version = 2.1,
							},
							inheritedObjectUUID = "037d4e2f-1842-5c02-8610-55c301569a25",
							inheritedOverwrites =
							{
								actionLua = "if data.frog_draw_settings == nil or data.frog_draw_settings.version~=32 then\n local p={\n  version=32,\n  path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]],\n  default=\"R1 H1 M1 MT OT M2 H2 R2\",\n  styleItems={\"Tether\",\"Arrow\",\"Disabled\"},\n  styleRows={\n   {\"p1_playstation\",\"P1 PlayStation\"},{\"p2_strength\",\"P2 Strength\"},\n   {\"p2_sanctity\",\"P2 Sanctity\"},{\"p3_dfg\",\"P3 Dive from Grace\"},\n   {\"p4_eyes\",\"P4 Eyes\"},{\"p5_wrath\",\"P5 Wrath\"},{\"p5_doth\",\"P5 DOTH\"},{\"p6_vow\",\"P6 Mortal Vow\"},{\"p6_wb1\",\"P6 Wyrmsbreath 1\"},{\"p6_wb2\",\"P6 Wyrmsbreath 2\"},{\"p6_cauterize\",\"P6 Double Cauterize\"},\n   {\"p7_trinity\",\"P7 Trinity\"},{\"p7_akh\",\"P7 Akh Morn\"},{\"p7_giga\",\"P7 Gigaflare\"}\n  },\n  styles={},\n  wb1Anchors={\"H1\",\"M1\",\"H2\"},wb1Flex={\"R1\",\"M2\",\"R2\"},\n  wb2Default=\"H1 R1 M1 M2 H2 R2\",wb2Edit=\"H1 R1 M1 M2 H2 R2\",\n  wb1Roles={\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"},wb2R1North=false,\n  cautMT=\"Nidhogg\",\n  cautItems={\"Nidhogg\",\"Hraesvelgr\",\"Fixed West\",\"Fixed East\"},\n  cautOpposite={\"Hraesvelgr\",\"Nidhogg\",\"Fixed East\",\"Fixed West\"},\n  autoOrderDefault=\"M R H\",\n  autoOrderEdit=\"M R H\",\n  elementDraws=true,\n  akhStrategy=\"6-1-1\",\n  akhStrategyItems={\"6-1-1\",\"3-3-2\"},\n  autoMode=\"Personal\",\n  autoModeItems={\"Personal\",\"Shotcaller\",\"Disabled\"},\n  dothMode=\"Configured conga\",\n  dothModeItems={\"Configured conga\",\"Live positions\"},\n  akhAfahHP=false,\n  vowTTSMode=\"Personal\",\n  vowDefault=\"T T M R\",\n  vowEdit=\"T T M R\",\n  vowGroups={T={\"MT\",\"OT\"},M={\"M1\",\"M2\"},R={\"R1\",\"R2\"}},\n  strategyItems={\"Westhogg\",\"Easthogg\"},\n  strategy=\"NAUR\",\n  holdItems={\"On\",\"Off\"},\n  customHold=false,\n  roles={MT=true,OT=true,H1=true,H2=true,M1=true,M2=true,R1=true,R2=true}\n }\n function p.parse(text)\n  if type(text)~=\"string\" then return nil,\"Enter all eight roles.\" end\n  local order,seen={},{}\n  for role in string.upper(text):gmatch(\"[^%s,]+\") do\n   if not p.roles[role] then return nil,\"Unknown role: \"..role end\n   if seen[role] then return nil,\"Duplicate role: \"..role end\n   seen[role]=true; order[#order+1]=role\n  end\n  if #order~=8 then return nil,\"Enter each of MT OT H1 H2 M1 M2 R1 R2 once.\" end\n  return order,table.concat(order,\" \")\n end\n function p.parseVow(text)\n  local order={}\n  for token in string.upper(text or \"\"):gmatch(\"[^%s,]+\") do\n   if not p.vowGroups[token] then return nil,\"Vow order uses T, M or R. Healers cannot receive.\" end\n   order[#order+1]=token\n  end\n  if #order~=4 then return nil,\"Enter four Vow passes.\" end\n  for _,initial in ipairs({\"M1\",\"M2\",\"R1\",\"R2\"}) do\n   local used={[initial]=true}\n   for _,token in ipairs(order) do\n    local chosen\n    for _,role in ipairs(p.vowGroups[token]) do\n     if not used[role] then chosen=role; break end\n    end\n    if not chosen then return nil,\"Vow order runs out of eligible receivers.\" end\n    used[chosen]=true\n   end\n  end\n  return order,table.concat(order,\" \")\n end\n function p.parseAuto(text)\n  if type(text)~=\"string\" then return nil,\"Auto order uses M, R and H once each.\" end\n  local compact=string.upper(text):gsub(\"[%s,]\",\"\")\n  if #compact~=3 then return nil,\"Enter M, R and H once each.\" end\n  local order,seen={},{}\n  for token in compact:gmatch(\".\") do\n   if token~=\"M\" and token~=\"R\" and token~=\"H\" then return nil,\"Auto order only accepts M, R and H.\" end\n   if seen[token] then return nil,\"Duplicate auto role: \"..token end\n   seen[token]=true; order[#order+1]=token\n  end\n  return order,table.concat(order,\" \")\n end\n function p.validatePairs(text)\n  local roles,seen={},{}\n  for role in (text or \"\"):gmatch(\"%S+\") do\n   if not (role==\"H1\" or role==\"H2\" or role==\"M1\" or role==\"M2\" or role==\"R1\" or role==\"R2\") or seen[role] then return nil,\"Each WB1 role must appear once.\" end\n   seen[role]=true;roles[#roles+1]=role\n  end\n  if #roles~=6 then return nil,\"Assign three anchor/flex pairs.\" end\n  return roles\n end\n function p.lineupPoints(roles)\n  local roster=AnyoneCore and AnyoneCore.Roster\n  if not roster or not roster.isReady() then return nil,\"Set the AnyoneCore roster first.\" end\n  local members=roster.members();local party=AnyoneCore.API.getAgnosticPartyList()\n  if type(members)~=\"table\" or type(party)~=\"table\" then return nil,\"Party roster unavailable.\" end\n  local slots={MT=\"T1\",OT=\"T2\",H1=\"H1\",H2=\"H2\",M1=\"M1\",M2=\"M2\",R1=\"R1\",R2=\"R2\"}\n  local points,used={},{}\n  local cx,cz=0,0\n  for _,role in ipairs(roles)do\n   local member=members[slots[role]]\n   if not member then return nil,\"Missing roster role: \"..role end\n   local candidate,count=nil,0\n   for _,a in pairs(party)do\n    if a.name==member.name and a.job==member.job then candidate=a;count=count+1 end\n   end\n   if count==0 then\n    local sameJob=0;for _,m in pairs(members)do if m.job==member.job then sameJob=sameJob+1 end end\n    if sameJob==1 then for _,a in pairs(party)do if a.job==member.job then candidate=a;count=count+1 end end end\n   end\n   if count~=1 or used[candidate.id] then return nil,\"Cannot uniquely match \"..role..\" to the party.\" end\n   local actor=TensorCore.mGetEntity(candidate.id)\n   if not actor or not actor.alive then return nil,\"All lineup players must be present and alive.\" end\n   used[actor.id]=true\n   points[#points+1]={role=role,x=actor.pos.x,z=actor.pos.z};cx=cx+actor.pos.x;cz=cz+actor.pos.z\n  end\n  return points\n end\n function p.captureLineup(roles)\n  local points,message=p.lineupPoints(roles)\n  if not points then return nil,message end\n  local cx,cz=0,0\n  for _,v in ipairs(points)do cx=cx+v.x;cz=cz+v.z end\n  cx=cx/#points;cz=cz/#points\n  local xx,xz,zz=0,0,0\n  for _,v in ipairs(points)do local x,z=v.x-cx,v.z-cz;xx=xx+x*x;xz=xz+x*z;zz=zz+z*z end\n  local h=0.5*math.atan2(2*xz,xx-zz)\n  local ux,uz=math.cos(h),math.sin(h)\n  local eastWest=math.abs(ux)>=math.abs(uz)\n  if (eastWest and ux<0) or (not eastWest and uz<0)then ux=-ux;uz=-uz end\n  local width=0\n  for _,v in ipairs(points)do\n   v.rank=(v.x-cx)*ux+(v.z-cz)*uz\n   width=math.max(width,math.abs((v.x-cx)*uz-(v.z-cz)*ux))\n  end\n  table.sort(points,function(a,b)return a.rank<b.rank end)\n  if width>3 then return nil,\"Form a single lineup before capturing.\" end\n  local order={}\n  for i,v in ipairs(points)do\n   if i>1 and v.rank-points[i-1].rank<0.3 then return nil,\"Lineup overlaps; separate the players or drag the boxes.\" end\n   order[i]=v.role\n  end\n  return order,eastWest and \"Captured W to E. Reverse if needed.\" or \"Captured N to S. Reverse if needed.\"\n end\n function p.captureDOTH()\n  local points,message=p.lineupPoints({\"MT\",\"OT\",\"H1\",\"H2\",\"M1\",\"M2\",\"R1\",\"R2\"})\n  if not points then return nil,message end\n  table.sort(points,function(a,b)return a.x<b.x end)\n  local order={}\n  for i,v in ipairs(points)do\n   if i>1 and v.x-points[i-1].x<0.3 then return nil,\"Separate players west to east before capturing DOTH.\" end\n   order[i]=v.role\n  end\n  return order,\"Captured DOTH west to east.\"\n end\n function p.captureWB1()\n  local points,message=p.lineupPoints(p.wb1Roles)\n  if not points then return nil,message end\n  local marks={}\n  for i=1,8 do\n   local x,y,z,active=Argus.getWaymarkInfo(i)\n   if active then\n    local near={}\n    for _,v in ipairs(points)do near[#near+1]={role=v.role,d=(v.x-x)^2+(v.z-z)^2}end\n    table.sort(near,function(a,b)return a.d<b.d end)\n    if near[2].d<=36 and near[2].d-near[1].d>=0.25 then\n     marks[#marks+1]={x=x,z=z,anchor=near[1].role,flex=near[2].role,cost=near[1].d+near[2].d}\n    end\n   end\n  end\n  local best,second,chosen=math.huge,math.huge,nil\n  for a=1,#marks-2 do for b=a+1,#marks-1 do for c=b+1,#marks do\n   local tri={marks[a],marks[b],marks[c]}\n   local area=math.abs((tri[2].x-tri[1].x)*(tri[3].z-tri[1].z)-(tri[3].x-tri[1].x)*(tri[2].z-tri[1].z))\n   local used,valid,cost={},area>2,0\n   for _,m in ipairs(tri)do\n    if used[m.anchor] or used[m.flex]then valid=false end\n    used[m.anchor]=true;used[m.flex]=true;cost=cost+m.cost\n   end\n   if valid then\n    if cost<best then second=best;best=cost;chosen=tri elseif cost<second then second=cost end\n   end\n  end end end\n  if not chosen or second-best<0.25 then return nil,\"Stand in three clear anchor/flex pairs beside the triangle markers.\" end\n  table.sort(chosen,function(a,b)return a.x<b.x end)\n  if chosen[2].x-chosen[1].x<1 or chosen[3].x-chosen[2].x<1 then return nil,\"The three WB1 markers must define left, middle and right.\" end\n  local order={}\n  for _,m in ipairs(chosen)do order[#order+1]=m.anchor;order[#order+1]=m.flex end\n  return order,\"Captured closest anchor and second-closest flex at each triangle marker.\"\n end\n function p.save(text)\n  local order,normalized=p.parse(text)\n  if not order then p.message=normalized; return false end\n  local vowOrder,vowText=p.parseVow(p.vowEdit)\n  if not vowOrder then p.message=vowText; return false end\n  local autoOrder,autoText=p.parseAuto(p.autoOrderEdit)\n  if not autoOrder then p.message=autoText; return false end\n  local pairText=table.concat({p.wb1Anchors[1],p.wb1Flex[1],p.wb1Anchors[2],p.wb1Flex[2],p.wb1Anchors[3],p.wb1Flex[3]},\" \")\n  local pairsOK,pairError=p.validatePairs(pairText)\n  if not pairsOK then p.message=pairError;return false end\n  local wb2=p.validatePairs(p.wb2Edit)\n  if not wb2 then p.message=\"WB2 requires each non-tank role once.\";return false end\n  local wb2Text=table.concat(wb2,\" \")\n  local nextSettings={}\n  for k,v in pairs(p.settings) do nextSettings[k]=v end\n  nextSettings.p6_wb1_pairs=pairText\n  nextSettings.p6_wb2_r1_north=p.wb2R1North\n  nextSettings.p6_wb2_order=wb2Text\n  nextSettings.doth_conga=normalized\n  nextSettings.doth_order_mode=p.dothMode==\"Live positions\" and \"Live positions\" or \"Configured conga\"\n  nextSettings.vow_pass_order=vowText\n  nextSettings.p6_vow_tts_mode=p.vowTTSMode\n  nextSettings.p6_akh_afah_hp=p.akhAfahHP\n  nextSettings.p6_dragon_hp_window=p.dragonHP\n  nextSettings.p3_custom_hold=p.customHold\n  nextSettings.p3_strategy=p.strategy==\"LPDU\" and \"LPDU\" or \"NAUR\"\n  nextSettings.p7_element_draws=p.elementDraws\n  nextSettings.p7_akh_strategy=p.akhStrategy==\"3-3-2\" and \"3-3-2\" or \"6-1-1\"\n  nextSettings.p7_auto_order=autoText\n  nextSettings.p7_auto_mode=p.autoMode\n  nextSettings.p6_cauterize_mt=p.cautMT\n  nextSettings.draw_styles={}\n  for _,row in ipairs(p.styleRows) do\n   local choice=p.styles[row[1]]\n   nextSettings.draw_styles[row[1]]=choice==\"Disabled\" and \"Disabled\" or choice==\"Arrow\" and \"Arrow\" or \"Tether\"\n  end\n  local ok,err=pcall(FileSave,p.path,nextSettings)\n  local readOK,saved=pcall(FileLoad,p.path)\n  local stylesOK=readOK and type(saved)==\"table\" and type(saved.draw_styles)==\"table\"\n  if stylesOK then\n   for _,row in ipairs(p.styleRows) do\n    if saved.draw_styles[row[1]]~=nextSettings.draw_styles[row[1]] then stylesOK=false break end\n   end\n  end\n  if not ok or not readOK or (type(saved)==\"table\" and (saved.p6_wb1_pairs~=pairText or saved.p6_wb2_r1_north~=p.wb2R1North)) or type(saved)~=\"table\" or saved.doth_conga~=normalized or saved.p6_wb2_order~=wb2Text or saved.doth_order_mode~=nextSettings.doth_order_mode or saved.p7_element_draws~=nextSettings.p7_element_draws or saved.p7_akh_strategy~=nextSettings.p7_akh_strategy or saved.p7_auto_order~=autoText or saved.p7_auto_mode~=nextSettings.p7_auto_mode or saved.p6_cauterize_mt~=nextSettings.p6_cauterize_mt or not stylesOK or saved.p3_strategy~=nextSettings.p3_strategy or saved.p3_custom_hold~=nextSettings.p3_custom_hold or saved.vow_pass_order~=vowText or saved.p6_vow_tts_mode~=nextSettings.p6_vow_tts_mode or saved.p6_akh_afah_hp~=nextSettings.p6_akh_afah_hp or saved.p6_dragon_hp_window~=nextSettings.p6_dragon_hp_window then\n   p.message=\"Save failed: \"..tostring(err or saved); return false\n  end\n  p.settings=nextSettings\n  if not p.elementDraws then\n   local element=data.frog_p7_element\n   if element and element.draw then Argus.deleteTimedShape(element.draw); element.draw=nil end\n  end\n  p.autoOrderEdit=autoText\n  p.vowEdit=vowText\n  p.order,p.saved,p.edit=order,normalized,normalized\n  p.message=\"Saved.\"\n  return true\n end\n p.order,p.saved=p.parse(p.default)\n p.edit=p.saved\n p.settings={}\n if FileExists(p.path) then\n  local ok,settings=pcall(FileLoad,p.path)\n  local order,normalized\n  if ok and type(settings)==\"table\" then\n   p.settings=settings\n   order,normalized=p.parse(settings.doth_conga)\n  end\n  if order then p.order,p.saved,p.edit=order,normalized,normalized\n  else p.message=\"Invalid settings file; using defaults. Apply to repair.\" end\n else\n  local previous=data.frog_draw_settings\n  p.save(previous and previous.saved or p.default)\n end\n for _,row in ipairs(p.styleRows) do\n  local styles=p.settings.draw_styles\n  local choice=type(styles)==\"table\" and styles[row[1]]\n  p.styles[row[1]]=choice==\"Disabled\" and \"Disabled\" or choice==\"Arrow\" and \"Arrow\" or \"Tether\"\n end\n local pairRoles=p.validatePairs(p.settings.p6_wb1_pairs or \"H1 R1 M1 M2 H2 R2\")\n if pairRoles then for lane=1,3 do p.wb1Anchors[lane]=pairRoles[lane*2-1];p.wb1Flex[lane]=pairRoles[lane*2] end end\n p.wb2R1North=p.settings.p6_wb2_r1_north==true\n local wb2=p.validatePairs(p.settings.p6_wb2_order or \"\")\n p.wb2Edit=wb2 and table.concat(wb2,\" \") or (p.wb2R1North and \"H1 R2 M1 M2 H2 R1\" or p.wb2Default)\n local autoOrder,autoText=p.parseAuto(p.settings.p7_auto_order or p.autoOrderDefault)\n p.autoOrderEdit=autoOrder and autoText or p.autoOrderDefault\n if not autoOrder then p.message=\"Invalid auto order; Save to use M R H.\" end\n p.elementDraws=p.settings.p7_element_draws~=false\n p.akhStrategy=p.settings.p7_akh_strategy==\"3-3-2\" and \"3-3-2\" or \"6-1-1\"\n p.autoMode=p.settings.p7_auto_mode==\"Shotcaller\" and \"Shotcaller\" or p.settings.p7_auto_mode==\"Disabled\" and \"Disabled\" or \"Personal\"\n local vowOrder,vowText=p.parseVow(p.settings.vow_pass_order or p.vowDefault)\n p.vowEdit=vowOrder and vowText or p.vowDefault\n p.akhAfahHP=p.settings.p6_akh_afah_hp==true\n p.dragonHP=p.settings.p6_dragon_hp_window~=false\n p.vowTTSMode=p.settings.p6_vow_tts_mode==\"Shotcaller\" and \"Shotcaller\" or p.settings.p6_vow_tts_mode==\"Disabled\" and \"Disabled\" or \"Personal\"\n if not vowOrder then p.message=\"Invalid Vow order; Save to use T T M R.\" end\n p.strategy=p.settings.p3_strategy==\"LPDU\" and \"LPDU\" or \"NAUR\"\n p.customHold=p.settings.p3_custom_hold==true\n p.dothMode=p.settings.doth_order_mode==\"Live positions\" and \"Live positions\" or \"Configured conga\"\n for _,value in ipairs(p.cautItems) do\n  if p.settings.p6_cauterize_mt==value then p.cautMT=value; break end\n end\n -- Preserve any unsaved edits when adding the new P6 settings.\n local previous=data.frog_draw_settings\n if previous then\n  for _,key in ipairs({\"edit\",\"vowEdit\",\"autoOrderEdit\",\"elementDraws\",\"akhStrategy\",\"autoMode\",\"strategy\",\"customHold\",\"dothMode\",\"cautMT\",\"vowTTSMode\",\"akhAfahHP\",\"dragonHP\",\"wb1Anchors\",\"wb1Flex\",\"wb2R1North\",\"wb2Edit\",\"message\"}) do\n   if previous[key]~=nil then p[key]=previous[key] end\n  end\n  for _,row in ipairs(p.styleRows) do\n   if previous.styles and previous.styles[row[1]] then p.styles[row[1]]=previous.styles[row[1]] end\n  end\n end\n data.frog_draw_settings=p\nend\n\nlocal p=data.frog_draw_settings\n-- Keep current edits intact when the menu layout changes.\nif p.strategyItems[1]~=\"Westhogg\" then\n p.strategyItems[1]=\"Westhogg\"; p.strategyItems[2]=\"Easthogg\"\nend\nlocal visible=GUI:Begin(\"Frog Draws\",nil,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n if GUI:Button(\"Open AnyoneCore roster\") then\n  local popup=AnyoneCore and AnyoneCore.RosterPopup\n  if popup and type(popup.openManual)==\"function\" then\n   local ok,err=pcall(popup.openManual)\n   if not ok then p.message=\"Roster could not open: \"..tostring(err) end\n  else p.message=\"AnyoneCore roster is unavailable\" end\n end\n GUI:Separator()\n local function changed(field,value)\n  if value~=nil and value~=p[field] then p[field]=value; p.message=\"Unsaved changes\" end\n end\n local function choice(id,label,index,items)\n  local selected=GUI:Combo(\"##\"..id,index,items)\n  GUI:SameLine(); GUI:TextUnformatted(label)\n  return selected\n end\n local function style(key,label)\n  local value=p.styles[key]\n  local index=value==\"Disabled\" and 3 or value==\"Arrow\" and 2 or 1\n  local selected=choice(key,label,index,p.styleItems)\n  local valueNew=p.styleItems[selected]\n  if valueNew and valueNew~=value then p.styles[key]=valueNew; p.message=\"Unsaved changes\" end\n end\n local function order(field,id,label,width,default)\n  GUI:PushItemWidth(width)\n  changed(field,GUI:InputText(\"##\"..id,p[field]))\n  GUI:PopItemWidth()\n  GUI:SameLine(); GUI:TextUnformatted(label)\n  if GUI:Button(\"Reset##\"..id) then changed(field,default) end\n end\n local function lineup(id,text,defaults,valid)\n  p.lineupWidgets=p.lineupWidgets or {}\n  local w=p.lineupWidgets[id]\n  if not w or w.text~=text then\n   local values=valid(text)\n   if not values then values=valid(defaults)end\n   w={text=text,values=values};p.lineupWidgets[id]=w\n  end\n  local captured=false;local changedOrder=false;local note\n  if GUI:Button(\"Capture lineup##\"..id)then\n   local expected=valid(defaults)\n   local values,message\n   if id==\"wb1\"then values,message=p.captureWB1()elseif id==\"doth\"then values,message=p.captureDOTH()else values,message=p.captureLineup(expected)end\n   if values then w.values=values;captured=true;changedOrder=true;note=message else p.message=message end\n  end\n  if GUI:IsItemHovered()then GUI:SetTooltip(\"Capture the live lineup. DOTH: west to east. Drag onto a box centre to swap; use its left/right edge to insert before/after.\")end\n  GUI:SameLine()\n  if GUI:Button(\"Reverse##\"..id)then\n   local values=w.values\n   for i=1,math.floor(#values/2)do values[i],values[#values-i+1]=values[#values-i+1],values[i]end\n   changedOrder=true\n  end\n  local drop\n  for i,role in ipairs(w.values)do\n   local label=role\n   local width=36\n   if id==\"wb1\"then\n    if i%2==1 then\n     GUI:Separator()\n     GUI:TextUnformatted(({\"Left pair\",\"Middle pair\",\"Right pair\"})[math.floor((i+1)/2)])\n    else GUI:SameLine()end\n    label=(i%2==1 and \"Anchor: \" or \"Flex: \")..role\n    width=110\n   elseif id==\"wb2\"then\n    if i%2==1 then GUI:Separator()else GUI:SameLine()end\n    label=({\"North wall: \",\"SW outer: \",\"SW inner: \",\"NE inner: \",\"South wall: \",\"NE outer: \"})[i]..role\n    width=145\n   elseif i>1 then GUI:SameLine()end\n   GUI:Button(label..\"##\"..id..\"_\"..role,width,26)\n   if GUI:IsItemClicked(0)then p.lineupDrag={id=id,index=i}end\n   local ax,ay=GUI:GetItemRectMin();local bx,by=GUI:GetItemRectMax()\n   if p.lineupDrag and p.lineupDrag.id==id and GUI:IsMouseHoveringRect(ax,ay,bx,by,true)then\n    drop=i\n    local mx=GUI:GetMousePos()\n    local fraction=(mx-ax)/math.max(1,bx-ax)\n    p.lineupDropMode=fraction<0.25 and \"before\" or fraction>0.75 and \"after\" or \"swap\"\n    GUI:SetTooltip(p.lineupDropMode==\"swap\" and \"Swap with \"..role or (p.lineupDropMode==\"before\" and \"Insert before \" or \"Insert after \")..role)\n   end\n  end\n  if p.lineupDrag and p.lineupDrag.id==id and GUI:IsMouseReleased(0)then\n   local from=p.lineupDrag.index\n   if drop and drop~=from then\n    if p.lineupDropMode==\"swap\"then\n     w.values[from],w.values[drop]=w.values[drop],w.values[from]\n     changedOrder=true\n    else\n     local slot=drop+(p.lineupDropMode==\"after\" and 1 or 0)\n     if from<slot then slot=slot-1 end\n     if slot~=from then table.insert(w.values,slot,table.remove(w.values,from));changedOrder=true end\n    end\n   end\n   p.lineupDrag=nil;p.lineupDropMode=nil\n  end\n  if changedOrder then\n   w.text=table.concat(w.values,\" \")\n   p.message=note or \"Unsaved changes\"\n   return w.text,captured,note\n  end\n  return text,false\n end\n GUI:PushItemWidth(145)\n if GUI:CollapsingHeader(\"P1 - Vault\") then\n  style(\"p1_playstation\",\"PlayStation\")\n end\n if GUI:CollapsingHeader(\"P2 - Thordan\") then\n  style(\"p2_strength\",\"Strength\")\n  style(\"p2_sanctity\",\"Sanctity\")\n end\n if GUI:CollapsingHeader(\"P3 - Nidhogg\") then\n  style(\"p3_dfg\",\"Dive from Grace\")\n  local selected=choice(\"p3_strategy\",\"Strategy\",p.strategy==\"LPDU\" and 2 or 1,p.strategyItems)\n  changed(\"strategy\",selected==2 and \"LPDU\" or \"NAUR\")\n  selected=choice(\"p3_custom_hold\",\"Lock face / stop actions\",p.customHold and 1 or 2,p.holdItems)\n  changed(\"customHold\",selected==1)\n end\n if GUI:CollapsingHeader(\"P4 - Eyes\") then\n  style(\"p4_eyes\",\"Orbs and Mirage Dive\")\n end\n if GUI:CollapsingHeader(\"P5 - Dark Thordan\") then\n  style(\"p5_wrath\",\"Wrath Of The Heavens\")\n  style(\"p5_doth\",\"Death Of The Heavens\")\n  local selected=choice(\"doth_order_mode\",\"DOTH order\",p.dothMode==\"Live positions\" and 2 or 1,p.dothModeItems)\n  changed(\"dothMode\",p.dothModeItems[selected])\n  GUI:TextUnformatted(\"DOTH order - drag to rearrange\")\n  local value,captured,note=lineup(\"doth\",p.edit,p.default,p.parse)\n  if value~=p.edit then p.dothMode=\"Configured conga\" end\n  changed(\"edit\",value)\n  if captured then p.dothMode=\"Configured conga\";if p.save(p.edit)then p.message=note..\" Saved.\"end end\n end\n if GUI:CollapsingHeader(\"P6 - Double Dragons\") then\n  local hpWindow=choice(\"p6_dragon_hp_window\",\"Dragon HP window\",p.dragonHP and 1 or 2,p.holdItems)\n  changed(\"dragonHP\",hpWindow==1)\n  local afahHP=choice(\"p6_akh_afah_hp\",\"Akh Afah HP callout\",p.akhAfahHP and 1 or 2,p.holdItems)\n  changed(\"akhAfahHP\",afahHP==1)\n  style(\"p6_vow\",\"Mortal Vow\")\n  local vowMode=choice(\"p6_vow_tts_mode\",\"Vow callouts\",p.vowTTSMode==\"Personal\" and 1 or p.vowTTSMode==\"Disabled\" and 3 or 2,p.autoModeItems)\n  changed(\"vowTTSMode\",p.autoModeItems[vowMode])\n  if p.styles.p6_vow~=\"Disabled\" then\n   order(\"vowEdit\",\"vow_order\",\"Vow passes (T / M / R)\",145,p.vowDefault)\n  end\n  style(\"p6_wb1\",\"Wyrmsbreath 1\")\n  GUI:TextUnformatted(\"WB1 pairs - anchor stays, flex adjusts\")\n  local pairsText=table.concat({p.wb1Anchors[1],p.wb1Flex[1],p.wb1Anchors[2],p.wb1Flex[2],p.wb1Anchors[3],p.wb1Flex[3]},\" \")\n  local value,captured,note=lineup(\"wb1\",pairsText,\"H1 R1 M1 M2 H2 R2\",p.validatePairs)\n  if value~=pairsText then\n   local roles=p.validatePairs(value)\n   for i=1,3 do p.wb1Anchors[i]=roles[i*2-1];p.wb1Flex[i]=roles[i*2]end\n   p.message=\"Unsaved changes\"\n  end\n  if captured and p.save(p.edit)then p.message=note..\" Saved.\"end\n  GUI:TextUnformatted(\"Anchors hold; flexers match opposite colours.\")\n  style(\"p6_wb2\",\"Wyrmsbreath 2\")\n  GUI:TextUnformatted(\"WB2 fixed spots - drag roles between labelled positions\")\n  local value,captured,note=lineup(\"wb2\",p.wb2Edit,p.wb2Default,p.validatePairs)\n  changed(\"wb2Edit\",value)\n  if captured and p.save(p.edit)then p.message=note..\" Saved.\"end\n  style(\"p6_cauterize\",\"Double Cauterize\")\n  if p.styles.p6_cauterize~=\"Disabled\" then\n   local index=1\n   for i,value in ipairs(p.cautItems) do if value==p.cautMT then index=i; break end end\n   local selected=choice(\"p6_cauterize_mt\",\"MT takes\",index,p.cautItems)\n   changed(\"cautMT\",p.cautItems[selected])\n   GUI:TextUnformatted(\"OT takes: \"..p.cautOpposite[selected])\n  end\n end\n if GUI:CollapsingHeader(\"P7 - Dragon-King\") then\n  style(\"p7_trinity\",\"Trinity\")\n  style(\"p7_akh\",\"Akh Morn\")\n  if p.styles.p7_akh~=\"Disabled\" then\n   local selected=choice(\"p7_akh_strategy\",\"Akh Morn groups\",p.akhStrategy==\"3-3-2\" and 2 or 1,p.akhStrategyItems)\n   changed(\"akhStrategy\",p.akhStrategyItems[selected])\n   if p.akhStrategy==\"3-3-2\" then GUI:TextUnformatted(\"G1 NW / G2 NE / tanks S\") end\n  end\n  style(\"p7_giga\",\"Gigaflare\")\n  local selected=choice(\"p7_element_draws\",\"Flames / ice\",p.elementDraws and 1 or 2,p.holdItems)\n  changed(\"elementDraws\",selected==1)\n  selected=choice(\"p7_auto_mode\",\"Auto callouts\",p.autoMode==\"Shotcaller\" and 2 or p.autoMode==\"Disabled\" and 3 or 1,p.autoModeItems)\n  changed(\"autoMode\",p.autoModeItems[selected])\n  if p.autoMode~=\"Disabled\" then\n   GUI:PushItemWidth(145)\n   changed(\"autoOrderEdit\",GUI:InputText(\"##p7_auto_order\",p.autoOrderEdit))\n   GUI:PopItemWidth()\n   GUI:SameLine(); GUI:TextUnformatted(\"Auto order (M / R / H; G1 first)\")\n   local valid,err=p.parseAuto(p.autoOrderEdit)\n   if not valid then GUI:TextUnformatted(err) end\n  end\n end\n GUI:PopItemWidth()\n GUI:Separator()\n if GUI:Button(\"Save\") then p.save(p.edit) end\n if p.message then GUI:SameLine(); GUI:TextUnformatted(p.message) end\nend\nGUI:End()\nself.used=true\n",
							},
						},
					},
				},
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
							aType = "ACR",
							conditions =
							{

								{
									"84c28b09-89b7-d643-9096-a3c34c497a07",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "ca6b7451-d5ef-e120-b078-ce78c2936741",
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
							buffCheckType = 2,
							buffID = 91,
							category = "Self",
							uuid = "84c28b09-89b7-d643-9096-a3c34c497a07",
							version = 3,
						},
					},
				},
				eventType = 16,
				name = "[WAR] Stance On",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 1,
				timerOffset = -30,
				timerStartOffset = -30,
				uuid = "99f6dadf-4534-b6cd-b637-44d265eaa835",
				version = 2,
			},
			inheritedIndex = 10,
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ed614957-af42-0663-c73d-2d052c1041c7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7538,
							conditions =
							{

								{
									"40d0ff4d-51ce-36ed-99ea-357665a014db",
									true,
								},

								{
									"43fe59c8-75af-0a0d-9811-1f33d11b5ed0",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Interject Adelphel",
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "8bdb727b-9209-f49a-bc69-fb723f016a65",
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
							eventSpellID = 25296,
							name = "E - 69.1/88.2/104.2 Holiest Hallowing",
							uuid = "40d0ff4d-51ce-36ed-99ea-357665a014db",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							eventArgOptionType = 2,
							eventEntityContentID = 3634,
							name = "E - 69.1/88.2/104.2 Ser Adelphel",
							uuid = "43fe59c8-75af-0a0d-9811-1f33d11b5ed0",
							version = 3,
						},
					},
				},
				enabled = false,
				eventType = 3,
				name = "[WAR] Interrupt Adelphel",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 120,
				uuid = "ab718d93-92e2-41be-b378-10704e20f28a",
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
							aType = "ACR",
							actionID = 7531,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"4511ca96-dbc4-b62d-b89c-38106578d6f8",
									true,
								},

								{
									"498288f7-1176-67e1-a605-0aea12da5ae7",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							ignoreWeaveRules = true,
							uuid = "bc8899b1-fe0e-05bc-af6d-856da657b746",
							variableTogglesType = 3,
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 46,
							atomicPriority = true,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"935713ad-f375-f1b0-bd2e-b3231fe2f523",
									true,
								},

								{
									"498288f7-1176-67e1-a605-0aea12da5ae7",
									true,
								},
							},
							name = "Tomahawk - Ser Adelphel",
							targetType = "Detection Target",
							uuid = "ed0cb8d6-5309-e680-95ee-0602451ac5a7",
							version = 2.1,
						},
						inheritedIndex = 2,
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"40d23191-49f2-8f4a-9df0-22dc2ae559c7",
									true,
								},

								{
									"498288f7-1176-67e1-a605-0aea12da5ae7",
									true,
								},
							},
							name = "Provoke - Ser Adelphel",
							targetType = "Detection Target",
							uuid = "93dc2b70-624a-48a5-b803-20cb154b2867",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 46,
							atomicPriority = true,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"935713ad-f375-f1b0-bd2e-b3231fe2f523",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							name = "Tomahawk - King Thordan",
							targetType = "Detection Target",
							uuid = "8a6cdd5b-44f9-3674-88f2-b405ebf65d5c",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"40d23191-49f2-8f4a-9df0-22dc2ae559c7",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							name = "Provoke - King Thordan",
							targetType = "Detection Target",
							uuid = "bb23e9c3-ced7-cd90-b30e-6cd8bd2e7999",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7387,
							atomicPriority = true,
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"70cda44e-ef11-c179-adf4-120c10e86680",
									true,
								},

								{
									"5b5162e1-378f-74b7-9350-55daa625c52d",
									true,
								},
							},
							ignoreWeaveRules = true,
							targetType = "Detection Target",
							uuid = "6996ad1e-ac46-bce8-9d61-d1640f8c0baf",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							acrOptionType = "Hold Action",
							actionLua = "local release=eventArgs.timeQueued+(eventArgs.time+8)*1000\nTensorCore.API.TensorACR.holdActionUntil(7389,release,1)\ndata.frog_war_early_prepull_holds=true\nself.used=true",
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"828b6395-17f8-bfe9-9038-587b26aa7c54",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							holdActionDuration = 8,
							holdActionID = 7389,
							name = "Hold Inner Release until +8s",
							uuid = "b540dcdb-764c-87fa-9e12-0bf042d07dc6",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							acrOptionType = "Hold Action",
							actionLua = "local release=eventArgs.timeQueued+(eventArgs.time+16)*1000\nTensorCore.API.TensorACR.holdActionUntil(25753,release,1)\ndata.frog_war_early_prepull_holds=true\nself.used=true",
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"828b6395-17f8-bfe9-9038-587b26aa7c54",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							holdActionDuration = 16,
							holdActionID = 25753,
							name = "Hold Primal Rend until +16s",
							uuid = "a3058758-9663-bbf3-ab68-9335501aa220",
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
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"4511ca96-dbc4-b62d-b89c-38106578d6f8",
									true,
								},

								{
									"498288f7-1176-67e1-a605-0aea12da5ae7",
									true,
								},
							},
							name = "Target Adelphel",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "b6160cd2-4e8e-d8e8-896f-98b237860741",
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
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"4511ca96-dbc4-b62d-b89c-38106578d6f8",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							name = "Target Thordan",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "55b527b3-d282-2d3d-910d-8ca0b3c6108d",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							acrOptionType = "Hold Action",
							actionLua = "local release=eventArgs.timeQueued+(eventArgs.time+2)*1000\nTensorCore.API.TensorACR.holdActionUntil(52,release,2)\ndata.frog_war_early_prepull_holds=true\nself.used=true",
							conditions =
							{

								{
									"2bb695f3-a4ba-8411-9e09-d72f5cf41944",
									true,
								},

								{
									"6d4d5118-1c75-74a5-9846-2373172e28cd",
									true,
								},

								{
									"828b6395-17f8-bfe9-9038-587b26aa7c54",
									true,
								},

								{
									"98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
									true,
								},
							},
							holdActionCharges = 2,
							holdActionDuration = 2,
							holdActionID = 52,
							name = "Hold Infuriate until +2s",
							uuid = "1c038cca-70d3-6d60-8dde-429e61e170d9",
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
							localmapid = 968,
							name = "DSR Map ID",
							uuid = "6d4d5118-1c75-74a5-9846-2373172e28cd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "F - Ser Adelphel",
							partyTargetContentID = 3634,
							uuid = "498288f7-1176-67e1-a605-0aea12da5ae7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "98f04ba2-a8ea-f9d5-8d46-b0a586ce1a29",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 2,
							eventCountdownTime = 5,
							name = "E - 4s remaining",
							uuid = "4511ca96-dbc4-b62d-b89c-38106578d6f8",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 2,
							eventCountdownTime = 1,
							name = "E - 0.8s remaining",
							uuid = "935713ad-f375-f1b0-bd2e-b3231fe2f523",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 2,
							eventCountdownTime = 0.5,
							name = "E - 0.5s remaining",
							uuid = "40d23191-49f2-8f4a-9df0-22dc2ae559c7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 2,
							name = "E - 0s remaining",
							uuid = "70cda44e-ef11-c179-adf4-120c10e86680",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "5b5162e1-378f-74b7-9350-55daa625c52d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 2,
							eventCountdownTime = 20,
							name = "Holds from -20s",
							uuid = "828b6395-17f8-bfe9-9038-587b26aa7c54",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return FFXIV_Common_BotRunning == true",
							name = "Bot running",
							uuid = "2bb695f3-a4ba-8411-9e09-d72f5cf41944",
							version = 3,
						},
					},
				},
				eventType = 16,
				name = "[WAR] Prepull",
				timeRange = true,
				timelineIndex = 1,
				timeout = 60,
				timerEndOffset = 30,
				timerStartOffset = -30,
				uuid = "61558045-bd5c-1e9e-9161-50d696e867ad",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Local fixes",
				uuid = "35c5797d-778d-738f-9b83-2132ecf65e14",
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
							actionLua = "local now=Now()\nTensorCore.API.TensorACR.holdActionUntil(52,now,2)\nTensorCore.API.TensorACR.holdActionUntil(7389,now,1)\nTensorCore.API.TensorACR.holdActionUntil(25753,now,1)\ndata.frog_war_early_prepull_holds=nil\nself.used=true",
							conditions =
							{

								{
									"4dea4005-982f-37ec-accb-905b29b10912",
									true,
								},

								{
									"77418b96-2030-b92e-8aa8-5438dc50a2e2",
									true,
								},
							},
							endIfUsed = true,
							name = "Release cancelled prepull holds",
							uuid = "8fb78c85-c658-581f-9faf-84a4cde4a1cd",
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
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "4dea4005-982f-37ec-accb-905b29b10912",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_early_prepull_holds==true",
							name = "Early holds were armed",
							uuid = "77418b96-2030-b92e-8aa8-5438dc50a2e2",
							version = 3,
						},
					},
				},
				displayPath = "Local fixes",
				eventType = 17,
				name = "[WAR] Cancel early prepull holds",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 30,
				timerStartOffset = -30,
				uuid = "de7a8e4a-e277-8488-95fc-0535afe04d6c",
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
				uuid = "dfaa6310-4b66-14ac-2631-9d72b406fa40",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Hold Jumps",
				uuid = "d4b73af4-7769-8531-8314-2cc0b710c2df",
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
				uuid = "8d10da89-b44c-7cd5-4efe-7093186852f9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"9ac9e9d5-e66f-172d-8c9d-18030f8ed796",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "Reprisal",
							uuid = "5d8f8bde-ee5d-e494-9080-d5240e2a4831",
							variableTogglesType = 3,
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
							comparator = 2,
							conditionLua = "local e=TensorCore.mGetEntity(eventArgs.detectionTargetID)\nlocal p=TensorCore.mGetPlayer()\nif not e or not e.targetable or not p then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz<=(e.hitradius+5)^2",
							conditionType = 4,
							inRangeValue = 5,
							name = "Targetable + in range",
							partyTargetType = "Detection Target",
							uuid = "e721c555-0101-d892-8a13-782e18848bad",
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
									"e721c555-0101-d892-8a13-782e18848bad",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Ser Adelphel",
							partyTargetContentID = 3634,
							uuid = "9ac9e9d5-e66f-172d-8c9d-18030f8ed796",
							version = 3,
						},
					},
				},
				mechanicTime = 10,
				name = "[WAR] Reprisal 1",
				timeRange = true,
				timelineIndex = 3,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "66563244-4050-445b-8e8d-5a7cdf9a78d7",
				version = 2,
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
				uuid = "c8ba5955-78a2-fe09-dc65-a707c2138bc5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[8] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "abb4e2ae-c871-1d3a-69f8-cf944da236de",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[10] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "9a83ac66-91cf-277a-7582-c47009d24bf6",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Blade Draw",
				uuid = "74f308a0-19e4-8422-92c0-e5aaf64df347",
				version = 2,
			},
			inheritedObjectUUID = "60c1eed1-d29b-e477-b273-75945c25583d",
			inheritedOverwrites =
			{
				name = "[Draw] Blade Draw",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5fac3769-211d-4e2d-0d5e-9b23aabb3119",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ThrillOfBattle",
							uuid = "d3024d80-2904-4678-bc21-de228bff6307",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 44.8,
				name = "[WAR] Thrill",
				timeRange = true,
				timelineIndex = 10,
				timerEndOffset = -15,
				timerOffset = -21,
				timerStartOffset = -20,
				uuid = "2dfcd900-24da-c320-af1c-110cbfbbb41c",
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
							aType = "ACR",
							conditions =
							{

								{
									"192d11e9-b5af-11cb-b659-bd8486c004dc",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "7d4db4d2-6131-fc1f-ac58-eefd099a0f86",
							variableTogglesType = 3,
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
							inRangeValue = 29.5,
							partyTargetNumber = 8,
							partyTargetSubType = "Number",
							uuid = "192d11e9-b5af-11cb-b659-bd8486c004dc",
							version = 3,
						},
					},
				},
				mechanicTime = 44.8,
				name = "[WAR] Shake",
				timelineIndex = 10,
				timerOffset = -14,
				timerStartOffset = 1,
				uuid = "ffe81fbc-7330-bebe-aec3-2c1212af71b4",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							name = "Damnation",
							uuid = "1e8cfc46-27d0-31cd-b3f3-bbedbe63f3b3",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 44.8,
				name = "[WAR] Damnation",
				timelineIndex = 10,
				timerOffset = -1,
				uuid = "70353076-8cdd-4731-b0ca-14d32938e288",
				version = 2,
			},
		},
	},
	[11] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8d6bbf70-37a7-c4c4-7da3-1a42a030c7e0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[12] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "2d633eb7-d9f9-d7db-5428-df95ba5c10e7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[13] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "bf4d5f16-d476-555a-2bf3-f06c00281586",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[14] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "20d88dea-018c-1ab6-240c-a9fc848985ba",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Execution Warning",
				uuid = "fa3d6061-5449-3f60-bef6-d16985ba8fb8",
				version = 2,
			},
			inheritedObjectUUID = "587d38ef-6dbf-fe1e-865b-f1654686e510",
			inheritedOverwrites =
			{
				name = "[Draw] Execution Warning",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1d4be135-9053-6641-7e0d-bf97649d6165",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7538,
							conditions =
							{

								{
									"8b5b5413-405c-dddc-bee7-1940fad2a06f",
									true,
								},

								{
									"44f62da1-3f7a-98cc-b917-ec98695fe807",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Interject Adelphel",
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "d043b58d-b22f-dc40-8ae6-2fe23c29aefc",
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
							eventSpellID = 25296,
							name = "E - 69.1 Holiest Hallowing",
							uuid = "8b5b5413-405c-dddc-bee7-1940fad2a06f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							eventArgOptionType = 2,
							eventEntityContentID = 3634,
							name = "E - 69.1 Ser Adelphel",
							uuid = "44f62da1-3f7a-98cc-b917-ec98695fe807",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 69.1,
				name = "[WAR] Interrupt 1",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "9e279d6a-8022-a0d2-947d-9af512f2509b",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Holmgang",
							uuid = "b1641805-e51c-9dc9-a92d-e476e4c1236c",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 69.1,
				name = "[WAR] Holmgang",
				timelineIndex = 14,
				timerOffset = -6,
				uuid = "0e53aefb-b425-4d36-a077-ee106ea5b803",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "b1641805-e51c-9dc9-a92d-e476e4c1236c",
							variableTogglesType = 3,
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "c4ac4fcf-af8b-16c1-a1fd-e5789cbda10e",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 69.1,
				name = "[WAR] Bloodwhetting + Equilibrium",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 3,
				timerOffset = 0.5,
				timerStartOffset = 0.5,
				uuid = "34c6f692-ee9f-5df4-aba0-7e49db731db9",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							gVar = "ACR_RikuWAR3_Jumps",
							gVarValue = 2,
							holdActionCharges = 3,
							holdActionDuration = 16,
							holdActionID = 7386,
							uuid = "2bb8a3c5-76a8-2469-96e6-e686166d2733",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 16,
							holdActionID = 25753,
							uuid = "2f5036d1-7e86-c520-b7d3-e5067fb77e3c",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 69.1,
				name = "[WAR] Hold Onslaught 3 + Rend",
				timelineIndex = 14,
				timerOffset = -15,
				uuid = "c11f8314-2482-81e8-8169-93e566cab646",
				version = 2,
			},
		},
	},
	[15] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "8d0ea723-e30a-f13f-4fe0-9f95761be8b3",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Symbol Capture",
				uuid = "1a746914-5bd4-2961-85b6-2ccf16a57141",
				version = 2,
			},
			inheritedObjectUUID = "8586edac-a1b3-98f4-a4de-bf5906381d18",
			inheritedOverwrites =
			{
				name = "[Draw] Symbol Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Symbol Guidance",
				uuid = "b717c9f9-ba32-3d93-8cc2-2467e2847cd2",
				version = 2,
			},
			inheritedObjectUUID = "a6ea40a2-70cb-f04b-a9ec-b956da1e86a3",
			inheritedOverwrites =
			{
				name = "[Draw] Symbol Guidance",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "35c2560c-3705-5b68-3c57-15f6af21987c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionLua = "TensorCore.sendParsedChatMessage('/statusoff \"Inner Strength\"')\nself.used = true",
							name = "Remove Inner Strength",
							uuid = "9cacda9e-4a34-5a82-bd03-7da08087ad85",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 86.2,
				name = "[WAR] Inner Strength Off",
				timelineIndex = 15,
				timerOffset = -1,
				uuid = "39b7bcae-c18c-5187-97a5-262239f8b3b6",
				version = 2,
			},
		},
	},
	[16] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "51265043-db43-610f-33d9-d3c9e6c99cf3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Interrupt 2nd if up",
				uuid = "4be92edc-ddf1-2b99-95d2-8574ead80452",
				version = 2,
			},
			inheritedObjectUUID = "5ae0fa75-4b7f-d85f-b5d2-a4f1aea6df26",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							name = "Rampart",
							uuid = "23eb2f18-8fe8-c687-955f-33794b4257c2",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 88.2,
				name = "[WAR] Rampart",
				timelineIndex = 16,
				timerOffset = -2,
				uuid = "ba924dab-c2e8-f6b5-a45b-371aee81b3a0",
				version = 2,
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
				uuid = "38c25de2-e3e8-d2ce-67a9-fe50b7846f52",
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
				uuid = "f376c481-af12-5ef5-d528-1bfb89f08df1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Interrupt",
				uuid = "a27aada8-3329-9a0b-ae28-4172c6cd104e",
				version = 2,
			},
			inheritedObjectUUID = "206a46c8-36c3-38c5-a988-045d41807bfb",
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
							actionID = 7538,
							conditions =
							{

								{
									"fb014904-a7fc-e54e-8914-02bea883c7cd",
									true,
								},

								{
									"8b088a14-26b3-faa6-9e00-fc434f0e1e83",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Interject Adelphel",
							targetContentID = 3634,
							targetType = "ContentID",
							uuid = "0f550b8f-82f0-4fde-826d-4ea97c9b6a1b",
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
							eventSpellID = 25296,
							name = "E - 104.2 Holiest Hallowing",
							uuid = "fb014904-a7fc-e54e-8914-02bea883c7cd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							eventArgOptionType = 2,
							eventEntityContentID = 3634,
							name = "E - 104.2 Ser Adelphel",
							uuid = "8b088a14-26b3-faa6-9e00-fc434f0e1e83",
							version = 3,
						},
					},
				},
				eventType = 3,
				mechanicTime = 104.2,
				name = "[WAR] Interrupt 3",
				timeRange = true,
				timelineIndex = 18,
				timerEndOffset = 10,
				timerStartOffset = -10,
				uuid = "0995a165-d668-b69f-b485-2a8e0683b47c",
				version = 2,
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
				uuid = "b7cb7545-6261-0e49-0e14-333b0b888f75",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
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
							aType = "ACR",
							conditions =
							{

								{
									"351a7414-ff5f-e8a4-9cb0-6f2f850989fa",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "Reprisal",
							uuid = "7788ee05-a690-59c1-a236-cd99bf3f7d18",
							variableTogglesType = 3,
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
							comparator = 2,
							conditionLua = "local e=TensorCore.mGetEntity(eventArgs.detectionTargetID)\nlocal p=TensorCore.mGetPlayer()\nif not e or not e.targetable or not p then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz<=(e.hitradius+5)^2",
							conditionType = 4,
							inRangeValue = 5,
							name = "Targetable + in range",
							partyTargetType = "Detection Target",
							uuid = "bf773e3d-47e5-280d-8876-02d75f463b35",
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
									"bf773e3d-47e5-280d-8876-02d75f463b35",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Ser Adelphel",
							partyTargetContentID = 3634,
							uuid = "351a7414-ff5f-e8a4-9cb0-6f2f850989fa",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 2,
							hpValue = 10,
							partyTargetType = "Detection Target",
							uuid = "da29e62e-6007-08f2-9bc8-a6101c3fe6ae",
							version = 3,
						},
					},
				},
				mechanicTime = 133.6,
				name = "[WAR] Reprisal 2",
				timeRange = true,
				timelineIndex = 23,
				timerEndOffset = -1,
				timerStartOffset = -5,
				uuid = "95e7c109-18cd-9961-9236-6ee96174e71f",
				version = 2,
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
				uuid = "a9bee3c0-5a7b-2aec-50fb-0d2e8ab7a6b0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[25] =
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
									"8a052370-3658-3fcb-b91c-206ea08a24fb",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "387c0265-d743-6ffe-ae23-0ca1dfc755a0",
							variableTogglesType = 3,
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
							channelCheckSpellID = 25316,
							conditionType = 5,
							name = "Pure of Heart",
							partyTargetType = "Detection Target",
							uuid = "2bfbeca9-432d-c8da-8e2a-366b5d120306",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckTimeRemain = 3,
							channelCheckType = 3,
							comparator = 2,
							conditionType = 5,
							name = "Cast <=3s",
							partyTargetType = "Detection Target",
							uuid = "ad13f61c-25fa-0c37-9a02-1557587d6bbb",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							comparator = 2,
							conditionType = 4,
							inRangeValue = 5,
							name = "Hitbox +5",
							partyTargetType = "Detection Target",
							uuid = "fa1b30b8-46cc-f8c2-916b-ca44e50d8d48",
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
									"2bfbeca9-432d-c8da-8e2a-366b5d120306",
									true,
								},

								{
									"ad13f61c-25fa-0c37-9a02-1557587d6bbb",
									true,
								},

								{
									"fa1b30b8-46cc-f8c2-916b-ca44e50d8d48",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Charibert",
							partyTargetContentID = 3642,
							uuid = "8a052370-3658-3fcb-b91c-206ea08a24fb",
							version = 3,
						},
					},
				},
				mechanicTime = 200,
				name = "[WAR] Reprisal Pure",
				timeRange = true,
				timelineIndex = 25,
				timerEndOffset = 40,
				timerOffset = -2,
				uuid = "46eb7d8d-962b-5e9e-86a0-39e49e666aa7",
				version = 2,
			},
		},
	},
	[27] =
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
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "4f363b12-c320-3cbd-a6a3-cddc46341e4e",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 210,
				name = "[WAR] Shake",
				timelineIndex = 27,
				timerOffset = 0.5,
				uuid = "16b2553c-3631-bd62-b3a2-8c935cb9645c",
				version = 2,
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
				uuid = "5f75f1fd-a5ff-9261-68f6-0d637d937ead",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[31] =
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
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_NascentFlashMouse",
							name = "NF Mouse - Caster",
							targetType = "Ranged Caster DPS",
							uuid = "45b3bbb4-6152-18a0-87ed-fc36dcb1beef",
							variableIsHover = true,
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 225.9,
				name = "[WAR] Nascent Caster",
				timelineIndex = 31,
				timerOffset = -1,
				uuid = "805e0f69-78e9-7fd2-a744-9195d37773e4",
				version = 2,
			},
		},
	},
	[35] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "599e7c3a-5bc2-a7c6-bea7-4858ff1bf9ea",
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
				uuid = "ed22b68d-bcf4-cf59-3295-3fbfa9df6b3d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[38] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "07127e14-e3be-9bf8-c01b-b17209d6e1e4",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6a20cbd7-5f34-740b-d99f-f66525c6cb87",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[40] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "489f294a-bcb3-ccc6-5e48-fe0c1d11e87a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[43] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8862729d-1de5-f459-79ac-f8435759eacd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Holmgang",
							uuid = "7e864069-72d8-77f1-9254-87dbc6b4ec89",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 306.4,
				name = "[WAR] Holmgang",
				timelineIndex = 43,
				timerOffset = -9,
				uuid = "9e34d0a0-935c-29f7-aeec-581ef780f3a1",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "ddff97d7-8e15-d12d-9140-1d85c5ceb870",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 306.4,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 43,
				timerOffset = -1,
				uuid = "fe0b3253-92f4-00f2-af80-a07b583978cd",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "e5abdf51-6e09-0320-8427-560d856bdeb4",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 306.4,
				name = "[WAR] Equilibrium",
				timelineIndex = 43,
				timerOffset = 0.5,
				uuid = "0adeb55e-f2da-b5c5-805d-6f7b3bd5ef9c",
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
				name = "store\\anyone\\dsw\\universal",
				uuid = "0a0e97bf-5505-c933-8832-df69eab82c2f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_ShirkOT",
							uuid = "ed4ed7c7-e0fe-68cb-bc87-cc4e27dbeee0",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 317.5,
				name = "[WAR] Shirk OT",
				timelineIndex = 45,
				uuid = "e3ffe5ba-918a-2c0f-949d-56d66392dfd9",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog",
				uuid = "fc835306-33ee-df63-8215-5123fc8a6fbc",
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
							actionLua = "-- Only actual hide-and-reappear events arm the Strength callout.\ndata.frog_strength_marker_v2 = data.frog_strength_marker_v2 or {hidden={}, visible={}, ids={}}\nlocal s = data.frog_strength_marker_v2\nif s.called then self.used = true return end\nlocal cid = eventArgs.entityContentID\ns.ids[cid] = eventArgs.entityID\ns.visible[cid] = eventArgs.isVisible\nif not eventArgs.isVisible then s.hidden[cid] = true end\nif not s.hidden[3634] or not s.hidden[3635] or not s.visible[3634] or not s.visible[3635] then\n    self.used = true\n    return\nend\nlocal adelphel = TensorCore.mGetEntity(s.ids[3634])\nlocal janlenoux = TensorCore.mGetEntity(s.ids[3635])\nif not adelphel or not janlenoux then return end\nlocal nx = 100 - (adelphel.pos.x + janlenoux.pos.x) / 2\nlocal nz = 100 - (adelphel.pos.z + janlenoux.pos.z) / 2\nlocal radius = math.sqrt(nx * nx + nz * nz)\nif radius < 1 then return end\nnx, nz = nx / radius, nz / radius\nlocal ex, ez = -nz, nx\nlocal aSide = (adelphel.pos.x - 100) * ex + (adelphel.pos.z - 100) * ez\nlocal jSide = (janlenoux.pos.x - 100) * ex + (janlenoux.pos.z - 100) * ez\nif math.abs(aSide - jSide) < 1 then return end\nlocal px, pz = 100 + nx * 23, 100 + nz * 23\nlocal nearest, best\nfor id = 1, 8 do\n    local x, y, z, active = Argus.getWaymarkInfo(id)\n    if active then\n        local mx, mz = x - px, z - pz\n        local distance = mx * mx + mz * mz\n        if not best or distance < best then\n            nearest, best = id, distance\n        end\n    end\nend\nif not nearest then s.called = true\nself.used = true return end\nlocal labels = \"ABCD1234\"\nlocal marker = labels:sub(nearest, nearest)\nTensorCore.addAlertText(8000, \"Thordan: \" .. marker, 1.5, 2, false)\nTensorCore.sendTTS(\"Thordan at \" .. marker)\ns.called = true\nself.used = true",
							conditions =
							{

								{
									"203b0169-6994-defa-8e1a-973faaf83d95",
									true,
								},
							},
							name = "Track Adelphel appearance",
							uuid = "480dfee7-67b7-6c9b-ae79-49ecced7ee5c",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "-- Only actual hide-and-reappear events arm the Strength callout.\ndata.frog_strength_marker_v2 = data.frog_strength_marker_v2 or {hidden={}, visible={}, ids={}}\nlocal s = data.frog_strength_marker_v2\nif s.called then self.used = true return end\nlocal cid = eventArgs.entityContentID\ns.ids[cid] = eventArgs.entityID\ns.visible[cid] = eventArgs.isVisible\nif not eventArgs.isVisible then s.hidden[cid] = true end\nif not s.hidden[3634] or not s.hidden[3635] or not s.visible[3634] or not s.visible[3635] then\n    self.used = true\n    return\nend\nlocal adelphel = TensorCore.mGetEntity(s.ids[3634])\nlocal janlenoux = TensorCore.mGetEntity(s.ids[3635])\nif not adelphel or not janlenoux then return end\nlocal nx = 100 - (adelphel.pos.x + janlenoux.pos.x) / 2\nlocal nz = 100 - (adelphel.pos.z + janlenoux.pos.z) / 2\nlocal radius = math.sqrt(nx * nx + nz * nz)\nif radius < 1 then return end\nnx, nz = nx / radius, nz / radius\nlocal ex, ez = -nz, nx\nlocal aSide = (adelphel.pos.x - 100) * ex + (adelphel.pos.z - 100) * ez\nlocal jSide = (janlenoux.pos.x - 100) * ex + (janlenoux.pos.z - 100) * ez\nif math.abs(aSide - jSide) < 1 then return end\nlocal px, pz = 100 + nx * 23, 100 + nz * 23\nlocal nearest, best\nfor id = 1, 8 do\n    local x, y, z, active = Argus.getWaymarkInfo(id)\n    if active then\n        local mx, mz = x - px, z - pz\n        local distance = mx * mx + mz * mz\n        if not best or distance < best then\n            nearest, best = id, distance\n        end\n    end\nend\nif not nearest then s.called = true\nself.used = true return end\nlocal labels = \"ABCD1234\"\nlocal marker = labels:sub(nearest, nearest)\nTensorCore.addAlertText(8000, \"Thordan: \" .. marker, 1.5, 2, false)\nTensorCore.sendTTS(\"Thordan at \" .. marker)\ns.called = true\nself.used = true",
							conditions =
							{

								{
									"d28923fd-b34f-4209-9c40-e7945260d6be",
									true,
								},
							},
							name = "Track Janlenoux appearance",
							uuid = "f78e175e-f89d-ee17-a37a-fd82e3c23e58",
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
							eventSpellID = 25555,
							name = "Adelphel visibility",
							uuid = "203b0169-6994-defa-8e1a-973faaf83d95",
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
							uuid = "d28923fd-b34f-4209-9c40-e7945260d6be",
							version = 3,
						},
					},
				},
				displayPath = "Frog",
				eventType = 22,
				loop = true,
				mechanicTime = 317.5,
				name = "Thordan Marker",
				timeRange = true,
				timelineIndex = 45,
				timerEndOffset = 30,
				timerStartOffset = -2,
				uuid = "f27efa68-4a64-d742-bef4-cc63158a8a5c",
				version = 2,
			},
		},
	},
	[46] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9620a058-07da-64bc-e7d4-0716042eb908",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							holdActionDuration = 15,
							holdActionID = 45,
							name = "Storm's Eye",
							uuid = "71e6cd99-27a2-b082-8fbf-231c8f6c30d8",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 320.6,
				name = "[WAR] Storm's Eye",
				timelineIndex = 46,
				timerOffset = -7,
				uuid = "9b461bb7-a96d-4900-9d82-25465db024f4",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							conditions =
							{

								{
									"3aa41e1d-0da6-4835-b60f-f401e404dcfa",
									true,
								},
							},
							holdActionDuration = 34.299999237061,
							holdActionID = 52,
							name = "Hold 1 Infuriate",
							uuid = "5d89d7f9-efac-27b3-b130-bc29c40e2527",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							actionCDValue = 31.3,
							actionID = 52,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Infuriate CD <= 31.3s",
							uuid = "3aa41e1d-0da6-4835-b60f-f401e404dcfa",
							version = 3,
						},
					},
				},
				mechanicTime = 320.6,
				name = "[WAR] Hold Infuriate",
				timelineIndex = 46,
				timerOffset = -3,
				uuid = "8d92e7f0-3d05-6b73-9e89-b180a421ca92",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							name = "Defiance Off",
							uuid = "9a6ee4f5-ebb9-0146-9bfd-9dfeecd35247",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 320.6,
				name = "[WAR] Defiance Off",
				timelineIndex = 46,
				timerOffset = -0.60000002384186,
				uuid = "0f4ed527-6bdf-6162-9d3c-e210b004cae0",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_Onslaught",
							uuid = "730b31da-eaa8-f5e5-a1e6-e0f856a4a201",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 320.6,
				name = "[WAR] Burn Onslaught",
				timeRange = true,
				timelineIndex = 46,
				timerStartOffset = -7.5,
				uuid = "3931e36d-50ca-6c11-8429-ec15850c9e87",
				version = 2,
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
				uuid = "334589f3-f507-c3ff-d560-de6d9be9afa3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[50] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "48b9d0d2-e83f-f10e-892b-bfb4a0851a22",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Tether Capture",
				uuid = "36857bb0-bb9c-abe1-bdeb-a669ccd1c8cb",
				version = 2,
			},
			inheritedObjectUUID = "05a626e0-a6e5-8337-b4df-85aaf4f08d2f",
			inheritedOverwrites =
			{
				name = "[Draw] Tether Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Knight Guidance",
				uuid = "6fd4e933-0bfc-efe3-993b-cbe1fda8ff80",
				version = 2,
			},
			inheritedObjectUUID = "52ad2556-54fb-1211-8925-7b8a895ed059",
			inheritedOverwrites =
			{
				name = "[Draw] Knight Guidance",
			},
		},

		{
			data =
			{
				name = "[Draw] Defamation Capture",
				uuid = "e8f6734a-2479-7237-af5a-c4a0e39d7566",
				version = 2,
			},
			inheritedObjectUUID = "ab430d1d-e935-6288-909f-9fda143ffeb4",
			inheritedOverwrites =
			{
				name = "[Draw] Defamation Capture",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ca0f6bad-b6ba-19e9-fbb4-279f97f77add",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw line to Warrior for alignment",
				uuid = "b2438d75-da67-faba-bf97-f166eb692fd4",
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
				actions =
				{

					{
						data =
						{
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_Sprint",
							uuid = "8312d7dc-d8b4-904e-bebd-b76fd1aa5c2c",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 335.3,
				name = "[WAR] Sprint",
				timelineIndex = 50,
				uuid = "ad863342-9824-1d30-b62f-3606665341c4",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "51c3d8e3-374c-8abd-b21c-bf9989195ead",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 335.3,
				name = "[WAR] Shake",
				timelineIndex = 50,
				uuid = "f54a139a-10c5-3039-a107-89229da68d3a",
				version = 2,
			},
		},
	},
	[54] =
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
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "e5f5e9e6-b0f0-f95a-85be-a597dbb187fe",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 346.8,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 54,
				timerOffset = -2,
				uuid = "33da91a5-7fe1-5559-83ba-58ced122e670",
				version = 2,
			},
		},
	},
	[55] =
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
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "284fcd59-2f3f-5806-980d-5ab1e61b21ad",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 348.9,
				name = "[WAR] Rampart",
				timelineIndex = 55,
				timerOffset = -15,
				uuid = "4a07f1a6-3bc4-7f8b-aafc-0d6299019a52",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "c90f46d9-518f-45b0-a81c-7d941ac86a12",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 348.9,
				name = "[WAR] Damnation",
				timelineIndex = 55,
				timerOffset = -10,
				uuid = "ff2e13a6-1e8c-25e5-9cb2-52cd51cf315c",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ThrillOfBattle",
							uuid = "1abde240-ce0e-9f3b-a486-dea7d761f93d",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 348.9,
				name = "[WAR] Thrill",
				timelineIndex = 55,
				timerOffset = -7,
				uuid = "2ac96f2d-8cb8-08e3-9d82-1281a651d8d3",
				version = 2,
			},
		},
	},
	[56] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "84357e8f-a834-32c3-87fc-99fdf41a78ff",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[57] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8cdaf04e-8fd0-4062-e9d9-38d402bc9f3e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "195a0f22-02fa-72bc-abd3-380fe7c7fe0d",
							variableTogglesType = 3,
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
							name = "F - Thordan",
							partyTargetContentID = 3632,
							uuid = "90915851-d686-0096-bcd1-f65fd20c94c7",
							version = 3,
						},
					},
				},
				mechanicTime = 351.9,
				name = "[WAR] Upheaval 1",
				timelineIndex = 57,
				timerOffset = 3,
				uuid = "3f6f0dca-11e6-be30-9310-bccb82eea227",
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
							aType = "ACR",
							conditions =
							{

								{
									"58e75949-b16f-b4bc-b920-5b1d3d47b407",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Onslaught",
							name = "Onslaught - Thordan",
							uuid = "516c77e2-cbb6-40eb-9bcf-58395b75d699",
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
							category = "Filter",
							filterTargetType = "ContentID",
							name = "F - Thordan",
							partyTargetContentID = 3632,
							uuid = "58e75949-b16f-b4bc-b920-5b1d3d47b407",
							version = 3,
						},
					},
				},
				mechanicTime = 351.9,
				name = "[WAR] Onslaught",
				timelineIndex = 57,
				timerOffset = -0.5,
				uuid = "d5a7430b-1d35-63b5-a023-e0c4b6955124",
				version = 2,
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
				uuid = "58047c75-4a84-a701-4a4e-d34764c4afa5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[62] =
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
							gVar = "ACR_RikuWAR3_Hotbar_Provoke",
							uuid = "35db7c40-fe01-b67a-a58a-a49123f119ff",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 374.6,
				name = "[WAR] Provoke",
				timelineIndex = 62,
				uuid = "fce6df51-005f-038f-ba14-5aea39c307a3",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "af327e36-56e5-e134-a193-611b739e9293",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 374.6,
				name = "[WAR] Defiance On",
				timelineIndex = 62,
				timerOffset = -2,
				uuid = "d0686253-2a3d-b7c0-9f2f-73ea00292967",
				version = 2,
			},
		},
	},
	[64] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "6b666ec3-571a-3787-7bd2-84f9b9fd01d3",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Flex Capture",
				uuid = "e88a9d9a-fc1a-f29e-b1f0-e39bf53c31a1",
				version = 2,
			},
			inheritedObjectUUID = "11f879ce-31b8-c5ff-b031-b1e7b4f637f3",
			inheritedOverwrites =
			{
				name = "[Draw] Flex Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Flex Tether",
				uuid = "225fac77-d6d1-d22f-913c-a1448279de42",
				version = 2,
			},
			inheritedObjectUUID = "4303064e-5ceb-e4e2-92fd-d41e4472795e",
			inheritedOverwrites =
			{
				name = "[Draw] Flex Tether",
			},
		},

		{
			data =
			{
				name = "[Draw] Predictive Capture",
				uuid = "df7fe0d0-f8eb-43e0-9d84-8093cc4ac797",
				version = 2,
			},
			inheritedObjectUUID = "8fe74c06-fd1a-6294-b637-aa9e1e29ea7d",
			inheritedOverwrites =
			{
				name = "[Draw] Predictive Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Predictive Cutouts",
				uuid = "6d664d8e-5c27-cebd-a42a-d7181cf3abb2",
				version = 2,
			},
			inheritedObjectUUID = "85dccc92-0e0c-fedc-9848-393300427559",
			inheritedOverwrites =
			{
				name = "[Draw] Predictive Cutouts",
			},
		},

		{
			data =
			{
				name = "[Draw] Sword Capture",
				uuid = "e75dcd73-3159-1575-9d74-3a112570377d",
				version = 2,
			},
			inheritedObjectUUID = "cc0414f0-aecf-112f-8446-ba032223805a",
			inheritedOverwrites =
			{
				name = "[Draw] Sword Capture",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "036d486c-00cc-c640-de94-3f428b0b0c5c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
				uuid = "2ba23795-652e-1ef9-6e4f-c0230a5e6345",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							holdActionDuration = 15,
							holdActionID = 45,
							name = "Storm's Eye",
							uuid = "f8211235-f17e-8331-bd4c-572ec0e21264",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 388.7,
				name = "[WAR] Storm's Eye",
				timelineIndex = 65,
				timerOffset = -7,
				timerStartOffset = -7,
				uuid = "867f1548-1a6f-7092-af42-fb38458d8094",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							conditions =
							{

								{
									"8eb29322-0eda-2361-a0b9-4a37e758e40b",
									true,
								},
							},
							holdActionDuration = 53.5,
							holdActionID = 52,
							name = "Hold 1 Infuriate",
							uuid = "c323fa68-2c89-1e0a-9805-4701febe33a2",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							actionCDValue = 50.5,
							actionID = 52,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Infuriate CD <= 50.5s",
							uuid = "8eb29322-0eda-2361-a0b9-4a37e758e40b",
							version = 3,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[WAR] Hold Infuriate",
				timelineIndex = 65,
				timerOffset = -3,
				uuid = "bf272fe2-c472-0fab-b6ad-81029b533ae3",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_ForceAOE",
							name = "Force AOE On",
							uuid = "11cde8ee-509b-f15b-9789-c97bf9d5e3f7",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 388.7,
				name = "[WAR] Force AOE On",
				timelineIndex = 65,
				timerOffset = -5,
				uuid = "e9fa927b-0e65-c3d0-a51d-9cf8af385475",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_ForceAOE",
							gVarValue = 2,
							name = "Force AOE Off",
							uuid = "3186d2f0-582f-b297-be6d-e04fb34b9381",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 388.7,
				name = "[WAR] Force AOE Off",
				timelineIndex = 65,
				uuid = "8e372f52-cfc1-d6ee-b5fc-8ec3ca9622fa",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_Onslaught",
							uuid = "38c31a30-7dc8-b8b1-a7ac-8660101fb0da",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				loop = true,
				mechanicTime = 388.7,
				name = "[WAR] Burn Onslaught",
				timeRange = true,
				timelineIndex = 65,
				timerStartOffset = -7.5,
				uuid = "b1c2eff1-5e3f-98e5-8b5d-894b9990fe39",
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
							actionID = 16465,
							conditions =
							{

								{
									"fb19cd3c-40a4-1ca0-8a64-d3d69f492a8b",
									true,
								},

								{
									"7fd5d150-6a86-f34d-a382-c88b8b13b0eb",
									true,
								},

								{
									"582257ea-0d54-560a-8378-189639c57528",
									true,
								},
							},
							endIfUsed = true,
							targetType = "Current Target",
							uuid = "efca2360-3141-8f6a-9e4d-92ea84be2dba",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 3549,
							conditions =
							{

								{
									"fb19cd3c-40a4-1ca0-8a64-d3d69f492a8b",
									true,
								},

								{
									"7fd5d150-6a86-f34d-a382-c88b8b13b0eb",
									true,
								},

								{
									"582257ea-0d54-560a-8378-189639c57528",
									false,
								},

								{
									"f7c91536-7da3-a830-9e72-c883ced32747",
									false,
								},
							},
							endIfUsed = true,
							targetType = "Current Target",
							uuid = "ab2812c0-fdb3-2c07-8f27-510187cfc29e",
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
							dequeueIfLuaFalse = true,
							jobIDList =
							{
								21,
							},
							name = "WAR",
							uuid = "fb19cd3c-40a4-1ca0-8a64-d3d69f492a8b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 6,
							gaugeValue = 100,
							name = "100 gauge",
							uuid = "7fd5d150-6a86-f34d-a382-c88b8b13b0eb",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 1897,
							category = "Self",
							name = "Nascent Chaos",
							uuid = "582257ea-0d54-560a-8378-189639c57528",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 1177,
							category = "Self",
							name = "Inner Release",
							uuid = "f7c91536-7da3-a830-9e72-c883ced32747",
							version = 3,
						},
					},
				},
				mechanicTime = 388.7,
				name = "[WAR] Dump Gauge",
				timeRange = true,
				timelineIndex = 65,
				timerEndOffset = -7,
				timerStartOffset = -10,
				uuid = "9b12b5f3-61bd-54ba-95c2-bfcd4af5e5ae",
				version = 2,
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
				uuid = "551c7242-ce15-eae6-8ce5-156c7a0c95b2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[68] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "2aaa3ed7-76f7-be33-b194-312dacaa6027",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Orb Cutouts",
				uuid = "2cdf5fa8-17ce-fc6a-8f73-a0f80bd7afc4",
				version = 2,
			},
			inheritedObjectUUID = "14d46326-3012-9e0a-b3eb-969d25e1f037",
			inheritedOverwrites =
			{
				name = "[Draw] Orb Cutouts",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4d1cfc88-1860-7354-993e-83ee70197c38",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
				uuid = "9d06c1b3-9700-086f-ef5e-b9d993025363",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw Tower Splits",
				uuid = "88691000-90f0-6905-9305-ae6d329c02b2",
				version = 2,
			},
			inheritedObjectUUID = "01a71a79-c32d-a5aa-9ce1-d95e77569110",
			inheritedOverwrites =
			{
				displayPath = "store\\anyone\\dsw\\universal",
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
				uuid = "3659aac1-8910-ee5d-c7a4-47479e6ea7d1",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] First Tower Guidance",
				uuid = "112d788c-f1d1-141c-8815-99da9166a39d",
				version = 2,
			},
			inheritedObjectUUID = "f18b26ef-d7aa-1e0e-b741-b6ecc895ac05",
			inheritedOverwrites =
			{
				name = "[Draw] First Tower Guidance",
			},
		},

		{
			data =
			{
				name = "[Draw] Meteor Capture",
				uuid = "81c44a23-b046-79d7-9e6f-5e320b8dbc43",
				version = 2,
			},
			inheritedObjectUUID = "498c2fd9-a02e-6116-9369-2e3a0cfc0c9c",
			inheritedOverwrites =
			{
				name = "[Draw] Meteor Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Role Guidance",
				uuid = "38b26f7c-8d58-a117-a0a0-d96e8a899cee",
				version = 2,
			},
			inheritedObjectUUID = "7b4a11b0-76e6-6cbe-8c69-aaf2050b2095",
			inheritedOverwrites =
			{
				name = "[Draw] Role Guidance",
			},
		},

		{
			data =
			{
				name = "[Draw] Tower Capture",
				uuid = "d7848b2a-6f9a-d413-b679-937d4aa9d081",
				version = 2,
			},
			inheritedObjectUUID = "4dde1532-92e5-0a36-94a9-9e9d4c181757",
			inheritedOverwrites =
			{
				name = "[Draw] Tower Capture",
			},
		},
	},
	[72] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "d740d9da-8e07-9756-4de6-2accb76322ea",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Final Tower Guidance",
				uuid = "c3e1eeda-23f1-d13f-aa29-193ff9dd4581",
				version = 2,
			},
			inheritedObjectUUID = "1c044c55-6bb8-9ccd-a337-8f72be56725b",
			inheritedOverwrites =
			{
				name = "[Draw] Final Tower Guidance",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "adb2f325-79d1-e7a1-860f-baa7980cc9d5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
				uuid = "4fdb5d3c-9799-2d48-8e2c-92462f2661ac",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[75] =
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
							actionLua = "TensorCore.sendParsedChatMessage('/p KNOCKBACK RESIST <se.2>')\nself.used = true",
							name = "Party Chat - Knockback Resist",
							uuid = "3ef9da8a-110b-3cfc-b0d0-3d48f673abbc",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				enabled = false,
				mechanicTime = 425.8,
				name = "[WAR] Knockback Resist",
				randomTimeout = 3,
				timeRandomRange = true,
				timeRange = true,
				timelineIndex = 75,
				timerEndOffset = 2,
				timerOffset = 0.25,
				uuid = "5ae409b7-f371-f242-aefe-78a50d02f784",
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
				name = "store\\anyone\\dsw\\universal",
				uuid = "fa72c90e-ae9d-c2f2-14b2-7f88120811fe",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[81] =
	{

		{
			data =
			{
				actions =
				{

					{
						data =
						{
							actionID = 7389,
							conditions =
							{

								{
									"87fb4033-d102-4166-90c2-d83fd6a19fd4",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Inner Release",
							uuid = "5bf66c34-2046-ad85-bbd9-186eb6a497ce",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7389,
							conditions =
							{

								{
									"b391cd3d-33e0-9718-bc1e-509467371ffc",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Safety Inner Release",
							uuid = "3b56813b-d4c5-59e9-a8b9-5cc97929ab9f",
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
							buffDuration = 10,
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye >=10s",
							uuid = "87fb4033-d102-4166-90c2-d83fd6a19fd4",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return TensorReactions_CurrentTimer>=436.7",
							name = "Conviction +2s",
							uuid = "b391cd3d-33e0-9718-bc1e-509467371ffc",
							version = 3,
						},
					},
				},
				mechanicTime = 434.7,
				name = "[WAR] Inner Release",
				timeRange = true,
				timelineIndex = 81,
				timerEndOffset = 10,
				uuid = "01d95275-0363-af48-ae0a-76990cdaafb0",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "1cb5da37-68ff-fa4b-d987-78cd321fed07",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a44582a8-66b7-169c-d75c-39eee8b38e58",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7387,
							atomicPriority = true,
							targetType = "Current Target",
							uuid = "d7a8753c-4265-c493-9e45-63287165aaa2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 439.2,
				name = "[WAR] Upheaval 2",
				timelineIndex = 82,
				uuid = "d94d881b-151e-6948-a44f-9407505e822b",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							conditions =
							{

								{
									"9e9cb498-9743-4958-a2bd-5addb14dff29",
									true,
								},
							},
							holdActionDuration = 10,
							holdActionID = 25753,
							uuid = "6760bfd0-b4c9-468f-a82a-7e1f309b046e",
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
							dequeueIfLuaFalse = true,
							jobIDList =
							{
								21,
							},
							name = "WAR",
							uuid = "9e9cb498-9743-4958-a2bd-5addb14dff29",
							version = 3,
						},
					},
				},
				mechanicTime = 439.2,
				name = "[WAR] Rend Hold",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 0.5,
				uuid = "dbc9e56d-9f8e-440e-a5e9-9f8c1d46b180",
				version = 2,
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
				uuid = "d893da9a-b703-9aa6-97a1-06e49b32174a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"6fc56c7f-4ac4-65bb-852a-5fa43feaa34b",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "2846850e-13dc-91a8-9a18-ecb2d55b0d1f",
							variableTogglesType = 3,
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
							filterTargetType = "ContentID",
							inRangeValue = 30,
							name = "All 8 within 30y",
							partyTargetContentID = 3632,
							partyTargetNumber = 8,
							partyTargetSubType = "Number",
							uuid = "6fc56c7f-4ac4-65bb-852a-5fa43feaa34b",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[WAR] Shake",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -1,
				timerStartOffset = -18,
				uuid = "055d66c8-df69-ee66-ab74-9b948eb90cdf",
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
							aType = "ACR",
							conditions =
							{

								{
									"833a6849-328a-c28f-b3a9-5d21553f52e1",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "cd68a4cc-b6cb-ed87-849d-147a739828f2",
							variableTogglesType = 3,
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
							conditions =
							{

								{
									"d781c4fb-2b9e-2b91-af8e-10ac0752573c",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "833a6849-328a-c28f-b3a9-5d21553f52e1",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							comparator = 2,
							conditionLua = "local id=eventArgs.detectionTargetID\nif not id then return false end\nlocal e=TensorCore.mGetEntity(id)\nlocal p=TensorCore.mGetPlayer()\nif not e or not p or not e.pos or not p.pos or not e.hitradius then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz <= (e.hitradius+4.5)^2",
							conditionType = 4,
							inRangeValue = 6,
							name = "Detection target hitbox +4.5y",
							partyTargetType = "Detection Target",
							uuid = "d781c4fb-2b9e-2b91-af8e-10ac0752573c",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "ee925652-68de-e687-8efc-d5cdb0755098",
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
							aType = "ACR",
							conditions =
							{

								{
									"669778be-1193-2cea-bcd0-87c3831275fa",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							uuid = "7e1591bd-142c-b6db-a1e6-e8686b65444a",
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
							category = "Filter",
							conditions =
							{

								{
									"ee37af8b-5266-9d92-a22a-51c304b746ab",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "669778be-1193-2cea-bcd0-87c3831275fa",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							comparator = 2,
							conditionType = 2,
							hpValue = 10,
							name = "Thordan HP <=10%",
							partyTargetType = "Detection Target",
							uuid = "ee37af8b-5266-9d92-a22a-51c304b746ab",
							version = 3,
						},
					},
				},
				mechanicTime = 452.7,
				name = "[WAR] Storm's Eye <10%",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 32.200000762939,
				uuid = "9d3da054-962e-d0ce-b332-14f670d51ac5",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Ultimate End Safety",
							uuid = "0b5f63bd-2db7-41d7-bec3-c4339c4c0804",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 452.7,
				name = "[WAR] Shake - Safety",
				timelineIndex = 84,
				timerOffset = -5,
				uuid = "224cc7c3-b0c3-e98f-b317-ef6bd2ddc30c",
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
							aType = "ACR",
							conditions =
							{

								{
									"61edfc80-de05-bc5d-8b0c-c8ab94ed25fb",
									true,
								},

								{
									"613b1da9-c943-f8d2-821c-550e5ba9d717",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "1d0912b6-92eb-6c6d-aafa-04ecc22c91d3",
							variableTogglesType = 3,
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
							eventEntityContentID = 3632,
							name = "King Thordan",
							uuid = "61edfc80-de05-bc5d-8b0c-c8ab94ed25fb",
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
							name = "Thordan Untargetable",
							uuid = "613b1da9-c943-f8d2-821c-550e5ba9d717",
							version = 3,
						},
					},
				},
				eventType = 26,
				mechanicTime = 452.7,
				name = "[WAR] Rampart",
				throttleTime = 2000,
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 32.200000762939,
				timerStartOffset = 2,
				uuid = "acda6e70-75ea-f776-88f7-c27a5af96978",
				version = 2,
			},
		},
	},
	[86] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "d556666b-df3c-5317-2038-3fb1ca44d4bb",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Broad Swings",
				uuid = "993d5a3a-dc9c-4976-adae-7abd546afab5",
				version = 2,
			},
			inheritedObjectUUID = "6d3b62a4-bd8f-e044-857a-b2c1fd5d91a0",
			inheritedOverwrites =
			{
				name = "[Draw] Broad Swings",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "05352b04-25f6-e300-2d95-aefaec7a8c74",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
				uuid = "2b020ad1-21be-f515-cfbc-148b8bd871c1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[94] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fe84ccfd-016f-e949-049e-3f7f1ca259ad",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[97] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "755ba6aa-09ed-2b76-726c-9f18cffb60da",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Enable Pots",
				uuid = "30818a06-c6c5-8278-89b5-6e9a39c7bb3d",
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
				actions =
				{

					{
						data =
						{
							aType = "Misc",
							conditions =
							{

								{
									"9dc56d46-c356-d8da-a534-53924535586b",
									true,
								},
							},
							name = "Target Nidhogg",
							setTarget = true,
							targetType = "Detection Target",
							uuid = "bcc3b011-590c-0aae-a88b-1480b30892dd",
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"9dc56d46-c356-d8da-a534-53924535586b",
									true,
								},
							},
							name = "Provoke Nidhogg",
							targetType = "Detection Target",
							uuid = "a1972b2f-47f1-bbd1-8c6a-810e115d483e",
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
							name = "F - Nidhogg",
							partyTargetContentID = 3458,
							uuid = "9dc56d46-c356-d8da-a534-53924535586b",
							version = 3,
						},
					},
				},
				mechanicTime = 602.3,
				name = "[WAR] Target + Provoke Nidhogg",
				timelineIndex = 97,
				uuid = "b39132bb-dc3b-0d90-a602-8af8d96ee1ff",
				version = 2,
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
				uuid = "ad2f1779-9664-ebcd-649c-44b37f3a54a9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[99] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "931ec87f-38b3-0d13-90ff-13697d7dd4cf",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Assignment Capture",
				uuid = "036cb772-9e33-6e93-b6c4-50f5f89f2d40",
				version = 2,
			},
			inheritedObjectUUID = "c708edb7-f258-bd67-9977-5fcf2ab1e915",
			inheritedOverwrites =
			{
				name = "[Draw] Assignment Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Line Capture",
				uuid = "34d3b4c8-8f78-174c-afd3-8736c924bf76",
				version = 2,
			},
			inheritedObjectUUID = "4d909d44-c452-90d7-a3d2-ee3f27e7a0e0",
			inheritedOverwrites =
			{
				name = "[Draw] Line Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Position Tethers",
				uuid = "3fbc2a67-ab18-1112-bbce-45e5e60e8377",
				version = 2,
			},
			inheritedObjectUUID = "81068bea-b927-c7fc-b131-d9a7c4c8b548",
			inheritedOverwrites =
			{
				name = "[Draw] Position Tethers",
			},
		},

		{
			data =
			{
				name = "[Draw] Tower Resolution",
				uuid = "4000a76d-f3a4-a7d9-8a21-025b0615d738",
				version = 2,
			},
			inheritedObjectUUID = "c6c40ffd-c8d2-8c1f-aed4-027d0ed4b613",
			inheritedOverwrites =
			{
				name = "[Draw] Tower Resolution",
			},
		},

		{
			data =
			{
				name = "[Draw] Stack Progress",
				uuid = "31fdc56c-2c62-e4c9-ad19-95f7be1e1669",
				version = 2,
			},
			inheritedObjectUUID = "1e7ab052-7891-d371-b577-c86ff1e7d1e3",
			inheritedOverwrites =
			{
				name = "[Draw] Stack Progress",
			},
		},

		{
			data =
			{
				name = "[Draw] Jump Placement",
				uuid = "169d67fa-99dc-5027-b81a-f7f4cc1a6d2f",
				version = 2,
			},
			inheritedObjectUUID = "974cf95f-d81a-6279-aaaa-af1c942f23fc",
			inheritedOverwrites =
			{
				name = "[Draw] Jump Placement",
			},
		},

		{
			data =
			{
				name = "[Draw] Tower Position",
				uuid = "a90f11fa-36f8-2dc8-b565-e79bd96738b0",
				version = 2,
			},
			inheritedObjectUUID = "dd27fdd3-0fed-785a-b9fd-1c8be4469367",
			inheritedOverwrites =
			{
				name = "[Draw] Tower Position",
			},
		},

		{
			data =
			{
				name = "[Draw] Finalize Assignments",
				uuid = "9988db2b-8152-9e4c-8c91-2d501ff88d59",
				version = 2,
			},
			inheritedObjectUUID = "adc30783-8745-cb47-94de-1259493b940b",
			inheritedOverwrites =
			{
				name = "[Draw] Finalize Assignments",
			},
		},

		{
			data =
			{
				name = "[Opti] Snapshot Hold",
				uuid = "fe67e018-92ed-727c-987b-5769c65ab3ad",
				version = 2,
			},
			inheritedObjectUUID = "362531aa-cbc3-b009-9773-ab1c5be72412",
			inheritedOverwrites =
			{
				name = "[Opti] Snapshot Hold",
			},
		},

		{
			data =
			{
				name = "[Opti] Wipe Cleanup",
				uuid = "54949d48-c3af-4d15-b0b3-af6797a18298",
				version = 2,
			},
			inheritedObjectUUID = "18c6f631-d6fa-4bec-a7c8-e063bbba23a9",
			inheritedOverwrites =
			{
				name = "[Opti] Wipe Cleanup",
			},
		},

		{
			data =
			{
				name = "[Opti] Death Cleanup",
				uuid = "45e37a49-978e-bc38-8b2b-a4ea215e06d8",
				version = 2,
			},
			inheritedObjectUUID = "9917af74-94dd-c335-911b-a6795904b839",
			inheritedOverwrites =
			{
				name = "[Opti] Death Cleanup",
			},
		},

		{
			data =
			{
				name = "[Draw] Geirskogul Lock",
				uuid = "940abf49-a72a-e2ea-bc9c-a3b33385c4c4",
				version = 2,
			},
			inheritedObjectUUID = "33f648c5-9c49-bafd-98a7-f5289c248869",
			inheritedOverwrites =
			{
				name = "[Draw] Geirskogul Lock",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "48cdbec0-c628-4164-30df-3e1229c681b0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7531,
							uuid = "50b706f0-6400-c14b-b330-8f00f506359f",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 620.5,
				name = "[WAR] Rampart",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = -10,
				timerOffset = -24,
				timerStartOffset = -30,
				uuid = "ba417600-683d-1835-a5ab-9421695b03cd",
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
							actionID = 25751,
							uuid = "b6a82669-32fc-8ef0-bd75-ac2005b65cef",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 620.5,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 99,
				timerOffset = -12,
				uuid = "59d49143-fc26-e384-b179-1e7b2d688d9a",
				version = 2,
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
				uuid = "5cb8644f-649e-3d3b-d1cd-d66db225f37f",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[101] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "2497520e-d8af-2e3a-8b19-f004c0c819be",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "9a9472ba-cb30-5a7e-b72d-f0cde5134abd",
				version = 2,
			},
			inheritedObjectUUID = "e611b105-6a30-ed4a-b4f9-a26d8fc0c970",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "",
								uuid = "2fe86195-f8f9-9b28-a245-209a3bc7f442",
								version = 2.1,
							},
							inheritedObjectUUID = "b6ce802e-807b-f04c-b7a0-041f32f5ee89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"da599fc2-7b55-949c-85a4-abec4ad546e1",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"0e556a1c-13a8-d67c-8fc3-cb47f8d90ca6",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"da599fc2-7b55-949c-85a4-abec4ad546e1",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "0e556a1c-13a8-d67c-8fc3-cb47f8d90ca6",
								version = 3,
							},
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "5e2d20a3-7c42-e79c-86d5-d6e124ec5ded",
				version = 2,
			},
			inheritedObjectUUID = "90347a66-51c4-a45c-b1c0-94a4f7e11766",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face towards 1",
								uuid = "acdb2add-4eb1-304f-aa33-b77eea5670f3",
								version = 2.1,
							},
							inheritedObjectUUID = "ce4fe96d-73c1-87fc-b241-46cf7f5fab22",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"98d60cfe-cbb4-c62c-99e1-0a8c65dae7e4",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},
								},
							},
						},
					},

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face away 1",
								uuid = "86f88466-be8f-47d4-a9db-a21ec001666f",
								version = 2.1,
							},
							inheritedObjectUUID = "7df771cf-100b-8967-a44b-6d96d9786e89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"3f9921c1-d797-d8ed-88b0-eb6bc33fb9b3",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"98d60cfe-cbb4-c62c-99e1-0a8c65dae7e4",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"3f9921c1-d797-d8ed-88b0-eb6bc33fb9b3",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "98d60cfe-cbb4-c62c-99e1-0a8c65dae7e4",
								version = 3,
							},
						},
					},
				},
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
				uuid = "bcaa2881-6c33-688d-2394-181bc0abbcb1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[106] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "760d9a6d-a1d4-b721-b878-a04f5602f55d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "efe1f2e8-7272-6d63-afa9-35f012ca4802",
				version = 2,
			},
			inheritedObjectUUID = "fda072ee-def8-f366-bf75-8aee6df53bd3",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face towards 2",
								uuid = "72035c25-2117-2447-b214-596991ff4235",
								version = 2.1,
							},
							inheritedObjectUUID = "ce4fe96d-73c1-87fc-b241-46cf7f5fab22",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"d4ee2e49-78df-cfea-8caf-3fd7a8b15597",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"0293d76c-c241-6a2a-994b-3b4b3e84554e",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"d4ee2e49-78df-cfea-8caf-3fd7a8b15597",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},
								},
							},
						},
					},

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face away 2",
								uuid = "5a33ed9f-bda2-cc35-bbcb-e4ea43bf4ca8",
								version = 2.1,
							},
							inheritedObjectUUID = "7df771cf-100b-8967-a44b-6d96d9786e89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"d4ee2e49-78df-cfea-8caf-3fd7a8b15597",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"f12157f5-f1af-1d57-b227-a6fa132f3ddf",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"0293d76c-c241-6a2a-994b-3b4b3e84554e",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"d4ee2e49-78df-cfea-8caf-3fd7a8b15597",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"f12157f5-f1af-1d57-b227-a6fa132f3ddf",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "0293d76c-c241-6a2a-994b-3b4b3e84554e",
								version = 3,
							},
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "aa3aceb5-7ad1-4913-ba8f-83f10ac23afb",
				version = 2,
			},
			inheritedObjectUUID = "33d7f612-2290-5b67-ad73-40205ec1daae",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "",
								uuid = "ed365382-af26-53c3-b7b4-a79a0ff532ad",
								version = 2.1,
							},
							inheritedObjectUUID = "b6ce802e-807b-f04c-b7a0-041f32f5ee89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"8d361bbc-39fe-472d-86ff-056b4e5049d2",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"ef159ff0-be7d-d2a7-aa43-c5a7e34e329a",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"8d361bbc-39fe-472d-86ff-056b4e5049d2",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "ef159ff0-be7d-d2a7-aa43-c5a7e34e329a",
								version = 3,
							},
						},
					},
				},
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
				uuid = "f696a2b7-bf80-1763-423f-813571b524a7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[109] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8880c316-82dc-9c82-5ab5-f60c79d1fc46",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Unlock face",
				uuid = "f4a7ab5c-98b4-a8fe-8a5e-5f52285a9bb6",
				version = 2,
			},
			inheritedObjectUUID = "090974f5-c3e4-e365-b0cf-4527515bd6ab",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "",
								uuid = "3b670f20-f7b2-3f16-8057-220efedf4a89",
								version = 2.1,
							},
							inheritedObjectUUID = "b6ce802e-807b-f04c-b7a0-041f32f5ee89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"da599fc2-7b55-949c-85a4-abec4ad546e1",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"402ab549-6aea-34b0-bf55-a8943204220b",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"da599fc2-7b55-949c-85a4-abec4ad546e1",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "402ab549-6aea-34b0-bf55-a8943204220b",
								version = 3,
							},
						},
					},
				},
			},
		},

		{
			data =
			{
				name = "Lock face",
				uuid = "e06c0718-7628-dae5-a8ee-fc2f7759a608",
				version = 2,
			},
			inheritedObjectUUID = "58ca87de-c205-7ef6-b022-7b3e386ec1eb",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face towards 3",
								uuid = "2974d3a5-d181-7e2a-930b-7d328de1e529",
								version = 2.1,
							},
							inheritedObjectUUID = "ce4fe96d-73c1-87fc-b241-46cf7f5fab22",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"49aeed35-730a-169a-8905-01ce8d6a04a7",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"076a4d91-5332-a419-8f15-8d39dd521dfc",
											true,
										},
									},
								},
							},
						},
					},

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Lock face away 3",
								uuid = "818309b0-0ce1-f781-b583-5e3878089588",
								version = 2.1,
							},
							inheritedObjectUUID = "7df771cf-100b-8967-a44b-6d96d9786e89",
							inheritedOverwrites =
							{
								conditions =
								{

									{
										type = "remove",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										type = "remove",
										value =
										{
											"3f9921c1-d797-d8ed-88b0-eb6bc33fb9b3",
											true,
										},
									},

									{
										position = 1,
										type = "add",
										value =
										{
											"49aeed35-730a-169a-8905-01ce8d6a04a7",
											true,
										},
									},

									{
										position = 2,
										type = "add",
										value =
										{
											"368b1f3e-eae0-1830-983a-01d248615641",
											true,
										},
									},

									{
										position = 3,
										type = "add",
										value =
										{
											"3f9921c1-d797-d8ed-88b0-eb6bc33fb9b3",
											true,
										},
									},
								},
							},
						},
					},
				},
				conditions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								category = "Lua",
								conditionLua = "local s=data.frog_dfg_v2\nreturn not (s and s.customHold==true)",
								name = "Anyone facing selected",
								uuid = "49aeed35-730a-169a-8905-01ce8d6a04a7",
								version = 3,
							},
						},
					},
				},
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
				uuid = "79ffe63c-9c97-4038-0d39-f00a788a7f6c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[111] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "d7d77c25-0b03-e1d1-8e0b-568ba0bf6e95",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "1df6145d-3d19-80b9-9469-1a2404178464",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 651.9,
				name = "[WAR] Shake",
				timeRange = true,
				timelineIndex = 111,
				timerStartOffset = -9,
				uuid = "0063e599-da5b-3875-ada7-57fc9d31ac79",
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
							aType = "ACR",
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "cd7e12a1-3d56-5b94-9592-df52010d1b48",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 651.9,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "ad9d5cc6-784b-eddc-a76c-2dad846ad054",
				version = 2,
			},
		},
	},
	[116] =
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
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "fb1cb847-a87f-38e3-a327-ae9a870cf2f9",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 664.9,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 116,
				timerOffset = -11.5,
				uuid = "bf88314b-eabf-4759-b639-9f5d61ccc6bf",
				version = 2,
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
				uuid = "26bc76a7-0ea1-752b-d173-4ab1caa44e97",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							gVar = "ACR_RikuWAR3_Jumps",
							gVarValue = 2,
							holdActionCharges = 3,
							holdActionDuration = 14.10000038147,
							holdActionID = 7386,
							uuid = "43e3a172-8048-2b07-9bda-3539afb9355e",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 14.10000038147,
							holdActionID = 25753,
							uuid = "63e22418-f88e-c71f-a914-5b8400a5968f",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 669.8,
				name = "[WAR] Hold Onslaught 3 + Rend",
				timelineIndex = 117,
				uuid = "86e34bc7-69f6-df21-aec8-357364c63659",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "80e789db-f327-3447-4a7b-6aa9bdb9702b",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9d64c334-28cf-95c0-ef2e-80124528bae4",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[MCH & SAM] Force pot",
				uuid = "1422d969-f463-a0a2-81c5-9642d3587ebd",
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
				actions =
				{

					{
						data =
						{
							aType = "ACR",
							conditions =
							{

								{
									"afdb46e4-e441-421b-9a7d-80abb6bb422b",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Potion",
							gVarValue = 2,
							name = "Clear pending potion request",
							uuid = "361d31dc-cfb8-190e-ac26-b5cddcef10bc",
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
									"afdb46e4-e441-421b-9a7d-80abb6bb422b",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Hotbar_Potion",
							name = "Potion Once",
							potType = 4,
							usePot = true,
							uuid = "b0e88960-a615-d43d-ba88-cfe2d9413842",
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
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "afdb46e4-e441-421b-9a7d-80abb6bb422b",
							version = 3,
						},
					},
				},
				mechanicTime = 676.9,
				name = "[WAR] Potion",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 5,
				uuid = "b32eb881-9e1a-d008-afab-e200e1ecbd68",
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
							aType = "ACR",
							conditions =
							{

								{
									"b233fa8e-3ad4-e0e0-9adb-6610d0ebf852",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Potion",
							gVarValue = 2,
							name = "Cancel pending P3 potion",
							uuid = "e6db504d-3ee3-ed6e-acae-a08979cc291c",
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
							conditionType = 13,
							dequeueIfLuaFalse = true,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "b233fa8e-3ad4-e0e0-9adb-6610d0ebf852",
							version = 3,
						},
					},
				},
				mechanicTime = 676.9,
				name = "[WAR] Potion Cleanup",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 6,
				timerStartOffset = 5,
				uuid = "03446f9c-a9cf-ca88-8ac4-67b6d86bc2c4",
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
				uuid = "0b0a475d-8d30-ee79-22eb-86b31565654d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[120] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "3577b4c9-9c5c-9335-54ab-807316600b39",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Holmgang",
							uuid = "874bd26f-c5b1-cbf7-9e8f-81fc8b432a00",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 683.9,
				name = "[WAR] Holmgang",
				timelineIndex = 120,
				timerOffset = -8,
				uuid = "968c084d-0e38-328c-b892-fa2fdd66eb4c",
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
							aType = "ACR",
							fallthrough = true,
							gVar = "ACR_RikuWAR3_Tankbar_ThrillOfBattle",
							uuid = "33d75202-ca65-b437-a0d4-8c0cdc5f33fa",
							variableTogglesType = 3,
							version = 2.1,
						},
						inheritedIndex = 1,
					},

					{
						data =
						{
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "874bd26f-c5b1-cbf7-9e8f-81fc8b432a00",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 683.9,
				name = "[WAR] Heal",
				timelineIndex = 120,
				timerOffset = 0.5,
				uuid = "371f47e4-b935-5a15-a640-cdf274de8c16",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_NascentFlashOT",
							uuid = "e12e6c8c-5c8a-f130-b099-0de0b95e350b",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 683.9,
				name = "[WAR] Nascent OT",
				timelineIndex = 120,
				timerOffset = -3,
				uuid = "d2627fc0-9c46-eaab-af7b-a6b0f43b72e7",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "874bd26f-c5b1-cbf7-9e8f-81fc8b432a00",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 683.9,
				name = "[WAR] Damnation",
				timelineIndex = 120,
				timerOffset = 3,
				uuid = "32ee21f5-f361-83c1-98fa-8a58e60b45f3",
				version = 2,
			},
		},
	},
	[122] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7faba097-d037-0243-d27f-44e5e3d24607",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[123] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "3df4f6f6-b7d3-0fe2-1d03-7bfc36041426",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"ff61b11a-09d4-031a-b939-d3340111abd4",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							uuid = "c701bc76-dcb2-32c5-8cc6-2b8473db16e7",
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
							category = "Party",
							comparator = 2,
							conditionType = 2,
							hpValue = 15,
							name = "Nidhogg HP <=10%",
							partyTargetType = "Detection Target",
							uuid = "e0c5ab52-9ff2-c78e-9fad-46bd1dd7e51f",
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
									"e0c5ab52-9ff2-c78e-9fad-46bd1dd7e51f",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Nidhogg",
							partyTargetContentID = 3458,
							uuid = "ff61b11a-09d4-031a-b939-d3340111abd4",
							version = 3,
						},
					},
				},
				mechanicTime = 721.1,
				name = "[WAR] Storm's Eye <10%",
				timeRange = true,
				timelineIndex = 123,
				timerStartOffset = -60,
				uuid = "f48c1904-64e3-5526-9195-224f07b1b99a",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_HoldOneJump",
							uuid = "ac8329fd-7e3b-2cc2-9898-ff6bf01f049c",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 721.1,
				name = "[WAR] Hold 1 Jump",
				timeRange = true,
				timelineIndex = 123,
				timerEndOffset = -25,
				timerStartOffset = -30,
				uuid = "524e5ff1-4b38-f124-95e3-5e046b193016",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "001374f1-c58f-2705-b5d4-9017a18daf81",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Event Capture",
				uuid = "d509bc00-3c83-2ee9-963b-43e25fa499cd",
				version = 2,
			},
			inheritedObjectUUID = "bd16ae3f-b6f4-5775-b1b9-49bf1e3eafd2",
			inheritedOverwrites =
			{
				name = "[Draw] Event Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Role Solver",
				uuid = "7f13fee9-53d8-65c8-9bf7-1c08d9bd4c5b",
				version = 2,
			},
			inheritedObjectUUID = "6fb85a95-9d48-9616-9a9d-578f6b6962fe",
			inheritedOverwrites =
			{
				name = "[Draw] Role Solver",
			},
		},

		{
			data =
			{
				name = "[Draw] Personal Guidance",
				uuid = "5725b690-09f1-987a-9b2b-298afe877466",
				version = 2,
			},
			inheritedObjectUUID = "971e735e-a32e-3b8d-a43c-43c9bea24569",
			inheritedOverwrites =
			{
				name = "[Draw] Personal Guidance",
			},
		},

		{
			data =
			{
				name = "[Draw] Yellow Soak",
				uuid = "f29c472a-87ab-3cc3-acd5-3e1efa979689",
				version = 2,
			},
			inheritedObjectUUID = "5a7a169d-9c77-7d06-9bec-3da48eb05c16",
			inheritedOverwrites =
			{
				name = "[Draw] Yellow Soak",
			},
		},

		{
			data =
			{
				name = "[Draw] Blue Soak",
				uuid = "b0acf57a-62eb-0d27-b118-05051598b807",
				version = 2,
			},
			inheritedObjectUUID = "9abfbf0a-40e4-d7cc-8394-4e474d9dd3bd",
			inheritedOverwrites =
			{
				name = "[Draw] Blue Soak",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7f40fb42-3e5e-1116-0e12-ab602d9e3c72",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7386,
							atomicPriority = true,
							conditions =
							{

								{
									"49d81cc2-8805-fda8-95ab-d346a572e03c",
									true,
								},

								{
									"ebf5eb01-35a0-c552-8f66-2515abe8039f",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Onslaught Right Eye",
							targetType = "Detection Target",
							uuid = "c4c15c48-38eb-8de9-a08b-00b689b4ff7f",
							version = 2.1,
						},
						inheritedIndex = 1,
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"49d81cc2-8805-fda8-95ab-d346a572e03c",
									true,
								},

								{
									"ebf5eb01-35a0-c552-8f66-2515abe8039f",
									true,
								},
							},
							name = "Provoke Right Eye",
							targetType = "Detection Target",
							uuid = "6eb3d0e9-35ff-da64-9e67-4ab272decef1",
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
							name = "F - Right Eye",
							partyTargetContentID = 11318,
							uuid = "ebf5eb01-35a0-c552-8f66-2515abe8039f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return eventArgs.buffID == 2748 or eventArgs.buffID == 2749",
							dequeueIfLuaFalse = true,
							name = "C - Soul of Friendship or Devotion",
							uuid = "49d81cc2-8805-fda8-95ab-d346a572e03c",
							version = 3,
						},
					},
				},
				eventType = 8,
				mechanicTime = 757,
				name = "[WAR] Soul Buff Right",
				timelineIndex = 127,
				timerEndOffset = 2,
				timerStartOffset = -5,
				uuid = "cb7514b3-999e-64f1-8d1d-8ca6381c4f3b",
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
				uuid = "791638e1-2bea-e86d-c75a-8d4b9c833391",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "0f571957-21ba-e5d0-ae1c-a8d533c94aa0",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 772.7,
				name = "[WAR] Shake",
				timelineIndex = 128,
				timerOffset = -1,
				uuid = "c55cbdb1-744c-7584-bb18-3c5cd4ae4295",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "0c38a1fb-4b1f-6daa-85bd-fb487d7c830d",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 772.7,
				name = "[WAR] Rampart",
				timelineIndex = 128,
				timerOffset = -4,
				uuid = "cc2af448-91e4-ab82-b90b-a14aec642b8b",
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
							alertText = "Move to left eye",
							conditions =
							{

								{
									"eb8273ba-fe1f-85bf-80bd-c9b8d7a8ac76",
									true,
								},
							},
							name = "Move to left eye",
							uuid = "fea70c0d-7326-2485-a114-acf453cffc1b",
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
							uuid = "5b573078-9d07-c1c7-9913-e96485aef580",
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
									"5b573078-9d07-c1c7-9913-e96485aef580",
									false,
								},
							},
							filterTargetType = "ContentID",
							name = "Left Eye",
							partyTargetContentID = 11317,
							uuid = "eb8273ba-fe1f-85bf-80bd-c9b8d7a8ac76",
							version = 3,
						},
					},
				},
				mechanicTime = 772.7,
				name = "[Callout] Left Eye",
				randomOffset = 8,
				timeRange = true,
				timelineIndex = 128,
				timerEndOffset = -4.4,
				timerStartOffset = -5,
				uuid = "70a48c65-3211-7ee2-9c3f-7f7a2983181a",
				version = 2,
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
				uuid = "77418588-e537-0204-6a05-1fca671e58f8",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionCharges = 3,
							holdActionDuration = 17.60000038147,
							holdActionID = 7386,
							uuid = "55313890-7946-f648-bae1-6b1b4dc10f9b",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 798.8,
				name = "[WAR] Hold Onslaught",
				timeRange = true,
				timelineIndex = 129,
				timerStartOffset = -0.5,
				uuid = "d7812146-f087-1ab6-a841-b35b60ecd4f2",
				version = 2,
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
				uuid = "eb0b6626-494b-9212-7dcf-dc105c612dd6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[131] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "98d99807-7d08-98b3-2b36-538956c75b77",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[132] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "59feae80-2fdd-343c-8870-00b648c32130",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[133] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "cb675d39-8db4-ca25-8b86-c2579e36f429",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"b2060762-2cc0-1c1a-91b0-ffe9393214de",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "Reprisal - Right Eye",
							uuid = "fc44c17b-c232-5fd1-b837-572924923145",
							variableTogglesType = 3,
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
							comparator = 2,
							conditionLua = "local id=eventArgs.detectionTargetID\nif not id then return false end\nlocal e=TensorCore.mGetEntity(id)\nlocal p=TensorCore.mGetPlayer()\nif not e or not p or not e.pos or not p.pos or not e.hitradius then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz <= (e.hitradius+4.5)^2",
							conditionType = 4,
							inRangeValue = 5,
							name = "Detection target hitbox +4.5y",
							partyTargetType = "Detection Target",
							uuid = "f99f6f51-65e7-277c-b709-795e19a38047",
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
									"c7363048-24cc-e6a6-9250-41dbbb14225c",
									false,
								},

								{
									"f99f6f51-65e7-277c-b709-795e19a38047",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Right Eye",
							partyTargetContentID = 11318,
							uuid = "b2060762-2cc0-1c1a-91b0-ffe9393214de",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							comparator = 2,
							conditionType = 2,
							hpValue = 6,
							name = "Right Eye HP <=6% (must be false)",
							partyTargetType = "Detection Target",
							uuid = "c7363048-24cc-e6a6-9250-41dbbb14225c",
							version = 3,
						},
					},
				},
				mechanicTime = 824.7,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 133,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "3f299115-522d-cf31-b1a8-d5788529f175",
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
							aType = "ACR",
							conditions =
							{

								{
									"9adf80c4-ff33-372a-a999-31b421b9e657",
									false,
								},

								{
									"68504ac9-8f89-49eb-ae7b-7bf012772ed5",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							uuid = "b89ed8d0-fbf0-5f27-a380-6d5099e83b45",
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
							category = "Party",
							comparator = 2,
							conditionType = 2,
							hpValue = 15,
							name = "Right Eye HP <=15%",
							partyTargetType = "Detection Target",
							uuid = "9c21bc6c-6ef8-6089-974c-bd79faee4137",
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
									"9c21bc6c-6ef8-6089-974c-bd79faee4137",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Right Eye",
							partyTargetContentID = 11318,
							uuid = "68504ac9-8f89-49eb-ae7b-7bf012772ed5",
							version = 3,
						},
					},

					{
						data =
						{
							buffCheckType = 3,
							buffDuration = 40,
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye >=40s",
							uuid = "9adf80c4-ff33-372a-a999-31b421b9e657",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 824.7,
				name = "[WAR] Storm's Eye <=15%",
				timeRange = true,
				timelineIndex = 133,
				timerStartOffset = -60,
				uuid = "33716ec9-05bf-3499-94a1-c5d921138d84",
				version = 2,
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
				uuid = "0b726193-dc99-c4a7-66df-d255e6dbd803",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7389,
							conditions =
							{

								{
									"87fb4033-d102-4166-90c2-d83fd6a19fd4",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Inner Release",
							uuid = "5bf66c34-2046-ad85-bbd9-186eb6a497ce",
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
							buffDuration = 1.5,
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye >=10s",
							uuid = "87fb4033-d102-4166-90c2-d83fd6a19fd4",
							version = 3,
						},
					},
				},
				mechanicTime = 900,
				name = "[WAR] Inner Release",
				timelineIndex = 135,
				timerEndOffset = 5,
				timerOffset = -2,
				timerStartOffset = -2,
				uuid = "6a524fa7-c06d-2553-8f76-0fdfe9ac3285",
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
							aType = "ACR",
							conditions =
							{

								{
									"0406e8b5-418a-1c94-ae97-4f87ac1409b0",
									true,
								},

								{
									"bd9a6733-1e4a-ec19-bdb2-560b3f8b146b",
									true,
								},

								{
									"9b5cc340-08df-e519-9930-2583f6793efd",
									true,
								},

								{
									"f37018cc-7a60-559b-9ccf-d4815a6485ac",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							name = "Storm's Eye",
							uuid = "ef620607-b086-74bd-87b5-971e8a2c0dfc",
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
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Spear alive",
							partyTargetContentID = 11320,
							uuid = "f37018cc-7a60-559b-9ccf-d4815a6485ac",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_war_rewind\nreturn TensorReactions_CurrentTimer>=920 or (s and s.lb==true)",
							name = "Rewind burst finished",
							uuid = "9b5cc340-08df-e519-9930-2583f6793efd",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye active",
							uuid = "0406e8b5-418a-1c94-ae97-4f87ac1409b0",
							version = 3,
						},
					},

					{
						data =
						{
							buffCheckType = 3,
							buffDuration = 34.9,
							buffID = 2677,
							category = "Self",
							comparator = 2,
							name = "Storm's Eye <35s",
							uuid = "bd9a6733-1e4a-ec19-bdb2-560b3f8b146b",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 900,
				name = "[WAR] Storm's Eye",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 96,
				uuid = "448baeaa-50a4-d4d3-9321-e15f0b63553a",
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
							actionLua = "data.frog_war_rewind={cleaves=0,lb=false}\nself.used=true",
							name = "Initialize rewind burst",
							uuid = "b0b4c28e-c5b3-4cfe-81a0-8c412489ed82",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 23.1,
							holdActionID = 25753,
							uuid = "8b20a580-c9b4-00a4-82ea-8a0c959b9d4d",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 10,
							holdActionID = 45,
							uuid = "73e3e9fc-db72-c342-9736-1d1b5c0dc073",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 10,
							holdActionID = 42,
							uuid = "eef21d89-cffc-dd41-bab7-511ce520018a",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 900,
				name = "[WAR] Burst Setup",
				timeRange = true,
				timelineIndex = 135,
				timerStartOffset = -2,
				uuid = "ba19492a-0591-95ac-85be-f71fd58e5253",
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
							actionLua = "local s=data.frog_war_rewind\nif not s then return end\nif eventArgs.spellID==3549 then s.cleaves=math.min(3,s.cleaves+1) else s.lb=true end\nself.used=true",
							conditions =
							{

								{
									"6571964f-962d-19e6-80fd-c1e894658120",
									true,
								},
							},
							name = "Record cleaves and LB",
							uuid = "2d51b411-ee16-e514-9134-df2a8d2fe5e2",
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
							conditionLua = "local p=TensorCore.mGetPlayer()\nreturn p and eventArgs.entityID==p.id and (eventArgs.spellID==3549 or eventArgs.spellID==4240)",
							name = "Self Fell Cleave or Land Waker",
							uuid = "6571964f-962d-19e6-80fd-c1e894658120",
							version = 3,
						},
					},
				},
				eventType = 2,
				loop = true,
				mechanicTime = 900,
				name = "[WAR] Burst Progress",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 20,
				timerStartOffset = -2,
				uuid = "55423ce8-2863-fd89-8def-20a86102b925",
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
							actionID = 3549,
							conditions =
							{

								{
									"e8d99da8-9af4-f94c-b85b-c444386dfb9e",
									true,
								},
							},
							targetContentID = 3642,
							targetType = "ContentID",
							uuid = "ddccc1b4-195c-e6fe-b1a4-b77005f0494a",
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
							conditionLua = "local s=data.frog_war_rewind\nreturn s and s.cleaves<3 and not s.lb",
							name = "Fewer than three cleaves",
							uuid = "e8d99da8-9af4-f94c-b85b-c444386dfb9e",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 900,
				name = "[WAR] Three Fell Cleaves",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 10,
				uuid = "60fa579c-7981-67ea-a0d8-2c55b021aacd",
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
							aType = "ACR",
							conditions =
							{

								{
									"b2f25f7a-1c3f-f1f8-b76a-063f9aa5214e",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_LimitBreak",
							uuid = "4301cca5-4d2b-4f28-9ffd-f77a211639ea",
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
							category = "Lua",
							conditionLua = "local s=data.frog_war_rewind\nreturn s and s.cleaves>=3 and not s.lb",
							name = "Three cleaves complete",
							uuid = "b2f25f7a-1c3f-f1f8-b76a-063f9aa5214e",
							version = 3,
						},
					},
				},
				mechanicTime = 900,
				name = "[WAR] LB After Cleaves",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 12,
				uuid = "3a2335a2-017b-39e5-af85-69c5eaa1eccf",
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
							actionID = 25753,
							conditions =
							{

								{
									"89c9c8cc-1a87-48e1-b63d-7a979b426cb8",
									true,
								},
							},
							targetContentID = 3642,
							targetType = "ContentID",
							uuid = "b910f962-a49c-0cf7-b934-4e10cc2d0109",
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
							conditionLua = "local s=data.frog_war_rewind\nreturn (s and s.lb==true) or TensorReactions_CurrentTimer>=921.1",
							name = "LB done or second cleave",
							uuid = "89c9c8cc-1a87-48e1-b63d-7a979b426cb8",
							version = 3,
						},
					},
				},
				mechanicTime = 900,
				name = "[WAR] Rend After LB",
				timeRange = true,
				timelineIndex = 135,
				timerEndOffset = 25,
				uuid = "b07f4a85-0446-5ec6-985a-7f918e26a1ba",
				version = 2,
			},
		},
	},
	[138] =
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
									"7db293b9-ff5e-3028-a730-867855b280a4",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_LimitBreak",
							uuid = "d6174b0c-0045-0fa1-8ff9-c2600cb11f9e",
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
							conditionType = 14,
							dequeueIfLuaFalse = true,
							jobIDList =
							{
								19,
								21,
								32,
								37,
							},
							name = "Tank Job",
							uuid = "7db293b9-ff5e-3028-a730-867855b280a4",
							version = 3,
						},
					},
				},
				mechanicTime = 910,
				name = "Tank LB",
				timelineIndex = 138,
				timerOffset = -2.7999999523163,
				uuid = "d878ff89-bee8-3000-8895-e7de0db0c061",
				version = 2,
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
				uuid = "aa813c93-3588-ee97-aefe-822985eab303",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							actionID = 16464,
							gVar = "ACR_RikuWAR3_Tankbar_NascentFlashMouse",
							name = "NF - Mouse",
							targetSubType = "Topmost Partylist",
							targetType = "Melee DPS",
							uuid = "19269a07-6ba2-0e93-be2d-a345e184816c",
							variableIsHover = true,
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 920.9,
				name = "[WAR] Nascent Melee",
				timelineIndex = 140,
				timerOffset = -4,
				uuid = "1772308b-60e8-c7de-bff6-5ee8180d2f30",
				version = 2,
			},
		},
	},
	[142] =
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
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Brightwing",
							uuid = "c5f5031b-a975-14d4-b7d7-d8d240a4c4db",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 925.9,
				name = "[WAR] Shake",
				timelineIndex = 142,
				timerOffset = -4,
				uuid = "9bcc3290-0395-01fb-8b0e-bc353335dbfe",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Brightwing Safety",
							uuid = "5b749098-1b14-2acb-aea2-d54825c8fc5d",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 925.9,
				name = "[WAR] Shake - Brightwing Safety",
				timelineIndex = 142,
				timerOffset = -5,
				uuid = "7c6aa983-6f55-f625-ac55-b6fa96b6edf3",
				version = 2,
			},
		},
	},
	[146] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6a763839-0ba4-0e95-f7a3-66033d45cf29",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"f89bfefc-a629-ec4c-a7d2-66cb8ecdb28c",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "Reprisal - Charibert",
							uuid = "34c81775-9551-2cda-8360-864e687636bc",
							variableTogglesType = 3,
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
							comparator = 2,
							conditionLua = "local id=eventArgs.detectionTargetID\nif not id then return false end\nlocal e=TensorCore.mGetEntity(id)\nlocal p=TensorCore.mGetPlayer()\nif not e or not p or not e.pos or not p.pos or not e.hitradius then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz <= (e.hitradius+4.5)^2",
							conditionType = 4,
							inRangeValue = 5,
							name = "Detection target hitbox +4.5y",
							partyTargetType = "Detection Target",
							uuid = "777b341e-ab76-3575-a6f9-6f22020aab0d",
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
									"777b341e-ab76-3575-a6f9-6f22020aab0d",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - Ser Charibert",
							partyTargetContentID = 3642,
							uuid = "f89bfefc-a629-ec4c-a7d2-66cb8ecdb28c",
							version = 3,
						},
					},
				},
				mechanicTime = 935.9,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 146,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "8b39aef9-69e7-d4f8-9f23-50eb652ee8f6",
				version = 2,
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
				uuid = "c1b32eeb-13a8-46af-bb9c-9f41938a5ddb",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[150] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "9cd94e30-c09b-b944-cefb-1e06fd4b1d60",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7389,
							conditions =
							{

								{
									"87fb4033-d102-4166-90c2-d83fd6a19fd4",
									true,
								},
							},
							ignoreWeaveRules = true,
							name = "Inner Release",
							uuid = "5bf66c34-2046-ad85-bbd9-186eb6a497ce",
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
							buffDuration = 10,
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye >=10s",
							uuid = "87fb4033-d102-4166-90c2-d83fd6a19fd4",
							version = 3,
						},
					},
				},
				mechanicTime = 996,
				name = "[WAR] Inner Release",
				timeRange = true,
				timelineIndex = 150,
				timerEndOffset = 5,
				timerStartOffset = -3,
				uuid = "2549a151-ca5f-3dc8-ba2e-77fae0b12ba4",
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
							actionID = 7387,
							atomicPriority = true,
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "d7a8753c-4265-c493-9e45-63287165aaa2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 996,
				name = "[WAR] Upheaval",
				timelineIndex = 150,
				timerOffset = -1,
				uuid = "f7312f28-2575-d3f6-9516-b084a68523c6",
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
							actionID = 7533,
							conditions =
							{

								{
									"4e516f98-dec4-3dad-a34e-95b25d410974",
									true,
								},
							},
							targetType = "Detection Target",
							uuid = "5303e8a0-7acc-fafa-a97c-248a3e5f9371",
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
							name = "Dark Thordan",
							partyTargetContentID = 3632,
							uuid = "4e516f98-dec4-3dad-a34e-95b25d410974",
							version = 3,
						},
					},
				},
				mechanicTime = 996,
				name = "[WAR] Opening Provoke",
				timeRange = true,
				timelineIndex = 150,
				timerEndOffset = 6,
				timerStartOffset = 1,
				uuid = "0e39bb01-8862-0a1b-84ea-d7ab332035ba",
				version = 2,
			},
		},
	},
	[152] =
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
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "b0832b49-7875-c573-86fa-d059632384fe",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1006.1,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 152,
				timerOffset = 2,
				uuid = "12b084ab-1135-b2ea-abb3-b3c525fe345a",
				version = 2,
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
				uuid = "29d1e3e3-2d1e-e7ef-e1ae-ff1985ac28b3",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Start + North Capture",
				uuid = "436aadd4-deef-03ff-b69e-4a002a1fb30f",
				version = 2,
			},
			inheritedObjectUUID = "80fa0d38-43f7-e787-afdd-18f32d399303",
			inheritedOverwrites =
			{
				name = "[Draw] Start + North Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Knight Tether Capture",
				uuid = "a0db17af-ec76-1b34-a1f7-e54b633d561d",
				version = 2,
			},
			inheritedObjectUUID = "5d8c8c59-cd1b-b6a2-b009-a2fb763a15e2",
			inheritedOverwrites =
			{
				name = "[Draw] Knight Tether Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Marker Capture",
				uuid = "a5988ab3-d019-919e-aa5a-2b16ae54499e",
				version = 2,
			},
			inheritedObjectUUID = "810b02a1-ba7c-261d-b62f-b6578ecabd62",
			inheritedOverwrites =
			{
				name = "[Draw] Marker Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Grinnaux South Capture",
				uuid = "438aacd8-e398-59f9-86a1-0b0c4c7ab19f",
				version = 2,
			},
			inheritedObjectUUID = "0ae604d5-3338-10a1-ac44-198371411e3a",
			inheritedOverwrites =
			{
				name = "[Draw] Grinnaux South Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Dive Progress",
				uuid = "eed3fbe4-7817-c719-bc8e-bb19e5baa60d",
				version = 2,
			},
			inheritedObjectUUID = "84ab5ace-904a-70fd-a489-d34e881f64a1",
			inheritedOverwrites =
			{
				name = "[Draw] Dive Progress",
			},
		},

		{
			data =
			{
				name = "[Draw] Unmarked East",
				uuid = "fb066092-f149-3f51-8e8f-c14321060160",
				version = 2,
			},
			inheritedObjectUUID = "9185e6e4-b485-f7e9-bea3-ac62b8cbb914",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Draw Relative East Arrow",
								uuid = "cbdbe385-ff48-c79d-8da2-97d5dcc4548b",
								version = 2.1,
							},
							inheritedObjectUUID = "f92484f0-85f8-6a5e-b0dd-0f8898161086",
							inheritedOverwrites =
							{
								actionLua = "-- Shared renderer; load once even when a replay skips the Start menu.\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p5_wrath\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_wrath_v1\nlocal ex,ez=-s.nz,s.nx\nlocal drawer=TensorCore.getStaticDrawer(0xFFFF6626,1,0,frogGuide.flags)\ns.arrow=drawer:addTimedArrow(8000,100+ex*5,0.08,100+ez*5,math.atan2(ex,ez),8,1.5,3,4,0,false,frogGuide.flags)\nself.used=true",
							},
						},
					},
				},
				name = "[Draw] Unmarked East",
			},
		},

		{
			data =
			{
				name = "[Draw] Personal Guidance",
				uuid = "b7fc4f3e-27e5-d4c3-9dfd-6d0ac3e7e76c",
				version = 2,
			},
			inheritedObjectUUID = "036d633e-8e25-a056-ab4d-802083c0d1ae",
			inheritedOverwrites =
			{
				actions =
				{

					{
						type = "add",
						value =
						{
							data =
							{
								name = "Draw Assigned Position",
								uuid = "ee020296-3372-a141-ba04-5273c7e050c0",
								version = 2.1,
							},
							inheritedObjectUUID = "cdd0c157-b2d0-6c08-bbae-1c5eedbf2a79",
							inheritedOverwrites =
							{
								actionLua = "-- Shared renderer; load once even when a replay skips the Start menu.\nif data.frog_draw_style_v5 == nil then\n local g={settings={},flags=(Argus2.RenderFlags.FLAG_RENDER_OVERLAY + Argus2.RenderFlags.FLAG_WARP_TERRAIN)}\n local path=GetLuaModsPath() .. [[TensorReactions\\FrogDrawsSettings.lua]]\n if FileExists(path) then\n  local ok,settings=pcall(FileLoad,path)\n  if ok and type(settings)==\"table\" then g.settings=settings end\n end\n function g.mode(key)\n  local menu=data.frog_draw_settings\n  local settings=menu and menu.settings or g.settings\n  local styles=settings and settings.draw_styles\n  local mode=type(styles)==\"table\" and styles[key]\n  if mode==\"Arrow\" or mode==\"Tether\" or mode==\"Disabled\" then return mode end\n  return \"Tether\"\n end\n function g.draw(key,drawer,x1,y1,z1,x2,y2,z2,width,endpoint)\n  local mode=g.mode(key)\n  if mode==\"Disabled\" then return end\n  if mode==\"Arrow\" then\n   local dx,dz=x2-x1,z2-z1\n   local length=math.sqrt(dx*dx+dz*dz)\n   if length<0.1 then return end\n   local tip=math.min(2,length*0.35)\n   if not g.arrow then g.arrow=TensorCore.getStaticDrawer(0xFFFF6626,1,0,g.flags) end\n   g.arrow:addArrow(x1,y1+0.08,z1,math.atan2(dx,dz),length-tip,0.75,tip,1.5,false,g.flags)\n  else\n   drawer:addLine(x1,y1,z1,x2,y2,z2,width,endpoint)\n  end\n end\n data.frog_draw_style_v5=g\nend\nlocal frogGuide=data.frog_draw_style_v5\nif frogGuide.mode(\"p5_wrath\")==\"Disabled\" then self.used=true return end\n\nlocal s=data.frog_wrath_v1\nif not s then return end\nlocal p=TensorCore.mGetPlayer()\nif not p or not p.pos or p.hp.current<=0 then return end\nlocal x,z\nlocal radius=19.5\nif s.phase==1 and s.nx then\n    local kx,kz\n    if p.id==s.vellID then kx,kz=s.vellX,s.vellZ\n    elseif p.id==s.ignID then kx,kz=s.ignX,s.ignZ end\n    if kx then\n        local ex,ez=-s.nz,s.nx\n        local side=(-kx+100)*ex+(-kz+100)*ez\n        local sign=side<0 and -1 or 1\n        local c,t=0.9238795325,0.3826834324\n        x,z=100+radius*(-c*s.nx+sign*t*ex),100+radius*(-c*s.nz+sign*t*ez)\n    elseif p.id==s.defamID then\n        -- WNW: 60 degrees west of dragon-relative north, away from the NW dive lane.\n        local ex,ez=-s.nz,s.nx\n        x,z=100+radius*(0.5*s.nx-0.8660254038*ex),100+radius*(0.5*s.nz-0.8660254038*ez)\n    end\nelseif s.phase==2 and p.id==s.diveID and s.gx then\n    local dx,dz=s.gx-100,s.gz-100\n    local length=math.sqrt(dx*dx+dz*dz)\n    if length>0 then x,z=100-radius*dx/length,100-radius*dz/length end\nend\nif x then\n    -- Moving player endpoint requires a per-frame line.\n    local drawer=TensorCore.getCachedFlatDrawer(nil,nil,0xFFFF8000,nil,1,0,0)\n    frogGuide.draw(\"p5_wrath\",drawer,p.pos.x,p.pos.y,p.pos.z,x,0.08,z,8,2)\nend\nself.used=true",
							},
						},
					},
				},
				name = "[Draw] Personal Guidance",
			},
		},

		{
			data =
			{
				name = "[Draw] Dive Bait Lock",
				uuid = "7ced81d0-e1ed-6db0-8401-d3609255678f",
				version = 2,
			},
			inheritedObjectUUID = "4495bce3-340a-78ac-857b-0b4bf11a1ae5",
			inheritedOverwrites =
			{
				name = "[Draw] Dive Bait Lock",
			},
		},
	},
	[155] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "1daa36f5-1947-5ac1-b59c-a573c1b7b6e5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"eb75e812-82eb-1d6e-b9ae-515cc84e1638",
									true,
								},

								{
									"b8809567-6f1e-8ee9-a5a8-c66fd97daa35",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							holdActionDuration = 15,
							holdActionID = 45,
							name = "Storm's Eye",
							uuid = "f8211235-f17e-8331-bd4c-572ec0e21264",
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
							buffID = 2677,
							category = "Self",
							name = "Storm's Eye active",
							uuid = "eb75e812-82eb-1d6e-b9ae-515cc84e1638",
							version = 3,
						},
					},

					{
						data =
						{
							buffCheckType = 3,
							buffDuration = 29.9,
							buffID = 2677,
							category = "Self",
							comparator = 2,
							name = "Storm's Eye <30s",
							uuid = "b8809567-6f1e-8ee9-a5a8-c66fd97daa35",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1027.9,
				name = "[WAR] Storm's Eye",
				timeRange = true,
				timelineIndex = 155,
				timerEndOffset = 0.5,
				timerOffset = -20,
				timerStartOffset = -20,
				uuid = "9f530549-0c47-1283-a78a-556d74f5d035",
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
							actionID = 7387,
							atomicPriority = true,
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "d7a8753c-4265-c493-9e45-63287165aaa2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1027.9,
				name = "[WAR] Upheaval",
				timelineIndex = 155,
				timerOffset = -1,
				uuid = "5a0863a0-ef59-a9c5-8b7c-ccdef4d7525f",
				version = 2,
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
				uuid = "c15669a2-6cdc-c74e-7df4-a0fc149ec4d2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[157] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "3af20503-6437-558f-3370-69e543e3f273",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[160] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b6561a8d-b66e-51f1-b98b-34af73a203fd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"f1b26fc1-46dd-ae8d-b5b3-ecce10c9a061",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Ascalon",
							uuid = "3a53a72a-0c5f-c664-abfe-fee482dfdecf",
							variableTogglesType = 3,
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
							inRangeValue = 30,
							name = "All 8 within 30y",
							partyTargetNumber = 8,
							partyTargetSubType = "Number",
							uuid = "f1b26fc1-46dd-ae8d-b5b3-ecce10c9a061",
							version = 3,
						},
					},
				},
				mechanicTime = 1042.2,
				name = "[WAR] Shake",
				timelineIndex = 160,
				timerOffset = 1,
				uuid = "4e32d199-2e6f-c7a8-8cec-f6682cca737b",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Ascalon Safety",
							uuid = "2113c89b-fac9-0156-b376-8b2eaee216cc",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1042.2,
				name = "[WAR] Shake - Ascalon Safety",
				timeRange = true,
				timelineIndex = 160,
				timerEndOffset = 10,
				timerOffset = -5,
				uuid = "504284af-2dd8-ad47-8053-1ae713f1924e",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "4c31453b-5553-230f-1f93-a1f9dab5f48b",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8a85f4d4-208d-21c8-3e65-ca727a526204",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7387,
							atomicPriority = true,
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "d7a8753c-4265-c493-9e45-63287165aaa2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1051.2,
				name = "[WAR] Upheaval",
				timelineIndex = 172,
				timerOffset = -1,
				uuid = "0a50c5a4-dcb0-0be4-bda0-071c15fda33c",
				version = 2,
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
				uuid = "0c8d845e-39a0-533a-b5be-ea806f90000e",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"b32cca50-f0b6-b31e-8ef7-a901f95ef07c",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "[WAR] Reprisal - Ancient Quaga 1",
							uuid = "57b407dc-2f35-3b5d-9072-c076afa575b6",
							variableTogglesType = 3,
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
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "6077596e-af34-6ded-ae69-90addf6cfe1f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							comparator = 2,
							conditionLua = "local id=eventArgs.detectionTargetID\nif not id then return false end\nlocal e=TensorCore.mGetEntity(id)\nlocal p=TensorCore.mGetPlayer()\nif not e or not p or not e.pos or not p.pos or not e.hitradius then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz <= (e.hitradius+4.5)^2",
							conditionType = 4,
							inRangeValue = 8,
							name = "Detection target hitbox +4.5y",
							partyTargetType = "Detection Target",
							uuid = "cd8586a5-da34-9357-bf8d-d2df10888b3d",
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
									"6077596e-af34-6ded-ae69-90addf6cfe1f",
									true,
								},

								{
									"cd8586a5-da34-9357-bf8d-d2df10888b3d",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "b32cca50-f0b6-b31e-8ef7-a901f95ef07c",
							version = 3,
						},
					},
				},
				mechanicTime = 1057.2,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 174,
				timerEndOffset = -1,
				timerStartOffset = -9,
				uuid = "fdcdb1d2-c168-b911-bbe6-c578fa6cf964",
				version = 2,
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
				uuid = "f0ad0bb2-470b-e136-822c-fc944cee6fe2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Holmgang",
							uuid = "75d3d56f-c156-9641-81e3-8157069d1f07",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1074,
				name = "[WAR] Holmgang",
				timelineIndex = 178,
				timerOffset = -9,
				uuid = "3fde2144-2a32-29b9-9f46-b2172aca1406",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "436b2275-d4b0-69e3-a429-28c8ecda5fdf",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1074,
				name = "[WAR] Equilibrium",
				timelineIndex = 178,
				timerOffset = 0.5,
				uuid = "8e7c54dd-d2e2-f74b-85ee-69c16e0714a1",
				version = 2,
			},
		},
	},
	[180] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "c04c4d14-b3a9-22a0-50d5-70321576ce24",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Setup + Roster",
				uuid = "216d7dba-a643-32db-8aeb-0380b848b4df",
				version = 2,
			},
			inheritedObjectUUID = "29278938-1a69-45b8-9946-2738079eca0e",
			inheritedOverwrites =
			{
				name = "[Draw] Setup + Roster",
			},
		},

		{
			data =
			{
				name = "[Draw] Knight North Capture",
				uuid = "21c3a706-bb9d-41a7-a5ff-0d656fa56f27",
				version = 2,
			},
			inheritedObjectUUID = "2660c2c1-0627-0145-95bf-93a7d21a2195",
			inheritedOverwrites =
			{
				name = "[Draw] Knight North Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Impact North Capture",
				uuid = "66ae8c0f-bc49-7f3b-a31a-3f07eb4bf814",
				version = 2,
			},
			inheritedObjectUUID = "4093725f-137e-f9a6-8a12-0837c3f21aff",
			inheritedOverwrites =
			{
				name = "[Draw] Impact North Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Doom Capture",
				uuid = "1ad2aa0b-9d4e-6817-9bef-c304fe754a06",
				version = 2,
			},
			inheritedObjectUUID = "75da7914-04d2-9301-8774-d547de1f34d9",
			inheritedOverwrites =
			{
				name = "[Draw] Doom Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Dive + Flare Progress",
				uuid = "0366d3da-c11f-c997-b5fb-c454fd863e61",
				version = 2,
			},
			inheritedObjectUUID = "a9ac8128-fdcd-83c6-9398-ae198710bddc",
			inheritedOverwrites =
			{
				name = "[Draw] Dive + Flare Progress",
			},
		},

		{
			data =
			{
				name = "[Draw] Cleanse Puddle Capture",
				uuid = "ae84b18e-979b-926c-a816-64c0f60d3d37",
				version = 2,
			},
			inheritedObjectUUID = "0b560dba-9528-9efa-8996-11b22293ee59",
			inheritedOverwrites =
			{
				name = "[Draw] Cleanse Puddle Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] PlayStation Capture",
				uuid = "2b80b6de-e9ec-0c23-ad66-e925831874c8",
				version = 2,
			},
			inheritedObjectUUID = "06b597fa-fa3b-d527-a29b-189db4d5446a",
			inheritedOverwrites =
			{
				name = "[Draw] PlayStation Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Assignment Solver",
				uuid = "b0512618-03d4-2191-8b35-469e33101a45",
				version = 2,
			},
			inheritedObjectUUID = "e40fcf03-16ef-42f9-be63-d0de9dbff003",
			inheritedOverwrites =
			{
				name = "[Draw] Assignment Solver",
			},
		},

		{
			data =
			{
				name = "[Draw] Bait Circle Callout",
				uuid = "3bd2eadb-4a4c-f5d0-b681-6fb71d2179ec",
				version = 2,
			},
			inheritedObjectUUID = "12c81a3c-f40a-6f9e-8063-8fb8905101bf",
			inheritedOverwrites =
			{
				name = "[Draw] Bait Circle Callout",
			},
		},

		{
			data =
			{
				name = "[Draw] Personal Guidance",
				uuid = "13918b5d-dba6-9d7c-8524-f706eb3b127f",
				version = 2,
			},
			inheritedObjectUUID = "82ac4b13-5f67-d31e-b22c-56c087e10c14",
			inheritedOverwrites =
			{
				name = "[Draw] Personal Guidance",
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
							aType = "ACR",
							conditions =
							{

								{
									"e57f2a43-4494-264f-aa59-847032ea4c54",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_StormsEye",
							name = "Storm's Eye",
							uuid = "78bcbf3d-8fd3-8149-bbac-185ca84944a5",
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
							buffCheckType = 3,
							buffDuration = 39.9,
							buffID = 2677,
							category = "Self",
							comparator = 2,
							name = "Storm's Eye <40s",
							uuid = "e57f2a43-4494-264f-aa59-847032ea4c54",
							version = 3,
						},
					},
				},
				loop = true,
				mechanicTime = 1085.1,
				name = "[WAR] Storm's Eye",
				timeRange = true,
				timelineIndex = 180,
				timerEndOffset = 3,
				timerStartOffset = -20,
				uuid = "d795768e-661c-9cff-916b-33f28d094440",
				version = 2,
			},
		},
	},
	[181] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "cbbe9fb6-077b-7eb2-9d08-452c26b54be6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7537,
							gVar = "ACR_RikuWAR3_Hotbar_ShirkOT",
							ignoreWeaveRules = true,
							targetType = "Other Tank",
							uuid = "c8d8d343-9da7-1586-a62c-ce5c536e5f1b",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1088.2,
				name = "[WAR] Shirk OT",
				timelineIndex = 181,
				timerOffset = 1,
				uuid = "c6317b74-a567-c852-b389-13c20424c5ef",
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
							actionID = 7387,
							atomicPriority = true,
							ignoreWeaveRules = true,
							targetType = "Current Target",
							uuid = "d7a8753c-4265-c493-9e45-63287165aaa2",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1088.2,
				name = "[WAR] Upheaval",
				timelineIndex = 181,
				timerOffset = -1,
				uuid = "3335f77d-0cab-8e5a-8d68-cc96f4d28597",
				version = 2,
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
				uuid = "aa2e7155-ee22-1379-2a95-9d576778b8c5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[187] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "4148092c-89c0-bac0-277e-dbb6e82561dc",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[190] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ce688f04-6d6d-9670-e7ee-7932876c4c34",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7389,
							conditions =
							{

								{
									"8cb9cfb5-1028-79c7-917d-fa6619a73357",
									true,
								},

								{
									"2368754b-0de7-4d69-b181-de16f4aa1f8c",
									true,
								},
							},
							ignoreWeaveRules = true,
							uuid = "0f9afd9b-efb0-d928-bbb3-8e131b0104c9",
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
							eventSpellID = 25308,
							uuid = "8cb9cfb5-1028-79c7-917d-fa6619a73357",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local p=TensorCore.mGetPlayer()\nif not p then return false end\nfor _,id in ipairs(eventArgs.hitTargets) do if id==p.id then return true end end\nreturn false",
							name = "Self hit",
							uuid = "2368754b-0de7-4d69-b181-de16f4aa1f8c",
							version = 3,
						},
					},
				},
				eventType = 2,
				mechanicTime = 1115.3,
				name = "[WAR] IR - Faith Unmoving Hit",
				timeRange = true,
				timelineIndex = 190,
				timerEndOffset = 14,
				timerStartOffset = -1,
				uuid = "364d641d-c81d-6513-a3d9-e2a06d3cf6a5",
				version = 2,
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
				uuid = "66e2b71b-0d65-15b7-7840-46c51c52a38b",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[194] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "352cdfb7-2a5b-970b-ab73-0f655b44a7c7",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6d78e6a8-15c4-2d0c-377c-d9e6bf032e18",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							acrOptionType = "Hold Action",
							holdActionDuration = 11,
							holdActionID = 25753,
							uuid = "fae28d58-84fe-238c-94de-5d98a62d752d",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1120.2,
				name = "[WAR] Hold Rend",
				timeRange = true,
				timelineIndex = 194,
				timerStartOffset = -5,
				uuid = "b5635b84-5d29-011b-a3b3-acb18b35d4bb",
				version = 2,
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
				uuid = "c3a62d0e-18c4-34e2-6a33-b5405fd6f4be",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"ab49c4ab-5901-4e13-a16e-ee1607b99088",
									true,
								},

								{
									"4a056843-90f1-7add-be38-d544533821e2",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							name = "[WAR] Reprisal - Ancient Quaga 2",
							uuid = "8dd5d4bf-fdcd-74a0-91f9-1752897cd24e",
							variableTogglesType = 3,
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
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "176aadcf-8e59-cb94-8351-7caa8c219101",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							comparator = 2,
							conditionLua = "local id=eventArgs.detectionTargetID\nif not id then return false end\nlocal e=TensorCore.mGetEntity(id)\nlocal p=TensorCore.mGetPlayer()\nif not e or not p or not e.pos or not p.pos or not e.hitradius then return false end\nlocal dx,dz=p.pos.x-e.pos.x,p.pos.z-e.pos.z\nreturn dx*dx+dz*dz <= (e.hitradius+4.5)^2",
							conditionType = 4,
							inRangeValue = 5,
							name = "Detection target hitbox +4.5y",
							partyTargetType = "Detection Target",
							uuid = "6846a09c-036b-5680-af76-35a795e184c0",
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
									"176aadcf-8e59-cb94-8351-7caa8c219101",
									true,
								},

								{
									"6846a09c-036b-5680-af76-35a795e184c0",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "F - King Thordan",
							partyTargetContentID = 3632,
							uuid = "4a056843-90f1-7add-be38-d544533821e2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							dequeueIfLuaFalse = true,
							eventArgType = 2,
							eventSpellID = 25542,
							name = "Ancient Quaga cast begins",
							uuid = "ab49c4ab-5901-4e13-a16e-ee1607b99088",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1142.2,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerStartOffset = -45,
				uuid = "122886eb-0a54-074e-beae-b17a28579c91",
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
							aType = "ACR",
							conditions =
							{

								{
									"5f33dfc9-a982-1dd9-be68-2b91f188b315",
									true,
								},

								{
									"7aa21bf3-a786-821d-ab08-d8dc839550db",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Ancient Quaga",
							uuid = "5e6644f2-ee36-0d47-835b-75408d0cd5d6",
							variableTogglesType = 3,
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
							inRangeValue = 30,
							name = "All 8 within 30y",
							partyTargetNumber = 8,
							partyTargetSubType = "Number",
							uuid = "7aa21bf3-a786-821d-ab08-d8dc839550db",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local t=TensorReactions_CurrentTimer\nlocal s=data.frog_doth_meteor_clear\nif not s or t<s.lastTime-2 then\n s={seen={},count=0,lastTime=t,cleared=false}\n data.frog_doth_meteor_clear=s\nend\ns.lastTime=t\nif s.cleared then return true end\nlocal meteors=TensorCore.getEntityGroupList(\"ContentID\",{contentid=4386})\nif not meteors then return false end\nlocal living=0\nfor _,meteor in pairs(meteors) do\n living=living+1\n if not s.seen[meteor.id] then s.seen[meteor.id]=true; s.count=s.count+1 end\nend\n-- Never treat the empty arena before meteor spawn as a completed mechanic.\nif s.count>=8 and living==0 then s.cleared=true end\nreturn s.cleared",
							name = "All 8 meteors cleared",
							uuid = "5f33dfc9-a982-1dd9-be68-2b91f188b315",
							version = 3,
						},
					},
				},
				mechanicTime = 1142.2,
				name = "[WAR] Shake",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerOffset = -10,
				timerStartOffset = -45,
				uuid = "f5b2778a-60e3-b108-942e-f5c938c5ab88",
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
							aType = "ACR",
							conditions =
							{

								{
									"c328cd34-c980-3657-aa45-56877a7d2e3e",
									true,
								},

								{
									"f11112b4-9c77-f723-bd6d-cd00bc4ca847",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							name = "Shake - Ancient Quaga Safety",
							uuid = "2fd103b1-9a6c-8265-aa71-1e050dc5a26f",
							variableTogglesType = 3,
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
							eventSpellID = 25542,
							name = "Ancient Quaga cast begins",
							uuid = "c328cd34-c980-3657-aa45-56877a7d2e3e",
							version = 3,
						},
					},

					{
						data =
						{
							actionCDValue = 1,
							actionID = 7388,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Shake ready",
							uuid = "f11112b4-9c77-f723-bd6d-cd00bc4ca847",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1142.2,
				name = "[WAR] Shake - Ancient Quaga Safety",
				timeRange = true,
				timelineIndex = 196,
				timerEndOffset = 5,
				timerOffset = -5,
				timerStartOffset = -45,
				uuid = "da66aacd-5a9a-0dfb-9aa0-30727d0f0ad1",
				version = 2,
			},
		},
	},
	[197] =
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
							gVar = "ACR_RikuWAR3_Hotbar_ProvokeMouse",
							targetContentID = 3632,
							targetType = "ContentID",
							uuid = "a49a1f2e-a83d-0c34-8fd0-c2db4ca50636",
							variableIsHover = true,
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
							category = "Filter",
							conditions =
							{

								{
									"65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
									true,
								},

								{
									"4755364a-ba7c-3510-8967-21c24a9347da",
									true,
								},
							},
							filterIncludeDead = true,
							filterTargetType = "Other Tank",
							matchAnyBuff = true,
							name = "F - Check cotank",
							uuid = "f62f94ce-b393-e1a2-9533-49caedd46313",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "PALADIN",
							name = "P - Paladin",
							partyTargetType = "Detection Target",
							uuid = "65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "GUNBREAKER",
							name = "P - Gunbreaker",
							partyTargetType = "Detection Target",
							uuid = "4755364a-ba7c-3510-8967-21c24a9347da",
							version = 3,
						},
					},
				},
				mechanicTime = 1158.4,
				name = "[WAR] Provoke",
				timelineIndex = 197,
				timerOffset = -0.89999997615814,
				uuid = "3bb0a8a4-e6e9-6286-9223-00e0f74c4373",
				version = 2,
			},
		},
	},
	[198] =
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
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "a49a1f2e-a83d-0c34-8fd0-c2db4ca50636",
							variableTogglesType = 3,
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
							conditions =
							{

								{
									"65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
									true,
								},

								{
									"4755364a-ba7c-3510-8967-21c24a9347da",
									true,
								},
							},
							filterIncludeDead = true,
							filterTargetType = "Other Tank",
							matchAnyBuff = true,
							name = "F - Check cotank",
							uuid = "f62f94ce-b393-e1a2-9533-49caedd46313",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "PALADIN",
							name = "P - Paladin",
							partyTargetType = "Detection Target",
							uuid = "65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "GUNBREAKER",
							name = "P - Gunbreaker",
							partyTargetType = "Detection Target",
							uuid = "4755364a-ba7c-3510-8967-21c24a9347da",
							version = 3,
						},
					},
				},
				mechanicTime = 1161.6,
				name = "[WAR] Bloodwhetting",
				timelineIndex = 198,
				timerOffset = -2,
				uuid = "2d017db3-ed9e-c056-b58a-142bee8d5e26",
				version = 2,
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
				uuid = "4cd66640-b560-359c-0504-c7f27b7beff0",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"f62f94ce-b393-e1a2-9533-49caedd46313",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "a49a1f2e-a83d-0c34-8fd0-c2db4ca50636",
							variableTogglesType = 3,
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
							conditions =
							{

								{
									"65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
									true,
								},

								{
									"4755364a-ba7c-3510-8967-21c24a9347da",
									true,
								},
							},
							filterIncludeDead = true,
							filterTargetType = "Other Tank",
							matchAnyBuff = true,
							name = "F - Check cotank",
							uuid = "f62f94ce-b393-e1a2-9533-49caedd46313",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "PALADIN",
							name = "P - Paladin",
							partyTargetType = "Detection Target",
							uuid = "65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "GUNBREAKER",
							name = "P - Gunbreaker",
							partyTargetType = "Detection Target",
							uuid = "4755364a-ba7c-3510-8967-21c24a9347da",
							version = 3,
						},
					},
				},
				mechanicTime = 1164.9,
				name = "[WAR] Damnation",
				timelineIndex = 200,
				timerOffset = -14,
				uuid = "b7acbd71-3e19-36f7-9e5a-ccdd37155d21",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Hotbar_Provoke",
							uuid = "cc333b7d-933d-ca8d-a374-aa6bfbf02afa",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1164.9,
				name = "[WAR] Provoke",
				timelineIndex = 200,
				uuid = "20e20544-a2a7-9bb4-82eb-0e401c0e95dc",
				version = 2,
			},
		},
	},
	[201] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b137bef9-9e52-7185-2dd1-9b134dbc67e9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[203] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "4cc7c104-b6aa-8450-ff5f-5b326a76d054",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "c4dfadc7-2613-b513-a610-57851b736f37",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 7533,
							conditions =
							{

								{
									"8b5cede6-6ea2-d414-bdfe-ebe4abb88f71",
									true,
								},

								{
									"71d23192-e1f9-76e6-9e7c-8e1b4836d9a8",
									true,
								},
							},
							ignoreWeaveRules = true,
							targetType = "Detection Target",
							uuid = "e3229030-0e05-002a-9e5f-731ed34b0a2d",
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							actionID = 7533,
							category = "Self",
							comparator = 2,
							conditionType = 4,
							name = "Provoke ready",
							uuid = "8b5cede6-6ea2-d414-bdfe-ebe4abb88f71",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							filterTargetType = "ContentID",
							name = "Nidhogg",
							partyTargetContentID = 3458,
							uuid = "71d23192-e1f9-76e6-9e7c-8e1b4836d9a8",
							version = 3,
						},
					},
				},
				mechanicTime = 1217.6,
				name = "[WAR] Provoke Nidhogg",
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 30,
				uuid = "5282e1c8-29f8-9d7e-8987-3b5f9f1de894",
				version = 2,
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "Frog",
				uuid = "9a218869-075f-4329-b1ba-3545f3c43c7f",
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
							name = "Dragon HP window",
							uuid = "a9bb561c-d84d-cd89-b1c6-1486b12b3ade",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				displayPath = "Frog",
				eventType = 13,
				mechanicTime = 1217.6,
				name = "[Draw] Dragon HP",
				timeRange = true,
				timelineIndex = 203,
				timerEndOffset = 315.1,
				uuid = "03b229bd-20b7-d887-857e-760acbead950",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "bbff07ba-6699-dd2e-a429-e85c2106110a",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5ae2f7c5-e608-b0b9-bb38-d1870b5c11b5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
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
							name = "Reset mouth glows",
							uuid = "fe0afd9b-24ea-f2b2-bcda-bb17d03d1b8f",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1235.9,
				name = "[WAR] Reset",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -9,
				timerStartOffset = -12,
				uuid = "4cab7dd9-014e-1be5-aba0-f60aaa1c3fe4",
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
							actionLua = "data.frog_war_wb1 = data.frog_war_wb1 or {}\nlocal s = data.frog_war_wb1\nif s.drawGuidance == nil then\n    function s.drawGuidance()\n        if s.guidanceDrawn or s.nidhoggSpell == nil or s.hraesvelgrSpell == nil then return end\n        local player = TensorCore.mGetPlayer()\n        if not player or not player.pos then return end\n        local other = TensorCore.getEntityByGroup(\"Other Tank\")\n        local drawer = TensorCore.getStaticDrawer(0xE0FF8800, 2, 0, Argus2.RenderFlags.FLAG_WARP_TERRAIN + Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n        local duration = 7200\n        local shared = s.nidhoggSpell == 27955 and s.hraesvelgrSpell == 27957\n        local mtx, mtz, otx, otz\n        if shared then\n            mtx, mtz, otx, otz = 100, 100, 100, 100\n        else\n            mtx, mtz, otx, otz = 87, 87, 113, 87\n        end\n        drawer:addTimedCircle(duration, mtx, 0, mtz, 1.0)\n        drawer:addTimedLine(duration, player.pos.x, player.pos.y, player.pos.z, mtx, 0, mtz, 0.5, 0.8)\n        if other and other.pos then\n            if not shared then drawer:addTimedCircle(duration, otx, 0, otz, 1.0) end\n            drawer:addTimedLine(duration, other.pos.x, other.pos.y, other.pos.z, otx, 0, otz, 0.5, 0.8)\n        end\n        s.guidanceDrawn = true\n    end\nend\ns.nidhoggSpell = eventArgs.spellID\ns.nidhogg = eventArgs.spellID == 27955\ns.drawGuidance()\nself.used = true",
							conditions =
							{

								{
									"b046771d-6600-f829-a434-bd101e4eb347",
									true,
								},
							},
							name = "Capture Nidhogg cast",
							uuid = "2e790352-9d4a-e138-adf2-9bb292f172ab",
							version = 2.1,
						},
					},

					{
						data =
						{
							aType = "Lua",
							actionLua = "data.frog_war_wb1 = data.frog_war_wb1 or {}\nlocal s = data.frog_war_wb1\nif s.drawGuidance == nil then\n    function s.drawGuidance()\n        if s.guidanceDrawn or s.nidhoggSpell == nil or s.hraesvelgrSpell == nil then return end\n        local player = TensorCore.mGetPlayer()\n        if not player or not player.pos then return end\n        local other = TensorCore.getEntityByGroup(\"Other Tank\")\n        local drawer = TensorCore.getStaticDrawer(0xE0FF8800, 2, 0, Argus2.RenderFlags.FLAG_WARP_TERRAIN + Argus2.RenderFlags.FLAG_RENDER_OVERLAY)\n        local duration = 7200\n        local shared = s.nidhoggSpell == 27955 and s.hraesvelgrSpell == 27957\n        local mtx, mtz, otx, otz\n        if shared then\n            mtx, mtz, otx, otz = 100, 100, 100, 100\n        else\n            mtx, mtz, otx, otz = 87, 87, 113, 87\n        end\n        drawer:addTimedCircle(duration, mtx, 0, mtz, 1.0)\n        drawer:addTimedLine(duration, player.pos.x, player.pos.y, player.pos.z, mtx, 0, mtz, 0.5, 0.8)\n        if other and other.pos then\n            if not shared then drawer:addTimedCircle(duration, otx, 0, otz, 1.0) end\n            drawer:addTimedLine(duration, other.pos.x, other.pos.y, other.pos.z, otx, 0, otz, 0.5, 0.8)\n        end\n        s.guidanceDrawn = true\n    end\nend\ns.hraesvelgrSpell = eventArgs.spellID\ns.hraesvelgr = eventArgs.spellID == 27957\ns.drawGuidance()\nself.used = true",
							conditions =
							{

								{
									"f035eb93-eb74-1575-8ca5-670516bbd672",
									true,
								},
							},
							name = "Capture Hraesvelgr cast",
							uuid = "a8f6e6c7-034f-aa70-b5b8-1a3a3a6748d0",
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
							eventArgOptionType = 3,
							eventArgType = 2,
							eventIntValue = 1293,
							name = "Nidhogg 27954/27955",
							spellIDList =
							{
								27954,
								27955,
							},
							uuid = "b046771d-6600-f829-a434-bd101e4eb347",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Event",
							comparator = 3,
							dequeueIfLuaFalse = true,
							eventArgOptionType = 3,
							eventArgType = 2,
							eventIntValue = 1294,
							name = "Hraesvelgr 27956/27957",
							spellIDList =
							{
								27956,
								27957,
							},
							uuid = "f035eb93-eb74-1575-8ca5-670516bbd672",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1235.9,
				name = "[WAR] Buster Capture + Spots",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -3.0999999046326,
				timerStartOffset = -9,
				uuid = "5bed6c67-e0ac-39f9-8396-715cae858217",
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
							aType = "ACR",
							conditions =
							{

								{
									"a781eab1-a8d0-e2d2-98fa-4022c8fe6303",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "01e0791d-adc0-dd27-8c94-cef98af950ae",
							variableTogglesType = 3,
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
									"dea27908-b112-572b-b0dc-17cc988ef87a",
									true,
								},

								{
									"0e26e757-dcfe-6570-bb60-41abe16b70ac",
									true,
								},
							},
							endIfUsed = true,
							gVar = "ACR_RikuWAR3_Tankbar_NascentFlashMouse",
							name = "NF - Other tank by job",
							targetType = "Detection Target",
							uuid = "850c5bbd-358f-77f5-a810-55dd370f19ed",
							variableIsHover = true,
							variableTogglesType = 3,
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
							conditionLua = "local s=data.frog_war_wb1\nreturn s~=nil and s.nidhoggSpell~=nil and s.hraesvelgrSpell~=nil",
							conditions =
							{

								{
									"0bba7bae-00a8-fdff-b501-1b7a76cf2874",
									true,
								},

								{
									"cf954640-669a-21fb-9d8d-ab818eb7dfda",
									true,
								},
							},
							matchAnyBuff = true,
							name = "Opposite dragon: BW",
							partyTargetNumber = 0,
							uuid = "a781eab1-a8d0-e2d2-98fa-4022c8fe6303",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Filter",
							conditionLua = "local s=data.frog_war_wb1\nreturn s~=nil and s.hraesvelgrSpell==27957",
							conditions =
							{

								{
									"9bad9c94-e584-ad08-874e-ce57a52f0229",
									true,
								},

								{
									"f9ff6165-f99a-9a5a-a6b9-9f22154551b2",
									true,
								},
							},
							matchAnyBuff = true,
							name = "Opposite dragon: NF",
							partyTargetNumber = 0,
							uuid = "dea27908-b112-572b-b0dc-17cc988ef87a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 9,
							name = "Main Tank",
							partyTargetType = "Main Tank",
							uuid = "7e055d49-cf6b-ea43-9ce4-ca9e3ff1acfa",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Self",
							conditionType = 9,
							name = "Off Tank",
							partyTargetType = "Off Tank",
							uuid = "0fb1bfcb-2eb6-c868-8986-b4a6d7536d42",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 27957,
							conditionType = 5,
							name = "Channel 27957",
							partyTargetType = "Detection Target",
							uuid = "ffb9bd9b-c0f1-bc66-8452-b9c8ec4659c3",
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
									"7e055d49-cf6b-ea43-9ce4-ca9e3ff1acfa",
									true,
								},

								{
									"ffb9bd9b-c0f1-bc66-8452-b9c8ec4659c3",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "MT - Hrae 27957",
							partyTargetContentID = 4954,
							uuid = "0bba7bae-00a8-fdff-b501-1b7a76cf2874",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 27956,
							conditionType = 5,
							name = "Channel 27956",
							partyTargetType = "Detection Target",
							uuid = "9d73ee13-3796-23f8-ab13-4a70f172b73a",
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
									"7e055d49-cf6b-ea43-9ce4-ca9e3ff1acfa",
									true,
								},

								{
									"9d73ee13-3796-23f8-ab13-4a70f172b73a",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "MT - Hrae 27956",
							partyTargetContentID = 4954,
							uuid = "9bad9c94-e584-ad08-874e-ce57a52f0229",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 27955,
							conditionType = 5,
							name = "Channel 27955",
							partyTargetType = "Detection Target",
							uuid = "87bc0b05-353e-d7ae-93c6-745b67d38ce7",
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
									"0fb1bfcb-2eb6-c868-8986-b4a6d7536d42",
									true,
								},

								{
									"87bc0b05-353e-d7ae-93c6-745b67d38ce7",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "OT - Nidhogg 27955",
							partyTargetContentID = 3458,
							uuid = "cf954640-669a-21fb-9d8d-ab818eb7dfda",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 27954,
							conditionType = 5,
							name = "Channel 27954",
							partyTargetType = "Detection Target",
							uuid = "c9f5b43b-5fcc-8aa0-b989-365b27b26a44",
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
									"0fb1bfcb-2eb6-c868-8986-b4a6d7536d42",
									true,
								},

								{
									"c9f5b43b-5fcc-8aa0-b989-365b27b26a44",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "OT - Nidhogg 27954",
							partyTargetContentID = 3458,
							uuid = "f9ff6165-f99a-9a5a-a6b9-9f22154551b2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "PALADIN",
							name = "Paladin",
							partyTargetType = "Detection Target",
							uuid = "d53d047a-4474-a8a2-ac3e-caaf6b4cb163",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "WARRIOR",
							name = "Warrior",
							partyTargetType = "Detection Target",
							uuid = "c8c8c2d5-3bd2-4573-bfa4-d7357c10a9f2",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "DARKKNIGHT",
							name = "Darkknight",
							partyTargetType = "Detection Target",
							uuid = "221399a1-eec7-f795-a62f-c6e6bd637850",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "GUNBREAKER",
							name = "Gunbreaker",
							partyTargetType = "Detection Target",
							uuid = "c83f8395-e2b6-d18d-98f7-2756bb886cad",
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
									"d53d047a-4474-a8a2-ac3e-caaf6b4cb163",
									true,
								},

								{
									"c8c8c2d5-3bd2-4573-bfa4-d7357c10a9f2",
									true,
								},

								{
									"221399a1-eec7-f795-a62f-c6e6bd637850",
									true,
								},

								{
									"c83f8395-e2b6-d18d-98f7-2756bb886cad",
									true,
								},
							},
							matchAnyBuff = true,
							name = "Tank jobs",
							partyTargetNumber = 0,
							uuid = "f3f92ab9-f622-a235-9701-981fc5d0f992",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 10,
							name = "Is self",
							partyTargetType = "Detection Target",
							uuid = "babf4605-0f2a-d1c1-88d8-539958763a2e",
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
									"babf4605-0f2a-d1c1-88d8-539958763a2e",
									false,
								},

								{
									"f3f92ab9-f622-a235-9701-981fc5d0f992",
									true,
								},
							},
							filterTargetType = "Party",
							name = "Other tank by job",
							uuid = "0e26e757-dcfe-6570-bb60-41abe16b70ac",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.9,
				name = "[WAR] Bloodwhetting / Nascent",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -0.1,
				timerStartOffset = -3,
				uuid = "f51aa18f-7627-8345-82fb-53e58b27fa60",
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
							aType = "ACR",
							conditions =
							{

								{
									"f62f94ce-b393-e1a2-9533-49caedd46313",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "a49a1f2e-a83d-0c34-8fd0-c2db4ca50636",
							variableTogglesType = 3,
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
							conditions =
							{

								{
									"65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
									true,
								},
							},
							filterIncludeDead = true,
							filterTargetType = "Other Tank",
							name = "F - Check cotank",
							uuid = "f62f94ce-b393-e1a2-9533-49caedd46313",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							conditionType = 7,
							jobValue = "DARKKNIGHT",
							name = "P - Dark Knight",
							partyTargetType = "Detection Target",
							uuid = "65aef9d8-b1eb-432d-bce2-f7598e6dbd46",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.9,
				name = "[WAR] Damnation",
				timelineIndex = 206,
				timerOffset = -13,
				uuid = "888adbdb-b976-f41e-bc5d-608014cb8052",
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
									"c538085b-2485-153a-8637-1c5ddf3f090e",
									true,
								},
							},
							endIfUsed = true,
							name = "Shared buster",
							uuid = "bc4b3423-03be-dd88-8833-adce55a1d72c",
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
									"4210bc4c-d58e-271d-aafe-58b3ee2315cd",
									true,
								},
							},
							endIfUsed = true,
							name = "Buster on you",
							uuid = "cc0229de-46ca-b69e-8cf8-b7966e063a55",
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
									"01c21a50-fece-bbc1-95ef-dc1c7c701a46",
									true,
								},
							},
							endIfUsed = true,
							name = "Buster on other tank",
							uuid = "44e59a28-6067-3668-8b3e-6da4cc816751",
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
							uuid = "c538085b-2485-153a-8637-1c5ddf3f090e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_war_wb1\nreturn s~=nil and s.hraesvelgr==true and s.nidhogg~=true",
							name = "Buster on you",
							uuid = "4210bc4c-d58e-271d-aafe-58b3ee2315cd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_war_wb1\nreturn s~=nil and s.nidhogg==true and s.hraesvelgr~=true",
							name = "Buster on other tank",
							uuid = "01c21a50-fece-bbc1-95ef-dc1c7c701a46",
							version = 3,
						},
					},
				},
				mechanicTime = 1235.9,
				name = "[WAR] Buster Callout",
				timeRange = true,
				timelineIndex = 206,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "d188950d-6d9b-f64f-aed3-1789857637d3",
				version = 2,
			},
		},
	},
	[207] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "d0b483d8-6e09-a05c-9cba-252e8d6e4768",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Vow Assignment",
				uuid = "324ad634-d631-b43f-9ea2-1069bea761b8",
				version = 2,
			},
			inheritedObjectUUID = "75468594-1190-acdd-97da-b53332268b43",
			inheritedOverwrites =
			{
				name = "[Draw] Vow Assignment",
			},
		},

		{
			data =
			{
				name = "[Draw] Vow Transfer",
				uuid = "6a72153f-5e00-5d5a-82c3-d4cd66e14f5c",
				version = 2,
			},
			inheritedObjectUUID = "1de71efc-297c-9413-a1b9-afb354dec20c",
			inheritedOverwrites =
			{
				name = "[Draw] Vow Transfer",
			},
		},

		{
			data =
			{
				name = "[Draw] Vow Guidance",
				uuid = "57e4adfa-71ce-74fa-907f-a81112c37697",
				version = 2,
			},
			inheritedObjectUUID = "27e0136f-a29f-afa4-91b8-0f9689614736",
			inheritedOverwrites =
			{
				name = "[Draw] Vow Guidance",
			},
		},

		{
			data =
			{
				name = "[Callout] Vow Callout",
				uuid = "60a4855f-bb4b-9cff-ae5c-5ec1eb859a54",
				version = 2,
			},
			inheritedObjectUUID = "209b208f-2719-b2a3-a9fa-e260d1405aed",
			inheritedOverwrites =
			{
				name = "[Callout] Vow Callout",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "728fcc53-b37a-eb87-edc6-96b93f3680c3",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[208] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "8db3e407-1d67-4ec3-ab9f-22712dc845d7",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Callout] HP Callout",
				uuid = "409cf895-58b0-a3f0-96d4-52d24c8e4f69",
				version = 2,
			},
			inheritedObjectUUID = "f40cd0cd-fe88-0832-8d60-06d3e2339b6c",
			inheritedOverwrites =
			{
				name = "[Callout] HP Callout",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "c09e10b8-410e-1414-948d-ffeaf346d828",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Target hraes",
				uuid = "80658efe-833c-68fd-8ddd-871c2f9ea03a",
				version = 2,
			},
			inheritedObjectUUID = "7fab58f7-f2d1-a146-98a5-ecb80d086ba2",
			inheritedOverwrites =
			{
				timerOffset = 2,
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
							aType = "ACR",
							conditions =
							{

								{
									"6a831fc7-cbd8-783c-92c3-d5b71baf03d8",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "a6e43c2a-3d89-e7cd-99d8-ce2907620462",
							variableTogglesType = 3,
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
							conditionLua = "data.frog_p6_reprisal = data.frog_p6_reprisal or {\n    nidhogg = {contentid = 3458},\n    hraesvelgr = {contentid = 4954}\n}\nlocal s = data.frog_p6_reprisal\nlocal p = TensorCore.mGetPlayer()\nlocal n = TensorCore.getEntityByGroup(\"ContentID\", s.nidhogg)\nlocal h = TensorCore.getEntityByGroup(\"ContentID\", s.hraesvelgr)\nif not p or not n or not h or not n.hitradius or not h.hitradius then return false end\nlocal nx, nz = p.pos.x - n.pos.x, p.pos.z - n.pos.z\nlocal hx, hz = p.pos.x - h.pos.x, p.pos.z - h.pos.z\nreturn nx * nx + nz * nz <= (4.5 + n.hitradius)^2\n   and hx * hx + hz * hz <= (4.5 + h.hitradius)^2",
							name = "Both dragons hitbox +4.5y",
							uuid = "6a831fc7-cbd8-783c-92c3-d5b71baf03d8",
							version = 3,
						},
					},
				},
				mechanicTime = 1254.2,
				name = "[WAR] Akh Afah 1 Reprisal Both",
				timeRange = true,
				timelineIndex = 208,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "9786e68d-1551-d4d6-901a-5039dfb34b58",
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
				uuid = "2f0ab251-3793-8b3d-4503-8d6be186f501",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[211] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a6e36d02-548c-936e-4ff1-0aec1589d832",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "34f74800-ea20-a236-a322-a143eeef16cb",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1268.7,
				name = "[WAR] Rampart",
				timelineIndex = 211,
				timerEndOffset = -0.10000000149012,
				timerOffset = -18,
				timerStartOffset = -18,
				uuid = "c4cad035-be6f-f387-a75c-e5610dca43eb",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "52f9dcef-d6f4-c5ba-876a-4bdbdf525a22",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1268.7,
				name = "[WAR] Bloodwhetting",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -3,
				uuid = "07e69fef-be80-74a8-a520-5961a038f2db",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "c359246c-5487-906c-9087-ed65188b5427",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1268.7,
				name = "[WAR] Equilibrium",
				timeRange = true,
				timelineIndex = 211,
				timerEndOffset = 5,
				timerStartOffset = 1,
				uuid = "fb14818f-9792-bbc5-b15e-c605beeee00b",
				version = 2,
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
				uuid = "e8915e55-93b7-8c61-315b-b5a3a5dba5c5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[213] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "737a0683-e2a7-f96f-5842-8c290271fed3",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Start Setup",
				uuid = "26b9daf6-2126-a9ab-b950-c4457c8ff2e3",
				version = 2,
			},
			inheritedObjectUUID = "20858df7-dd6b-d8fb-9d50-cd29fabab34e",
			inheritedOverwrites =
			{
				name = "[Draw] Start Setup",
			},
		},

		{
			data =
			{
				name = "[Draw] Orb Order + Start",
				uuid = "e25dfb7f-fb1b-8ea0-ae60-093833d671c7",
				version = 2,
			},
			inheritedObjectUUID = "a174b377-08ab-7323-995a-a1d31955d057",
			inheritedOverwrites =
			{
				name = "[Draw] Orb Order + Start",
			},
		},

		{
			data =
			{
				name = "[Draw] Dive + Stack Countdown",
				uuid = "7de6c271-f696-3bd9-b065-6e2b160c4e3c",
				version = 2,
			},
			inheritedObjectUUID = "9162dbb8-ebbd-ce21-a38c-b8bf30031945",
			inheritedOverwrites =
			{
				name = "[Draw] Dive + Stack Countdown",
			},
		},

		{
			data =
			{
				name = "[Draw] Dragon Arrival",
				uuid = "a8a975d3-2dbb-33dd-b3e9-82041a7776db",
				version = 2,
			},
			inheritedObjectUUID = "f5e84434-d959-37d6-9c9f-d2ca171bc691",
			inheritedOverwrites =
			{
				name = "[Draw] Dragon Arrival",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7faaf62c-91e2-d908-a1a0-34c226884edc",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Target nidhog",
				uuid = "e5792e2a-20d4-8a6d-9d8f-92eb5c8d089d",
				version = 2,
			},
			inheritedObjectUUID = "ddbdd4be-660e-bd05-9a20-0a5c0d514451",
			inheritedOverwrites =
			{
				timerOffset = 0,
			},
		},
	},
	[214] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0d384e57-f167-507b-57d6-ee490fd85bc7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "60744fd2-6ddc-2657-bdb3-2a11503e2650",
							variableTogglesType = 3,
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
							inRangeValue = 30,
							partyTargetNumber = 8,
							partyTargetSubType = "Number",
							uuid = "7049b736-b290-ba21-8fcc-6ee237151598",
							version = 3,
						},
					},
				},
				mechanicTime = 1293.5,
				name = "[WAR] Shake",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = -2,
				timerOffset = -10,
				timerStartOffset = -10,
				uuid = "dfc84254-933b-c518-88c2-5dd7f1986570",
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
							actionLua = "local v=data.frog_vow_v1\nif not v or not v.ready or not v.holder then return end\ndata.frog_wroth_rend_hold={active=true,holder=v.holder}\nTensorCore.API.TensorACR.holdActionUntil(25753,Now()+25000,1)\nTensorCore.API.TensorACR.holdActionUntil(7386,Now()+25000,3)\nself.used=true",
							name = "Hold Primal Rend",
							uuid = "8551b9f5-f8a9-7bdf-b45a-24f549daf0d8",
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
									"0f59cc55-7e30-c9b1-89cf-d1e2a6b74085",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Sprint",
							uuid = "a257ce58-0219-57a2-8be1-1ec4248076d9",
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
							category = "Lua",
							conditionLua = "return TensorReactions_CurrentTimer>=1292.5",
							name = "Akh Morn -1s",
							uuid = "0f59cc55-7e30-c9b1-89cf-d1e2a6b74085",
							version = 3,
						},
					},
				},
				mechanicTime = 1293.5,
				name = "[WAR] Jump Hold + Sprint",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = 1,
				timerStartOffset = -2,
				uuid = "c4c7057b-7b64-3db5-8835-b0804cba2abd",
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
							actionLua = "local h=data.frog_wroth_rend_hold\nif h and h.active then\n    TensorCore.API.TensorACR.holdActionUntil(25753,Now(),1)\n    TensorCore.API.TensorACR.holdActionUntil(7386,Now(),3)\n    h.active=false\nend\nself.used=true",
							conditions =
							{

								{
									"b83aea3f-95eb-06c8-8cfa-3e424894692b",
									true,
								},

								{
									"02fb6c2c-b692-7702-a181-fe16c3e1ee77",
									true,
								},
							},
							name = "Release Primal Rend",
							uuid = "b482fd64-3667-84a1-98f5-f99d1a00eaf5",
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
							name = "Mortal Vow",
							uuid = "b83aea3f-95eb-06c8-8cfa-3e424894692b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local h=data.frog_wroth_rend_hold\nlocal v=data.frog_vow_v1\nif not h or not h.active or not v or not v.slots or eventArgs.entityID==h.holder then return false end\nfor _,id in pairs(v.slots) do\n    if id==eventArgs.entityID then return true end\nend\nreturn false",
							name = "Next Vow recipient",
							uuid = "02fb6c2c-b692-7702-a181-fe16c3e1ee77",
							version = 3,
						},
					},
				},
				eventType = 8,
				loop = true,
				mechanicTime = 1293.5,
				name = "[WAR] Jump Release",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = 28,
				timerStartOffset = -2,
				uuid = "27cd9f96-7f57-f0e5-9535-791f8e6215cc",
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
							actionLua = "local old=eventArgs.oldData\nlocal h=old and old.frog_wroth_rend_hold\nif h and h.active then\n    TensorCore.API.TensorACR.holdActionUntil(25753,Now(),1)\n    TensorCore.API.TensorACR.holdActionUntil(7386,Now(),3)\n    h.active=false\nend\nself.used=true",
							name = "Release Wroth hold",
							uuid = "80a36e6b-f03d-7ed9-a943-3875cb112080",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				eventType = 9,
				loop = true,
				mechanicTime = 1293.5,
				name = "[WAR] Jump Cleanup",
				timeRange = true,
				timelineIndex = 214,
				timerEndOffset = 1000,
				timerStartOffset = -1293.5,
				uuid = "9ef9b24e-5d34-272d-946e-626da3d2d9fb",
				version = 2,
			},
		},
	},
	[215] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0a218cb6-aac6-087a-8ba7-18d0651838e6",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[216] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ace7df89-e50e-0acd-a20a-da17fc306cf9",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[218] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "88a50dbb-9a4c-f417-eccb-f0cd7da0f3ab",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[219] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fcb5feba-5896-4a76-1c8f-4664c45cfc2a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[220] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "6d967cfa-8ddc-3586-f75a-de989a993c6a",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[222] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "d7a1d4e4-2de4-e7e0-982e-a53e4ed73694",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[223] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "6899f5b2-75b2-c2ce-e38d-2684fbb9eec2",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Callout] HP Callout",
				uuid = "652c38a9-9c7b-a8ec-a1f4-ebb40da39768",
				version = 2,
			},
			inheritedObjectUUID = "a5c4a381-5733-b0c7-b3d4-5c82148a4550",
			inheritedOverwrites =
			{
				name = "[Callout] HP Callout",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "a7de7f4d-386f-5119-898c-7eff455cadbd",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"82f7ad45-4002-1619-89de-27379201bab7",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "b3584f4d-eb09-83aa-9da3-efa540f6f8cb",
							variableTogglesType = 3,
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
							conditionLua = "data.frog_p6_reprisal = data.frog_p6_reprisal or {\n    nidhogg = {contentid = 3458},\n    hraesvelgr = {contentid = 4954}\n}\nlocal s = data.frog_p6_reprisal\nlocal p = TensorCore.mGetPlayer()\nlocal n = TensorCore.getEntityByGroup(\"ContentID\", s.nidhogg)\nlocal h = TensorCore.getEntityByGroup(\"ContentID\", s.hraesvelgr)\nif not p or not n or not h or not n.hitradius or not h.hitradius then return false end\nlocal nx, nz = p.pos.x - n.pos.x, p.pos.z - n.pos.z\nlocal hx, hz = p.pos.x - h.pos.x, p.pos.z - h.pos.z\nreturn nx * nx + nz * nz <= (4.5 + n.hitradius)^2\n   and hx * hx + hz * hz <= (4.5 + h.hitradius)^2",
							name = "Both dragons hitbox +4.5y",
							uuid = "82f7ad45-4002-1619-89de-27379201bab7",
							version = 3,
						},
					},
				},
				mechanicTime = 1323.7,
				name = "[WAR] Akh Afah 2 Reprisal Both",
				timeRange = true,
				timelineIndex = 223,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "0d414497-cc09-88c1-9e1e-965b62e081f3",
				version = 2,
			},
		},
	},
	[229] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ec6e4423-4b46-cabf-b26a-af5933dcd793",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ThrillOfBattle",
							uuid = "ca66cf78-fd2d-9df0-90fd-0b3ebc4eb78b",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1337,
				name = "[WAR] Thrill",
				timeRange = true,
				timelineIndex = 229,
				timerEndOffset = -0.1,
				timerStartOffset = -8,
				uuid = "ea8cc92f-3598-bdcc-927d-bff64d2611d6",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "c6c4a3c1-af27-4ba4-bf06-6220347878f8",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1337,
				name = "[WAR] Bloodwhetting",
				timeRange = true,
				timelineIndex = 229,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -3,
				uuid = "a2685d1d-9aff-7f6b-8843-0e2253148354",
				version = 2,
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
				uuid = "e87c0f5d-6ddf-99a9-ea33-159bf2d72d4d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[232] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "0fbce28b-2670-00f7-986c-d3edff3072fb",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Disable CD",
				uuid = "5d87c71a-1592-020a-9d0a-9085ea68d431",
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
				uuid = "88b1398a-563f-d098-9add-97a396632e77",
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
				uuid = "4fa698c5-1990-aed0-85a9-9b32933e3db0",
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
									"d88092da-3261-86fa-8ac2-442625249af9",
									true,
								},
							},
							name = "Capture nidhogg",
							uuid = "81576431-b937-b88d-87fd-f2fc118e0713",
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
									"53c8f609-acdb-e2d2-a455-e0e6c1da9620",
									true,
								},
							},
							name = "Capture hraesvelgr",
							uuid = "f0a6c7fc-6e9b-8edd-9f36-5033dc9aae4a",
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
							uuid = "d88092da-3261-86fa-8ac2-442625249af9",
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
							uuid = "53c8f609-acdb-e2d2-a455-e0e6c1da9620",
							version = 3,
						},
					},
				},
				eventType = 3,
				loop = true,
				mechanicTime = 1355.7,
				name = "[WAR] Cast Capture",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = -0.1,
				timerStartOffset = -9,
				uuid = "ec90699b-ca41-0314-bbe0-184d89c4cb10",
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
									"db0c1083-3aa0-5ad6-8ded-2eb4db526c6b",
									true,
								},
							},
							endIfUsed = true,
							name = "SHARED",
							uuid = "025519fa-bdc0-8f0a-8be1-a2d09a6de4e3",
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
									"8d0d704f-ec2f-fba5-a54b-d3aad4d4dfeb",
									true,
								},
							},
							endIfUsed = true,
							name = "ON ME",
							uuid = "dc303159-85d4-6db1-b869-4682e483fe55",
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
									"cc12c11a-5afb-ee37-a3f6-3a61c97c5068",
									true,
								},
							},
							endIfUsed = true,
							name = "ON OTHER TANK",
							uuid = "bb355ffc-0016-31b1-bf62-2a2994938c30",
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
							uuid = "db0c1083-3aa0-5ad6-8ded-2eb4db526c6b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_war_wb2\nreturn s~=nil and s.nidhoggSpell==27954 and s.hraesvelgrSpell==27957",
							name = "ON ME",
							uuid = "8d0d704f-ec2f-fba5-a54b-d3aad4d4dfeb",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local s=data.frog_war_wb2\nreturn s~=nil and s.nidhoggSpell==27955 and s.hraesvelgrSpell==27956",
							name = "ON OTHER TANK",
							uuid = "cc12c11a-5afb-ee37-a3f6-3a61c97c5068",
							version = 3,
						},
					},
				},
				mechanicTime = 1355.7,
				name = "[WAR] Buster Callout",
				timeRange = true,
				timelineIndex = 232,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -8,
				uuid = "7f550608-2f75-a28c-9727-89554429c851",
				version = 2,
			},
		},
	},
	[233] =
	{

		{
			data =
			{
				displayPath = "",
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "c17d26a9-23dc-b265-0a3f-6c034857a279",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Fixed Spots",
				uuid = "40e77a31-59b0-e0c1-86c5-388056aa547b",
				version = 2,
			},
			inheritedObjectUUID = "df791e7b-33bc-51ba-a11d-855883a34444",
			inheritedOverwrites =
			{
				name = "[Draw] Fixed Spots",
			},
		},

		{
			data =
			{
				name = "[Opti] Pyretic Hold",
				uuid = "fa2899f9-150f-7dd7-988e-923c425ae7a3",
				version = 2,
			},
			inheritedObjectUUID = "bdd90e87-11a0-0dab-ae66-0d6e513e0267",
			inheritedOverwrites =
			{
				name = "[Opti] Pyretic Hold",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "8eeb7c0a-2c09-d356-51b8-ed84b88f2afa",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "d1c4192c-f338-2871-841a-0cf34de7bab3",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1356.5,
				name = "[WAR] Rampart",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -18,
				uuid = "834d07d5-3fe7-dcaa-b907-36485cdc0fdd",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "6961464d-1fdd-12a1-950e-4660c8c8583f",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1356.5,
				name = "[WAR] Damnation",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = -0.1,
				timerStartOffset = -13,
				uuid = "ec6ad102-c55a-76f5-9eb9-175d3df4145e",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Equilibrium",
							uuid = "9dcf8cc9-e07e-6c56-ad74-102960238672",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1356.5,
				name = "[WAR] Equilibrium",
				timeRange = true,
				timelineIndex = 233,
				timerEndOffset = 5,
				timerStartOffset = 1,
				uuid = "b99a3c33-8da1-959b-bd05-631d2c465604",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "8d5788fe-5cbe-2ea2-8ff6-6f9401eeab4e",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Capture",
				uuid = "ea2f05a9-42d0-8ddb-a478-96988c570917",
				version = 2,
			},
			inheritedObjectUUID = "87df69e5-6e9b-1f30-9ade-fdd37deb1974",
			inheritedOverwrites =
			{
				name = "[Draw] Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Guidance",
				uuid = "5a352f4a-0852-9da3-be72-f0e60a25aa10",
				version = 2,
			},
			inheritedObjectUUID = "5abcd529-7fc3-8f73-9f06-1fbb25c713ca",
			inheritedOverwrites =
			{
				name = "[Draw] Guidance",
			},
		},

		{
			data =
			{
				name = "[Opti] Hit Tracking",
				uuid = "0e12ee88-06eb-cfec-a8ec-1b4fd2e7b771",
				version = 2,
			},
			inheritedObjectUUID = "5064c709-5e23-26d6-b0eb-eb0fe95e9753",
			inheritedOverwrites =
			{
				name = "[Opti] Hit Tracking",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5324d6b1-993c-af75-7f17-9dcfa180aee1",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Holmgang",
							uuid = "3b83acea-3095-b8ff-85d8-d709dc7a7601",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1369,
				name = "[WAR] Cauterize Holmgang",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -3,
				uuid = "91e228cf-ff04-0a7d-bdfa-4163a0c4ead2",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_NascentFlashMouse",
							targetType = "Other Tank",
							uuid = "bf61f1de-ba0f-24f8-88f6-1370a412dae8",
							variableIsHover = true,
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1369,
				name = "[WAR] Cauterize Nascent Cotank",
				timeRange = true,
				timelineIndex = 234,
				timerEndOffset = -0.1,
				timerStartOffset = -3,
				uuid = "0fcd3a82-9d7e-8059-ba23-e1c7db69c0d6",
				version = 2,
			},
		},
	},
	[235] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "b26d6d18-c198-c34c-46f6-8b8e9fabfb88",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[236] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "449f0d7f-b684-7d83-df09-620186356eaf",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[237] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "534133be-3ce8-e222-f0c9-45286255b5ee",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[239] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "5771ae3c-212f-abe8-2454-fb6255fc476c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[242] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "ffb956a2-4751-1836-51ba-6a285301b1d2",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"692c3fed-a6d9-aff2-9e7a-0f1c0b1ca621",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "7b08fd72-7dff-b12e-8a74-8f6fe6085c20",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{

					{
						data =
						{
							buffCheckType = 2,
							buffID = 2951,
							category = "Self",
							name = "Transition bleed gone",
							uuid = "692c3fed-a6d9-aff2-9e7a-0f1c0b1ca621",
							version = 3,
						},
					},
				},
				mechanicTime = 1532.8,
				name = "[WAR] Shake After Bleed",
				timeRange = true,
				timelineIndex = 242,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "2f3c12e4-c057-bca9-8c34-68a122f6e6ef",
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
				name = "Frog\\Ultimates\\DSR\\Draws",
				uuid = "8831e308-899f-7fec-07fd-9446e1b3fed8",
			},
			inheritanceRoot = "Frog\\Ultimates\\DSR\\Draws",
			objectType = "folder",
		},

		{
			data =
			{
				name = "[Draw] Fire Ice Telegraph",
				uuid = "d797dd81-f639-f808-9c9d-e99018664efc",
				version = 2,
			},
			inheritedObjectUUID = "588a5d0c-7ffb-684c-928e-7318d0f5a1b4",
			inheritedOverwrites =
			{
				name = "[Draw] Fire Ice Telegraph",
			},
		},

		{
			data =
			{
				name = "[Draw] Fire Ice Resolution",
				uuid = "96fa6d95-2f79-a803-bede-037263dee1bd",
				version = 2,
			},
			inheritedObjectUUID = "58eaf718-4d20-ba31-ab09-331d56058692",
			inheritedOverwrites =
			{
				name = "[Draw] Fire Ice Resolution",
			},
		},

		{
			data =
			{
				name = "[Draw] Role Setup",
				uuid = "ad967db0-8749-6d19-9c69-9a355a30a178",
				version = 2,
			},
			inheritedObjectUUID = "d404a5bc-972e-dc82-b369-707d02a2f410",
			inheritedOverwrites =
			{
				name = "[Draw] Role Setup",
			},
		},

		{
			data =
			{
				name = "[Draw] Tower + Flare Capture",
				uuid = "27ee3c68-e62b-f435-b7d6-d6d28b39bc64",
				version = 2,
			},
			inheritedObjectUUID = "d9da5c3b-3609-9d19-802a-f96e73cb9c29",
			inheritedOverwrites =
			{
				name = "[Draw] Tower + Flare Capture",
			},
		},

		{
			data =
			{
				name = "[Draw] Mechanic Progress",
				uuid = "d96aad35-833c-e471-b9bc-8b1970510e75",
				version = 2,
			},
			inheritedObjectUUID = "5a3885b5-14f8-562c-b113-f1d5e3fababb",
			inheritedOverwrites =
			{
				name = "[Draw] Mechanic Progress",
			},
		},

		{
			data =
			{
				name = "[Draw] Personal Guidance",
				uuid = "3462c5d8-5aed-5097-a415-f62b380d7a6e",
				version = 2,
			},
			inheritedObjectUUID = "36b39445-1b58-5601-9cf0-58dc33461b9e",
			inheritedOverwrites =
			{
				name = "[Draw] Personal Guidance",
			},
		},

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "7954f203-4a67-d9d7-3ffa-87018246df73",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"6af3157d-bc61-48be-968d-ec1ae6e6c00b",
									true,
								},

								{
									"60097937-87a6-26a1-b948-5991c182f7a8",
									true,
								},

								{
									"2a1de351-3a3d-44c0-a847-bebb435d3235",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "8592ea56-b1c4-b901-a858-523d921c51e4",
							variableTogglesType = 2,
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"6af3157d-bc61-48be-968d-ec1ae6e6c00b",
									true,
								},

								{
									"60097937-87a6-26a1-b948-5991c182f7a8",
									true,
								},

								{
									"2a1de351-3a3d-44c0-a847-bebb435d3235",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ProvokeMouse",
							ignoreWeaveRules = true,
							targetType = "Detection Target",
							uuid = "e0866b90-d2ea-3400-b83e-0b4cfa8412cb",
							variableIsHover = true,
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "6af3157d-bc61-48be-968d-ec1ae6e6c00b",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "2a1de351-3a3d-44c0-a847-bebb435d3235",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "8a144a3a-a7ec-3891-a2d9-1281b602cb47",
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
									"8a144a3a-a7ec-3891-a2d9-1281b602cb47",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "60097937-87a6-26a1-b948-5991c182f7a8",
							version = 3,
						},
					},
				},
				mechanicTime = 1542.1,
				name = "[WAR] Stance + Provoke",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 5,
				timerStartOffset = -1,
				uuid = "40f13c4f-b828-1d07-a05d-a404dedecd79",
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
									"f2237c3e-2ab6-6ba7-8ea7-40b789aa76a6",
									true,
								},
							},
							name = "Latch reversed assignment",
							uuid = "643c81d7-28b5-09dc-beca-f7f3008d6932",
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
									"f2237c3e-2ab6-6ba7-8ea7-40b789aa76a6",
									true,
								},
							},
							uuid = "dda7f836-9bdc-8d42-8a60-0e85a8ff876f",
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
							uuid = "f2237c3e-2ab6-6ba7-8ea7-40b789aa76a6",
							version = 3,
						},
					},
				},
				mechanicTime = 1542.1,
				name = "[WAR] Reverse Handoffs",
				timeRange = true,
				timelineIndex = 243,
				timerEndOffset = 25.5,
				timerStartOffset = 22,
				uuid = "27cfa93d-696f-0e42-9060-0c24c0dd4032",
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
				uuid = "db3c3b30-bcda-81ac-8608-c21a3bae0a60",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[245] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "30b00e29-25c0-e9d5-4b24-3a9b46387399",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "fbe9d23a-bb45-e6b3-9b61-ec67cb27625f",
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
				uuid = "e4a289c4-20d2-58c8-0bd1-2196e8e8f3f4",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "2796c782-9d73-f6aa-acf9-dde8fafbc252",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1573.9,
				name = "[WAR] Rampart",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = -0.1,
				timerStartOffset = -13,
				uuid = "c7be66a4-b388-77f1-a0b4-10043e3cfc0d",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "7bd73bd0-19c4-941c-bae3-9529e05829c3",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1573.9,
				name = "[WAR] Bloodwhetting",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = -0.1,
				timerStartOffset = -1,
				uuid = "9b071246-b1ea-74be-8b37-7be256c92e85",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "5a928860-0aa5-e72a-b41b-cb7f572246f6",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1573.9,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = -0.1,
				timerStartOffset = -3,
				uuid = "5fd53ff9-83b4-20d4-99a2-a34a72081bd9",
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
							aType = "ACR",
							conditions =
							{

								{
									"a0baaa84-b111-da9d-a8f8-57d31bca2218",
									false,
								},

								{
									"d218e620-7816-89e9-bc2c-5a62d5d57719",
									true,
								},

								{
									"da4d80e3-2048-8891-a1bc-1bcb28b59105",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ShirkMouse",
							targetType = "Other Tank",
							uuid = "a3a9054b-f329-5479-b626-e08619823013",
							variableIsHover = true,
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
									"a0baaa84-b111-da9d-a8f8-57d31bca2218",
									false,
								},

								{
									"d218e620-7816-89e9-bc2c-5a62d5d57719",
									true,
								},

								{
									"da4d80e3-2048-8891-a1bc-1bcb28b59105",
									true,
								},

								{
									"ea534df9-2f43-e09a-a355-12efc94b960e",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "1c0d876b-fa06-9909-92a1-80bbc0f3a531",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "d218e620-7816-89e9-bc2c-5a62d5d57719",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "ea534df9-2f43-e09a-a355-12efc94b960e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "cfd8c7f7-d747-03f7-8402-9e915d0a9aac",
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
									"cfd8c7f7-d747-03f7-8402-9e915d0a9aac",
									true,
								},

								{
									"49a2927a-b2dd-18c4-8976-177ba49a822e",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "da4d80e3-2048-8891-a1bc-1bcb28b59105",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "49a2927a-b2dd-18c4-8976-177ba49a822e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "a0baaa84-b111-da9d-a8f8-57d31bca2218",
							version = 3,
						},
					},
				},
				mechanicTime = 1573.9,
				name = "[WAR] Trinity 2 Shirk + Release",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "cc717d1e-37d4-6ca5-bfc4-d0b62ca92409",
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
							aType = "ACR",
							conditions =
							{

								{
									"b25fca17-255c-8b29-96a1-964abc1be3e2",
									true,
								},

								{
									"0f17cd76-dcaa-8fa9-88d6-60ee73fcc090",
									true,
								},

								{
									"0c0436d0-4fe0-f2d9-9010-bda878356c0d",
									true,
								},

								{
									"b662ff7b-fda1-4cc8-a3ad-780fa3c05f2f",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "508c171f-b2c8-3ad2-a53c-2b41285e67ca",
							variableTogglesType = 2,
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"b25fca17-255c-8b29-96a1-964abc1be3e2",
									true,
								},

								{
									"0f17cd76-dcaa-8fa9-88d6-60ee73fcc090",
									true,
								},

								{
									"0c0436d0-4fe0-f2d9-9010-bda878356c0d",
									true,
								},

								{
									"b662ff7b-fda1-4cc8-a3ad-780fa3c05f2f",
									true,
								},
							},
							targetType = "Detection Target",
							uuid = "35b55e02-d778-0ead-9416-a704d4604371",
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
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "0f17cd76-dcaa-8fa9-88d6-60ee73fcc090",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "b662ff7b-fda1-4cc8-a3ad-780fa3c05f2f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "70c692ea-215c-ce90-8dd4-f6152f8bd95a",
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
									"70c692ea-215c-ce90-8dd4-f6152f8bd95a",
									true,
								},

								{
									"d9fcf09c-48ec-dbf6-8f30-333aec8fd3c6",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "0c0436d0-4fe0-f2d9-9010-bda878356c0d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "d9fcf09c-48ec-dbf6-8f30-333aec8fd3c6",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "b25fca17-255c-8b29-96a1-964abc1be3e2",
							version = 3,
						},
					},
				},
				mechanicTime = 1573.9,
				name = "[WAR] Trinity 2 Reversed Take",
				timeRange = true,
				timelineIndex = 248,
				timerEndOffset = -0.1,
				timerStartOffset = -8,
				uuid = "8dabd3bb-a381-78b4-bc82-864d50d67100",
				version = 2,
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
				uuid = "ce18132d-030b-1321-79e7-0137d763c81d",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "aa3c2abd-ecb1-f243-8726-f4b43d274937",
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
				uuid = "0714271e-e447-6a52-6a0a-50b8dbdc45ce",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[252] =
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
									"57965c76-0205-a160-8e3a-403dba84095e",
									false,
								},

								{
									"5e22499b-07c7-a673-a083-ec8c47b4d359",
									true,
								},

								{
									"05ebf4c2-8ee8-ae6e-8158-a1336fafdf3c",
									true,
								},

								{
									"f040f896-a14d-15f6-a3f4-f9e2a94c0a72",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "4423be39-26f9-f0aa-819b-ca80bc5aaa1f",
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
									"57965c76-0205-a160-8e3a-403dba84095e",
									false,
								},

								{
									"5e22499b-07c7-a673-a083-ec8c47b4d359",
									true,
								},

								{
									"05ebf4c2-8ee8-ae6e-8158-a1336fafdf3c",
									true,
								},

								{
									"f040f896-a14d-15f6-a3f4-f9e2a94c0a72",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ProvokeMouse",
							targetType = "Detection Target",
							uuid = "8b83006b-1d37-c352-83ec-1b42fd8e64a5",
							variableIsHover = true,
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "5e22499b-07c7-a673-a083-ec8c47b4d359",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "f040f896-a14d-15f6-a3f4-f9e2a94c0a72",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "ef5ea997-ba23-cd99-bbd3-c4fe44d3fc66",
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
									"ef5ea997-ba23-cd99-bbd3-c4fe44d3fc66",
									true,
								},

								{
									"ed7b7207-25d5-83d2-ad90-8af25c20ee15",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "05ebf4c2-8ee8-ae6e-8158-a1336fafdf3c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28057,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "ed7b7207-25d5-83d2-ad90-8af25c20ee15",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "57965c76-0205-a160-8e3a-403dba84095e",
							version = 3,
						},
					},
				},
				mechanicTime = 1600.8,
				name = "[WAR] Trinity 4 Defiance + Provoke",
				timeRange = true,
				timelineIndex = 252,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "8c1136a6-f942-82b0-bcf2-995f5e5cfa0f",
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
							aType = "ACR",
							conditions =
							{

								{
									"50bc136f-5cf1-5e94-b2c0-5de8d6054810",
									true,
								},

								{
									"97df4e5b-690c-95c9-835b-b87a9cebf057",
									true,
								},

								{
									"c74bb5c5-6678-d006-ab57-d6630b333361",
									true,
								},

								{
									"faa19e12-0e8d-9682-a8af-9dca5aa55248",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "4d6e734b-33f6-b775-a3e9-75927ce5ac28",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "97df4e5b-690c-95c9-835b-b87a9cebf057",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "faa19e12-0e8d-9682-a8af-9dca5aa55248",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "368486b1-143a-b44e-824f-bff46a36a11e",
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
									"368486b1-143a-b44e-824f-bff46a36a11e",
									true,
								},

								{
									"7c69dd27-0ad1-1d96-ae78-939b83b6121b",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "c74bb5c5-6678-d006-ab57-d6630b333361",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28057,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "7c69dd27-0ad1-1d96-ae78-939b83b6121b",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "50bc136f-5cf1-5e94-b2c0-5de8d6054810",
							version = 3,
						},
					},
				},
				mechanicTime = 1600.8,
				name = "[WAR] Trinity 4 Reversed Release",
				timeRange = true,
				timelineIndex = 252,
				timerEndOffset = -1,
				timerStartOffset = -10,
				uuid = "a5cf8a40-fe69-c354-a69f-9ec50b0e8393",
				version = 2,
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
				uuid = "f99772f8-dbe4-937c-8fdd-e2de2ef8ce68",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "1ed6f093-2c6f-8167-8d1e-3f66962269cc",
				version = 2,
			},
			inheritedObjectUUID = "07467977-ea9b-4621-86d5-00442779c12b",
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
				uuid = "00161beb-e71f-0be7-abf9-b47dd1ed4adb",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[256] =
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
									"c342e28b-c567-3b6a-ad70-aa81708e0298",
									false,
								},

								{
									"c887d08c-727c-3d75-946e-3d2c3c9436cb",
									true,
								},

								{
									"16dc0d3a-1c5b-f54a-9585-2bb068ac229a",
									true,
								},

								{
									"7a9feba2-94b9-1a25-9c50-316d9b23be37",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "e1fae5c5-6ea6-ac66-9a62-94458709d139",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "c887d08c-727c-3d75-946e-3d2c3c9436cb",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "7a9feba2-94b9-1a25-9c50-316d9b23be37",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "328c8ccf-1d6c-9052-bcd2-63ad4114ffa5",
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
									"328c8ccf-1d6c-9052-bcd2-63ad4114ffa5",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "16dc0d3a-1c5b-f54a-9585-2bb068ac229a",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "c342e28b-c567-3b6a-ad70-aa81708e0298",
							version = 3,
						},
					},
				},
				mechanicTime = 1623.1,
				name = "[WAR] Trinity 6 Release Defiance",
				timeRange = true,
				timelineIndex = 256,
				timerEndOffset = 4,
				timerStartOffset = 0.2,
				uuid = "3b8c6671-d5a3-d904-960d-9dff6344283f",
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
							aType = "ACR",
							conditions =
							{

								{
									"86e9f09a-cf8e-0841-8f24-bfd8924ce43b",
									true,
								},

								{
									"cc14d2cd-2d4a-c163-bc07-037fa0bc108d",
									true,
								},

								{
									"6bb6f843-7705-96c6-9e57-bb29971494e6",
									true,
								},

								{
									"6feb1822-31f6-753f-ab87-290283a00e1d",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "b14f29f2-69d0-264b-9d18-71cbaa600bbb",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "cc14d2cd-2d4a-c163-bc07-037fa0bc108d",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "6feb1822-31f6-753f-ab87-290283a00e1d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "3f9a161b-cb35-f329-a83e-811ed13eda5b",
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
									"3f9a161b-cb35-f329-a83e-811ed13eda5b",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "6bb6f843-7705-96c6-9e57-bb29971494e6",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "86e9f09a-cf8e-0841-8f24-bfd8924ce43b",
							version = 3,
						},
					},
				},
				mechanicTime = 1623.1,
				name = "[WAR] Trinity 6 Reversed Stance On",
				timeRange = true,
				timelineIndex = 256,
				timerEndOffset = 4,
				timerStartOffset = 0.2,
				uuid = "bc35bf04-2e71-77fe-99d5-b5d5bf53015d",
				version = 2,
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
				uuid = "03de8894-ccf3-c2e0-22d0-8e2a2f9b37c4",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[258] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "764b6007-863b-a4cb-5aa3-fef934392377",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "be8608e6-c4bb-8c68-bf34-d81d0d3a94a4",
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
				uuid = "6b12b1b6-cc1b-078a-ac25-5da4c6095de6",
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
				uuid = "6e297357-4cec-6e0b-39a6-790d70c980c7",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Damnation",
							uuid = "3e8b10a2-6c74-1ba4-a351-877e2d3c99c2",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1652.9,
				name = "[WAR] Damnation",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -0.1,
				timerStartOffset = -7,
				uuid = "1118e322-ae88-ae54-8873-cc3194fd6886",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_ThrillOfBattle",
							uuid = "2ae4a2c9-6105-c780-84b2-167cd312af5f",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1652.9,
				name = "[WAR] Thrill",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -0.1,
				timerStartOffset = -2,
				uuid = "1d80d1f2-a769-2952-af51-b51d84434275",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Rampart",
							uuid = "bcb17b99-0828-92ef-b1cb-4f7340423fec",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1652.9,
				name = "[WAR] Rampart",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -0.1,
				timerStartOffset = -11,
				uuid = "62a3ea8f-5968-a7a1-a637-c527028b480e",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Bloodwhetting",
							uuid = "deacbd6a-a635-d2c5-b4bc-d5b4bdb0b4f8",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1652.9,
				name = "[WAR] Bloodwhetting",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -0.1,
				timerStartOffset = -0.5,
				uuid = "be68f27d-b5e1-39a3-a7a2-1238ec46f22b",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "cd69c609-d344-6450-b262-f62991e2de1b",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1652.9,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -0.1,
				timerStartOffset = -2,
				uuid = "f60a6629-8413-4647-8831-4a94e01ed2aa",
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
							aType = "ACR",
							conditions =
							{

								{
									"be80bbec-2701-55c4-8951-92ed175c2f3b",
									false,
								},

								{
									"cbc2d359-833a-05f2-a3ec-9ca801500e83",
									true,
								},

								{
									"9213641f-52e4-42e4-a25a-5c61b8dd239c",
									true,
								},

								{
									"c1b656fc-7890-efb6-abe7-b33c21f8f743",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "b2517cbe-fb91-d939-8e5a-9308f697cac0",
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
									"be80bbec-2701-55c4-8951-92ed175c2f3b",
									false,
								},

								{
									"cbc2d359-833a-05f2-a3ec-9ca801500e83",
									true,
								},

								{
									"9213641f-52e4-42e4-a25a-5c61b8dd239c",
									true,
								},

								{
									"c1b656fc-7890-efb6-abe7-b33c21f8f743",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ProvokeMouse",
							targetType = "Detection Target",
							uuid = "3c425620-c956-cf5b-9ff8-3f25e026209a",
							variableIsHover = true,
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "cbc2d359-833a-05f2-a3ec-9ca801500e83",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "c1b656fc-7890-efb6-abe7-b33c21f8f743",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "2f82222f-8a25-d8a5-89a4-fe30ad5d0549",
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
									"2f82222f-8a25-d8a5-89a4-fe30ad5d0549",
									true,
								},

								{
									"b5272cb3-4840-bb65-837e-3428d7560f40",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "9213641f-52e4-42e4-a25a-5c61b8dd239c",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "b5272cb3-4840-bb65-837e-3428d7560f40",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "be80bbec-2701-55c4-8951-92ed175c2f3b",
							version = 3,
						},
					},
				},
				mechanicTime = 1652.9,
				name = "[WAR] Trinity 8 Defiance + Provoke",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "a5ac8d42-4936-0d4f-9646-145e04a1007d",
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
							actionID = 7537,
							conditions =
							{

								{
									"e0f28f4a-6f67-e2c0-be91-77826175db43",
									true,
								},

								{
									"c8ff1ec6-aafd-fc62-8f61-5d3a35a1d8d6",
									true,
								},

								{
									"15c6b639-6b4b-b507-be2e-49341c1376e4",
									true,
								},
							},
							targetType = "Other Tank",
							uuid = "5c03b5a7-535a-2dfc-a462-4787c4fb7855",
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
									"e0f28f4a-6f67-e2c0-be91-77826175db43",
									true,
								},

								{
									"c8ff1ec6-aafd-fc62-8f61-5d3a35a1d8d6",
									true,
								},

								{
									"15c6b639-6b4b-b507-be2e-49341c1376e4",
									true,
								},

								{
									"95d93548-6b78-89eb-a9e0-5877b0e4919f",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "117cf8b0-6a48-0e56-9fc4-80a597ef6cbc",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "c8ff1ec6-aafd-fc62-8f61-5d3a35a1d8d6",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "95d93548-6b78-89eb-a9e0-5877b0e4919f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "cc68d1c4-e410-3341-a31c-e633d9b0a6f4",
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
									"cc68d1c4-e410-3341-a31c-e633d9b0a6f4",
									true,
								},

								{
									"fba8567a-5513-7cd2-9513-9dcc25ab9435",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "15c6b639-6b4b-b507-be2e-49341c1376e4",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "fba8567a-5513-7cd2-9513-9dcc25ab9435",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "e0f28f4a-6f67-e2c0-be91-77826175db43",
							version = 3,
						},
					},
				},
				mechanicTime = 1652.9,
				name = "[WAR] Trinity 8 Reversed Give",
				timeRange = true,
				timelineIndex = 261,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "f1d68368-2c6d-53ad-8898-deff74485e33",
				version = 2,
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
				uuid = "60728d10-b806-16b4-a622-3ebaf8c03940",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "d2459bd8-e870-14d4-b67c-f58b784ef418",
				version = 2,
			},
			inheritedObjectUUID = "2d8981d2-4f42-d2cb-81f3-9b089c94fcaa",
			inheritedOverwrites =
			{
				enabled = false,
			},
		},
	},
	[264] =
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
									"65686981-8a69-d492-8ec2-081b95c7f5b0",
									false,
								},

								{
									"ad9bb268-a923-e3ad-bc42-67e77e6acca7",
									true,
								},

								{
									"18c85f04-7995-190b-91b8-17e95a477bf7",
									true,
								},

								{
									"55fb7baa-3f4c-f797-a20f-dbbfaf82f831",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "ffdf9181-6624-52dc-92c2-632d39bf2c5c",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "ad9bb268-a923-e3ad-bc42-67e77e6acca7",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "55fb7baa-3f4c-f797-a20f-dbbfaf82f831",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "b4ade142-d8cf-97aa-aeb8-6c846524cc91",
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
									"b4ade142-d8cf-97aa-aeb8-6c846524cc91",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "18c85f04-7995-190b-91b8-17e95a477bf7",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "65686981-8a69-d492-8ec2-081b95c7f5b0",
							version = 3,
						},
					},
				},
				mechanicTime = 1670,
				name = "[WAR] Trinity 10 Release Defiance",
				timeRange = true,
				timelineIndex = 264,
				timerEndOffset = 4,
				timerStartOffset = 0.2,
				uuid = "0e84ebbe-3ee3-4e31-87bd-c1486e055094",
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
							aType = "ACR",
							conditions =
							{

								{
									"10a597e8-6a84-38ff-a8d2-9748471b3daf",
									true,
								},

								{
									"3bdf3cda-aba7-8ba3-bd4b-45a542093d69",
									true,
								},

								{
									"df843f9f-aa31-a087-94e6-36fcd4ea2036",
									true,
								},

								{
									"50a4c7af-955e-d2a1-a753-2ab89fecbe3d",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "691adeb1-8735-9b55-8954-92547ea47839",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "3bdf3cda-aba7-8ba3-bd4b-45a542093d69",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "50a4c7af-955e-d2a1-a753-2ab89fecbe3d",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "37ad9a3a-aa61-6bc9-95d4-8b2bbf906b46",
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
									"37ad9a3a-aa61-6bc9-95d4-8b2bbf906b46",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "df843f9f-aa31-a087-94e6-36fcd4ea2036",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "10a597e8-6a84-38ff-a8d2-9748471b3daf",
							version = 3,
						},
					},
				},
				mechanicTime = 1670,
				name = "[WAR] Trinity 10 Reversed Stance On",
				timeRange = true,
				timelineIndex = 264,
				timerEndOffset = 4,
				timerStartOffset = 0.2,
				uuid = "6d78cc29-5e74-0be8-ad82-223a38aa1c0d",
				version = 2,
			},
		},
	},
	[265] =
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
							gVar = "ACR_RikuWAR3_Tankbar_ShakeItOff",
							uuid = "5448c50c-57af-2b60-a38d-ffe32c6287e6",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1680.9,
				name = "[WAR] Shake",
				timeRange = true,
				timelineIndex = 265,
				timerEndOffset = -0.1,
				timerStartOffset = -2,
				uuid = "5a68bd83-f0f7-088f-baa8-f3a4e445e3e8",
				version = 2,
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
				uuid = "e09c1b2c-ef9c-f898-74f8-27ae877973dc",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "e3339ac8-83e6-0da4-9de7-0f1d8fb6f4e7",
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
				uuid = "49828355-9054-6231-8c75-e86f06cccac5",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	[270] =
	{

		{
			data =
			{
				displayPath = "",
				name = "store\\anyone\\dsw\\universal",
				uuid = "fb3fc599-90ae-eded-2e2d-e6f758d1b289",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							aType = "ACR",
							conditions =
							{

								{
									"63d7ace0-6eeb-8c5a-ab34-e415ec679305",
									false,
								},

								{
									"5d715af9-f2ea-9b91-ab89-a5cf38f0c55f",
									true,
								},

								{
									"79c3cf2a-e4c0-45fa-95da-33510ec3b0f5",
									true,
								},

								{
									"c422b614-af80-f73f-9d36-26a4e9894ab9",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "109d9fba-1e46-3c8d-ace9-01f179ecedf6",
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
									"63d7ace0-6eeb-8c5a-ab34-e415ec679305",
									false,
								},

								{
									"5d715af9-f2ea-9b91-ab89-a5cf38f0c55f",
									true,
								},

								{
									"79c3cf2a-e4c0-45fa-95da-33510ec3b0f5",
									true,
								},

								{
									"c422b614-af80-f73f-9d36-26a4e9894ab9",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ProvokeMouse",
							targetType = "Detection Target",
							uuid = "daaa365a-4c8e-3933-9228-8f2301d851e1",
							variableIsHover = true,
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "5d715af9-f2ea-9b91-ab89-a5cf38f0c55f",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "c422b614-af80-f73f-9d36-26a4e9894ab9",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "35b9d785-0c0d-69e6-afb0-ac4789a4fbcd",
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
									"35b9d785-0c0d-69e6-afb0-ac4789a4fbcd",
									true,
								},

								{
									"51b47df5-2dac-70c1-a6c0-c46f4caf69cd",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "79c3cf2a-e4c0-45fa-95da-33510ec3b0f5",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28059,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "51b47df5-2dac-70c1-a6c0-c46f4caf69cd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "63d7ace0-6eeb-8c5a-ab34-e415ec679305",
							version = 3,
						},
					},
				},
				mechanicTime = 1712,
				name = "[WAR] Trinity 12 Defiance + Provoke",
				timeRange = true,
				timelineIndex = 270,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "bcaf5f6b-073c-d0d6-8951-a9d2503df440",
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
							aType = "ACR",
							conditions =
							{

								{
									"762d4583-979e-0681-a9be-4af4e0f0baf1",
									true,
								},

								{
									"f5a66587-d0c9-5cf4-8d1e-e3d5e1b95730",
									true,
								},

								{
									"94968a7f-17b7-7b8c-82ae-e0098f1638ac",
									true,
								},

								{
									"28ecc324-1f7e-7a00-8e5b-9f99b4ed1f70",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "8d3d9bce-2fd3-4429-b5a7-81c9fdc5043e",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "f5a66587-d0c9-5cf4-8d1e-e3d5e1b95730",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "28ecc324-1f7e-7a00-8e5b-9f99b4ed1f70",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "f7cf3ded-e385-fe17-a9bb-c19b035f334d",
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
									"f7cf3ded-e385-fe17-a9bb-c19b035f334d",
									true,
								},

								{
									"d27c844b-e0db-0c31-aad0-2bb8d1030df3",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "94968a7f-17b7-7b8c-82ae-e0098f1638ac",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28059,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "d27c844b-e0db-0c31-aad0-2bb8d1030df3",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "762d4583-979e-0681-a9be-4af4e0f0baf1",
							version = 3,
						},
					},
				},
				mechanicTime = 1712,
				name = "[WAR] Trinity 12 Reversed Release",
				timeRange = true,
				timelineIndex = 270,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "e7ec4666-733e-818c-8d4b-0c4862d0560e",
				version = 2,
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
				uuid = "f0b55c60-49fb-0784-33c7-b956ab6b3b10",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "45be7386-042d-e765-bfd8-43b93587f0ce",
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
				uuid = "b521f5e5-d74b-7c01-be42-6383947b3155",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
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
							actionID = 43,
							atomicPriority = true,
							ignoreWeaveRules = true,
							uuid = "b5802795-2dcd-dc4e-bfde-7d5a452a40b8",
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1732.9,
				name = "[WAR] Holmgang",
				timelineIndex = 274,
				timerOffset = -1,
				timerStartOffset = -1,
				uuid = "78926532-63b2-8541-a244-e5083f9a8634",
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
							aType = "ACR",
							gVar = "ACR_RikuWAR3_Tankbar_Reprisal",
							uuid = "80b7a664-04a5-7abe-a034-af03d757adb2",
							variableTogglesType = 3,
							version = 2.1,
						},
					},
				},
				conditions =
				{
				},
				mechanicTime = 1732.9,
				name = "[WAR] Reprisal",
				timeRange = true,
				timelineIndex = 274,
				timerEndOffset = -0.10000000149012,
				timerStartOffset = -1.5,
				uuid = "3e598eb6-1e66-6bfd-9086-2edd3b0967f4",
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
							aType = "ACR",
							conditions =
							{

								{
									"a9c71027-b226-2e7f-ba5e-20419014c74f",
									false,
								},

								{
									"de60a029-90c7-1aa8-b1c0-e6f3485640a1",
									true,
								},

								{
									"3c3702d3-c662-53b5-b317-8312b60e26fd",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ShirkMouse",
							targetType = "Other Tank",
							uuid = "936699d3-72a8-e3aa-a233-85e4bd5dd7cf",
							variableIsHover = true,
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
									"a9c71027-b226-2e7f-ba5e-20419014c74f",
									false,
								},

								{
									"de60a029-90c7-1aa8-b1c0-e6f3485640a1",
									true,
								},

								{
									"3c3702d3-c662-53b5-b317-8312b60e26fd",
									true,
								},

								{
									"855dde3f-9ac0-9152-9f93-adcf1c635e5f",
									true,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_ReleaseDefiance",
							uuid = "b1e5b40e-4cdf-c9f3-bd89-37f315674ae3",
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
							conditionType = 13,
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "de60a029-90c7-1aa8-b1c0-e6f3485640a1",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "855dde3f-9ac0-9152-9f93-adcf1c635e5f",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "38791599-aa4c-0fd0-8adf-e8c799c657d6",
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
									"38791599-aa4c-0fd0-8adf-e8c799c657d6",
									true,
								},

								{
									"d2ea7666-008f-ae50-b83a-94cde328fc77",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "3c3702d3-c662-53b5-b317-8312b60e26fd",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "d2ea7666-008f-ae50-b83a-94cde328fc77",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "a9c71027-b226-2e7f-ba5e-20419014c74f",
							version = 3,
						},
					},
				},
				mechanicTime = 1732.9,
				name = "[WAR] Trinity 14 Shirk + Release",
				timeRange = true,
				timelineIndex = 274,
				timerEndOffset = -1,
				timerStartOffset = -8,
				uuid = "e91e41b0-48a3-d1b7-aa66-8023730e26a1",
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
							aType = "ACR",
							conditions =
							{

								{
									"3bdbfd9a-354a-d92c-a6d2-b5137600833b",
									true,
								},

								{
									"cafa190e-63d1-bea4-93ec-4b5ea338693f",
									true,
								},

								{
									"2cbaf918-da94-fe57-83b0-e52292f31652",
									true,
								},

								{
									"8cb22ad4-e91b-dfd7-bb61-74c67354dad8",
									false,
								},
							},
							gVar = "ACR_RikuWAR3_Hotbar_Defiance",
							uuid = "e5bc5845-f296-2931-bd22-c55accf5e464",
							variableTogglesType = 2,
							version = 2.1,
						},
					},

					{
						data =
						{
							actionID = 7533,
							conditions =
							{

								{
									"3bdbfd9a-354a-d92c-a6d2-b5137600833b",
									true,
								},

								{
									"cafa190e-63d1-bea4-93ec-4b5ea338693f",
									true,
								},

								{
									"2cbaf918-da94-fe57-83b0-e52292f31652",
									true,
								},

								{
									"8cb22ad4-e91b-dfd7-bb61-74c67354dad8",
									true,
								},
							},
							targetType = "Detection Target",
							uuid = "05ae1342-6956-95bb-b8a3-e85d3509284c",
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
							jobValue = "WARRIOR",
							name = "Warrior",
							uuid = "cafa190e-63d1-bea4-93ec-4b5ea338693f",
							version = 3,
						},
					},

					{
						data =
						{
							buffID = 91,
							category = "Self",
							name = "Defiance active",
							uuid = "8cb22ad4-e91b-dfd7-bb61-74c67354dad8",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "local id=eventArgs.detectionTargetID\nlocal e=id and TensorCore.mGetEntity(id)\nreturn e~=nil and e.targetable==true",
							name = "Detected Thordan targetable",
							uuid = "b8658819-e5e3-6f7e-bfea-61e150d0f62a",
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
									"b8658819-e5e3-6f7e-bfea-61e150d0f62a",
									true,
								},

								{
									"dde576e7-c2d7-5047-8ce9-9ba6433c796e",
									true,
								},
							},
							filterTargetType = "ContentID",
							name = "Dragon-king Thordan",
							partyTargetContentID = 11319,
							uuid = "2cbaf918-da94-fe57-83b0-e52292f31652",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Party",
							channelCheckSpellID = 28051,
							conditionType = 5,
							name = "Thordan cast lock",
							partyTargetType = "Detection Target",
							uuid = "dde576e7-c2d7-5047-8ce9-9ba6433c796e",
							version = 3,
						},
					},

					{
						data =
						{
							category = "Lua",
							conditionLua = "return data.frog_war_p7_reverse==true",
							dequeueIfLuaFalse = true,
							name = "Reversed opening",
							uuid = "3bdbfd9a-354a-d92c-a6d2-b5137600833b",
							version = 3,
						},
					},
				},
				mechanicTime = 1732.9,
				name = "[WAR] Trinity 14 Reversed Take",
				timeRange = true,
				timelineIndex = 274,
				timerEndOffset = -0.1,
				timerStartOffset = -8,
				uuid = "2e07b54c-afc1-ea0b-a314-491f4a2eab69",
				version = 2,
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
				uuid = "ffa62cfc-e90b-5f28-44a6-c8222b94c92c",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},

		{
			data =
			{
				name = "Draw in/out",
				uuid = "755c87f4-702a-0136-b1cf-2bbcad61ae15",
				version = 2,
			},
			inheritedObjectUUID = "57baee0b-e3a4-9c37-8961-f81f1349a1a9",
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
				uuid = "82b1a848-b3e0-3b64-f614-10caaaa599b8",
			},
			inheritanceRoot = "store\\anyone\\dsw\\universal",
			objectType = "folder",
		},
	},
	inheritedProfiles =
	{
		"store\\anyone\\dsw\\universal",
		"Frog\\Ultimates\\DSR\\Draws",
	},
	timelineName = "dsw",
	version = "1.0.5",
}



return tbl
