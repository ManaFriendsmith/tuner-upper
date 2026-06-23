local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

local function allow_recycling(recipe)
    if recipe.force_auto_recycle then return true end
    if (recipe.auto_recycle == false) or (recipe.auto_recycle_bypass == false) then return false end
    if not recipe.category then recipe.categories={"crafting"} end
    if not data.raw["recipe-category"][recipe.category] then return false end
    if data.raw["recipe-category"][recipe.category].can_recycle == false then return false end
    return true
end

local function get_canonical_recipe(item)
    --if a canonical recipe is specified, use that. no questions asked.
    if item.canonical_recipe ~= nil then return item.canonical_recipe end

    --if a recipe exists with the exact same name that produces the item, use that.
    if data.raw.recipe[item.name] and data.raw.recipe[item.name].results then
        for k, product in pairs(data.raw.recipe[item.name].results) do
            if product.name == item.name and product.type == "item" then
                return item.name
            end
        end
    end

    --if exactly one valid recipe produces the item with no byproducts, use that.
    local candidate = nil
    for k, recipe in pairs(data.raw.recipe) do
        if recipe.results and #recipe.results == 1 and recipe.auto_recycle == false then
            local ok = false
            local solids = 0
            for k2, product in pairs(recipe.results) do --not taking risks if someone uses weird keys for their tables.
                if product.type == "item" then
                    solids = solids + 1
                    if product.name == item.name then
                        ok = true
                    end
                end
            end

            for k2, v2 in pairs(recipe.categories or {"crafting"}) do
                if v2 == "recycling" then
                    ok = false
                end
            end

            if (solids == 1) and ok then
                if candidate then
                    candidate = nil
                else
                    candidate = recipe.name
                end
            end
        end
    end
    if candidate then return candidate end
    return true
end

for k, v in pairs(tune_up_data.recipes) do
    local item_p = misc.GetPrototype(k)
    if item_p then
        local original_recipe = get_canonical_recipe(item_p)
        local original_ingredients = {}
        if original_recipe and data.raw.recipe[original_recipe] then
            for k2, v2 in pairs(data.raw.recipe[original_recipe].ingredients or {}) do
                table.insert(original_ingredients, v2.name)
            end
        end

        local valid = false
        local good_ingredients = {}
        for k2, v2 in pairs(v.ingredients) do
            valid = true
            for k3, v3 in pairs(v2) do
                if not (data.raw.fluid[v3[1]] or misc.GetPrototype(v3[1])) then
                    valid = false
                    break
                end
                if v.forbid_original_ingredients then
                    for k4, v4 in pairs(original_ingredients) do
                        if v3[1] == v4 then
                            valid = false
                            break
                        end
                    end
                    if not valid then
                        break
                    end
                end
            end
            if valid then
                good_ingredients = v2
                break
            end
        end
        if valid then
            local new_recipe = {
                name = k .. "-tuning-up",
                type = "recipe",
                localised_name = {"recipe-name.tuning-up", {"?", {"item-name." .. k}, {"entity-name." .. k}}},
                subgroup = "tuning-" .. item_p.subgroup,
                order = item_p.order,
                hide_from_player_crafting = true,
                categories = v.categories,
                enabled = v.enabled,
                energy_required = v.energy_required or (type(original_recipe) == "string" and original_recipe.energy_required) or 5,
                ingredients = {},
                products = {},
                maximum_productivity = 0,
                allow_decomposition = false,
                allow_as_intermediate = false,
                auto_recycle = false
            }

            if mods["space-age"] then
                new_recipe.surface_conditions = v.surface_conditions
            end
            
            if item_p.icon then
                new_recipe.icons = {
                    {
                        icon = item_p.icon,
                        icon_size = item_p.icon_size
                    },
                    {
                        icon = "__tuner-upper__/graphics/enhancement-overlay.png",
                        icon_size = 64
                    }
                }
            else
                new_recipe.icons = table.deepcopy(item_p.icons)
                table.insert(new_recipe.icons, {icon = "__tuner-upper__/graphics/enhancement-overlay.png", icon_size = 64})
            end

            rm.AddIngredient(new_recipe, k, v.count)
            rm.AddProduct(new_recipe, k, v.count)
            for k2, v2 in pairs(good_ingredients) do
                if v2[3] == "byproduct" or v2[3] == "force-byproduct" then
                    if settings.startup["tuner-upper-byproducts"].value or v2[3] == "force-byproduct" then
                        rm.AddProduct(new_recipe, v2[1], v2[2])
                    end
                else
                    rm.AddIngredient(new_recipe, v2[1], v2[2])
                end
            end

            if v.result_is_always_fresh then
                for k, v in pairs(new_recipe.results) do
                    v.always_fresh = true
                end
            end

            data:extend({new_recipe})
        end
    end
end

if not data.raw.furnace.recycler.effect_receiver then
    data.raw.furnace.recycler.effect_receiver = {}
end
data.raw.furnace.recycler.effect_receiver.base_effect = {quality=-0.16}
data.raw.furnace.recycler.effect_receiver.quality_limits = {low=-100, high=0}
for k, v in pairs(data.raw.quality) do
    if v.name  ~= normal then
        v.previous_probability = 1
    end
end

data.raw.module["speed-module"].effect.quality = -0.02
data.raw.module["speed-module-2"].effect.quality = -0.03
data.raw.module["speed-module-3"].effect.quality = -0.05

