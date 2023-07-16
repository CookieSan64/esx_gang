ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_families:confiscatePlayerItem') -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
AddEventHandler('esx_families:confiscatePlayerItem', function(target, itemType, itemName, amount) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
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

RegisterServerEvent('esx_families:handcuff') -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
AddEventHandler('esx_families:handcuff', function(target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_families:handcuff', target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_families:drag') -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
AddEventHandler('esx_families:drag', function(target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
  local _source = source
  TriggerClientEvent('esx_families:drag', target, _source) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_families:putInVehicle') -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
AddEventHandler('esx_families:putInVehicle', function(target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_families:putInVehicle', target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_families:OutVehicle') -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
AddEventHandler('esx_families:OutVehicle', function(target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
    TriggerClientEvent('esx_families:OutVehicle', target) -- Remplacer 'esx_families' par le nom du groupe criminel souhaité
end)
