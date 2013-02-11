--------------------------------------------xtrafcts 12.12----------------------------------------
--License: WTFPL

function simple_growing(node, ground, interv, chanc, height)
minetest.register_abm ({
	nodenames = {node},
	interval = interv,
	chance = chanc,
	action = function (pos)
		local about = {x=pos.x, y=pos.y+1, z=pos.z}
		for _, surface in ipairs(ground) do
			if minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == surface
			and minetest.env:get_node({x=pos.x, y=pos.y-height, z=pos.z}).name ~= node
			and minetest.env:get_node(about).name == "air" then
				minetest.env:add_node (about, {name = node})
			end
		end
	end,
})
end

WATER = {"default:water_source", "default:water_flowing"}
LAVA = {"default:lava_flowing","default:lava_source"}

function lavacooling_abm(input, coolingnodes, output)
minetest.register_abm ({
	nodenames = {input},
	interval = 0,
	chance = 1,
	action = function (pos)
		for _, water in ipairs(coolingnodes) do
			for i=-1,1 do
				if minetest.env: get_node({x=pos.x+i, y=pos.y, z=pos.z}).name == water
				or minetest.env: get_node({x=pos.x, y=pos.y+i, z=pos.z}).name == water
				or minetest.env: get_node({x=pos.x, y=pos.y, z=pos.z+i}).name == water
				then
				minetest.env: add_node (pos, {name = output})
				minetest.sound_play("lavacooling", {pos = pos,	gain = 1.0,	max_hear_distance = 5})
				end
			end
		end
	end,
})
end

function tooldef(modname, name, desc, strenght, pih, shh, axh, swh)
local xnode = modname..":"..name
local stick = 'default:stick'
local xpick, xshovel, xaxe, xsword = modname..":pick_"..name, modname..":shovel_"..name, modname..":axe_"..name, modname..":sword_"..name

minetest.register_tool(xpick, {
	description = desc.." Pickaxe",
	inventory_image = modname.."_pick_"..name..".png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[1]=3*pih, [2]=1.2*pih, [3]=0.8*pih}, uses=20*strenght, maxlevel=1}
		}
	},
})

minetest.register_tool(xshovel, {
	description = desc.." Shovel",
	inventory_image = modname.."_shovel_"..name..".png",
	wield_image = modname.."_shovel_"..name..".png^[transformR90",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[1]=1.5*shh, [2]=0.5*shh, [3]=0.3*shh}, uses=20*strenght, maxlevel=1}
		}
	},
})

minetest.register_tool(xaxe, {
	description = desc.." Axe",
	inventory_image = modname.."_axe_"..name..".png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3*axh, [2]=1*axh, [3]=0.6*axh}, uses=20*strenght, maxlevel=1},
			fleshy={times={[2]=1.3*axh, [3]=0.7*axh}, uses=20*strenght, maxlevel=1}
		}
	},
})

minetest.register_tool(xsword, {
	description = desc.." Sword",
	inventory_image = modname.."_sword_"..name..".png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			fleshy={times={[2]=0.8*swh, [3]=0.4*swh}, uses=20*strenght, maxlevel=1},
			snappy={times={[2]=0.8*swh, [3]=0.4*swh}, uses=20*strenght, maxlevel=1},
			choppy={times={[3]=0.9*swh}, uses=20*strenght, maxlevel=0}
		}
	}
})

minetest.register_craft({
	output = xpick,
	recipe = {
		{xnode,xnode,xnode},
		{'', stick, ''},
		{'', stick, ''},
	}
})

minetest.register_craft({
	output = xshovel,
	recipe = {
		{xnode},
		{stick},
		{stick},
	}
})

minetest.register_craft({
	output = xaxe,
	recipe = {
		{xnode, xnode},
		{xnode, stick},
		{'', stick},
	}
})

minetest.register_craft({
	output = xsword,
	recipe = {
		{xnode},
		{xnode},
		{stick},
	}
})

end
