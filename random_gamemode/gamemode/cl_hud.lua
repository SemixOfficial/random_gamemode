local hide = {
	["CHudAmmo"] = true,
	["CTargetID"] = true,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
	["CHudDamageIndicator"] = true
}
hook.Add("HUDShouldDraw", "hide_hud", function(name)
	if (hide[name]) then
		return false;
	end
end);

function GM:HUDDrawTargetID()

end

local overlay = Material("vgui/zoom");
hook.Add("HUDPaint", "custom_hud_thing", function()
	surface.SetMaterial(overlay);
	surface.SetDrawColor(Color(255, 255, 255, 255));
	surface.DrawTexturedRectRotated(0.5 * ScrW(), 0.5 * ScrH(), ScrW(), ScrH(), 0);
	surface.DrawTexturedRectRotated(0.5 * ScrW(), 0.5 * ScrH(), ScrW(), ScrH(), 180);
end);