local item_sounds = require("__base__/prototypes/item_sounds")
local assembler2pipepictures = table.deepcopy(require("__base__/prototypes/entity/assembler-pictures").assembler2pipepictures)
local misc = require("__pf-functions__/misc")

local tm = require("__pf-functions__/technology-manipulation")

--REMINDER
-- this runs before all PF mods. you cannot use data.raw.item[whatever] to test for the existence of an item from one of those mods!

data:extend({
    {
        type = "recipe-category",
        name = "tuning-up"
    },
    {
        type = "recipe-category",
        name = "purification"
    },
    {
        type = "item",
        name = "molecular-purifier",
        icon = "__tuner-upper__/graphics/molecular-purifier/atom-forge-icon.png",
        subgroup = "smelting-machine",
        place_result = "molecular-purifier",
        order = "y",
        inventory_move_sound = item_sounds.reactor_inventory_move,
        pick_sound = item_sounds.reactor_inventory_pickup,
        drop_sound = item_sounds.reactor_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis",
        weight = 200 * kg
    },
    {
        type = "item",
        name = "tune-up-station",
        icons = { {
            icon = "__tuner-upper__/graphics/tune-up-station/gravity-assembler-icon.png",
            icon_size = 64,
            tint = mods["LunarLandings"] and { 1, 1, 0.5, 1 } or { 1, 1, 1, 1 }
        } },
        subgroup = "smelting-machine",
        place_result = "tune-up-station",
        order = "z",
        inventory_move_sound = item_sounds.mechanical_large_inventory_move,
        pick_sound = item_sounds.mechanical_large_inventory_pickup,
        drop_sound = item_sounds.mechanical_large_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis",
        weight = 200 * kg
    },
    {
        type = "assembling-machine",
        name = "molecular-purifier",
        icon = "__tuner-upper__/graphics/molecular-purifier/atom-forge-icon.png",
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 0.1, result = "molecular-purifier" },
        max_health = 400,
        corpse = "recycler-remnants",
        dying_explosion = "recycler-explosion",
        effect_receiver = {
            base_effect = { quality = 0.8 },
        },
        circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions.create_vector(
            universal_connector_template,
            {
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true }
            }
        ),
        collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        damaged_trigger_effect = data.raw["furnace"]["recycler"].damaged_trigger_effect,
        module_slots = 2,
        allowed_effects = { "consumption", "speed", "pollution", "quality" },
        graphics_set = {
            animation = {
                layers = {
                    {
                        filenames = { "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-2.png" },
                        width = 400,
                        height = 480,
                        frame_count = 80,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = { 0, -0.25 },
                        scale = 0.33
                    },
                    {
                        filenames = { "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-shadow.png" },
                        width = 900,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 80,
                        draw_as_shadow = true,
                        shift = { 0, -0.25 },
                        scale = 0.33
                    }
                }
            },
            idle_animation = {
                layers = {
                    {
                        filenames = { "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-2.png" },
                        width = 400,
                        height = 480,
                        frame_count = 80,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = { 0, -0.25 },
                        scale = 0.33
                    },
                    {
                        filenames = { "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-shadow.png" },
                        width = 900,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 80,
                        draw_as_shadow = true,
                        shift = { 0, -0.25 },
                        scale = 0.33
                    }
                }
            },
            working_visualisations = {
                {
                    fadeout = true,
                    secondary_draw_order = 1,
                    animation = {
                        layers = {
                            {
                                filenames = { "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-emission-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-emission-2.png" },
                                width = 400,
                                height = 480,
                                frame_count = 80,
                                line_length = 8,
                                lines_per_file = 8,
                                blend_mode = "additive",
                                draw_as_glow = true,
                                shift = { 0, -0.25 },
                                scale = 0.33
                            }
                        }
                    }
                }
            }
        },
        impact_categories = { "metal-large" },
        open_sound = { filename = "__base__/sound/open-close/nuclear-open.ogg", volume = 0.5 },
        close_sound = { filename = "__base__/sound/open-close/nuclear-close.ogg", volume = 0.5 },
        working_sound = table.deepcopy(data.raw["reactor"]["nuclear-reactor"].working_sound),
        crafting_speed = 1,
        energy_source =
        {
            type = "burner",
            fuel_categories = {"exotic"},
            emissions_per_minute = { pollution = 2 },
            fuel_inventory_size = 1,
            burnt_inventory_size = 1,
        },
        energy_usage = "1MW",
        crafting_categories = { "purification" },
        fluid_boxes_off_when_no_fluid_recipe = true,
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "input",
                        direction = defines.direction.north,
                        position = { 0.5, -1.5 },
                    }
                },
                secondary_draw_orders = { north = -1 }
            },
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "input",
                        direction = defines.direction.north,
                        position = { -0.5, -1.5 },
                    }
                },
                secondary_draw_orders = { north = -1 }
            },
            {
                production_type = "output",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "output",
                        direction = defines.direction.south,
                        position = { 0.5, 1.5 }
                    }
                },
                secondary_draw_orders = { north = -1 }
            },
            {
                production_type = "output",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "output",
                        direction = defines.direction.south,
                        position = { -0.5, 1.5 }
                    }
                },
                secondary_draw_orders = { north = -1 }
            }
        },
        ll_surface_conditions = { nauvis = true, luna = { plain = false, lowland = false, mountain = false, foundation = true } }
    },
    {
        type = "assembling-machine",
        name = "tune-up-station",
        icons = { {
            icon = "__tuner-upper__/graphics/tune-up-station/gravity-assembler-icon.png",
            icon_size = 64,
            tint = mods["LunarLandings"] and { 1, 1, 0.5, 1 } or { 1, 1, 1, 1 }
        } },
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 0.1, result = "tune-up-station" },
        max_health = 400,
        corpse = "recycler-remnants",
        dying_explosion = "recycler-explosion",
        effect_receiver = {
            base_effect = { quality = 0.8 },
        },
        circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions.create_vector(
            universal_connector_template,
            {
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
                { variation = 11, main_offset = util.by_pixel(28, 16), shadow_offset = util.by_pixel(35, 31), show_shadow = true }
            }
        ),
        collision_box = { { -1.3, -1.3 }, { 1.3, 1.3 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        damaged_trigger_effect = data.raw["furnace"]["recycler"].damaged_trigger_effect,
        module_slots = 3,
        allowed_effects = { "consumption", "speed", "pollution", "quality" },
        graphics_set = {
            animation = {
                layers = {
                    {
                        filenames = { "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-2.png" },
                        width = 320,
                        height = 320,
                        frame_count = 100,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = { 0, -0.15 },
                        scale = 0.3
                    },
                    {
                        filenames = { "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-shadow.png" },
                        width = 520,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 100,
                        draw_as_shadow = true,
                        shift = { 0, -0.15 },
                        scale = 0.3
                    }
                }
            },
            idle_animation = {
                layers = {
                    {
                        filenames = { "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-2.png" },
                        width = 320,
                        height = 320,
                        frame_count = 100,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = { 0, -0.15 },
                        scale = 0.3
                    },
                    {
                        filenames = { "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-shadow.png" },
                        width = 520,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 100,
                        draw_as_shadow = true,
                        shift = { 0, -0.15 },
                        scale = 0.3
                    }
                }
            },
            working_visualisations = {
                {
                    fadeout = true,
                    secondary_draw_order = 1,
                    animation = {
                        layers = {
                            {
                                filenames = { "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-emission-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-emission-2.png" },
                                width = 320,
                                height = 320,
                                frame_count = 100,
                                line_length = 8,
                                lines_per_file = 8,
                                blend_mode = "additive",
                                draw_as_glow = true,
                                shift = { 0, -0.15 },
                                scale = 0.3
                            }
                        }
                    }
                }
            }
        },
        impact_categories = { "metal-large" },
        open_sound = { filename = "__base__/sound/open-close/mechanical-large-open.ogg", volume = 0.5 },
        close_sound = { filename = "__base__/sound/open-close/mechanical-large-close.ogg", volume = 0.5 },
        working_sound = { filename = "__base__/sound/assembling-machine-repaired-1.ogg", volume = 0.5 },
        crafting_speed = 1,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = 1 }
        },
        energy_usage = "250kW",
        crafting_categories = { "tuning-up" },
        fluid_boxes_off_when_no_fluid_recipe = true,
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "input",
                        direction = defines.direction.north,
                        position = { 0, -1 },
                    }
                },
                secondary_draw_orders = { north = -1 }
            },
            {
                production_type = "output",
                pipe_picture = assembler2pipepictures,
                pipe_covers = pipecoverspictures(),
                volume = 1000,
                pipe_connections =
                {
                    {
                        flow_direction = "output",
                        direction = defines.direction.south,
                        position = { 0, 1 }
                    }
                },
                secondary_draw_orders = { north = -1 }
            }
        },
        ll_surface_conditions = { nauvis = true, luna = { plain = false, lowland = false, mountain = false, foundation = true } }
    },
    {
        type = "recipe",
        name = "molecular-purifier",
        categories = { "crafting" },
        ingredients = mods["space-age"] and {
            { type = "item", name = "centrifuge",       amount = 1 },
            { type = "item", name = "quality-module-2", amount = 10 },
            { type = "item", name = "carbon-fiber",     amount = 100 },
            { type = "item", name = "tungsten-plate",   amount = 100 },
        } or {
            { type = "item", name = "centrifuge",       amount = 1 },
            { type = "item", name = "quality-module-3", amount = 1 },
            { type = "item", name = "chemical-plant",   amount = 10 },
            { type = "item", name = "uranium-235",      amount = 20 },
            { type = "item", name = "processing-unit",  amount = 20 },
        },
        results = {
            { type = "item", name = "molecular-purifier", amount = 1 }
        },
        energy_required = 10,
        enabled = false
    },
    {
        type = "recipe",
        name = "tune-up-station",
        categories = { "crafting" },
        ingredients = {
            { type = "item", name = "assembling-machine-2", amount = 1 },
            { type = "item", name = "quality-module",       amount = 10 },
            { type = "item", name = "electric-engine-unit", amount = 20 },
            { type = "item", name = "fast-inserter",        amount = 20 }
        },
        results = {
            { type = "item", name = "tune-up-station", amount = 1 }
        },
        energy_required = 10,
        enabled = false
    },
    {
        type = "technology",
        name = "tune-up-station",
        icon = "__tuner-upper__/graphics/tune-up-station/gravity-assembler-technology.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "tune-up-station"
            }
        },
        prerequisites = { "quality-module", "electric-engine" },
        unit = {
            count = 250,
            time = 15,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 }
            }
        }
    },
    {
        type = "technology",
        name = "molecular-purifier",
        icon = "__tuner-upper__/graphics/molecular-purifier/atom-forge-technology.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "molecular-purifier"
            }
        },
        prerequisites = mods["space-age"] and
            { "quality-module-2", "carbon-fiber", "metallurgic-science-pack", "uranium-processing" } or
            { "quality-module-3", "uranium-processing" },
        unit = {
            count = mods["space-age"] and 2500 or 500,
            time = 15,
            ingredients = mods["space-age"] and {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "space-science-pack",        1 },
                { "production-science-pack",   1 },
                { "agricultural-science-pack", 1 },
                { "metallurgic-science-pack",  1 }
            } or {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 }
            }
        }
    },
    {
        type = "fuel-category",
        name = "exotic"
    },
    {
        type = "sprite",
        name = "tooltip-category-exotic",
        filename = "__base__/graphics/icons/tooltips/tooltip-category-nuclear.png",
        priority = "extra-high-no-scale",
        width = 40,
        height = 40,
        flags = { "gui-icon" },
        mipmap_count = 2,
        scale = 0.5
    }
})

