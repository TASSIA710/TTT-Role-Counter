
--[[
	TTT Role Counter -> Autorun (Shared)
	by Tassilo (https://github.com/TASSIA710)
--]]



-- Ignore if gamemode is not TTT
if engine.ActiveGamemode() ~= "terrortown" end



if SERVER then
	AddCSLuaFile("cl_role_counter.lua")
	include("sv_role_counter.lua")

else
	include("cl_role_counter.lua")

end
