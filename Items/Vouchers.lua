local voucher_atlas = {
    object_type = "Atlas",
    key = "atlasvoucher",
    path = "atlasvoucher.png",
    px = 71,
    py = 95
}
local copies = {
    object_type = "Voucher",
	key = "copies",
    atlas = "atlasvoucher",
	pos = {x = 1, y = 1},
	loc_txt = {
        name = 'Copies',
        text = {
			"Double Tags become {C:attention}Triple Tags{}",
            "and are {C:attention}2X{} as common"
		}
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_double"}
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_cry_triple", specific_vars = {2}}
        return {vars = {}}
    end,
}
local tag_printer = {
    object_type = "Voucher",
	key = "tag_printer",
    atlas = "atlasvoucher",
	pos = {x = 1, y = 2},
	loc_txt = {
        name = 'Tag Printer',
        text = {
			"Double Tags become {C:attention}Quadruple Tags{}",
            "and are {C:attention}3X{} as common"
		}
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_double"}
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_cry_quadruple", specific_vars = {3}}
        return {vars = {}}
    end,
    requires = {"v_cry_copies"}
}
local clone_machine = {
    object_type = "Voucher",
	key = "clone_machine",
    atlas = "atlasvoucher",
	pos = {x = 1, y = 3},
	loc_txt = {
        name = 'Clone Machine',
        text = {
			"Double Tags become {C:attention}Quintuple Tags{}",
            "and are {C:attention}4X{} as common"
		}
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_double"}
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_cry_quintuple", specific_vars = {4}}
        return {vars = {}}
    end,
    requires = {"v_cry_tag_printer"}
}
local command_prompt = {
    object_type = "Voucher",
	key = "command_prompt",
    atlas = "atlasvoucher",
	pos = {x = 0, y = 1},
	loc_txt = {
        name = 'Command Prompt',
        text = {
			"{C:cry_code}Code{} cards can appear",
            "in the {C:attention}shop{}"
		}
    },
    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,
    redeem = function(self)
        G.E_MANAGER:add_event(Event({func = function()
            G.GAME.code_rate = 4
        return true end }))
    end
}
local satellite_uplink = {
    object_type = "Voucher",
	key = "satellite_uplink",
    atlas = "atlasvoucher",
	pos = {x = 0, y = 2},
	loc_txt = {
        name = 'Satellite Uplink',
        text = {
			"{C:cry_code}Code{} cards may",
            "appear in any of",
            "the {C:attention}Celestial Packs{}"
		}
    },
    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,
    requires = {"v_cry_command_prompt"}
}
local quantum_computing = {
    object_type = "Voucher",
	key = "quantum_computing",
    atlas = "atlasvoucher",
	pos = {x = 0, y = 3},
	loc_txt = {
        name = 'Quantum Computing',
        text = {
			"{C:cry_code}Code{} cards can spawn",
            "with {C:dark_edition}Negative{} edition"
		}
    },
    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,
    requires = {"v_cry_satellite_uplink"}
}
local triple = {
    object_type = "Tag",
    atlas = "tag_cry",
    pos = {x=0, y=1},
    config = {type = 'tag_add', num = 2},
    key = "triple",
    loc_txt = {
        name = "Triple Tag",
        text = {
            "Gives {C:attention}#1#{} copies of the",
            "next selected {C:attention}Tag",
            "{s:0.8,C:inactive}Copying Tags excluded",
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.num}}
    end,
    apply = function(tag, context)
        if context.type == 'tag_add' and context.tag.key ~= 'tag_double' and context.tag.key ~= 'tag_cry_triple' and context.tag.key ~= 'tag_cry_quadruple' and context.tag.key ~= 'tag_cry_quintuple' and context.tag.key ~= 'tag_cry_memory' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.RED,function()
                if context.tag.ability and context.tag.ability.orbital_hand then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                for i = 1, tag.config.num do
                    add_tag(Tag(context.tag.key))
                end
                G.orbital_hand = nil
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
        end
        return true
    end,
    in_pool = function()
        return G.GAME.used_vouchers.v_cry_copies
    end
}
local quadruple = {
    object_type = "Tag",
    atlas = "tag_cry",
    pos = {x=1, y=1},
    config = {type = 'tag_add', num = 3},
    key = "quadruple",
    loc_txt = {
        name = "Quadruple Tag",
        text = {
            "Gives {C:attention}#1#{} copies of the",
            "next selected {C:attention}Tag",
            "{s:0.8,C:inactive}Copying Tags excluded",
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.num}}
    end,
    apply = function(tag, context)
        if context.type == 'tag_add' and context.tag.key ~= 'tag_double' and context.tag.key ~= 'tag_cry_triple' and context.tag.key ~= 'tag_cry_quadruple' and context.tag.key ~= 'tag_cry_quintuple' and context.tag.key ~= 'tag_cry_memory' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.RED,function()
                if context.tag.ability and context.tag.ability.orbital_hand then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                for i = 1, tag.config.num do
                    add_tag(Tag(context.tag.key))
                end
                G.orbital_hand = nil
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
        end
        return true
    end,
    in_pool = function()
        return G.GAME.used_vouchers.v_cry_tag_printer
    end
}
local quintuple = {
    object_type = "Tag",
    atlas = "tag_cry",
    pos = {x=2, y=1},
    config = {type = 'tag_add', num = 4},
    key = "quintuple",
    loc_txt = {
        name = "Quintuple Tag",
        text = {
            "Gives {C:attention}#1#{} copies of the",
            "next selected {C:attention}Tag",
            "{s:0.8,C:inactive}Copying Tags excluded",
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.num}}
    end,
    apply = function(tag, context)
        if context.type == 'tag_add' and context.tag.key ~= 'tag_double' and context.tag.key ~= 'tag_cry_triple' and context.tag.key ~= 'tag_cry_quadruple' and context.tag.key ~= 'tag_cry_quintuple' and context.tag.key ~= 'tag_cry_memory' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.RED,function()
                if context.tag.ability and context.tag.ability.orbital_hand then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                for i = 1, tag.config.num do
                    add_tag(Tag(context.tag.key))
                end
                G.orbital_hand = nil
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
        end
        return true
    end,
    in_pool = function()
        return G.GAME.used_vouchers.v_cry_clone_machine
    end
}
return {name = "Vouchers", 
        init = function()
            --Copies and upgrades
            local gcp = get_current_pool
            function get_current_pool(type, rarity, legendary, append, z)
                pool, pool_append = gcp(type, rarity, legendary, append, z)
                if type == 'Tag' then
                    for i = 1, #pool do
                        if pool[i] == "tag_double" and G.GAME.used_vouchers.v_cry_copies then
                            pool[i] = "tag_cry_triple"
                        end
                        if (pool[i] == "tag_double" or pool[i] == "tag_cry_triple") and G.GAME.used_vouchers.v_cry_tag_printer then
                            pool[i] = "tag_cry_quadruple"
                        end
                        if (pool[i] == "tag_double" or pool[i] == "tag_cry_triple" or pool[i] == "tag_cry_quadruple") and G.GAME.used_vouchers.v_cry_clone_machine then
                            pool[i] = "tag_cry_quintuple"
                        end
                    end
                end
                return pool, pool_append
            end
            local tinit = Tag.init
            function Tag:init(tag, y, z)
                if tag == "tag_double" and G.GAME.used_vouchers.v_cry_copies then
                    tag = "tag_cry_triple"
                end
                if (tag == "tag_double" or tag == "tag_cry_triple") and G.GAME.used_vouchers.v_cry_tag_printer then
                    tag = "tag_cry_quadruple"
                end
                if (tag == "tag_double" or tag == "tag_cry_triple" or tag == "tag_cry_quadruple") and G.GAME.used_vouchers.v_cry_clone_machine then
                    tag = "tag_cry_quintuple"
                end
                return tinit(self,tag,y,z)
            end
        end,
        items = {voucher_atlas, copies, tag_printer, clone_machine, triple, quadruple, quintuple, command_prompt, satellite_uplink, quantum_computing}}
