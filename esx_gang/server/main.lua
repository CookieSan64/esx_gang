ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_gang:confiscatePlayerItem') -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
AddEventHandler('esx_gang:confiscatePlayerItem', function(target, itemType, itemName, amount) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
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

RegisterServerEvent('esx_gang:handcuff') -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
AddEventHandler('esx_gang:handcuff', function(target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_gang:handcuff', target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_gang:drag') -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
AddEventHandler('esx_gang:drag', function(target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
  local _source = source
  TriggerClientEvent('esx_gang:drag', target, _source) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_gang:putInVehicle') -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
AddEventHandler('esx_gang:putInVehicle', function(target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_gang:putInVehicle', target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_gang:OutVehicle') -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
AddEventHandler('esx_gang:OutVehicle', function(target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
    TriggerClientEvent('esx_gang:OutVehicle', target) -- Remplacer 'esx_gang' par le nom du groupe criminel souhaité
end)
