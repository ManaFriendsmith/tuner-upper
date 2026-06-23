if mods["bzlead"] then

    local lead_byproduct = data.raw.item["silver-ore"] and "silver-ore" or "copper-ore"

    tune_up_data.recipes["lead-plate"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"lead-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}, {lead_byproduct, 1, "byproduct"}}, {{"stone", 1}, {"lead-ore", 5}, {lead_byproduct, 1, "byproduct"}}}
    }

    if not mods["space-age"] then
        tune_up_data.recipes["lead-ore"] = {
            categories={"purification"},
            count = 5,
            energy_required = 1,
            ingredients = {{{"lead-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}, {lead_byproduct, 1, "byproduct"}}}
        }
    end

    tune_up_data.recipes["lead-expansion-bolt"] = {
        categories={"tuning-up"},
        count = 5,
        energy_required = 1,
        ingredients = {{{"lead-plate", 1}, {"iron-stick", 1}}}
    }

end

if mods["bztitanium"] then

    tune_up_data.recipes["titanium-plate"] = {
        categories={"purification"},
        count = 2,
        energy_required = 10,
        ingredients = {{{"titanium-plate", 1}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"titanium-ore", 5}}}
    }

    if not mods["space-age"] then
        tune_up_data.recipes["titanium-ore"] = {
            categories={"purification"},
            count = 5,
            energy_required = 1,
            ingredients = {{{"titanium-ore", 5}, {"stone", 1}, {"sulfuric-acid", 125}}}
        }
    end

    tune_up_data.AddIngredient("construction-robot", "titanium-plate", 1)
    tune_up_data.AddIngredient("logistic-robot", "titanium-plate", 1)

end

if mods["bzcarbon"] then

    tune_up_data.recipes["graphite"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"graphite", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"flake-graphite", 5}}, {{"stone", 1}, {"coal", 5}}}
    }

    tune_up_data.recipes["carbon-black"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"carbon-black", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"coal", 5}}}
    }

    tune_up_data.recipes["carbon-black"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"carbon-black", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"coal", 5}}}
    }

    if not mods["space-age"] then
        tune_up_data.recipes["flake-graphite"] = {
            categories={"purification"},
            count = 5,
            energy_required = 1,
            ingredients = {{{"flake-graphite", 5}, {"coal", 1}, {"stone", 1}, {"steam", 50}}}
        }
    end

    tune_up_data.AddIngredient("laser-turret", "diamond", 1)

    if data.raw.item["graphene"] then
        tune_up_data.AddIngredient("superconductor", "graphene", 1)
    end

end

if mods["bztin"] then

    tune_up_data.recipes["tin-plate"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"tin-plate", 5}, {"organotins", 50}, {"calcite", 1}}, {{"stone", 1}, {"tin-ore", 5}}}
    }

    tune_up_data.recipes["bronze-plate"] = {
        categories={"purification"},
        count = 8,
        energy_required = 8,
        ingredients = {{{"tin-plate", 1}, {"copper-plate", 3}, {"calcite", 1}}, {{"stone", 1}, {"tin-plate", 1}, {"copper-plate", 3}}}
    }

    tune_up_data.recipes["tinned-cable"] = {
        categories={"tuning-up"},
        count = 10,
        energy_required = 4,
        ingredients = {{{"gold-plate", 1}, {"plastic-bar", 1}}, {{"tin-plate", 1}, {"plastic-bar", 1}}}
    }

    if not mods["space-age"] then
        tune_up_data.recipes["tin-ore"] = {
            categories={"purification"},
            count = 5,
            energy_required = 1,
            ingredients = {{{"tin-ore", 5}, {"stone", 1}, {"organotins", 50}}}
        }
    end

    tune_up_data.ReplaceIngredientProportional("poison-capsule", "petroleum-gas", "organotins", 1)

    if data.raw.item["tinned-cable"] then
        tune_up_data.AddIngredient("advanced-circuit", "tinned-cable", 2)
    end

end

if mods["bzzirconium"] then

    tune_up_data.recipes["zirconium-plate"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"zirconium-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zirconium-sponge", 5}}}
    }

    tune_up_data.recipes["zirconia"] = {
        categories={"purification"},
        count = 20,
        energy_required = 10,
        ingredients = {{{"zirconia", 10}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zircon", 5}}}
    }

    tune_up_data.recipes["zirconium-sponge"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"zirconium-sponge", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zirconia", 5}}}
    }

    tune_up_data.recipes["zirconium-tungstate"] = {
        categories={"purification"},
        count = 20,
        energy_required = 20,
        ingredients = {{{"zirconium-plate", 5}, {"tungsten-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}}
    }

    tune_up_data.recipes["zircaloy-4"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"zirconium-plate", 5}, {"tin-plate", 1}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zirconium-plate", 5}, {"tin-plate", 1}}}
    }

    if not mods["space-age"] then
        tune_up_data.recipes["zircon"] = {
            categories={"purification"},
            count = 5,
            energy_required = 1,
            ingredients = {{{"zircon", 5}, {"stone", 1}, {"sulfuric-acid", 50}}}
        }
    end

end

if mods["bzsilicon"] then

    tune_up_data.recipes["silicon"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"silicon", 5}, {"carbon", 1}, {"sulfuric-acid", 50}, {"calcite", 1}, {"silica", 1, "byproduct"}}, {{"silica", 10}, {"coal", 1}, {"silica", 1, "byproduct"}}}
    }

    tune_up_data.recipes["silicone"] = {
        categories={"purification"},
        count = 10,
        energy_required = 10,
        ingredients = {{{"silicone", 5}, {"carbon", 1}, {"sulfuric-acid", 50}, {"calcite", 1}, {"silica", 1, "byproduct"}}, {{"silica", 10}, {"coal", 1}, {"silica", 1, "byproduct"}}}
    }

    tune_up_data.recipes["silica"] = {
        categories={"purification"},
        count = 20,
        energy_required = 10,
        ingredients = {{{"silica", 10}, {"carbon", 1}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 5}, {"coal", 1}}}
    }

    tune_up_data.recipes["silicon-wafer"] = {
        categories={"tuning-up"},
        count = 2,
        energy_required = 3,
        ingredients = {{{"silicon", 1}, {"sulfuric-acid", 25}, {"gold-plate", 1}}, {{"silicon", 1}, {"sulfuric-acid", 25}, {"copper-plate", 1}}}
    }

    tune_up_data.recipes["solar-cell"] = {
        categories={"tuning-up"},
        count = 4,
        energy_required = 4,
        ingredients = {{{"advanced-circuit", 1}}}
    }

    tune_up_data.recipes["optical-fiber"] = {
        categories={"tuning-up"},
        count = 10,
        energy_required = 1,
        ingredients = {{{"rubber", 1}}, {{"plastic-bar", 1}}}
    }

end