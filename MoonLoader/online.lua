local imgui = require 'imgui'
local path = getWorkingDirectory()..'\\resource'
local encoding = require 'encoding'
local hook = require 'lib.samp.events'
encoding.default = 'CP1251'
u8 = encoding.UTF8

if not doesDirectoryExist(path) then createDirectory(path) end

local filepath = path..'\\players.txt'

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    sampRegisterChatCommand("online", cmd)

    sampRegisterChatCommand('list', function(arg)
        if not arg:find('%.txt') then arg = arg..'.txt' end -- Adicionar extensao do arquivo
        if not doesFileExist(path..'\\players.txt') then return sampAddChatMessage('Erro, este arquivo não existe!', -1) end
        local f = io.open(path..'\\players.txt', 'r')
        local text = f:read('*a')
        f:close()
        sampShowDialog(9999, "Lista de players", '{FFFFFF}'..text, 'OK')
    end)

    sampRegisterChatCommand('add', function(arg)
        if not arg:find('%.txt') then arg = arg..'.txt' end -- Adicionar extensao do arquivo
        if not doesFileExist(filepath) then return sampAddChatMessage('Erro, este arquivo não existe!', -1) end
        lines = {} -- matriz de linhas de arquivo
        for line in io.lines(filepath) do
            table.insert(lines, line)
        end
        sampShowDialog(7777, "Editar/adicionar players", '{00FF00}Adicionar linha\n'..table.concat(lines, '\n'), 'Escolher', 'Fechar', 2)
        lua_thread.create(dialog)
    end)

    while true do
        wait(0)
    end
end

function cmd()
    -- lua_thread.create(menu, param)
    if not doesFileExist(path..'\\players.txt') then
        sampAddChatMessage('Criado arquivo players.txt', -1)
        local f = io.open(path..'\\players.txt', 'w+')
        f:close()
    end

    -- local f = io.open(path..'\\players.txt', 'r')
    -- local text = f:read('*a')
    -- f:close()
    local players = {}
    local ids = {}
    local status = {}
    for line in io.lines(filepath) do
        local id = sampGetPlayerIdByNickname(line)
        if id ~= nil then
            table.insert(ids, id)
        end
        if not id then
            table.insert(status, 0)
        else
            table.insert(status, 1)
        end
        table.insert(players, line)
    end

    local player = {}
    local aux = 1
    for i = 1, #players do
        if status[i] == 1 then
            table.insert(player, players[i]..'     '..ids[aux]..'     {00FF00}V')
            aux = aux + 1
        else
            table.insert(player, players[i]..'     {FF0000}X')
        end
    end
    
    sampShowDialog(7777, "Status players", table.concat(player, '\n'), 'Escolher', 'Fechar', 2)
    
end

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end

function dialog()
    while sampIsDialogActive() do
        wait(0)
        if sampGetCurrentDialogId() ~= 7777 then break end
        local result, button, list, input = sampHasDialogRespond(7777)
        if result then
            if button == 1 then
                if list == 0 then
                    line = #lines + 1
                    sampShowDialog(8888, '{00FF00}Adicionar linha de linha:', '{FFFFFF}Digite o texto', 'OK', 'Cancelar', 1)
                    lua_thread.create(dialog2)
                else
                    line = list
                    sampShowDialog(8888, '{FFFFFF}Linha de edição:', '{FFFFFF}'..lines[line], 'OK', 'Cancelar', 1)
                    lua_thread.create(dialog2)
                end
            end
        end
    end
end

function dialog2()
    while sampIsDialogActive() do
        wait(0)
        if sampGetCurrentDialogId() ~= 8888 then break end
        local result, button, list, input = sampHasDialogRespond(8888)
        if result then
            if button == 1 then
                lines[line] = input
                local file = io.open(filepath, 'w')
                file:write(table.concat(lines, "\n"))
                file:close()
            end
        end
    end
end

function hook.onPlayerJoin(id, color, isNPC, nickname)
    -- Percorrer lista de players
    for line in io.lines(filepath) do
        if line == nickname then
            sampAddChatMessage(string.format( "%s[%d] {00FF00}Acabou de logar", nickname, id), -1)
        end
    end
end

function hook.onPlayerQuit(id, reason)
    if reason ~= 2 then -- Possivelmente problemas ao se logar.
        local name = sampGetPlayerNickname(id)
        for line in io.lines(filepath) do
            if line == name then
                sampAddChatMessage(name.."["..id.."] {FF0000}Acabou de deslogar, razao: "..reason.."", -1)
            end
        end
    end
end
