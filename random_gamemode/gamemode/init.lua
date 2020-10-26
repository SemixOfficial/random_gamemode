AddCSLuaFile "shared.lua";
AddCSLuaFile "cl_init.lua";
AddCSLuaFile "cl_hud.lua";
AddCSLuaFile "cl_postprocessing.lua";
include"shared.lua";
DEFINE_BASECLASS "gamemode_base";

function GM:PlayerCanHearPlayersVoice(listener, talker)
	return listener:GetPos():DistToSqr(talker:GetPos()) > 250000, true;
end