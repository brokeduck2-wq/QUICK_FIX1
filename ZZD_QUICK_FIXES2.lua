

-- ZZD_QUICK_FIXES2.lua ------ 👇👆 

----------------------------------
-- 👇 R69: 
-- ANY NEW CHANGES WE MAKE WILL BE CONTAINED WITHIN THESE EMOJI TO KEEP OBVIOUS VISUAL TRACK OF WHAT HAS REMAINED THE SAME.
-------------------------- 👆 


Army_COUNT_R69 = {} 
Entertainer_COUNT_R69 = {}  

LURK_FIXER_FUNC_DONE_ONE_TIME = false

local function fixerFunc2()
  if BWOEvents then
    if BWOEvents.Start and BWOEvents.SpawnGroup and BWOEvents.Entertainer then

      if LURK_FIXER_FUNC_DONE_ONE_TIME == true then
        do return end
      end
      
      -- params: [eid(opt)]
      BWOEvents.Entertainer = function(params)
          local player = getSpecificPlayer(0)
          if not player then return end


          --------------------------
          -- 👇 R69: MAX OF 1 ENTERTAINER SPAWNED EVERY 4 HOURS... MAX 3 PER DAY:
          local totHoursNow = (getGameTime():getHour() + (getGameTime():getDay() * 24))

          if Entertainer_COUNT_R69[getGameTime():getDay()] == nil then
              Entertainer_COUNT_R69[getGameTime():getDay()] = {}
          end

          local totalThisDayR69 = 0
          local totalThisHourR69 = 0

          totalThisDayR69 = (#Entertainer_COUNT_R69[getGameTime():getDay()])
        
          for i = 1, (#Entertainer_COUNT_R69[getGameTime():getDay()]) do
      
              local totHoursThen = Entertainer_COUNT_R69[getGameTime():getDay()][i].hour

              if math.abs(totHoursNow - totHoursThen) <= 4 then
                  totalThisHourR69 = totalThisHourR69 + 1
              end

          end

          if totalThisDayR69 >= 3 or totalThisHourR69 >= 1 then
              do return end
          end

          ---------------------- 👆 



        
          local args = {
              program = "Entertainer",
              size = 1
          }
      
          local spawnPoint = generateSpawnPoint(player:getX(), player:getY(), player:getZ(), ZombRand(28, 35), 1)
          if #spawnPoint == 0 then return end
      
          args.x = spawnPoint[1].x
          args.y = spawnPoint[1].y
          args.z = spawnPoint[1].z
                  
          local icon = "media/ui/concert.png"
          local color = {r=1, g=0.7, b=0.8} -- pink
          local desc = "Entertainment"
      
          local rnd
          if params.eid then
              rnd = params.eid
          else
              if BanditCompatibility.GetGameVersion() >= 42 then
                  rnd = ZombRand(4)
              else
                  rnd = ZombRand(4) --7
              end
          end
      
          rnd = 0
      
          -- rnd = 9
          if rnd == 0 then
              args.cid = Bandit.clanMap.Priest
              args.occupation = "Priest"
              icon = "media/ui/cross.png"
              desc = "Preacher"
          elseif rnd == 1 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "BassPlayer"
          elseif rnd == 2 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "ViolinPlayer"
          elseif rnd == 3 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "SaxPlayer"
          elseif rnd == 4 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "Breakdancer"
          elseif rnd == 5 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "Clown"
          elseif rnd == 6 then
              args.bid = "40b9340b-3310-40e9-b8a2-e925912590b6" -- fixme
              args.occupation = "ClownObese"
          end
      
          local gmd = GetBWOModData()
          local variant = gmd.Variant
          if BWOVariants[variant].playerIsHostile then args.hostileP = true end


          --------------------------
          -- 👇 R69:

          local totHoursNow = (getGameTime():getHour() + (getGameTime():getDay() * 24))
    
          table.insert(Entertainer_COUNT_R69[getGameTime():getDay()], {hour=totHoursNow, count=1})
    
          ---------------------- 👆

        
          sendClientCommand(player, 'Spawner', 'Clan', args)
      
          if SandboxVars.Bandits.General_ArrivalIcon then
              BanditEventMarkerHandler.set(getRandomUUID(), icon, 3600, args.x, args.y, color, desc)
          end
      end

      -- params: [intensity, cid, name]
      BWOEvents.SpawnGroup = function(params)
          local player = getSpecificPlayer(0)
          if not player then return end

          -- 👇 R69: MAX OF 1 Army SPAWNED EVERY HOUR... MAX OF 12 PER DAY:

          local ArmyHereR69 = false
    
          if params then
              if params.name then
                  if tostring(params.name) == "Army" then
                      ArmyHereR69 = true
                  end
              end
          end

          local totHoursNow = (getGameTime():getHour() + (getGameTime():getDay() * 24))
    
          if ArmyHereR69 == true then

              ------------ Army

              local totHoursNow = (getGameTime():getHour() + (getGameTime():getDay() * 24))

              if Army_COUNT_R69[getGameTime():getDay()] == nil then
                  Army_COUNT_R69[getGameTime():getDay()] = {}
              end

              local totalThisDayR69 = 0
              local totalThisHourR69 = 0

              totalThisDayR69 = (#Army_COUNT_R69[getGameTime():getDay()])
          
              for i = 1, (#Army_COUNT_R69[getGameTime():getDay()]) do
          
                  local totHoursThen = Army_COUNT_R69[getGameTime():getDay()][i].hour

                  if math.abs(totHoursNow - totHoursThen) <= 0 then
                      totalThisHourR69 = totalThisHourR69 + 1
                  end

              end

              if totalThisDayR69 >= 12 or totalThisHourR69 >= 1 then
                  do return end
              end

              ------------ Army

          end
                  
          ---------------------- 👆

        
          local density = BWOBuildings.GetDensityScore(player, 120) / 6000
          if density > 2 then density = 2 end
          if density < 0.5 then density = 0.5 end
      
          local occupation = "None"
          local intensity = math.floor(params.intensity * density * SandboxVars.BanditsWeekOne.BanditsPopMultiplier + 0.4)
          if params.name == "Army" then
              intensity = math.floor(params.intensity * density * SandboxVars.BanditsWeekOne.ArmyPopMultiplier + 0.4)
              occupation = "Army"
          end
          if intensity < 1 then return end
      
          local args = {
              cid = params.cid,
              size = intensity,
              occupation = occupation, 
              program = params.program,
              voice = params.voice
          }
      
          local gmd = GetBWOModData()
          local variant = gmd.Variant
          if BWOVariants[variant].playerIsHostile and not params.loyal then args.hostileP = true else args.hostileP = false end
      
          local spawnPoint = generateSpawnPoint(player:getX(), player:getY(), player:getZ(), ZombRand(params.d, params.d+10), 1)
          if #spawnPoint == 0 then return end
      
          local sp = spawnPoint[1]
          args.x = sp.x
          args.y = sp.y
          args.z = sp.z



          ----------------------
          -- 👇 R69:
    
          if ArmyHereR69 == true then

              local totHoursNow = (getGameTime():getHour() + (getGameTime():getDay() * 24))
        
              table.insert(Army_COUNT_R69[getGameTime():getDay()], {hour=totHoursNow, count=1})
        
          end
      
          ---------------------- 👆 
          
        
          sendClientCommand(player, 'Spawner', 'Clan', args)
      
          if SandboxVars.Bandits.General_ArrivalIcon then
              local desc = params.name
              local icon = "media/ui/raid.png"
              local color = {r=1, g=0, b=0} -- red
      
              if params.name == "Army" or params.name == "Veterans" then
                  color = {r=0, g=1, b=0} -- green
              end
      
              BanditEventMarkerHandler.set(getRandomUUID(), icon, 3600, sp.x, sp.y, color, desc)
          end
      end
      
      -- params: []
      BWOEvents.Start = function(params)
          local player = getSpecificPlayer(0)
          if not player then return end


           -- R69: player check if already GOT GIVEN money as this guy:
    
          local playerName = player:getDisplayName()

          local mainR69 = ModData.getOrCreate("mainR69")

          if not mainR69.givenStartMoney then
              mainR69.givenStartMoney = {}
          end
    
          if mainR69.givenStartMoney then
              if mainR69.givenStartMoney[tostring(playerName)] then
                  do return end
              end
          end
      
          local profession = player:getDescriptor():getCharacterProfession()
          local cell = getCell()
          local building = player:getBuilding()
          if building then
              local buildingDef = building:getDef()
              local keyId = buildingDef:getKeyId()
      
              -- register player home
              if params.party then
                  local args = {id=keyId, event="party", x=(buildingDef:getX() + buildingDef:getX2()) / 2, y=(buildingDef:getY() + buildingDef:getY2()) / 2}
                  sendClientCommand(player, 'Commands', 'EventBuildingAdd', args)
              else
                  local args = {id=keyId, event="home", x=(buildingDef:getX() + buildingDef:getX2()) / 2, y=(buildingDef:getY() + buildingDef:getY2()) / 2}
                  sendClientCommand(player, 'Commands', 'EventBuildingAdd', args)
              end
      
              -- generate home key
              local item = BanditCompatibility.InstanceItem("Base.Key1")
              item:setKeyId(keyId)
              item:setName("Home Key")
              player:getInventory():AddItem(item)
      
              -- show home icon
              if SandboxVars.Bandits.General_ArrivalIcon then
                  local x = buildingDef:getX()
                  local y = buildingDef:getY()
                  local x2 = buildingDef:getX2()
                  local y2 = buildingDef:getY2()
      
                  local icon = "media/ui/defend.png"
                  local color = {r=0.5, g=1, b=0.5} -- GREEN
                  local desc = "Home"
                  BanditEventMarkerHandler.set(getRandomUUID(), icon, 604800, (x + x2) / 2, (y + y2) / 2, color, desc)
              end
          end
      
          -- give some starting cash
          for i=1, 25 + ZombRand(60) do


              if mainR69.givenStartMoney[tostring(playerName)] == nil then
                  mainR69.givenStartMoney[tostring(playerName)] = 1
                  ModData.transmit("mainR69")            
              end
          
              local item = BanditCompatibility.InstanceItem("Base.Money")
              player:getInventory():AddItem(item)
          end
          
          -- profession items
          local professionItemTypeList
          local professionSubItemTypeList
          if profession == CharacterProfession.FIRE_OFFICER then
              professionItemTypeList = {"Base.Axe", "Base.Extinguisher"}
          elseif profession == CharacterProfession.PARK_RANGER then
              professionItemTypeList = {"Base.Bag_SurvivorBag"}
          elseif profession == CharacterProfession.MECHANICS then
              professionSubItemTypeList = {"Base.Wrench", "Base.TireIron", "Base.Ratchet", "Base.Jack", "Base.LightBulbBox"}
              professionItemTypeList = {"Base.Toolbox_Mechanic"}
          elseif profession == CharacterProfession.LUMBERJACK then
              professionItemTypeList = {"Base.Woodaxe"}
          elseif profession == CharacterProfession.DOCTOR then
              professionSubItemTypeList = {"Base.Bandage", "Base.Bandage", "Base.Bandage", "Base.Bandage", "Base.AlcoholWipes", "Base.SutureNeedle", "Base.SutureNeedle", "Base.Tweezers"}
              professionItemTypeList = {"Base.Bag_Satchel_Medical"}
          elseif profession == CharacterProfession.POLICE_OFFICER then
              professionItemTypeList = {"Base.Nightstick"}
          elseif profession == CharacterProfession.VETERAN then
              professionItemTypeList = {"Base.HuntingRifle", "Base.308Box"}
          end
          
          if professionItemTypeList then
              for _, professionItemType in pairs(professionItemTypeList) do
                  local professionItem = BanditCompatibility.InstanceItem(professionItemType)
                  if professionSubItemTypeList then
                      local container = professionItem:getItemContainer()
                      for _, professionSubItemType in pairs(professionSubItemTypeList) do
                          local professionSubItem = BanditCompatibility.InstanceItem(professionSubItemType)
                          container:AddItem(professionSubItem)
                      end
                  end
                  player:getInventory():AddItem(professionItem)
              end
          end
      
          -- spawn babe
          if SandboxVars.BanditsWeekOne.StartBabe then
      
              local args = {
                  cid = "a3bd90b9-aa08-44b2-8be3-a6dfcf15f9e1", 
                  program = "Babe",
                  permanent = true,
                  loyal = true,
                  occupation = "Babe",
                  size = 1,
                  x = player:getX() + 1,
                  y = player:getY() + 1,
                  z = player:getZ()
              }
      
              if player:isFemale() then
                  args.cid = "303cd279-a36a-4e4a-b448-ac1ef1c83b7d"
              end
                      
              sendClientCommand(player, 'Spawner', 'Clan', args)
          end
      
          -- spawn vehicle if there is a spot
          if SandboxVars.BanditsWeekOne.StartRide then
              local px = player:getX()
              local py = player:getY()
              local zone
              local distMin = math.huge
              for x = -40, 40 do
                  for y =-40, 40 do
                      local testZone = getVehicleZoneAt(px + x, py + y, 0)
                      if testZone then
                          local zx = testZone:getX()
                          local zy = testZone:getY()
      
                          local dist = BanditUtils.DistTo(px, py, zx, zy)
                          if dist < distMin then
                              zone = testZone
                              distMin = dist
                          end
                      end
                  end
              end
      
              -- check if vehicle is already there
              if zone then
                  local x1 = zone:getX()
                  local y1 = zone:getY()
                  local w = zone:getWidth()
                  local h = zone:getHeight()
                  local x2 = x1 + w
                  local y2 = y1 + h
      
                  local vehicle
                  for x=x1, x2 do
                      for y=y1, y2 do
                          local square = cell:getGridSquare(x, y, 0)
                          if square then
                              local testVehicle = square:getVehicleContainer() 
                              if testVehicle then
                                  vehicle = testVehicle
                              end
                          end
                      end
                  end
      
                  if not vehicle then
                      local sx
                      local sy
                      local dir
                      if w > h then
                          sx = x1 + 3.5
                          sy = y1 + 2
                          dir = "E"
                      else
                          sx = x1 + 2
                          sy = y1 + 3.5
                          dir = "S"
                      end
                      
                      local carType
                      if BWOVehicles.playerCarChoicesOccupation[profession] then
                          carType = BWOCompatibility.GetCarType(BanditUtils.Choice(BWOVehicles.playerCarChoicesOccupation[profession]))
                      else
                          carType = BWOCompatibility.GetCarType(BanditUtils.Choice(BWOVehicles.playerCarChoicesDefault))
                      end
      
                      vehicle = spawnVehicle(sx, sy, 0, BWOCompatibility.GetCarType(carType))
                      if vehicle then
                          if dir == "S" then
                              vehicle:setAngles(0, 0, 0)
                          elseif dir == "E" then
                              vehicle:setAngles(0, 90, 0)
                          end
                      end
                  end
      
                  if vehicle then
                      local key = vehicle:getCurrentKey()
                      if not key then 
                          key = vehicle:createVehicleKey()
                      end
      
                      local inventory = player:getInventory()
                      player:getInventory():AddItem(key)
                  end
              end
          end
          BWOScheduler.Add("Say", {txt="TIP: Press \"T\" to chat with other people."}, 16000)
          BWOScheduler.Add("Say", {txt="TIP: Press \"T\" to chat with other people."}, 32000)
          -- BWOScheduler.Add("Say", {txt="TIP: Press \"T\" to chat with other people."}, 41000)
      end
      
    end
  end

      LURK_FIXER_FUNC_DONE_ONE_TIME = true
end



local onTickZZD = function(numTicksInZZD) 
    if numTicksInZZD % 2 == 0 or numTicksInZZD % 2 ~= 0 then
    
        -- fixerFunc2 is just a safety measure that's a wrapper/intercept on some BWOEVents global functions within "Week One". It's just here to DOUBLY Make sure that certain BWOEvents functions that get called dont create TOO MANY npcs of certain types like priests or army to doubly ensure that each player only gets their starting stuff (like money, items and vehicle) ONCE per character:
    
        fixerFunc2()
    end
end
Events.OnTick.Add(onTickZZD)