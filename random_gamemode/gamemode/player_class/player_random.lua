AddCSLuaFile();
DEFINE_BASECLASS "player_default";
local PLAYER = {};
PLAYER.DisplayName			= "Random Class";
PLAYER.WalkSpeed			= 180;		-- How fast to move when not running
PLAYER.RunSpeed				= 300;		-- How fast to move when running
PLAYER.CrouchedWalkSpeed	= 0.3;		-- Multiply move speed by this when crouching
PLAYER.DuckSpeed			= 0.4;		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.4;		-- How fast to go from ducking, to not ducking
PLAYER.JumpPower			= 200;		-- How powerful our jump should be
PLAYER.CanUseFlashlight		= true;		-- Can we use the flashlight
PLAYER.MaxHealth			= 100;		-- Max health we can have
PLAYER.StartHealth			= 100;		-- How much health we start with
PLAYER.StartArmor			= 0;		-- How much armour we start with
PLAYER.DropWeaponOnDie		= true;		-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide	= true;		-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers			= true;		-- Automatically swerves around other players
PLAYER.UseVMHands			= true;		-- Uses viewmodel hands

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Float", 0, "Stamina", nil);
	BaseClass.SetupDataTables(self);
end

function PLAYER:Spawn()
	self.Player:SetStamina(1);
end

local PLAYER_STAMINA_DRAINTIME = 5; -- How long does it take for player to run out of stamina when sprinting, in seconds.
local PLAYER_STAMINA_RECOVERYTIME = 7.5; -- How long does it take for player to run out of stamina when sprinting, in seconds.
function PLAYER:Move(mv)
	local flStaminaAmt = self.Player:GetStamina();
	local flDeltaTime = FrameTime();

	if (self.Player:IsSprinting()) then
		local flStaminaLoss = (1 / PLAYER_STAMINA_DRAINTIME) * flDeltaTime;
		local flLossMult = (self.Player:GetVelocity():Length() / mv:GetMaxClientSpeed());
		local flNewStamina = flStaminaAmt - (flLossMult * flStaminaLoss);
		if (flNewStamina <= 0) then
			flNewStamina = 0;
		end

		self.Player:SetStamina(flNewStamina);
		local frac = math.min(flNewStamina / 0.3, 1);
		mv:SetMaxSpeed(Lerp(frac, PLAYER.WalkSpeed, PLAYER.RunSpeed));
		mv:SetMaxClientSpeed(Lerp(frac, PLAYER.WalkSpeed, PLAYER.RunSpeed));
	else
		local flStaminaGain = (1 / PLAYER_STAMINA_RECOVERYTIME) * flDeltaTime;
		local flStaminaBonus = 0.0025 * (0.5 - math.min(flStaminaAmt + flStaminaGain, 0.5));
		local flNewStamina = flStaminaAmt + (flStaminaGain + flStaminaBonus);

		if (flNewStamina > 1) then
			flNewStamina = 1;
		end

		self.Player:SetStamina(flNewStamina);
		mv:SetMaxSpeed(PLAYER.WalkSpeed);
		mv:SetMaxClientSpeed(PLAYER.WalkSpeed);
	end
end

player_manager.RegisterClass("player_random", PLAYER, "player_default");
