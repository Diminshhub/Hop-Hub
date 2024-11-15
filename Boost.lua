-- Créditos para o @exp.io

-- Função para otimizar o jogo removendo texturas, ajustando materiais e desativando sombras e efeitos
local function optimizeForPerformance()
    -- Itera sobre todos os objetos no workspace, incluindo Models
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Plastic -- Define o material como Plastic
            obj.Reflectance = 0 -- Remove qualquer reflexo
            obj.CastShadow = false -- Desativa sombras

            -- Remove texturas aplicadas na superfície
            for _, child in pairs(obj:GetChildren()) do
                if child:IsA("Texture") or child:IsA("Decal") then
                    child:Destroy() -- Remove texturas e decals
                end
            end
        elseif obj:IsA("Model") then
            -- Aplica a otimização a todas as partes dentro do Model
            for _, part in pairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                    part.Reflectance = 0
                    part.CastShadow = false
                    
                    for _, child in pairs(part:GetChildren()) do
                        if child:IsA("Texture") or child:IsA("Decal") then
                            child:Destroy()
                        end
                    end
                end
            end
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj.Enabled = false -- Desativa efeitos visuais
        end
    end

    -- Ajusta a água (Terrain)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Terrain") then
            obj.WaterTransparency = 0.3 -- Deixa a água um pouco transparente para leveza e beleza
            obj.WaterReflectance = 0.3  -- Reflexo moderado para estética sem exagero
            obj.WaterWaveSize = 0.2     -- Ondas pequenas
            obj.WaterWaveSpeed = 10     -- Velocidade das ondas
        end
    end

    -- Desativa sombras globais
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false -- Desativa sombras globais para otimização
end

-- Chama a função para otimizar o jogo
optimizeForPerformance()

-- Atualiza a otimização quando novos objetos forem adicionados
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") then
        descendant.Material = Enum.Material.Plastic
        descendant.Reflectance = 0
        descendant.CastShadow = false

        -- Remove texturas e decals do novo objeto
        for _, child in pairs(descendant:GetChildren()) do
            if child:IsA("Texture") or child:IsA("Decal") then
                child:Destroy()
            end
        end
    elseif descendant:IsA("Model") then
        -- Aplica a otimização a todas as partes dentro de um novo Model
        for _, part in pairs(descendant:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
                part.Reflectance = 0
                part.CastShadow = false
                
                for _, child in pairs(part:GetChildren()) do
                    if child:IsA("Texture") or child:IsA("Decal") then
                        child:Destroy()
                    end
                end
            end
        end
    elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Smoke") or descendant:IsA("Fire") or descendant:IsA("Sparkles") then
        descendant.Enabled = false -- Desativa novos efeitos visuais
    elseif descendant:IsA("Terrain") then
        -- Ajusta a água se um novo Terrain for adicionado
        descendant.WaterTransparency = 0.3
        descendant.WaterReflectance = 0.3
        descendant.WaterWaveSize = 0.2
        descendant.WaterWaveSpeed = 10
    end
end)

G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true-- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
    ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
    ["No Explosions"] = true, -- Makes Explosion's invisible
    ["No Clothes"] = true, -- Removes Clothing from the game
    ["Low Water Graphics"] = true, -- Removes Water Quality
    ["No Shadows"] = true, -- Remove Shadows
    ["Low Rendering"] = true, -- Lower Rendering
    ["Low Quality Parts"] = true -- Lower quality parts
}
