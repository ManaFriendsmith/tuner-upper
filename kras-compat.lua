
--UNFINISHED. was working on this when 2.1 announced.
--Will finish when K2 updates for 2.1

if mods["Krastorio2"] then
    tune_up_data.ReplaceIngredientProportional("wood", "sulfur", "kr-biomass", 1)

    tune_up_data.recipes["kr-inserter-parts"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 0.5,
      ingredients = {{{"kr-steel-gear-wheel", 1}}}
    }

    tune_up_data.recipes["kr-automation-core"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 1,
      ingredients = {{{"electronic-circuit", 2}}}
    }

    tune_up_data.recipes["kr-blank-tech-card"] = {
      categories={"tuning-up"},
      count = 10,
      energy_required = 2,
      ingredients = {{{"electronic-circuit", 1}}}
    }
    
    tune_up_data.recipes["kr-iron-beam"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 1,
      ingredients = {{{"iron-stick", 2}}}
    }

    tune_up_data.recipes["kr-steel-beam"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 2,
      ingredients = {{{"iron-stick", 4}, {"steel-plate", 1}}}
    }

    tune_up_data.recipes["kr-imersium-beam"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 2,
      ingredients = {{{"steel-beam", 1}, {"kr-advanced-fuel", 1}, {"kr-imersite-crystal", 1}}}
    }

    tune_up_data.recipes["kr-steel-gear-wheel"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 0.5,
      ingredients = {{{"iron-gear-wheel", 1}}}
    }

    tune_up_data.recipes["kr-imersium-gear-wheel"] = {
      categories={"tuning-up"},
      count = 4,
      energy_required = 2,
      ingredients = {{{"kr-steel-gear-wheel", 1}, {"kr-advanced-fuel", 1}, {"kr-imersite-crystal", 1}}}
    }

    tune_up_data.recipes["kr-ai-core"] = {
      categories={"tuning-up"},
      count = 6,
      energy_required = 15,
      ingredients = {{{"kr-imersium-plate", 6}, {"flying-robot-frame", 3}, {"kr-energy-control-unit", 1}}}
    }

    tune_up_data.recipes["kr-energy-control-unit"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"kr-lithium-sulfur-battery", 2}, {"kr-imersium-gear-wheel", 5}, {"processing-unit", 1}}}
    }

    tune_up_data.recipes["kr-lithium-sulfur-battery"] = {
      categories={"tuning-up"},
      count = 2,
      energy_required = 2,
      ingredients = {{{"kr-lithium", 1}, {"kr-electronic-components", 1}}}
    }

    tune_up_data.recipes["kr-superior-inserter"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"fast-inserter", 1}, {"kr-imersium-gear-wheel", 3}}}
    }

    tune_up_data.recipes["kr-superior-long-inserter"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"fast-inserter", 1}, {"kr-imersium-gear-wheel", 3}}}
    }

    tune_up_data.recipes["kr-superior-long-inserter"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"fast-inserter", 1}, {"kr-imersium-gear-wheel", 3}}}
    }

    tune_up_data.recipes["kr-superior-substation"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-ai-core", 1}, {"kr-imersium-plate", 3}}}
    }

    tune_up_data.recipes["kr-steel-pipe"] = {
      categories={"tuning-up"},
      count = 15,
      energy_required = 3,
      ingredients = {{{"pump", 1}, {"kr-steel-beam", 1}}}
    }

    tune_up_data.recipes["kr-steel-pump"] = {
      categories={"tuning-up"},
      count = 10,
      energy_required = 2,
      ingredients = {{{"pump", 1}, {"kr-steel-pipe", 1}}}
    }

    tune_up_data.recipes["kr-greenhouse"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-fertilizer", 5}, {"kr-glass", 10}}}
    }

    tune_up_data.recipes["kr-biolab"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-pollution-filter", 5}, {"kr-glass", 10}}}
    }

    tune_up_data.recipes["kr-crusher"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"engine-unit", 5}, {"kr-steel-gear-wheel", 5}}}
    }

    tune_up_data.recipes["kr-electrolysis-plant"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-steel-pipe", 10}, {"battery", 10}}}
    }

    tune_up_data.recipes["kr-filtration-plant"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-pollution-filter", 2}, {"kr-automation-core", 5}}}
    }

    tune_up_data.recipes["kr-atmospheric-condenser"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-steel-pipe", 10}, {"electric-engine-unit", 10}}}
    }

    tune_up_data.recipes["kr-flare-stack"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-steel-beam", 5}, {"automation-core", 1}}}
    }

    tune_up_data.recipes["kr-fuel-refinery"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 2,
      ingredients = {{{"kr-steel-pipe", 5}, {"engine-unit", 5}}}
    }

    tune_up_data.recipes["kr-research-server"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"processing-unit", 5}}}
    }

    tune_up_data.recipes["kr-quantum-computer"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"kr-matter-stabilizer", 20}, {"kr-energy-control-unit", 50}}}
    }

    tune_up_data.recipes["kr-advanced-lab"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"lab", 1}, {"processing-unit", 2}}}
    }

    tune_up_data.recipes["kr-advanced-lab"] = {
      categories={"tuning-up"},
      count = 1,
      energy_required = 5,
      ingredients = {{{"kr-advanced-lab", 1}, {"processing-unit", 2}}}
    }
    
end