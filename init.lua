-- vignette
-- Adds a vignette filter to player's screen
-- Based on concept by TriBlade9
-- By David_G (kestral246@gmail.com)
-- Includes chat command "/vignette", which toggles effect off or on

local vignette = {}

minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	vignette[pname] = {
		id = player:hud_add({
			hud_elem_type = "image",
			text = "vignette.png",
			position = {x=0, y=0},
			scale = {x=-100, y=-100},
			alignment = {x=1, y=1},
			offset = {x=0, y=0}
		}),
		enable = true }
end)

minetest.register_chatcommand("vignette", {
	params = "",
	description = "Toggle display of vignette mask.",
	privs = {},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if vignette[name].enable == true then
			player:hud_change(vignette[name].id, "text", "blank.png")
			vignette[name].enable = false
		else
			player:hud_change(vignette[name].id, "text", "vignette.png")
			vignette[name].enable = true
		end
	end,
})

minetest.register_on_leaveplayer(function(player)
	local pname = player:get_player_name()
	if vignette[pname] then
		vignette[pname] = nil
	end
end)
