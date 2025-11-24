print("Loading MultiPet mod")
local mod = GameMain:GetMod("MultiPet")

function mod:OnEnter()
    print("[MultiPet] OnEnter - Delayed initialization")
    
    -- 延迟执行，确保游戏完全加载
    GameMain:GetMod("VSLua"):DelayCall(1.0, function()
        self:InitializeMod()
    end)
end

function mod:InitializeMod()
    print("[MultiPet] Initializing...")
    
    -- 安全检查
    if not CS or not CS.System or not CS.System.IO then
        print("[MultiPet] System namespace not available")
        return
    end
    
    -- 获取MOD路径
    local success, thisData = pcall(function()
        return CS.ModsMgr.Instance:FindMod("MultiPet", nil, true)
    end)
    
    if not success or not thisData then
        print("[MultiPet] Cannot find mod data")
        return
    end
    
    local thisPath = thisData.Path
    print("[MultiPet] Mod path: " .. thisPath)
    
    -- 加载DLL
    local mllFile = CS.System.IO.Path.Combine(thisPath, "MultiPet.dll")
    if not CS.System.IO.File.Exists(mllFile) then
        print("[MultiPet] DLL not found: " .. mllFile)
        return
    end
    
    -- 尝试加载程序集
    local ok, result = pcall(function()
        local asm = CS.System.Reflection.Assembly.LoadFrom(mllFile)
        print("[MultiPet] Assembly loaded: " .. tostring(asm))
        return asm
    end)
    
    if ok then
        print("[MultiPet] Initialization completed")
    else
        print("[MultiPet] Initialization failed: " .. tostring(result))
    end
end

function mod:OnLeave()
    print("[MultiPet] OnLeave")
    -- 清理操作
end
