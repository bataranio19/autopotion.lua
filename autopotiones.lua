local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")

-- Función para recoger pociones
local function recogerPocion(pocion)
    if pocion and pocion:FindFirstChild("TouchInterest") then
        -- Simula que el jugador toca la poción
        humanoidRootPart.CFrame = pocion.CFrame
        wait(0.3)  -- Espera para asegurar el "contacto"
    elseif pocion:FindFirstChild("Collect") then
        -- Alternativamente, intenta activar la función de recolección si existe
        pocion.Collect:FireServer()
    end
end

-- Función para buscar pociones en el entorno
local function buscarPociones()
    for _, item in pairs(game.Workspace:GetChildren()) do
        if item:IsA("Model") and item:FindFirstChild("Poción") then
            recogerPocion(item.Poción)  -- Llama a la función de recolección
        end
    end
end

-- Ejecuta la función de búsqueda de forma continua
runService.RenderStepped:Connect(function()
    buscarPociones()
end)
