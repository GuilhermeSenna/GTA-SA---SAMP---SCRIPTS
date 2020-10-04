-- -- Mod Feito para o servidor do samp: Fenixzone BR
-- script_name("Verificar star")
-- script_authors("G. Senna")
-- script_version("0.8")
-- script_description[[
-- - Adicionar, modificar e remover estrelas.
-- ]]

-- local key = require 'vkeys'
-- local hook = require 'lib.samp.events'

-- function main()
--     if not isSampfuncsLoaded() or not isSampLoaded() then return end
--     while true do
--         wait(0)
--         if wasKeyPressed(key.VK_L) then
--             local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
--             sampSendDeathByPlayer(myid, 2)
--             print(myid)
--             -- sampForceWeaponsSync()
--         end
--     end
-- end

-- function hook.onSetPlayerWantedLevel(id, star) 
--     print("Estrela colocada")
--     print(star)
-- end

-- -- function hook.onSetPlayerSkin(id, skinid)
-- --     print('skin colocada')
-- -- end

-- -- function hook.onSetPlayerHealth(health)
-- --     print(health)
-- -- end

-- -- function hook.onGivePlayerMoney(money)
-- --     print(money)
-- -- end

-- -- function hook.onResetPlayerMoney()
-- --     print("resetado")
-- -- end

-- -- Retornar mensagem que o jogador falou
-- function hook.onSendChat(msg)
--     print(msg)
-- end

-- function hook.onSendDeathNotification(reason, killerid)
--     if killerid ~= 65535 then
--         local name = sampGetPlayerNickname(killerid)
--         print("Você foi morto por "..name)
--         print("Você foi morto por "..killerid)
--         print(reason)
--     end
-- end

-- function hook.onPlayerDeath(id)
--     local name = sampGetPlayerNickname(id)
--     sampAddChatMessage("Player " ..name.."["..id.."] morreu", -1)
-- end


-- function check_and_create_directories()
-- 	if not doesDirectoryExist('moonloader/info') then
-- 		createDirectory('moonloader/info')
-- 	end
-- end