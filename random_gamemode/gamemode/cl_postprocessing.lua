local color_mod = {
    ["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.10,
	["$pp_colour_contrast"] = 1.25,
	["$pp_colour_colour"] = 1.5,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}
hook.Add("RenderScreenspaceEffects", "post_processing", function()
    DrawColorModify(color_mod);
    DrawBloom(0.75, 1.27, 8, 8, 4, 8.5, 1, 1, 1);
    --DrawMotionBlur(0.1, 0.99, 0);
end);