local tbl = 
{
	
	{
		data = 
		{
			displayPath = "",
			name = "01 - Opening Qualifier",
			uuid = "029cc92a-154b-438c-adea-b2589a5d3b81",
		},
		objectType = "folder",
	},
	
	{
		data = 
		{
			displayPath = "01 - Opening Qualifier",
			name = "Obstacle Draws",
			uuid = "450b5ca5-8900-ed8d-8d33-d1491bdd58e1",
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
						actionLua = "local remaining = eventArgs.duration * 1000 - (Now() - eventArgs.startTime)\nif remaining > 0 then\n    local drawer = TensorCore.getMoogleDrawer()\n    drawer:addTimedCircle(remaining, eventArgs.x, eventArgs.y, eventArgs.z, eventArgs.aoeLength, 0, false, true)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"990ac5bd-42e8-2b5e-9dcf-772904424b07",
								true,
							},
							
							{
								"71f0cca2-9a68-5aaf-a017-668a668af8af",
								true,
							},
						},
						name = "Draw Recorded Warning",
						uuid = "ccc480cd-0cd1-134a-8aaf-9f442429e19c",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "990ac5bd-42e8-2b5e-9dcf-772904424b07",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.aoeID == 34717\n    and eventArgs.aoeCastType == 2\n    and eventArgs.friendly == false\n    and eventArgs.duration > 0\n    and eventArgs.aoeLength > 0",
						dequeueIfLuaFalse = true,
						name = "Hazard 34717",
						uuid = "71f0cca2-9a68-5aaf-a017-668a668af8af",
						version = 3,
					},
				},
			},
			displayPath = "01 - Opening Qualifier/Obstacle Draws",
			eventType = 18,
			name = "Opening - Circular Warnings (34717)",
			timeout = 1,
			uuid = "e3dbdd9b-4bcb-08fa-88e1-02c6dedc0e5e",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\n-- Remove the prepared first-hit placement on the actual attack event.\nlocal initial=data.blunderInitialWarnings\nlocal preview=initial and initial.draws[eventArgs.entityID]\nif preview and preview.uuid and preview.spell==eventArgs.spellID then\n    removeWarning(preview.uuid)\n    initial.draws[eventArgs.entityID]={spell=preview.spell,resolved=true}\nend\nlocal geometry = {[34716]={12,3,2}, [34717]={2,3,0}, [34718]={12,4,10}, [34773]={2,5,0}, [34774]={8,0,3}, [34775]={12,3,3}, [34776]={2,2,0}}\n-- Predictions from observed obstacle cycles, not server snapshot timers.\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used = true return end\nlocal p = entity.pos\nlocal now = Now()\nlocal ability = eventArgs.spellID\n-- Snowballs now have one spawn-driven lane rectangle, not sampled circles.\nif ability == 34776 then self.used = true return end\ndata.blunderOpeningCapturedPhaseV4 = data.blunderOpeningCapturedPhaseV4 or {}\nlocal states = data.blunderOpeningCapturedPhaseV4\nlocal key = tostring(ability) .. \":\" .. tostring(eventArgs.entityID)\nlocal state = states[key]\nif not state or now - state.last > 15000 then\n    state = {history = {}, scheduled = {}, last = now}\n    states[key] = state\nend\nif ability==34773 then\n    data.blunderActiveSpinners=data.blunderActiveSpinners or {}\n    local active=data.blunderActiveSpinners\n    local previous=active[eventArgs.entityID]\n    local firstHit=not previous or now-previous.last>1500\n    local burstAt=firstHit and now or previous.burstAt\n    active[eventArgs.entityID]={x=p.x,y=p.y,z=p.z,radius=5,\n        last=now,untilTime=now+600,burstAt=burstAt}\n    if firstHit then\n        local cycle=previous and now-previous.burstAt or 6000\n        if cycle<4500 or cycle>8000 then cycle=6000 end\n        local delay=math.max(0,cycle-3000)\n        countdownDrawer():addTimedCircle(cycle-delay,\n            p.x,p.y,p.z,5,delay,false,true)\n    end\n    self.used=true return\nend\nlocal history = state.history\nlocal shape = geometry[ability]\nlocal point = {x=p.x, y=p.y, z=p.z, h=p.h, t=now,\n    length=shape[2], width=shape[3], kind=shape[1], centered=(ability==34716)}\nif shape[1] == 8 then\n    local x,y,z=eventArgs.castPosX,eventArgs.castPosY,eventArgs.castPosZ\n    if x==nil or y==nil or z==nil then self.used=true return end\n    if z < -330 then\n        -- Captured slope endpoints are five fixed stops. Predict the next stop,\n        -- reflecting at a wall, instead of redrawing the completed segment.\n        local centre=p.x < -100 and -200 or 0\n        local middle=math.abs(z+347.829)<0.5 and 3.75369 or 3.50955\n        local grid={-6.8819,-0.0153198-middle,-0.0153198,\n            -0.0153198+middle,6.85126}\n        local current\n        for i,v in ipairs(grid) do\n            if math.abs(x-centre-v)<0.4 then current=i break end\n        end\n        if state.slidePreview then removeWarning(state.slidePreview) state.slidePreview=nil end\n        if not current then state.last=now self.used=true return end\n        local previous=state.slideEndpoint\n        local delta=previous and x-previous.x or x-p.x\n        local direction=delta>=0 and 1 or -1\n        if current==1 then direction=1 elseif current==#grid then direction=-1 end\n        local nextIndex=current+direction\n        local nextX=centre+grid[nextIndex]\n        local interval=now-state.last\n        if interval<500 or interval>4000 then interval=1600 end\n        state.slideEndpoint={x=x,y=y,z=z}\n        state.last=now\n        local delay=math.max(0,interval-3000)\n        state.slidePreview=countdownDrawer():addTimedCenteredRect(interval-delay,\n            (x+nextX)/2,y,z,math.abs(nextX-x),point.width,\n            direction*math.pi/2,delay,false,true)\n        self.used=true return\n    end\n    -- Ground-cast endpoints are authoritative. The live model heading can lag\n    -- the move, and its position may already be part way through a segment.\n    local previous={x=p.x,y=p.y,z=p.z}\n    local dx=x-previous.x\n    point.length=math.abs(dx)\n    if point.length<0.5 or point.length>50 then self.used=true return end\n    point.x,point.y,point.z=(previous.x+x)/2,(previous.y+y)/2,(previous.z+z)/2\n    point.h=math.pi/2\n    point.kind=12\n    point.centered=true\n    state.slideEndpoint={x=x,y=y,z=z}\n    -- Draw the current movement even before a complete repeating cycle exists.\n    local observedInterval=now-state.last\n    if observedInterval<500 or observedInterval>4000 then\n        observedInterval=(z < -330) and 1600 or 2100\n    end\n    if state.slidePreview then removeWarning(state.slidePreview) end\n    local delay=math.max(0,observedInterval-3000)\n    state.slidePreview=countdownDrawer():addTimedCenteredRect(observedInterval-delay,\n        point.x,point.y,point.z,point.length,point.width,point.h,delay,false,true)\n    state.last=now\n    -- This crossing owns exactly one warning. Do not also extrapolate it.\n    self.used=true return\nend\nhistory[#history+1] = point\nif #history > 18 then table.remove(history, 1) end\nstate.last = now\nlocal n = #history\nif ability==34775 then\n    -- Argus supplies completed hits here, not an advance cast timer.\n    -- Retire the previous forecast on the real hit before preparing the next.\n    if state.orbPreview then removeWarning(state.orbPreview) state.orbPreview=nil end\n    if n<3 then self.used=true return end\n    local priorSame=history[n-2]\n    local priorOpposite=history[n-1]\n    if math.cos(priorSame.h-point.h)<0.99\n        or math.cos(priorOpposite.h-point.h)>-0.99 then self.used=true return end\n    local interval=priorOpposite.t-priorSame.t\n    if interval<500 or interval>4000 then self.used=true return end\n    local delay=math.max(0,interval-3000)\n    state.orbPreview=countdownDrawer():addTimedCenteredRect(interval-delay,\n        point.x,point.y,point.z,point.length,point.width,priorOpposite.h,delay,false,true)\n    self.used=true return\nend\n-- Draw the destination at the start of the crossing, not just in its last 3s.\nif ability==34717 then\n    local previous=history[n-1]\n    -- The captures show a four-yalm crossing; until both endpoints have been\n    -- observed, the initial facing supplies the first destination.\n    local destination=previous or {x=point.x+math.sin(point.h)*4,\n        y=point.y,z=point.z+math.cos(point.h)*4}\n    local interval=4800\n    if previous then\n        interval=now-previous.t\n        if interval<3500 or interval>6000 then self.used=true return end\n    end\n    local drawer=countdownDrawer()\n    drawer:addTimedCircle(interval,destination.x,destination.y,destination.z,\n        3,0,false,true)\n    local radius=entity.hitradius\n    local dx,dz=destination.x-point.x,destination.z-point.z\n    local length=math.sqrt(dx*dx+dz*dz)\n    -- One complete contact corridor; clear it when movement ends, before\n    -- the destination attack wind-up. No sampled or overlapping tiles.\n    if radius>0 and length>0.5 then\n        drawer:addTimedCenteredRect(interval-1000,\n            (point.x+destination.x)/2,point.y,(point.z+destination.z)/2,\n            length+2*radius,2*radius,math.atan2(dx,dz),0,false,true)\n    end\n    self.used=true return\nend\n-- Seed first-hit predictions from position/direction-specific captured timing.\nif ability==34716 or ability==34718 then\n    local captured={[\"34716:-120:-1303:-1\"]=1375,[\"34716:-120:-1303:1\"]=2813,[\"34716:-120:-1388:-1\"]=1375,[\"34716:-120:-1388:1\"]=2812,[\"34716:-120:-1473:-1\"]=1375,[\"34716:-120:-1473:1\"]=2820,[\"34716:-30:-2199:-1\"]=1375,[\"34716:-30:-2199:1\"]=2813,[\"34716:-30:-2253:-1\"]=2813,[\"34716:-30:-2253:1\"]=1375,[\"34716:-30:-2320:-1\"]=1375,[\"34716:-30:-2320:1\"]=2812,[\"34716:-30:-2390:-1\"]=2813,[\"34716:-30:-2390:1\"]=1375,[\"34716:-60:-1303:-1\"]=2812,[\"34716:-60:-1303:1\"]=1375,[\"34716:-60:-1388:-1\"]=2813,[\"34716:-60:-1388:1\"]=1375,[\"34716:-60:-1473:-1\"]=2812,[\"34716:-60:-1473:1\"]=1375,[\"34716:-60:-2253:-1\"]=2133,[\"34716:-60:-2253:1\"]=2125,[\"34716:-60:-2390:-1\"]=2133,[\"34716:-60:-2390:1\"]=2125,[\"34716:-90:-1303:-1\"]=2125,[\"34716:-90:-1303:1\"]=2133,[\"34716:-90:-1388:-1\"]=2133,[\"34716:-90:-1388:1\"]=2125,[\"34716:-90:-1473:-1\"]=2125,[\"34716:-90:-1473:1\"]=2133,[\"34716:-90:-2253:-1\"]=1375,[\"34716:-90:-2253:1\"]=2812,[\"34716:-90:-2390:-1\"]=1375,[\"34716:-90:-2390:1\"]=2812,[\"34716:0:-2199:-1\"]=2125,[\"34716:0:-2199:1\"]=2125,[\"34716:0:-2320:-1\"]=2133,[\"34716:0:-2320:1\"]=2125,[\"34716:120:-1303:-1\"]=2813,[\"34716:120:-1303:1\"]=1375,[\"34716:120:-1388:-1\"]=2812,[\"34716:120:-1388:1\"]=1375,[\"34716:120:-1473:-1\"]=2813,[\"34716:120:-1473:1\"]=1375,[\"34716:30:-2199:-1\"]=2812,[\"34716:30:-2199:1\"]=1375,[\"34716:30:-2253:-1\"]=1375,[\"34716:30:-2253:1\"]=2813,[\"34716:30:-2320:-1\"]=2813,[\"34716:30:-2320:1\"]=1375,[\"34716:30:-2390:-1\"]=1375,[\"34716:30:-2390:1\"]=2813,[\"34716:60:-1303:-1\"]=1375,[\"34716:60:-1303:1\"]=2812,[\"34716:60:-1388:-1\"]=1375,[\"34716:60:-1388:1\"]=2813,[\"34716:60:-1473:-1\"]=1375,[\"34716:60:-1473:1\"]=2812,[\"34716:60:-2253:-1\"]=2125,[\"34716:60:-2253:1\"]=2125,[\"34716:60:-2390:-1\"]=2125,[\"34716:60:-2390:1\"]=2133,[\"34716:90:-1303:-1\"]=2133,[\"34716:90:-1303:1\"]=2125,[\"34716:90:-1388:-1\"]=2125,[\"34716:90:-1388:1\"]=2133,[\"34716:90:-1473:-1\"]=2133,[\"34716:90:-1473:1\"]=2125,[\"34716:90:-2253:-1\"]=2812,[\"34716:90:-2253:1\"]=1375,[\"34716:90:-2390:-1\"]=2812,[\"34716:90:-2390:1\"]=1375,[\"34718:-20:-2610:-1\"]=3641,[\"34718:-20:-2610:1\"]=4563,[\"34718:-20:-2810:-1\"]=3750,[\"34718:-20:-2810:1\"]=4547,[\"34718:-60:-2610:-1\"]=2875,[\"34718:-60:-2610:1\"]=5375,[\"34718:-60:-2810:-1\"]=2875,[\"34718:-60:-2810:1\"]=5375,[\"34718:20:-2610:-1\"]=4547,[\"34718:20:-2610:1\"]=3750,[\"34718:20:-2810:-1\"]=4563,[\"34718:20:-2810:1\"]=3641,[\"34718:60:-2610:-1\"]=5375,[\"34718:60:-2610:1\"]=2875,[\"34718:60:-2810:-1\"]=5375,[\"34718:60:-2810:1\"]=2875}\n    local centre=(point.x < -100) and -200 or 0\n    local phase=math.sin(point.h)>0 and 1 or -1\n    local phaseKey=tostring(ability)..\":\"..tostring(math.floor((point.x-centre)*10+0.5))\n        ..\":\"..tostring(math.floor(point.z*10+0.5))..\":\"..tostring(phase)\n    local interval=captured[phaseKey]\n    if n>=3 then\n        local previousPhase=history[n-2]\n        if math.cos(previousPhase.h-point.h)>0.99 then\n            local observed=history[n-1].t-previousPhase.t\n            if observed>500 and observed<8000 then interval=observed end\n        end\n    end\n    if not interval then self.used=true return end\n    if state.armPreview then removeWarning(state.armPreview) end\n    local delay=math.max(0,interval-3000)\n    local drawer=countdownDrawer()\n    if point.centered then\n        state.armPreview=drawer:addTimedCenteredRect(interval-delay,point.x,point.y,point.z,\n            point.length,point.width,point.h+math.pi,delay,false,true)\n    else\n        state.armPreview=drawer:addTimedRect(interval-delay,point.x,point.y,point.z,\n            point.length,point.width,point.h+math.pi,delay,false,true)\n    end\n    self.used=true return\nend\nif n < 4 then self.used = true return end\nlocal function matches(a,b)\n    return math.abs(a.x-b.x)<0.4 and math.abs(a.y-b.y)<0.5\n        and math.abs(a.z-b.z)<0.4 and math.abs(a.length-b.length)<0.5\n        and math.abs(math.sin(a.h-b.h))<0.1 and math.cos(a.h-b.h)>0.99\nend\nlocal period\nfor candidate=1,math.min(8, math.floor((n-1)/2)) do\n    local equal=true\n    for j=0,candidate-1 do\n        local recent,prior=n-j,n-j-candidate\n        if not matches(history[recent],history[prior])\n            or math.abs((history[recent].t-history[recent-1].t)\n                -(history[prior].t-history[prior-1].t))>650 then equal=false break end\n    end\n    if equal then period=candidate break end\nend\nlocal intervals={}\nfor i=math.max(2,n-7),n do\n    intervals[#intervals+1]=history[i].t-history[i-1].t\nend\ntable.sort(intervals)\nlocal interval=intervals[math.ceil(#intervals/2)]\n-- Reject unstable sequences rather than extrapolate changing hit times.\nif interval<350 or interval>10000 or (not period and intervals[#intervals]-intervals[1]>650) then\n    self.used=true return\nend\nlocal linear=false\nlocal vx,vy,vz\nif not period then\n    -- Moving hazards can be extrapolated only after three consistent steps.\n    local a,b=history[n-1],history[n]\n    local dt=b.t-a.t\n    vx,vy,vz=(b.x-a.x)/dt,(b.y-a.y)/dt,(b.z-a.z)/dt\n    linear=true\n    for i=n-2,n-1 do\n        local old,new=history[i-1],history[i]\n        local elapsed=new.t-old.t\n        if elapsed<=0 or math.abs((new.x-old.x)-vx*elapsed)>0.5\n            or math.abs((new.y-old.y)-vy*elapsed)>0.5\n            or math.abs((new.z-old.z)-vz*elapsed)>0.5 then linear=false break end\n    end\n    if not linear then self.used=true return end\nend\nlocal drawer=countdownDrawer()\nlocal future={}\nfor _,scheduled in ipairs(state.scheduled) do\n    if scheduled.t>now+150 then future[#future+1]=scheduled end\nend\nstate.scheduled=future\nlocal deadline=now\nfor step=1,9 do\n    local stepInterval=interval\n    if period then\n        local index=n-period+1+((step-1)%period)\n        local samples={}\n        while index>=2 do\n            samples[#samples+1]=history[index].t-history[index-1].t\n            index=index-period\n        end\n        table.sort(samples)\n        stepInterval=samples[math.ceil(#samples/2)]\n    end\n    if stepInterval<350 or stepInterval>10000 then break end\n    deadline=deadline+stepInterval\n    local nextPoint\n    if period then\n        nextPoint=history[n-period+1+((step-1)%period)]\n    else\n        nextPoint={x=point.x+vx*(deadline-now),y=point.y+vy*(deadline-now),\n            z=point.z+vz*(deadline-now),h=point.h,length=point.length,\n            width=point.width,kind=point.kind,centered=point.centered}\n    end\n    local duplicate=false\n    for _,scheduled in ipairs(future) do\n        if math.abs(scheduled.t-deadline)<math.min(500,stepInterval*0.4) and matches(scheduled.point,nextPoint) then\n            duplicate=true break\n        end\n    end\n    if not duplicate then\n        local delay=math.max(0,deadline-now-3000)\n        local duration=math.min(3000,deadline-now)\n        if nextPoint.kind==2 then\n            drawer:addTimedCircle(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,delay,false,true)\n        elseif nextPoint.centered then\n            local active=drawer\n            if ability==34774 then\n                active=TensorCore.getCachedDrawer(drawer.colorEnd,drawer.colorEnd,drawer.colorEnd,\n                    drawer.colorOutline,drawer.outlineThickness,drawer.occlusionChannel,drawer.renderFlags)\n            end\n            active:addTimedCenteredRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        else\n            drawer:addTimedRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        end\n        future[#future+1]={t=deadline,point=nextPoint}\n    end\n    if deadline-now>=3000 then break end\nend\nself.used=true\n",
						conditions = 
						{
							
							{
								"f72f8f0b-dd42-828c-a553-123ccbae8405",
								true,
							},
							
							{
								"c4d66d7c-ebad-7abc-9ba6-71b1cb6fbd50",
								true,
							},
							
							{
								"70ab9d30-bed6-6b0b-a7a7-09d5e034cfd1",
								true,
							},
							
							{
								"8a4f6c1e-8e65-fcef-b22d-3f4cb4df5f18",
								true,
							},
						},
						name = "Predict Three-Second Timed Warnings",
						uuid = "e9924be4-808c-a567-9a4b-b8a116fbfc98",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "f72f8f0b-dd42-828c-a553-123ccbae8405",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actor",
						uuid = "c4d66d7c-ebad-7abc-9ba6-71b1cb6fbd50",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.spellID == 34717 or eventArgs.spellID == 34716 or eventArgs.spellID == 34718 or eventArgs.spellID == 34773 or eventArgs.spellID == 34774 or eventArgs.spellID == 34775",
						dequeueIfLuaFalse = true,
						name = "Obstacle Cast",
						uuid = "70ab9d30-bed6-6b0b-a7a7-09d5e034cfd1",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local entity = TensorCore.mGetEntity(eventArgs.entityID)\nreturn entity ~= nil and entity.pos.z < 0",
						name = "Course Area",
						uuid = "8a4f6c1e-8e65-fcef-b22d-3f4cb4df5f18",
						version = 3,
					},
				},
			},
			displayPath = "01 - Opening Qualifier/Obstacle Draws",
			eventType = 2,
			name = "Opening - Predicted Obstacles (3s)",
			timeout = 1,
			uuid = "b40c273a-826d-d4ea-b2c0-769c9b3f8c90",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\nlocal entity=TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used=true return end\nlocal p=entity.pos\n-- Initial warning covers only the launch area, not the entire rolling lane.\nlocal radius=2\nlocal firstCollisionZ=p.z+3.1\nlocal startZ=p.z-radius\nlocal endZ=firstCollisionZ+radius\ncountdownDrawer():addTimedCenteredRect(2900,p.x,18.1429,(startZ+endZ)/2,\n    endZ-startZ,radius*2,0,0,false,true)\nself.used=true",
						conditions = 
						{
							
							{
								"6a87b6b7-d9f7-ca9c-bcf5-1553a67c6fed",
								true,
							},
							
							{
								"7f553d1d-2114-1d04-80c2-f7423bd6212f",
								true,
							},
							
							{
								"ed14aec5-1836-b483-b800-c15b756aebf4",
								true,
							},
						},
						name = "Draw Short Launch Warning",
						uuid = "30319c19-4f12-42a9-bc8f-68524f626de0",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "6a87b6b7-d9f7-ca9c-bcf5-1553a67c6fed",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actor",
						uuid = "7f553d1d-2114-1d04-80c2-f7423bd6212f",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local entity=TensorCore.mGetEntity(eventArgs.entityID)\nreturn entity ~= nil and Argus.getEntityModel(eventArgs.entityID) == 16351 and entity.pos.z < -365 and entity.pos.z > -368",
						name = "Snowball Spawn",
						uuid = "ed14aec5-1836-b483-b800-c15b756aebf4",
						version = 3,
					},
				},
			},
			displayPath = "01 - Opening Qualifier/Obstacle Draws",
			eventType = 5,
			name = "Opening - Snowball Launch Warning",
			timeout = 1,
			uuid = "d4749b90-1626-c558-80f0-d67317d2b3d5",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\nlocal entity=TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used=true return end\nlocal p=entity.pos\nlocal now=Now()\ndata.blunderRolling=data.blunderRolling or {}\nlocal states=data.blunderRolling\nlocal s=states[eventArgs.entityID]\nif not s or now-s.last>1000 or p.z<s.z-1 then s={history={}} states[eventArgs.entityID]=s end\nlocal history=s.history\nhistory[#history+1]={t=now,z=p.z}\nif #history>6 then table.remove(history,1) end\ns.last=now s.z=p.z\nlocal velocity=0\nif #history>=2 then\n    local meanT,meanZ=0,0\n    for _,v in ipairs(history) do meanT=meanT+v.t meanZ=meanZ+v.z end\n    meanT=meanT/#history meanZ=meanZ/#history\n    local numerator,denominator=0,0\n    for _,v in ipairs(history) do\n        numerator=numerator+(v.t-meanT)*(v.z-meanZ)\n        denominator=denominator+(v.t-meanT)^2\n    end\n    if denominator>0 then velocity=math.max(0,numerator/denominator) end\nend\nlocal radius=2\nlocal rear=p.z-radius\nlocal front=math.min(-342.8,p.z+velocity*3000+radius)\nif front>rear then\n    -- Renewed only by collision events, never a per-frame callback.\n    -- Old positions disappear after 500ms, even if this actor stops updating.\n    countdownDrawer():addTimedCenteredRect(500,p.x,p.y,(rear+front)/2,\n        front-rear,radius*2,0,0,false,true)\nend\nself.used=true",
						conditions = 
						{
							
							{
								"faad6a6d-822c-b4b1-aa69-2c895dbad034",
								true,
							},
							
							{
								"31977472-d8a9-749e-80d7-df81631c3c63",
								true,
							},
						},
						name = "Draw Short Moving Lane Preview",
						uuid = "a9a2246a-3167-8b30-ae70-06ebbec7ec19",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "faad6a6d-822c-b4b1-aa69-2c895dbad034",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.spellID == 34776 and eventArgs.entityContentID == 108",
						dequeueIfLuaFalse = true,
						name = "Snowball Collision",
						uuid = "31977472-d8a9-749e-80d7-df81631c3c63",
						version = 3,
					},
				},
			},
			displayPath = "01 - Opening Qualifier/Obstacle Draws",
			eventType = 2,
			name = "Opening - Moving Snowball Rectangles (3s)",
			timeout = 1,
			uuid = "b48ab4b8-e8d7-bc7d-9954-49fa6f4e1445",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if not data.blunderImageAssetsReady then self.used=true return end\nlocal active=data.blunderActiveSpinners\nif not active then self.used=true return end\nlocal now=Now()\nlocal player=TensorCore.mGetPlayer()\nif not player or player.localmapid~=1165 then data.blunderActiveSpinners=nil self.used=true return end\nlocal danger=data.blunderSpinnerDangerDrawer\nif not danger then\n    local red=GUI:ColorConvertFloat4ToU32(1,0.08,0.02,0.55)\n    local outline=GUI:ColorConvertFloat4ToU32(1,0.2,0.05,1)\n    danger=Argus2.ShapeDrawer:new(nil,nil,red,outline,3)\n    data.blunderSpinnerDangerDrawer=danger\n    local white=GUI:ColorConvertFloat4ToU32(1,1,1,1)\n    data.blunderSpinnerTextDrawer=Argus2.ShapeDrawer:new(nil,nil,white)\nend\nfor id,spin in pairs(active) do\n    if now<spin.untilTime and TensorCore.mGetEntity(id) then\n        danger:addCircle(spin.x,spin.y,spin.z,spin.radius,false)\n        data.blunderSpinnerTextDrawer:addScreenFacingTexture(\n            spin.x,spin.y+2,spin.z,0,\n            GetLuaModsPath()..\"TensorReactions/FrogBlunderSpinning.png\",\n            384,96,3,0.75)\n    elseif now-spin.last>15000 then active[id]=nil end\nend\nself.used=true",
						name = "Active Danger and SPINNING",
						uuid = "164f0e1b-48f2-2da4-b070-04528b5b60bf",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "01 - Opening Qualifier/Obstacle Draws",
			eventType = 13,
			name = "Opening - Active Spinners",
			timeout = 1,
			uuid = "126ef0a1-eef6-01fd-a25c-43ad1fb5e930",
			version = 2,
		},
	},
	
	{
		data = 
		{
			displayPath = "",
			name = "02 - Second Round",
			uuid = "595b1984-daf2-d1a0-88b6-706c42f2dbdb",
		},
		objectType = "folder",
	},
	
	{
		data = 
		{
			displayPath = "02 - Second Round",
			name = "Coloured Eggs and Paths",
			uuid = "dde1f8e1-14ec-36e1-b324-85fdc84b23c2",
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
						actionLua = "local remaining=eventArgs.startTime+eventArgs.duration*1000-Now()\nif remaining>0 then\n    local base=TensorCore.getMoogleDrawer()\n    local blue=GUI:ColorConvertFloat4ToU32(0.10,0.55,1.0,0.40)\n    local outline=GUI:ColorConvertFloat4ToU32(0.10,0.65,1.0,0.95)\n    local d=TensorCore.getCachedDrawer(blue,blue,blue,outline,\n        base.outlineThickness,base.occlusionChannel,base.renderFlags)\n    local h=eventArgs.heading\n    local x=eventArgs.x+math.sin(h)*eventArgs.aoeLength/2\n    local z=eventArgs.z+math.cos(h)*eventArgs.aoeLength/2\n    d:addTimedCenteredRect(remaining,x,eventArgs.y,z,eventArgs.aoeLength,\n        eventArgs.aoeWidth,h,0,false,true)\nend\nself.used=true",
						conditions = 
						{
							
							{
								"9f60d787-1bdc-1663-93eb-94f9ae9ee578",
								true,
							},
							
							{
								"323f07c2-6096-eff8-8a8b-188550d515b6",
								true,
							},
						},
						name = "Draw Recorded Warning",
						uuid = "39cb4696-d74b-b771-b285-c955461a4f48",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "9f60d787-1bdc-1663-93eb-94f9ae9ee578",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.aoeID == 34800\n    and eventArgs.aoeCastType == 12\n    and eventArgs.friendly == false\n    and eventArgs.duration > 0\n    and eventArgs.aoeLength > 0\n    and eventArgs.aoeWidth > 0",
						dequeueIfLuaFalse = true,
						name = "Hazard 34800",
						uuid = "323f07c2-6096-eff8-8a8b-188550d515b6",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Coloured Eggs and Paths",
			eventType = 18,
			name = "Egg Paths - Rectangular Warning (34800)",
			timeout = 1,
			uuid = "fc3e6c93-581e-f97a-8099-bdd08915b9a6",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\nlocal geometry = {[34716]={12,3,2}, [34774]={8,0,3}, [34799]={12,4,4}}\n-- Predictions from observed obstacle cycles, not server snapshot timers.\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used = true return end\nlocal p = entity.pos\nlocal now = Now()\nlocal ability = eventArgs.spellID\ndata.blunderPredictEggV2 = data.blunderPredictEggV2 or {}\nlocal states = data.blunderPredictEggV2\nlocal key = tostring(ability) .. \":\" .. tostring(eventArgs.entityID)\nlocal state = states[key]\nif not state or now - state.last > 15000 then\n    state = {history = {}, scheduled = {}, last = now}\n    states[key] = state\nend\nlocal history = state.history\nlocal shape = geometry[ability]\nlocal point = {x=p.x, y=p.y, z=p.z, h=p.h, t=now, centered=(ability==34799),\n    length=shape[2], width=shape[3], kind=shape[1]}\nif shape[1] == 8 then\n    local x,y,z=eventArgs.castPosX,eventArgs.castPosY,eventArgs.castPosZ\n    if x==nil or y==nil or z==nil then self.used=true return end\n    local previous=state.slideEndpoint or {x=p.x,y=y,z=p.z}\n    local dx,dz=x-previous.x,z-previous.z\n    point.length=math.sqrt(dx*dx+dz*dz)\n    if point.length<0.5 or point.length>50 then self.used=true return end\n    point.x,point.y,point.z=(previous.x+x)/2,y,(previous.z+z)/2\n    point.h=math.atan2(dx,dz)\n    point.kind=12 point.centered=true\n    state.slideEndpoint={x=x,y=y,z=z}\n    local interval=now-state.last\n    if interval<500 or interval>6000 then interval=3900 end\n    -- One warning for the complete crossing; expire at the predicted hit.\n    local delay=math.max(0,interval-3000)\n    countdownDrawer():addTimedCenteredRect(interval-delay,\n        point.x,point.y,point.z,point.length,point.width,point.h,delay,false,true)\n    state.last=now\n    -- Do not stack cycle predictions over the current movement lane.\n    self.used=true return\nend\nhistory[#history+1] = point\nif #history > 18 then table.remove(history, 1) end\nstate.last = now\nlocal n = #history\nif n < 4 then self.used = true return end\nlocal function matches(a,b)\n    return math.abs(a.x-b.x)<0.4 and math.abs(a.y-b.y)<0.5\n        and math.abs(a.z-b.z)<0.4 and math.abs(a.length-b.length)<0.5\n        and math.abs(math.sin(a.h-b.h))<0.1 and math.cos(a.h-b.h)>0.99\nend\nlocal period\nfor candidate=1,math.min(8, math.floor((n-1)/2)) do\n    local equal=true\n    for j=0,candidate-1 do\n        local recent,prior=n-j,n-j-candidate\n        if not matches(history[recent],history[prior])\n            or math.abs((history[recent].t-history[recent-1].t)\n                -(history[prior].t-history[prior-1].t))>650 then equal=false break end\n    end\n    if equal then period=candidate break end\nend\nlocal intervals={}\nfor i=math.max(2,n-7),n do\n    intervals[#intervals+1]=history[i].t-history[i-1].t\nend\ntable.sort(intervals)\nlocal interval=intervals[math.ceil(#intervals/2)]\n-- Reject unstable sequences rather than extrapolate changing hit times.\nif interval<350 or interval>10000 or (not period and intervals[#intervals]-intervals[1]>650) then\n    self.used=true return\nend\nlocal linear=false\nlocal vx,vy,vz\nif not period then\n    -- Moving hazards can be extrapolated only after three consistent steps.\n    local a,b=history[n-1],history[n]\n    local dt=b.t-a.t\n    vx,vy,vz=(b.x-a.x)/dt,(b.y-a.y)/dt,(b.z-a.z)/dt\n    linear=true\n    for i=n-2,n-1 do\n        local old,new=history[i-1],history[i]\n        local elapsed=new.t-old.t\n        if elapsed<=0 or math.abs((new.x-old.x)-vx*elapsed)>0.5\n            or math.abs((new.y-old.y)-vy*elapsed)>0.5\n            or math.abs((new.z-old.z)-vz*elapsed)>0.5 then linear=false break end\n    end\n    if not linear then self.used=true return end\nend\nlocal drawer=countdownDrawer()\nlocal future={}\nfor _,scheduled in ipairs(state.scheduled) do\n    if scheduled.t>now then future[#future+1]=scheduled end\nend\nstate.scheduled=future\n-- Alternating arms must show only their next swing. Keep its original\n-- deadline instead of stacking revised forecasts over an existing warning.\nif ability==34716 and #future>0 then self.used=true return end\nlocal deadline=now\nlocal predictionCount=ability==34716 and 1 or 9\nfor step=1,predictionCount do\n    local stepInterval=interval\n    if period then\n        local index=n-period+1+((step-1)%period)\n        local samples={}\n        while index>=2 do\n            samples[#samples+1]=history[index].t-history[index-1].t\n            index=index-period\n        end\n        table.sort(samples)\n        stepInterval=samples[math.ceil(#samples/2)]\n    end\n    if stepInterval<350 or stepInterval>10000 then break end\n    deadline=deadline+stepInterval\n    local nextPoint\n    if period then\n        nextPoint=history[n-period+1+((step-1)%period)]\n    else\n        nextPoint={x=point.x+vx*(deadline-now),y=point.y+vy*(deadline-now),\n            z=point.z+vz*(deadline-now),h=point.h,length=point.length,\n            width=point.width,kind=point.kind,centered=point.centered}\n    end\n    local duplicate=false\n    for _,scheduled in ipairs(future) do\n        if math.abs(scheduled.t-deadline)<math.min(500,stepInterval*0.4) and matches(scheduled.point,nextPoint) then\n            duplicate=true break\n        end\n    end\n    if not duplicate then\n        local delay=math.max(0,deadline-now-3000)\n        local duration=math.min(3000,deadline-now)\n        if nextPoint.kind==2 then\n            drawer:addTimedCircle(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,delay,false,true)\n        elseif nextPoint.centered then\n            drawer:addTimedCenteredRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        else\n            drawer:addTimedRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        end\n        future[#future+1]={t=deadline,point=nextPoint}\n    end\n    if deadline-now>=3000 then break end\nend\nself.used=true\n",
						conditions = 
						{
							
							{
								"f7ba6c78-e08d-26a8-91cb-0ba33c81dc5b",
								true,
							},
							
							{
								"177be2c3-241c-4b5b-9edb-fa3fcfa6e54c",
								true,
							},
							
							{
								"74dbcb24-437c-8059-bbe5-e0c821e2ef7a",
								true,
							},
							
							{
								"bc4be91d-657b-dd84-b237-8f321d07a3d6",
								true,
							},
						},
						name = "Predict Three-Second Timed Warnings",
						uuid = "587070ab-f5f0-b9d9-a16d-13425fd437be",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "f7ba6c78-e08d-26a8-91cb-0ba33c81dc5b",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actor",
						uuid = "177be2c3-241c-4b5b-9edb-fa3fcfa6e54c",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.spellID == 34716 or eventArgs.spellID == 34774 or eventArgs.spellID == 34799",
						dequeueIfLuaFalse = true,
						name = "Obstacle Cast",
						uuid = "74dbcb24-437c-8059-bbe5-e0c821e2ef7a",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local entity = TensorCore.mGetEntity(eventArgs.entityID)\nreturn entity ~= nil and entity.pos.z > 0",
						name = "Course Area",
						uuid = "bc4be91d-657b-dd84-b237-8f321d07a3d6",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Coloured Eggs and Paths",
			eventType = 2,
			name = "Egg Paths - Predicted Obstacles (3s)",
			timeout = 1,
			uuid = "e2af1503-5ea6-f2c8-aa0d-c650f625c1e6",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local remaining=eventArgs.startTime+eventArgs.duration*1000-Now()\nlocal player=TensorCore.mGetPlayer()\nif remaining>0 and player then\n    AnyoneCore.addWorldTextCountdownOnEnt(remaining,player.id,AnyoneCore.white,true,1.3,3)\nend\nself.used=true",
						conditions = 
						{
							
							{
								"741ee41b-07c9-5dc0-837c-91cc0e472494",
								true,
							},
							
							{
								"cca32f3b-ca46-3bb6-a624-6ab3137b2ed0",
								true,
							},
							
							{
								"30c7a0c6-d7ed-33ab-bd06-0572df943a3e",
								true,
							},
							
							{
								"702acb47-630c-dc53-be63-f894529e634c",
								true,
							},
						},
						name = "Countdown Above Player in Range",
						uuid = "1df678d3-daa2-f894-bf87-9c7bd68b1699",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "741ee41b-07c9-5dc0-837c-91cc0e472494",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.aoeID == 34800 and eventArgs.friendly == false and eventArgs.duration > 0",
						dequeueIfLuaFalse = true,
						name = "Typhon Knockback",
						uuid = "cca32f3b-ca46-3bb6-a624-6ab3137b2ed0",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return AnyoneCore ~= nil and type(AnyoneCore.addWorldTextCountdownOnEnt) == \"function\"",
						name = "AnyoneCore Countdown",
						uuid = "30c7a0c6-d7ed-33ab-bd06-0572df943a3e",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "if Now()>=eventArgs.startTime+eventArgs.duration*1000 then return false end\nlocal player=TensorCore.mGetPlayer()\nif not player then return false end\nlocal dx,dz=player.pos.x-eventArgs.x,player.pos.z-eventArgs.z\nlocal h=eventArgs.heading\nlocal forward=dx*math.sin(h)+dz*math.cos(h)\nlocal sideways=dx*math.cos(h)-dz*math.sin(h)\nreturn forward>=0 and forward<=eventArgs.aoeLength\n    and math.abs(sideways)<=eventArgs.aoeWidth/2\n    and math.abs(player.pos.y-eventArgs.y)<5",
						name = "Inside Knockback Corridor",
						uuid = "702acb47-630c-dc53-be63-f894529e634c",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Coloured Eggs and Paths",
			eventType = 18,
			name = "Egg Paths - Player Knockback Countdown",
			timeout = 4,
			uuid = "e63bf3fa-a90e-8a24-b62e-0109f118ee6d",
			version = 2,
		},
	},
	
	{
		data = 
		{
			displayPath = "02 - Second Round",
			name = "Circular Chase - Typhon",
			uuid = "9fa16912-3b2d-d246-b84e-14476bab919e",
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
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\nlocal remaining=eventArgs.startTime+eventArgs.duration*1000-Now()\nif remaining>0 then\n    local d=countdownDrawer()\n    if eventArgs.aoeID==34805 then\n        d:addTimedCircle(remaining,eventArgs.x,eventArgs.y,eventArgs.z,eventArgs.aoeLength,0,false,true)\n    elseif eventArgs.aoeID==35409 then\n        -- Argus supplies the corridor endpoint and heading back along its path.\n        local entity=TensorCore.mGetEntity(eventArgs.entityID)\n        if entity then\n            local p=entity.pos\n            local dx,dz=eventArgs.x-p.x,eventArgs.z-p.z\n            d:addTimedCenteredRect(remaining,(p.x+eventArgs.x)/2,(p.y+eventArgs.y)/2,\n                (p.z+eventArgs.z)/2,eventArgs.aoeLength,eventArgs.aoeWidth,\n                math.atan2(dx,dz),0,false,true)\n        end\n    else\n        -- 180-degree hammer swing confirmed from the recorded floor telegraph.\n        d:addTimedCone(remaining,eventArgs.x,eventArgs.y,eventArgs.z,eventArgs.aoeLength,math.pi,eventArgs.heading,0,false,true)\n    end\nend\nself.used=true",
						conditions = 
						{
							
							{
								"19282b87-cc21-04f1-aa75-c1b8d8537694",
								true,
							},
							
							{
								"a5bd237d-bcda-6f75-a272-ba54f60e84a8",
								true,
							},
						},
						name = "Draw Timed Typhon Warnings",
						uuid = "f65858bf-93b5-425b-bd50-78c3d0bc2177",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "19282b87-cc21-04f1-aa75-c1b8d8537694",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.friendly == false and eventArgs.duration > 0 and eventArgs.aoeLength > 0 and ((eventArgs.aoeID == 34805 and eventArgs.aoeCastType == 2) or (eventArgs.aoeID == 35409 and eventArgs.aoeCastType == 8 and eventArgs.aoeWidth > 0))",
						dequeueIfLuaFalse = true,
						name = "Typhon Hazard",
						uuid = "a5bd237d-bcda-6f75-a272-ba54f60e84a8",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Circular Chase - Typhon",
			eventType = 18,
			name = "Typhon - Announced Obstacle Warnings",
			timeout = 1,
			uuid = "9145fc9e-b115-0eb4-9009-23017e40a52a",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\n-- Predictions from observed obstacle cycles, not server snapshot timers.\nlocal p={x=eventArgs.x,y=eventArgs.y,z=eventArgs.z,h=eventArgs.heading}\nlocal now = Now()\nlocal ability = eventArgs.aoeID\ndata.blunderPredict = data.blunderPredict or {}\nlocal states = data.blunderPredict\nlocal key = tostring(ability) .. \":\" .. tostring(eventArgs.entityID)\nlocal state = states[key]\nif not state or now - state.last > 15000 then\n    state = {history = {}, scheduled = {}, last = now}\n    states[key] = state\nend\nlocal history = state.history\nlocal shape={eventArgs.aoeCastType,eventArgs.aoeLength,eventArgs.aoeWidth}\n-- Sliders use the authoritative corridor event; do not extrapolate moving endpoints.\nif ability==35409 then self.used=true return end\nlocal point = {x=p.x, y=p.y, z=p.z, h=p.h, t=eventArgs.startTime+eventArgs.duration*1000,\n    length=shape[2], width=shape[3], kind=shape[1]}\nif shape[1] == 8 then\n    -- Sliding corridor: endpoints are supplied by the observed ground cast.\n    local x, y, z = eventArgs.castPosX, eventArgs.castPosY, eventArgs.castPosZ\n    if x == nil or y == nil or z == nil then self.used = true return end\n    local dx, dz = x-p.x, z-p.z\n    point.length = math.sqrt(dx*dx + dz*dz)\n    if point.length < 0.5 or point.length > 50 then self.used = true return end\n    point.x, point.y, point.z = (p.x+x)/2, (p.y+y)/2, (p.z+z)/2\n    point.kind = 12\n    point.centered = true\nend\nhistory[#history+1] = point\nif #history > 18 then table.remove(history, 1) end\nstate.last = now\nlocal n = #history\nif n < 4 then self.used = true return end\nlocal function matches(a,b)\n    return math.abs(a.x-b.x)<0.4 and math.abs(a.y-b.y)<0.5\n        and math.abs(a.z-b.z)<0.4 and math.abs(a.length-b.length)<0.5\n        and math.abs(math.sin(a.h-b.h))<0.1 and math.cos(a.h-b.h)>0.99\nend\nlocal period\nfor candidate=1,math.min(8, math.floor((n-1)/2)) do\n    local equal=true\n    for j=0,candidate-1 do\n        local recent,prior=n-j,n-j-candidate\n        if not matches(history[recent],history[prior])\n            or math.abs((history[recent].t-history[recent-1].t)\n                -(history[prior].t-history[prior-1].t))>650 then equal=false break end\n    end\n    if equal then period=candidate break end\nend\nlocal intervals={}\nfor i=math.max(2,n-7),n do\n    intervals[#intervals+1]=history[i].t-history[i-1].t\nend\ntable.sort(intervals)\nlocal interval=intervals[math.ceil(#intervals/2)]\n-- Reject unstable sequences rather than extrapolate changing hit times.\nif interval<350 or interval>10000 or (not period and intervals[#intervals]-intervals[1]>650) then\n    self.used=true return\nend\nlocal linear=false\nlocal vx,vy,vz\nif not period then\n    -- Moving hazards can be extrapolated only after three consistent steps.\n    local a,b=history[n-1],history[n]\n    local dt=b.t-a.t\n    vx,vy,vz=(b.x-a.x)/dt,(b.y-a.y)/dt,(b.z-a.z)/dt\n    linear=true\n    for i=n-2,n-1 do\n        local old,new=history[i-1],history[i]\n        local elapsed=new.t-old.t\n        if elapsed<=0 or math.abs((new.x-old.x)-vx*elapsed)>0.5\n            or math.abs((new.y-old.y)-vy*elapsed)>0.5\n            or math.abs((new.z-old.z)-vz*elapsed)>0.5 then linear=false break end\n    end\n    if not linear then self.used=true return end\nend\nlocal drawer=countdownDrawer()\nlocal future={}\nfor _,scheduled in ipairs(state.scheduled) do\n    if scheduled.t>now+150 then future[#future+1]=scheduled end\nend\nstate.scheduled=future\nlocal deadline=point.t\nfor step=1,9 do\n    local stepInterval=interval\n    if period then\n        local index=n-period+1+((step-1)%period)\n        local samples={}\n        while index>=2 do\n            samples[#samples+1]=history[index].t-history[index-1].t\n            index=index-period\n        end\n        table.sort(samples)\n        stepInterval=samples[math.ceil(#samples/2)]\n    end\n    if stepInterval<350 or stepInterval>10000 then break end\n    deadline=deadline+stepInterval\n    local nextPoint\n    if period then\n        nextPoint=history[n-period+1+((step-1)%period)]\n    else\n        nextPoint={x=point.x+vx*(deadline-now),y=point.y+vy*(deadline-now),\n            z=point.z+vz*(deadline-now),h=point.h,length=point.length,\n            width=point.width,kind=point.kind,centered=point.centered}\n    end\n    local duplicate=false\n    for _,scheduled in ipairs(future) do\n        if math.abs(scheduled.t-deadline)<math.min(500,stepInterval*0.4) and matches(scheduled.point,nextPoint) then\n            duplicate=true break\n        end\n    end\n    if not duplicate then\n        local delay=math.max(0,deadline-now-3000)\n        local duration=math.min(3000,deadline-now)\n        if nextPoint.kind==2 then\n            drawer:addTimedCircle(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,delay,false,true)\n        elseif nextPoint.kind==13 then\n            drawer:addTimedCone(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,math.pi,nextPoint.h,delay,false,true)\n        elseif nextPoint.centered then\n            drawer:addTimedCenteredRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        else\n            drawer:addTimedRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        end\n        future[#future+1]={t=deadline,point=nextPoint}\n    end\n    if deadline-now>=3000 then break end\nend\nself.used=true\n",
						conditions = 
						{
							
							{
								"484c8478-db5b-77b7-983d-01388c759f60",
								true,
							},
							
							{
								"2edb7c0c-0cc0-6348-9697-6c1fcd09b21b",
								true,
							},
						},
						name = "Draw Timed Typhon Warnings",
						uuid = "4a818ad1-b364-bd06-821a-6e584a5cd553",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "484c8478-db5b-77b7-983d-01388c759f60",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.friendly == false and eventArgs.duration > 0 and eventArgs.aoeLength > 0 and ((eventArgs.aoeID == 34805 and eventArgs.aoeCastType == 2) or (eventArgs.aoeID == 35409 and eventArgs.aoeCastType == 8 and eventArgs.aoeWidth > 0))",
						dequeueIfLuaFalse = true,
						name = "Typhon Hazard",
						uuid = "2edb7c0c-0cc0-6348-9697-6c1fcd09b21b",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Circular Chase - Typhon",
			eventType = 18,
			name = "Typhon - Predicted Obstacles (3s)",
			timeout = 1,
			uuid = "81e79807-e5f8-1522-b059-efc434cc30ec",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+1.5,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\nlocal entity=TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used=true return end\nlocal now=Now()\ndata.typhonRotation=data.typhonRotation or {history={},scheduled={}}\nlocal s=data.typhonRotation\nif not s.last or now-s.last>5000 then\n    s.history={} s.scheduled={} s.entity=eventArgs.entityID\nend\n-- Two collision proxies alternate along the same rotating lane; track one.\nif s.entity~=eventArgs.entityID then self.used=true return end\nlocal p=entity.pos\nlocal history=s.history\nlocal angle=p.h\nif #history>0 then\n    local previous=history[#history]\n    angle=previous.angle+math.atan2(math.sin(p.h-previous.h),math.cos(p.h-previous.h))\nend\nhistory[#history+1]={t=now,angle=angle,h=p.h}\nif #history>6 then table.remove(history,1) end\ns.last=now\nif #history<4 then self.used=true return end\nlocal meanT,meanA=0,0\nfor _,point in ipairs(history) do meanT=meanT+point.t meanA=meanA+point.angle end\nmeanT=meanT/#history meanA=meanA/#history\nlocal numerator,denominator=0,0\nlocal intervals={}\nfor i,point in ipairs(history) do\n    numerator=numerator+(point.t-meanT)*(point.angle-meanA)\n    denominator=denominator+(point.t-meanT)^2\n    if i>1 then intervals[#intervals+1]=point.t-history[i-1].t end\nend\nif denominator<=0 then self.used=true return end\nlocal omega=numerator/denominator\ntable.sort(intervals)\nlocal interval=intervals[math.ceil(#intervals/2)]\nif interval<500 or interval>2500 or math.abs(omega)<0.00005 or math.abs(omega)>0.0006 then self.used=true return end\n-- Reject irregular turns; fit the measured rotation rather than a fixed speed.\nfor _,point in ipairs(history) do\n    if math.abs(point.angle-(meanA+omega*(point.t-meanT)))>0.1 then self.used=true return end\nend\nlocal drawer=countdownDrawer()\nlocal future={}\nfor _,time in ipairs(s.scheduled) do if time>now+150 then future[#future+1]=time end end\ns.scheduled=future\nfor step=1,math.ceil(3000/interval) do\n    local deadline=now+step*interval\n    local duplicate=false\n    for _,time in ipairs(future) do if math.abs(time-deadline)<400 then duplicate=true break end end\n    if not duplicate then\n        local heading=angle+omega*(deadline-now)\n        local delay=math.max(0,deadline-now-3000)\n        drawer:addTimedRect(math.min(3000,deadline-now),p.x,p.y,p.z,100,8,heading,delay,false,true)\n        future[#future+1]=deadline\n    end\nend\nself.used=true",
						conditions = 
						{
							
							{
								"447ab63b-2bff-1d25-ba51-4e14d7de5dca",
								true,
							},
							
							{
								"8a3a437e-6636-0dd8-9039-ffc25226d2b4",
								true,
							},
						},
						name = "Draw Timed Typhon Warnings",
						uuid = "1458c46d-8b92-3372-b2d3-e78c14ae332e",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "447ab63b-2bff-1d25-ba51-4e14d7de5dca",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.spellID == 34808 and eventArgs.entityContentID == 108",
						dequeueIfLuaFalse = true,
						name = "Typhon Hazard",
						uuid = "8a3a437e-6636-0dd8-9039-ffc25226d2b4",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Circular Chase - Typhon",
			eventType = 2,
			name = "Typhon - Predicted Rotating Lane (3s)",
			timeout = 1,
			uuid = "80fd8485-51c8-51b3-bcdc-ea8eaf70a6d4",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local now=Now()\nlocal deadline=eventArgs.startTime+eventArgs.duration*1000\nif deadline<=now then self.used=true return end\ndata.typhonTrackedSwing=data.typhonTrackedSwing or {}\nlocal key=tostring(math.floor(eventArgs.x*2+0.5))..\":\"..tostring(math.floor(eventArgs.z*2+0.5))\nlocal states=data.typhonTrackedSwing\nlocal s=states[key]\nif not s or now-s.observed>15000 then s={intervals={}} states[key]=s end\nif s.deadline and math.abs(s.deadline-deadline)<150 then self.used=true return end\nlocal d=TensorCore.getMoogleDrawer()\nif s.current then Argus.deleteTimedShape(s.current) s.current=nil end\nlocal covered=s.future and math.abs(s.next-deadline)<650\n    and math.cos(s.heading-eventArgs.heading)>0.99\nif covered then\n    s.current=s.future s.future=nil\nelse\n    if s.future then Argus.deleteTimedShape(s.future) s.future=nil end\n    s.current=d:addTimedCone(deadline-now,eventArgs.x,eventArgs.y,eventArgs.z,\n        eventArgs.aoeLength,math.pi,eventArgs.heading,0,false,true)\nend\nif s.deadline then\n    local interval=deadline-s.deadline\n    if interval>=3800 and interval<=8000 then\n        s.intervals[#s.intervals+1]=interval\n        if #s.intervals>5 then table.remove(s.intervals,1) end\n    else s.intervals={} end\nend\ns.deadline=deadline s.observed=now\nlocal interval=5000\nif #s.intervals>0 then\n    local samples={}\n    for _,v in ipairs(s.intervals) do samples[#samples+1]=v end\n    table.sort(samples)\n    interval=samples[math.ceil(#samples/2)]\nend\ns.next=deadline+interval s.heading=eventArgs.heading+math.pi\nlocal delay=math.max(deadline-now,s.next-now-3000)\ns.future=d:addTimedCone(s.next-now-delay,eventArgs.x,eventArgs.y,eventArgs.z,\n    eventArgs.aoeLength,math.pi,s.heading,delay,false,true)\nself.used=true",
						conditions = 
						{
							
							{
								"da0763bf-800f-30e0-9c7e-9f7209cff8bb",
								true,
							},
							
							{
								"765c955c-34b6-24a5-85bb-f061865220c5",
								true,
							},
						},
						name = "Draw Timed Single 180-Degree Swing",
						uuid = "842c3622-37aa-15fa-b415-6291ce143de8",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "da0763bf-800f-30e0-9c7e-9f7209cff8bb",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.friendly == false and eventArgs.duration > 0 and eventArgs.aoeCastType == 13 and (eventArgs.aoeID == 34797 or eventArgs.aoeID == 34798)",
						dequeueIfLuaFalse = true,
						name = "Half-Circle Swing",
						uuid = "765c955c-34b6-24a5-85bb-f061865220c5",
						version = 3,
					},
				},
			},
			displayPath = "02 - Second Round/Circular Chase - Typhon",
			eventType = 18,
			name = "Typhon - Single Half-Circle Swing (3s)",
			timeout = 1,
			uuid = "320647ed-de08-e8b8-b99d-fab732fb97f5",
			version = 2,
		},
	},
	
	{
		data = 
		{
			displayPath = "",
			name = "03 - Final Race",
			uuid = "dcf90b4a-9ba0-2608-a0d3-8d1d65a8f41d",
		},
		objectType = "folder",
	},
	
	{
		data = 
		{
			displayPath = "03 - Final Race",
			name = "AOE Draws",
			uuid = "1344da9c-e884-eea7-b0fa-afb3ad7069fd",
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
						actionLua = "local remaining = eventArgs.duration * 1000 - (Now() - eventArgs.startTime)\nif remaining > 0 then\n    local drawer = TensorCore.getMoogleDrawer()\n    drawer:addTimedRect(remaining, eventArgs.x, eventArgs.y, eventArgs.z, eventArgs.aoeLength, eventArgs.aoeWidth, eventArgs.heading, 0, false, true)\nend\nself.used = true",
						conditions = 
						{
							
							{
								"4ad3b7f5-f99b-faae-ad22-a9a42b1388bb",
								true,
							},
							
							{
								"4d6af054-311c-c375-bd69-402b1804f829",
								true,
							},
						},
						name = "Draw Recorded Warning",
						uuid = "f997d444-932f-8db8-a980-1cbee9fb2565",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "4ad3b7f5-f99b-faae-ad22-a9a42b1388bb",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.aoeID == 34812\n    and eventArgs.aoeCastType == 12\n    and eventArgs.friendly == false\n    and eventArgs.duration > 0\n    and eventArgs.aoeLength > 0\n    and eventArgs.aoeWidth > 0",
						dequeueIfLuaFalse = true,
						name = "Hazard 34812",
						uuid = "4d6af054-311c-c375-bd69-402b1804f829",
						version = 3,
					},
				},
			},
			displayPath = "03 - Final Race/AOE Draws",
			eventType = 18,
			name = "Final - Alternating Squares (34812)",
			timeout = 1,
			uuid = "c5758b6c-c0cc-5522-b67e-0e0bc158daf1",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Countdown records share the shape's exact start, expiry and cancellation.\nlocal function removeWarning(uuid)\n    if data.blunderDrawCountdowns then data.blunderDrawCountdowns[uuid]=nil end\n    Argus.deleteTimedShape(uuid)\nend\nlocal function countdownDrawer()\n    local base=TensorCore.getMoogleDrawer()\n    local proxy={}\n    local function track(uuid,timeout,x,y,z,delay)\n        if uuid then\n            data.blunderDrawCountdowns=data.blunderDrawCountdowns or {}\n            local start=Now()+(delay or 0)\n            local labelHeight=(eventArgs.spellID==29795 or eventArgs.spellID==34796) and 5 or 1.5\n            data.blunderDrawCountdowns[uuid]={start=start,finish=start+timeout,x=x,y=y+labelHeight,z=z}\n        end\n        return uuid\n    end\n    function proxy:addTimedCircle(t,x,y,z,r,delay,old,ignore,renderFlags)\n        return track(base:addTimedCircle(t,x,y,z,r,delay,old,ignore,renderFlags),t,x,y,z,delay)\n    end\n    function proxy:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore)\n        return track(base:addTimedCenteredRect(t,x,y,z,l,w,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    function proxy:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore)\n        return track(base:addTimedCone(t,x,y,z,l,angle,h,delay,old,ignore),t,x,y,z,delay)\n    end\n    return proxy\nend\n-- Remove the prepared first-hit placement on the actual attack event.\nlocal initial=data.blunderInitialWarnings\nlocal preview=initial and initial.draws[eventArgs.entityID]\nif preview and preview.uuid and preview.spell==eventArgs.spellID then\n    removeWarning(preview.uuid)\n    initial.draws[eventArgs.entityID]={spell=preview.spell,resolved=true}\nend\nlocal geometry = {[29795]={2,3,0}, [34796]={2,5,0}, [34801]={2,6,0}, [34802]={2,5,0}, [34804]={12,6,6}}\n-- Predictions from observed obstacle cycles, not server snapshot timers.\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nif not entity then self.used = true return end\nlocal p = entity.pos\nlocal now = Now()\nlocal ability = eventArgs.spellID\ndata.blunderFinalStartupV2 = data.blunderFinalStartupV2 or {}\nlocal states = data.blunderFinalStartupV2\nlocal key = tostring(ability) .. \":\" .. tostring(eventArgs.entityID)\nlocal state = states[key]\nif not state or now - state.last > 15000 then\n    state = {history = {}, scheduled = {}, last = now}\n    states[key] = state\nend\nlocal history = state.history\nlocal shape = geometry[ability]\nlocal point = {x=p.x, y=p.y, z=p.z, h=p.h, t=now,\n    length=shape[2], width=shape[3], kind=shape[1]}\nif shape[1] == 8 then\n    -- Sliding corridor: endpoints are supplied by the observed ground cast.\n    local x, y, z = eventArgs.castPosX, eventArgs.castPosY, eventArgs.castPosZ\n    if x == nil or y == nil or z == nil then self.used = true return end\n    local dx, dz = x-p.x, z-p.z\n    point.length = math.sqrt(dx*dx + dz*dz)\n    if point.length < 0.5 or point.length > 50 then self.used = true return end\n    point.x, point.y, point.z = (p.x+x)/2, (p.y+y)/2, (p.z+z)/2\n    point.kind = 12\n    point.centered = true\nend\nhistory[#history+1] = point\nif #history > 18 then table.remove(history, 1) end\nstate.last = now\nlocal n = #history\nif ability==34801 then\n    -- One complete repeating sweep can include two different course rows.\n    if state.preview then removeWarning(state.preview) state.preview=nil end\n    for _,warning in ipairs(state.circleWarnings or {}) do removeWarning(warning.uuid) end\n    state.circleWarnings={}\n    local function same(a,b)\n        return math.abs(a.x-b.x)<0.4 and math.abs(a.y-b.y)<0.5\n            and math.abs(a.z-b.z)<0.4\n    end\n    local period\n    for _,candidate in ipairs({4,8}) do\n        if n>=candidate+1 then\n            local valid=true\n            for i=candidate+1,n do\n                if not same(history[i],history[i-candidate]) then valid=false break end\n            end\n            if valid then period=candidate break end\n        end\n    end\n    if not period then self.used=true return end\n    local drawer=countdownDrawer()\n    local deadline=now\n    for step=1,4 do\n        local index=n-period+step\n        local nextImpact=history[index]\n        local samples={}\n        for i=index,n,period do\n            if i>=2 then samples[#samples+1]=history[i].t-history[i-1].t end\n        end\n        if #samples==0 then self.used=true return end\n        table.sort(samples)\n        local interval=samples[math.ceil(#samples/2)]\n        if interval<500 or interval>6000 then self.used=true return end\n        deadline=deadline+interval\n        local delay=math.max(0,deadline-now-3000)\n        local duration=deadline-now-delay\n        local uuid=drawer:addTimedCircle(duration,nextImpact.x,nextImpact.y,nextImpact.z,\n            point.length,delay,false,true,Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n        state.circleWarnings[#state.circleWarnings+1]={uuid=uuid,t=deadline}\n    end\n    self.used=true return\nend\nif ability==34802 then\n    if state.preview then removeWarning(state.preview) state.preview=nil end\n    local previous=history[n-1]\n    local interval=previous and now-previous.t or 3200\n    if interval<500 or interval>6000 then self.used=true return end\n    local x,y,z=point.x,point.y,point.z\n    if ability==34801 then\n        -- Impacts wrap through four recorded positions, not a straight line.\n        if n<4 then self.used=true return end\n        local nextImpact=history[n-3]\n        for i=n-2,n do\n            if math.abs(history[i].z-point.z)>0.4\n                or math.abs(history[i].y-point.y)>0.5 then self.used=true return end\n        end\n        local unique={}\n        for i=n-3,n do\n            for _,v in ipairs(unique) do\n                if math.abs(v-history[i].x)<0.4 then self.used=true return end\n            end\n            unique[#unique+1]=history[i].x\n        end\n        x,y,z=nextImpact.x,nextImpact.y,nextImpact.z\n        if n>=5 then\n            local prior=history[n-4]\n            if math.abs(prior.x-point.x)<0.4 and math.abs(prior.z-point.z)<0.4 then\n                interval=nextImpact.t-prior.t\n            end\n        end\n        if interval<500 or interval>6000 then self.used=true return end\n    end\n    if state.preview then removeWarning(state.preview) end\n    -- The hazard actor can be above the course. Keep X/Z and use the mesh floor.\n    local floor=NavigationManager:GetClosestPointOnMesh({x=x,y=y,z=z})\n    if floor and (floor.x-x)^2+(floor.z-z)^2<=0.25\n        and floor.y<=y+0.5 and y-floor.y<=10 then\n        y=floor.y\n    end\n    local delay=math.max(0,interval-3000)\n    state.preview=countdownDrawer():addTimedCircle(interval-delay,\n        x,y,z,point.length,delay,false,true,Argus2.RenderFlags.FLAG_WARP_TERRAIN)\n    self.used=true return\nend\nif ability==34804 then\n    -- Four impacts form one descending row. Never extrapolate beyond it.\n    if n<4 then self.used=true return end\n    local first=n-3\n    for i=first+1,n do\n        local prior,current=history[i-1],history[i]\n        if math.abs(current.x-prior.x)>0.4\n            or math.abs((current.z-prior.z)-6)>0.4 then\n            self.used=true return\n        end\n    end\n    local cycle=6000\n    for i=first-1,1,-1 do\n        if math.abs(history[i].z-history[first].z)<0.4 then\n            local observed=history[first].t-history[i].t\n            if observed>=4500 and observed<=7500 then cycle=observed end\n            break\n        end\n    end\n    local rowStarts=history[first].t+cycle\n    if state.rowStarts and math.abs(state.rowStarts-rowStarts)<1000 then\n        self.used=true return\n    end\n    state.rowStarts=rowStarts\n    local delay=math.max(0,rowStarts-now-3000)\n    local drawer=countdownDrawer()\n    for i=first,n do\n        local square=history[i]\n        local duration=square.t+cycle-now-delay\n        if duration>0 then\n            drawer:addTimedCenteredRect(duration,square.x,square.y,square.z,\n                square.length,square.width,square.h,delay,false,true)\n        end\n    end\n    self.used=true return\nend\nif n < 4 then self.used = true return end\nlocal function matches(a,b)\n    return math.abs(a.x-b.x)<0.4 and math.abs(a.y-b.y)<0.5\n        and math.abs(a.z-b.z)<0.4 and math.abs(a.length-b.length)<0.5\n        and math.abs(math.sin(a.h-b.h))<0.1 and math.cos(a.h-b.h)>0.99\nend\nlocal period\nfor candidate=1,math.min(8, math.floor((n-1)/2)) do\n    local equal=true\n    for j=0,candidate-1 do\n        local recent,prior=n-j,n-j-candidate\n        if not matches(history[recent],history[prior])\n            or math.abs((history[recent].t-history[recent-1].t)\n                -(history[prior].t-history[prior-1].t))>650 then equal=false break end\n    end\n    if equal then period=candidate break end\nend\nlocal intervals={}\nfor i=math.max(2,n-7),n do\n    intervals[#intervals+1]=history[i].t-history[i-1].t\nend\ntable.sort(intervals)\nlocal interval=intervals[math.ceil(#intervals/2)]\n-- Reject unstable sequences rather than extrapolate changing hit times.\nif interval<350 or interval>10000 or (not period and intervals[#intervals]-intervals[1]>650) then\n    self.used=true return\nend\nlocal linear=false\nlocal vx,vy,vz\nif not period then\n    -- Moving hazards can be extrapolated only after three consistent steps.\n    local a,b=history[n-1],history[n]\n    local dt=b.t-a.t\n    vx,vy,vz=(b.x-a.x)/dt,(b.y-a.y)/dt,(b.z-a.z)/dt\n    linear=true\n    for i=n-2,n-1 do\n        local old,new=history[i-1],history[i]\n        local elapsed=new.t-old.t\n        if elapsed<=0 or math.abs((new.x-old.x)-vx*elapsed)>0.5\n            or math.abs((new.y-old.y)-vy*elapsed)>0.5\n            or math.abs((new.z-old.z)-vz*elapsed)>0.5 then linear=false break end\n    end\n    if not linear then self.used=true return end\nend\nlocal drawer=countdownDrawer()\nlocal future={}\nfor _,scheduled in ipairs(state.scheduled) do\n    if scheduled.t>now+150 then future[#future+1]=scheduled end\nend\nstate.scheduled=future\nlocal deadline=now\nfor step=1,9 do\n    local stepInterval=interval\n    if period then\n        local index=n-period+1+((step-1)%period)\n        local samples={}\n        while index>=2 do\n            samples[#samples+1]=history[index].t-history[index-1].t\n            index=index-period\n        end\n        table.sort(samples)\n        stepInterval=samples[math.ceil(#samples/2)]\n    end\n    if stepInterval<350 or stepInterval>10000 then break end\n    deadline=deadline+stepInterval\n    local nextPoint\n    if period then\n        nextPoint=history[n-period+1+((step-1)%period)]\n    else\n        nextPoint={x=point.x+vx*(deadline-now),y=point.y+vy*(deadline-now),\n            z=point.z+vz*(deadline-now),h=point.h,length=point.length,\n            width=point.width,kind=point.kind,centered=point.centered}\n    end\n    local duplicate=false\n    for _,scheduled in ipairs(future) do\n        if math.abs(scheduled.t-deadline)<math.min(500,stepInterval*0.4) and matches(scheduled.point,nextPoint) then\n            duplicate=true break\n        end\n    end\n    if not duplicate then\n        local delay=math.max(0,deadline-now-3000)\n        local duration=math.min(3000,deadline-now)\n        if nextPoint.kind==2 then\n            drawer:addTimedCircle(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,delay,false,true)\n        elseif nextPoint.centered then\n            drawer:addTimedCenteredRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        else\n            drawer:addTimedRect(duration,nextPoint.x,nextPoint.y,nextPoint.z,\n                nextPoint.length,nextPoint.width,nextPoint.h,delay,false,true)\n        end\n        future[#future+1]={t=deadline,point=nextPoint}\n    end\n    if deadline-now>=3000 then break end\nend\nself.used=true\n",
						conditions = 
						{
							
							{
								"8541bd43-3c56-d92f-9f10-9f565ee61587",
								true,
							},
							
							{
								"2c3a2ca9-c462-167f-bca5-c3e3575403ea",
								true,
							},
							
							{
								"a9a64926-5207-7044-9f5b-3405e8afd212",
								true,
							},
							
							{
								"88df1671-8717-217a-a834-8b4ed8023e14",
								true,
							},
						},
						name = "Predict Three-Second Timed Warnings",
						uuid = "0928da07-6ba9-8ffe-8ac3-353cd6ecd263",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "8541bd43-3c56-d92f-9f10-9f565ee61587",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actor",
						uuid = "2c3a2ca9-c462-167f-bca5-c3e3575403ea",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return eventArgs.spellID == 29795 or eventArgs.spellID == 34796 or eventArgs.spellID == 34801 or eventArgs.spellID == 34802 or eventArgs.spellID == 34804",
						dequeueIfLuaFalse = true,
						name = "Obstacle Cast",
						uuid = "a9a64926-5207-7044-9f5b-3405e8afd212",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local entity = TensorCore.mGetEntity(eventArgs.entityID)\nreturn entity ~= nil and entity.pos.z > 0",
						name = "Course Area",
						uuid = "88df1671-8717-217a-a834-8b4ed8023e14",
						version = 3,
					},
				},
			},
			displayPath = "03 - Final Race/AOE Draws",
			eventType = 2,
			name = "Final - Predicted Obstacles (3s)",
			timeout = 1,
			uuid = "0f319af4-2fee-1e4c-9d27-3d32f3c03acf",
			version = 2,
		},
	},
	
	{
		data = 
		{
			displayPath = "",
			name = "Shared - Stage Detection",
			uuid = "f48f3743-8da6-c6b2-af00-1bed82124acc",
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
						actionLua = "-- Use the original deadline so queue latency does not extend the countdown.\nlocal remaining = eventArgs.duration * 1000 - (Now() - eventArgs.startTime)\nif remaining > 0 then\n    local showBG = true\n    local size = 1\n    local height = 1\n    if eventArgs.targetAttach then\n        AnyoneCore.addWorldTextCountdownOnEnt(\n            remaining, eventArgs.targetAttach, AnyoneCore.white, showBG, size, height\n        )\n    else\n        local pos = {x = eventArgs.x, y = eventArgs.y + height, z = eventArgs.z}\n        AnyoneCore.addWorldTextCountdown(remaining, pos, AnyoneCore.white, showBG, size)\n    end\nend\nself.used = true",
						conditions = 
						{
							
							{
								"a7acd150-2e69-e558-b076-57b69b372831",
								true,
							},
							
							{
								"159ef7fc-ebb3-ee8f-bcd5-8e540ea88987",
								true,
							},
							
							{
								"2fb460f6-aaf4-54e8-839f-f431df975a43",
								true,
							},
						},
						name = "Draw LJ World Countdown",
						uuid = "0971c7a7-fa56-74c2-adae-970992e90d50",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "a7acd150-2e69-e558-b076-57b69b372831",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local covered={[34716]=true,[34717]=true,[34718]=true,[34773]=true,[34774]=true,[34775]=true,[34776]=true,[34798]=true,[34799]=true,[34801]=true,[34802]=true,[34804]=true,[34805]=true,[34808]=true,[35409]=true}\nif covered[eventArgs.aoeID] then return false end\nreturn eventArgs.friendly == false and eventArgs.duration > 0 and eventArgs.aoeLength > 0 and eventArgs.aoeID ~= 34800",
						dequeueIfLuaFalse = true,
						name = "Hostile Warning",
						uuid = "159ef7fc-ebb3-ee8f-bcd5-8e540ea88987",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return AnyoneCore ~= nil and type(AnyoneCore.addWorldTextCountdown) == \"function\" and type(AnyoneCore.addWorldTextCountdownOnEnt) == \"function\"",
						dequeueIfLuaFalse = true,
						name = "AnyoneCore Countdown",
						uuid = "2fb460f6-aaf4-54e8-839f-f431df975a43",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			eventType = 18,
			name = "World - AoE Hit Countdown",
			timeout = 1,
			uuid = "88c79375-7b92-5a2d-8f7b-b4e20655c9ac",
			version = 2,
		},
	},
	
	{
		data = 
		{
			displayPath = "Shared - Stage Detection",
			name = "Timing Capture",
			uuid = "d6d65e0d-354d-d924-8d99-006b80caf7b0",
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
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnEntityCast\", {spellID=eventArgs.spellID,hitTargets=eventArgs.hitTargets,targetID=eventArgs.targetID,heading=eventArgs.heading,entityID=eventArgs.entityID,targetContentID=eventArgs.targetContentID,hitTargetsContentIDs=eventArgs.hitTargetsContentIDs,entityContentID=eventArgs.entityContentID,castPosZ=eventArgs.castPosZ,castPosY=eventArgs.castPosY,castPosX=eventArgs.castPosX}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nlocal geometry = state.geometry[eventArgs.spellID]\nif not geometry then\n    geometry = Argus.getSpellAOEInfo(eventArgs.spellID)\n    state.geometry[eventArgs.spellID] = geometry\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] cast observed_ms=%.3f entity=%s spell=%s target=%s entity_xyzh=%s cast_xyz=%s,%s,%s shape=%s length=%s width=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.spellID), tostring(eventArgs.targetID), position, tostring(eventArgs.castPosX), tostring(eventArgs.castPosY), tostring(eventArgs.castPosZ), tostring(geometry.aoeCastType), tostring(geometry.aoeLength), tostring(geometry.aoeWidth)))\nself.used = true",
						conditions = 
						{
							
							{
								"a1678f8b-2ffc-2d16-ad80-56e26b1dfe6f",
								true,
							},
							
							{
								"ae447724-e8e5-951f-9885-e7a9bae38ddf",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "d56386ec-9cd2-3e2b-8ab6-2e43f60edb33",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "a1678f8b-2ffc-2d16-ad80-56e26b1dfe6f",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actors",
						uuid = "ae447724-e8e5-951f-9885-e7a9bae38ddf",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 2,
			name = "Timing Capture - Obstacle Casts",
			timeout = 1,
			uuid = "c4351929-048d-4932-991c-28a0e84e99eb",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnEntityChannel\", {spellID=eventArgs.spellID,targetContentID=eventArgs.targetContentID,entityID=eventArgs.entityID,entityContentID=eventArgs.entityContentID,channelTimeMax=eventArgs.channelTimeMax,targetID=eventArgs.targetID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] channel observed_ms=%.3f entity=%s spell=%s max_s=%s entity_xyzh=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.spellID), tostring(eventArgs.channelTimeMax), position))\nself.used = true",
						conditions = 
						{
							
							{
								"d29e8717-7ce7-ed70-851b-20aafe8ce283",
								true,
							},
							
							{
								"fcdef699-a4b5-8cf4-ab64-a7f0b4712b6d",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "1b4cd422-0927-37f9-8be4-8f12f7eead2c",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "d29e8717-7ce7-ed70-851b-20aafe8ce283",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actors",
						uuid = "fcdef699-a4b5-8cf4-ab64-a7f0b4712b6d",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 3,
			name = "Timing Capture - Obstacle Channels",
			timeout = 1,
			uuid = "91f70b85-5d2b-bc03-b99a-8d278dbed8d4",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnAnimationChange\", {newAnimID=eventArgs.newAnimID,oldAnimID=eventArgs.oldAnimID,entityContentID=eventArgs.entityContentID,index=eventArgs.index,entityID=eventArgs.entityID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] animation observed_ms=%.3f entity=%s index=%s old=%s new=%s entity_xyzh=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.index), tostring(eventArgs.oldAnimID), tostring(eventArgs.newAnimID), position))\nself.used = true",
						conditions = 
						{
							
							{
								"ffa886ec-72ab-c405-b07d-83e912210fac",
								true,
							},
							
							{
								"780f5d68-9df2-fa86-84b5-acd66ea58cba",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "62705357-9322-0174-8963-22d49707cca2",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "ffa886ec-72ab-c405-b07d-83e912210fac",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actors",
						uuid = "780f5d68-9df2-fa86-84b5-acd66ea58cba",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 23,
			name = "Timing Capture - Obstacle Animations",
			timeout = 1,
			uuid = "232404fd-2ebb-e590-83d4-2cd10cca0141",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnMapEffect\", {a3=eventArgs.a3,a2=eventArgs.a2,a1=eventArgs.a1}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] map observed_ms=%.3f a1=%s a2=%s a3=%s\\n\", observed, tostring(eventArgs.a1), tostring(eventArgs.a2), tostring(eventArgs.a3)))\nself.used = true",
						conditions = 
						{
							
							{
								"dbacbb77-444e-5de6-8384-b62affb8da7f",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "79d4731d-c2cc-d3b7-9502-f000e6cfe970",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "dbacbb77-444e-5de6-8384-b62affb8da7f",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 14,
			name = "Timing Capture - Map Effects",
			timeout = 1,
			uuid = "e125c55d-95da-c790-bb88-01399aa43bdb",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnNewBuffEntry\", {ownerContentID=eventArgs.ownerContentID,entityContentID=eventArgs.entityContentID,ownerID=eventArgs.ownerID,buffDuration=eventArgs.buffDuration,buffID=eventArgs.buffID,entityID=eventArgs.entityID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] status observed_ms=%.3f entity=%s buff=%s duration_s=%s owner=%s owner_content=%s entity_xyzh=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.buffID), tostring(eventArgs.buffDuration), tostring(eventArgs.ownerID), tostring(eventArgs.ownerContentID), position))\nself.used = true",
						conditions = 
						{
							
							{
								"8e4544f2-275f-5df7-8fe9-ea7ac035ba33",
								true,
							},
							
							{
								"a6fd55bf-9295-f656-aae2-45834004d55c",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "32b32e5e-b567-40e7-9c5a-83cdd89cf3da",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "8e4544f2-275f-5df7-8fe9-ea7ac035ba33",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 0,
						name = "Players",
						uuid = "a6fd55bf-9295-f656-aae2-45834004d55c",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 8,
			name = "Timing Capture - Player Statuses",
			timeout = 1,
			uuid = "1a7f14f6-f982-3365-b30c-9049d983abdc",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnEntityAdd\", {entityName=eventArgs.entityName,entityID=eventArgs.entityID,entityContentID=eventArgs.entityContentID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal model=Argus.getEntityModel(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] add observed_ms=%.3f entity=%s content=%s entity_xyzh=%s model=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.entityContentID), position, tostring(model)))\nif entity and model==16352 then\n    data.blunderStageMarkers=data.blunderStageMarkers or {}\n    local course=(entity.pos.x>100) and \"second-typhon\" or \"second-eggs\"\n    data.blunderStageMarkers[course]={entity=eventArgs.entityID,x=entity.pos.x,\n        z=entity.pos.z,model=model,observed=observed}\n    TensorCore.timelineLogToFile(string.format(\n        \"[BlunderStage] marker observed_ms=%.3f course=%s entity=%s model=%s\\n\",\n        observed,course,tostring(eventArgs.entityID),tostring(model)))\nend\nself.used = true",
						conditions = 
						{
							
							{
								"57220f4f-f977-da91-91d2-216d9f7e2cbd",
								true,
							},
							
							{
								"917981b7-27c1-8076-b017-e0cba9e3006f",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "e17eaeeb-9083-57b2-a9aa-731a40c94bc8",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "57220f4f-f977-da91-91d2-216d9f7e2cbd",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actors",
						uuid = "917981b7-27c1-8076-b017-e0cba9e3006f",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 5,
			name = "Timing Capture - Obstacle Spawns",
			timeout = 1,
			uuid = "3a54d147-4e71-6ca1-9b61-774a44b85da5",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnEntityRemove\", {entityName=eventArgs.entityName,entityID=eventArgs.entityID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] remove observed_ms=%.3f entity=%s\\n\", observed, tostring(eventArgs.entityID)))\nself.used = true",
						conditions = 
						{
							
							{
								"2d370938-cf6f-2ad6-b6d0-8a22846474f3",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "bf93a9c3-6791-2578-a67a-5f3b67b4d6d1",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "2d370938-cf6f-2ad6-b6d0-8a22846474f3",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 6,
			name = "Timing Capture - Entity Removals",
			timeout = 1,
			uuid = "f20d6ec1-1749-7020-9813-874c3b446d01",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnVisibilityChange\", {entityID=eventArgs.entityID,isVisible=eventArgs.isVisible,wasVisible=eventArgs.wasVisible,entityContentID=eventArgs.entityContentID}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nlocal entity = TensorCore.mGetEntity(eventArgs.entityID)\nlocal position = \"unavailable\"\nif entity then\n    local p = entity.pos\n    position = string.format(\"%.4f,%.4f,%.4f,%.5f\", p.x, p.y, p.z, p.h)\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] visibility observed_ms=%.3f entity=%s old=%s new=%s entity_xyzh=%s\\n\", observed, tostring(eventArgs.entityID), tostring(eventArgs.wasVisible), tostring(eventArgs.isVisible), position))\nself.used = true",
						conditions = 
						{
							
							{
								"ed6b63ed-6458-07e4-b88b-0d6d45af1d45",
								true,
							},
							
							{
								"4a5a7a5a-05d8-d64a-bf17-171c4e2b48aa",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "1835d4ac-7b79-e43b-a5d6-197581ac274a",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "ed6b63ed-6458-07e4-b88b-0d6d45af1d45",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						dequeueIfLuaFalse = true,
						eventArgOptionType = 2,
						eventEntityContentID = 108,
						name = "Obstacle Actors",
						uuid = "4a5a7a5a-05d8-d64a-bf17-171c4e2b48aa",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 22,
			name = "Timing Capture - Obstacle Visibility",
			timeout = 1,
			uuid = "9552dd43-5461-4a4f-acf2-7a008d73f9eb",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local observed = Now()\nif BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n    BlundervilleCapture.Event(\"OnAOECreate\", {y=eventArgs.y,targetAttach=eventArgs.targetAttach,isAreaTarget=eventArgs.isAreaTarget,aoeAnimationInfo=eventArgs.aoeAnimationInfo,z=eventArgs.z,aoeName=eventArgs.aoeName,aoeCastType=eventArgs.aoeCastType,aoeWidth=eventArgs.aoeWidth,aoeLength=eventArgs.aoeLength,contentID=eventArgs.contentID,aoeType=eventArgs.aoeType,heading=eventArgs.heading,friendly=eventArgs.friendly,duration=eventArgs.duration,startTime=eventArgs.startTime,delay=eventArgs.delay,x=eventArgs.x,aoeID=eventArgs.aoeID,entityID=eventArgs.entityID,aoeEffectInfo=eventArgs.aoeEffectInfo}, observed)\nend\n\ndata.blunderTiming = data.blunderTiming or {geometry = {}}\nlocal state = data.blunderTiming\nif not state.started then\n    state.started = observed\n    TensorCore.timelineLogToFile(string.format(\"[BlunderClock] session observed_ms=%.3f wall_epoch_s=%d\\n\", observed, os.time()))\nend\nTensorCore.timelineLogToFile(string.format(\"[BlunderClock] aoe observed_ms=%.3f start_ms=%s duration_s=%s entity=%s spell=%s friendly=%s xyz=%s,%s,%s heading=%s shape=%s length=%s width=%s delay=%s attachment=%s\\n\", observed, tostring(eventArgs.startTime), tostring(eventArgs.duration), tostring(eventArgs.entityID), tostring(eventArgs.aoeID), tostring(eventArgs.friendly), tostring(eventArgs.x), tostring(eventArgs.y), tostring(eventArgs.z), tostring(eventArgs.heading), tostring(eventArgs.aoeCastType), tostring(eventArgs.aoeLength), tostring(eventArgs.aoeWidth), tostring(eventArgs.delay), tostring(eventArgs.targetAttach)))\nself.used = true",
						conditions = 
						{
							
							{
								"ac438eec-d863-2286-ad17-66b0a347c99f",
								true,
							},
						},
						name = "Record Clock and Event",
						uuid = "8522e517-0d73-72b7-b54a-15133753f826",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "ac438eec-d863-2286-ad17-66b0a347c99f",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 18,
			name = "Timing Capture - AOE Records",
			timeout = 1,
			uuid = "c6c131fe-badc-6169-91af-73c2c10055fd",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Removal is sampled because OnNewBuffEntry reports additions only.\nlocal player=TensorCore.mGetPlayer()\nif not player then self.used=true return end\nlocal now=Now()\nlocal p=player.pos\nlocal course=data.blunderStage and data.blunderStage.course or \"unclassified\"\nlocal state=data.blunderStatusExpiry\nif not state or state.player~=player.id then\n    state={player=player.id,statuses={}}\n    data.blunderStatusExpiry=state\n    TensorCore.timelineLogToFile(string.format(\n        \"[BlunderStatus] baseline observed_ms=%.3f entity=%s course=%s xyz=%.3f,%.3f,%.3f\\n\",\n        now,tostring(player.id),course,p.x,p.y,p.z))\nend\nlocal current={}\nfor _,buff in ipairs(TensorCore.getBuffs(player,false)) do\n    local key=tostring(buff.id)..\":\"..tostring(buff.ownerid)..\":\"..tostring(buff.slot)\n    local previous=state.statuses[key]\n    local entry={id=buff.id,name=buff.name,owner=buff.ownerid,slot=buff.slot,\n        duration=buff.duration,stacks=buff.stacks,lastSeen=now,\n        expiry=now+buff.duration*1000}\n    current[key]=entry\n    if not previous or buff.duration>previous.duration+1 or buff.stacks~=previous.stacks then\n        local kind=previous and \"refresh\" or \"present\"\n        TensorCore.timelineLogToFile(string.format(\n            \"[BlunderStatus] %s observed_ms=%.3f entity=%s buff=%s name=%s owner=%s slot=%s duration_s=%.3f stacks=%s expiry_estimate_ms=%.3f course=%s xyz=%.3f,%.3f,%.3f\\n\",\n            kind,now,tostring(player.id),tostring(buff.id),buff.name,tostring(buff.ownerid),\n            tostring(buff.slot),buff.duration,tostring(buff.stacks),entry.expiry,course,p.x,p.y,p.z))\n    end\nend\nfor key,previous in pairs(state.statuses) do\n    if not current[key] then\n        if previous.id==3782 then\n            data.blunderRoundClock={course=course,lastBound=previous.lastSeen,\n                released=now,uncertainty=now-previous.lastSeen}\n            TensorCore.timelineLogToFile(string.format(\n                \"[BlunderStart] released observed_ms=%.3f last_bound_ms=%.3f uncertainty_ms=%.3f course=%s\\n\",\n                now,previous.lastSeen,now-previous.lastSeen,course))\n        end\n        TensorCore.timelineLogToFile(string.format(\n            \"[BlunderStatus] removed observed_ms=%.3f last_present_ms=%.3f first_absent_ms=%.3f entity=%s buff=%s name=%s owner=%s slot=%s last_duration_s=%.3f expiry_estimate_ms=%.3f course=%s xyz=%.3f,%.3f,%.3f\\n\",\n            now,previous.lastSeen,now,tostring(player.id),tostring(previous.id),previous.name,\n            tostring(previous.owner),tostring(previous.slot),previous.duration,previous.expiry,\n            course,p.x,p.y,p.z))\n    end\nend\nstate.statuses=current\nself.used=true",
						conditions = 
						{
							
							{
								"b336ec10-330c-e7b2-be80-976551397df4",
								true,
							},
						},
						name = "Capture Status Expiry and Removal",
						uuid = "439f854b-dece-28d3-8fbb-3d8cd203b5c3",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "b336ec10-330c-e7b2-be80-976551397df4",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			name = "Timing Capture - Player Status Removal",
			throttleTime = 100,
			timeout = 1,
			uuid = "018d31ff-adc4-7c4a-ab68-e9886f9a1bd6",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnTransformChange\",{entityContentID=eventArgs.entityContentID,entityID=eventArgs.entityID,newTransformFlags=eventArgs.newTransformFlags,newTransformID=eventArgs.newTransformID,oldTransformFlags=eventArgs.oldTransformFlags,oldTransformID=eventArgs.oldTransformID},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "12eb3dd8-5bbe-caab-8f37-ebef65533c16",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 24,
			name = "Capture v3 - OnTransformChange",
			timeout = 1,
			uuid = "def8e85f-bedb-0fe7-a2d1-588877d26720",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnAuraChange\",{entityContentID=eventArgs.entityContentID,entityID=eventArgs.entityID,newActiveAura1=eventArgs.newActiveAura1,newActiveAura2=eventArgs.newActiveAura2,newPersistentAura=eventArgs.newPersistentAura,oldActiveAura1=eventArgs.oldActiveAura1,oldActiveAura2=eventArgs.oldActiveAura2,oldPersistentAura=eventArgs.oldPersistentAura},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "59eac624-f5b5-261f-8b5d-e0582e22e38d",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 25,
			name = "Capture v3 - OnAuraChange",
			timeout = 1,
			uuid = "7bc0625d-32ed-db97-a5a0-cdc21c8437e1",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnAddEntityVFX\",{a5=eventArgs.a5,a6=eventArgs.a6,primaryEntityContentID=eventArgs.primaryEntityContentID,primaryEntityID=eventArgs.primaryEntityID,secondaryEntityContentID=eventArgs.secondaryEntityContentID,secondaryEntityID=eventArgs.secondaryEntityID,time=eventArgs.time,vfxID=eventArgs.vfxID,vfxName=eventArgs.vfxName},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "4a86e302-cfa7-1302-b7d5-126d7e7fb877",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 27,
			name = "Capture v3 - OnAddEntityVFX",
			timeout = 1,
			uuid = "5f96838e-468a-3908-a60c-fb8f8b36789b",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnAddGroundVFX\",{a9=eventArgs.a9,ownerEntContentID=eventArgs.ownerEntContentID,ownerEntID=eventArgs.ownerEntID,scale=eventArgs.scale,time=eventArgs.time,vfxID=eventArgs.vfxID,vfxName=eventArgs.vfxName,x=eventArgs.x,y=eventArgs.y,z=eventArgs.z},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "808ebd94-1fcb-1af6-a9f8-56726420805f",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 28,
			name = "Capture v3 - OnAddGroundVFX",
			timeout = 1,
			uuid = "6b258822-d2c0-ba72-b001-d34f52b1683c",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnAddGroundEffect\",{a1=eventArgs.a1,a2=eventArgs.a2,a3=eventArgs.a3,a4=eventArgs.a4,a5=eventArgs.a5,entityContentID=eventArgs.entityContentID,entityID=eventArgs.entityID,flags=eventArgs.flags,flags2=eventArgs.flags2,heading=eventArgs.heading,keyID=eventArgs.keyID,ownerContentID=eventArgs.ownerContentID,ownerID=eventArgs.ownerID,radius=eventArgs.radius,state=eventArgs.state,type=eventArgs.type,type2=eventArgs.type2,type3=eventArgs.type3,x=eventArgs.x,y=eventArgs.y,z=eventArgs.z},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "9b20dc0b-30c1-8128-b3dd-fd7c2e93af96",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 29,
			name = "Capture v3 - OnAddGroundEffect",
			timeout = 1,
			uuid = "bd791b30-8f68-40fc-8606-e2f8251e896e",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnEventObjectScript\",{a2=eventArgs.a2,a3=eventArgs.a3,a4=eventArgs.a4,entityContentID=eventArgs.entityContentID,entityID=eventArgs.entityID},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "cb7dc5d3-3b86-2e24-810e-b2cef4f82aa7",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 19,
			name = "Capture v3 - OnEventObjectScript",
			timeout = 1,
			uuid = "01275f6d-51e1-c8f4-bde8-7fbfefa8f0f6",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnEventObjectScript2\",{a2=eventArgs.a2,a3=eventArgs.a3,entityContentID=eventArgs.entityContentID,entityID=eventArgs.entityID},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "40058cf3-8653-cc1a-89ec-7b2ae5669b38",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 20,
			name = "Capture v3 - OnEventObjectScript2",
			timeout = 1,
			uuid = "616e913b-8a84-bc57-83b6-7ac5d18ee489",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture and BlundervilleNav and BlundervilleNav.recording then\n BlundervilleCapture.Event(\"OnFloorChange\",{a1=eventArgs.a1,a2=eventArgs.a2,a3=eventArgs.a3},Now())\nend\nself.used=true",
						name = "Record documented event",
						uuid = "fafe8c4c-968f-ea17-b6d2-7fe22aebd68a",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			eventType = 21,
			name = "Capture v3 - OnFloorChange",
			timeout = 1,
			uuid = "899fb8ae-8031-abe1-a9b9-9d0d7b75dcc1",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if BlundervilleCapture then BlundervilleCapture.Ready() end\nself.used=true",
						name = "Capture readiness",
						uuid = "d4245f06-4907-a509-bd56-b21adaacdebe",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection/Timing Capture",
			name = "Capture v3 - Hook readiness",
			throttleTime = 500,
			timeout = 1,
			uuid = "07545295-f989-8a4b-bcf7-6e4dfb873bfb",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Hide only the native floor omens for covered Blunderville hazards.\nlocal ids={34717,34800,34801,34805,34812,34797,34798,35409}\nfor _,id in ipairs(ids) do\n    Argus.setActionAOEType(id,0,0)\n    Argus.setActionAOEType(id,1,0)\nend\nself.used=true",
						conditions = 
						{
							
							{
								"a9d5448f-be77-d23d-a277-cd8adabb62d3",
								true,
							},
						},
						name = "Hide Covered Native Omens",
						uuid = "25fd4cc4-f468-c3f1-bb42-b28f835ee9cc",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "a9d5448f-be77-d23d-a277-cd8adabb62d3",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			eventType = 11,
			name = "Hide Covered Game Telegraphs",
			timeout = 1,
			uuid = "e9149fa5-4c14-8ef4-b6b7-925f63c45faf",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local player=TensorCore.mGetPlayer()\nif not player then self.used=true return end\nlocal p=player.pos\nlocal course=\"lobby-or-transition\"\nlocal round=0\n-- Positive course bounds from captured obstacle positions. No inference from\n-- absence of an end zone, and no unverified crown model.\nif p.x>120 and p.x<280 and p.z>-210 and p.z<0 then\n    course=\"second-typhon\" round=2\nelseif p.x>-280 and p.x<-120 and p.z>100 and p.z<350 then\n    course=\"second-eggs\" round=2\nelseif math.abs(p.x)<80 and p.z>100 and p.z<360 then\n    course=\"final\" round=3\nelseif p.x>-280 and p.x<80 and p.z<-100 and p.z>-430 then\n    course=\"opening\" round=1\nend\nlocal now=Now()\nlocal state=data.blunderStage\nif not state or state.course~=course then\n    state={course=course,round=round,entered=now,snapshot=false,lateSnapshot=false}\n    data.blunderStage=state\n    TensorCore.timelineLogToFile(string.format(\n        \"[BlunderStage] course observed_ms=%.3f round=%d course=%s player_xyz=%.3f,%.3f,%.3f\\n\",\n        now,round,course,p.x,p.y,p.z))\nend\n-- Inventory at course entry, after loading, and once near the finish. Routine updates\n-- check the player position; they do not repeatedly enumerate entities.\nlocal nearFinish=(course==\"final\" and p.z<160) or (course==\"opening\" and p.z<-330)\nlocal finishSnapshot=nearFinish and not state.finishSnapshot\nlocal snapshot=round>0 and (not state.snapshot or\n    (not state.lateSnapshot and now-state.entered>=5000) or finishSnapshot)\nif snapshot then\n    if finishSnapshot then state.finishSnapshot=true end\n    if state.snapshot then state.lateSnapshot=true else state.snapshot=true end\n    local count=0\n    for id,entity in pairs(TensorCore.entityList(\"\")) do\n        local e=entity.pos\n        local dx,dz=e.x-p.x,e.z-p.z\n        if entity.contentid~=0 and dx*dx+dz*dz<150*150 then\n            count=count+1\n            if count>100 then break end\n            local model=Argus.getEntityModel(id)\n            TensorCore.timelineLogToFile(string.format(\n                \"[BlunderStage] object observed_ms=%.3f course=%s entity=%s content=%s model=%s xyz=%.3f,%.3f,%.3f name=%s\\n\",\n                now,course,tostring(id),tostring(entity.contentid),tostring(model),e.x,e.y,e.z,entity.name))\n            if entity.contentid==108 and model==16352 and round==2 then\n                data.blunderStageMarkers=data.blunderStageMarkers or {}\n                data.blunderStageMarkers[course]={entity=id,x=e.x,z=e.z,model=model,observed=now}\n                state.typhonConfirmed=true\n            end\n        end\n    end\nend\nself.used=true",
						conditions = 
						{
							
							{
								"d1d38b73-1e58-2914-b863-07f3ac453ab0",
								true,
							},
						},
						name = "Identify Course and Capture Landmarks",
						uuid = "4c128edf-99c6-9a9f-b857-2ff41ebdbafc",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "d1d38b73-1e58-2914-b863-07f3ac453ab0",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Stage - Detect Active Course",
			throttleTime = 500,
			timeout = 1,
			uuid = "2ca32521-5fac-e9f1-a1d7-0f9585b1e70d",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Only suppress the known Blunderville attacks replaced by this profile.\nlocal covered={29795,34716,34717,34718,34773,34774,34775,34776,34796,34797,34798,34799,34800,34801,34802,34804,34805,34808,34812,35409}\nlocal blacklist=MoogleTelegraphs.Settings.aoeIDUserBlacklist\nfor _,id in ipairs(covered) do\n    if blacklist[id]==nil then\n        blacklist[id]={label=\"Blunderville obstacle \"..tostring(id),source=\"Blunderville profile\"}\n    end\nend\nself.used=true",
						conditions = 
						{
							
							{
								"23ed88de-52b1-c63e-bb9f-515fbe1d0716",
								true,
							},
							
							{
								"1bc4c800-331e-b431-b544-e05d49a9e35e",
								true,
							},
						},
						name = "Apply Covered Obstacle Blacklist",
						uuid = "ae282c44-d5d8-4f17-9a1d-3db02a4eebfd",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "23ed88de-52b1-c63e-bb9f-515fbe1d0716",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "return MoogleTelegraphs ~= nil",
						dequeueIfLuaFalse = true,
						name = "Moogle Available",
						uuid = "1bc4c800-331e-b431-b544-e05d49a9e35e",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Hide Duplicate Moogle Telegraphs",
			throttleTime = 1000,
			timeout = 1,
			uuid = "aae423d2-cd16-6aa8-90b6-19a7cfe292fd",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "-- Initial placements while the verified round-start Bind is present.\n-- The status has no countdown duration; do not fabricate a snapshot timer.\nlocal player=TensorCore.mGetPlayer()\nif not player or not TensorCore.hasBuff(player,3782) then self.used=true return end\nlocal course=data.blunderStage and data.blunderStage.course\nif course~=\"opening\" and course~=\"final\" then self.used=true return end\nlocal recipes={[\"opening:120:-1303\"]={spell=34716,model=16338,x=12.0,y=12.6671,z=-130.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:120:-1473\"]={spell=34716,model=16338,x=12.0,y=17.0547,z=-147.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:60:-1388\"]={spell=34716,model=16338,x=6.0,y=14.8186,z=-138.8,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-120:-1303\"]={spell=34716,model=16338,x=-12.0,y=12.5409,z=-130.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-60:-1388\"]={spell=34716,model=16338,x=-6.0,y=14.7771,z=-138.8,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-120:-1473\"]={spell=34716,model=16338,x=-12.0,y=17.0961,z=-147.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:30:-2199\"]={spell=34716,model=16338,x=3.0,y=16.8109,z=-219.9,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:90:-2253\"]={spell=34716,model=16338,x=9.0,y=15.4637,z=-225.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-90:-2253\"]={spell=34716,model=16338,x=-9.0,y=15.4637,z=-225.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:90:-2390\"]={spell=34716,model=16338,x=9.0,y=12.0207,z=-239.05,h=-1.57087,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-30:-2320\"]={spell=34716,model=16338,x=-3.0,y=13.7922,z=-232.0,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:-90:-2390\"]={spell=34716,model=16338,x=-9.0,y=12.015,z=-239.05,h=1.57077,kind=12,length=3.0,width=2.0,offset=688,centered=true},\n[\"opening:60:-2810\"]={spell=34718,model=16338,x=6.0,y=11.1998,z=-281.0,h=-1.57087,kind=12,length=4.0,width=10.0,offset=813,centered=false},\n[\"opening:-60:-2610\"]={spell=34718,model=16338,x=-6.0,y=11.3589,z=-261.0001,h=1.57077,kind=12,length=4.0,width=10.0,offset=813,centered=false},\n[\"opening:90:-1303\"]={spell=34716,model=16338,x=8.998999999999995,y=12.2059,z=-130.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:90:-1388\"]={spell=34716,model=16338,x=9.0,y=14.4835,z=-138.8,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:90:-1473\"]={spell=34716,model=16338,x=9.0,y=16.761,z=-147.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:-90:-1303\"]={spell=34716,model=16338,x=-9.0,y=12.2058,z=-130.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:-90:-1388\"]={spell=34716,model=16338,x=-9.0,y=12.9191,z=-138.8,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:-90:-1473\"]={spell=34716,model=16338,x=-9.0,y=16.761,z=-147.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:0:-2199\"]={spell=34716,model=16338,x=0.0,y=16.8109,z=-219.9,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:60:-2253\"]={spell=34716,model=16338,x=6.0,y=15.2142,z=-225.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:0:-2320\"]={spell=34716,model=16338,x=0.0,y=13.5427,z=-232.0,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:-60:-2253\"]={spell=34716,model=16338,x=-6.0,y=15.4637,z=-225.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:60:-2390\"]={spell=34716,model=16338,x=6.0,y=12.0207,z=-239.05,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:-60:-2390\"]={spell=34716,model=16338,x=-6.0,y=11.7713,z=-239.05,h=1.57077,kind=12,length=3.0,width=2.0,offset=1063,centered=true},\n[\"opening:40:-1880\"]={spell=34717,model=16339,x=4.0,y=17.4845,z=-188.0,h=1.57077,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:40:-1980\"]={spell=34717,model=16339,x=4.0,y=17.4845,z=-198.0,h=1.57077,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-40:-1880\"]={spell=34717,model=16339,x=-4.0,y=17.4845,z=-188.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-40:-1980\"]={spell=34717,model=16339,x=-4.0,y=17.4845,z=-198.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-20:-1660\"]={spell=34717,model=16339,x=-2.0,y=17.4845,z=-166.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:130:-1660\"]={spell=34717,model=16339,x=13.0,y=17.4845,z=-166.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:130:-1740\"]={spell=34717,model=16339,x=13.0,y=17.4845,z=-174.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-20:-1740\"]={spell=34717,model=16339,x=-2.0,y=17.4845,z=-174.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-90:-1660\"]={spell=34717,model=16339,x=-9.0,y=17.4845,z=-166.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:-90:-1740\"]={spell=34717,model=16339,x=-9.0,y=17.4845,z=-174.0,h=-1.57087,kind=2,length=3.0,width=0.0,offset=1063,centered=false},\n[\"opening:60:-1303\"]={spell=34716,model=16338,x=6.0,y=12.6671,z=-130.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:120:-1388\"]={spell=34716,model=16338,x=12.0,y=14.7771,z=-138.8,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:60:-1473\"]={spell=34716,model=16338,x=6.0,y=17.0962,z=-147.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-60:-1303\"]={spell=34716,model=16338,x=-6.0,y=12.4995,z=-130.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-120:-1388\"]={spell=34716,model=16338,x=-12.0,y=14.8186,z=-138.8,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-60:-1473\"]={spell=34716,model=16338,x=-6.0,y=17.0547,z=-147.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:20:-2810\"]={spell=34718,model=16338,x=2.0,y=10.071,z=-281.0,h=-1.57087,kind=12,length=4.0,width=10.0,offset=1375,centered=false},\n[\"opening:-20:-2610\"]={spell=34718,model=16338,x=-2.0,y=10.0626,z=-261.0,h=1.57077,kind=12,length=4.0,width=10.0,offset=1375,centered=false},\n[\"opening:-30:-2199\"]={spell=34716,model=16338,x=-3.0,y=16.8109,z=-219.9,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:30:-2253\"]={spell=34716,model=16338,x=3.0,y=15.4637,z=-225.3,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-30:-2253\"]={spell=34716,model=16338,x=-3.0,y=15.4637,z=-225.3,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:30:-2320\"]={spell=34716,model=16338,x=3.0,y=13.7921,z=-232.0,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-30:-2390\"]={spell=34716,model=16338,x=-3.0,y=12.0208,z=-239.05,h=1.57077,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:30:-2390\"]={spell=34716,model=16338,x=3.0,y=12.0207,z=-239.05,h=-1.57087,kind=12,length=3.0,width=2.0,offset=1375,centered=true},\n[\"opening:-20:-2810\"]={spell=34718,model=16338,x=-2.0,y=10.0626,z=-281.0,h=-1.57087,kind=12,length=4.0,width=10.0,offset=1813,centered=false},\n[\"opening:20:-2610\"]={spell=34718,model=16338,x=2.0,y=10.071,z=-261.0,h=1.57077,kind=12,length=4.0,width=10.0,offset=1813,centered=false},\n[\"opening:-60:-2810\"]={spell=34718,model=16338,x=-6.0,y=11.1998,z=-281.0,h=-1.57087,kind=12,length=4.0,width=10.0,offset=2188,centered=false},\n[\"opening:60:-2610\"]={spell=34718,model=16338,x=6.0,y=11.3589,z=-261.0,h=1.57077,kind=12,length=4.0,width=10.0,offset=2188,centered=false},\n[\"final:-120:2430\"]={spell=34801,model=16338,x=-12.0,y=9.3873,z=251.0,h=-5e-05,kind=2,length=6.0,width=0.0,offset=63,centered=false},\n[\"final:-120:1457\"]={spell=34801,model=16338,x=12.0,y=33.469,z=145.7,h=-5e-05,kind=2,length=6.0,width=0.0,offset=63,centered=false},\n[\"final:-120:1987\"]={spell=34801,model=16338,x=4.0,y=22.5211,z=198.7,h=-5e-05,kind=2,length=6.0,width=0.0,offset=63,centered=false},\n[\"final:-120:2213\"]={spell=34801,model=16338,x=4.0,y=14.541,z=229.3,h=-5e-05,kind=2,length=6.0,width=0.0,offset=63,centered=false},\n[\"final:100:2253\"]={spell=34802,model=16338,x=10.0,y=14.7558,z=225.3,h=-5e-05,kind=2,length=5.0,width=0.0,offset=63,centered=false},\n[\"final:100:2675\"]={spell=34802,model=16338,x=10.0,y=6.0,z=267.5,h=-5e-05,kind=2,length=5.0,width=0.0,offset=63,centered=false},\n[\"final:32:1351\"]={spell=29795,model=16338,x=3.218,y=36.3023,z=135.092,h=1.09955,kind=2,length=3.0,width=0.0,offset=500,centered=false},\n[\"final:20:1560\"]={spell=34796,model=16338,x=2.0,y=31.3896,z=156.0,h=-5e-05,kind=2,length=5.0,width=0.0,offset=500,centered=false},\n[\"final:43:1757\"]={spell=34796,model=16338,x=4.3431,y=29.3701,z=175.6569,h=2.35618,kind=2,length=5.0,width=0.0,offset=500,centered=false},\n[\"final:-100:1560\"]={spell=34796,model=16338,x=-10.0,y=31.3895,z=156.0,h=0.78536,kind=2,length=5.0,width=0.0,offset=500,centered=false},\n[\"final:-68:1369\"]={spell=29795,model=16338,x=-6.782,y=36.106,z=136.908,h=2.042,kind=2,length=3.0,width=0.0,offset=500,centered=false},\n[\"final:-100:1700\"]={spell=34796,model=16338,x=-10.0,y=29.9515,z=170.0,h=-5e-05,kind=2,length=5.0,width=0.0,offset=500,centered=false},\n[\"final:-100:2253\"]={spell=34802,model=16338,x=-10.0,y=14.7558,z=225.3,h=-5e-05,kind=2,length=5.0,width=0.0,offset=1313,centered=false},\n[\"final:-100:2675\"]={spell=34802,model=16338,x=-10.0,y=6.0,z=267.5,h=-5e-05,kind=2,length=5.0,width=0.0,offset=1500,centered=false},\n[\"final:0:2253\"]={spell=34802,model=16338,x=0.0,y=14.7558,z=225.3,h=-5e-05,kind=2,length=5.0,width=0.0,offset=2313,centered=false}}\nlocal now=Now()\ndata.blunderInitialWarnings=data.blunderInitialWarnings or {course=course,draws={},scans=0}\nlocal state=data.blunderInitialWarnings\nif state.course~=course then self.used=true return end\nif state.scans>=2 then self.used=true return end\nstate.scans=state.scans+1\nlocal base=TensorCore.getMoogleDrawer()\nlocal caution=GUI:ColorConvertFloat4ToU32(1,0.75,0.1,0.30)\nlocal drawer=TensorCore.getCachedDrawer(caution,caution,caution,base.colorOutline,\n    base.outlineThickness,base.occlusionChannel,base.renderFlags)\nfor id,entity in pairs(TensorCore.entityList(\"\")) do\n    if entity.contentid==108 and not state.draws[id] then\n        local p=entity.pos\n        local centre=p.x < -100 and -200 or 0\n        local key=course..\":\"..tostring(math.floor((p.x-centre)*10+0.5))\n            ..\":\"..tostring(math.floor(p.z*10+0.5))\n        local recipe=recipes[key]\n        local dx,dz=p.x-player.pos.x,p.z-player.pos.z\n        if recipe and dx*dx+dz*dz<120*120 and Argus.getEntityModel(id)==recipe.model then\n            local uuid\n            if recipe.kind==2 then\n                uuid=drawer:addTimedCircle(60000,recipe.x+centre,recipe.y,recipe.z,\n                    recipe.length,0,false,true)\n            elseif recipe.centered then\n                uuid=drawer:addTimedCenteredRect(60000,recipe.x+centre,recipe.y,recipe.z,\n                    recipe.length,recipe.width,recipe.h,0,false,true)\n            elseif recipe.kind==12 then\n                uuid=drawer:addTimedRect(60000,recipe.x+centre,recipe.y,recipe.z,\n                    recipe.length,recipe.width,recipe.h,0,false,true)\n            end\n            if uuid then\n                state.draws[id]={uuid=uuid,spell=recipe.spell}\n                TensorCore.timelineLogToFile(string.format(\n                    \"[BlunderStart] prepared observed_ms=%.3f course=%s entity=%s spell=%s\\n\",\n                    now,course,tostring(id),tostring(recipe.spell)))\n            end\n        end\n    end\nend\nself.used=true",
						conditions = 
						{
							
							{
								"c92faeeb-85e9-4f5c-923f-2aab6a880009",
								true,
							},
							
							{
								"96ede0ba-992b-9856-b2e5-4657e37487bc",
								true,
							},
						},
						name = "Show Initial Obstacle Footprints",
						uuid = "e5d59aa3-a0f8-1b42-b1ac-48077819d6ee",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "c92faeeb-85e9-4f5c-923f-2aab6a880009",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local player=TensorCore.mGetPlayer()\nreturn player~=nil and TensorCore.hasBuff(player,3782)",
						dequeueIfLuaFalse = true,
						name = "Round Start Bind",
						uuid = "96ede0ba-992b-9856-b2e5-4657e37487bc",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Opening and Final - Prepare First Warnings",
			throttleTime = 1000,
			timeout = 1,
			uuid = "a8220ab2-0ac9-7658-9147-fd2b3b6c9527",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if not data.blunderImageAssetsReady then self.used=true return end\nlocal records=data.blunderDrawCountdowns\nif not records then self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.localmapid~=1165 then data.blunderDrawCountdowns=nil self.used=true return end\nlocal now=Now()\nlocal drawer=data.blunderNumberDrawer\nif not drawer then\n    drawer=Argus2.ShapeDrawer:new(nil,nil,GUI:ColorConvertFloat4ToU32(1,1,1,1))\n    data.blunderNumberDrawer=drawer\nend\nfor uuid,record in pairs(records) do\n    if now>=record.finish then records[uuid]=nil\n    elseif now>=record.start then\n        local tenth=math.min(100,math.max(1,math.ceil((record.finish-now)/100)))\n        drawer:addScreenFacingTexture(record.x,record.y,record.z,0,\n            GetLuaModsPath()..\"TensorReactions/FrogBlunderCountdown\"..tenth..\".png\",\n            192,80,1.5,0.625)\n    end\nend\nself.used=true",
						name = "World - Shape-Synchronized Countdowns",
						uuid = "a83c6403-682a-291d-b0e4-621b839cd153",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection",
			eventType = 13,
			name = "World - Shape-Synchronized Countdowns",
			timeout = 1,
			uuid = "e68871ef-8bb3-aef4-8477-cd4a9b11aeb1",
			version = 2,
		},
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
								"b53a0650-f811-9a3a-a248-0d4567e46dbf",
								true,
							},
						},
						name = "Stop Moving Before Facing",
						stopMoving = true,
						uuid = "70532336-2a4e-5e1c-8ab1-5c3584d8b297",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "if data.blunderNorthLockVersion~=2 or data.blunderNorthLock~=true then self.used=true return end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.localmapid~=1165 then self.used=true return end\nlocal face\nlocal remaining\nfor _,buff in ipairs(TensorCore.getBuffs(player,false)) do\n    if buff.name==\"Left Face\" then face={x=1,z=0} remaining=buff.duration\n    elseif buff.name==\"Right Face\" then face={x=-1,z=0} remaining=buff.duration\n    elseif buff.name==\"About Face\" then face={x=0,z=1} remaining=buff.duration\n    elseif buff.name==\"Forced March\" then self.used=true return end\nend\n-- Do not redirect manual movement. Only face shortly before the status expires.\nif face and remaining and remaining>0 and remaining<=0.35 and not Player:IsMoving() then\n    local p=player.pos\n    Player:SetFacing(p.x+face.x,p.y,p.z+face.z)\nend\nself.used=true",
						conditions = 
						{
							
							{
								"b53a0650-f811-9a3a-a248-0d4567e46dbf",
								true,
							},
						},
						name = "Opening - Point March Arrow North",
						uuid = "bd34395b-0637-57f7-8c06-1b3be42d75e8",
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
						conditionLua = "if data.blunderNorthLockVersion~=2 or data.blunderNorthLock~=true then return false end\nlocal player=TensorCore.mGetPlayer()\nif not player or player.localmapid~=1165 then return false end\nlocal late=false\nfor _,buff in ipairs(TensorCore.getBuffs(player,false)) do\n    if buff.name==\"Forced March\" then return false end\n    if (buff.name==\"Left Face\" or buff.name==\"Right Face\" or buff.name==\"About Face\")\n        and buff.duration>0 and buff.duration<=0.5 then late=true end\nend\nreturn late",
						dequeueIfLuaFalse = true,
						name = "Final March Window",
						uuid = "b53a0650-f811-9a3a-a248-0d4567e46dbf",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Opening - Point March Arrow North",
			timeout = 1,
			uuid = "072db509-984b-4699-b43d-f4020a34dc14",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local player=TensorCore.mGetPlayer()\nif not player or player.localmapid~=1165 then self.used=true return end\nif data.blunderNorthLockVersion~=2 then\n    data.blunderNorthLock=false\n    data.blunderNorthLockVersion=2\nend\nGUI:SetNextWindowSize(360,0,GUI.SetCond_Always)\nlocal visible=GUI:Begin(\"Blunderville movement assist\",true,GUI.WindowFlags_AlwaysAutoResize)\nif visible then\n    data.blunderNorthLock=GUI:Checkbox(\"Point march arrow north\",data.blunderNorthLock)\n    GUI:TextWrapped(\"Off by default. Stops movement in the final 0.5 seconds, then faces in the final 0.35 seconds of Left Face, Right Face or About Face.\")\nend\nGUI:End()\nself.used=true",
						name = "Opening - March Arrow Toggle",
						uuid = "5c6a9174-ed21-a7bd-87e1-7086f0505090",
						version = 2.1,
					},
				},
			},
			conditions = 
			{
			},
			displayPath = "Shared - Stage Detection",
			eventType = 13,
			name = "Opening - March Arrow Toggle",
			timeout = 1,
			uuid = "67db77e0-d608-9e49-a7b9-4e1b8a4e75d7",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local nav=BlundervilleNav\nif not nav or not nav.SetReactionState then self.used=true return end\nlocal now=Now()\nlocal active,windows={},{}\ndata.blunderNavigationSpinnerDurations=data.blunderNavigationSpinnerDurations or {}\nlocal durations=data.blunderNavigationSpinnerDurations\nfor id,spin in pairs(data.blunderActiveSpinners or {}) do\n    local span=spin.untilTime-spin.burstAt\n    if span>0 then durations[id]=math.max(durations[id] or 0,span) end\n    if now<spin.untilTime then\n        active[#active+1]={kind=\"circle\",x=spin.x,y=spin.y,z=spin.z,\n            radius=spin.radius,start=now-100,finish=spin.untilTime,\n            collisionWindow=true,timingSource=\"observed spinner hit tail\"}\n    end\n    -- The countdown ends at the next predicted burst START. It is not the\n    -- occupancy interval. Retain the collision burst after the warning ends.\n    for uuid,warning in pairs(data.blunderDrawCountdowns or {}) do\n        if warning.finish>=now and math.abs(warning.x-spin.x)<0.25\n            and math.abs(warning.z-spin.z)<0.25 then\n            windows[uuid]={kind=\"circle\",start=warning.finish-100,\n                finish=warning.finish+(durations[id] or span),\n                source=\"predicted spinner burst with observed duration\"}\n        end\n    end\nend\n-- Swinging orb impacts have their own completed-hit events and forecast UUID.\n-- A 100ms early/200ms late tolerance surrounds the estimated impact, rather\n-- than blocking the full multi-second visual countdown.\nfor key,state in pairs(data.blunderOpeningCapturedPhaseV4 or {}) do\n    if key:match(\"^34775:\") then\n        local warning=state.orbPreview and data.blunderDrawCountdowns\n            and data.blunderDrawCountdowns[state.orbPreview]\n        if warning then windows[state.orbPreview]={kind=\"centeredrect\",\n            start=warning.finish-100,finish=warning.finish+200,\n            source=\"predicted orb impact with timing tolerance\"} end\n        local history=state.history\n        local hit=history and history[#history]\n        if hit and hit.t+200>now then\n            active[#active+1]={kind=\"centeredrect\",x=hit.x,y=hit.y,z=hit.z,\n                length=hit.length,width=hit.width,heading=hit.h,start=hit.t,\n                finish=hit.t+200,collisionWindow=true,timingSource=\"observed orb impact\"}\n        end\n    end\nend\nnav.SetReactionState({updated=now,course=data.blunderStage and data.blunderStage.course,\n    active=active,windows=windows})\nself.used=true\n",
						conditions = 
						{
							
							{
								"5ba75b49-38ee-001c-8efb-178b4b05b634",
								true,
							},
						},
						name = "Publish Active Hazards",
						uuid = "cdcf5fc0-08df-5b28-8c5b-a3bfce72f386",
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
						localmapid = 1165,
						name = "Blunderville",
						uuid = "5ba75b49-38ee-001c-8efb-178b4b05b634",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Navigation - Opening Hazard Feed",
			throttleTime = 100,
			timeout = 1,
			uuid = "73182cb6-1667-645f-bdf2-84eb8ebde55d",
			version = 2,
		},
	},
	
	{
		data = 
		{
			actions = 
			{
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local alphabet=\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/\"\nlocal values={}\nfor i=1,#alphabet do values[alphabet:sub(i,i)]=i-1 end\nlocal function decode(encoded)\n local out={}\n for i=1,#encoded,4 do\n  local a=values[encoded:sub(i,i)]\n  local b=values[encoded:sub(i+1,i+1)]\n  local c=values[encoded:sub(i+2,i+2)]\n  local d=values[encoded:sub(i+3,i+3)]\n  local n=a*262144+b*4096+(c or 0)*64+(d or 0)\n  out[#out+1]=string.char(math.floor(n/65536)%256)\n  if c then out[#out+1]=string.char(math.floor(n/256)%256) end\n  if d then out[#out+1]=string.char(n%256) end\n end\n return table.concat(out)\nend\nlocal assets={\n {\"FrogBlunderSpinning.png\",\"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\"},\n {\"FrogBlunderCountdown1.png\",\"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\"},\n {\"FrogBlunderCountdown2.png\",\"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\"},\n {\"FrogBlunderCountdown3.png\",\"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\"},\n {\"FrogBlunderCountdown4.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAG4UlEQVR4nO3dbUhTXQAH8Lu5zenmWm4LwxcIkqLwKZ8IKixMMCQiikHSh4oI9YP4RRGDQA36EkZf6oNlUYEEUVQEBVKEldRjYZJYX4qKJtHjy6Z7MTc393B6yO7Ozr3uzs2Xnf8PRDzbPbtcz//cc+89904QAACATyolbw4PlISTtyoAiaP6qyemth3Tm9DwIVWDIPsiGj6kehBUShq/Ydvbb4leMYBk8P3zd0EsIVDF0vjR8CFVgkCHQE0vgMYPqYTuvOn2rVayMMByJNeO1VLpQOOHVCJuz+J2LrsHAEh1swFA7w887gWwBwCuIQDANQQAuIYAANcQAOAaAgBcQwCAawgAcA0BAK4hAMA1BAC4hgAA1xAA4BoCEKN169Zpm5ubVzx//jzn8+fPuS6XK//Lly+5PT09OadPnzZv2LBBKyyylpYWs8/nKxD/3Lhxw7rY67WUaRZ7BZY6vV6vOnPmjLm6ujorLS0t4rVVq1alkZ/i4mJdfX296cqVK95Tp065JicnF/z5SVu3btU1NDSYFvpzlzsEQEZGRobq9u3btt27d+vn2pBqtVqorq42rl+/XmO320cWMgRkPTs6Oqx0QGFuGALJuHDhQnYsjV9s165d+vb2douwgMgeqrCwEJ1ZHBAACTt37kw/fPiwIZ6NarfbM8vLyxUFJ16lpaX6mpqarIX4rFSEAEhobGxcwSrv6+sLlJWV/Wuz2RwlJSU/Xrx44We9r6mpibl8IplMJvWlS5csKpWiR7yCCALAkJubm1ZWVhbVg4+Njc0cPHhwuLe310/G+P39/QG73T78/fv3EP3e7du3p69duzapw5Lz58+vzMvLw8B/HhAAhoqKigxWr9rZ2eklIRCX+Xy+cEdHh4dVz969ezOEJNm/f39mvEM0+AMBYNixY0c6q7yrq2tKSTnZCwhJYLPZ0sgBejLq5g0CwLBp0yYdq/zDhw/TUuUzMzMx1zNfFy9ezLZarRH/u4cPH/50Op3RKwGyEAAKGfqsWbMmauzu9/vDIyMjUWN9Ynp6Ojw8PBz1Wn5+vkar1Sb0CPXIkSOGffv2RQytRkdHZ2pra52J/BxeIACU7OxsNbn6S5e7XC7Z3nV8fHyGdXFs9erVCTtIJYFqa2tbSZfX1dU5pcIJ8hAAisViYTZYj8cjGwCPxxOWCpSQoD3T5cuXs7OysiLqu3nzpu/BgweTifgMHiEAFKPRyByy+P3M0/2zAoFAWEl9StXW1maRq8zisqGhoVBDQ4MrEfXzCgGgSI3Zg8Gg7NyeUCjEfD0RxwCFhYXa1tZWs7gsHA4LNTU1Y263Gwe+84AAJNl8r9JqNBrh6tWrFjLhTVze3t7u6e7uZp5+hdghAIwzOqwNNddMS41Go1JSn5IpGVu2bIk4nfrx48dgc3Pz+Hzqhf8hABRyZVdg0Ol0sl251OtSB8ex2Lx5s66pqSlijn8oFBKqqqpGF+Oeg1SEAMR4utNoNMpuK5PJxAxAvBenyKlYMvShjyHOnTs38ebNm0A8dUK02Y2LL8j4c+7e6XTm0w2P9LhkBqgg4evXr7lkigLdW1ssFkc8wyByh1d3d3eOkGDkgtn169e9Aqd8om+NJN8YiT0AhUxpcDgcUReVMjMzVWazmbm90tPTVVarNeogweFwBOM9BlBhjvOCQAAYBgcHmUOMoqIi5o3vGzdu1LLa68DAAIYqSxwCwNDb28tsuHv27GFOby4vL2eWv3r1Sv7qGSw6BIDh8ePHP1nlR48eNZK7sOiD4+PHjzPn5T969IhZDywduJGa4f3799Pv3r0L0NOZyRTku3fv2k6ePOki7yHPCjp79uxKMkmN1ft/+vQpyKrf7XYX0NcVyJmd0tLSH7//fv36td9gMCj6onKHw5FHzz26c+fO5LFjx0aV1MMTBEBCW1ubu7Oz08q6yeXZs2c5sSyfiH8QJBeGQBLu3bs3ef/+/bhmWZLZmV1dXRj+LAMIgIwTJ06MPXnyRNF8m5cvX/qrqqpwc8oygQDImJqaCh86dGiEDGekpjuLrx9cu3bNe+DAgWGv14sZmssEjgHmQG6FbG1tHSdXTysrKw0VFRX6goICjcViUU9MTISHhoaCT58+nbp165ZvcHCQec8wLF2YCgFcwVQIABEcAwDXEADgGgIAXEMAgGsIAHANAQCuIQDANQQAuIYAANcQAOAaAgBcQwCAawgAcE0tfkoWa8ooQKpOhSa/sQcArkUEAHsB4Kn3n3MPgKEQpAK5dhwVAHE65loYYKmj2y/dviW/9EH8uPTfDNveKnpSGcBiYXXcdOP/VSZXCSsEAMsRq/H/Ko9lYQQBUq3hz76upDIEAVKl4QMIIAj/Ac5XeBWOYlV9AAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown5.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAIQElEQVR4nO2dW0hUXRvH95w8Na/Z6KidJiulQnuzly6+ytJEa6ibYgalLpKKJuiqgg7gVRQIBUFEERXUhRHZyQoCKcVMyoi+rOxEdZP15VnTGfMw47w8vdg3s2ft7R7dw/e51/8Hg7r27NVuz/Nf63nW86w9ggAAAIBPdOG82f8qxx+5SwFAPXR/1iuybUVvguEDrQpB9iAMH2hdCLpwjH/Kv/79Re0LAyASeBr+sikRgU6J8cPwgVaEIBaBXnwCjB9oCfHgLbZvfTgnAzAZkbNjvZQ6YPxASwTac6Cdy84AAGid3wLA6A94nAUwAwCugQAA10AAgGsgAMA1EADgGggAcA0EALgGAgBcAwEAroEAANdAAIBrIADANRAA4Brj//oCJgsLFiwwFRcXxxUUFMTOmjXLMG3aNH1PT8/It2/ffNXV1QNXr171vH37djiS13DixIlpu3bt+mM85z569GjQbre3qn9VkxsIYAxiYmJ0R48eTXC5XH8YDIagY8nJyQZ6LV26NGrfvn3xFy5ccJeWlnb39/dH5PlJWVlZUZHol2cgABliY2N1165ds65ZsyZmrBup1+sFl8tlXrhwodHhcLRHQgRZWVkmtfvkHcQAMpw6dcqixPgDWb16dczZs2cTBZWZPXu2cerUqfi8VAY3VIJVq1ZFb968ecp4bqrD4YgrLCwMSzhjgdE/MkAAEuzfv38qq/358+dD+fn5rVartTknJ6eFgkvW+w4ePMg8f7xAAJEBMQCDmTNnGvLz80NG8M7OzpFNmza10U/6+8WLF0MOh6OtsbFxxowZM4Ii5OXLl0enp6cbP3365I1UAEz/PolQjf55BTMAA7vdHqvThT40r7y83D1q/KN4PB7/+fPn+1j9rF+/PlatD2rx4sUhAfCbN28iuuzKAxAAgxUrVkSz2quqqgbCaadZQFBpKTY9PT1EAE1NTUNq9M8zEACDJUuWMNfbpRJd1D4yMqK4n3BZtGiRSZyDIF6/fo0ZYIJAACLI9Zk7d25IbDQ4OOhvb2/3sW7i8PCwv62tzcdaujSZTGF9CUk4AbDJZBJOnjxpoRikq6trdmtr66zGxsbpZ86csRQUFKi6CqVVEASLsFgsenI5xO3d3d2hQ3wAVBaRmppqECfHpk+fbvjy5Ys3EhngysrK5MC/o6OjdRkZGfqMjAxTSUmJub6+fnD37t2dnz9/ViUQ1yKYAUQkJiaG+hqCIPT19ckKoK+vzy8lKCECAbAScnJyoh8+fJgqFdMACCAEs9nMdFkGB5nL/b8ZGhryh9NfOGRmZo47lqCivYqKCmtaWhpmewaYAURI+exer1e2tsfn8zGPTzQGILcqKSlpQp8TieDcuXOql2doAQggwrDyCWoEwJSPKC0t7cnOzv6PxWJpttlsX0tKSjo+fvzI9PdXrlwZnZeXh8BYBKZFxoqOwIC1DBl0I41GXTj9KYX2Gxw7dqw3LS3NMGfOHCOtUL1//354y5YtHYGBOa1SXb9+vZ9yEtXV1SmZmZkhwikqKoqrra1l5ix4BQIQQZld1o2KioqSHcqljksFx0p59+7d8OHDh3uUvp+C9UOHDnXfvXs3aIWIyM3NxQwgAi6QwuVOs9kse6/i4+OZAujq6pJdPYoEdXV1Az9//vSz8hITdcm0BgQgoqOjw8dyWyiQlLuRrOM+n0/4/v07M3kWSbxer9Da2upjuXHYUxAMXCARVNLQ3NzsmzdvXtC9iYuL0yUkJPzaByw+hxJQSUlJIUFCc3OzdyIxACXkaG8B+f42m41eBhrFP3z4MOx0OtvlzpVafRoYGIjIds3JCgTAgIrMxAIYTUix6v8p4GS5Fq9evZpQsRotvdKuNBJYYHtycrKeRnOaYViQWFNSUkIESeKFAIKBC8Tg6dOnTMNdu3Yts7y5sLCQ2f7kyRP57JkCV6apqWmYFY84nU7J3Wrr1q2LNRpDx7aGhoYJXY8WgQAY3L9//yerfevWreb4+Hi92Bi3bdvGNMZ79+4x+wmHO3fu9LPay8rKEqxWa8gon5iYqD9y5EiCRF8Tvh6tAQEwoI0mL1++DJkFKCN78+ZN67Jly6LoiRHZ2dlRN27csJJfzhr9pXaD9fb22jweT9CrtrY2lfXeK1eueFhlFuTi1NTUpGzYsCGWXB4Kbp1OZ1xdXV0qq5qVKlnp2UVyxsAjiAEkOH78eG95eXkSa5MLFZgpOV+ND4gSYadPn+7bu3dvvPgYxSlU56OknwMHDnTD/w8FM4AEt27d6q+srGS6H0rclqqqKtXcjbKysh+sGUkp9MCuioqKcf1ftA4EIMOOHTs6Hzx4EFbpwOPHjwd37tzZJaicnaaHbVFWONxzL1++7NmzZ4+q16MlIAAZyGUoKipqJ3dGqtw5MH9w8eJF98aNG9vcbrfq2V9KqOXm5rZcunTJLbX8GUhHR8fI9u3bO10uV6ffj6V/KXTir44Xf6U8+Aeqpy8uLp5it9tjKClFqy0/fvzwf/361VtTU/Pr4bisJUupIFhcXPfs2bOhvLw8RY84Id+fHtpFtT3z58830qYbKn1oaWnx0Sxx+/btflqBcrvdsHwRnoa/bKO/6/6s/2/2BgIAPAoALhDgGggAcA0EALgGAgBcAwEAroEAANdAAIBrIADANRAA4BoIAHANBAC4BgIAXAMBAK6BAADX6ANLQ1klowBotRSafmIGAFwTJADMAoCn0X/MGQCuENACcnYcIoBAdYx1MgD/74jtV2zfkg+LD9wjPAo2y4PJAmvgFhv/rza5TlgiAGAywjL+X+1KToYQgNYM//fxcDqDEIBWDB8AAQjC3/8fL5Bs7AI0AAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown6.png\",\"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\"},\n {\"FrogBlunderCountdown7.png\",\"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\"},\n {\"FrogBlunderCountdown8.png\",\"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\"},\n {\"FrogBlunderCountdown9.png\",\"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\"},\n {\"FrogBlunderCountdown10.png\",\"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\"},\n {\"FrogBlunderCountdown11.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAC9klEQVR4nO3czUpiYRzH8eMLI4yG00KXXkJBK4kWgTcQbVq6yqV5DQYuDVduvQI3gVfQIgiCXq6gNjPIDIyTDDQ6DhMUxzNq50SOz/P8vh+IyjL+5P97ngLL8wAAmmJRPnlyvTNZ3ijA+4ltnIXa7VCfxOLD1RAWfpDFh+shxKIsf7p4effegwHLMDzfKoSJIBZm+Vl8uBJCMIJ48A4sP1wSvHgH9zse5c6AjRbtcXxeHSw/XOLfZ/+eLzwBANe9BMDVH4qnACcApBEApBEApBEApBEApBEApBEApBEApBEApBEApBEApBEApBEApBHAGx0cHKSHw2HB/3J8fPxJfRbbEMBbvmnxuHd0dLTmGcCkWWxEAG9QqVTWNjc3P3gGMGkWGxFARMViMdVoNIz48cKkWWxFABFsb2+nut1uLpVKRfqXkq7PYjMCCKlcLmdOT0/z2Wx25d8zk2axXXLVA5gul8slms3m+v7+/kdmcQ8BzJHP5xOHh4eZarW6lslkVnqlNWkW1xDAHCcnJ+t7e3szr/qj0chLJpOSs7iGq0lEV1dXj5VK5atnAJNmsRUBhDQej71WqzUolUpf7u/vR8t9WOyZxXacnSH0er2f9Xr9+83NzePyHxJ7ZnEBAczR7/d/t9vtH51O5+H29vbX/31YzJ3FNQQwR61W++YZwqRZXMPvAJBGAJBGAJBGAJBGAJBGAJBGAJBGAJBGAJBGAJDGUyFWYDAYFBKJxNRtFxcXj7u7u59XMY8yTgBIIwBIIwBIIwBIIwBIe/mvYpPrncnz2+ni5d3KJgKWaHi+VXh+O7ZxFuMEgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgDQCgLS4/6mhs54yCrj6VOi/rzkBIG0qAE4BKF39Xz0B+FEILli0x/8E4K/jtTsDpgvub3C/p97x8/+N8DP+Vhi2mHXhDi7/022LvsisCAAbzVr+p9vD3JkQ4Nriv3w8yhcjBLiy+IAHz/sD+n0WOB9F9P8AAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown12.png\",\"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\"},\n {\"FrogBlunderCountdown13.png\",\"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\"},\n {\"FrogBlunderCountdown14.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAEk0lEQVR4nO3dTUhiaxgH8HP8SMuvcqxVthPaNMVEIDGE0DYiIogWYRt1IX2AhLuKijZFEQV9EdSmVbQoat1iiKFgoKldu2uLe9Hx3nGuzr1zNS8OFMdTmlrOe855/j9w4dEjj/r8z/v6clSOAwAAmvhi7pz+/D5dvlIAXg//9kNBvV3QndD4oNQg5L0RjQ9KDwJfTPMbnJ9+e+3CAMoh/vFdQyEh4AtpfjQ+KCUI4hCoxDug+UFJxAdvcX+ritkZQI7y9bEqVzrQ/KAkwn4W9nneEQBA6R4CgKM/UBwFMAIAaQgAkIYAAGkIAJCGAABpCACQhgAAaQgAkIYAAGkIAJCGAABpCACQhgAAaQhAifr7+w3xeLxBeJmZmanmGJqcnKwW17S7u2tjWZPUIQClvGgqFTc6OmriJKStra0iEAiYWdchNwhACbxer6m5ubmCk4jKykp+a2vLplarWZciOwhAkZxOp25ubo7pVEdsdna22uFwaFjXIUcIQBHa29t1BwcHtTqdrqiflCwnl8ul9/l8kpqOyQkCUCC32208Ojqqs1gsknnNzGazamNj4w3PSyaPsoNh8xm1tbXqxcXFmt7e3ipOYjJ11dfXY+L/AghADnV1dWqPx2McGRkxGY1GyRz173V3d1cNDAwYWNchdwhADktLSzU9PT1PHvWTySSn0WiYjkorKytWZgUoiOSObFJ3eXn5w+v1fmFZw+rqqtVms2W9d8fHx9+j0egdu6rkCQEoUCqV4paXl2OdnZ1/hEKhJMfI4OCgoaurq1K4LRKJ3Pn9/iirmuQMU6ACnJycfJ+env56dXX1g2PIbrdr5ufna8Tbh4eHo+FwOMWmKnlDAHIIh8N3a2tr33Z2dv6+vr7+j2Mss9S5ublpNZlMWaP23t5e/PDwMMGuMnlDAHIYGxuT1JTC7/ebOjo69MJtt7e3qUAg8Ce7quQPnwFkwOFwaKemprJOv0in05zP5/sSi8XwwfcFEACJyyy3bm9vv8mc8Cbcvr6+/u309PQfdpUpAwIgcePj45bW1tasM09vbm6SExMTf7GrSjkQAAlraWmpCAaDZvFyrMfjiSQSCfxn8ytAACRKr9fzmamPVqvNmvosLCx8vbi4YLocqyQIgEQ1NTVpGxsbteLtwWDQIv7a4/3FarU+ej/7+vqqhPcZGhoy/rInIQMIgETxOMf5l0AAgDQEAEhDAIA0nArBQCwWaxD/gkNmZcflcv1+f/38/Pxfg8FQ1B+Vh0KhevEH4f39/YTb7Y68vGplwggApCEAQBoCAKQhAEAaAgCkYRWoBGdnZ0Wv0AiZzeaS983HbrffluNxlQwjAJCGAABpCACQhgAAaQgAkIYAAGkIAJCGAABpCACQhgAAaQgAkIYAAGkIAJCGAABpDwHg3354+Am++Md3DcwqAigTYV/f9ztGACAtKwAYBYDS0f/ZEQBTIVCCfH38KADCdDy3M4DUiftX3N9ZV4TSn98/+gMGg/NTWb7LCvDanjpwi5v/57Z8D/JUCADk6Knm/7m9kJ0RBFBa4z/cXsyDIQiglMYH4IDj/gfQQGj71wkRTAAAAABJRU5ErkJggg==\"},\n {\"FrogBlunderCountdown15.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAF/UlEQVR4nO3cS0gbWxwG8DxvbLTXGjV6L9f4Xki0SjeKDSgodNFNqVHRjSDoQsHHRgRXKhgQVERUEBduRCoiPqDUhcWKC1etrRYVKZR6vRriq2p8JuZyCkqczGhiTTIz5/tBqJ3MJMf4/+acmTkTiQQAAOgk9WRlxxeDw3tNAXg40qdzbtW2Wyuh8EGsQbj1SRQ+iD0IUk+KPzDj44+HbhiAN1jnn+ncCYHUneJH4YNYgsAMgYy5AYofxIS582bWt8yTjQGE6LY6lnGlA8UPYuJcz851fmsPACB21wHA3h9o7AXQAwDVEACgGgIAVEMAgGoIAFANAQCqIQBANQQAqIYAANUQAKAaAgBUQwCAaggAUA0BuKfCwsJAq9Wqc340Nzc/kXhRe3t7CPM93X28e/cuwpttEyoE4D4fmkwmqa6ufizxseTk5D98/Z5ihwDcQ3l5+ePU1FSfF2NycrLS1+8pdgiAhzIyMlQtLS1eHeqwiYqKUgQHB+Pv9cDwgXogMzNTNTo6Gq5SqTz6SsmHgL2/dyAAbiopKQmanJzU+msvjAB4h8JLrysa4eHhcnL25fXr12p/toPtAPjTp0/nBoNhyz8tEgcEgINWq5WXlZUFVVVVPQ4KCvJ7T5mSkuJyAPz169cL/7RGPBAADh0dHSGvXr1i3evbbDaJQuG7jy4gIECakJDgEoClpaVznzVCpPy+ZxOaz58/n5eXl+/48j2TkpKUcrncZfni4iJ6gN+EALjJbrdLOjs7D3Jycszr6+s2CQ8OgJVKJWmTZmFh4e/d3d0os9n8z8LCwl89PT2a3NzcAF+2UagwBHLD27dvT5qamn4uLi76ZcjBdQV4bGxM6/x/cno2MTFRlpiYqCRnrebm5s4qKip2vn375tPACgl6AA4Wi+Wyt7f3MD09fTM/P9/ir+LnOgB2h8FgUH348CGSXL94+FaJA3oADjU1NbsSntDr9feedhESEiIbHh4OJ6dLv3//jp6AAT0Az0VGRsrDwsJ+6+9EQtDX1xf6cK0SDwSA57gOgHd2di4bGhr209LS/tNoNOs6ne7fkpKS7bW1Nda9/PPnz1XZ2dk4MGbAEIjnNjY27K2trQcxMTHy6OhoRWxsrGJlZeWiuLh4e29v7/JqvbOzM8fIyMjx1NTU6fT0dIRer3cJTkFBgXpmZubU578EjyEAPLe8vHzR2Ni47+76h4eHl/X19Xtk3hLzuaysLPQADBgCidDs7OzpycmJg21KtVTq84msvIYAiBCZqmE2m+3M5eRqMu4puAlDIB4jc4Dy8vLUZOyv0+nIQ0724qurqxdGo9Fy27ZKpZJ1V396eurSM9AMAeAxm83m6Orq0jBvwNFqtTKyNyfTM9io1WppRESEy+Sh/f39SwTgJgyBeD6UWVpacpnwRqZnG43GQK7tXrx48Yhttur8/PyZF5opaAgAz01MTByzLTeZTE/IzTrM5aGhoTKur2eZmJg48UYbhQwB8IODgwOX7+2ZmZmJZFt3aGjIen5+7jJuJ0Oc9+/fR7x8+fIRGfKQg1uj0aienZ2NJNcKmOtbLBb7mzdvrN76nYQKxwACuBDW3d19WFtb+yfzubi4OAWZ5+PO69TV1e1h/O8KPYAAmEymn+RGnPtu39/ffzQ8PMw6lKIdAiAAVqvVkZeXZyFXhT3ddnBw0Mqnma18gwAIxObmpj0rK2trYGDgiOv0p7Pt7e3L0tLSHXL7psOBU/9ccAwgsJ6gsrJyt62t7aCoqCiQzO2Jj49XaDQaGZn6sLW1ZSe9xPj4+DG5i+3o6AiVf4frCyyOL4brDysw4+OPuzYEECLr/DPd1c/Sp3NSDIGAaggAUA0BAKohAEA1BACohgAA1RAAoBoCAFRDAIBqCABQDQEAqiEAQDUEAKiGAADVZM5TQ9mmjAKIdSo0+Rc9AFDtRgDQCwBNe/87ewAMhUAMbqtjlwA4p+OujQH4jlm/zPrm/LJ453uEr+BeYRAKth03s/h/LbvtRdhCACBEbMX/a7k7GyMIILbCv37ekxdDEEAshQ8gAYnkf2cPOcMpsiepAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown16.png\",\"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\"},\n {\"FrogBlunderCountdown17.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAE00lEQVR4nO3dP0gjWRwH8EniJbubqBtu9RTEStEqQhCJuoWitagRLAXBNOKfKo2KoJgyYhUQkXTaaCOoaGHhIsE/C66ChWChiHeE+5OsXi5qzDHLGSYzSZyZi755876fZuHpxB/J7/veTPIyy3EAAMAmg5JfTn77nHy9UgDyx+D4Iqu3Zf0SGh/0GoScP0Tjg96DYFDS/FbX18t8FwbwGu5Czko5ITDIaX40PuglCOIQGMUHoPlBT8STt7i/jUoOBqBRrj42ZksHmh/0RNjPwj7PuQIA6F0qAJj9gcVVACsAMA0BAKYhAMA0BACYhgAA0xAAYBoCAExDAIBpCAAwDQEApiEAwDQEAJiGAADTCkgXQKve3l7r4uLiz8Ixv98fnZiY+Ctff6OhocGys7PzS74ez+fzRWZmZiL5ejw9wAqg5kkzGrmRkZHC/L8c8NYQABU8Hk9hXV2dOf8vB7w1BEAhl8tl8fl8H1/n5YC3hgAo0NTUZFldXS2xWCyKbimpBeFwOLG0tHRHug6tQQBk6uvrs62trZUWFxdT95zF4/Gk2+0OX1xcPJKuRWvwLtALSkpKTH6/397d3f2Be2P7+/txq9Wq6NY0Xq+3aHJyMu0Uzev1/nl0dHSf9wJ1AAHIorS01DQwMGAbHh4utNlsVMz6jY2NlvHx8bTm39jYiC0sLNySq0rbEIAsZmdn7Z2dnRln/cfHR66gQFtPHX9qFgwGP5lMptRYNBp9Ghoa+oNoYRpHxcymJcfHx/cej+d3TmOmp6c/VlRUmERjkZubmwS5qrQPAZApkUhwc3Nz0ba2tt+urq40dTHJf2Lc399vE46dnZ09zM/PfydXFR20tY5r1Pr6emxqaipycnKiuQtJg8HAB9PO/yvEb8ngT9UgNwQgi3A4/BQIBL4Hg8Hb09PTB06jenp6PjgcjrRPpQ8PD+/5i19yVdEDAchidHRU8xeP/AXv2NhYcaZNb2Qqog+uASjmdrut1dXVPwnHzs/PH7a2tjD7y4QAUGxwcFCyIzUQCNwmk/jPPOVCACjldDrN9fX1ZvGWh+XlZez3UQABoHhLtnhsc3MzFolEnshURCcEgEJms9nQ0dHxXjy+srLyN5mK6IUAUKi9vf2deFcq/57/9vb2P+SqohMCQKGuri7JHqVQKBTn9/6QqYheCACFWltb34nHdnd3MfurgABQpqqqqqC8vDxt09vzCkCmIrohAJRpbm6WzP68g4MDze1TogG2QhAQjUYrhfv2nxu4paXl15eOdTgcaZ/88q6vrxN4+1MdrACUqa2tlQSA3/pMphr6IQCUqampkQTg8vIS+55VQgAouyNdWVmZKdMpEJmK6IcAUIT/8Ev8xRcezv/VQwAoYrfbM75esVgM2z9VwrtAKuzt7Sm+X49QUVGRqmP5G1v9n78LUlgBgGkIADANAQCmIQDANAQAmIYAANMQAGAaAgBMQwCAaQgAMA0BAKYhAMA0BACYhgAA01IBMDi+pL5pcRdyVhKrCOCVCPv6ud+xAgDT0gKAVQBYmv1fXAFwKgR6kKuPJQEQpuOlgwG0Tty/4v6W3mLgP8lvnyVftLa6vuL7qECFTBO3uPl/jOV6kEwhAKBRpub/MS7nYAQB9Nb4qZ8reTAEAfTS+AAccNy/atd2zjoiEFUAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown18.png\",\"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\"},\n {\"FrogBlunderCountdown19.png\",\"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\"},\n {\"FrogBlunderCountdown20.png\",\"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\"},\n {\"FrogBlunderCountdown21.png\",\"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\"},\n {\"FrogBlunderCountdown22.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAFSUlEQVR4nO3dO0gjWxgH8EyMJjeJRsy6XHwsQjqLiCIisoqYQgsxKAHjAxGLLWwEsRELwVoQNGoKsfQJYqOCjeADRGGFRQsFmxVfiY+92RXN1SSXs3DFPTnGxMfuzDn/H4gwY8LH8P1nzjzOqFIBAICYpFj+OPTlY+jtSgF4PZJ1NarejuqP0PjAaxAirkTjA+9BkGJpfkPh56+vXRjAW7haz/sQTQikaJofjQ+8BIEOgZr+AJofeELvvOn+VsfyYQAlitTH6sfSgeYHnjzs54d9HvEIAMC7+wBg7w8iHgVwBAChIQAgNAQAhIYAgNAQABAaAgBCQwBAaAgACA0BAKEhACA0BACEhgCA0BAAEJrmTxegFMXFxVq73a4vLCzUZmZmakwmk3RzcxM6Pz8Pbm9v366trd2MjY1dnZ2dBUWqRenu50ficWi2vLy8BJfLlZKTk5Pw1MYkTTg0NPS9p6fnn9vb2xDPtfAwR5jMD8YQKIL6+nrD0tLS39E0HKHT6aT29vakxcXF90ajUc1rLTzBhnmEzWbTud1us0YT+yixoKBAOz4+/k6SYnrxniJq4Q0CwJCQkCD19fWlxMXFPXvDlpWV6ZxOp4GnWniEADDU1NToLRZL2O42FAqp+vv7fVar9Sg5OfnAYrEctrW1Xfh8PubJZmtrayJPtfAIAWBwOBx61vLu7u5vnZ2d3/b39+/IieXJyUlgZGTkh91u95KGZJ20ms1mNS+18AgbhELGyiUlJTp6+cXFRdDlcn1nbcSNjQ3/8vLyDWtdRkaGhodaeIUAULKysjQGgyHsjJE0ld/vf/RyIrn+zlr+nBNXOdbCK2wRxvVzMrxIS0uLS09P15Df5Gd3d5fZVP+Lj49nXmY5PT0N8FALrxAAyvHxcaC3t9cX64bMz88Puz7v8XgCh4eHAR5q4RWGQK+AnGCSH3r5wsLCNeuEVJRalAABeKXr9PRy0myDg4PME1URalEKBOAlG0+tVrnd7hTWkGNycvJqZ2cn4lid11qUBAF4wSXKgYGBlNra2rA7rGSs3dHRcSliLUqDk+BnII8lDA8PmxsaGsIajtyUamlpObu8vAyKVosSIQDPGGePjo6aq6urw+7QBoNB1adPny5WV1f9otWiVAhADPR6vTQxMZFKns6k193d3ZGGO5+amroSrRYlQwCilJiYqJ6ZmUktKirS0uuur69DTU1NZ/Pz89ei1aJ0CEAUTCaTem5u7n1ubm7YFRYyvnY4HN719XW/aLXwAAF4AplNNTs7m8pquIODg7uqqirv3t7erWi18AIBeOKZmunp6XdkVhW9jjyPU1lZ6Tk6OgqIVgtPEIAIyAR01uPI5Bn88vJyj9frDYhYC09wI+wRzc3NxsbGxrBr6+QxZKfT6f2dDSenWniD16IwkEeOt7a20oxG44tnkldUVHhWVlZ+maDi8/k+0HN8Nzc3/y0tLT353bWIBq9FiUJXV5fpNRqOt1p4hCEQhcybraurk8UbFORUC68QAMZbGLRarSz2uHKqhVcIAMVms/2lkgk51cIrBIBitVrjVTIhp1p4hfsAlOzs7KO33uhJSUlf5VKL6HAEAKEhACA0BACEhgCA0BAAEBoCAEJDAEBoCAAIDQEAoSEAIDQEAISGAIDQEAAQGgIAQrsPgGRdlVgThwF4nRBPfuMIAEL7JQA4CoBIe/8njwAYCgEPIvVxWAAepuOpDwPIHd2/dH8/+sqN0JePYf9T01D4Oaq5rAB/GmvHTTf/z2WRvoQVAgAlYjX/z+XRfBhBAN4a/359LF+GIAAvjQ+gApXqP5Ab7CIRCr9DAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown23.png\",\"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\"},\n {\"FrogBlunderCountdown24.png\",\"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\"},\n {\"FrogBlunderCountdown25.png\",\"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\"},\n {\"FrogBlunderCountdown26.png\",\"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\"},\n {\"FrogBlunderCountdown27.png\",\"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\"},\n {\"FrogBlunderCountdown28.png\",\"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\"},\n {\"FrogBlunderCountdown29.png\",\"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\"},\n {\"FrogBlunderCountdown30.png\",\"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\"},\n {\"FrogBlunderCountdown31.png\",\"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\"},\n {\"FrogBlunderCountdown32.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAIPElEQVR4nO2ca0hUWxTHZ8bRmauOrzHv1TSsKaMiI62wcGpIyKIojCCdHpREUJk96EMgUfRFokIoM6Xo4Ycy/FIfVDDSqJEuSRFS0ZPIV761UfPtXJaQ6Jl9xhnnjN2Z/f/BMLrPnDObM+u/91prr31kMgAAAHwid+TDlppEi+u6AoB0yGNNdtm2XR+C4QNPFYLNgzB84OlCkDti/H4Jr2ul7hgArqD337g59ohAbo/xw/CBpwhBKAKF8AQYP/AkhIO30L4VjpwMgDtiy44VYuqA8QNPYqI9T7RzmzMAAJ7OuAAw+gMeZwHMAIBrIADANRAA4BoIAHANBAC4BgIAXAMBAK6BAADXQACAayAAwDUQAOAaCABwDQQAuEb5pzvgDnh5ecnWrVun3rFjh298fLwqPDzcS6PRyNvb20e/ffs2XFFR0V9UVNRLf89Ef/R6vWrbtm2+CQkJqqioKGVgYKC8v7/fQv15+/btUFVVVf+9e/d629raRmeiP+7M+P5IlEOzWbFihU9eXp52yZIl3rZu5NDQkOXmzZs9WVlZXQMDAy55flJcXJxPbm5uyLJly3ym+iwJIi8vr/v8+fM/qW+u6I+77xGm/cFwgWxAI35lZeU/Uxk/4e3tLT906JCmtLQ0LCgoSPL7ajQa/agv9hg/oVar5SdPngwoLy8P8/f3x+8sAm6MCKtXr1bduHFDq1A4dovILSksLAx19DxbJCUlqfPz87VKpeMe66pVq1T3798PlcsdegggN0AAIuTk5AT7+PjIp2uwNGLLJID6kJOTE0JxyHRZv369OjU1VZL+eBoQAIO1a9eqly5dauVqdHd3j2ZmZnZERUXVR0RE1KekpLR+/vx5iHWNjIwMjRQ/0Pbt2311Op3V0G+xWGRXrlwxx8bGNgYFBdXpdLqGY8eOdZjNZmbge/jwYUn642kgCyRidKz2PXv2tD1+/Lj/9//l5eV9Hz58GKqurg739/efNFuQgEJCQhQdHR2jzsYhrPazZ892Xb582fz7/6amphEKwmtqaoYqKir+Fro8FEBrtVoFZYqc6Y+ngRmAgcFgUAnbyPAnGv9vamtrh00mk1U7QelSZ34cMmKajYTtJKrc3Nxu1jkvX74cePbsGbM/kZGRGPAE4IYw2Lt3b/vixYu96bVo0aKx15MnT/pkIjQ3N4+w2nt7e51KP0ZHRyv9/Pys4hAycFupVloLoHULYft0gmhPB3eEQU1NzSC97L2JsbGxVvECLUJ9//7dqYUxyuWTqxMREeE1e/ZsJb3T6+PHj8y4Y2JK1hGh8gwE4CQ7d+70W758uZUA7ty500OBqjP8+PFj5NKlS+N+viOLd8K2lpaWkYaGBghAAAQwDWiRKSYmxptSnazsCmWGLl68+FP2B6Bgl17C9rKysj5nBemJQAAOkpmZGZCdnR0kdvzTp09DW7dube3p6Zlxa/u9ZiBsJ8O/du0aM2jmHWSBHGT+/PnMQYOMjNKQer2+qa6ubkaK4iZCK8/5+fkhLPfnwYMHve/evbMZN/AKBCCRAChlSZmXjIyMgICAgBm9r/TdV69eDaF4RHiM/P5Tp051zmR/3AkIwEF0Op1oYdyCBQuUZ86cCaSFMVZg7AqoRKKgoEC7b98+f+ExqgJNT09v6+zsxOKXCBCAg5w4caIjJiamITg4uG7hwoUN586d6xocHJzk70dGRnqVlJSEsUoYpPb57969G7pr1y6rkX90dFR28ODBDpPJNODKPrg72A8gAZs2bfqruLh4lrD84OnTp/2bN29ukbkAX19feVFR0SwqvBMeGx4eJuNvJ9/fFd/tzmA/gAugFCPVBQnbDQaDmlaRpf4+jUajePToURjL+Pv6+ixpaWmtMH77gAskEZWVlf1i2xdlEhIYGKgoKysLW7NmjdV1ydffsmVLS2lpqWjZBpgM1gEEUKmBXq9Xk/8+b9485dy5c8fejUZj24sXL0T96a6uLmagGR4eLtk9pp1dDx8+nMUKsCn1SusPtA4h1ffxAAQggMqYb926pRW2r1y5UmVLAGKVn79+/ZIkA0P1PcXFxaG0w0t4jGqDaORvbGxEqYODwAUSIFYEZzQamXX5EwNhVnt9fb0kRkmb4Vml0V+/fh1OTk6G8U8TCIBRgPbq1atB1sxw9OhR5q6q/fv3+7NGZlodpkyQzEkox797926rVCeVRKempra2trZi5J8mcIEYUCVnfHy8VU1NdnZ2MJUlFxQUdNPIHh0d7XXgwAHNkSNHmMKg5wWRoITtZrN5jnCPb3V19aDBYGhixSQXLlwIZl1fpVLJadFNZicbN25sef78udOC9CQgAAaFhYU9VOUpTGFSnp9mAbGZQJiLP336tNMlCFlZWYHC7ZZAOuACiRhvenp6uzMVncePH+94//69UxkZ2sOblpaGpzm4EAjARjBM/jU9CcJR8VDx2e3bt3uk2JxPbo6z1wHiQABTLG4lJiY2VVVV2VVP8+bNm8Hk5OTm69evS1J7n5SUxMwsAelADDAFX758Gd6wYUNzYmKiKiUlxZcWySgwJb/cbDZbKMilp0KUlJT0UdAr4W9De40lL6MAk0ExHOAKFMMBMAHEAIBrIADANRAA4BoIAHANBAC4BgIAXAMBAK6BAADXQACAayAAwDUQAOAaCABwDQQAuGZcAPJYk5xVMgqAp5ZC0ztmAMA1kwSAWQDwNPpPOQPAFQKegC07thLARHVMdTIA/3eE9iu0b9FHblhqEq2eieOX8LpW4v4B4BJYA7fQ+MfabF2EJQIA3BGW8Y+123MyhAA8zfDHjztyMQgBeIrhAyADMtl/bPsw76tn5QwAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown33.png\",\"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\"},\n {\"FrogBlunderCountdown34.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAHT0lEQVR4nO3dX0hTXwAH8LvN6XTO/dH6/eY/KtP+odTPDIutRkERhGAE1cD+UUj5h8LCIiofAh8WBRWW2V8feuop0CApezD6I0X4EJG+5JQS17TpZtqWP04wubu7m7vubs2d7weGerbdjbvzvefcc86dDAMAAHSSCHnwdI9hOnJvBUA8kqKukOp2SA9CxYd4DULQO1HxId6DIBFS+ZWl7/vFfmMAkeB8/V9uKCGQhFL5UfEhXoLADYGU+wRUfogn3IM3t35LhTwZYD4KVo+lgdKByg/xhF2f2fU8aAsAEO9mAoCjP9DYCqAFAKohAEA1BACohgAA1RAAoBoCAFRDAIBqCABQDQEAqiEAQDUEAKiGAADVEACgGgIQAplMxmzevFnR1NSke/Pmjb6/vz97ZGQkp6+vL6ujo+OfM2fOqBcvXpzA/GUXLlzQOJ3OXPbtwYMHGX/7fcWyv/6hxbq1a9cmNjU1pa9atUrOvU+v18vIbcOGDUn19fVpt2/fHj979uzo5ORk1L8/qaSkJLGuri4t2q8736EFCGLXrl0pnZ2d//JVfi65XC45evSoqr29faFGo4nqfk1OTpa0tLRkkJYKhEEAAli/fn1SS0tLulQqbBeVlpYmtba2Zgh9XjguXryoyc/PR2s+BwhAAFeuXNEmJiYK+upIry1btijMZrOSiQKTyaSorKxUReO14hECwGPjxo2KwsLCRG752NjY79raWntOTs5AZmbmQHl5+XBvb+8vvm1UV1dHvFKmpaVJm5ub0yWSOeUUcBLMb+fOnSl85RUVFbaOjo6f3r+fPn068enTp1/d3d361NRUn1pIAqTT6aR2u/13pGra5cuXtdnZ2ej4hwEtAA+TyZTELSMVn135vfr7+91dXV1+5QQZIWIipKysLGXv3r1R6WbFM5w48di3b9/3lStXysltxYoVf27Pnj2bCLQTh4aGPHzlTqczIsOhCxYskF27dk0XiW3TBgHg0dPTM0Vuoe7EoqIiv/MFm832+8uXL24mAq5fv67LyMjwab3b2tomyMgV6XZF4jXjFXZWmHbv3q1cs2aNXwDu378/Pj0tfgNQUVGh3LFjRzI3bFVVVXbRX4wCaAHmQKFQSAoKCuRkqPPYsWN+oz1kZMhisfxgRJaTk5NgsVi03PKamhr78PAwbzcMgkMABKqtrU1rbGzUBLr/8+fPv8rKyobHx8dFPfyToc5bt27pVCqVT6v98OFD5+PHj11ivhZN0AUSaOnSpbwHDdLdIWuBjEbjN6vVKnrfv6qqSkXmJ9hlAwMDnrq6uhGxX4smCIBIASBH6E2bNimqq6vTyAQVI6L8/Hx5Q0ODhhu4ysrK7w6HI2LzDDRAAATKy8sLuDCOrMc5d+6cmkyM8Z0Yz0VCQgJz586ddLLgjV1+8+bNsRcvXvDOP0DoEACBTpw4YS8oKBjUarXWZcuWDTY0NIxOTU359PfJ7GxbW9vCvLy8sM+xTp06pS4uLvYJU29vr/v8+fOj4W4bEADB2tvbJwYHBz2k0pM+uMVicZjNZht3yFOtVkuvXr0a1mTV6tWrE8l1Buwyj8fDHDlyxOZyufA/m0WAFkAET548mSDrgvhWapJZ5LkOtZKuD7nOgF1+6dKlH93d3SFP0kFwCIBIOjs7efvjRqPRb11RKAoLC+XLly/3C099fb2ae9mj98Y3C0wu6mE/5sCBA6lzeT/xCvMAHJmZmTKj0agg/fclS5YkkGt9yU/SzXn16tVkoB05OjrKOxqj1+vntI8lWOMcFQgAB1nGfPfu3XRueUlJSVKwAARa+elyuTBMGcPQBeIItAjObDbzXiPgtX37dp/1OV7kRDmMzwciDAHg+Pr1q+fdu3dTfC1DTU0N71VeBw8eTF23bp1fX5+MDGGsPrahC8SDrOQsLi72G8JsbGzUZmVlJTQ3N4+RI/uiRYtkhw8fVpFlCnzbef78+U8SKG65w+HI5X6DAxnZMZlM37x/v337dlKpVAr6R+VWqzWbeyL86NEj1/79+21CtkMTBIBHa2vrOFnlyR3CJOelpBUI1BKwud1u5vTp01inE+PQBQpQeQ8dOvQ9nBWdx48ft3/8+JH3gnmIHQhAkJPhPXv2DJNvghAanpMnT47cu3dvXJRPCCIKAZhlcstgMHx7+fJlwOFPtg8fPkxt27Zt6MaNG2OifUIQUTgHmEVfX59769atQwaDIam8vDyFTJKRyTLyNSgOh2OanOSSb4Ug1+SSk97Iflwgtpl1JtM9hpn+rrL0vaDRB4D5wvn6v1zv75KiLgm6QEA1BACohgAA1RAAoBoCAFRDAIBqCABQDQEAqiEAQDUEAKiGAADVEACgGgIAVEMAgGpS9tJQviWjAPG6FJr8RAsAVPMJAFoBoOnoP2sLgK4QxINg9dgvAOx0zPZkgFjHrb/c+u3zBxv7GmEvXCsM8wXfgZtb+f+UBdsIXwgA5iO+yv+nPJQnIwgQbxV/5n4hG0MQIF4qPgADDPM/O9CZ0dwrG6wAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown35.png\",\"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\"},\n {\"FrogBlunderCountdown36.png\",\"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\"},\n {\"FrogBlunderCountdown37.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAHVElEQVR4nO2cb0hTXxjH72Zz+zWdzqKfSgVlan9okP3BaiujKHojmEExKMgXQaVSEBWYFEhZ+CIqSKgo8U296aUWRU3ISLIifFFRUeQfStSl07mcf/bj8cdk3p3N3XV3c/d8P3CZnu3ec7n3+Z5znuc85wgCAAAAPtFI+bGvzeqL3a0AIB8aS3NEth3Rj2D4QK1CCPslDB+oXQgaKcZvzH/bLveNARAL3C15iyMRgSYS44fhA7UIQSwCrfgEGD9QE+LGW2zfWiknAxCPhLNjbSh1wPiBmgi050A7D9sDAKB2pgSA1h/w2AugBwBcAwEAroEAANdAAIBrIADANRAA4BoIAHANBAC4BgIAXAMBAK6BAADXQACAayAAwDVz/vYNxAMJCQnC1q1bDXv37p27du1afUZGRkJycrKmr69v4tu3b2PPnj37ff/+fTf9LWe9GzZs0Dscjn/lut7FixcHLly4MCDX9dQABDAD69atS7xx48a8VatW6cTfkRDo2LRpk/706dOm27dvD1VUVPSPjIxg/6Q4AUOgMFCL73A40lnGL0an02mOHDmS3NjYuCA1NRXPNU7AiwrBxo0b9bdu3Zqn1Up7RPn5+fr6+vr5Us8Dfwe8pRBcuXLFnJiYKGnrSD/bt2832O12ozCL6OnpGb937577b9/HbAMCYLBlyxbD6tWrE8Xlg4ODE+Xl5c5FixZ1ZmZmdhYVFfV8/vx5lHWN0tLSZGGWQD5JcXFxz9evX2V10tUAnGAGe/bsmcsqP3DgQO+TJ09++/9//Pix5+PHj6Otra0ZSUlJ03oLElBaWprW6XRORPtyXr16NWI0GiVtTXPq1CnTuXPnUkVlv968eeON9j7UDHoABgUFBXpxGRl+oPH7aW9vH2tubg4qJyhCJCjst5w9e3aa8T98+NBD0Skl7yOeQA/A4ODBg30rV67U0bFixYrJ4+nTp55QD7G7u3ucVe52uxULh6akpGjr6urm05yFH5fLNVFWVuZU6h7iEQiAQVtbm5eOSB+ixWIJ8hd6e3snvn//rtiYu6qqKnXhwoXTepyqqqqBHz9+MMUJ/gdDoD9k3759xjVr1gQJoK6ubsjnU6YDoBnjkpKSpMCyDx8+jN68eXNQkRuIY9ADRIHBYNDk5OToKNR59OjRoGgPRYZqamoUSTnQaDTC1atXzfQZSGVlZf/YGII+MwEBSKS8vNxUXV09zdEM5NOnT6OFhYU9Q0NDPqVmq8VDsNevX3vJ+VWi/ngHQyCJLFu2jNlo0HCHoi02m+1nR0eHIk0vObwVFRUprKQ3JepXAxCATAKgIQhljJaWlppMJpMiz7W4uNiYnZ2tEw+/aH5CifrVAAQgkaysrJCJcdnZ2XMqKytTaGKM5RjLzbFjx4L8j9raWsWcbzUAAUjkxIkTzpycnC6z2dyRm5vbdf78+X6v1zvN4igc2dDQsCArKytmPlZeXl4ipWqLUx5oXUKs6lQjEIBEGhsbPV1dXeNk9J2dneM1NTUuu93eK251aWLq2rVraUKMOHz4cFDr/+jRI8/AwEDUqRc8AgHIAEVcWOPugoICA80iCzJDWaqFhYX/iMsfPHgwLHddagcCkAmHw8HMB7LZbEF5RX/Kjh07DNTDBJZRzJ+VqwTCg3kAEZmZmQk2m81A4/elS5fOWbJkyeQnDXNevnw5EupB9vf3M4ceGRkZsj/joqKioGzVlpaWEcr9kbsutQMBiKA05jt37swTl69fv14fTgChMj+Hh4dlN8pt27YZxGXPnz9H6x8FGAKJCJUEZ7fbmWsE/OzevTtoTE6QoyzIPA/BEhv1AHLWwwsQgAjKnmQtHqGeoaysjLnK69ChQ0mUkCYup8hQU1OTrC3z5s2bg1p/orW1FQteogACYECZnKzy6upq86VLl8zkF9AuEDTxdfnyZfP169eZ4U7aL4iVjuxyuRa73e5pR1NTU3okL8xisQRFlSgsi/BndMAHYFBfXz9EWZ7iECalO1AvEKonEEdlzpw580uQmeXLlwcJgFKf5a6HF9ADhDDekpKSvj/J6Dx+/Ljz/fv3shtmbm6ujrUsU+56eAECCOMM79+/v4d2gpAqnpMnT/66e/eu7Otwaa+h9PT0BNYQSO66eAECmGFyy2q1/nzx4kVEEZZ37955d+3a1V1bWxuTlVg0+SVe+EJg/B898AFm4MuXL2M7d+7stlqtepqAokkymiyjbVBcLpePnFzaFaKhocFDTq8QQ8xmM7PB8ng8SP+MkqnmxNdmnXqIxvy3kvaiASBecLfkLfb/rbE0azAEAlwDAQCugQAA10AAgGsgAMA1EADgGggAcA0EALgGAgBcAwEAroEAANdAAIBrIADANRAA4BptYGooK2UUALWmQtMnegDANdMEgF4A8NT6z9gDYCgE1EA4Ow4SQKA6ZjoZgNmO2H7F9h28xQBjjbAfrBUG8QKr4RYb/2RZuIuwRABAPMIy/snySE6GEIDaDH/qeykXgxCAWgwfAAEIwn/muLUVLDTP9AAAAABJRU5ErkJggg==\"},\n {\"FrogBlunderCountdown38.png\",\"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\"},\n {\"FrogBlunderCountdown39.png\",\"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\"},\n {\"FrogBlunderCountdown40.png\",\"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\"},\n {\"FrogBlunderCountdown41.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAEi0lEQVR4nO3dT0hiWxwH8Hs10/JfOdYq2wltmmIikBhCaBsREUSLsI26kP6AhLuKijZFEQX9I6hNq2hR1LrFEEPBQFO7dmOL99DxvXGeznvzNB8OTO96M/Oq3TPe3/cDbq5e78H7+55zPFyvHAcAADTxUl6c+vg29XJNASgd/vW7vGo7rxeh8EGpQcj5JAoflB4EXkrx6x0fPpW6YQAvIfb+TWM+IeDzKX4UPiglCOIQqMQ7oPhBScSdt7i+VVJ2BihHuepY9VQ6UPygJMJ6FtZ5zhEAQOkeAoDeHyiOAhgBgDQEAEhDAIA0BABIQwCANAQASEMAgDQEAEhDAIA0BABIQwCANAQASEMAgDQEoEhTU1M1sVisUfjY29uzcjIaGBjQi9swOztbI2cbyhUCUIT29vZKv99v4hhSqVTc2NiYkWUbyhkCUKCqqip+e3vbqlarOZY8Ho+xpaWlkmkjyhgCUKC5ubkau91ewTHkcDi08/PzmOoUAQEogNPp1Hm9XqbTjo6ODu3h4WGdVquVdHtLyIQASGQymVSbm5uveJ5d3blcLsPx8XG92WzG+SsS0yG8HC0tLdU2NDQwmfjX1dWp08fv6+urZnF8JUIAJOjp6akeHBzUczKrr69Xu91uw+joqNFgMKDXLyEEQELvu7q6auEYWF5eru3t7c3a6ycSCa6iAqexUOhN8rS2tmaxWq0Zn9fJycm3SCRyzzFydXX13ePxfGZ1fCVAAPIwNDSk7+7urhJuC4fD9z6fL8IxkEwmuZWVlWhXV9fvwWAwwaINSoGx8xk2m61iYWGhVrx9ZGQkEgqFkpzMTk9Pv83MzHy5vr7+LvexlQgByCG91Lm1tWUxGo0ZI+X+/n7s6OgozskkFArdr6+vf93d3f3r5ubmX7mOSwECkIPP5zN2dnbqhNvu7u6Sfr//D05G4+PjTKZaFOA7wBPsdrtmeno64zKDVCrFeb3ez9FolNkXXygtBCCL9LLizs7Oq/QFb8LtGxsbX8/Ozv4u8TkAhhCALCYmJsxtbW0ZV1je3t4mJicn/5TtzIAsEACR1tbWykAgYBIvO7rd7nA8Hsf/JCsMAiCg0+n49NRHo9FkTH0WFxe/XF5eYtlRgRAAgebmZk1TU5NG/CEFAgGz+CeHPx8Wi+XRZ9jf318tfM3w8LDhpU8kFAYBEOBZXuMMTCAAQBoCAKQhAEAaLoUQuLi4+Eev10v6c/BgMNgg/iJ8cHAQd7lc4af2iUajjeK7SaRXmZxO529Sjg3FwwgApCEAQBoCAKQhAEAaAgCkYRWoSDab7U7qPiaTSdJKUy7n5+eSV67gfxgBgDQEAEhDAIA0BABIQwCANAQASEMAgDQEAEhDAIA0BABIQwCANAQASEMAgDQEAEh7CAD/+t3DTaFi7980MmsRwAsR1vXPescIAKRlBACjAFDq/Z8dATAVAiXIVcePAiBMx3M7A/zqxPUrru8n74ac+vj20Z9B6B0f8NtTKAvZOm5x8f/YlutNsoUAoBxlK/4f2/PZGUEApRX+w/NS3gxBAKUUPgAHHPcfLANo+29D9ocAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown42.png\",\"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\"},\n {\"FrogBlunderCountdown43.png\",\"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\"},\n {\"FrogBlunderCountdown44.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAADvElEQVR4nO3dv0sbYRzH8bv8kKQhqcYIHRK3rEUqgkOR/AHi7iBOkiE4BXFTBzfFRQd/IOji5CS4Z+hQFBy6ummGgmnapk36g8aUWCqXa4x3Gstzz/f9AhGe5MKX8/u55zgvzxkGAEAm082bG+9eN56uFKB7zJdvHPW2ozfR+NA1CB1fpPGhexBMN80fGT276HZhwFOovn016CQEppPmp/GhSxDsIfDZN6D5oRP7wdve3z43GwNe1KmPfXelg+aHTqz9bO3zjjMAoLvbAHD0h8RZgBkAohEAiEYAIBoBgGgEAKIRAIhGACAaAYBoBACiEQCIRgAgGgGAaAQAohGAR1pcXOytVquD1p/9/f2E9Fq8ggA8wsjISE8+n48ZClCpFi8hAA8UDofNnZ2dhN/v7+5fxOO1eA0BeKDl5eXedDodMBSgUi1eQwAeIJPJhLLZbNRQgEq1eBEBcCkWi/m2trb6TdPVsqra1+JVBMCltbW1vmQyqcTJtkq1eBUBcGFiYuLZ5ORkxFCASrV4GQFwaGBgwL++vh43FKBSLV5HABza2NiIJxKJlv11fHz8rVwuX0uuxesIgANTU1OR8fHxsHWsVCpd53K5suRadEAA7pFKpQIrKyt99vHZ2dny1dVVXWotuiAAHTQvL25vb8ej0WjLfjo4OKgeHR3VpNaiEwLQQS6Xi46NjYWsY8VisZ7P5z9KrkUnBOAO6XQ6uLS01GsdazQaRjab/VCpVK6l1qIbAtBGIBAwdnd3+5s3mVnHNzc3vxQKhe9Sa9ERAWhjbm7u+fDwcI917Pz8/NfCwsInybXoiADYDA0N9czPz7fcV1+v142ZmZlSrVZrSK1FVwTAIhQKmc3TjWAw2HK6sbq6+vn09PSn1Fp0drtzeUDGn29VFQqFF93eyc1/Uu3t7X31ai26PjWy+cRIZgALU6H7ilWqRWcEAKIRAIhGACAaX6S2ODk5+RGJRFw9HPzy8jIZj8dbDiSHh4e16enp0l3bVCqVQfsKDs0rO5lM5v3/rkU6ZgCIRgAgGgGAaAQAohEAiMZVoEdKpVJFt9vEYrELVWqRjhkAohEAiEYAIBoBgGgEAKIRAIhGACAaAYBoBACiEQCIRgAgGgGAaAQAohEAiOazrpLVbvUsQNdV4Zq/mQEgWksAmAUg6eh/7wzAqRB00KmP/wmANR33bQyozt6/9v6+cwVi63Lpf0VGz57ku6xAt7U7cNub/2as04e0CwHgRe2a/2bcycYEAbo1/u3rbj6MIECXxgcMGMZvfhySbvQDJLsAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown45.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAGmElEQVR4nO3dXUhTbQAH8LMvvz/n5+vHso9Bob7IK0LUUC+UbqIbJTAQISghCQpJg6CSBKFUEDXKFPRCL8QLLQy9iCy8EIKyV0Uj6iKtDN206XTm5l6eXpLt7Gye6Xa2c57/D0Z09GwPx+d/ns9tDAMAAHSSefLLtn91Nt8VBcB7ZH+P86rbvH4JFR+kGgS3P0TFB6kHQeZJ5Q8/+faLtwsG4AumiX80fEIg41P5UfFBKkFgh0DOPgGVH6SEffNm12+5JycDiJG7eix3lQ5UfpAS+/psX8/dtgAAUrcbANz9gcZWAC0AUA0BAKohAEA1BACohgAA1RAAoBoCAFRDAIBqCABQDQEAqiEAQDUEAKiGAADVEIADunPnTozJZNLYP3p6euIZH2hubo5lvxbfx8jISJIvyiR2CMAB5OXlBVVXV0cxAsnKygoS6rVogQDsU2hoqOzJkyfxCoWCEUpWVpZKsBejBAKwT/X19TFarVbJCCQ9PV0ZHR2Nv5eX4YLuQ2FhYUhlZWUkIyDc/X0DAfBQVFSU/PHjx3EymUcfq3pgCIBvCNaESwWZiUlLSxOu4+9mAPzu3btfOp1uUeiySAlaAA+cO3curKysLJzxg+zsbKcB8MzMzLY/yiIlCABPCQkJitbWVjXjByEhIbJjx445BWB6evqXP8ojJQgAT21tber4+HiH6zU8PLxpMBh2GB87ceKEimu6dWpqCi3AASEAPJSXl4efPXs21P7Y8vLyTlVVlYHx4wBYpVIxLS0t6snJyRSDwZD+48ePtMnJyb8ePnyoLioqChGibGKHQTCP+fcHDx7Eso9fvXrVsLS0ZGX8uAI8ODiYaP//4OBgmVarlWu1WlVFRUXE+Pj41pUrV/SfPn2yCFFOMUIL4AaZ6uzo6FBHRkY6XKe+vj7T06dPNxg/DoD50Ol0wa9evUo+depUsPdLJQ0IgBtVVVWR+fn5Dl2JhYUFa3V19QojoMzMzH3vAYqNjZX39/cnZGRkoLXngAC4QLoRd+/ejbE/ZrPZmMrKSr3RaPT5wPeP5ORkBXvwvZ8QdHR0xHmvVNKBAHBQKpVMV1dXHNnwZn/80aNHa2NjY2bB/jpuBsB6vX7n1q1bqzk5Od/UavW8RqNZqKioWP748SNnf//06dPBZAuHzwssMmgWOdy4cSM6NzfXodtBKtbt27dXGYF9/frVev/+fWNGRobi0KFDysOHDyvn5ua2L1y4sLyysrLbEm1tbdkGBgY2RkdHzS9evEjKzMx0Cs758+fDhA5woEMAWHJycoJqa2sd9vhbrVbm0qVLyxsbG4J/T/Ls7Ox2XV0d7+Ctra3t3Lx5c+XZs2cOM0REQUEBWgAWdIFYK66k66NSqRy6Po2NjT/fvHkjmlXX169fmzc3N21cU7pCb+ILdLtXA1+Q8f87vMbGxpK9fZHJgll3d/c6I6CZmZkUrpmf1NTUhdXVVcEG8YH8rZHkGyPRBbIjC7DbI2mRSkpKwkjfX6PRkIeC3MU/fPiwXVpauuTuXHYr9ofZbBa8GxfIEIAAZrFYbGQDHlnhtT+emJgoJ3uDyNiES1hYmCwpKclp8xC58yMAjjAGCGAWi4Xs+HTa8BYRESEvLS11uS37zJkzoWQql21iYmLLB8UUNQQgwLnactHQ0BBDtmizj8fFxcnv3bsX4+K5Nn1RRjHDIPiA5ufn09RqtcONhMzHk0UpV+cYjUYNe3szmWUqLCx0endXamqqYnp6OiUoKMipT//582cLmfJ8+fKlmfT5i4uLQ+rq6mK4Br9k497x48e/0d4FMmEQLC5kIay9vX3t+vXrTp8/dOTIESXZ58PneWpqalZor/xc0AUSgYaGhp/v37/f9zpEZ2fnen9/v2C7V8UEARABk8lkKykpWSKrwp6e29vba7p27Zogb9wRIwRAJL5//24tKChYJAtqrqY/2e9Yu3jxov7y5ct6sosVuGEdQGQtAVlVbmpqMpJPpyB7e44ePaokg3Cy9WFxcdFKWomhoaGN58+fb66vr6Pm7wGzQED1LBC6QEA1BACohgAA1RAAoBoCAFRDAIBqCABQDQEAqiEAQDUEAKiGAADVEACgGgIAVEMAgGpy+62hXFtGAaS6FZr8ixYAqOYQALQCQNPdf88WAF0hkAJ39dgpAPbp2OtkgEDHrr/s+u3y05DtPy79j/CTb794uXwAPsF142ZX/t/H3D0JVwgAxIir8v8+zudkBAGkVvF3f+7JkyEIIJWKD8AAw/wH0zZ3CTldunYAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown46.png\",\"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\"},\n {\"FrogBlunderCountdown47.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAFZUlEQVR4nO3dS0gjSRwG8M7DjJo1moyyCmZOBj0F8cWIi8SrSEDixYMIgnoInoJ68AlRL4ogCmpUyEkF9SKI4sWAexAfc9iLB8GDD1zQdSaZUdcZY5aaZaS7jTGtmemu1Pe7CKWJRfL/uirV1R2OAwAANqmk/HHorz9CP68rALGjsv4ZVW1H9UcofIjXIET8JQof4j0IKinFr3//4SjWHQP4Ga62Ct5FEwJVNMWPwod4CYI4BGrxA1D8EE/EB29xfaulPBiARpHqWP1UOlD8EE/49cyv84gjAEC8ewgAjv7A4iiAEQCYhgAA0xAAYBoCAExDAIBpCAAwDQEApiEAwDQEAJiGAADTEABgGgIATEMAgGlauTtAu56enrS2tjYDv21xcfG6vr7+4rXPXVJS8mZjY+N3LkYGBgb8/f39/lg9XzzACPAKxcXFOpfLJSh+oAsC8EJJSUmqqampdI1GE9t3BH4pBOCF+vr60iwWC6aQlEMAXsBmsyU2NzencBQ5Pz8Pzs3NXcndD6VBACQyGAzqycnJtyqVpNuqyur29jbkcDjODw8P7+Tui9JgCJdoeHjYmJ2d/Usm/tvb27d6vV7SrWnIihRZmRK1fdzb2/sa8w7GAYwAEtjt9uTa2lo9p1ClpaVvOjs7BcW/urp6Mz09/UW+XikbAhCljIwMzejoqIlTqNTUVLXX6xWsSgUCgfuWlpZLWTumcAhAlMbGxkzp6emC12tlZeXm8vLynlMAt9udJp6aud1u/9nZWVC+XikfAhCFuro6fVVVVRK/7eLi4t7pdCri6ErOGDc0NPzGb9vf3//m8Xg+y9crOiAAzzCbzdrBwUGjuJ1MLcjSIiczsho1MjJiFK9KdXV1fbq7w6LPcxCACEhReTweU0pKiuB1mp2dvVpeXr7mFKCmpibZarXq+G27u7tfyYdf+XpFDwQgAqfTmVJeXp7Ibzs5OQm6XK6PnAKQD7wdHR2p4Ta9ydMj+iAAT7BYLAm9vb2CJcVQKMQ1Nzf/Q1ZXOAVwOBx60k9+28HBwbf19XUc/aOEAISh1Wq5mZmZt2TDG799YmLis8/n+5dT0AglbhsfH/9CggrRQQDCaG1tTS0sLBTMqw8ODu66u7s/cQpRUFCgKyoq0om3PMzPz2O/jwQIgEh+fr6uvb1dsMc/GAxyjY2NF9fX14o5tDY1NT06+q+trd34/X5FTM9ogQDwJCYmqsjUJyEhQTD1GRoa8u/s7ChmL41Op1PZ7XbBeQliaWlJEStTNHl4o/EFGf9f4eXz+TJj/SKTE2Zerzdm+3EqKyuTFhYWMvhtZM3fbDafKOUDOg3fGkm+MRIjAI+Kkj3O1dXVyeK2ra2tWxS/dAgAhSoqKgTnJojNzU3FrE7RBAGgTE5OjjYrK0sTbgSQp0d0QwAoU1ZW9ujoTyjpQzpNcEXYK6/AOj4+zjaZTGop9wUKBALvxHeTIAVss9n+fu7/Wa1WwZlf4vT0NIjlz5fBCECZvLy8RwEgW5/l6Q39EADK5ObmPgrA0dER9j2/EAJAEbVazWVmZmrCTYHk6RH9EACKkOt+w52qwPz/5RAAihiNxrDv183NjWL2KNEGq0CvRLYfSH2MwWCQtNL0A7mxldRVKogMIwAwDQEApiEAwDQEAJiGAADTEABgGgIATEMAgGkIADANAQCmIQDANAQAmIYAANMQAGCamn+XrHB3zwKI17vCkZ8YAYBpggBgFACWjv7PjgCYCkE8iFTHjwLAT8dzDwZQOnH9iuv7ybsh82+X/oP+/QdcjwpUCHfgFhf/97ZITxIuBAA0Clf839ujeTCCAPFW+A+/l/JkCALES+EDcMBx/wHH+rsUmG/LxAAAAABJRU5ErkJggg==\"},\n {\"FrogBlunderCountdown48.png\",\"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\"},\n {\"FrogBlunderCountdown49.png\",\"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\"},\n {\"FrogBlunderCountdown50.png\",\"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\"},\n {\"FrogBlunderCountdown51.png\",\"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\"},\n {\"FrogBlunderCountdown52.png\",\"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\"},\n {\"FrogBlunderCountdown53.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAIZ0lEQVR4nO2de0iT3x/Hn23OmfdLXsFlqUFNo35d0HI5CrKS/jCli1BifxSZSUEQFP1VYBEVERRUdIOoDKILGVReMktB+nazq0Vl8k1/c5bmvMypPz7+KOaz88zNtqU77xc86M6e59nh2ed9zuecz+ecCQIAAAA+kTly8uCLtEHXVQUA5yGbUW2Xbdt1EgwfeKoQbL4JwweeLgSZI8bvl/JPo7MrBoArMNb+R22PCGT2GD8MH3iKEMQikIsvgPEDT0LceIvtW+7IxQCMR2zZsVxKHTB+4ElY2rOlndvsAQDwdH4LAK0/4LEXQA8AuAYCAFwDAQCugQAA10AAgGsgAMA1EADgGggAcA0EALgGAgBcAwEAroEAANdAAIBrvP52BcY6hw8fDtm0aVPAaK59+PBh79KlS1ucWR+FQiGkp6f75OTk+M6ePVsVHR2tCAgIkBkMhoFPnz6Zy8vLey5fvmyk/535uZ4KBDACSUlJ3sIYYc6cOd7Hjx8P02g0SvF7JAQ65s+fr9q5c2fg6dOnO3fv3v2jt7cXeznZAC7QCCQlJVkZ29+AWvyKiooolvGLUSqVss2bNweUlpZGBAcH4zu2AR6ODWJjY72CgoL++jNKTU1VnTp1Kkwud6wqKSkpqgsXLkx09DqewJMZB63/kSNHQry9vR3axvIXixcv9snNzfVzfq08AwhgjAtg4cKFPsnJyVbjkJ8/fw4UFRW1xcbGNsXExDRlZWXpGxoa+lj3KCwsHNUgngcwCHZwAPz06VNTWlpas+AmVq5c6csqX7duXeu9e/d6fr2+e/du99u3b/vq6uqi/f39h/UWJKDQ0FB5W1vbgDvqPJ5AD2CD5ORkqx7g1atXzFbWVeh0OpW4jAzf0vh/0djYaK6urrYqJ2iGyFV1HM+gB5DAx8dHlpCQYCWA+vp6k+BG1q9fb5g+fbqSjmnTpg0dZWVl3VLnt7S09LPKjUYjpkMZQAASkKFR0EnMy5cv3doDvHjxwkSHvefPmDHDym1rbW0d+PLlCwJjDCAABwfASqVSOHr0aChFY9VqtaKvr2/w27dv/Y8fP+69du1a1/3795kuiDtYvXq136xZs6wEcO7cuc7BQXQALCAAByPA169fj7B8rVKpZImJifLExERlXl6ef3V1dW9BQYHh48ePZne5alOnTlXSVGdBQYHVbA/NDB08eLDdHXUZj2AQ7MAA2B7S0tJUDx48iKKUBMHFFBUVBRoMhtiampqorVu3Bohdtvfv3/etWLFC39nZieZfAghAAo1GM+ocoJCQEHlJSUl4XFycS3vYhIQE5v3J3aFcIK1W2/z161f4/jaAABhERUUpJk6c+EfPhkRw8uTJMOEvCEAmkw1ljBYWFgYGBgbiO7YBHo4DA2BKOaYMy5kzZ/4bGhr6Va1WN+Xl5bU2NDQwW9kFCxaodDqdj+Ai4uPjJd20xMRErz179gRRYIw1MAb/53fEELtDD58CXbVqlV9cXJxi0qRJXpMnT/aiKGtubm7r9+/fraKpAQEB8rKyskhWpub58+c7CwoK2gQXsHz58gnPnz836fX6gYiICPnatWv9du3aFSTOG2pvbx8gd8hdA/Px8pNJ9HNJEICTWLRokc+tW7eGzRARnz9/Nms0mn8FN7Fs2bIJV69eDSc3yJLKysqezMzM/wqcYxQJAC6Qk6iqqurp7u4eZKVUi43Rldy5c6eb8oLE5eSKUc/mtoqMEyAAJ2E2m5lpCDQ16e41BRUVFcxgnFardfnU7HgDgTBGYCk7O9uXfH+1Wk2Hglrxd+/e9eXk5OhHWonFKu/p6RnVPHxMTIxCq9X6xMfHe02ZMmVoLEJ/aSxSU1PTK3Xdjx8/mFmf0dHR+L5F4IGIMJvNg8eOHQulCK9lOQ0yqTXv72fmmgm+vr6yyMhIBcsYRysASmM+c+aM1VTq3LlzVbYEIJX52dXVhXRoEXCBGK5MfX29VcKbv7+/PCcnR3JlVUZGxgQvL+v2pLa2VtJQR0IqCS43N5e5RsByIMwqb2pqYquXYyAABjdv3uxilRcXFweHh4dbta5hYWHyvXv3BkvcSzJ1eSQoye7JkycmVs9AqQ+sa/Lz8/3nzZunYkWHaSZotHXxVCAABpcuXTKaTCYrt4VcnPLy8sjMzMwJ5PLQ4JZ2a6iqqooi/1x8vl6v779y5YpRXN7R0aE2Go3DjsrKyihWXSiTk1VeXFwcsn///hD6XBp7UODrwIEDIeS+sc6n/YJIUFKGwCuIA0iwb9++4O3btwf+ycPNz89vLSkp6WIJQJy4VldXZ9LpdFZLLcmtqq2tjf6TKUxy61JTU7+9fv3arWsZxiKIA9hJcXFxO0VZR/ugKRmNZfyjMd4NGzYY/iSjc9u2bW0wfjZwgSSgJYTZ2dn6N2/eONxqXrx40UhGJzgJGgyvWbNGTztBOCqeHTt2fD979izTjQIQgE3IZ05PT28mP1xq+lO89JBa640bNxqcvQKLglu0G8WjR4/smlV69uyZKSMjo+XEiRM/nVoRDwNxADt6gi1btrQdOnSog5LNKM2YAlO0zQilPjQ3N/dTL3Hjxo2u0tLSblcuPvnw4YN5yZIlLbToJisry5eCZBQso21QOjo6hpZm0q4Qt2/f7qZBr6vq4UlgEAy4AoNgACzAIBhwDQQAuAYCAFwDAQCugQAA10AAgGsgAMA1EADgGggAcA0EALgGAgBcAwEAroEAANfILfdJZKWMAuCpqdD0Fz0A4JphAkAvAHhq/UfsAeAKAU/Alh1bCcBSHSNdDMBYR2y/YvuW3Lje8hdjfuGX8k+jk+sHgEtgNdxi4x8qs3UTlggAGI+wjH+o3J6LIQTgaYb/+31HbgYhAE8xfAAEIAj/A481PnICL5pyAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown54.png\",\"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\"},\n {\"FrogBlunderCountdown55.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAFVElEQVR4nO3dTUhiaxgHcD+vTh+3yb7cZDblIrRL3NVQgtKmoKUS1EZoUdCqNm1atnAXRLSJFrWIyEX0Aa0qyiKCYKKbURFBzL1NRjV1u9mHHzmc4DZ2PJo2NnN83v8PYpijRx4Oz/897zm+qkQCAABskibz5PBf5vDblQKQOtI/VhLq7YSehMYHqkGI+yAaH6gHQZpM82d+/PQ51YUBvAXf2p+6REIgTaT50fhAJQj8EMj4O6D5gRL+4M3vb1kyOwOko3h9LIuVDjQ/UBLZz5F9HvcMAEDdUwAw+gOLZwGcAYBpCAAwDQEApiEAwDQEAJiGAADTEABgGgIATEMAgGkIADANAQCmIQDANAQAmKb41QWIXW9vb25bW1v2a/ZdXl6+r6+vP6FYCxU4A7zAZDL9JhEJMdVCBQLwApPJpJSIhJhqoQIBiKO4uFiRk5MjimMkploowQFNkxFXTLVQggCkSdOJqRZKcBcoyYvOjY0Nv9ls9rJcCyU4A8RRWVkZNepub28HWK+FEgQgBrVaLS0vL49qOo/H42e5FmoQgBgqKiqUcrk8avvW1laA5VqowTVAkhedSqVS0tfXp7FYLGqdTicPBALh4+Pj0Orq6v3ExMTN3NzcHeVaqEEAknzXdXJysjDy/yqVSmowGGQGg0HpcDiyVlZW7tvb288PDg6CFGuhBlOgJC46E2E2m1VLS0va6upqFcVaqEEAYjAaja9ed5ObmytzuVwFer1eQa0WahAAAVqtVp6fn/9Dx4ZrvMHBwTxKtVCEACRx0Xl+fv7Q3d19WVVV9UWj0fyt0+n+cTgcZ/v7+4Jz7JqaGpXValVTqYWip5+LwbdDP7/t2NjYmKnX6+UlJSWK0tJSxe7ubqC5ufns4uLigX8Qs7OzZfPz80VGozGqWUdGRq7b29u/UqiF2k8mcT+XhACkSG1trXpmZubZXRnO4eFh0Gg0fmG1FrEHAFOgFHG73Xe3t7dhoWXM0u/jDHO1iB0CkCLBYFBycnIS4m/n3sH92ev4xVSL2OHWmMC6G5vNlsHNt3U6Hfcn50bOvb29gN1uP413MJVKpeDwend3FzUap1stVCEAPMFgMNzf36/h3lWN3F5YWCjjRtBQKGpgfZSRkSEtKiqKWrBzeXn58NqmE1MtVOF0KDB98Hg8UYvMsrKyZHa7PTPWgayrq3unUESPJ2tra/cUaqEKARAwPT19I7Td6XS+LygoiBpZ8/LyZD09Pe9jvNYtlVooQgAEjI2N+fx+f9RUgZtWLCwsFDU0NLzjphncBaXdbs9wu91a7v48//mnp6eh8fFxH3/71dWVzufzPftbXFzU/opaWIdrAAFHR0ehgYGB/zo7O3/nP/bhwwcFt7YmkYPb1dV18aNzbjHVQhHOADE4nc5/Nzc3X/2Jq6GhoWuXyyU4fUnnWqhBAGLw+Xxhm812urOzk/SnrkZHR30dHR1fKdZCDQIQB/fpKovF4h0eHr6Odcsx0tnZ2UNLS8t5a2vreTgcJlsLJVgLlCBuvt3U1JTJffywrKxModFoZNxyA6/XG+JG5qmpqZvZ2dnb6+vrF7uNuwjmf8Z3fX3db7VavT+7FtZgMRwwzYfFcADf4RoAmIYAANMQAGAaAgBMQwCAaQgAMA0BAKYhAMA0BACYhgAA0xAAYBoCAExDAIBpssjvSRRaMgpAdSk09y/OAMC0ZwHAWQBYGv1fPANgKgQUxOvjqABEpuOlnQHEjt+//P6O+WXxkb8Y87/Mj58+p7g+gDchNHDzm/9xW7wXEQoBQDoSav7H7YnsjCAAtcZ/ejyZF0MQgErjA0hAIvkGl+PsrpBbEi8AAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown56.png\",\"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\"},\n {\"FrogBlunderCountdown57.png\",\"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\"},\n {\"FrogBlunderCountdown58.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAIfElEQVR4nO2deUhU7RfHZ3UbX50ZddL6ZXtSTq8SVC+lOESgIATlYAWBJFQSRdlCSRG0MGZE2YLQQoQRkfRHOWALJGb+0fqmv4yKaOH1lznu6UyONo4vJ37FeO8zq2Ppvd8PDDLP3Hs5zJzvfc45z7mPEgkAAABxIvXn4KH/pg2NnikABA/pn3U++bZPB8HxgVCF4PFDOD4QuhCk/ji/6q+//wm2YQCMBraH8xN9EYHUF+eH4wOhCIErAhn3BDg/EBLcmzfXv2X+nAzAeMSTH8vcqQPOD4SEqz+7+rnHGQAAofNTALj7AzHOApgBgKiBAICogQCAqIEAgKiBAICogQCAqIEAgKiBAICogQCAqIEAgKiBAICogQCAqIEAgKhR/G4DxjrHjx/XbNy48Y9Azn3w4EF/VlaWJZj2qFQqaW5urspgMISlpqaGxMXFyVQqlcxqtTrb2tqcz58/H6iuru67fv36176+Pmxj4wUIwAt6vT5EMkbIy8uLLC4uVkdHR/NmbrVaLaPXrFmzFLm5uREmk0mzc+fOrmvXrtl+j7XjA4RAXtDr9UrJGODIkSOasrIyLcv5WWi1WtnFixdj9u/fHz361o1fIAAPTJ48WeGrw40ma9euVW3ZsiWgMGz37t3RRqMxIvhWCYPf/uOOZcbC3V+pVEoPHTqkHsk1KBySy+XBM0pAQABjXADp6emhOp2O5712u33IZDJ9SUlJaY6NjW3S6/XNBw8e/MJKfCdNmiRfvHhx6C8zehyBJNjPBJiqLGlpaS2/0waisLCwq7y83Prj/YcPHxwlJSVfmpqaHOfPn49hXYeqUqNt73gDM4AH5s2bx5sBXr58+U3yC1Gr1bzd+xwOh6SiooJZ3aHy58DAAG8WoArRaNk4nsGX4oawsDDpzJkzeQJobGwckPxCWltbndwxqVT6/cWCxmUyGe/D1tbWwVEycVwDAbhhzpw5Slbi+OLFi186A9TU1Ni5Y2TXypUrmZUdqvgoFPzItra2lncdAAH4nQArlUrJyZMntfX19RM7OzsnWyyW/9TX1ydQjX7ZsmVhwXaq169ff7t7924fd7y0tFS7a9euqGnTpilotqK/9J7Guceazea+t2/fOoJtmxD4OVViY6zhlJSUaDZv3ux37b2urq5/06ZNHe/evQuaw02cOFFeXV09gdYl/D2XcpbMzExLV1cXL5QS+27RtFM0QiA/EmBfSEtLC71//358MMuOzc3NgwaDwXL79m3eTOCJGzdufM3Ozm6F87sHAnBDcnJywD1AGo1GVlFRETd16tSglZlbWloGCwoKOlk5AYsnT54M7Nu3r7utrQ3JrwcgAAbx8fHy2NjYEX03JIJz587x6vGBsmLFioiGhoYE6gL15fgFCxaEPHv2LGHr1q1RwbJBiEAAfiTAHR0dzr1793anpqY2a7XapsTExP/l5eW1u0swlyxZEuqrw3pi1apVqvLy8lh/+5JCQ0OlJpNJPdJWCiEDATD49OnT4NGjR3tosenRo0f9VEOnMiK1HZSWlvaQw/f39w+RIGjhKT09vcXdAhm1Jo/kB5oyZYrizJkzWpls+E9Fi10HDhzonjt3brNGo2lKSkr6VFRU1G2z2XiLYNu3b4/KysoKH4kdQgVVoCCxdOnSMLPZrOOOf/z40ZGcnNwc6HVPnz6tzc/Pj+SOr1u3rr2iouIrd3zhwoWhd+7c0YWEhAxbDGtsbPy2aNGizxKRY0MVaHSgGYLViEalS3ertt6gBS9WKzPNSiznJx4/ftx/+fJlGyuso8W9gAwRMAiBggT151gslkGWEwf6TEFSUpIyKiqKd+6tW7c8lkPv3bvHrBTNnz9/zDzdNlZANygHWlXNycmJoNg7MTGRXnK6i7958+ab0Whs89a7zxqn1uVAq1Gs8e7ubo+LWu7q/jExMbjhcYAAODgcjiGKu6mC4jqu0+lkdDcfHGSX1SMiIqQTJkyQs5w1UAGwujqJhIQEj0+3kK2s8d7eXjwkzwF3BEYoQwkjdzwyMlJmNBpVEjdkZmaGs5rQHj58GHAPPiukIrxVdCghd7eYFqgtQgUCYFBZWclMMGlHhri4ODkrtHBXa6+srPSrfcGV9+/fO6jUyh1PSUkJWb9+Pa8y9CPOX716NU+oTqdzRGIUKhAAg6tXr9pY4QeFONSUlp2dHU4hDyW3VKWpra2Np25M7vHUhsDalqSnpyfRZrMNe9XU1MRzj6Nwy2w2M8V44sQJ7bFjxzSzZ89WUu5BthUUFPxRVVWl44ZvRF1dnR09QXywDuCGw4cPqwsLC0fURuCuVk8C4D5rQL07BoOB96gl9RM9ffo0ITw8PLBa6v+hjlDqVJWIHBvWAXyjuLj4S0NDQ8BPf124cMHqrlbvD7SQRu0XI7lGWVlZL5yfDUIgN1BLQU5OTturV6/8fgLsypUrtm3btnVKgsTZs2d7i4qKuoaG/C/iUAi2Z8+ermDZIjQgAA98/vx5MCMjo+XSpUtWd+VPV9rb2535+fkdGzZs6AjEWT1x6tSpXgpjfBVkZ2enc8eOHV1kjy+2ixXkAD4yffp0xZo1a1QZGRlhM2bMUNDWg9T6QKVFcsqbN29+raqq6rNarV49358cgPeDSaUSsmH58uXh1PdDi3WUjNvt9u+b49bX19PmuHZq5PPFFrHnABAAEBVIggFwATkAEDUQABA1EAAQNRAAEDUQABA1EAAQNRAAEDUQABA1EAAQNRAAEDUQABA1EAAQNRAAEDUy195oVssoAEJthaa/mAGAqBkmAMwCQEx3f68zAEIhIAQ8+TFPAK7q8HYyAGMdrv9y/dvtZkuu/zb1B6q//v4nyPYBMCqwbtxc5/8+5ukiLBEAMB5hOf/3cV9OhhCA0Bz/5+f+XAxCAEJxfAAkQCL5F0m6c1LTOAAfAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown59.png\",\"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\"},\n {\"FrogBlunderCountdown60.png\",\"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\"},\n {\"FrogBlunderCountdown61.png\",\"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\"},\n {\"FrogBlunderCountdown62.png\",\"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\"},\n {\"FrogBlunderCountdown63.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAI+UlEQVR4nO2deUhUXxTHZ8Zlxn1pUkcySlNpE1s0CzdarIgWy0ikjBoxKpOC/moh/0kL/4gK6o9Ko4VCgojQwHALQ00SEeqPMiqXVFybZtzGGX8co7A3940zOtMv3/t+4KHc9954eXO+7557zrlXiQQAAIA4kVpz8XhT7Lj9ugKA7ZBGVFtk2xZdBMMHQhWC2ZMwfCB0IUitMX63mIYWW3cMAHugq1053xIRSC0xfhg+EIoQuCKQcW+A8QMhwX15c+1bZs3NAMxGzNmxjE8dMH4gJCbb82Q7NzsCACB0fgsAb38gxlEAIwAQNRAAEDUQABA1EAAQNRAAEDUQABA1EAAQNRAAEDUQABA1EAAQNRAAEDUQABA1EAAQNY7/dwdmE4sWLXLcuXOna1JSkktQUJCDv7+/g16vH+/o6DDU1dWNPnr0SFdVVTVszz44ODhIEhISFCkpKa6rVq2Sq1QqBw8PD2lvb6/x8+fPY+Xl5cOPHz/W0e/27IdQ+L0+EuXQ/Pj6+spycnK8Dx065C6TmR80X716NZyZmdnX2tpqcwNcvXq1840bN+YsXbrUydx1JMrbt29rz549OzAyMoK9nHjWCNP6YLhAUxAaGupYU1OjUqvVUxo/ER8frygvL/dfsGCBTUdXeuNXVFQETGX8hJOTk/To0aMeJSUlft7e3viOzYCHY4bQ0FCn0tJS/3nz5jlIrCAwMNDhwYMHSnJXbMHatWvlt27dmmOJACcTExMjv3fvntLa+8QEngwPjo6OEjJiPz+/aVnxihUrnPfv3+8usQFXrlzxcXZ2tmoby19s2LBBkZaW5maLfggRCIAHtVrtsWzZMqa7cffuXW1kZGSHUqlsjY6O7nj69Okg67qMjIwZC4BcquXLlztz23/8+GHMzs7uCwoKagsMDGxLTk7u/vjxo571GVlZWR4z7YdQgQAYSKVSXqPJz8/XHD9+vI+MbWhoaPzdu3f69PT0ntra2hHutStXrnSeO3fujPyg3bt3u7LaDxw40HPnzh1tX1+f8fv378bS0tKhHTt2dGu1WpNJLwmIJvIz6YdQQRiUQXR0tDw4ONjk2bS0tIzl5uZ+57YbjUbJw4cPdeHh4U6dnZ2GXweFR11cXKbluvwiMTFRzm17+fLlMB2s/lVXVw9v2bLFhXuOwqUklpn0RYhAAAw2bdqkYLU/efJkcHR0lBlWLCgo0NJh6y8oPT29d8mSJU50LF68eOIoKysb4ru+q6vLwGrX6XQIhzKAABisWbPG5K1LlJWV2TXJxaKpqWmUDkuvj4iIMJkv9PT0GL9+/YrEGAP4hQzoLctqJ39f8g+zb98+N4o+sSbt4+MYAFhgBOCgUCik5C9z2zUajbG7u9vg7u4uO3LkiPuuXbtcQ0JCHCk8Sf5+XV3dCLlIL1684HVP7NXfsLAwJwp1Hjt2zGTiTpP1/Px8k3kL+AkEwEGpVMr4fGtKLN2/f19Jia7J5xYuXOhIR2pqqltNTc1IRkZG75cvX+zucmRnZ3vm5eV5853/8OGDni8yBH4CF4iDl5eXjK/92bNnflzjZ2Vtq6qqAigEKvkLxXmsdnJ3qBYoLi6u0x41SUICAuAgl8uZYUvKCLu7u0stHUWKiormBgQE2KYWwkoBUB6DKkazsrI8PT098R2bAQ+H+0BsVDdD84hLly75SOxISEiIk7kivvPnz3vV19erWBNj8BMIgINebz7Q8+3bN4Nare6lEgRfX9/W+Pj4zpKSEubEd8+ePa5UUCexE6dOneoLCwtr9/HxaQ0PD2/PyckZ4OYpqJCvuLjYjybs9urHbAYC4KDT6Xizpf39/cb169d30YITyqpSrf3bt29H9+7d211UVDTIGk22bdtmkpW1FSS89vZ2Axl9W1ubgco00tLSerghT5q/XLt2zdde/ZjNQACMpBHfw6KJJd+k8sKFCwOs9nXr1jGTavaCwrBUF8RtT0xMVPDlN8QMBMBhYGDAyBc2fPPmjUnB2+Q6HDq47bRsUvKXqaioYGas4+Li/qoYZwPwCxk0NzfrIyMjTSaOw8PDZuPptC53/vw//z2tpZEjFhRyjYuLU5D/TsV5lGugn+TmUL7BnIhZ7SqVCt83BzwQBuTXswQQFBRk9nm5ublJWaKQTBMqYy4oKJjDbY+KipKbEwArk00MDg6iGpQDXCAGlZWVTBdi+/btvBNaKpEIDg428bHb29unnYjiK4JLS0tjrhH4xdatW5n9pInydPsiVCAABqWlpcOs8mEyLFqczrqHFtDQMkoulZWVvG/qqaD1BDQasUaGEydOMBfs0M4VtJ6B206RIT5hixkIgIFWqzXSAhfWucLCQmVubq43+eW0+wL55VSPc+7cOS/utbRijFUcp9Fo5ut0uj+OysrKANbfo0pOVnteXp4PJdro71M/KPF1+fJln+vXrzPDnbRfEAmKdU7MYF8gHih609jYqJpJKcHVq1c1Z86cGWAJgLtjRH19/WhiYmIn91oaVWpra1UzCWGOjY1RjVLH+/fv/+ly7r8B9gWyEKr+zMzM7DUYDNP23y9evDjjMmQy3sOHD/fOpKLz5MmTfTB+NnCBzPD8+fOhgwcP9tBOaxIrIGNLSUnpttUyRBJTampqN+0EYa14Tp8+3V9YWGjzpZpCAQKYAtryhMofGhoaRi0xOFoXTK4MlSjYOrkVGxvb+fr1a4sm1Y2NjaObN2/uunnz5g9b9kNoIA9gAWT8CQkJnRs3bnShbUqioqKcqdTZ1dV1YlPaT58+jVGExd6b0jY3N48lJSV1xcbGypOTk10pSUbJMkq2aTSaiU16aVeI4uLiIZr02qsfQgKTYCAqMAkGYBKYAwBRAwEAUQMBAFEDAQBRAwEAUQMBAFEDAQBRAwEAUQMBAFEDAQBRAwEAUQMBAFEDAQBR81sA0ohqKatkFAChlkLTT4wAQNT8IQCMAkBMb/8pRwC4QkAImLNjEwFMVsdUNwPwr8O1X6598+5cPN4Ua7Klh1tMQ4uN+weAXWC9uLnGP9Fm7kNYIgBgNsIy/ol2S26GEIDQDP/3eWs+DEIAQjF8ACRAIvkPMH6/3GdVHXwAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown64.png\",\"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\"},\n {\"FrogBlunderCountdown65.png\",\"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\"},\n {\"FrogBlunderCountdown66.png\",\"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\"},\n {\"FrogBlunderCountdown67.png\",\"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\"},\n {\"FrogBlunderCountdown68.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAJRUlEQVR4nO2ceUhU3RvH74zjOpOOk9tUY2WZFPJqgWbxpiKt2J4tf0hSlgptVEZZUmlkK1RSQhAWLVQiVAQWUqJhlJVLQgtom/uujU6OzqgvT/D2szvnztxxrr/fr3ueD1ykM/feDvc+33vOeZbDMAiCIAidSKw5eajy76HR6wqCCIfkr2Jets3rJDR8RKxCMPsjGj4idiFIrDF+eVhZjdAdQ5DRQPdyli8fEUj4GD8aPiIWIbBFIGVfgMaPiAn2x5tt31JrLkaQPxFzdizlUgcaPyImhtvzcDs3OwIgiNj5JQD8+iM0jgI4AiBUgwJAqAYFgFANCgChGhQAQjUoAIRqUAAI1aAAEKpBASBUgwJAqAYFgFANCgChGhQAQjWy/3UH/iSmTp0qW7FihcvChQudNRqNnbe3t53BYBhqbGwcKCkp6b99+7auqKhIP5p9kMvlknXr1skjIyOdgoODHTw9PaVyuVza09Mz2NraOlheXt5fUFDQm5ub+6O3txe3sbHAr/pITIfmRqVSSY8eParctGmTQio1P2g+e/ZMn5CQ0FFbW2tkBCYuLk5x4sQJpZubm8WRu6OjYzA5Obnz7t27OqH7IZYaYagPximQBfz9/WUvXrxQx8fHWzR+IDw83KmgoMB70qRJgo6uJ0+edM/KylLxMf5/RZudnT328OHDbkL2Q2ygAMzg7+9vn5+f7z1hwgQ7ax7quHHj7G7evOlhZ2fVZZzExsbKd+zYMWYk1+7fv98tJibGRZCOiBAUAAcymYwBI/by8hqRFc+cOdMhNjZWYdPbYRjG3t5ecuzYMaUt98jIyHAXSoxiAwXAQXx8/JjAwEB70m/Xrl3rCQ4ObvTw8KgNDQ1tvHfv3g/SeVu2bLFZAPPmzXMkiVCv1w9lZGR8DwoKaoB+BAYGNqSnp38nLXzHjx9vN3fuXEdb+yJGUAAEJBIJs337duKU48yZM9pt27Z1VFVVGcDY3r17Z9i4cWPby5cv+9jnzpo1C7w0Nn16AwMDHUjtu3fv7jx+/Pj36upqI/Tjy5cvxlOnTn3fuXNnhzX3oR10gxIIDQ119PPzM3k2NTU1RvjqstsHBweZW7du6QICAuybmpoG/j3APers7GzVDtxslEqlyfVGo5HJyckhenfA/Xnp0iWVg4PDb9cplUr82BFAARBYsGCBE5dx9ff3E33r2dnZPXAwAtPS0jJIGqHgIAHtUqnU5MeWlpYBofsmBvCrQGD27NnE+fLTp09HNchForCw0OT/hAXt6tWriZ4d8PjAAp4UnxilLv7RoAAITJ8+nbj4hfk+81/m48ePhvz8/F52+/nz51X79u1znTx5sszJyUkCf+Hf0M4+9+HDh71VVVWCB+bEAEaCWYAxtbe3a9jtWq12UK1W1ykUCmliYqJi5cqVLlOmTJHBXBvm+yUlJX0wRXr06JGJsdoKxBUguKbRaKyesoJoFy1a1NzZ2WkylaIRjARbwMPDgzgqNjc3D4SFhTmWl5er09PTleDhgagsLHLh67thwwZ5bm6u55MnTwSPAjc0NAxERkY2P3782Cpx3b9//0d0dHQLGj83OAViwZVqAO0PHjzwgq+xmefJzJkzx7GoqMgHBMIICIwySUlJHaQ1AYnXr1/3p6amdrW2tuLi1wwoABaOjo5E9woEoxQKhYTvKJKTk+Pp4+MjWPh11apVLm/fvlVDFiif80NCQhxKS0vVu3btchWqD2IEBcB+IDwS3vigVqvtIIFNiHutX79efv36dQ++iXDDxZyRkaG0NZVCzKAAWBgMBovz8fj4+HaNRlOnUqlqw8PDm/Ly8ohz8zVr1rhAQp0tL2jixImyixcvqtjChHhEWlpa14wZMxrc3d1rAwIC6lNSUrp0Op1JnGLPnj2uixcvdralH2IFBcBCp9NxektgMRkVFdV8584dHeTb9/X1DZWWlvavXbu2NScnxyQfCIw2OjraJsNLTk52dXFxMZl6JSYmtp8+fVr77ds3I4ihrq5uIDMzU7t06dIWUrAuLS0NRwECKAAWbW1tnAK4cuVKD1ehy5EjR7pI7bYkoUHAi5TKDC5XkuCAV69e9d24ccMkTQIS+7jiGzSDAmDR1dU12NPTM8RlXFwPEvKE4GC3Q9nkSF8O5Ba5urqavCNLsQauiLXQnikxgAIgUF1dTVwIQAqyuYfZ3t5uMnrw9RyR4PIigUjNXcfl9x87diy+bxb4QAjAvJ7UbikSCwXrfETBF67EO/AwmbvOy8uL+F67u7uxSJ4FCoAAV7Bp2bJlnAtaSJHw8/MzmWPX19ePOAcHos+kdksenaioKCeuYNpI+yJWUAAE8vPz9SR34pIlS5y56muhgIaUhVlYWMi5brDE58+fjaQRJCgoyGHr1q0Krnk+pGWQahZIRTu0gwIgAHvsQIEL6berV696QHAJEuGgXhfygGCrktTUVJPdF6BSi7Rg1Wq1vjqd7rejsLDQh33ewMAAZHISvT3nzp1TnT171n3atGn20A9YbCclJY3Jy8vzIkWzi4uL9ZgTZApmg3IABlVRUaEmeWH4cuHCBe3Bgwe7SAJgF6lD7k5kZGQT+1xIrHvz5o3a1soyyAgtLi6mfgTQ4b5A/OffCQkJ7fAVHgmVlZX9ULPL2MjXr1+Nhw4dIsYY+JKVldWNxk8Gp0BmgEKSuLi4Ntj+kLGC9+/fG2JiYlpJ64iRcPny5e6UlJTOoSHrbwc7wx04cKBTiH6IERSABWDLE0h/KCsrI7pG2cXqUBcMU5n6+npBPS6ZmZndMI358OEDr6o0SNXYu3dv5+bNm0c8itEAFsXzAIw/IiKiaf78+c5QiwupxhCkghwd8NJ8+vTJCK5TyBGC7UlG62U9f/68LyQkpDEiIsJp+fLlzrB7ha+vrwyyRPV6/c/NcSsqKmBzXD3sGsEV0Ub+Ay6CEarARTCCDAPXAAjVoAAQqkEBIFSDAkCoBgWAUA0KAKEaFABCNSgAhGpQAAjVoAAQqkEBIFSDAkCoBgWAUM0vAUj+KpaQUkYRRKyp0PAXRwCEan4TAI4CCE1ff4sjAE6FEDFgzo5NBDBcHZYuRpD/d9j2y7Zvzs2Whir/NimoloeV1QjcPwQZFUgfbrbx/2wzdxOSCBDkT4Rk/D/b+VyMQkDEZvi/frfmZigERCyGjyAMwjD/AImS4CDf/ikOAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown69.png\",\"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\"},\n {\"FrogBlunderCountdown70.png\",\"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\"},\n {\"FrogBlunderCountdown71.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAE00lEQVR4nO3dP0gjWRwH8DeJl+xtom6401MQK0WrCEEk6haK1qJGsBQE04h/qjQqgmLKiFVARNJpo42gooWFiwT/LLgKFoKFIt4R7k+yermoMccsZ3YyySUzybzEmff9NMJLMhkyv+978+fNSAgAALCJk/Pm2JePMXqrAqAczvpJUm1LehMKH7QahLQvovBB60Hg5BS/yf75WukVA6DhwW+rlhICTkrxo/BBK0EQh0An/gCKH7RE3HmL61sn58MAapSujnX/lw4UP2iJsJ6FdZ52BADQungA0PsDi6MARgBgGgIATEMAgGkIADANAQCmIQDANAQAmIYAANMQAGAaAgBMQwCAaQgAMA0BAKYVFXoF3pqmpibj3t7eL0otz+12B+fm5oKEov7+ftPy8vJPwjaPxxOampr6i+b3agFGAJXT6XRkbGysuNDroVYIgMo5nc7ihoYGQ6HXQ60QABWz2+1Gt9v9odDroWYIAEWBQCC6srLyQGPZLS0txvX19TKj0Sjr8ZaQCAGgJBKJxBwOR+Dq6upZ6WUPDAyYNzY2yktLS7H9coSzQCKHh4cRk8kk63EwLperZHp6OmFXxOVy/XlycvJIFFRWVqb3eDyW3t7e90oul2UIQI6am5uNk5OTCcW/tbUVXlpauicKKS8v1w8NDZlHR0eLzWYzen0FIQA54HdBfD7fz3q9Pt4WCoVeRkZG/iAKmp+ft3R3d6fs9Z+fn0lRETZjttCb5GB2dvZDVVWVXtQWvLu7i5I8OD09fXQ6nb/n47u0CgHI4Yrx4OCgWdh2cXHxtLi4+JVQFo1GycLCQqijo+O3m5sbxQ+yWYKxMwscx/EFaOH/CvFTD/hdEpo2NzfDMzMzwbOzM0UPsFmFAGShr6/vvdVqTbj6enx8/Mgf/BIKAoHAi9fr/erz+e7Pz8+faHwHqxAAmfgD3omJidJUk94IJePj44oeVMN3OAaQyeFwmGpra38Qtl1eXj7t7OxQ6f2BLgRApuHh4aSZl16v9z4Wwz/QVCMEQAabzWZobGw0iKc8rK6uUpnvA/QhADKnHovbtre3w8Fg8EXRrQJ5gwBIZDAYuK6urh/F7Wtra38rvlUgbxAAiTo7O9+JZ1/y5/x3d3f/obJlIC8QAIl6enqS5uL4/f4IP/dH8a0CeYMASNTe3v5O3La/v4/eX+UQAAlqamqKKisrEya9vY4AVLYK5A0CIEFra2tS7887OjrCfByVw1QICaxWa8KVX97t7W0029OfoVCoWngPwWuY2trafs1meZA9jAAS1NfXJwWAn/qcw+8ObwQCIEFdXV1SAK6vrzEPXwMQgEw/kE5HKioq9Kl2gahtFcgbBCAD/uKX+MYXHqY/aAMCkIHFYkn5G4XDYUz/1ACcBcqAf7CV3OcEZVJSUqLY8g4ODmQ/xwi+wwgATEMAgGkIADANAQCmIQDANAQAmIYAANMQAGAaAgBMQwCAaQgAMA0BAKYhAMA0BACYFg8AZ/0Uv+vjwW+rLtgaAVAirOvXescIAExLCABGAWCp9884AmBXCLQgXR0nBUCYjkwfBnjrxPUrru/kxx38J/blY9JN3yb7Z9x7CqqQquMWF/+3tnQLSRUCADVKVfzf2qV8GEEArRV+/HU5C0MQQCuFD0CAkH8BkXB2ziikJDQAAAAASUVORK5CYII=\"},\n {\"FrogBlunderCountdown72.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAG5ElEQVR4nO3cW0gUbRgH8Jl1dTd3dT100LIILAovNpIIO1IZ1IUYqaCZRHixF4UEEd1UCElBUERlKRHRVVpRdNMBg4RSkKwuRJGMvFA0cz20W35qq+7HEyjrO7M6s7OHdt7/DySadWeH9fnPvKcZQQAAAD6Jan7Z27bTG7pDAQge0d6kqLYV/RIKH/QahAVfROGD3oMgqil+S87nnmAfGEAojLVkr1ESAlFJ8aPwQS9BYENgYN+A4gc9YU/ebH0b1LwZIBotVMcGf+lA8YOe+Nazb50veAUA0Lu5AODsDzxeBXAFAK4hAMA1BAC4hgAA1xAA4BoCAFxDAIBrCABwDQEAriEAwDUEALiGAADXEADgmjHSB/Cv2bp1q6mxsXFFsPZ3+fJl16VLl1xCEO3atct06NCh+JycHNPq1auNNptNnJiY8A4PD8+0t7d7mpubJx4+fDg2NDQ0E8zP1SMEIIpkZ2fHVVdXp2zatCmOfS02NlZMSEgwrF271piXl7eksrIy6c6dO78uXrzo8ng8eJ6TH2gCRYnS0lJLY2NjmlzxyzGbzeLp06cTGxoallutVvyd/cAXEwVyc3PNtbW1qUajMaAmXV1d3VJRVPUQQG4gACHkdDqn6+rqxrTsIy4uTrx+/XpKTExMwPvYt2+fuaSkxKLlOPQKAQiRyclJb2FhobO7u3tKy34KCgriMzMzJad+r9cr3Lx502232/uTkpJ6MzMz+06dOjXidrtlO74nTpxI0HIceoVOMOPDhw+TFotF1eNgzp49m0idTmbb6KdPn/5o/QMVFRXFy22vrKz8ee3aNffs/wcGBqbv3bv3u62tzfP27dsVbJOHOtCpqakGGinSekx6giuARtu2bTOdP39+XvG/evVqnIpR676piHfv3m1mt4+MjMxUV1f/8hfgd+/eTci9lpGRgRMeAwHQwGazGR48eLDUt31OTZCKiooRIQhoSNNisUh6r1Tg1MTy9z6aC5DbHkgnWu/wjWhQVVWVlJGRMa93WlVV5fr+/fu05r+MIAg0uUVNnZUrV8asWrXKSP/Sz5cvX2QL3HdOQG77jx8/gnJceoIABIiGF8vLy62+2zo7Oz13796VbZoEgoJ09erVuXa+Ulu2bJHMFQwODk739fUhAAw0gQJsm9+4cSOZ7WheuHDh59SUpkEfzaizSz/sduqX0MgRzIcABDgyY7fb5xXZx48f/1CRCRE0O2fAbqfCv337dtCuTHqCAKhEHd5z587Z5Ba9CRFkMBiE2traFLnmz6NHj8Y6OjoW7DfwCgFQqbCw0LJ+/fpY321fv371NDQ0ROzsT02xW7dupRQXF0tme6ndf+bMmdHIHNm/D51glU6ePCmZUa2pqfkdqfY1XZFqampSjx49Kil+WgVaXl4+NDo6iskvPxAAFahzyTYxaDy+vr5e03ofLW3++/fvpx4+fFgyWzwzMyM4HI6RpqamyUgcW7RAAFRwOBySs//r16/HXS5X2M+w8fHxYn19/TJaKcq+RiNRDodj+PHjxxEJZjRBAFScbfPz85ew258+ffqfEGZ048uzZ8+Wbd++3cS+Nj4+7j127NjQy5cvIzoiFS0QAIX2799vpqUP7Jn2zZs3sutuQoWO4cWLF8s3b94sGe2htn5RUZGzpaUFzR6FEACF5NrZVGj+lh+HAt3Z9fz582Vyxd/b2zuVn5/v7OrqwnCnCgiAQnv37pW0td+/fx+2sz+t73ny5MlSWoLBvkZrg/Ly8gb7+/ux1EElBECBdevWGdPT0yW3ZIWzqUE3w8stjf727dvUgQMHBunus3Adi55gIkyBHTt2SAqPtLa2ar7hRYnjx49by8rKJOP8NARbUlLiRPEHDlcABex2+7yZ39kZ1kCHP91u9xr2Hl8K0549ewbY36Xlz1euXEmW24/JZBJbW1vTlX7uwYMHB8PZbIsGuAIosHHjRkkAaOmzEAa07shqteKRDiGCACiwYcMGSQB6enpCvu6Z7uE9cuQInuYQQgjAYl+QwSCkpaVJOsDhuLmEnghBzZxQfw7PEAAFE09yD5UKx/KH3NxcycwzBBcCsIjk5GTZ74iWHAgR6HxDcGEUaBH0YCu1zwlaTGJioqL9ZWVl9Qfzc0EKVwDgGgIAXEMAgGsIAHANAQCuIQDANQQAuIYAANcQAOAaAgBcQwCAawgAcA0BAK4hAMC1uQCI9qa5uz7GWrLXROyIAELEt65n6x1XAODavADgKgA8nf0XvQKgKQR6sFAdSwLgm47F3gzwr2Prl61vv4/c8LbtlNz0bcn5HNR7YwFCRe7EzRb/320L7UQuBADRSK74/25X8mYEAfRW+HOvq9kZggB6KXwAAQThfwGnXcuWFbMnAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown73.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAHVElEQVR4nO2cXUgUXRjHZ9fW3bf1ay16XamgTO2DFrIPrHbLKIpuBDMoFgryIqhUCqICkwIpCy+igoSKEm/qpkstilohI8mK8KKiosgPStRNV9fN75fHl5V15uw64365c/4/GHY9OzMeZp7/Oed5znOOIAAAAOATjZKTJ1qsE+GrCgChQ2NplGXbsk6C4QO1CiHgjzB8oHYhaJQYvzH3fWuoKwZAOHA35SyVIwKNHOOH4QO1CEEsAq34Ahg/UBPixlts31olFwMQiwSyY60/dcD4gZrwtWdfOw/YAwCgdqYEgNYf8NgLoAcAXAMBAK6BAADXQACAayAAwDUQAOAaCABwDQQAuAYCAFwDAQCugQAA10AAgGsgAMA186JdgbnGpk2b9A6H499Q3e/y5ct9ly5d6gvV/eLi4oTt27cb9u/fP3/9+vV6s9kcl5iYqOnp6Rn/8ePH6IsXL/4+fPjQTd9D9T/VDAQQQ2zYsCH+1q1bC9asWaMT/0ZCoGPLli36s2fPJt29e3egrKysd2hoCHs5BQBDoBiBWnyHw5HGMn4xOp1Oc+zYscT6+vpFKSkpeMcBwMOJATZv3qy/c+fOAq1W2evKzc3V19bWLlR6HU/gyYSRrq6usQcPHriDvc+1a9dM8fHxirax9LJz506D3W43BlsHtQIBhAkaexcWFnZ9//49KGd027ZthrVr18aLy/v7+8dLS0udS5YsaU9PT28vKCjo+vr16wjrHsXFxYnB1EHNwAkW8ebNmyGj0ahoO5gzZ84kXbhwIUVU9ufdu3fDwb6gffv2zWeVHzp0qPvZs2d/vX8/ffrU8/nz55Hm5mZzQkLCtN6CBJSamqp1Op3jwdZHbaAHCMH4/Pz589OM//Hjxx6KwgghIC8vTy8uI8P3NX4vra2to42NjZJygiJEoaiP2kAPEATJycnampqahRSb9+JyucZLSkqcQog4fPhwz+rVq3V0rFq1avJ4/vy5x9/5nZ2dY6xyt9uNcCgDCCAIKioqUhYvXjytZa2oqOj79esX0whnQ0tLyzAdcs+3WCwSf6G7u3v858+fmBhjgCFQEDPGRUVFCb5lnz59Grl9+3a/ECUOHDhgXLdunUQANTU1AxMT6ABYoAeYBRqNRrh+/bqJPn0pLy/vHR2NbENrMBg0WVlZOgp1Hj9+XBLtochQVVVVyFIx1AYEMMtZWfFQ4+3bt8Pk/AoRpLS0NKmysnKaA+7Lly9fRvLz87sGBgbQ/PsBQyCFkMNbVlaWzEp6EyLMihUrmA0YDXcoCmWz2X63tbVh7B8ACEAhhYWFxszMTJ14mEFxeGGOCICGZpQxWlxcnJSUlIR3HAA8HIWcOHFCMs6urq6OipOZkZHhNzEuMzNzXnl5eTJNjLEcY/A/EIACcnJy4iklWZzyQPn3QhQ4deqUMysrq8NkMrVlZ2d3XLx4sXd4eHiaEilMW1dXtygjIwP+HgMIQAFHjx6VtP5Pnjzx9PX1RSXFoL6+3tPR0TFGRt/e3j5WVVXlstvt3eLeiCbsbty4kRqNOs51IACZUDZmfn7+P+LyR48eDQpzCIpEsfyRvLw8A80iR6dWcxcIQCa7du0yUEvqW0Yxf1ZOTrRxOBzMOtlsNkleEe9gXCiTgoICSVZmU1PTEOX+CGEiPT09zmazGWj8vnz58nnLli2b/KRhzuvXr4f8Xdfb28usk9lsxvsWgQcikx07dhjEZS9fvgxr609pzPfu3VsgLt+4caM+kAD8ZX4ODg4iHVoEhkAy4+0so6IeQAgj/pLg7HY7c42Al71790p8FYIc5VDVTS1AADLYunWrpPUnmpubg17wEgjKKmUtqqGeoaSkhLnK68iRIwmUqCcup8hQQ0PDnPNXog0EIAOLxSKJnlD4cbbhT5fLtdTtdk87Ghoa0ljnUiYnq7yystJ05coVE/kFtAsETXxdvXrVdPPmTWa4k/YLCmWatlqADyCDlStXSgRAqc9CBKitrR2gLE9xCJPSHagX8NcTiKNV586d+xPWisYo6AFkkJ2drWMtPxQiABlvUVFRTzAZnSdPnnR+/PgxIoKNNSCAmR6QViukpaXFsYZAQoQgZ/jgwYNdtBOEUvGcPn36z/3790OyPlmNQAAzQJNf4oUvRKTTH2hyy2q1/n716pWsyNOHDx+G9+zZ01ldXR21FWqxAHyAGTCZTMxGwuPxRDz989u3b6O7d+/utFqtepqYo0kymiyjbVBcLtcEObm0K0RdXZ2HnN5I1y8WmWraJlqsUy/UmPte0b44AMQK7qacpd7vGkujBkMgwDUQAOAaCABwDQQAuAYCAFwDAQCugQAA10AAgGsgAMA1EADgGggAcA0EALgGAgBcAwEArtH6poayUkYBUGsqNH2iBwBcM00A6AUAT63/jD0AhkJADQSyY4kAfNUx08UAzHXE9iu2b+l2B4w1wl6wVhjECqyGW2z8k2WBbsISAQCxCMv4J8vlXAwhALUZ/tTvSm4GIQC1GD4AAhCE/wDTd7UVs5yxNAAAAABJRU5ErkJggg==\"},\n {\"FrogBlunderCountdown74.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAFZUlEQVR4nO3dP0gjWRwH8Mkfs2rOaLLKKZitDGsVxH+seEhsRQISGwsRBLUQK1EL/0LURhFEQY0KqVRQG0EUGwNeIf7Z4hqLgIV/8EDP3WRXc+4ac7yFlZlJLpmYvKyZ9/00woszLyS/77zJy5sJxwEAAJsU0fxz4K8/AvSeCkD8KMx/SqptSf+Ewge5BiHsgyh8kHsQFNEUv/bDx7N4PzEAGu72i99JCYFCSvGj8EEuQRCHQCneAMUPciI+eIvrWxnNxgDJKFwdK/8vHSh+kBN+PfPrPOwIACB3zwHA0R9YHAUwAgDTEABgGgIATEMAgGkIADANAQCmIQDANAQAmIYAANMQAGAaAgBMQwCAaQgAME39q5/Aa1NeXv5md3f393jtb3R01DMyMuLhEmBwcDCru7tbx29bW1u7b2pquklE/8kII4BMlJWVaTo7OwXFD5EhADKQlpammJ+fz1apVL/6qSQdBEAGhoeHs0wmE05nXwABoOj6+tq/vLx8R7MPi8WS2tbWlkGzDzlDACh5eHgI2Gy269PT00dafeh0OuXc3NxbhSKqW7wCD4ZNkYODgwetVhvV7WDIzAuZgRG1fTo+Pv7GUTQxMaHPz8/HiX8MMALEqKKi4k1fX5+g+Le2tnwLCwtfOYqsVmt6Q0ODlmYfLEAAYpCZmal0Op2C2Rev1/vU0dFxy1GUk5OjmpqaMtDsgxUIQAzsdnuW+BTEbrd7rq6u/BxF09PThuzsbMF7t7m56bu9vX2i2a8cIQAxfGPc3Nz8G7/t5OTku8Ph+MJR1NjYqK2trU3jt93c3Dy1t7dTHXXkCgF4ATLrMjk5qRfPvvT3939+fKQ26cMZjUb12NiYXtxOTrnIlCu1jmUMAXiB+vr6dLPZrOG3HR0dfSMffjlKSNgcDochIyND8J4tLS3dbWxs3NPqV+4QgCiRD7y9vb2ZoRa9cRS1t7dnVFVVpfLbLi4u/J2dnZ9o9it3CECUbDab1mQypfDb3G73952dHWpHf9Lf0NCQYKo1EAhwbW1t/5BZJ1r9sgABeMGRWNw2MzPzlRQkDWq1mltcXHxLFrzx22dnZ7+4XK5/qXTKEAQgCsXFxZrS0lKNeMnDysoKtfU+XV1dmSUlJYI+3W7348DAwGdafbIEAYhCa2tr0NF/e3vb5/F4qJyGFBUVaXp6egRr/P1+P9fS0nJzf3+P32yOAwRAIo1Go7BarYL5d2J9fZ3KDExqaqqCnPqkpKQITn3Gx8c9h4eHVNcYseT5xcUPZIRXU1OTtrq6msNvI3P+RqPxgsYHUXKFl8vlyo33fskXZk6nk+o6pWT51Ujyi5EYASSqq6tLF7ft7+8/0JqFUWCNc0IgABJVV1cL5uCJvb09zMIkOQRAgoKCAnVeXp4q1AhA5V2BhEEAJKisrAw6+hP4MJr8cEWYBGazWfDNL3F5eel/6fSn1+t9J76DAwmTxWL5O5Yr087Pz/MNBoPgoIb7AoWHEUCCwsLCoACQpc9StoXXDQGQ4P3790EBODs7o7fuGRIGAYj0AimVXG5urirUKRC1dwUSBgGQcN1vqCl5WssfILEQgAj0en3I18jn82EtjgxgFigCcmOraGdjItHpdHHd309kWQaN/coZRgBgGgIATEMAgGkIADANAQCmIQDANAQAmIYAANMQAGAaAgBMQwCAaQgAMA0BAKYhAMA0Jf8uWaHungUg17vCkb8YAYBpggBgFACWjv4RRwCcCoEchKvjoADw0xFpY4DXTly/4voOvt1BiNul/6T98JHKtawA8RbqwC0u/h9t4XYSKgQAyShU8f9ol7IxggByK/znx6PZGYIAcil8AA447j8to7sUwNiE4QAAAABJRU5ErkJggg==\"},\n {\"FrogBlunderCountdown75.png\",\"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\"},\n {\"FrogBlunderCountdown76.png\",\"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\"},\n {\"FrogBlunderCountdown77.png\",\"iVBORw0KGgoAAAANSUhEUgAAAMAAAABQCAYAAABPunpEAAAD+UlEQVR4nO3cvy/jcRzH8X5bV07vlOSSIxETYerQiBAGErNE6i8wWMRqQQzCbpKIwcZiJgwGhsavwWKQGJqISyR31x5XpfTyldN8fdtrv1/09PN5Px+L5FOtV+T9+n764/utxwMAkMlw88uZ455M6aIAb8cI7TqabUe/xOBD1yIUvJHBh+5FMNwMf6DzKPbWwYBSuI6Gm5yUwHAy/Aw+dCmCvQRe+x0YfujEfvC2z7fXzZ0BFRWaY++/2sHwQyfWebbOecEdANBdtgAc/SFxF2AHgGgUAKJRAIhGASAaBYBoFACiUQCIRgEgGgWAaBQAolEAiEYBIBoFgGgV7x2g3HR0dFRub29/favHm5ubi8/OzsZVz6IrdgCIRgEgGgWAaBSghC4vL+9XVlauPWWgnLKUEwpQIqlUKhOJRC7Pzs7SpfobKmYpN7wLZLO3t5cKBAKuvg5mfHy8Znp6uta29uPw8PBWlyy6Ygd4pa6ursrJyclnA7e+vp5cWlq6kpxFFRTgFYLBoHd5efmLz+fLriUSiYexsbHvkrOohAK8wszMTG1jY6PPtha/uLi4l5xFJRTghcxPaYeHhz9Z105OTu4WFxd/Sc6iGgrwAoZheObn5+vMn1ZTU1M/0+m02CwqogAvMDQ0VB0KhfzWtYODg1vzBafkLCqiAC6ZLzInJiaC+U40k5xFVRTApUgkEmhpaflgXTs9Pb3b3NxMSs6iKgrg0ujo6Gf72sLCwlUmkxGdRVUUwIVwOOxvb2/3208zWF1dvZacRWUUwIWRkZGcI+7GxkYyHo8/SM6iMgrgkN/vNwYGBj7a19fW1n5LzqI6CuBQf39/lXm6gXXNfJ99a2vrRnIW1VEAhwYHB6vta9FoNGWebyM5i+oogEN9fX1V9rWdnZ0b6VlURwEcaG5urmhoaHh2otnTUVdyFh1QAAe6u7tzjrim/f39W8lZdMAVYQ6EQqFnn7aazs/P71/6lmMikWiynrf/NMC9vb3f/ncW6dgBHGhra8sZOvN0Y+lZdEABHGhtbc0ZulgslpaeRQcUoNg/yOv11NfX+/I97ZCcRRcUoAjzAyf7xSam93jOXU5ZdEEBiqirq8v7P0omkxnJWXTBu0BFmF8m5fa7eYqpqamJlUsW6dgBIBoFgGgUAKJRAIhGASAaBYBoFACiUQCIRgEgGgWAaBQAolEAiEYBIBoFgGjZAhih3eyVFtfRcNO7JQJKxDrXT/PODgDRnhWAXQCSjv5FdwCeCkEHheY4pwDWdhS7M1Du7PNrn+/crxj4K3Pck3OhdaDziOtRoYR8B2778D+uFXqQfCUAVJRv+B/XndyZIkC3wc/e7ubBKAJ0GXzAA4/nD/1B4uchw4arAAAAAElFTkSuQmCC\"},\n {\"FrogBlunderCountdown78.png\",\"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\"},\n {\"FrogBlunderCountdown79.png\",\"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\"},\n {\"FrogBlunderCountdown80.png\",\"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\"},\n {\"FrogBlunderCountdown81.png\",\"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\"},\n {\"FrogBlunderCountdown82.png\",\"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\"},\n {\"FrogBlunderCountdown83.png\",\"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\"},\n {\"FrogBlunderCountdown84.png\",\"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\"},\n {\"FrogBlunderCountdown85.png\",\"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\"},\n {\"FrogBlunderCountdown86.png\",\"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\"},\n {\"FrogBlunderCountdown87.png\",\"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\"},\n {\"FrogBlunderCountdown88.png\",\"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\"},\n {\"FrogBlunderCountdown89.png\",\"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\"},\n {\"FrogBlunderCountdown90.png\",\"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\"},\n {\"FrogBlunderCountdown91.png\",\"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\"},\n {\"FrogBlunderCountdown92.png\",\"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\"},\n {\"FrogBlunderCountdown93.png\",\"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\"},\n {\"FrogBlunderCountdown94.png\",\"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\"},\n {\"FrogBlunderCountdown95.png\",\"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\"},\n {\"FrogBlunderCountdown96.png\",\"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\"},\n {\"FrogBlunderCountdown97.png\",\"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\"},\n {\"FrogBlunderCountdown98.png\",\"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\"},\n {\"FrogBlunderCountdown99.png\",\"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\"},\n {\"FrogBlunderCountdown100.png\",\"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\"}\n}\nlocal root=GetLuaModsPath()..\"TensorReactions/\"\nfor _,asset in ipairs(assets) do\n local path=root..asset[1]\n local bytes=decode(asset[2])\n local file=io.open(path,\"rb\")\n local current\n if file then current=file:read(\"*a\");file:close() end\n if current~=bytes then\n  local output,err=io.open(path,\"wb\")\n  assert(output,\"Blunderville image creation failed: \"..path..\": \"..tostring(err))\n  local ok,writeError=output:write(bytes)\n  output:close()\n  assert(ok,\"Blunderville image write failed: \"..tostring(writeError))\n  local verify=assert(io.open(path,\"rb\"))\n  local saved=verify:read(\"*a\");verify:close()\n  assert(saved==bytes,\"Blunderville image verification failed: \"..path)\n end\nend\ndata.blunderImageAssetsReady=true\nself.used=true",
						conditions = 
						{
							
							{
								"87672bef-0561-6534-987f-925f1e1b19ad",
								true,
							},
						},
						endIfUsed = true,
						name = "Generate and Verify Bundled Images",
						uuid = "b762371f-4988-0eb4-90ef-c48629359490",
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
						conditionLua = "return data.blunderImageAssetsReady~=true",
						name = "Images need initialization",
						uuid = "87672bef-0561-6534-987f-925f1e1b19ad",
						version = 3,
					},
				},
			},
			displayPath = "Shared - Stage Detection",
			name = "Assets - Generate Bundled PNGs",
			throttleTime = 1000,
			timeout = 1,
			uuid = "6d34c399-0260-bb57-b08c-35fdf2809107",
			version = 2,
		},
	}, 
	inheritedProfiles = 
	{
	},
}



return tbl