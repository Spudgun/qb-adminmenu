-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local frozen = false
local permissions = {
    ['menu_get_dealers'] = {'admin'},
    ['menu_get_players'] = {'admin'},
    ['menu_get_rank'] = {'god'},
    ['admin_toggle_blips'] = {'admin'},
    ['admin_toggle_names'] = {'admin'},
    ['admin_toggle_coords'] = {'admin'},
    ['admin_kill'] = {'admin'},
    ['player_ban'] = {'admin'},
    ['noclip'] = {'admin'},
    ['kickall'] = {'admin'},
    ['kick'] = {'admin'},
    ['show_blips'] = {'admin'},
    ['revive'] = {'admin'},
    ['freeze'] = {'admin'},
    ['teleport_to_player'] = {'admin'},
    ['teleport_into_veh'] = {'admin'},
    ['bring_player'] = {'admin'},
    ['view_inventory'] = {'admin'},
    ['open_clothing'] = {'admin'},
    ['set_perms'] = {'god'},
    ['send_report'] = {'admin'},
    ['staff_chat'] = {'admin'},
    ['give_weapon'] = {'admin'},
    ['veh_save'] = {'admin'},
    ['veh_max_mods'] = {'admin'},
}
local players = {}

-- Functions
local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

local function hasPermissions(source, perms)
    if QBCore.Functions.HasPermission(source, perms) or IsPlayerAceAllowed(source, 'command') then
        return true
    end
    TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_permissions"), 'error', 5000)
    return false
end

-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(source, cb)
    local src = source
    if hasPermissions(src, permissions['menu_get_dealers']) then
        cb(exports['qb-drugs']:GetDealers())
    end
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local src = source
    if hasPermissions(src, permissions['menu_get_players']) then
        cb(players)
    end
end)

-- Get Ranks
QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    local src = source
    if hasPermissions(src, permissions['menu_get_rank']) then
        cb(true)
    else
        cb(false)
    end
end)


-- Events
RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    if hasPermissions(source, permissions['show_blips']) then
        TriggerClientEvent('qb-admin:client:Show', source, players)
    end
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    if hasPermissions(source, permissions['admin_kill']) then
        TriggerClientEvent('hospital:client:KillPlayer', player.id)
    end
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    if hasPermissions(source, permissions['revive']) then
        TriggerClientEvent('hospital:client:Revive', player.id)
    end
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    if hasPermissions(source, permissions['kick']) then
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(source), reason), true)
        DropPlayer(player.id, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. QBCore.Config.Server.Discord)
    end
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    if hasPermissions(source, permissions['player_ban']) then
        time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            QBCore.Functions.GetIdentifier(player.id, 'license'),
            QBCore.Functions.GetIdentifier(player.id, 'discord'),
            QBCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(source)
        })
        TriggerClientEvent('chat:addMessage', -1, {
            template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
            args = {GetPlayerName(player.id), reason}
        })
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(source), reason), true)
        if banTime >= 2147483647 then
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.Discord)
        else
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.Discord)
        end
    end
end)

RegisterNetEvent('qb-admin:server:spectate', function(player)
    if hasPermissions(source, permissions['spectate']) then
        local targetped = GetPlayerPed(player.id)
        local coords = GetEntityCoords(targetped)
        TriggerClientEvent('qb-admin:client:spectate', source, player.id, coords)
    end
end)

RegisterNetEvent('qb-admin:server:freeze', function(player)
    if hasPermissions(source, permissions['freeze']) then
        local target = GetPlayerPed(player.id)
        if not frozen then
            frozen = true
            FreezeEntityPosition(target, true)
        else
            frozen = false
            FreezeEntityPosition(target, false)
        end
    end
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    if hasPermissions(source, permissions['teleport_to_player']) then
        local admin = GetPlayerPed(source)
        local coords = GetEntityCoords(GetPlayerPed(player.id))
        SetEntityCoords(admin, coords)
    end
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    if hasPermissions(source, permissions['teleport_into_veh']) then
        local admin = GetPlayerPed(source)
        -- local coords = GetEntityCoords(GetPlayerPed(player.id))
        local targetPed = GetPlayerPed(player.id)
        local vehicle = GetVehiclePedIsIn(targetPed,false)
        local seat = -1
        if vehicle ~= 0 then
            for i=0,8,1 do
                if GetPedInVehicleSeat(vehicle,i) == 0 then
                    seat = i
                    break
                end
            end
            if seat ~= -1 then
                SetPedIntoVehicle(admin,vehicle,seat)
                TriggerClientEvent('QBCore:Notify', source, Lang:t("sucess.entered_vehicle"), 'success', 5000)
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_free_seats"), 'danger', 5000)
            end
        end
    end
end)


RegisterNetEvent('qb-admin:server:bring', function(player)
    if hasPermissions(source, permissions['bring_player']) then
        local admin = GetPlayerPed(source)
        local coords = GetEntityCoords(admin)
        local target = GetPlayerPed(player.id)
        SetEntityCoords(target, coords)
    end
end)