if mods["space-age"] then
    data:extend({
        {
            type = "item",
            name = "geothermal-power-cell",
            subgroup = "vulcanus-processes",
            order = "z",
            stack_size = 50,
            mass = 10 * kg,
            default_import_location = "vulcanus",
            icon = "__tuner-upper__/graphics/icons/geothermal-power-cell.png",
            icon_size = 64,
            pictures = {
                layers = {
                    {
                        size = 64,
                        filename = "__tuner-upper__/graphics/icons/geothermal-power-cell.png",
                        scale = 0.5
                    },
                    {
                        filename = "__tuner-upper__/graphics/icons/geothermal-power-cell-glow.png",
                        size = 64,
                        scale = 0.5,
                        draw_as_light = true
                    }
                }
            },
            fuel_value = "50MJ",
            fuel_categories = { "exotic" }
        },
        {
            type = "recipe",
            name = "geothermal-power-cell",
            energy_required = 5,
            categories = {"metallurgy"},
            allow_productivity = true,
            ingredients = {
                {type="item", name="tungsten-plate", amount=1},
                {type="fluid", name="lava", amount=12000},
            },
            results = {
                {type="item", name="geothermal-power-cell", amount=1}
            }
        }
    })

    data.raw.item["supercapacitor"].fuel_value = "250MJ"
    data.raw.item["supercapacitor"].fuel_categories = { "exotic" }

    data.raw.item["promethium-asteroid-chunk"].fuel_value = "80MJ"
    data.raw.item["promethium-asteroid-chunk"].fuel_categories = { "exotic" }

    data.raw.item["nutrients"].fuel_categories = { "nutrients", "exotic" }
    data.raw.item["fusion-power-cell"].fuel_categories = { "fusion", "exotic" }

    tm.AddUnlock("molecular-purifier", "geothermal-power-cell")
end

data.raw.item["uranium-fuel-cell"].fuel_categories = { "nuclear", "exotic" }

tune_up_data = {
    recipes = {},
    scrap_values = {
        ["metal-scrap"] = 1,
        ["electrical-scrap"] = 1,
        ["masonry-scrap"] = 1,
        ["structural-scrap"] = 4,
        ["mechanical-scrap"] = 1,
        ["electronic-scrap"] = 2,
        ["robotic-scrap"] = 5,
        ["plumbing-scrap"] = 1,
        ["volcanic-scrap"] = 1,
        ["superconducting-scrap"] = 1,
    }
}

function tune_up_data.AddIngredient(recipe, ingredient, amount, byproduct)
    if amount == nil then
        amount = 1
    end
    if byproduct == false then
        byproduct = nil
    end
    if byproduct == true then
        byproduct = "byproduct"
    end
    if tune_up_data.recipes[recipe] then
        if tune_up_data.recipes[recipe].ingredients then
            for k, v in pairs(tune_up_data.recipes[recipe].ingredients) do
                local found = false
                for k2, v2 in pairs(v) do
                    if v2[1] == ingredient and v2[3] == byproduct then
                        v2[2] = v2[2] + amount
                        found = true
                    end
                end
                if not found then
                    table.insert(v, { ingredient, amount, byproduct })
                end
            end
        else
            tune_up_data.recipes[recipe].ingredients = { { { ingredient, amount, byproduct } } }
        end
    end
end

function tune_up_data.RemoveIngredient(recipe, ingredient, amount)
    if amount == nil then
        amount = 1
    end
    if byproduct == nil then
        byproduct = false
    end
    if byproduct == "byproduct" then
        byproduct = true
    end
    if tune_up_data.recipes[recipe] then
        if tune_up_data.recipes[recipe].ingredients then
            for k, v in pairs(tune_up_data.recipes[recipe].ingredients) do
                local remaining = amount
                for k2, v2 in pairs(v) do
                    if v2[1] == ingredient and (v2[3] == "byproduct") == byproduct then
                        if v2[2] > remaining then
                            v2[2] = v2[2] - amount
                            remaining = 0
                        else
                            remaining = remaining - v2[2]
                            v2[2] = 0
                        end
                    end
                end

                --remove any ingredients that were zeroed
                local index = 1
                while index <= #v do
                    if v[index][2] == 0 then
                        table.remove(v, index)
                    else
                        index = index + 1
                    end
                end
            end
        end
    end
end

function tune_up_data.ReplaceIngredientProportional(recipe, ingredient, replacement, ratio, byproduct)
    if ratio == nil then
        ratio = 1
    end
    if byproduct == nil then
        byproduct = false
    end
    if byproduct == "byproduct" then
        byproduct = true
    end
    --due to the foresight afforded by my extremely thicc brain, I do not need to consolidate multiple of the same
    if tune_up_data.recipes[recipe] then
        if tune_up_data.recipes[recipe].ingredients then
            for k, v in pairs(tune_up_data.recipes[recipe].ingredients) do
                for k2, v2 in pairs(v) do
                    if v2[1] == ingredient and (v2[3] == "byproduct") == byproduct then
                        v2[2] = math.max(math.floor(v2[2] * ratio), 1)
                        v2[1] = replacement
                    end
                end
            end
        end
    end
end

