--[[
░█████╗░██████╗░███╗░░██╗██╗███████╗
██╔══██╗██╔══██╗████╗░██║██║██╔════╝
███████║██████╔╝██╔██╗██║██║█████╗░░
██╔══██║██╔══██╗██║╚████║██║██╔══╝░░
██║░░██║██║░░██║██║░╚███║██║███████╗
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚══════╝
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Arnie_drugrun")

RegisterServerEvent('Betaling')
AddEventHandler('Betaling', function()
    local source = source
    local user_id = vRP.getUserId({source})
    vRP.giveBankMoney({user_id,75000})
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har modtaget 75000 kr for bilen', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
end)