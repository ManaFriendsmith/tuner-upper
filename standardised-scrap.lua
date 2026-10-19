local misc = require("__pf-functions__/misc")
local item_sounds = require("__base__/prototypes/item_sounds")

if settings.startup["tuner-upper-byproducts"].value ~= "Standardised" then
    return
end

local function recycling_icon(icon)
    return {
        {
            icon = "__recycler__/graphics/icons/recycling.png",
            icon_size = 64
        },
        {
            icon = icon,
            icon_size = 64,
            scale = 0.37
        },
        {
            icon = "__recycler__/graphics/icons/recycling-top.png",
            icon_size = 64
        }
    }
end

local function crushing_icon(icon)
    return {
        {
            icon = icon,
            icon_size = 64,
            scale = 0.37
        },
        {
            icon = "__tuner-upper__/graphics/icons/crush-overlay.png",
            icon_size = 64
        }
    }
end

data:extend({
    {
        type = "item-subgroup",
        name = "tuning-scrap",
        order = "ii",
        group = "intermediate-products"
    },

    {
        type = "item",
        name = "metal-scrap",
        icon = "__tuner-upper__/graphics/icons/metal-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "a1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "metal-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.metal-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/metal-scrap.png"),
        subgroup = "tuning-scrap",
        order = "a2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "metal-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = "iron-plate", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "metal-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.metal-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/metal-scrap.png"),
        subgroup = "tuning-scrap",
        order = "a3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "metal-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-plate", amount = 1, independent_probability = 0.15 },
            { type = "item", name = "copper-plate", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "iron-stick", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "steel-plate", amount = 1, independent_probability = 0.01 },
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "electrical-scrap",
        icon = "__tuner-upper__/graphics/icons/electrical-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "b1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "electrical-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.electrical-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/electrical-scrap.png"),
        subgroup = "tuning-scrap",
        order = "b2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "electrical-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = "copper-plate", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "electrical-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.electrical-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/electrical-scrap.png"),
        subgroup = "tuning-scrap",
        order = "b3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "electrical-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "copper-plate", amount = 1, independent_probability = 0.1 },
            { type = "item", name = "copper-cable", amount = 1, independent_probability = 0.15 },
            { type = "item", name = "electronic-circuit", amount = 1, independent_probability = 0.03 },
            { type = "item", name = "battery", amount = 1, independent_probability = 0.01 },
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "masonry-scrap",
        icon = "__tuner-upper__/graphics/icons/masonry-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "c1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "masonry-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.masonry-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/masonry-scrap.png"),
        subgroup = "tuning-scrap",
        order = "c2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "masonry-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = "stone", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "masonry-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.masonry-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/masonry-scrap.png"),
        subgroup = "tuning-scrap",
        order = "c3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "masonry-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "stone", amount = 1, independent_probability = 0.15 },
            { type = "item", name = "stone-brick", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "concrete", amount = 1, independent_probability = 0.01 }
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "structural-scrap",
        icon = "__tuner-upper__/graphics/icons/structural-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "d1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "structural-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.structural-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/structural-scrap.png"),
        subgroup = "tuning-scrap",
        order = "d2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "structural-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = "steel-plate", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "structural-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.structural-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/structural-scrap.png"),
        subgroup = "tuning-scrap",
        order = "d3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "structural-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "steel-plate", amount = 1, independent_probability = 0.15 },
            { type = "item", name = "concrete", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "iron-stick", amount = 1, independent_probability = 0.1 },
            { type = "item", name = "metal-scrap", amount = 1, independent_probability = 0.4 },
            { type = "item", name = "masonry-scrap", amount = 1, independent_probability = 0.4 }
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "mechanical-scrap",
        icon = "__tuner-upper__/graphics/icons/mechanical-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "e1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "mechanical-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.mechanical-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/mechanical-scrap.png"),
        subgroup = "tuning-scrap",
        order = "e2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "mechanical-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = mods["BrassTacksMk2"] and  "brass-plate" or "iron-plate", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "mechanical-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.mechanical-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/mechanical-scrap.png"),
        subgroup = "tuning-scrap",
        order = "e3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "mechanical-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "iron-plate", amount = 1, independent_probability = mods["BrassTacksMk2"] and 0.1 or 0.15 },
            { type = "item", name = "iron-gear-wheel", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "pipe", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "metal-scrap", amount = 1, independent_probability = 0.1 }
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "electronic-scrap",
        icon = "__tuner-upper__/graphics/icons/electronic-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "f1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "electronic-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.electronic-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/electronic-scrap.png"),
        subgroup = "tuning-scrap",
        order = "f2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "electronic-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = mods["ThemTharHillsMk2"] and "gold-plate" or "copper-plate", amount = 1 },
            { type = "item", name = "plastic-bar", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "electronic-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.electronic-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/electronic-scrap.png"),
        subgroup = "tuning-scrap",
        order = "f3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "electronic-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = mods["ThemTharHillsMk2"] and "gold-wire" or "copper-cable", amount = 1, independent_probability = 0.5 },
            { type = "item", name = "plastic-bar", amount = 1, independent_probability = 0.1 },
            { type = "item", name = "electronic-circuit", amount = 1, independent_probability = 0.1 },
            { type = "item", name = "advanced-circuit", amount = 1, independent_probability = 0.05 },
            { type = "item", name = "electrical-scrap", amount = 1, independent_probability = 0.2 }
        },
        energy_required = 0.2,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },

    {
        type = "item",
        name = "robotic-scrap",
        icon = "__tuner-upper__/graphics/icons/robotic-scrap.png",
        icon_size = 64,
        subgroup = "tuning-scrap",
        order = "g1",
        flags = {"always-show"},
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 0.1,
        auto_recycle = false,
        weight = 1*kg
    },
    {
        type = "recipe",
        name = "robotic-scrap-compacting",
        localised_name = {"recipe-name.compacting", {"item-name.robotic-scrap"}},
        icons = crushing_icon("__tuner-upper__/graphics/icons/robotic-scrap.png"),
        subgroup = "tuning-scrap",
        order = "g2",
        categories = { "crafting" },
        auto_recycle = false,
        ingredients = {
            { type = "item", name = "robotic-scrap", amount = 10 }
        },
        results = {
            { type = "item", name = mods["IfNickelMk2"] and "nickel-plate" or "copper-plate", amount = 1 },
            { type = "item", name = "iron-plate", amount = 1 }
        },
        enabled = false,
        energy_required = 5,
        unlock_results = false,
        allow_productivity = false,
        allow_quality = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    },
    {
        type = "recipe",
        name = "robotic-scrap-recycling",
        localised_name = {"recipe-name.recycling", {"item-name.robotic-scrap"}},
        icons = recycling_icon("__tuner-upper__/graphics/icons/robotic-scrap.png"),
        subgroup = "tuning-scrap",
        order = "g3",
        categories = { "recycling" },
        auto_recycle = false,
        enabled = false,
        ingredients = {
            { type = "item", name = "robotic-scrap", amount = 1 }
        },
        results = {
            { type = "item", name = "metal-scrap", amount = 1, independent_probability = 0.9 },
            { type = "item", name = "electrical-scrap", amount = 1, independent_probability = 0.9 },
            { type = "item", name = "mechanical-scrap", amount = 1, independent_probability = 0.8 },
            { type = "item", name = "electronic-scrap", amount = 1, independent_probability = 0.8 },
            { type = "item", name = "flying-robot-frame", amount = 1, independent_probability = 0.01 },
            { type = "item", name = "electric-engine-unit", amount = 1, independent_probability = 0.01 },
            { type = "item", name = "fast-inserter", amount = 1, independent_probability = 0.01 },
        },
        energy_required = 0.5,
        unlock_results = false,
        allow_productivity = false,
        allow_decomposition = false,
        allow_as_intermediate = false,
    }
})

