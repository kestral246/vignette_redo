-- vignette
-- Adds a vignette filter to player's screen
-- Based on concept by TriBlade9
-- By David_G (kestral246@gmail.com)
-- 2019-03-19

-- Don't enable vignette effect at start.
-- Use chat command "/vignette" to enable, and then to toggle effect off or on.
-- Add local storage to maintain state of vignette filter per user.

local vignette = {}
local storage = minetest.get_mod_storage()

minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	if storage:get(pname) and storage:get(pname) == "1" then  -- enabled
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
	else  -- not enabled
		vignette[pname] = {
			id = player:hud_add({
				hud_elem_type = "image",
				text = "",
				position = {x=0, y=0},
				scale = {x=-100, y=-100},
				alignment = {x=1, y=1},
				offset = {x=0, y=0}
			}),
			enable = false }
	end
end)

minetest.register_chatcommand("vignette", {
	params = "",
	description = "Toggle display of vignette mask.",
	privs = {},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if vignette[name].enable == true then
			player:hud_change(vignette[name].id, "text", "")
			vignette[name].enable = false
			storage:set_string(name, "0")
		else
			player:hud_change(vignette[name].id, "text", "vignette.png")
			vignette[name].enable = true
			storage:set_string(name, "1")
		end
	end,
})

minetest.register_on_leaveplayer(function(player)
	local pname = player:get_player_name()
	if vignette[pname] then
		vignette[pname] = nil
	end
end)
