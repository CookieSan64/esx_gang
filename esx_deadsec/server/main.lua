ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_deadsec:confiscatePlayerItem') -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
AddEventHandler('esx_deadsec:confiscatePlayerItem', function(target, itemType, itemName, amount) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
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

RegisterServerEvent('esx_deadsec:handcuff') -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
AddEventHandler('esx_deadsec:handcuff', function(target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_deadsec:handcuff', target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_deadsec:drag') -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
AddEventHandler('esx_deadsec:drag', function(target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
  local _source = source
  TriggerClientEvent('esx_deadsec:drag', target, _source) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_deadsec:putInVehicle') -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
AddEventHandler('esx_deadsec:putInVehicle', function(target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
  TriggerClientEvent('esx_deadsec:putInVehicle', target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
end)

RegisterServerEvent('esx_deadsec:OutVehicle') -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
AddEventHandler('esx_deadsec:OutVehicle', function(target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
    TriggerClientEvent('esx_deadsec:OutVehicle', target) -- Remplacer 'esx_deadsec' par le nom du groupe criminel souhaité
end)
