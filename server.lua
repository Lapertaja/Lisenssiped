AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('ajokorttiped:loadLicenses', source, licenses)
	end)
end)


RegisterNetEvent('ajokorttiped:addLicense')
AddEventHandler('ajokorttiped:addLicense', function(type)
	local source = source

	TriggerEvent('esx_license:addLicense', source, type, function()
		TriggerEvent('esx_license:getLicenses', source, function(licenses)
			TriggerClientEvent('ajokorttiped:loadLicenses', source, licenses)
		end)
	end)
end)

if Config.Debug then
	ESX.RegisterCommand('addLicense', 'admin', function(xPlayer, args, showError)
		if not args.type then args.type = 'drive' end
		xPlayer.triggerEvent('esx_license:addLicense', source, args.type)
	end, true, {help = 'Anna lisenssi', arguments = {{name = 'type', help = 'Lisenssin tyyppi', type = 'string'}}
	})
end

ESX.RegisterServerCallback('ajokorttiped:payCar', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.Account == 'cash' then
		if xPlayer.getMoney() >= Config.CarLicensePrice then
			xPlayer.removeMoney(Config.CarLicensePrice, "Ajokortin osto")
			cb(true)
		else
			cb(false)
		end
	else
		if xPlayer.getAccount('bank').money >= Config.CarLicensePrice then
			xPlayer.removeAccountMoney('bank', Config.CarLicensePrice)
			cb(true)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('ajokorttiped:payBike', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.Account == 'cash' then
		if xPlayer.getMoney() >= Config.MotorBikePrice then
			xPlayer.removeMoney(Config.MotorBikePrice, "Ajokortin osto")
			cb(true)
		else
			cb(false)
		end
	else
		if xPlayer.getAccount('bank').money >= Config.MotorBikePrice then
			xPlayer.removeAccountMoney('bank', Config.MotorBikePrice)
			cb(true)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('ajokorttiped:payTruck', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.Account == 'cash' then
		if xPlayer.getMoney() >= Config.TruckLicensePrice then
			xPlayer.removeMoney(Config.TruckLicensePrice, "Ajokortin osto")
			cb(true)
		else
			cb(false)
		end
	else
		if xPlayer.getAccount('bank').money >= Config.TruckLicensePrice then
			xPlayer.removeAccountMoney('bank', Config.TruckLicensePrice)
			cb(true)
		else
			cb(false)
		end
	end
end)