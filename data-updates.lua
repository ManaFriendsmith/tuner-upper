local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["space-age"] and mods["LasingAroundMk2"] and misc.difficulty == 3 then
    data.raw.item["antimatter-power-cell"].fuel_categories = {"antimatter", "exotic"}
end

if settings.startup["tuner-upper-byproducts"].value == "Standardised" then
    rm.AddProduct("automation-science-pack", "metal-scrap")
    tm.AddUnlock("automation-science-pack", "metal-scrap-compacting")
    tm.AddUnlock("recycling", "metal-scrap-recycling")

    rm.AddProduct("logistic-science-pack", "mechanical-scrap", 2)
    tm.AddUnlock("logistic-science-pack", "mechanical-scrap-compacting")
    tm.AddUnlock("recycling", "mechanical-scrap-recycling")

    rm.AddProduct("military-science-pack", "masonry-scrap", 2)
    rm.AddProduct("military-science-pack", "metal-scrap", 2)
    tm.AddUnlock("military-science-pack", "masonry-scrap-compacting")
    tm.AddUnlock("tune-up-station", "masonry-scrap-compacting")
    tm.AddUnlock("recycling", "masonry-scrap-recycling")

    rm.AddProduct("chemical-science-pack", "electronic-scrap", 2)
    rm.AddProduct("chemical-science-pack", "mechanical-scrap", 3)
    tm.AddUnlock("chemical-science-pack", "electronic-scrap-compacting")
    tm.AddUnlock("chemical-science-pack", "electrical-scrap-compacting")
    tm.AddUnlock("recycling", "electrical-scrap-recycling")
    tm.AddUnlock("recycling", "electronic-scrap-recycling")

    rm.AddProduct("production-science-pack", "electronic-scrap", 10)
    rm.AddProduct("production-science-pack", "structural-scrap", 4)
    rm.AddProduct("production-science-pack", "metal-scrap", 10)
    tm.AddUnlock("production-science-pack", "structural-scrap-compacting")
    tm.AddUnlock("tune-up-station", "structural-scrap-compacting")
    tm.AddUnlock("recycling", "structural-scrap-recycling")

    rm.AddProduct("utility-science-pack", "metal-scrap", 10)
    rm.AddProduct("utility-science-pack", "robotic-scrap", 5)
    rm.AddProduct("utility-science-pack", "electronic-scrap", 5)
    tm.AddUnlock("utility-science-pack", "robotic-scrap-compacting")
    tm.AddUnlock("tune-up-station", "robotic-scrap-compacting")
    tm.AddUnlock("recycling", "robotic-scrap-recycling")

    if data.raw.item["plumbing-scrap"] then
        tm.AddUnlock("tune-up-station", "plumbing-scrap-compacting")
        tm.AddUnlock("recycling", "plumbing-scrap-recycling")
    end

    if mods["space-age"] then
        rm.AddProduct("metallurgic-science-pack", "volcanic-scrap", 2)
        tm.AddUnlock("metallurgic-science-pack", "volcanic-scrap-compacting")
        tm.AddUnlock("recycling", "volcanic-scrap-recycling")

        rm.AddProduct("electromagnetic-science-pack", "superconducting-scrap", 1)
        tm.AddUnlock("recycling", "superconducting-scrap-compacting")
        tm.AddUnlock("recycling", "superconducting-scrap-recycling")

        data.raw.item["supercapacitor"].burnt_result = "superconducting-scrap"
        data.raw.item["geothermal-power-cell"].burnt_result = "volcanic-scrap"
    end
end

