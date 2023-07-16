ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_cartel:confiscatePlayerItem') -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
AddEventHandler('esx_cartel:confiscatePlayerItem', function(target, itemType, itemName, amount) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if itemType == 'item_standard' then
    local label = sourceXPlayer.getInventoryItem(itemName).label
    targetXPlayer.removeInventoryItem(itemName, amount)
    sourceXPlayer.addInventoryItem(itemName, amount)
    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confinv') .. amount .. ' ' .. label .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. _U('confinv') .. amount .. ' ' .. label )
  end

  if itemType == 'item_account' then
    targetXPlayer.removeAccountMoney(itemName, amount)
    sourceXPlayer.addAccountMoney(itemName, amount)
    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confdm') .. amount .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. _U('confdm') .. amount)
  end

  if itemType == 'item_weapon' then
    targetXPlayer.removeWeapon(itemName)
    sourceXPlayer.addWeapon(itemName, amount)
    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confweapon') .. ESX.GetWeaponLabel(itemName) .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. sourceXPlayer.name .. _U('confweapon') .. ESX.GetWeaponLabel(itemName))
  end
end)

RegisterServerEvent('esx_cartel:handcuff') -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
AddEventHandler('esx_cartel:handcuff', function(target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_cartel:handcuff', target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_cartel:drag') -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
AddEventHandler('esx_cartel:drag', function(target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
  local _source = source
  TriggerClientEvent('esx_cartel:drag', target, _source) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_cartel:putInVehicle') -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
AddEventHandler('esx_cartel:putInVehicle', function(target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_cartel:putInVehicle', target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_cartel:OutVehicle') -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
AddEventHandler('esx_cartel:OutVehicle', function(target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
    TriggerClientEvent('esx_cartel:OutVehicle', target) -- Remplacer 'esx_cartel' par le nom du groupe criminel souhaité
end)
