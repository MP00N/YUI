local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- 1. 无限高频循环 + 疯狂打印（刷屏控制台）
while true do
    print("🔥 控制台刷屏！CPU 爆炸！" .. os.clock()) -- 强制刷屏
    task.wait(0.001) -- 几乎不等待，让循环极高频运行
end

-- 2. 内存泄漏（无限创建 Parts，不销毁）
RunService.Heartbeat:Connect(function()
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Position = Vector3.new(math.random(-50, 50), 10, math.random(-50, 50))
        part.Parent = workspace
    end
end)

-- 3. 无限递归函数（堆栈溢出风险）
local function CrashGame()
    CrashGame() -- 无限递归，可能直接卡死游戏
end
CrashGame()

-- 4. 滥用 RemoteEvents（网络堵塞）
RunService.Stepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        game.ReplicatedStorage.RemoteEvent:FireAllClients("网络堵塞测试", math.random(1, 1000))
    end
end)
