-- Mod Feito para o servidor do samp: Fenixzone BR
script_name("Portamalas automatico")
script_authors("G. Senna")
script_version("0.8")
script_description[[
- Automatiza funções relacionadas ao portamalas: Saque, guardar e roubo. 
]]

local weapon = require 'lib.game.weapons'
local imgui = require 'imgui'
local key = require 'vkeys'
local init = true
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local main_window_state = imgui.ImBool(false)

-- Switch usado para sacar a arma do bau
switch = {
    ['granada'] = function() return 1 end,
    ['edc'] = function() return 2 end,
    ['m4'] = function() return 3 end,
    ['ak'] = function() return 4 end,
    ['faca'] = function() return 5 end,
    ['mp5'] = function() return 6 end,
    ['dk'] = function() return 7 end,
    ['rifle'] = function() return 8 end,
    ['silenciada'] = function() return 9 end,
    ['9mm'] = function() return 10 end,
    ['escopeta'] = function() return 11 end,
}

-- Funcao principal --
function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    sampRegisterChatCommand("bauu", cmd)
    while true do
        wait(0)
        if init then
            wait(1500)
            sampAddChatMessage("{000000}={FF0000}= {00FFFF}Mod PortaMalas Automatico V1.0 {000000}={FF0000}=" , 0x00FFFF)
            sampAddChatMessage("{000000}={FF0000}= {00FFFF}Criado por G. Senna {000000}={FF0000}=" , 0x00FFFF)
            sampAddChatMessage("{000000}={FF0000}= {00FFFF}Use {FFFF00}/bauu {00FFFF}para ver os comandos disponiveis. {000000}={FF0000}=" , 0x00FFFF)
            init = false
        end
        imgui.Process = main_window_state.v
    end
end

function cmd(param)
    lua_thread.create(menu, param)
end

function menu(x)
    -- Variables
    armas = {"Granada", "Escopeta de combate", "M4", "AK", "Faca", "MP5", "Desert Eagle", "Rifle", "9mm com silenciador", "9mm", "Escopeta normal"}
    armas_guardar = {"Granada", "Escopeta-de-combate", "M4", "ak-47", "Faca", "MP5", "Desert-Eagle", "Rifle", "9mm-com-silenciador", "9mm", "Escopeta"}
    armas_ids = {16, 27, 31, 30, 4, 29, 24, 33, 23, 22, 25}

    -- Commands

    if x == '' then -- Proprio veiculo, use /bauu
        -- sampAddChatMessage("===================================================", 0x00FFFF)
        -- sampAddChatMessage("                        USO NO PROPRIO PORTAMALAS          ", 0x00FFFF)
        -- sampAddChatMessage("===================================================", 0x00FFFF)
        -- sampAddChatMessage("{000000}={FF0000}= {00FFFF}Use {FFFF00}/bauu {00FF00}arma {00FFFF}para sacar uma arma de sua escolha de seu bau. {000000}={FF0000}=" , 0x00FFFF)
        -- sampAddChatMessage("...Para ver a lista de armas para sacar use {FFFF00}/bauu armas", 0xFFFFFF)
        -- sampAddChatMessage("{000000}={FF0000}= {00FFFF}Use {FFFF00}/bauu guardar {00FFFF}para guardar todas as armas do personagem.{000000}={FF0000}=" , 0x00FFFF)
        -- sampAddChatMessage("... Itens como cameras, ramalhetes, dildos, nao serao considerados como armas e nao serao guardados.", 0xFFFFFF)
        -- wait(3000)
        -- sampAddChatMessage("===================================================", 0x00FFFF)
        -- sampAddChatMessage("          USO PARA ROUBO DE PORTAMALAS ABERTO         ", 0x00FFFF)
        -- sampAddChatMessage("===================================================", 0x00FFFF)
        -- sampAddChatMessage("{000000}={FF0000}= {00FFFF}Use {FFFF00}/bauu {00FF00}ID {00FFFF}para roubar as armas de um jogador cujo id voce saiba e o portamalas dele..." , 0x00FFFF)
        -- sampAddChatMessage("... esteja aberto.{000000}={FF0000}=", 0x00FFFF)
        -- sampAddChatMessage("... Eh recomendado que esteja desarmado na hora do roubo, armas do mesmo tipo que você carregue nao serao roubadas", 0xFFFFFF)
        main_window_state.v = not main_window_state.v

        --=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=

    elseif tonumber(x) ~= nil then -- Veiculo alheio, /bauu ID
        limpar_chat()
        sampSendChat(string.format("/baul %d", x))
        wait(7500)
        sacar(false)

        --=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=

    -- elseif string.lower(x) == "armas" then -- Usuario pede Informacoes sobre comandos de pegar as armas
    --     sampAddChatMessage("=== Lista de armas para pegar ===" , 0x00FFFF)
    --     sampAddChatMessage(" Se tiver maiusculo ou minusculo nao importa, tanto dk quanto DK da no mesmo!!", 0x00FFFF)
    --     sampAddChatMessage("Aguarde 4 Segundos...", 0xFFFFFF)
    --     wait(4000)
    --     sampAddChatMessage("- Granada use {FFFF00}/bauu granada " , 0x00FFFF)
    --     sampAddChatMessage("- Escopeta de Combate use {FFFF00}/bauu edc " , 0x00FFFF)
    --     sampAddChatMessage("- M4 use {FFFF00}/bauu m4 " , 0x00FFFF)
    --     sampAddChatMessage("- AK-47 use {FFFF00}/bauu ak " , 0x00FFFF)
    --     sampAddChatMessage("- Faca use {FFFF00}/bauu faca " , 0x00FFFF)
    --     sampAddChatMessage("- Camera use {FFFF00}/bauu camera " , 0x00FFFF)
    --     sampAddChatMessage("- mp5 use {FFFF00}/bauu mp5 " , 0x00FFFF)
    --     sampAddChatMessage("- Desert Eagle use {FFFF00}/bauu dk " , 0x00FFFF)
    --     sampAddChatMessage("- Rifle use {FFFF00}/bauu rifle " , 0x00FFFF)
    --     sampAddChatMessage("- 9mm use {FFFF00}/bauu 9mm " , 0x00FFFF)
    --     sampAddChatMessage("- Escopeta normal use {FFFF00}/bauu escopeta " , 0x00FFFF)

        --=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=

    elseif string.lower(x) == "guardar" then -- Guarda todas as armas do jogador
       
        guardar()

        --=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=

    else
        if switch[string.lower(x)] == nil then -- Comando nao registrado
            sampAddChatMessage(":(   Comando incorreto, tente usar /bauu para ver as comandos disponiveis" , 0x00FFFF)
        
        else -- Comando reconhecido
           arma_id = switch[string.lower(x)]()
           sampSendChat("/abrir bau")
            wait(1200)
            sampSendChat("/baul")
            wait(1200)
            sacar(true)
        end
    end
