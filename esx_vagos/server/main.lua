ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_vagos:confiscatePlayerItem') -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
AddEventHandler('esx_vagos:confiscatePlayerItem', function(target, itemType, itemName, amount) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
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

RegisterServerEvent('esx_vagos:handcuff') -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
AddEventHandler('esx_vagos:handcuff', function(target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_vagos:handcuff', target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_vagos:drag') -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
AddEventHandler('esx_vagos:drag', function(target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
  local _source = source
  TriggerClientEvent('esx_vagos:drag', target, _source) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_vagos:putInVehicle') -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
AddEventHandler('esx_vagos:putInVehicle', function(target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_vagos:putInVehicle', target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_vagos:OutVehicle') -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
AddEventHandler('esx_vagos:OutVehicle', function(target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
    TriggerClientEvent('esx_vagos:OutVehicle', target) -- Remplacer 'esx_vagos' par le nom du groupe criminel souhaité
end)