tune_up_data.recipes["iron-gear-wheel"] = {
    categories = { "tuning-up" },
    count = 3,
    energy_required = 2,
    ingredients = { { { "bearing", 1 } }, { { "steel-plate", 1 }, {"lubricant", 3} } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3,
}

tune_up_data.recipes["iron-stick"] = {
    categories = { "tuning-up" },
    count = 16,
    energy_required = 2,
    ingredients = { { { "invar-plate", 1 } }, { { "lead-expansion-bolt", 4 } }, { { "steel-plate", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3,
}

tune_up_data.recipes["low-density-structure"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "plastic-bar", 5 }, { "loadbearing-lattice", 2 }, { "iron-stick", 2, "byproduct" } }, { { "plastic-bar", 5 }, { "ll-aluminium-plate", 2 }, { "iron-stick", 2, "byproduct" } }, { { "plastic-bar", 5 }, { "titanium-plate", 2 }, { "iron-stick", 2, "byproduct" } }, { { "plastic-bar", 5 }, { "steel-plate", 3 }, { "iron-stick", 2, "byproduct" } } },
    scrap_types = { { "metal-scrap", 1 }, { "structural-scrap", 1 } },
    scrap_yield = 8,
}

tune_up_data.recipes["engine-unit"] = {
    categories = { "tuning-up" },
    count = 2,
    energy_required = 10,
    ingredients = { { { "tungsten-plate", 1 }, { "galvanized-tubing", 2, "byproduct" } }, { { "tungsten-plate", 1 }, { "pipe", 2, "byproduct" } }, { { "fluid-regulator", 1 }, { "flywheel", 2 } }, { { "fluid-regulator", 2 } }, { { "flywheel", 2 }, { "iron-gear-wheel", 4 } }, { { "iron-gear-wheel", 6 } } },
    scrap_types = { { "volcanic-scrap", 1 }, { "plumbing-scrap", 2 }, { "mechanical-scrap", 1 } },
    scrap_limit = 2,
    scrap_yield = 10,
}

tune_up_data.recipes["electric-engine-unit"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "superconductor", 3 }, { "semiboloid-stator", 3 }, { "copper-cable", 1, "byproduct" } }, { { "superconductor", 3 }, { "iron-gear-wheel", 2 }, { "copper-cable", 1, "byproduct" } }, { { "advanced-circuit", 1 }, { "semiboloid-stator", 2 }, { "copper-cable", 1, "byproduct" } }, { { "advanced-circuit", 1 }, { "iron-gear-wheel", 2 }, { "copper-cable", 1, "byproduct" } } },
    scrap_types = { { "superconducting-scrap", 2 }, { "electronic-scrap", 2 }, { "mechanical-scrap", 2 } },
    scrap_yield = 9
}

tune_up_data.recipes["flying-robot-frame"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "supercapacitor", 2 }, { "transceiver", 1 } }, { { "tracker", 1 }, { "electronic-circuit", 1, "byproduct" } }, { { "supercapacitor", 3 } }, { { "transceiver", 2 }, { "battery", 2 } }, { { "advanced-circuit", 2 }, { "battery", 2 } } },
    scrap_types = { { "robotic-scrap", 1 }, { "electronic-scrap", 1 } },
    scrap_yield = 12
}

tune_up_data.recipes["copper-cable"] = {
    categories = { "tuning-up" },
    count = 8,
    energy_required = 2,
    ingredients = { { { "electronic-circuit", 1 } } },
    scrap_types = { { "electrical-scrap", 1 } },
    scrap_yield = 1.5
}

tune_up_data.recipes["electronic-circuit"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "plastic-bar", 1 } } },
    scrap_types = { { "electrical-scrap", 1 } },
    scrap_yield = 0.5
}

tune_up_data.recipes["advanced-circuit"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "sulfuric-acid", 5 }, { "integrated-circuit", 1 }, { "depleted-acid", 5, "force-byproduct" } }, { { "sulfuric-acid", 5 }, { "electronic-circuit", 2 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["processing-unit"] = {
    categories = { "tuning-up" },
    count = 8,
    energy_required = 20,
    ingredients = { { { "speed-module", 1 }, { "efficiency-module", 1 }, { "productivity-module", 1 }, { "quality-module", 1 }, { "advanced-circuit", 4, "byproduct" } } },
    scrap_types = { { "electronic-scrap", 6 }, { "electrical-scrap", 1 } },
    scrap_yield = 100
}

tune_up_data.recipes["speed-module"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "fast-gearbox", 2 } }, { { "electric-motor", 5 }, { "electronic-circuit", 1, "byproduct" } }, { { "iron-gear-wheel", 10 }, { "electronic-circuit", 1, "byproduct" } } },
    scrap_types = { { "electronic-scrap", 2 }, { "robotic-scrap", 10 } },
    scrap_yield = (mods["BrassTacksMk2"] and misc.difficulty > 1) and 20 or 15
}

tune_up_data.recipes["efficiency-module"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "high-pressure-valve", 2 } }, { { "battery", 5 }, { "copper-cable", 3, "byproduct" } } },
    scrap_types = { { "electronic-scrap", 2 }, { "electrical-scrap", 5 } },
    scrap_yield = mods["IfNickel"] and 20 or 10
}

tune_up_data.recipes["productivity-module"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "engine-unit", 2 }, { "plastic-bar", 1, "byproduct" } } },
    scrap_types = { { "electronic-scrap", 2 }, { "plumbing-scrap", 3 }, { "mechanical-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = mods["IfNickel"] and 25 or 15
}

tune_up_data.recipes["quality-module"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "stepper-motor", 2 }, { "electronic-circuit", 1, "byproduct" } }, { { "advanced-circuit", 2 }, { "electronic-circuit", 1, "byproduct" } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 10
}

tune_up_data.recipes["wood"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 1,
    ingredients = { { { "nutrients", 3 }, { "wood", 2 }, { "water", 50 } }, { { "kr-biomass", 1 }, { "wood", 1 }, { "water", 50 } }, { { "sulfur", 1 }, { "wood", 1 }, { "water", 50 } } }
}

tune_up_data.recipes["coal"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 1,
    ingredients = { { { "sulfur", 2 }, { "heavy-oil", 5 } } }
}

tune_up_data.recipes["carbon"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 2,
    ingredients = { { { "coal", 4 }, { "sulfuric-acid", 5 } } }
}

tune_up_data.recipes["sulfur"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 1,
    ingredients = { { { "coal", 2 }, { "petroleum-gas", 5 } } }
}

tune_up_data.recipes["plastic-bar"] = {
    categories = { "purification" },
    count = 3,
    energy_required = 6,
    ingredients = { { { "bioflux", 1 }, { "organotins", 15 } }, { { "bioflux", 1 }, { "petroleum-gas", 5 } }, { { "toluene", 1 }, { "organotins", 15 } }, { { "toluene", 1 }, { "petroleum-gas", 15 } }, { { "plastic-bar", 3 }, { "petroleum-gas", 30 }, { "organotins", 45 } }, { { "plastic-bar", 3 }, { "petroleum-gas", 75 } } }
}

tune_up_data.recipes["rocket-fuel"] = {
    categories = { "purification" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "toluene", 3 }, { "solid-fuel", 5 }, { "light-oil", 15 } }, { { "sulfur", 3 }, { "solid-fuel", 5 }, { "light-oil", 15 } } }
}

tune_up_data.recipes["solid-fuel"] = {
    categories = { "purification" },
    count = 4,
    energy_required = 1,
    ingredients = { { { "toluene", 1 }, { "solid-fuel", 3 }, { "petroleum-gas", 10 } }, { { "coal", 1 }, { "solid-fuel", 3 }, { "petroleum-gas", 10 } } }
}

tune_up_data.recipes["battery"] = {
    categories = { "tuning-up" },
    count = 3,
    energy_required = 3,
    ingredients = { { { "sulfur", 2 }, { "electronic-circuit", 1 } } },
    scrap_types = { { "electrical-scrap", 1 }, { "metal-scrap", 1 } },
    scrap_yield = 2
}

tune_up_data.recipes["explosives"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 2,
    ingredients = { { { "gunpowder", 2 }, { "water", 5 } }, { { "carbon", 1 }, { "water", 5 } }, { { "coal", 1 }, { "light-oil", 10 } } }
}

if not mods["space-age"] then
    tune_up_data.recipes["iron-ore"] = {
        categories = { "purification" },
        count = 5,
        energy_required = 1,
        ingredients = { { { "iron-ore", 5 }, { "stone", 1 }, { "sulfuric-acid", 25 } } }
    }

    tune_up_data.recipes["copper-ore"] = {
        categories = { "purification" },
        count = 5,
        energy_required = 1,
        ingredients = { { { "copper-ore", 5 }, { "stone", 1 }, { "nitric-acid", 25 } }, { { "copper-ore", 5 }, { "stone", 1 }, { "sulfuric-acid", 25 } } }
    }
end