data:extend({
    {
        type = "tips-and-tricks-item",
        name = "new-quality-mechanics",
        tag = "[item=tune-up-station]",
        category = "quality",
        order = "d",
        indent = 1,
        trigger =
        {
            type = "unlock-recipe",
            recipe = "quality-module"
        },
        skip_trigger =
        {
            type = "build-entity",
            quality = "uncommon",
            count = 10
        },
        simulation = {
            init_update_count = 600,
            init =
            [[
        game.simulation.camera_zoom = 1
        game.simulation.camera_alt_info = true
        game.surfaces[1].build_checkerboard{{-40, -40}, {40, 40}}
        game.surfaces[1].create_entities_from_blueprint_string
        {
          string = "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",
          position = {0,0},
        }

        game.forces.player.technologies["quality-module"].researched = true
        game.forces.player.technologies["bulk-inserter"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-1"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-2"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-3"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-4"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-5"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-6"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-7"].researched = true

        if script.active_mods["BrassTacksMk2"] then
          local chests = game.surfaces[1].find_entities_filtered{name = "infinity-chest"}
          for k, v in pairs(chests) do
            local filter = v.get_infinity_container_filter(1)
            if filter and filter.name == "steel-plate" then
              v.set_infinity_container_filter(1, {name="bearing", count=100})
            end
          end
        end
      ]]
        }
    },
    {
        type = "tips-and-tricks-item",
        name = "recyclers-and-quality",
        tag = "[item=recycler]",
        category = "quality",
        order = "e",
        indent = 1,
        trigger =
        {
            type = "build-entity",
            entity = "recycler",
            count = 1
        },
        skip_trigger =
        {
            type = "build-entity",
            entity = "recycler",
            count = 20
        },
        simulation = {
            init_update_count = 600,
            init =
            [[
        game.simulation.camera_alt_info = true
        game.surfaces[1].build_checkerboard{{-40, -40}, {40, 40}}
        game.surfaces[1].create_entities_from_blueprint_string
        {
          string = "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",
          position = {2,0},
        }

        game.forces.player.technologies["quality-module"].researched = true
        game.forces.player.technologies["recycling"].researched = true
        game.forces.player.technologies["steam-power"].researched = true
        game.forces.player.technologies["bulk-inserter"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-1"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-2"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-3"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-4"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-5"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-6"].researched = true
        game.forces.player.technologies["inserter-capacity-bonus-7"].researched = true
      ]]
        }
    }
})

data.raw["tips-and-tricks-item"]["quality-probabilities"] = nil

--require("bz-compat")
--require("ll-compat")
--require("kras-compat")

if settings.startup["tuner-upper-extra-tiers"].value ~= "Off" then
    if settings.startup["tuner-upper-extra-tiers"].value == "+3" then
        if mods["space-age"] then
            tm.RemoveSciencePack("epic-quality", "agricultural-science-pack")
            tm.AddSciencePack("epic-quality", "space-science-pack")
            tm.RemovePrerequisite("epic-quality", "agricultural-science-pack")
            tm.AddPrerequisite("epic-quality", "space-science-pack")

            tm.RemoveSciencePack("legendary-quality", "cryogenic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "metallurgic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "electromagnetic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "production-science-pack")
            tm.AddSciencePack("legendary-quality", "agricultural-science-pack")
            tm.RemovePrerequisite("legendary-quality", "cryogenic-science-pack")
            tm.AddPrerequisite("legendary-quality", "agricultural-science-pack")

            tm.SetTechnologyCost("epic-quality", 1500)
            tm.SetTechnologyCost("legendary-quality", 3000)
        else
            tm.RemoveSciencePack("epic-quality", "utility-science-pack")
            tm.RemoveSciencePack("epic-quality", "production-science-pack")
            tm.RemovePrerequisite("epic-quality", "utility-science-pack")
            tm.RemovePrerequisite("epic-quality", "production-science-pack")

            tm.RemovePrerequisite("legendary-quality", "space-science-pack")
            tm.AddPrerequisite("legendary-quality", "utility-science-pack")
            tm.RemoveSciencePack("legendary-quality", "space-science-pack")
            tm.RemoveSciencePack("legendary-quality", "production-science-pack")

            tm.SetTechnologyCost("epic-quality", 500)
            tm.SetTechnologyCost("legendary-quality", 750)
        end
        data:extend({
            {
                type = "technology",
                name = "glorious-quality",
                icon = "__tuner-upper__/graphics/icons/glorious_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "glorious" } },
                prerequisites = mods["space-age"] and { "legendary-quality", "electromagnetic-science-pack" } or
                    { "legendary-quality" },
                unit = {
                    count = mods["space-age"] and 10000 or 1000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "utility-science-pack",    1 }
                    }
                }
            },
            {
                type = "technology",
                name = "eternal-quality",
                icon = "__tuner-upper__/graphics/icons/eternal_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "eternal" } },
                prerequisites = mods["space-age"] and
                    { "glorious-quality", "metallurgic-science-pack", "production-science-pack" } or
                    { "glorious-quality", "production-science-pack" },
                unit = {
                    count = mods["space-age"] and 20000 or 2000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "production-science-pack",      1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 },
                        { "metallurgic-science-pack",     1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "utility-science-pack",    1 },
                        { "production-science-pack", 1 }
                    }
                }
            },
            {
                type = "technology",
                name = "transcendent-quality",
                icon = "__tuner-upper__/graphics/icons/transcendent_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "transcendent" } },
                prerequisites = mods["space-age"] and
                    { "glorious-quality", "cryogenic-science-pack", "military-science-pack" } or
                    { "glorious-quality", "space-science-pack" },
                unit = {
                    count = mods["space-age"] and 50000 or 5000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "military-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 },
                        { "metallurgic-science-pack",     1 },
                        { "cryogenic-science-pack",       1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "utility-science-pack",    1 },
                        { "production-science-pack", 1 },
                        { "space-science-pack",      1 },
                    }
                }
            },
            {
                type = "quality",
                name = "legendary",
                level = 4,
                color = { 178, 104, 0 },
                order = "e",
                next = "glorious",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__quality__/graphics/icons/quality-legendary.png",
                science_pack_drain_multiplier = 96 / 100,
                cargo_wagon_inventory_size_multiplier = 2,
                locomotive_power_multiplier = 1.8,
                rolling_stock_max_speed_multiplier = 1.12
            },
            {
                type = "quality",
                name = "glorious",
                level = 5,
                color = { 255, 255, 64 },
                order = "f",
                next = "eternal",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/glorious.png",
                science_pack_drain_multiplier = 95 / 100,
                cargo_wagon_inventory_size_multiplier = 2.25,
                locomotive_power_multiplier = 2,
                rolling_stock_max_speed_multiplier = 1.15
            },
            {
                type = "quality",
                name = "eternal",
                level = 6,
                color = { 40, 255, 160 },
                order = "g",
                next = "transcendent",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/eternal.png",
                science_pack_drain_multiplier = 94 / 100,
                cargo_wagon_inventory_size_multiplier = 2.5,
                locomotive_power_multiplier = 2.2,
                rolling_stock_max_speed_multiplier = 1.18
            },
            {
                type = "quality",
                name = "transcendent",
                level = 8,
                color = { 255, 192, 192 },
                order = "h",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/transcendent.png",
                science_pack_drain_multiplier = 92 / 100,
                cargo_wagon_inventory_size_multiplier = 3,
                locomotive_power_multiplier = 2.6,
                rolling_stock_max_speed_multiplier = 1.24
            },
        })

        local multipliers = {
            normal = 1,
            uncommon = 5 / 6,
            rare = 2 / 3,
            epic = 1 / 2,
            legendary = 1 / 3,
            glorious = 1 / 5,
            eternal = 1 / 6,
            transcendent = 1 / 10
        }

        for k, v in pairs(multipliers) do
            data.raw.quality[k].beacon_power_usage_multiplier = v
            data.raw.quality[k].mining_drill_resource_drain_multiplier = v
        end
    else
        if mods["space-age"] then
            tm.RemoveSciencePack("epic-quality", "agricultural-science-pack")
            tm.RemoveSciencePack("epic-quality", "utility-science-pack")
            tm.AddSciencePack("epic-quality", "space-science-pack")
            tm.RemovePrerequisite("epic-quality", "agricultural-science-pack")
            tm.RemovePrerequisite("epic-quality", "utility-science-pack")
            tm.AddPrerequisite("epic-quality", "space-science-pack")

            tm.RemoveSciencePack("legendary-quality", "cryogenic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "metallurgic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "electromagnetic-science-pack")
            tm.RemoveSciencePack("legendary-quality", "production-science-pack")
            tm.RemoveSciencePack("legendary-quality", "agricultural-science-pack")
            tm.RemovePrerequisite("legendary-quality", "cryogenic-science-pack")
            tm.AddPrerequisite("legendary-quality", "utility-science-pack")

            tm.SetTechnologyCost("epic-quality", 1500)
            tm.SetTechnologyCost("legendary-quality", 3000)
        else
            tm.RemoveSciencePack("epic-quality", "utility-science-pack")
            tm.RemoveSciencePack("epic-quality", "production-science-pack")
            tm.RemoveSciencePack("epic-quality", "chemical-science-pack")
            tm.RemovePrerequisite("epic-quality", "utility-science-pack")
            tm.RemovePrerequisite("epic-quality", "production-science-pack")

            tm.RemovePrerequisite("legendary-quality", "space-science-pack")
            tm.AddPrerequisite("legendary-quality", "chemical-science-pack")
            tm.RemoveSciencePack("legendary-quality", "space-science-pack")
            tm.RemoveSciencePack("legendary-quality", "utility-science-pack")
            tm.RemoveSciencePack("legendary-quality", "production-science-pack")

            tm.SetTechnologyCost("epic-quality", 500)
            tm.SetTechnologyCost("legendary-quality", 750)
        end
        data:extend({
            {
                type = "technology",
                name = "glorious-quality",
                icon = "__tuner-upper__/graphics/icons/glorious_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "glorious" } },
                prerequisites = mods["space-age"] and { "legendary-quality", "agricultural-science-pack" } or
                    { "legendary-quality", "utility-science-pack" },
                unit = {
                    count = mods["space-age"] and 10000 or 1000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",   1 },
                        { "logistic-science-pack",     1 },
                        { "chemical-science-pack",     1 },
                        { "space-science-pack",        1 },
                        { "utility-science-pack",      1 },
                        { "agricultural-science-pack", 1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "utility-science-pack",    1 }
                    }
                }
            },
            {
                type = "technology",
                name = "eternal-quality",
                icon = "__tuner-upper__/graphics/icons/eternal_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "eternal" } },
                prerequisites = mods["space-age"] and { "glorious-quality", "electromagnetic-science-pack" } or
                    { "glorious-quality", "production-science-pack" },
                unit = {
                    count = mods["space-age"] and 20000 or 2000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "production-science-pack", 1 },
                        { "utility-science-pack",    1 }
                    }
                }
            },
            {
                type = "technology",
                name = "transcendent-quality",
                icon = "__tuner-upper__/graphics/icons/transcendent_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "transcendent" } },
                prerequisites = mods["space-age"] and
                    { "eternal-quality", "metallurgic-science-pack", "production-science-pack" } or
                    { "eternal-quality", "military-science-pack" },
                unit = {
                    count = mods["space-age"] and 30000 or 3000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "production-science-pack",      1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 },
                        { "metallurgic-science-pack",     1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "military-science-pack",   1 },
                        { "utility-science-pack",    1 },
                        { "production-science-pack", 1 }
                    }
                }
            },
            {
                type = "technology",
                name = "eldritch-quality",
                icon = "__tuner-upper__/graphics/icons/eldritch_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "eldritch" } },
                prerequisites = mods["space-age"] and
                    { "transcendent-quality", "cryogenic-science-pack", "military-science-pack" } or
                    { "transcendent-quality", "space-science-pack" },
                unit = {
                    count = mods["space-age"] and 50000 or 5000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "military-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 },
                        { "metallurgic-science-pack",     1 },
                        { "cryogenic-science-pack",       1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "military-science-pack",   1 },
                        { "utility-science-pack",    1 },
                        { "production-science-pack", 1 },
                        { "space-science-pack",      1 },
                    }
                }
            },
            {
                type = "technology",
                name = "newtronic-quality",
                icon = "__tuner-upper__/graphics/icons/newtronic_256.png",
                icon_size = 256,
                effects = { { type = "unlock-quality", quality = "newtronic" } },
                prerequisites = mods["space-age"] and { "eldritch-quality", "promethium-science-pack" } or
                    { "eldritch-quality", "space-science-pack" },
                unit = {
                    count = mods["space-age"] and 1000000 or 10000,
                    time = 60,
                    ingredients = mods["space-age"] and {
                        { "automation-science-pack",      1 },
                        { "logistic-science-pack",        1 },
                        { "chemical-science-pack",        1 },
                        { "military-science-pack",        1 },
                        { "space-science-pack",           1 },
                        { "utility-science-pack",         1 },
                        { "agricultural-science-pack",    1 },
                        { "electromagnetic-science-pack", 1 },
                        { "metallurgic-science-pack",     1 },
                        { "cryogenic-science-pack",       1 },
                        { "promethium-science-pack",      1 }
                    } or {
                        { "automation-science-pack", 1 },
                        { "logistic-science-pack",   1 },
                        { "chemical-science-pack",   1 },
                        { "utility-science-pack",    1 },
                        { "production-science-pack", 1 },
                        { "space-science-pack",      1 },
                    }
                }
            },
            {
                type = "quality",
                name = "legendary",
                level = 4,
                color = { 178, 104, 0 },
                order = "e",
                next = "glorious",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__quality__/graphics/icons/quality-legendary.png",
                science_pack_drain_multiplier = 96 / 100,
                cargo_wagon_inventory_size_multiplier = 2,
                locomotive_power_multiplier = 1.8,
                rolling_stock_max_speed_multiplier = 1.12
            },
            {
                type = "quality",
                name = "glorious",
                level = 5,
                color = { 255, 255, 64 },
                order = "f",
                next = "eternal",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/glorious.png",
                science_pack_drain_multiplier = 95 / 100,
                cargo_wagon_inventory_size_multiplier = 2.25,
                locomotive_power_multiplier = 2,
                rolling_stock_max_speed_multiplier = 1.15
            },
            {
                type = "quality",
                name = "eternal",
                level = 6,
                color = { 40, 255, 160 },
                order = "g",
                next = "transcendent",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/eternal.png",
                science_pack_drain_multiplier = 94 / 100,
                cargo_wagon_inventory_size_multiplier = 2.5,
                locomotive_power_multiplier = 2.2,
                rolling_stock_max_speed_multiplier = 1.18
            },
            {
                type = "quality",
                name = "transcendent",
                level = 7,
                color = { 255, 192, 192 },
                order = "h",
                next = "eldritch",
                next_probability = 1,
                chain_probability = 0,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/transcendent.png",
                science_pack_drain_multiplier = 93 / 100,
                cargo_wagon_inventory_size_multiplier = 2.75,
                locomotive_power_multiplier = 2.4,
                rolling_stock_max_speed_multiplier = 1.21
            },
            {
                type = "quality",
                name = "eldritch",
                level = 8,
                color = { 96, 0, 48 },
                order = "i",
                next = "newtronic",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/eldritch.png",
                science_pack_drain_multiplier = 92 / 100,
                cargo_wagon_inventory_size_multiplier = 3,
                locomotive_power_multiplier = 2.6,
                rolling_stock_max_speed_multiplier = 1.24
            },
            {
                type = "quality",
                name = "newtronic",
                level = 10,
                color = { 64, 144, 255 },
                order = "j",
                next_probability = 1,
                chain_probability = 0.1,
                subgroup = "qualities",
                icon = "__tuner-upper__/graphics/icons/newtronic.png",
                science_pack_drain_multiplier = 90 / 100,
                cargo_wagon_inventory_size_multiplier = 3.5,
                locomotive_power_multiplier = 3,
                rolling_stock_max_speed_multiplier = 1.3
            }
        })


        local multipliers = {
            normal = 1,
            uncommon = 5 / 6,
            rare = 2 / 3,
            epic = 1 / 2,
            legendary = 1 / 3,
            glorious = 1 / 5,
            eternal = 1 / 6,
            transcendent = 1 / 8,
            eldritch = 1 / 10,
            newtronic = 1 / 12
        }

        for k, v in pairs(multipliers) do
            data.raw.quality[k].beacon_power_usage_multiplier = v
            data.raw.quality[k].mining_drill_resource_drain_multiplier = v
        end
    end
else
    if not mods["space-age"] then
        tm.RemoveSciencePack("epic-quality", "production-science-pack")
        tm.RemovePrerequisite("epic-quality", "production-science-pack")
        tm.SetTechnologyCost("epic-quality", 750)
    end
end

tm.SetTechnologyCost("quality-module", 50)
if not mods["space-age"] then
    tm.SetTechnologyCost("recycling", 300)
end
