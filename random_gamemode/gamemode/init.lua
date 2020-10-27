AddCSLuaFile "shared.lua";
AddCSLuaFile "cl_init.lua";
AddCSLuaFile "cl_hud.lua";
AddCSLuaFile "cl_postprocessing.lua";
include"shared.lua";
DEFINE_BASECLASS "gamemode_base";

function GM:PlayerCanHearPlayersVoice(listener, talker)
	return listener:GetPos():DistToSqr(talker:GetPos()) > 250000, true;
end

local RoundTime = 15
local FreezeTime = 0.10
local Delay = CurTime() + 60 * RoundTime
local IsFreezeTime = false

local function RoundSystem()
	local Timer = Delay - CurTime()
	
	if IsFreezeTime then
		if Timer <= 0 then
			IsFreezeTime = false
			Delay = CurTime() + 60 * RoundTime
		end
	else
		if Timer <= 0 then
			IsFreezeTime = true
			Delay = CurTime() + 60 * FreezeTime
		end
	end
	
	print( 'rt: ' .. string.FormattedTime( Timer, '%2i:%02i' ), 'isft: ' .. tostring( IsFreezeTime ) )
	
	for Index, Human in pairs( player.GetHumans() ) do
		Human:SetNWInt( 'RoundTime', RoundTime )
		--Human:SetNWBool( 'IsFreezeTime', IsFreezeTime )
	end
end

function GM:Tick()
	RoundSystem()
end