tune_up_data.recipes["stone"] = {
    categories = { "purification" },
    count = mods["space-age"] and 10 or 20,
    energy_required = mods["space-age"] and 5 or 10,
    ingredients = mods["space-age"] and { { { "copper-ore", 2 }, { "iron-ore", 2 }, { "water", 30 } } } or
        { { { "uranium-238", 1 } } }
}

tune_up_data.recipes["stone-brick"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 5,
    ingredients = { { { "stone", 8 }, { "carbon", 1 } }, { { "stone", 8 }, { "coal", 1 } } }
}

tune_up_data.recipes["concrete"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 5,
    ingredients = { { { "galvanized-rod", 1 }, { "stone-brick", 2 } }, { { "iron-stick", 1 }, { "stone-brick", 2 } } }
}

tune_up_data.recipes["refined-concrete"] = {
    categories = { "purification" },
    count = (mods["BrassTacksMk2"] and misc.difficulty == 3) and 10 or 5,
    energy_required = (mods["BrassTacksMk2"] and misc.difficulty == 3) and 10 or 5,
    ingredients = { { { "loadbearing-lattice", 1 }, { "concrete", 10 } }, { { "lead-expansion-bolt", 1 }, { "concrete", 5 } }, { { "iron-stick", 2 }, { "concrete", 5 } } }
}

tune_up_data.recipes["iron-plate"] = {
    categories = { "purification" },
    count = 10,
    energy_required = 10,
    ingredients = { { { "iron-plate", 5 }, { "sulfuric-acid", 50 }, { "calcite", 1 } }, { { "stone", 1 }, { "iron-ore", 10 } } }
}

tune_up_data.recipes["steel-plate"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 10,
    ingredients = { { { "carbon", 3 }, { "sulfuric-acid", 50 }, { "calcite", 1 } }, { { "coal", 2 }, { "iron-ore", 20 } } }
}

tune_up_data.recipes["copper-plate"] = {
    categories = { "purification" },
    count = 10,
    energy_required = 10,
    ingredients = { { { "copper-plate", 5 }, { "nitric-acid", 50 }, { "calcite", 1 } }, { { "copper-plate", 5 }, { "sulfuric-acid", 50 }, { "calcite", 1 } }, { { "stone", 1 }, { "copper-ore", 10 } } }
}

tune_up_data.recipes["calcite"] = {
    categories = { "purification" },
    count = 20,
    energy_required = 10,
    ingredients = { { { "stone", 5 }, { "promethium-asteroid-chunk", 1 } } }
}

tune_up_data.recipes["promethium-asteroid-chunk"] = {
    categories = { "purification" },
    count = 1,
    energy_required = 1,
    surface_conditions = { { property = "pressure", min = 0, max = 0 } },
    ingredients = { { { "uranium-235", 1 } } }
}

tune_up_data.recipes["uranium-238"] = {
    categories = { "purification" },
    count = 100,
    energy_required = 100,
    ingredients = { { { "depleted-uranium-fuel-cell", 1 }, { "sulfuric-acid", 100 } } }
}

tune_up_data.recipes["uranium-235"] = {
    categories = { "purification" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "depleted-uranium-fuel-cell", 1 }, { "sulfuric-acid", 100 } } }
}

tune_up_data.recipes["copper-bacteria"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 2,
    result_is_always_fresh = true,
    ingredients = { { { "copper-bacteria", 1 }, { "philosophers-hormone", 1 }, { "growth-serum", 5 } }, { { "copper-bacteria", 1 }, { "nutrients", 5 }, { "growth-serum", 5 } }, { { "copper-bacteria", 1 }, { "nutrients", 8 } } }
}

tune_up_data.recipes["iron-bacteria"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 2,
    result_is_always_fresh = true,
    ingredients = { { { "iron-bacteria", 1 }, { "philosophers-hormone", 1 }, { "growth-serum", 5 } }, { { "iron-bacteria", 1 }, { "nutrients", 5 }, { "growth-serum", 5 } }, { { "iron-bacteria", 1 }, { "nutrients", 8 } } }
}

tune_up_data.recipes["carbon-fiber"] = {
    categories = { "purification" },
    count = 2,
    energy_required = 10,
    surface_conditions = { { property = "pressure", min = 4000, max = 4000 } },
    ingredients = { { { "carbon", mods["IfNickelMk2"] and 3 or 1 }, { "water", 10 } } }
}

--make the bioflux less depressed
tune_up_data.recipes["bioflux"] = {
    categories = { "purification" },
    count = 10,
    energy_required = 10,
    ingredients = { { { "lithium-plate", 1 }, { "fertilizer-slurry", 100 } }, { { "lithium-plate", 1 } } }
}

tune_up_data.recipes["tungsten-plate"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 20,
    ingredients = { { { "tungsten-ore", 16 }, { "holmium-plate", 1 }, { "electrolyte", 20 } } }
}

tune_up_data.recipes["tungsten-carbide"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 20,
    ingredients = { { { "tungsten-ore", 8 }, { "holmium-plate", 1 }, { "light-oil", 30 } } }
}

tune_up_data.recipes["tungsten-ore"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 10,
    ingredients = { { { "tungsten-ore", 5 }, { "calcite", 1 }, { "zirconium-tungstate", 1 } }, { { "tungsten-ore", 5 }, { "calcite", 1 } } }
}

tune_up_data.recipes["holmium-plate"] = {
    categories = { "purification" },
    count = 10,
    energy_required = 4,
    ingredients = { { { "electrolyte", 50 }, { "holmium-ore", 1 } } }
}

tune_up_data.recipes["holmium-ore"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 2,
    ingredients = { { { "electrolyte", 20 }, { "holmium-ore", 1 }, { "bioflux", 1 } } }
}

tune_up_data.recipes["superconductor"] = {
    categories = { "tuning-up" },
    count = 3,
    energy_required = 2,
    ingredients = { { { "electrolyte", 5 }, { "carbon-fiber", 1 } } }
}

tune_up_data.recipes["supercapacitor"] = {
    categories = { "tuning-up" },
    count = 2,
    energy_required = 4,
    ingredients = { { { "lithium-plate", 1 }, { "tungsten-carbide", 1 }, { "advanced-circuit", 1 } } },
    scrap_types = { { "superconducting-scrap", 1 }, { "electrical-scrap", 1 } },
    scrap_yield = 8
}

tune_up_data.recipes["lithium-plate"] = {
    categories = { "purification" },
    count = 10,
    surface_conditions = {{property="pressure", min=300, max=300}},
    energy_required = 30,
    ingredients = { { { "lithium-plate", 5 }, { "sulfuric-acid", 50 }, { "calcite", 1 } } }
}

tune_up_data.recipes["quantum-processor"] = {
    categories = { "tuning-up" },
    count = 40,
    energy_required = 200,
    ingredients = { { { "speed-module-2", 1 }, { "efficiency-module-2", 1 }, { "productivity-module-2", 1 }, { "quality-module-2", 1 } } },
    scrap_types = { { "electronic-scrap", 5 }, { "electrical-scrap", 1 } },
    scrap_yield = 300
}

tune_up_data.recipes["speed-module-2"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "speed-module", 1 }, { "electric-engine-unit", 5 }, { "lubricant", 30 } } },
    scrap_types = { { "electronic-scrap", 1 }, { "robotic-scrap", 1 } },
    scrap_yield = 25
}

tune_up_data.recipes["efficiency-module-2"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "efficiency-module", 1 }, { "heavy-cable", 5 }, { "petroleum-gas", 30 } }, { { "efficiency-module", 1 }, { "electronic-circuit", 10 }, { "petroleum-gas", 30 } } },
    scrap_types = { { "electronic-scrap", 3 }, {"electrical-scrap", 1} },
    scrap_yield = 20,
}

tune_up_data.recipes["productivity-module-2"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "productivity-module", 1 }, { "flying-robot-frame", 5 }, { "sulfuric-acid", 30 } } },
    scrap_types = { { "electronic-scrap", 1 }, { "robotic-scrap", 2 } },
    scrap_yield = 30
}

tune_up_data.recipes["quality-module-2"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "quality-module", 1 }, { "processing-unit", 5 }, { "light-oil", 30 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 50
}

tune_up_data.recipes["speed-module-3"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "speed-module-2", 1 }, { "quantum-processor", 5 }, { "tungsten-plate", 20 } }, { { "speed-module-2", 1 }, { "processing-unit", 10 }, { "express-transport-belt", 10 } } },
    scrap_types = { { "volcanic-scrap", 1 }, { "electronic-scrap", 100 } },
    scrap_yield = mods["space-age"] and 75 or 150
}