end


--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=
                                              --Funções Principais
--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=

function imgui.OnDrawFrame()
  if main_window_state.v then
    local sw, sh = getScreenResolution()
		-- center
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(800, 500), imgui.Cond.FirstUseEver)
    imgui.Begin('Mod portamalas', main_window_state)
    imgui.TextWrapped('Mod criado por G. Senna')
    imgui.Text('')
    imgui.TextWrapped('O objetivo do mod é automatizar funções antes feitas manualmente, como: ')
    imgui.Text('- Uso no próprio portamalas:')
    imgui.Indent()
    imgui.BulletText('Sacar alguma arma específica.')
    imgui.BulletText('Guardar todas as armas do personagem.')
    imgui.Unindent()
    imgui.Text('- Uso no portamalas alheio:')
    imgui.Indent()
    imgui.BulletText('Roubar o portamalas de alguém que o deixou aberto.')
    imgui.Unindent()
    imgui.Text('')
    if (imgui.TreeNode("Avisos")) then
        imgui.BulletText('Objetos em geral (exceto facas) não serão considerados pelo programa, como dildos, câmeras, objetos de roubo, etc...')
        imgui.BulletText('O programa roubará as armas por ordem de valor (1º Granada, 2º EDC ...) ')
        imgui.BulletText('O programa reconhece o tipo de arma que o jogador está usando para não ser substituida. (ex: DK no inventário não saca 9mm)')
        imgui.BulletText('O programa avisará caso uma arma solicitada para o saque não esteja no portamalas.')
        imgui.BulletText('O programa limpará o chat para evitar leitura duplicada caso já tenha aberto outro bau recentemente.')
        imgui.BulletText('O programa não verifica se o portamalas está cheio ao guardar as armas, para tornar a tarefa mais ágil.')
        imgui.BulletText('O programa não verifica se o jogador tem nível suficiente para sacar/roubar alguma arma.')
        imgui.BulletText('Permaneça sempre o mais próximo possível do portamalas para funcionar corretamente.')
        imgui.BulletText('Caso esteja lagado é possível que alguns comandos não funcionem, caso não esteja não se preocupe.')
        imgui.TreePop();
    end
    imgui.Text('')
    imgui.TextWrapped('Veja os tutoriais abaixos relacionados a cada uma das funções apresentadas acima: ')
    -- if imgui.Button('Press me') then
    --   printStringNow('Button pressed!', 1000)
    -- end
    if imgui.CollapsingHeader('Mexer no próprio portamalas') then
      if (imgui.TreeNode("Sacar alguma arma")) then
        imgui.Text('')
        imgui.TextWrapped('Comando: ')
        imgui.TextColored(imgui.ImVec4(1.0, 1.0, 0.0, 1.0), "/bauu ARMA");
        imgui.TextWrapped('Algumas armas foram deixadas com suas iniciais (Escopeta de Combate = EDC) para facilitar na hora de pegar.')
        imgui.TextWrapped('Veja a lista delas abaixo:')
        if (imgui.TreeNode("Lista de armas")) then
          imgui.BulletText('Granada - /bauu granada')
          imgui.BulletText('Escopeta de Combate - /bauu edc ')
          imgui.BulletText('M4 - /bauu m4 ')
          imgui.BulletText('AK-47 - /bauu ak')
          imgui.BulletText('Faca - /bauu faca')
          imgui.BulletText('mp5 - /bauu mp5')
          imgui.BulletText('Desert Eagle - /bauu dk')
          imgui.BulletText('Rifle - /bauu rifle')
          imgui.BulletText('9mm silenciada - /bauu silenciada')
          imgui.BulletText('9mm - /bauu 9mm')
          imgui.BulletText('Escopeta normal - /bauu escopeta')
          imgui.TreePop();
        end
        imgui.TreePop();
      end
      imgui.Text('')
      if (imgui.TreeNode("Guardar todas as armas")) then
        imgui.TextWrapped('Comando: ')
        imgui.TextColored(imgui.ImVec4(1.0, 1.0, 0.0, 1.0), "/bauu guardar");
        imgui.TreePop();
      end
    end
    if imgui.CollapsingHeader('Roubo de armas portamalas') then
        imgui.Text('')
        imgui.TextWrapped('Para roubar o portamalas de alguém:')
        imgui.BulletText('O portamalas PRECISA estar aberto.')
        imgui.BulletText('Você precisa saber o ID do jogador a qual vai roubar')
        imgui.Text('')
        imgui.TextWrapped('Comando: ')
        imgui.TextColored(imgui.ImVec4(1.0, 1.0, 0.0, 1.0), "/bauu ID");
        imgui.TextWrapped('ID = ID da pessoa com o portamalas aberto.')
        imgui.TextWrapped('Ex: /bauu 36')
    end
    imgui.End()
  end
