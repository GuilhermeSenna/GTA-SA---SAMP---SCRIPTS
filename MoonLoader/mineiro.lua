function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    local status = 0
    while true do
        wait(0)
        local x, y, z = getCharCoordinates(PLAYER_PED)
        -- status 0 = fora da mina - ocioso
        -- status 1 = entrou na mina
        -- status 2 = pegou a rocha
        -- status 3 = saiu da mina
        -- printStringNow(string.format( "%f %f %f", x, y, z), 1)
        if isCharInArea3d(PLAYER_PED, -610, 2326, 82, -612, 2328, 79, 1) and status == 0 then
            wait(100)
            sampSendChat("/entrar")
            status = 1
        end
        if isCharInArea3d(PLAYER_PED, -737, 2380, 6, -745, 2394, 1, 1) and status == 1 then
            wait(100)
            sampSendChat("/minerar")
            status = 2
        end
        if isCharInArea3d(PLAYER_PED, -721, 2461, 10, -717, 2465, 9, 1) and status == 2 then
            wait(100)
            sampSendChat("/sair")
            status = 3
        end
        if isCharInArea3d(PLAYER_PED, -550, 2339, 84, -548, 2334, 83, 1) and status == 3 then
            wait(100)
            sampSendChat("/deixar rocha")
            status = 0
        end
    end
end