tune_up_data.recipes["efficiency-module-3"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "efficiency-module-2", 1 }, { "quantum-processor", 5 }, { "carbon-fiber", 20 } }, { { "efficiency-module-2", 1 }, { "processing-unit", 10 }, { "solar-panel", 1 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = mods["space-age"] and 75 or 150
}

tune_up_data.recipes["productivity-module-3"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "productivity-module-2", 1 }, { "quantum-processor", 5 }, { "pentapod-egg", 20 } }, { { "productivity-module-2", 1 }, { "processing-unit", 10 }, { "assembling-machine-3", 1 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = mods["space-age"] and 75 or 150
}

tune_up_data.recipes["quality-module-3"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "quality-module-2", 1 }, { "quantum-processor", 5 }, { "supercapacitor", 20 } }, { { "quality-module-2", 1 }, { "processing-unit", 5 }, { "recycler", 1 } } },
    scrap_types = { { "electronic-scrap", 20 }, { "superconducting-scrap", 1 } },
    scrap_yield = mods["space-age"] and 75 or 150
}

tune_up_data.recipes["biter-egg"] = {
    categories = { "purification" },
    count = 1,
    result_is_always_fresh = true,
    energy_required = 5,
    ingredients = { { { "tree-seed", 1 }, { "growth-serum", 10 } }, { { "tree-seed", 1 }, { "nutrients", 5 } } }
}

tune_up_data.recipes["raw-fish"] = {
    categories = { "purification" },
    count = 5,
    result_is_always_fresh = true,
    energy_required = 10,
    ingredients = { { { "tree-seed", 5 }, { "biter-egg", 1 }, { "growth-serum", 5 } }, { { "tree-seed", 5 }, { "biter-egg", 1 } }, { { "raw-fish", 10 }, { "plastic-bar", 10 }, { "water", 50 } } }
}

tune_up_data.recipes["nutrients"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 1,
    ingredients = { { { "spoilage", 5 }, { "fertilizer-slurry", 5 } }, { { "spoilage", 5 } } }
}

tune_up_data.recipes["spoilage"] = {
    categories = { "purification" },
    count = 5,
    energy_required = 1,
    ingredients = { { { "nutrients", 5 } } }
}

tune_up_data.recipes["pentapod-egg"] = {
    categories = { "purification" },
    count = 1,
    result_is_always_fresh = true,
    energy_required = 5,
    ingredients = { { { "iron-bacteria", 2 }, { "nutrients", 10 } } }
}

tune_up_data.recipes["burner-inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "iron-stick", 3 } } },
    scrap_types = { { "mechanical-scrap", 1 } },
    scrap_yield = 1
}

tune_up_data.recipes["inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "iron-gear-wheel", 2 } } },
    scrap_types = { { "mechanical-scrap", 1 } },
    scrap_yield = 3,
}

tune_up_data.recipes["long-handed-inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "linkages", 4 } }, { { "iron-gear-wheel", 4 } } },
    scrap_types = { { "metal-scrap", 1 }, { "mechanical-scrap", 2 } },
    scrap_yield = 5
}

tune_up_data.recipes["fast-inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "electric-motor", 3 } }, { { "electronic-circuit", 3 } } },
    scrap_types = { { "mechanical-scrap", 1 }, { "electrical-scrap", 3 } },
    scrap_yield = 4
}

tune_up_data.recipes["bulk-inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "complex-joint", 2 } }, { { "electric-engine-unit", 2 } } },
    scrap_types = { { "robotic-scrap", 5 }, { "mechanical-scrap", 2 } },
    scrap_yield = 15
}

tune_up_data.recipes["stack-inserter"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "carbon-fiber", 5 }, { "bioflux", 5 }, { "grabber", 1 } }, { { "carbon-fiber", 5 }, { "musculoskeletal-bioculture", 2 }, { "advanced-circuit", 3 } }, { { "carbon-fiber", 5 }, { "bioflux", 5 }, { "advanced-circuit", 5 } }, { { "low-density-structure", 1 }, { "processing-unit", 1 } } },
    scrap_types = { { "robotic-scrap", 10 }, { "electronic-scrap", 1 } },
    scrap_yield = 40
}

tune_up_data.recipes["pipe"] = {
    categories = { "tuning-up" },
    count = 5,
    energy_required = 1,
    ingredients = { { { "airtight-seal", 1 } }, { { "galvanized-steel-plate", 1 } }, { { "steel-plate", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 5
}

tune_up_data.recipes["pump"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "high-pressure-valve", 2 } }, { { "iron-gear-wheel", 3 }, { "pipe-flange", 1 } }, { { "iron-gear-wheel", 3 }, { "pipe", 2 } } },
    scrap_types = { { "plumbing-scrap", 5 }, { "mechanical-scrap", 2 } },
    scrap_yield = mods["IfNickelMk2"] and 15 or 5
}

tune_up_data.recipes["transport-belt"] = {
    categories = { "tuning-up" },
    count = 2,
    energy_required = 1,
    ingredients = { { { "iron-gear-wheel", 1 } } },
    scrap_types = { { "mechanical-scrap", 1 } },
    scrap_yield = 1
}

tune_up_data.recipes["fast-transport-belt"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "flywheel", 2 }, { "rubber", 1 } }, { { "iron-gear-wheel", 3 }, { "rubber", 1 } }, { { "flywheel", 1 }, { "iron-gear-wheel", 2 } }, { { "iron-gear-wheel", 4 } } },
    scrap_types = { { "mechanical-scrap", 1 }, {"metal-scrap", 1} },
    scrap_yield = 4
}

tune_up_data.recipes["express-transport-belt"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "engine-unit", 1 }, { "bearing", 2 }, { "iron-gear-wheel", 1, "byproduct" } }, { { "engine-unit", 1 }, { "iron-gear-wheel", 4 } } },
    scrap_types = { { "mechanical-scrap", 2 }, { "metal-scrap", 1 } },
    scrap_yield = 10
}

tune_up_data.recipes["small-electric-pole"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "wood", 1 } } }
}

tune_up_data.recipes["medium-electric-pole"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "electronic-circuit", 3 } } },
    scrap_types = { { "electrical-scrap", 15 }, { "structural-scrap", 1 } },
    scrap_yield = 4
}

tune_up_data.recipes["big-electric-pole"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "electronic-circuit", 6 }, { "copper-cable", 2 } } },
    scrap_types = { { "electrical-scrap", 15 }, { "structural-scrap", 1 } },
    scrap_yield = 8
}

tune_up_data.recipes["substation"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 3,
    ingredients = { { { "processing-unit", 1 }, { "electrolyte", 25 }, { "copper-cable", 3, "byproduct" } }, { { "processing-unit", 1 }, { "copper-cable", 3, "byproduct" } } },
    scrap_types = { { "electrical-scrap", 5 }, { "electronic-scrap", 1 } },
    scrap_yield = 35
}

tune_up_data.recipes["assembling-machine-1"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "inserter", 3 }, { "iron-gear-wheel", 3 } } },
    scrap_types = { { "electrical-scrap", 1 }, { "mechanical-scrap", 1 } },
    scrap_yield = 15
}

tune_up_data.recipes["assembling-machine-2"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { mods["space-age"] and { { "electric-engine-unit", 2 }, { "advanced-circuit", 3 } } or { { "fast-inserter", 2 }, { "engine-unit", 2 } } },
    scrap_types = { { "robotic-scrap", 2 }, { "electronic-scrap", 1 } },
    scrap_yield = 30
}

tune_up_data.recipes["assembling-machine-3"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "supercapacitor", 5 }, { "tungsten-plate", 5 }, { "carbon-fiber", 5 } }, { { "bulk-inserter", 1 }, { "electric-engine-unit", 5 } } },
    scrap_types = { { "robotic-scrap", 10 }, { "electronic-scrap", 1 } },
    scrap_yield = mods["space-age"] and 20 or 45
}

tune_up_data.recipes["chemical-plant"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "pump", 3 }, { "pipe", 5 } } },
    scrap_types = { { "plumbing-scrap", 3 }, { "structural-scrap", 1 }, { "mechanical-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = mods["IfNickelMk2"] and 30 or 20
}

tune_up_data.recipes["oil-refinery"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "pump", 6 }, { "concrete", 15 } } },
    scrap_types = { { "plumbing-scrap", 3 }, { "structural-scrap", 2 }, { "mechanical-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = mods["IfNickelMk2"] and 60 or 30

}

tune_up_data.recipes["centrifuge"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "electric-engine-unit", 20 }, { "speed-module-2", mods["space-age"] and 2 or 1 } } },
    scrap_types = { { "robotic-scrap", 4 }, { "mechanical-scrap", 10 } },
    scrap_yield = 250
}

