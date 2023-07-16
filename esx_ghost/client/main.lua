local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function OpenVehicleSpawnerMenu(station, partNum)
  local vehicles = Config.GhostStations[station].Vehicles
  ESX.UI.Menu.CloseAll()
  if Config.EnableSocietyOwnedVehicles then
    local elements = {}
    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)
      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end
      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)
          menu.close()
          local vehicleProps = data.current.value
          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
          end)
          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ghost', vehicleProps) -- Remplace 'ghost' par le nom de ton groupe criminel
        end,
        function(data, menu)
          menu.close()
          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}
        end
      )
    end, 'ghost') -- Remplace 'ghost' par le nom de ton groupe criminel
  else
    local elements = {}
    for i=1, #Config.GhostStations[station].AuthorizedVehicles, 1 do
      local vehicle = Config.GhostStations[station].AuthorizedVehicles[i]
      table.insert(elements, {label = vehicle.label, value = vehicle.name})
    end
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        menu.close()
        local model = data.current.value
        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)
        if not DoesEntityExist(vehicle) then
          local playerPed = GetPlayerPed(-1)
          if Config.MaxInService == -1 then
            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
              SetVehicleMaxMods(vehicle)
            end)
          else
            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
              if canTakeService then
                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  SetVehicleMaxMods(vehicle)
                end)
              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end
            end, 'ghost') -- Remplace 'ghost' par le nom de ton groupe criminel
          end
        else
          ESX.ShowNotification(_U('vehicle_out'))
        end
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {station = station, partNum = partNum}
      end
    )
  end
end

function OpenGhostActionsMenu()
  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'ghost_actions',
    {
      title    = 'Gang', -- Remplace 'Gang' par le nom de ton groupe criminel
      align    = 'top-left',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
      },
    },
    function(data, menu)
      if data.current.value == 'citizen_interaction' then
        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('search'),          value = 'body_search'},
              {label = _U('handcuff'),        value = 'handcuff'},
              {label = _U('drag'),            value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'}
            },
          },
          function(data2, menu2)
            local player, distance = ESX.Game.GetClosestPlayer()
            if distance ~= -1 and distance <= 3.0 then
              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end
              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_ghost:handcuff', GetPlayerServerId(player)) -- Remplace 'esx_ghost' par le nom de ton script
              end
              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_ghost:drag', GetPlayerServerId(player)) -- Remplace 'esx_ghost' par le nom de ton script
              end
              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_ghost:putInVehicle', GetPlayerServerId(player)) -- Remplace 'esx_ghost' par le nom de ton script
              end
              if data2.current.value == 'out_the_vehicle' then
                TriggerServerEvent('esx_ghost:OutVehicle', GetPlayerServerId(player)) -- Remplace 'esx_ghost' par le nom de ton script
              end
            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end

      if data.current.value == 'vehicle_interaction' then
        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('pick_lock'),    value = 'hijack_vehicle'},
            },
          },
          function(data2, menu2)
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
            if DoesEntityExist(vehicle) then
              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
              if data2.current.value == 'hijack_vehicle' then
                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)
                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
                  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
                  if DoesEntityExist(vehicle) then
                    Citizen.CreateThread(function()
                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                      Wait(20000)
                      ClearPedTasksImmediately(playerPed)
                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))
                    end)
                  end
                end
              end
            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

function OpenBodySearchMenu(player)
  ESX.TriggerServerCallback('esx_ghost:getOtherPlayerData', function(data) -- Remplace 'esx_ghost' par le nom de ton script
    local elements = {}
    local blackMoney = 0
    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end
    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Armes ---', value = nil})
    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})
    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then
          TriggerServerEvent('esx_ghost:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount) -- Remplace 'esx_ghost' par le nom de ton script
          OpenBodySearchMenu(player)
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end, GetPlayerServerId(player))
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
  PlayerData.job2 = job2
end)

AddEventHandler('esx_ghost:hasEnteredMarker', function(station, part, partNum) -- Remplace 'esx_ghost' par le nom de ton script

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'VehicleDeleter' then
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed,  false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end
    end
  end
end)

