DeriveGamemode "base";
DEFINE_BASECLASS "gamemode_base";
include("player_class/player_random.lua");

GM.Name			= "Random Gamemode";
GM.Author		= "BlacK and Asteya (or the other way around)";
GM.TeamBased	= false;

function GM:PlayerSpawn(player)
	player_manager.SetPlayerClass(player, "player_random");
	BaseClass.PlayerSpawn(self, player);
end

function GM:StartCommand( Player, CUserCmd )
	if Player:GetNWBool( 'IsFreezeTime' ) then
		CUserCmd:ClearMovement()
	end
end