tune_up_data.recipes["tune-up-station"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "bulk-inserter", 10 }, { "complex-joint", 10 }, { "processing-unit", 10 } }, { { "bulk-inserter", 10 }, { "processing-unit", 10 } } },
    scrap_types = { { "robotic-scrap", 1 }, { "electronic-scrap", 1 } },
    scrap_yield = 250
}

tune_up_data.recipes["molecular-purifier"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "quality-module-3", 1 }, { "tungsten-carbide", 50 }, { "bioflux", 50 }, { "non-reversible-tremie-pipe", 10 } }, { { "quality-module-3", 1 }, { "tungsten-carbide", 50 }, { "bioflux", 50 } }, { { "quality-module-3", 1 }, { "oil-refinery", 10 }, { "uranium-235", 10 } } },
    scrap_types = { { "volcanic-scrap", 1 }, { "plumbing-scrap", 1 }, { "electronic-scrap", 5 }, {"structural-scrap", 1} },
    scrap_limit = 2,
    scrap_yield = 200
}

tune_up_data.recipes["lab"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "advanced-circuit", 5 } } },
    scrap_types = { { "electrical-scrap", 2 }, { "electronic-scrap", 1 } },
    scrap_yield = 20
}

tune_up_data.recipes["electric-furnace"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "steel-furnace", 1 }, { "cooling-fan", 4 } }, { { "steel-furnace", 1 }, { "heavy-cable", 4 } }, { { "steel-furnace", 1 }, { "electronic-circuit", 10 } } },
    scrap_types = { { "structural-scrap", 10 }, { "electrical-scrap", 1 } },
    scrap_yield = 30
}

tune_up_data.recipes["steel-furnace"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "refined-concrete", 10 } } },
    scrap_types = { { "masonry-scrap", 1 } },
    scrap_yield = 10
}

tune_up_data.recipes["stone-furnace"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "stone-brick", 2 } } },
    scrap_types = { { "masonry-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["beacon"] = {
    categories = { "tuning-up" },
    count = 2,
    energy_required = 15,
    surface_conditions = { { property = "magnetic-field", min = 99, max = 99 } },
    ingredients = { { { "superconductor", 50 }, { "efficiency-module-2", 1 } }, { { "efficiency-module-2", 1 } } },
    scrap_types = { { "superconducting-scrap", 1 }, { "electronic-scrap", 8 } },
    scrap_yield = 125
}

tune_up_data.recipes["burner-mining-drill"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "boiler", 1 } } },
    scrap_types = { { "masonry-scrap", 1 } },
    scrap_yield = 5
}

tune_up_data.recipes["electric-mining-drill"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "engine-unit", 2 }, { "burner-mining-drill", 1 } } },
    scrap_types = { { "structural-scrap", 1 }, { "mechanical-scrap", 4 } },
    scrap_yield = 24
}

tune_up_data.recipes["pumpjack"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "pump", 4 }, { "tungsten-plate", 2 } }, { { "pump", 4 }, { "fluid-regulator", 2 } }, { { "pump", 4 }, { "offshore-pump", 5 } } },
    scrap_types = { { "plumbing-scrap", 3 }, { "mechanical-scrap", 1 } },
    scrap_yield = mods["IfNickelMk2"] and 40 or 25
}

tune_up_data.recipes["offshore-pump"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "pipe", 2 } } },
    scrap_types = { { "plumbing-scrap", 1 }, { "metal-scrap", 1 } },
    scrap_limit = 1,
    scrap_yield = 1
}

tune_up_data.recipes["solar-panel"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "advanced-circuit", 5 }, { "solar-cell", 5 } }, { { "advanced-circuit", 8 } } },
    scrap_types = { { "electrical-scrap", 2 }, { "electronic-scrap", 1 } },
    scrap_yield = 60
}

tune_up_data.recipes["accumulator"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "supercapacitor", 1 } }, { { "battery", 3 } } },
    scrap_types = { { "electrical-scrap", 1 }, { "metal-scrap", 1 } },
    scrap_yield = 5
}

tune_up_data.recipes["boiler"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "stone-furnace", 2 } } },
    scrap_types = { { "masonry-scrap", 1 } },
    scrap_yield = 8
}

tune_up_data.recipes["steam-engine"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "engine-unit", 1 } } },
    scrap_types = { { "plumbing-scrap", 2 }, { "mechanical-scrap", 1 }, { "metal-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = 20
}

tune_up_data.recipes["steam-turbine"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "electric-engine-unit", 5 }, { "high-pressure-valve", 10 }, { "steam-engine", 1 } }, { { "electric-engine-unit", 5 }, { "steam-engine", 2 } } },
    scrap_types = { { "plumbing-scrap", mods["IfNickelMk2"] and 3 or 1 }, { "electrical-scrap", 5 }, { "metal-scrap", 3 } },
    scrap_limit = 2,
    scrap_yield = 75
}

tune_up_data.recipes["heat-exchanger"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "heat-pipe", 1 }, { "tungsten-plate", 5 } }, { { "heat-pipe", 1 }, { "low-density-structure", 5 } } },
    scrap_types = { { "volcanic-scrap", 1 }, { "plumbing-scrap", 2 }, { "structural-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = 50
}

tune_up_data.recipes["nuclear-reactor"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 30,
    ingredients = { { { "heat-pipe", 10 }, { "tungsten-plate", 25 }, { "processing-unit", 50 } }, { { "heat-pipe", 10 }, { "refined-concrete", 100 }, { "processing-unit", 50 } } },
    scrap_types = { { "electronic-scrap", 8 }, { "volcanic-scrap", 1 }, { "structural-scrap", 9 } },
    scrap_yield = 1000
}

tune_up_data.recipes["heat-pipe"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "tungsten-plate", 1 }, { "hardened-hull", 5 } }, { { "tungsten-plate", 2 } }, { { "hardened-hull", 8 }, { "water", 50 } }, { { "steel-plate", 12 }, { "water", 50 } } },
    scrap_types = { { "volcanic-scrap", 1 }, { "structural-scrap", 2 } },
    scrap_yield = 20
}

tune_up_data.recipes["fusion-reactor"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 30,
    ingredients = { { { "fluoroketone-cold", 1000 }, { "quantum-processor", 100 }, { "supercapacitor", 50 }, { "efficiency-module-2", 10 } } },
    scrap_types = { { "superconducting-scrap", 2 }, { "electronic-scrap", 1 } },
    scrap_yield = 1000
}

tune_up_data.recipes["fusion-generator"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "fluoroketone-cold", 500 }, { "quantum-processor", 25 }, { "supercapacitor", 10 }, { "speed-module-2", 2 } } },
    scrap_types = { { "superconducting-scrap", 2 }, { "electronic-scrap", 1 } },
    scrap_yield = 500

}

tune_up_data.recipes["foundry"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "tungsten-plate", 15 }, { "electric-furnace", 3 }, { "express-transport-belt", 10 } } },
    scrap_types = { { "volcanic-scrap", 2 }, { "structural-scrap", 2 }, {"robotic-scrap", 1} },
    scrap_yield = 100

}

tune_up_data.recipes["big-mining-drill"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "productivity-module-2", 1 }, { "electric-mining-drill", 5 }, { "tungsten-plate", 10 } } },
    scrap_types = { { "volcanic-scrap", 2 }, { "robotic-scrap", 2 }, {"mechanical-scrap", 1} },
    scrap_yield = 100
}

tune_up_data.recipes["electromagnetic-plant"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    surface_conditions = { { property = "magnetic-field", min = 99, max = 99 } },
    ingredients = { { { "quality-module-2", 5 }, { "assembling-machine-3", 2 }, { "supercapacitor", 50 } } },
    scrap_types = { { "superconducting-scrap", 1 }, { "robotic-scrap", 1 }, {"electronic-scrap", 2} },
    scrap_yield = 350
}

tune_up_data.recipes["recycler"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    surface_conditions = { { property = "magnetic-field", min = 99, max = 99 } },
    ingredients = { { { "quality-module", 2 }, { "assembling-machine-2", 2 }, { "superconductor", 20 } }, { { "quality-module", 3 }, { "assembling-machine-2", 2 } } },
    scrap_types = { { "robotic-scrap", 2 }, {"mechanical-scrap", 1} },
    scrap_yield = 120
}

tune_up_data.recipes["biochamber"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "jellynut-seed", 1 }, { "yumako-seed", 1 }, { "carbon-fiber", 5 } } },
    scrap_types = { { "plumbing-scrap", 2 }, { "metal-scrap", 2 } },
    scrap_limit = 1,
    scrap_yield = 5
}

