local tm = require("__pf-functions__/technology-manipulation")

if mods["LunarLandings"] then
    tune_up_data.recipes["ll-ion-logistic-robot"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-rocket-control-unit", 1}, {"ll-aluminium-plate", 4}}, {{"rocket-control-unit", 1}, {"ll-aluminium-plate", 4}}}
    }

    tune_up_data.recipes["ll-ion-construction-robot"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-rocket-control-unit", 1}, {"ll-aluminium-plate", 4}}, {{"rocket-control-unit", 1}, {"ll-aluminium-plate", 4}}}
    }

    tune_up_data.recipes["ll-ion-roboport"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-rocket-control-unit", 20}, {"flying-robot-frame", 10}, {"ll-aluminium-plate", 20}}, {{"rocket-control-unit", 20}, {"flying-robot-frame", 10}, {"ll-aluminium-plate", 20}}}
    }

    tune_up_data.recipes["ll-rtg"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"uranium-238", 10}}}
    }

    tune_up_data.recipes["ll-core-extractor"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"electric-mining-drill", 1}, {"electric-engine-unit", 5}}}
    }

    tune_up_data.recipes["ll-arc-furnace"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-heat-shielding", 5}, {"ll-alumina", 25}}}
    }

    tune_up_data.recipes["ll-heat-furnace"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-heat-shielding", 5}, {"concrete", 20}}}
    }

    tune_up_data.recipes["ll-low-grav-assembling-machine"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"assembling-machine-3", 1}, {"ll-quantum-processor", 3}}}
    }

    tune_up_data.recipes["ll-oxygen-diffuser"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"engine-unit", 2}}}
    }

    tune_up_data.recipes["ll-quantum-resonator"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"processing-unit", 5}, {"lab", 10}, {"ll-astroflux", 15}}}
    }

    tune_up_data.recipes["ll-telescope"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"processing-unit", 5}, {"ll-blank-data-card", 5}}}
    }

    tune_up_data.recipes["ll-data-card"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 20,
      ingredients = {{{"ll-junk-data-card", 1}, {"ll-broken-data-card", 1, "byproduct"}}}
    }

    tune_up_data.recipes["ll-quantum-data-card"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 30,
      ingredients = {{{"ll-data-card", 1}, {"ll-junk-data-card", 1, "byproduct"}}}
    }

    tune_up_data.recipes["ll-blank-data-card"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 2,
      ingredients = {{{"ll-blank-data-card", 1}, {"electronic-circuit", 5}, {"ll-broken-data-card", 1, "byproduct"}}}
    }

    tune_up_data.recipes["ll-quantum-processor"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 6,
      ingredients = {{{"ll-blank-data-card", 1}, {"ll-aluminium-plate", 5}, {"ll-broken-data-card", 1, "byproduct"}}}
    }

    tune_up_data.recipes["ll-heat-shielding"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"ll-alumina", 1}, {"ll-aluminium-plate", 1}}}
    }

    tune_up_data.recipes["ll-moon-rock"] = {
      categories={"purification"},
      count = 100,
      energy_required = 100,
      ingredients = {{{"ll-rich-moon-rock", 10}, {"uranium-238", 1}, {"ll-oxygen", 50}}}
    }

    tune_up_data.recipes["ll-silica"] = {
      categories={"purification"},
      count = 10,
      energy_required = 10,
      ingredients = {{{"ll-silica", 10}, {"sulfuric-acid", 30}, {"water", 30}}}
    }

    tune_up_data.recipes["ll-silicon"] = {
      categories={"purification"},
      count = 10,
      energy_required = 10,
      ingredients = {{{"ll-silica", 5}, {"nitric-acid", 30}, {"ll-astroflux", 1}}, {{"ll-silica", 5}, {"sulfuric-acid", 30}, {"ll-astroflux", 1}}}
    }

    tune_up_data.recipes["ll-rich-moon-rock"] = {
      categories={"purification"},
      count = 1000,
      energy_required = 1000,
      ingredients = {{{"ll-moon-rock", 500}, {"uranium-235", 1}, {"ll-oxygen", 500}}}
    }

    tune_up_data.recipes["ll-aluminium-ore"] = {
      categories={"purification"},
      count = 10,
      energy_required = 10,
      ingredients = {{{"ll-aluminium-ore", 10}, {"sulfuric-acid", 50}, {"stone", 1}}}
    }

    tune_up_data.recipes["ll-alumina"] = {
      categories={"purification"},
      count = 10,
      energy_required = 10,
      ingredients = {{{"ll-alumina", 10}, {"sulfuric-acid", 50}, {"coal", 1}}}
    }

    tune_up_data.recipes["ll-aluminium-plate"] = {
      categories={"purification"},
      count = 10,
      energy_required = 10,
      ingredients = {{{"ll-alumina", 1}, {"sulfuric-acid", 50}, {"copper-plate", 1}, {"iron-plate", 1}}}
    }

    tune_up_data.recipes["ll-superposed-polariton"] = {
      categories={"purification"},
      count = 1,
      energy_required = 100,
      ingredients = {{{"ll-superposed-polariton", 2}, {"ll-quantum-data-card", 1}, {"ll-right-polariton", 1, "force-byproduct"}, {"ll-up-polariton", 1, "force-byproduct"}, {"ll-junk-data-card", 1, "force-byproduct"}}}
    }

    tune_up_data.ReplaceIngredientProportional("speed-module-3", "processing-unit", "ll-quantum-processor", 1)
    tune_up_data.ReplaceIngredientProportional("efficiency-module-3", "processing-unit", "ll-quantum-processor", 1)
    tune_up_data.ReplaceIngredientProportional("productivity-module-3", "processing-unit", "ll-quantum-processor", 1)
    tune_up_data.ReplaceIngredientProportional("quality-module-3", "processing-unit", "ll-quantum-processor", 1)

    if not mods["space-age"] then
        tm.RemovePrerequisite("legendary-quality", "space-science-pack")
        tm.RemoveSciencePack("legendary-quality", "space-science-pack")
        tm.AddPrerequisite("legendary-quality", "ll-quantum-science-pack")
        tm.AddSciencePack("legendary-quality", "ll-quantum-science-pack")

        tune_up_data.ReplaceIngredientProportional("rocket", "rocket-fuel", "ll-rocket-fuel", 10)
        tune_up_data.ReplaceIngredientProportional("explosive-rocket", "rocket-fuel", "ll-rocket-fuel", 10)
        tune_up_data.ReplaceIngredientProportional("atomic-bomb", "rocket-fuel", "ll-rocket-fuel", 10)
        tune_up_data.AddIngredient("rocket", "steel-plate", 1)
        tune_up_data.AddIngredient("atomic-bomb", "rocket-control-unit", 1)

        tune_up_data.ReplaceIngredientProportional("molecular-purifier", "processing-unit", "ll-data-card", 1)

        if not mods["pf-sa-compat"] then
                tune_up_data.recipes["rocket-control-unit"] = {
                  categories={"tuning-up"},
                  count = 1,
                  energy_required = 3,
                  ingredients = {{{"tracker", 1}}, {{"gyro", 1}, {"advanced-circuit", 1}}, {{"advanced-circuit", 1}, {"battery", 1}}}
                }
        end
    end
end