if mods["space-age"] then
    data.raw.recipe["casting-low-density-structure"].hidden = true
    data.raw.recipe["casting-low-density-structure"].hidden_in_factoriopedia = true
    data.raw.recipe["low-density-structure"].categories={"crafting", "metallurgy"}

    tm.RemoveUnlock("foundry", "casting-low-density-structure")
    tm.RemoveUnlock("low-density-structure-productivity", {type="change-recipe-productivity",recipe="casting-low-density-structure",change=0.1})

    if not (mods["pf-sa-compat"] and misc.difficulty > 1) then
        data.raw.technology["low-density-structure-productivity"].max_level = 10
        data.raw.technology["processing-unit-productivity"].max_level = 10
        data.raw.technology["rocket-fuel-productivity"].max_level = 10
    end
end

local new_groups = {}
for k, v in pairs(data.raw["item-subgroup"]) do
    local new_group = table.deepcopy(v)
    new_group.name = "tuning-" .. new_group.name
    new_group.order = "zzzzz-" .. new_group.order
    table.insert(new_groups, new_group)
end
data:extend(new_groups)

data.raw["utility-constants"].default.maximum_quality_jump = 1

if settings.startup["tuner-upper-buff-quality-science"] then
    local q = data.raw.quality[data.raw.quality.normal.next]
    local mul = 2
    while q do
        q.tool_durability_multiplier = mul
        mul = mul + 2
        if q.next then
            q = data.raw.quality[q.next]
        else
            q = nil
        end
    end
end

for k, v in pairs(data.raw.quality) do
    if not v.default_multiplier then
        v.default_multiplier = 1 + (0.3 * v.level)
    end

    v.module_quality_multiplier = ((((v.module_speed_multiplier or v.default_multiplier) - 1) * 2) / 3) + 1
end

if settings.startup["tuner-upper-nerf-quality-power"] then
    for k, v in pairs(data.raw.quality) do
        --v.default_multiplier = 1 + (v.level * 0.1)
        v.equipment_grid_width_bonus = 0

        v.crafting_machine_speed_multiplier = (((v.crafting_machine_speed_multiplier or v.default_multiplier) - 1) / 3) + 1
        if v.crafting_machine_energy_usage_multiplier then
            v.crafting_machine_energy_usage_multiplier = ((v.crafting_machine_energy_usage_multiplier - 1) / 3) + 1
        end
        v.module_speed_multiplier = (((v.module_speed_multiplier or v.default_multiplier) - 1) / 3) + 1
        v.module_productivity_multiplier = (((v.module_productivity_multiplier or v.default_multiplier) - 1) / 3) + 1
        v.module_consumption_multiplier = (((v.module_consumption_multiplier or v.default_multiplier) - 1) / 3) + 1
    end

    for k, v in pairs(data.raw["assembling-machine"]) do
        if v.crafting_speed_quality_multiplier then
            for k2, v2 in pairs(v.crafting_speed_quality_multiplier) do
                v.crafting_speed_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
        if v.energy_usage_quality_multiplier then
            for k2, v2 in pairs(v.energy_usage_quality_multiplier) do
                v.energy_usage_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
    end

    for k, v in pairs(data.raw["furnace"]) do
        if v.crafting_speed_quality_multiplier then
            for k2, v2 in pairs(v.crafting_speed_quality_multiplier) do
                v.crafting_speed_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
        if v.energy_usage_quality_multiplier then
            for k2, v2 in pairs(v.energy_usage_quality_multiplier) do
                v.energy_usage_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
    end

    for k, v in pairs(data.raw["rocket-silo"]) do
        if v.crafting_speed_quality_multiplier then
            for k2, v2 in pairs(v.crafting_speed_quality_multiplier) do
                v.crafting_speed_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
        if v.energy_usage_quality_multiplier then
            for k2, v2 in pairs(v.energy_usage_quality_multiplier) do
                v.energy_usage_quality_multiplier[k2] = ((v2 - 1) / 3) + 1
            end
        end
    end

    for k, v in pairs(data.raw.beacon) do
        v.distribution_effectivity_bonus_per_quality_level = v.distribution_effectivity_bonus_per_quality_level / 2
    end
end

data.raw.module["quality-module"].effect.quality = 0.04
data.raw.module["quality-module-2"].effect.quality = 0.06
data.raw.module["quality-module-3"].effect.quality = 0.08

--quality complexity is based on # of processing steps and it is really easy to hit 4 processes to up quality if you can mine uncommon ores directly.
--also the current megabase meta is to use uncommon ore for science which means no foundries which is No Fun. if the first opportunity for uncommon items is at plates foundries are better bc more modules.
--quality ore is used for upgrading plates so it's not like upgrading ore in the purifier is worthless either.
--maybe if using a more quality tiers mod this is unnecessary but it's a sweet spot of maybe 1-3 extra tiers before Fun Spaghetti Mode disappears behind mandatory purifier stacks for every resource.
for k, v in pairs(data.raw["mining-drill"]) do
    if v.allowed_effects then
        for k2, v2 in pairs(v.allowed_effects) do
            if v2 == "quality" then
                table.remove(v.allowed_effects, k2)
            end
        end
    else
        v.allowed_effects = {"speed", "consumption", "productivity", "pollution"}
    end
end