end

-- Função para sacar
function sacar(specific)

    if specific then -- Sacar alguma arma do proprio bau
        if not is_weapon_in_chest() then -- Ao usar /bauu alguma-arma e a arma nao tiver no bau ira encerrar
            return
        end

        for i = 85, 99 do -- Verifica as ultimas 14 linhas do chat
            local text = sampGetChatString(i) 
            for j = 1, 14 do -- 14 linhas do 
                if text:find(string.format( "Lugar {DBED15}%d{C8C8C8}:{FFFFFF} %s", j, armas[arma_id])) then
                    -- Se procurar 9mm e achar 9mm-silencada
                    if arma_id == 10 then
                        if not text:find(string.format( "Lugar {DBED15}%d{C8C8C8}:{FFFFFF} 9mm com", j)) then
                            if not is_repeated(armas_ids[arma_id]) then
                                sampSendChat(string.format("/baul sacar %d", j))
                                wait(1200)
                                limpar_chat()
                                fechar_bau()   
                            end    
                            return
                        end
                    else
                        if not is_repeated(armas_ids[arma_id]) then
                            sampSendChat(string.format("/baul sacar %d", j))
                        end
                        wait(1200)
                        limpar_chat()
                        fechar_bau()       
                        return
                    end
                end
            end
        end
    else -- Roubo de armas
        for i = 85, 99 do -- Verifica as ultimas 14 linhas do chat
            local text = sampGetChatString(i) 
            for j = 1, 14 do -- 14 linhas do 
                for k = 1, #armas do -- Compara com as listas de armas pré-existente
                    if text:find(string.format( "Lugar {DBED15}%d{C8C8C8}:{FFFFFF} %s", j, armas[k])) then
                        if not is_repeated(armas_ids[k]) then
                            sampSendChat(string.format( "/baul sacar %d", j))
                            wait(1500)
                        end
                    end
                end
            end
        end
    end

  limpar_chat()
end

-- Função para Guardar armas
function guardar()
    -- Primeiro uso
    if not is_armed(true) then
        return
    end

    -- Se o player tiver armado dai lê essa parte
    sampAddChatMessage("Guardando todas as armas do Personagem..." , 0x00FFFF)
    sampAddChatMessage("Atencao, o mod nao checara se o portamalas esta cheio, para o processo de guardar ser mais agil!!" , 0x00FFFF)
    wait(1200)
    sampSendChat("/abrir bau")
    wait(1200)
    sampSendChat("/baul")

    -- Segundo uso
    guardar_armas()
    wait(1200)
    fechar_bau()
    limpar_chat()