--brimstuff enables crafting seeds into equal quality fruits without the need of quality-1 fruits. as such quality seeds are very valuable and there should not be so easy ways to get them.
if mods["BrimStuffMk2"] then
    tune_up_data.recipes["biochamber"].count = 2
    tune_up_data.recipes["biochamber"].ingredients[1][3][2] = 10
    tune_up_data.ReplaceIngredientProportional("biochamber", "jellynut-seed", "jelly", 10)
    tune_up_data.ReplaceIngredientProportional("biochamber", "yumako-seed", "yumako-mash", 5)
else
    tune_up_data.recipes["jellynut-seed"] = {
        categories = { "purification" },
        count = 1,
        energy_required = 3,
        ingredients = { { { "jelly", 5 }, { "bioflux", 1 }, { "growth-serum", 50 } }, { { "jelly", 10 }, { "bioflux", 1 }, { "fertilizer-slurry", 1 } }, { { "jelly", 10 }, { "bioflux", 1 } } }
    }

    tune_up_data.recipes["yumako-seed"] = {
        categories = { "purification" },
        count = 1,
        energy_required = 3,
        ingredients = { { { "yumako-mash", 5 }, { "bioflux", 1 }, { "growth-serum", 50 } }, { { "yumako-mash", 10 }, { "bioflux", 1 }, { "fertilizer-slurry", 1 } }, { { "yumako-mash", 10 }, { "bioflux", 1 } } }
    }
end

tune_up_data.recipes["jellynut"] = {
    categories = { "purification" },
    count = 12,
    energy_required = 6,
    ingredients = { { { "yumako-mash", 1 }, { "jellynut-seed", 1 }, { "growth-serum", 20 } }, { { "yumako-mash", 1 }, { "jellynut-seed", 1 } } }
}

tune_up_data.recipes["yumako"] = {
    categories = { "purification" },
    count = 12,
    energy_required = 6,
    ingredients = { { { "jelly", 2 }, { "yumako-seed", 1 }, { "growth-serum", 20 } }, { { "jelly", 2 }, { "yumako-seed", 1 } } }
}


tune_up_data.recipes["biolab"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "bioflux", 30 }, { "quantum-processor", 10 } } },
    scrap_types = { { "electronic-scrap", 2 }, { "plumbing-scrap", 1 } },
    scrap_yield = 100
}

tune_up_data.recipes["heating-tower"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "steel-furnace", 1 }, { "heat-pipe", 3 } } },
    scrap_types = { { "structural-scrap", 2 }, { "masonry-scrap", 1 } },
    scrap_yield = 60
}

tune_up_data.recipes["lightning-rod"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "rubber", 8 } }, { { "plastic-bar", 5 } } },
    scrap_types = { { "structural-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["lightning-collector"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "efficiency-module", 1 }, { "electrolyte", 20 } } },
    scrap_types = { { "superconducting-scrap", 2 }, { "electrical-scrap", 1 } },
    scrap_yield = 30
}

tune_up_data.recipes["captive-biter-spawner"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "biochamber", 1 }, { "biter-egg", 10 } } }
}

tune_up_data.recipes["cryogenic-plant"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "chemical-plant", 1 }, { "biochamber", 1 }, { "quantum-processor", 5 }, { "fluorine", 30 } } },
    scrap_types = { { "superconducting-scrap", 1 }, { "plumbing-scrap", 2 } },
    scrap_yield = 100
}

tune_up_data.recipes["cargo-bay"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "low-density-structure", 15 } } },
    scrap_types = { { "structural-scrap", 1 } },
    scrap_yield = 50
}

tune_up_data.recipes["crusher"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "tungsten-carbide", 5 }, { "diamond", 5 }, { "express-gearbox", 5 }, { "lubricant", 100 } }, { { "tungsten-carbide", 10 }, { "express-gearbox", 5 }, { "lubricant", 100 } }, { { "tungsten-carbide", 5 }, { "diamond", 5 }, { "electric-engine-unit", 5 }, { "lubricant", 100 } }, { { "tungsten-carbide", 10 }, { "electric-engine-unit", 5 }, { "lubricant", 100 } } },
    scrap_types = { { "mechanical-scrap", 1 }, { "metal-scrap", 4 } },
    scrap_yield = 20
}

tune_up_data.recipes["asteroid-collector"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "stack-inserter", 3 }, { "rocket-control-unit", 5 }, { "lubricant", 100 } }, { { "stack-inserter", 3 }, { "processing-unit", 5 }, { "lubricant", 100 } } },
    scrap_types = { { "electronic-scrap", 2 }, { "robotic-scrap", 10 } },
    scrap_yield = 150
}

tune_up_data.recipes["thruster"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "superconductor", 30 }, { "gimbaled-rocket-engine", 10 }, { "lubricant", 100 } }, { { "superconductor", 30 }, { "pump", 10 }, { "lubricant", 100 } } },
    scrap_types = { { "robotic-scrap", 1 }, { "plumbing-scrap", 5 } },
    scrap_yield = 100
}

tune_up_data.recipes["gun-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "invar-plate", 3 }, { "iron-gear-wheel", 10 }, { "iron-plate", 1, "byproduct" } }, { { "steel-plate", 2 }, { "iron-gear-wheel", 10 }, { "iron-plate", 1, "byproduct" } } },
    scrap_types = { { "mechanical-scrap", 1 } },
    scrap_yield = 12
}

tune_up_data.recipes["flamethrower-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "pump", 5 } } },
    scrap_types = { { "plumbing-scrap", 2 }, { "structural-scrap", 1 }, { "mechanical-scrap", 2 } },
    scrap_limit = 2,
    scrap_yield = mods["IfNickelMk2"] and 50 or 25
}

tune_up_data.recipes["laser-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "processing-unit", 2 }, { "optical-fiber", 10 } }, { { "processing-unit", 2 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 50
}

tune_up_data.recipes["artillery-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "radar", 15 }, { "quality-module-2", 1 } } },
    scrap_types = { { "electronic-scrap", 10 }, { "structural-scrap", 1 } },
    scrap_yield = 100
}

tune_up_data.recipes["artillery-wagon"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "radar", 15 }, { "quality-module-2", 1 } } },
    scrap_types = { { "electronic-scrap", 10 }, { "structural-scrap", 1 } },
    scrap_yield = 100
}

tune_up_data.recipes["railgun-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "tungsten-plate", 50 }, { "quantum-processor", 50 }, { "fluoroketone-cold", 50 } } },
    scrap_types = { { "superconducting-scrap", 1 }, { "volcanic-scrap", 1 } },
    scrap_yield = 200
}

tune_up_data.recipes["tesla-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "tungsten-plate", 10 }, { "superconductor", 50 }, { "laser-turret", 4 } } },
    scrap_types = { { "superconducting-scrap", 10 }, { "structural-scrap", 1 } },
    scrap_yield = 150
}

tune_up_data.recipes["rocket-turret"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "tungsten-plate", 10 }, { "gun-turret", 10 } } },
    scrap_types = { { "mechanical-scrap", 1 }, { "structural-scrap", 1 } },
    scrap_yield = 150
}

tune_up_data.recipes["radar"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "transceiver", 3 } }, { { "advanced-circuit", 4 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 20
}

tune_up_data.recipes["stone-wall"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "refined-concrete", 2 } } },
    scrap_types = { { "masonry-scrap", 1 } },
    scrap_yield = 4
}

tune_up_data.recipes["gate"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "refined-concrete", 2 }, { "iron-gear-wheel", 2 } } },
    scrap_types = { { "structural-scrap", 1 } },
    scrap_yield = 6
}

