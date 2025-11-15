print("Loading MultiPet mod")
local mod = GameMain:GetMod("MultiPet");
function mod:OnBeforeInit()
  print("[MultiPet] OnBeforeInit")
  xlua.private_accessible(CS.XLua.LuaEnv)
  xlua.private_accessible(CS.XLua.ObjectTranslator)
  local thisData = CS.ModsMgr.Instance:FindMod("MultiPet", nil, true)
  local thisPath = thisData.Path
  print("[MultiPet] path: " .. thisPath)
  local mllFile = CS.System.IO.Path.Combine(thisPath, "MultiPet.dll")
  local asm = CS.System.Reflection.Assembly.LoadFrom(mllFile)
  CS.XiaWorld.LuaMgr.Instance.Env.translator.assemblies:Add(asm)
  -- CS.MultiPet.MultiPet.Patch()
end

function mod:OnLoad()
  print("[MultiPet] OnLoad")
end

function mod:OnLeave()
  print("[MultiPet] OnLeave")
  CS.MultiPet.MultiPetPatcher.Unpatch()
end