RegisterNetEvent('qb-admin:server:inventory', function(player)
    if hasPermissions(source, permissions['view_inventory']) then
        TriggerClientEvent('qb-admin:client:inventory', source, player.id)
    end
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    if hasPermissions(source, permissions['open_clothing']) then
        TriggerClientEvent('qb-clothing:client:openMenu', player.id)
    end
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    if hasPermissions(source, permissions['set_perms']) then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.rank_level")..group[1].label)
    end
end)

RegisterNetEvent('qb-admin:server:SendReport', function(name, targetsource, msg)
    if hasPermissions(source, permissions['send_report']) then
        if QBCore.Functions.IsOptin(source) then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.admin_report")..name..' ('..targetsource..')', msg}
            })
        end
    end
end)

RegisterNetEvent('qb-admin:server:Staffchat:addMessage', function(name, msg)
    if hasPermissions(source, permissions['staff_chat']) then
        if QBCore.Functions.IsOptin(source) then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.staffchat")..name, msg}
            })
        end
    end
end)

RegisterServerEvent('qb-admin:giveWeapon', function(weapon)
    if hasPermissions(source, permissions['give_weapon']) then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(weapon, 1)
    end
end)

RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, _, plate)
    if hasPermissions(source, permissions['veh_save']) then
        local Player = QBCore.Functions.GetPlayer(source)
        local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result[1] == nil then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                vehicle.model,
                vehicle.hash,
                json.encode(mods),
                plate,
                0
            })
            TriggerClientEvent('QBCore:Notify', source, Lang:t("success.success_vehicle_owner"), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_vehicle_owner"), 'error', 3000)
        end
    end
end)

-- Commands
QBCore.Commands.Add('maxmods', Lang:t("desc.max_mod_desc"), {}, false, function(source)
    TriggerClientEvent('qb-admin:client:maxmodVehicle', source)
end, 'admin')

QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    TriggerClientEvent('qb-admin:client:toggleBlips', source)
end, 'admin')

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    TriggerClientEvent('qb-admin:client:toggleNames', source)
end, 'admin')

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    TriggerClientEvent('qb-admin:client:ToggleCoords', source)
end, 'admin')

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    TriggerClientEvent('qb-admin:client:ToggleNoClip', source)
end, 'admin')

QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source, _)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, 'admin')

QBCore.Commands.Add('announce', Lang:t("commands.make_announcement"), {}, false, function(_, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end, 'admin')

QBCore.Commands.Add('admin', Lang:t("commands.open_admin"), {}, false, function(source, _)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, 'admin')

QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

QBCore.Commands.Add('staffchat', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, 'admin')

QBCore.Commands.Add('givenuifocus', Lang:t("commands.nui_focus"), {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(_, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", Lang:t("info.warning_chat_message")..GetPlayerName(source).."," .. Lang:t("info.reason") .. ": "..msg }, color = 255, 0, 0 })
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')

QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
        MySQL.query('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')

QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', source, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(source, 'admin') or IsPlayerAceAllowed(source, 'command') ~= 1 then return end  -- is this needed? The command is default set to 'admin' perms
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', source, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', source, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(source)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')

QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('setspeed', Lang:t("commands.set_player_foot_speed"), {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_speed"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source, _)
    QBCore.Functions.ToggleOptin(source)
    if QBCore.Functions.IsOptin(source) then
        TriggerClientEvent('QBCore:Notify', source, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_receive_report"), 'error')
    end
end, 'admin')

QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    if source > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') then -- is this needed? The command is default set to 'god' perms
            if reason and reason ~= '' then
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("info.no_reason_specified"), 'error')
            end
        end
    else
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, Lang:t("info.server_restart") .. QBCore.Config.Server.Discord)
            end
        end
    end
end, 'god')

QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapon, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', source, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', source, 'current', amount)
    end
end, 'admin')

QBCore.Commands.Add('vector2', 'Copy vector2 to clipboard (Admin only)', {}, false, function(source)
    TriggerClientEvent('qb-admin:client:copyToClipboard', source, 'coords2')
end, 'admin')

QBCore.Commands.Add('vector3', 'Copy vector3 to clipboard (Admin only)', {}, false, function(source)
    TriggerClientEvent('qb-admin:client:copyToClipboard', source, 'coords3')
end, 'admin')

QBCore.Commands.Add('vector4', 'Copy vector4 to clipboard (Admin only)', {}, false, function(source)
    TriggerClientEvent('qb-admin:client:copyToClipboard', source, 'coords4')
end, 'admin')

QBCore.Commands.Add('heading', 'Copy heading to clipboard (Admin only)', {}, false, function(source)
    TriggerClientEvent('qb-admin:client:copyToClipboard', source, 'heading')
end, 'admin')

CreateThread(function()
    while true do
        local tempPlayers = {}
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local targetped = GetPlayerPed(v)
            local ped = QBCore.Functions.GetPlayer(v)
            tempPlayers[#tempPlayers + 1] = {
                name = (ped.PlayerData.charinfo.firstname or '') .. ' ' .. (ped.PlayerData.charinfo.lastname or '') .. ' | (' .. (GetPlayerName(v) or '') .. ')',
                id = v,
                coords = GetEntityCoords(targetped),
                cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
                citizenid = ped.PlayerData.citizenid,
                sources = GetPlayerPed(ped.PlayerData.source),
                sourceplayer = ped.PlayerData.source

            }
        end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(1500)
    end
end)