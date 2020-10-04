-- Mod Feito para o servidor do samp: Fenixzone BR
script_name("Comprar materiais automatico")
script_authors("G. Senna")
script_version("0.8")
script_description[[
- Compra materiais automaticamente ao estar no checkpoint 
]]

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while true do
        wait(0)

        if isCharInArea2d(PLAYER_PED, 1419, -1322, 1428, -1320, 1) or
        isCharInArea2d(PLAYER_PED, 2815, -1423, 2828, -1424, 1) or
        isCharInArea2d(PLAYER_PED, -1741, 1248, -1738, 1258, 1) then
            wait(500)
            sampSendChat("/comprar materiais")
        end
    end
end