ESX = exports["es_extended"]:getSharedObject()

local Licenses = {}

Citizen.CreateThread(function()
    -- OX targetin asetukset
    local options = {
        {
            name = 'pedmnu',
            label = Config.PedTitle,
            icon = Config.PedIcon,
            onSelect = function()
                luoMenu()
                lib.showContext('lisenssimenu')
            end
        }
    }

    local pedh = GetHashKey(Config.Ped.Name)
    RequestModel(pedh)

    -- Odotetaan, että pedi latautuu
    while not HasModelLoaded(pedh) do
        Wait(1)
    end
    
    -- Pedin luonti
    ped = CreatePed(1, pedh, Config.Ped.Pos.x, Config.Ped.Pos.y, Config.Ped.Pos.z, Config.Ped.Pos.h, false, true)
    -- Pedin asetukset
    SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedDiesWhenInjured(ped, false)
	SetPedCanPlayAmbientAnims(ped, true)
	SetPedCanRagdollFromPlayerImpact(ped, false)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)

    -- OX targetin laitto pediin
    exports.ox_target:addModel(pedh, options)
end)


RegisterNetEvent('ajokorttiped:loadLicenses')
AddEventHandler('ajokorttiped:loadLicenses', function(licenses)
	Licenses = licenses
end)

function luoMenu()
    local ownedLicenses = {}
    
    for i=1, #Licenses, 1 do
        ownedLicenses[Licenses[i].type] = true
    end

    lib.registerContext({
        id = 'lisenssimenu',
        title = Config.MenuTitle,
        options = {
            {
                title = Config.DriveLicense,
                description = Config.DriveLicenseDesc,
                icon = 'fa-solid fa-address-card',
                onSelect = function()
                    if not ownedLicenses['drive'] then
                        ESX.TriggerServerCallback('ajokorttiped:payCar', function(canPay)
                            if canPay then
                                TriggerServerEvent('ajokorttiped:addLicense', 'drive')
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.LicenseGived,
                                        duration = 5000,
                                        type = 'success'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.LicenseGived, 'success', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.LicenseGived, 5000, 'success', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('success', Config.LicenseGived)
                                else
                                    ESX.ShowNotification(Config.LicenseGived, 'success', 5000)
                                end
                            else
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.NoMoney,
                                        duration = 5000,
                                        type = 'error'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.NoMoney, 5000, 'error', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('error', Config.NoMoney)
                                else
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                end
                            end
                        end)
                    else
                        if Config.NotifyType == 'ox' then
                            lib.notify({
                                title = Config.AlreadyLicense,
                                duration = 5000,
                                type = 'error'
                            })
                        elseif Config.NotifyType == 'esx' then
                            ESX.ShowNotification(Config.AlreadyLicense, 'error', 5000)
                        elseif Config.NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.okokTitle, Config.AlreadyLicense, 5000, 'error', false)
                        elseif Config.NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('error', Config.AlreadyLicense)
                        else
                            ESX.ShowNotification(Config.AlreadyLicense, 'error', 5000)
                        end
                    end
                end
            },
            {
                title = Config.MotorBikeLicense,
                description = Config.MBLicenseDesc,
                icon = 'fa-solid fa-address-card',
                onSelect = function()
                    if not ownedLicenses['drive_bike'] then
                        ESX.TriggerServerCallback('ajokorttiped:payBike', function(canPay)
                            if canPay then
                                TriggerServerEvent('ajokorttiped:addLicense', 'drive_bike')
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.MBLicenseGived,
                                        duration = 5000,
                                        type = 'success'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.MBLicenseGived, 'success', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.MBLicenseGived, 5000, 'success', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('success', Config.MBLicenseGived)
                                else
                                    ESX.ShowNotification(Config.MBLicenseGived, 'success', 5000)
                                end
                            else
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.NoMoney,
                                        duration = 5000,
                                        type = 'error'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.NoMoney, 5000, 'error', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('error', Config.NoMoney)
                                else
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                end
                            end
                        end)
                    else
                        if Config.NotifyType == 'ox' then
                            lib.notify({
                                title = Config.AlreadyMBLicense,
                                duration = 5000,
                                type = 'error'
                            })
                        elseif Config.NotifyType == 'esx' then
                            ESX.ShowNotification(Config.AlreadyMBLicense, 'error', 5000)
                        elseif Config.NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.okokTitle, Config.AlreadyMBLicense, 5000, 'error', false)
                        elseif Config.NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('error', Config.AlreadyMBLicense)
                        else
                            ESX.ShowNotification(Config.AlreadyMBLicense, 'error', 5000)
                        end
                    end
                end
            },
            {
                title = Config.TruckLicense,
                description = Config.TruckLicenseDesc,
                icon = 'fa-solid fa-address-card',
                onSelect = function()
                    if not ownedLicenses['drive_truck'] then
                        ESX.TriggerServerCallback('ajokorttiped:payTruck', function(canPay)
                            if canPay then
                                TriggerServerEvent('ajokorttiped:addLicense', 'drive_truck')
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.TruckLicenseGived,
                                        duration = 5000,
                                        type = 'success'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.TruckLicenseGived, 'success', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.TruckLicenseGived, 5000, 'success', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('success', Config.TruckLicenseGived)
                                else
                                    ESX.ShowNotification(Config.TruckLicenseGived, 'success', 5000)
                                end
                            else
                                if Config.NotifyType == 'ox' then
                                    lib.notify({
                                        title = Config.NoMoney,
                                        duration = 5000,
                                        type = 'error'
                                    })
                                elseif Config.NotifyType == 'esx' then
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                elseif Config.NotifyType == 'okok' then
                                    exports['okokNotify']:Alert(Config.okokTitle, Config.NoMoney, 5000, 'error', false)
                                elseif Config.NotifyType == 'mythic' then
                                    exports['mythic_notify']:DoHudText('error', Config.NoMoney)
                                else
                                    ESX.ShowNotification(Config.NoMoney, 'error', 5000)
                                end
                            end
                        end)
                    else
                        if Config.NotifyType == 'ox' then
                            lib.notify({
                                title = Config.AlreadyTruckLicense,
                                duration = 5000,
                                type = 'error'
                            })
                        elseif Config.NotifyType == 'esx' then
                            ESX.ShowNotification(Config.AlreadyTruckLicense, 'error', 5000)
                        elseif Config.NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.okokTitle, Config.AlreadyTruckLicense, 5000, 'error', false)
                        elseif Config.NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('error', Config.AlreadyTruckLicense)
                        else
                            ESX.ShowNotification(Config.AlreadyTruckLicense, 'error', 5000)
                        end
                    end
                end
            }
        }
    })
end