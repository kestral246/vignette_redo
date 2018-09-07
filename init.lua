minetest.register_on_joinplayer(function(player)
    player:hud_add({
        hud_elem_type = "image",
        text = "vignette.png",
        position = {x=0, y=0},
        scale = {x=-100, y=-100},
        alignment = {x=1, y=1},
        offset = {x=0, y=0}
    })
end)
