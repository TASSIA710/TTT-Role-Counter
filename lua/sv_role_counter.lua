
--[[
	TTT Role Counter -> Base (ServerSide)
	by Tassilo (https://github.com/TASSIA710)
--]]



-- Add network strings
util.AddNetworkString("TTTRoleCounter_NotifyStart")
util.AddNetworkString("TTTRoleCounter_NotifyLeave")





-- == Hook: TTTBeginRound == --
hook.Add("TTTBeginRound", "TTTRoleCounter_TTTBeginRound", function()
	-- 1 second delay to allow last minute changes to roles via 3rd party addons
	timer.Simple(1, function()

		local innocents = 0
		local traitors = 0
		local detectives = 0

		for _, ply in pairs(player.GetAll()) do
			if ply:GetRole() == ROLE_TRAITOR then
				traitors = traitors + 1

			elseif ply:GetRole() == ROLE_DETECTIVE then
				detectives = detectives + 1
			else
				innocents = innocents + 1

			end
		end

		net.Start("TTTRoleCounter_NotifyStart")
		net.WriteUInt(innocents, 8)
		net.WriteUInt(traitors, 8)
		net.WriteUInt(detectives, 8)
		net.Broadcast()

	end)
end)
-- == Hook: TTTBeginRound == --





-- == Hook: PlayerDisconnected == --
hook.Add("PlayerDisconnected", "TTTRoleCounter_PlayerDisconnected", function(ply)

	-- Ignore if round is not active
	if GetRoundState() ~= ROUND_ACTIVE then return end

	-- Ignore if player was not alive (and ensure compatibility with SpecDM)
	if ply.IsGhost then
		if not ply:Alive() or ply:IsGhost() then return end
	else
		if not ply:Alive() then return end
	end

	-- Broadcast notification
	net.Start("TTTRoleCounter_NotifyLeave")
	net.WriteUInt(ply:GetRole(), 8)
	net.Broadcast()

end)
-- == Hook: PlayerDisconnected == --