if mods["IfNickelMk2"] or ((mods["BrassTacksMk2"] or mods["BrimStuffMk2"]) and misc.difficulty > 1) then
    data:extend({
        {
            type = "item",
            name = "plumbing-scrap",
            icon = "__tuner-upper__/graphics/icons/plumbing-scrap.png",
            icon_size = 64,
            subgroup = "tuning-scrap",
            order = "h1",
            flags = {"always-show"},
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 50,
            default_import_location = "nauvis",
            canonical_cost = 0.1,
            auto_recycle = false,
            weight = 1*kg
        },
        {
            type = "recipe",
            name = "plumbing-scrap-compacting",
            localised_name = {"recipe-name.compacting", {"item-name.plumbing-scrap"}},
            icons = crushing_icon("__tuner-upper__/graphics/icons/plumbing-scrap.png"),
            subgroup = "tuning-scrap",
            order = "h2",
            categories = { "crafting" },
            auto_recycle = false,
            ingredients = {
                { type = "item", name = "plumbing-scrap", amount = 10 }
            },
            results = {
                { type = "item", name = mods["bzlead"] and "lead-plate" or "iron-plate", amount = 1 }
            },
            enabled = false,
            energy_required = 5,
            unlock_results = false,
            allow_productivity = false,
            allow_quality = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        },
        {
            type = "recipe",
            name = "plumbing-scrap-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.plumbing-scrap"}},
            icons = recycling_icon("__tuner-upper__/graphics/icons/plumbing-scrap.png"),
            subgroup = "tuning-scrap",
            order = "h3",
            categories = { "recycling" },
            auto_recycle = false,
            enabled = false,
            ingredients = {
                { type = "item", name = "plumbing-scrap", amount = 1 }
            },
            results = {
                { type = "item", name = mods["bzlead"] and "lead-plate" or "iron-plate", amount = 1, independent_probability = 0.15 },
                { type = "item", name = "pipe", amount = 1, independent_probability = 0.1 },
                { type = "item", name = "mechanical-scrap", amount = 1, independent_probability = 0.1 },
                { type = "item", name = "pump", amount = 1, independent_probability = 0.01 }
            },
            energy_required = 0.2,
            unlock_results = false,
            allow_productivity = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        }
    })

    data.raw.recipe["mechanical-scrap-recycling"].results[3].name = "plumbing-scrap"
