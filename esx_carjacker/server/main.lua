ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_carjacker:confiscatePlayerItem')
AddEventHandler('esx_carjacker:confiscatePlayerItem', function(target, itemType, itemName, amount)
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

RegisterServerEvent('esx_carjacker:handcuff')
AddEventHandler('esx_carjacker:handcuff', function(target)
  TriggerClientEvent('esx_carjacker:handcuff', target)
end)

RegisterServerEvent('esx_carjacker:drag')
AddEventHandler('esx_carjacker:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_carjacker:drag', target, _source)
end)

RegisterServerEvent('esx_carjacker:putInVehicle')
AddEventHandler('esx_carjacker:putInVehicle', function(target)
  TriggerClientEvent('esx_carjacker:putInVehicle', target)
end)

RegisterServerEvent('esx_carjacker:OutVehicle')
AddEventHandler('esx_carjacker:OutVehicle', function(target)
    TriggerClientEvent('esx_carjacker:OutVehicle', target)
end)