AddEventHandler('esx_ghost:hasExitedMarker', function(station, part, partNum) -- Remplace 'esx_ghost' par le nom de ton script
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_ghost:hasEnteredEntityZone', function(entity) -- Remplace 'esx_ghost' par le nom de ton script
  local playerPed = GetPlayerPed(-1)
  if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ghost' and not IsPedInAnyVehicle(playerPed, false) then -- Remplace 'ghost' par le nom de ton groupe criminel
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = {entity = entity}
  end
  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed,  false) then
      local vehicle = GetVehiclePedIsIn(playerPed)
      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end
    end
  end
end)

AddEventHandler('esx_ghost:hasExitedEntityZone', function(entity) -- Remplace 'esx_ghost' par le nom de ton script
  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end
end)

RegisterNetEvent('esx_ghost:handcuff') -- Remplace 'esx_ghost' par le nom de ton script
AddEventHandler('esx_ghost:handcuff', function() -- Remplace 'esx_ghost' par le nom de ton script
  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)
  Citizen.CreateThread(function()
    if IsHandcuffed then
      RequestAnimDict('mp_arresting')
      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
    else
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
    end
  end)
end)

RegisterNetEvent('esx_ghost:drag') -- Remplace 'esx_ghost' par le nom de ton script
AddEventHandler('esx_ghost:drag', function(cop) -- Remplace 'esx_ghost' par le nom de ton script
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_ghost:putInVehicle') -- Remplace 'esx_ghost' par le nom de ton script
AddEventHandler('esx_ghost:putInVehicle', function() -- Remplace 'esx_ghost' par le nom de ton script

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
    if DoesEntityExist(vehicle) then
      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil
      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end
      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end
    end
  end
end)

RegisterNetEvent('esx_ghost:OutVehicle') -- Remplace 'esx_ghost' par le nom de ton script
AddEventHandler('esx_ghost:OutVehicle', function(t) -- Remplace 'esx_ghost' par le nom de ton script
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2
  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ghost' then -- Remplace 'ghost' par le nom de ton groupe criminel
      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)
      for k,v in pairs(Config.GhostStations) do
        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end
        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'ghost' then -- Remplace 'ghost' par le nom de ton groupe criminel
      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil
      for k,v in pairs(Config.GhostStations) do
        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end
        end
        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end
      end

      local hasExited = false
      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_ghost:hasExitedMarker', LastStation, LastPart, LastPartNum) -- Remplace 'esx_ghost' par le nom de ton script
          hasExited = true
        end
        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_ghost:hasEnteredMarker', currentStation, currentPart, currentPartNum) -- Remplace 'esx_ghost' par le nom de ton script
      end
      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_ghost:hasExitedMarker', LastStation, LastPart, LastPartNum) -- Remplace 'esx_ghost' par le nom de ton script
      end
    end
  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a'
	}

	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local closestDistance = -1
		local closestEntity   = nil
		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end
		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_ghost:hasEnteredEntityZone', closestEntity) -- Remplace 'esx_ghost' par le nom de ton script
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_ghost:hasExitedEntityZone', LastEntity) -- Remplace 'esx_ghost' par le nom de ton script
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlPressed(0,  Keys['E']) and PlayerData.job2 ~= nil and PlayerData.job2.name == 'ghost' and (GetGameTimer() - GUI.Time) > 150 then
        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end
        if CurrentAction == 'delete_vehicle' then
          if Config.EnableSocietyOwnedVehicles then
            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'ghost', vehicleProps)
          else
            if GetEntityModel(vehicle) == GetHashKey('tribike') then
              TriggerServerEvent('esx_service:disableService', 'ghost')
            end
          end
          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' then
          ESX.UI.Menu.CloseAll()
          TriggerEvent('esx_society:openBossMenu', 'ghost', function(data, menu)
            menu.close()
            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}
          end)
        end
        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end
        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end
   if IsControlPressed(0,  Keys['F9']) and PlayerData.job2 ~= nil and PlayerData.job2.name == 'ghost' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'ghost_actions') and (GetGameTimer() - GUI.Time) > 150 then
     OpenGhostActionsMenu() -- Remplace 'OpenGhostActionsMenu' par la fonction qui ouvre le menu des actions du gang
     GUI.Time = GetGameTimer()
    end
  end
end)

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:openMenuGang')
AddEventHandler('NB:openMenuGang', function()
	OpenGhostActionsMenu() -- Remplace 'OpenGhostActionsMenu' par la fonction qui ouvre le menu des actions du gang
end)