end

if mods["BrassTacksMk2"] then
    table.insert(data.raw.recipe["mechanical-scrap-recycling"].results, 2, {type="item", name="brass-plate", amount=1, independent_probability=0.1})
end

if mods["space-age"] then
    data:extend({
        {
            type = "item",
            name = "volcanic-scrap",
            icon = "__tuner-upper__/graphics/icons/volcanic-scrap.png",
            icon_size = 64,
            subgroup = "tuning-scrap",
            order = "i1",
            flags = {"always-show"},
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 50,
            default_import_location = "nauvis",
            canonical_cost = 0.1,
            auto_recycle = false,
            weight = 1*kg
        },
        {
            type = "recipe",
            name = "volcanic-scrap-compacting",
            localised_name = {"recipe-name.compacting", {"item-name.volcanic-scrap"}},
            icons = crushing_icon("__tuner-upper__/graphics/icons/volcanic-scrap.png"),
            subgroup = "tuning-scrap",
            order = "i2",
            categories = { "crafting" },
            auto_recycle = false,
            ingredients = {
                { type = "item", name = "volcanic-scrap", amount = 10 }
            },
            results = {
                { type = "item", name = "tungsten-ore", amount = 1 }
            },
            enabled = false,
            energy_required = 5,
            unlock_results = false,
            allow_productivity = false,
            allow_quality = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        },
        {
            type = "recipe",
            name = "volcanic-scrap-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.volcanic-scrap"}},
            icons = recycling_icon("__tuner-upper__/graphics/icons/volcanic-scrap.png"),
            subgroup = "tuning-scrap",
            order = "i3",
            categories = { "recycling" },
            auto_recycle = false,
            enabled = false,
            ingredients = {
                { type = "item", name = "volcanic-scrap", amount = 1 }
            },
            results = {
                { type = "item", name = "tungsten-ore", amount = 1, independent_probability = 0.12 },
                { type = "item", name = "tungsten-plate", amount = 1, independent_probability = 0.01 },
                { type = "item", name = "tungsten-carbide", amount = 1, independent_probability = 0.01 },
                { type = "item", name = "copper-ore", amount = 1, independent_probability = 0.05 },
                { type = "item", name = "stone", amount = 1, independent_probability = 0.1 },
                { type = "item", name = "metal-scrap", amount = 1, independent_probability = 0.4 }
            },
            energy_required = 0.5,
            unlock_results = false,
            allow_productivity = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        },
        {
            type = "item",
            name = "superconducting-scrap",
            icon = "__tuner-upper__/graphics/icons/superconducting-scrap.png",
            icon_size = 64,
            subgroup = "tuning-scrap",
            order = "j1",
            flags = {"always-show"},
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 50,
            default_import_location = "nauvis",
            canonical_cost = 0.1,
            auto_recycle = false,
            weight = 1*kg
        },
        {
            type = "recipe",
            name = "superconducting-scrap-compacting",
            localised_name = {"recipe-name.compacting", {"item-name.superconducting-scrap"}},
            icons = crushing_icon("__tuner-upper__/graphics/icons/superconducting-scrap.png"),
            subgroup = "tuning-scrap",
            order = "j2",
            categories = { "crafting" },
            auto_recycle = false,
            ingredients = {
                { type = "item", name = "superconducting-scrap", amount = 10 }
            },
            results = {
                { type = "item", name = "holmium-plate", amount = 1 }
            },
            enabled = false,
            energy_required = 5,
            unlock_results = false,
            allow_productivity = false,
            allow_quality = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        },
        {
            type = "recipe",
            name = "superconducting-scrap-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.superconducting-scrap"}},
            icons = recycling_icon("__tuner-upper__/graphics/icons/superconducting-scrap.png"),
            subgroup = "tuning-scrap",
            order = "j3",
            categories = { "recycling" },
            auto_recycle = false,
            enabled = false,
            ingredients = {
                { type = "item", name = "superconducting-scrap", amount = 1 }
            },
            results = {
                { type = "item", name = "holmium-plate", amount = 1, independent_probability = 0.12 },
                { type = "item", name = "holmium-ore", amount = 1, independent_probability = 0.02 },
                { type = "item", name = "superconductor", amount = 1, independent_probability = 0.05 },
                { type = "item", name = "processing-unit", amount = 1, independent_probability = 0.005 },
                { type = "item", name = "electronic-scrap", amount = 1, independent_probability = 0.2 }
            },
            energy_required = 0.5,
            unlock_results = false,
            allow_productivity = false,
            allow_decomposition = false,
            allow_as_intermediate = false,
        }
    })
end