end

-- Função realmente efetiva, Checa se o player possui as armas pré-definidas e então as guarda.
function guardar_armas()
    for i=1, #armas_ids do
        if hasCharGotWeapon(PLAYER_PED, armas_ids[i]) then
            wait(1200)
            sampAddChatMessage(string.format( "%s foi guardado(a) <-> se o portamalas tiver espaco", armas[i]) , 0x00FFFF)
            sampSendChat(string.format( "/baul guardar %s", armas_guardar[i]))
        end
    end
end

-- Função simples, apenas fecha o bau
function fechar_bau()
    wait(500)
    sampSendChat("/fechar bau")
end

function limpar_chat()
    for m = 1, 20 do -- O chat é limpado para evitar leituras duplicadas
        sampAddChatMessage("Limpando chat", 0x00FFFF)
    end    
end

--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=
                                              --Funções auxiliares
--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=--=-=-=-=-=-=-==-=-=-=-=-=-==-=-=-=-==-=-=-=-=-=-=-=-=


-- Funcao exclusiva para verificar se o jogador ta armado
function is_armed(print) -- O print serve para verificar se é para printar a mensagem de estar desarmado ou não.
    local armado = false -- a piori considera-se que o jogador está desarmado
    -- Faz uma primeira verificacao para nao abrir o bau a toa caso o player esteja desarmado
    for i=1, #armas_ids do
        if hasCharGotWeapon(PLAYER_PED, armas_ids[i]) then
            armado = true
        end
    end
    if not armado then -- Se o jogador estiver desarmado o retorná falso e então terminará
        if print then
            sampAddChatMessage(":(   O jogador esta desarmado...   " , 0x00FFFF)
        end
        return false
    else               -- Se o jogador estiver armado retornará true
        return true
    end
end


-- Checa se a proxima arma a sacar é a mesma ou do mesmo tipo
-- id é o id da proxima arma que seria sacada
function is_repeated(id)
    -- PISTOLAS --
    if hasCharGotWeapon(PLAYER_PED , weapon.COLT45) or hasCharGotWeapon(PLAYER_PED , weapon.SILENCED) or hasCharGotWeapon(PLAYER_PED , weapon.DESERTEAGLE) then
        if id == weapon.COLT45 or id == weapon.SILENCED or id == weapon.DESERTEAGLE then
            sampAddChatMessage(":(   Voce ja possui uma Pistola no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- FUZIS --
    if hasCharGotWeapon(PLAYER_PED , weapon.M4) or hasCharGotWeapon(PLAYER_PED , weapon.AK47) then
        if id == weapon.M4 or id == weapon.AK47 then
            sampAddChatMessage(":(   Voce ja possui um Fuzil no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- ESCOPETAS
    if hasCharGotWeapon(PLAYER_PED , weapon.SHOTGUN) or hasCharGotWeapon(PLAYER_PED , weapon.COMBATSHOTGUN) then
        if id == weapon.SHOTGUN or id == weapon.COMBATSHOTGUN then
            sampAddChatMessage(":(   Voce ja possui uma Escopeta no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- RIFLE
    if hasCharGotWeapon(PLAYER_PED, weapon.RIFLE) then
        if id == weapon.RIFLE then
            sampAddChatMessage(":(   Voce ja possui um Rifle no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- Granada
    if hasCharGotWeapon(PLAYER_PED, weapon.GRENADE) then
        if id == weapon.GRENADE then
            sampAddChatMessage(":(   Voce ja possui uma Granada no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- MP5
    if hasCharGotWeapon(PLAYER_PED, weapon.MP5) then
        if id == weapon.MP5 then
            sampAddChatMessage(":(   Voce ja possui uma MP5 no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    -- FACA
    if hasCharGotWeapon(PLAYER_PED, weapon.KNIFE) then
        if id == weapon.KNIFE then
            sampAddChatMessage(":(   Voce ja possui uma Faca no inventario ...   " , 0x00FFFF)
            return true
        end
    end

    return false
end

----------------------------------
-- Checa se a arma esta no bau antes de tentar sacar
function is_weapon_in_chest()
    local slots_aux = {}
    
    for i = 85, 99 do -- Verifica as ultimas 14 linhas do chat
        local text = sampGetChatString(i) 
        for j = 1, 14 do -- 14 linhas do 
            if text:find(string.format( "Lugar {DBED15}%d{C8C8C8}:{FFFFFF} %s", j, armas[arma_id])) then
                table.insert(slots_aux, j) -- Preenche os lugares com armas no portamalas
            end
        end
    end

    if #slots_aux == 0 then
        sampAddChatMessage(":(   A arma escolhida nao esta no bau...   " , 0x00FFFF)
        return false
    end
    return true
end