tune_up_data.recipes["grenade"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "explosives", 5 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["cluster-grenade"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "explosives", 10 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 9
}

tune_up_data.recipes["defender-capsule"] = {
    categories = { "tuning-up" },
    count = 4,
    energy_required = 20,
    ingredients = { { { "gun-turret", 1 } } },
    scrap_types = { { "robotic-scrap", 1 } },
    scrap_yield = 15
}

tune_up_data.recipes["distractor-capsule"] = {
    categories = { "tuning-up" },
    count = 4,
    energy_required = 40,
    ingredients = { { { "laser-turret", 1 } } },
    scrap_types = { { "robotic-scrap", 1 } },
    scrap_yield = 60
}

tune_up_data.recipes["destroyer-capsule"] = {
    categories = { "tuning-up" },
    count = 20,
    energy_required = 320,
    ingredients = { { { "tesla-turret", 1 } }, { { "roboport", 1 } } },
    scrap_types = { { "robotic-scrap", 1 } },
    scrap_yield = 240
}

tune_up_data.recipes["firearm-magazine"] = {
    categories = { "tuning-up" },
    count = 5,
    energy_required = 5,
    ingredients = { { { "steel-plate", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 4
}

tune_up_data.recipes["piercing-rounds-magazine"] = {
    categories = { "tuning-up" },
    count = 5,
    energy_required = 10,
    ingredients = { { { "explosives", 10 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 2
}

tune_up_data.recipes["uranium-rounds-magazine"] = {
    categories = { "tuning-up" },
    count = 10,
    energy_required = 40,
    ingredients = { { { "tungsten-plate", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["shotgun-shell"] = {
    categories = { "tuning-up" },
    count = 5,
    energy_required = 5,
    ingredients = { { { "explosives", 3 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["piercing-shotgun-shell"] = {
    categories = { "tuning-up" },
    count = 5,
    energy_required = 5,
    ingredients = { { { "copper-plate", 10 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 8
}

tune_up_data.recipes["flamethrower-ammo"] = {
    categories = { "purification" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "pipe", 5 }, { "light-oil", 10 } } },
    scrap_types = { { "plumbing-scrap", 1 }, { "metal-scrap", 1 } },
    scrap_limit = 1,
    scrap_yield = 3
}

tune_up_data.recipes["cannon-shell"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "rocket", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 1
}

tune_up_data.recipes["explosive-cannon-shell"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "explosive-rocket", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 1
}

tune_up_data.recipes["rocket"] = {
    categories = { "tuning-up" },
    count = 10,
    energy_required = 30,
    ingredients = { { { "rocket-fuel", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["explosive-rocket"] = {
    categories = { "tuning-up" },
    count = 10,
    energy_required = 30,
    ingredients = { { { "rocket-fuel", 1 }, { "explosives", 15 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 4
}

tune_up_data.recipes["atomic-bomb"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 30,
    ingredients = { { { "quantum-processor", 5 }, { "promethium-asteroid-chunk", 5 } }, { { "rocket-fuel", 10 }, { "uranium-238", 30 } } }
}

tune_up_data.recipes["artillery-shell"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "explosive-cannon-shell", 2 }, { "tungsten-carbide", 4 } }, { { "explosive-cannon-shell", 3 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 20
}

tune_up_data.recipes["railgun-ammo"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "cannon-shell", 1 }, { "electronic-circuit", 3 } } },
    scrap_types = { { "metal-scrap", 2 }, { "electrical-scrap", 1 } },
    scrap_yield = 9
}

tune_up_data.recipes["pistol"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "raw-fish", 1 } } }
}

--rocket launcher and tesla gun are the only personal gun used in crafting.
--other personal guns + armors are such a tiny cost in comparison that i am fine forcing you to upcycle or craft from quality parts
--unclear on grid equipment because it is also used to outfit spidertrons so is in some sense "infrastructure"
tune_up_data.recipes["rocket-launcher"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "laser", misc.difficulty == 3 and 2 or 1 } }, { { "advanced-circuit", 2 } } },
    scrap_types = { { "electronic-scrap", 1 } },
    scrap_yield = 12
}

tune_up_data.recipes["teslagun"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "processing-unit", 5 } } },
    scrap_types = { { "electronic-scrap", 1 }, {"superconducting-scrap", 2} },
    scrap_yield = 60
}

tune_up_data.recipes["roboport"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 10,
    ingredients = { { { "flying-robot-frame", 10 }, mods["space-age"] and { "destroyer-capsule", 5 } or { "distractor-capsule", 10 } } },
    scrap_types = { { "electronic-scrap", 1 }, {"robotic-scrap", 5} },
    scrap_yield = 250
}

tune_up_data.recipes["logistic-robot"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { { "rocket-control-unit", 1 } }, { { "advanced-circuit", 2 }, { "stepper-motor", 1 } }, { { "advanced-circuit", 3 } } },
    scrap_types = { { "electronic-scrap", 1 }, { "robotic-scrap", 5 } },
    scrap_yield = 25
}

tune_up_data.recipes["construction-robot"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 5,
    ingredients = { { "tracker", 1 }, { { "advanced-circuit", 1 }, { "stepper-motor", 1 } }, { { "advanced-circuit", 2 } } },
    scrap_types = { { "electronic-scrap", 1 }, {"robotic-scrap", 5} },
    scrap_yield = 20
}

--too easy!
--[[
tune_up_data.recipes["rocket-silo"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 30,
    ingredients = { { { "quantum-processor", 200 }, { "tungsten-carbide", 400 }, { "carbon-fiber", 400 } }, { { "space-science-pack", 50 }, { "low-density-structure", 200 } } },
    scrap_types = { { "structural-scrap", 4 }, {"robotic-scrap", 1}, {"electronic-scrap", 2} },
    scrap_yield = 3000
}

tune_up_data.recipes["satellite"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 20,
    ingredients = { { { "radar", 25 }, { "roboport", 10 } } },
    scrap_types = { { "robotic-scrap", 5 }, { "electronic-scrap", 2 } },
    scrap_yield = 2000
}
]]--

tune_up_data.recipes["iron-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "galvanized-panel", 5 } }, { { "steel-plate", 1 } } },
    scrap_types = { { "metal-scrap", 1 } },
    scrap_yield = 3
}

tune_up_data.recipes["steel-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 } }, { { "low-density-structure", 1 } } },
    scrap_types = { { "structural-scrap", 1 } },
    scrap_yield = 15
}

tune_up_data.recipes["passive-provider-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"advanced-circuit", 2} } },
    scrap_types = { { "structural-scrap", 2 }, {"electronic-scrap", 1} },
    scrap_yield = 25
}

tune_up_data.recipes["storage-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"advanced-circuit", 2} } },
    scrap_types = { { "structural-scrap", 2 }, {"electronic-scrap", 1} },
    scrap_yield = 25
}

tune_up_data.recipes["active-provider-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 }, {"tracker", 1} }, { { "hardened-hull", 3 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"tracker", 1} }, { { "low-density-structure", 1 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"advanced-circuit", 2} } },
    scrap_types = { { "structural-scrap", 2 }, {"electronic-scrap", 1} },
    scrap_yield = 25
}

tune_up_data.recipes["requester-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 }, {"tracker", 1} }, { { "hardened-hull", 3 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"tracker", 1} }, { { "low-density-structure", 1 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"advanced-circuit", 2} } },
    scrap_types = { { "structural-scrap", 2 }, {"electronic-scrap", 1} },
    scrap_yield = 25
}

tune_up_data.recipes["buffer-chest"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 1,
    ingredients = { { { "hardened-hull", 3 }, {"tracker", 1} }, { { "hardened-hull", 3 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"tracker", 1} }, { { "low-density-structure", 1 }, {"transceiver", 2} }, { { "low-density-structure", 1 }, {"advanced-circuit", 2} } },
    scrap_types = { { "structural-scrap", 2 }, {"electronic-scrap", 1} },
    scrap_yield = 25
}

tune_up_data.recipes["storage-tank"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = { { { "loadbearing-lattice", 5 }, { "galvanized-tubing", 5 } }, { { "high-pressure-valve", 5 }, { "pipe", 5 } }, { { "hardened-hull", 5 }, { "pipe", 5 } }, { { "pump", 4 } } },
    scrap_types = { { "structural-scrap", 5 }, {"plumbing-scrap", 2}, {"metal-scrap", 5}  },
    scrap_limit = 2,
    scrap_yield = 28
}

tune_up_data.recipes["locomotive"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = {{ { "electric-engine-unit", 15 }, { "express-gearbox", 5 } }, { "electric-engine-unit", 15 }, { "iron-gear-wheel", 25 }},
    scrap_types = { {"mechanical-scrap", 5}, {"electrical-scrap", 1} },
    scrap_yield = 100
}

tune_up_data.recipes["cargo-wagon"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = {{ { "steel-chest", 2 }, { "bearing", 4 } }, {{ "steel-chest", 2 }, { "iron-gear-wheel", 8 }}},
    scrap_types = { {"mechanical-scrap", 1}, {"structural-scrap", 5} },
    scrap_yield = 50
}

tune_up_data.recipes["fluid-wagon"] = {
    categories = { "tuning-up" },
    count = 1,
    energy_required = 2,
    ingredients = {{ { "storage-tank", 1 }, { "fluid-regulator", 3 } }, {{ "storage-tank", 1 }, { "pump", 2 }}},
    scrap_types = { {"mechanical-scrap", 1}, {"structural-scrap", 3}, {"plumbing-scrap", 2} },
    scrap_yield = 50
}

local upgrade_item_in_sim = mods["BrassTacksMk2"] and "bearing" or "steel-plate"

require("standardised-scrap")
