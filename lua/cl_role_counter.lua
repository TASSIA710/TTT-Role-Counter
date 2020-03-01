
--[[
	TTT Role Counter -> Base (ClientSide)
	by Tassilo (https://github.com/TASSIA710)
--]]



-- Define variables
local colors = {
	["PLAIN"] = Color(255, 255, 255),
	["INNOCENT"] = Color(46, 204, 113),
	["TRAITOR"] = Color(231, 76, 60),
	["DETECTIVE"] = Color(52, 152, 219),
}





-- == Receive: TTTRoleCounter_NotifyStart == --
net.Receive("TTTRoleCounter_NotifyStart", function(len)

	local innocents = net.ReadUInt(8)
	local traitors = net.ReadUInt(8)
	local detectives = net.ReadUInt(8)

	if detectives > 0 then
		-- With detectives
		chat.AddText(
			colors["PLAIN"], "There are ",
			colors["INNOCENT"], innocents .. Either(innocents == 1, " innocent", " innocents"),
			colors["PLAIN"], ", ",
			colors["DETECTIVE"], detectives .. Either(detectives == 1, " detective", " detectives"),
			colors["PLAIN"], " and ",
			colors["TRAITOR"], traitors .. Either(traitors == 1, " traitor", " traitors"),
			colors["PLAIN"], " this round."
		)

	else
		-- Without detectives
		chat.AddText(
			colors["PLAIN"], "There are ",
			colors["INNOCENT"], innocents .. Either(innocents == 1, " innocent", " innocents"),
			colors["PLAIN"], " and ",
			colors["TRAITOR"], traitors .. Either(traitors == 1, " traitor", " traitors"),
			colors["PLAIN"], " this round."
		)

	end

end)
-- == Receive: TTTRoleCounter_NotifyStart == --





-- == Receive: TTTRoleCounter_NotifyLeave == --
net.Receive("TTTRoleCounter_NotifyLeave", function(len)

	local role = net.ReadUInt(8)

	if role == ROLE_INNOCENT then
		chat.AddText(
			colors["PLAIN"] = "An ",
			colors["INNOCENT"] = "innocent",
			colors["PLAIN"] = " has left the server."
		)

	elseif role == ROLE_TRAITOR then
		chat.AddText(
			colors["PLAIN"] = "A ",
			colors["TRAITOR"] = "traitor",
			colors["PLAIN"] = " has left the server."
		)

	elseif role == ROLE_DETECTIVE then
		chat.AddText(
			colors["PLAIN"] = "A ",
			colors["DETECTIVE"] = "detective",
			colors["PLAIN"] = " has left the server."
		)

	end

end)
-- == Receive: TTTRoleCounter_NotifyLeave == --
