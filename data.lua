local item_sounds = require("__base__/prototypes/item_sounds")

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
        weight = 200*kg
    },
    {
        type = "item",
        name = "tune-up-station",
        icons = {{
            icon = "__tuner-upper__/graphics/tune-up-station/gravity-assembler-icon.png",
            icon_size = 64,
            tint = mods["LunarLandings"] and {1, 1, 0.5, 1} or {1, 1, 1, 1}
        }},
        subgroup = "smelting-machine",
        place_result = "tune-up-station",
        order = "z",
        inventory_move_sound = item_sounds.mechanical_large_inventory_move,
        pick_sound = item_sounds.mechanical_large_inventory_pickup,
        drop_sound = item_sounds.mechanical_large_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis",
        weight = 200*kg
    },
    {
        type = "assembling-machine",
        name = "molecular-purifier",
        icon = "__tuner-upper__/graphics/molecular-purifier/atom-forge-icon.png",
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.1, result = "molecular-purifier"},
        max_health = 400,
        corpse = "recycler-remnants",
        dying_explosion = "recycler-explosion",
        effect_receiver = {
            base_effect = { quality = 8 },
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
        collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
        selection_box = {{-2, -2}, {2, 2}},
        damaged_trigger_effect = data.raw["furnace"]["recycler"].damaged_trigger_effect,
        module_slots = 2,
        allowed_effects = {"consumption", "speed", "pollution", "quality"},
        graphics_set = {
            animation = {
                layers = {
                    {
                        filenames = {"__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-2.png"},
                        width = 400,
                        height = 480,
                        frame_count = 80,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = {0, -0.25},
                        scale = 0.33
                    },
                    {
                        filenames = {"__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-shadow.png"},
                        width = 900,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 80,
                        draw_as_shadow = true,
                        shift = {0, -0.25},
                        scale = 0.33
                    }
                }
            },
            idle_animation = {
                layers = {
                    {
                        filenames = {"__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-animation-2.png"},
                        width = 400,
                        height = 480,
                        frame_count = 80,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = {0, -0.25},
                        scale = 0.33
                    },
                    {
                        filenames = {"__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-shadow.png"},
                        width = 900,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 80,
                        draw_as_shadow = true,
                        shift = {0, -0.25},
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
                                filenames = {"__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-emission-1.png", "__tuner-upper__/graphics/molecular-purifier/atom-forge-hr-emission-2.png"},
                                width = 400,
                                height = 480,
                                frame_count = 80,
                                line_length = 8,
                                lines_per_file = 8,
                                blend_mode = "additive",
                                draw_as_glow = true,
                                shift = {0, -0.25},
                                scale = 0.33
                            }
                        }
                    }
                }
            }
        },
        impact_category = "metal-large",
        open_sound = {filename = "__base__/sound/open-close/nuclear-open.ogg", volume = 0.5},
        close_sound = {filename = "__base__/sound/open-close/nuclear-close.ogg", volume = 0.5},
        working_sound = table.deepcopy(data.raw["reactor"]["nuclear-reactor"].working_sound),
        crafting_speed = 1,
        energy_source =
        {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = { pollution = 2 }
        },
        energy_usage = "1MW",
        crafting_categories = {"purification"},
        fluid_boxes_off_when_no_fluid_recipe = true,
        fluid_boxes =
        {
          {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {0.5, -1.5},
              }
            },
            secondary_draw_orders = {north = -1}
          },
          {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {-0.5, -1.5},
              }
            },
            secondary_draw_orders = {north = -1}
          },
          {
            production_type = "output",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="output",
                direction = defines.direction.south,
                position = {0.5, 1.5}
              }
            },
            secondary_draw_orders = {north = -1}
          },
          {
            production_type = "output",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="output",
                direction = defines.direction.south,
                position = {-0.5, 1.5}
              }
            },
            secondary_draw_orders = {north = -1}
          }
       },
      ll_surface_conditions = {nauvis=true, luna={plain=false, lowland=false, mountain=false, foundation=true}}
    },
    {
        type = "assembling-machine",
        name = "tune-up-station",
        icons = {{
            icon = "__tuner-upper__/graphics/tune-up-station/gravity-assembler-icon.png",
            icon_size = 64,
            tint = mods["LunarLandings"] and {1, 1, 0.5, 1} or {1, 1, 1, 1}
        }},
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.1, result = "tune-up-station"},
        max_health = 400,
        corpse = "recycler-remnants",
        dying_explosion = "recycler-explosion",
        effect_receiver = {
            base_effect = { quality = 8 },
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
        collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        damaged_trigger_effect = data.raw["furnace"]["recycler"].damaged_trigger_effect,
        module_slots = 3,
        allowed_effects = {"consumption", "speed", "pollution", "quality"},
        graphics_set = {
            animation = {
                layers = {
                    {
                        filenames = {"__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-2.png"},
                        width = 320,
                        height = 320,
                        frame_count = 100,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = {0, -0.15},
                        scale = 0.3
                    },
                    {
                        filenames = {"__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-shadow.png"},
                        width = 520,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 100,
                        draw_as_shadow = true,
                        shift = {0, -0.15},
                        scale = 0.3
                    }
                }
            },
            idle_animation = {
                layers = {
                    {
                        filenames = {"__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-animation-2.png"},
                        width = 320,
                        height = 320,
                        frame_count = 100,
                        line_length = 8,
                        lines_per_file = 8,
                        shift = {0, -0.15},
                        scale = 0.3
                    },
                    {
                        filenames = {"__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-shadow.png"},
                        width = 520,
                        height = 500,
                        frame_count = 1,
                        line_length = 1,
                        lines_per_file = 1,
                        repeat_count = 100,
                        draw_as_shadow = true,
                        shift = {0, -0.15},
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
                                filenames = {"__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-emission-1.png", "__tuner-upper__/graphics/tune-up-station/gravity-assembler-hr-emission-2.png"},
                                width = 320,
                                height = 320,
                                frame_count = 100,
                                line_length = 8,
                                lines_per_file = 8,
                                blend_mode = "additive",
                                draw_as_glow = true,
                                shift = {0, -0.15},
                                scale = 0.3
                            }
                        }
                    }
                }
            }
        },
        impact_category = "metal-large",
        open_sound = {filename = "__base__/sound/open-close/mechanical-large-open.ogg", volume = 0.5},
        close_sound = {filename = "__base__/sound/open-close/mechanical-large-close.ogg", volume = 0.5},
        working_sound = {filename = "__base__/sound/assembling-machine-repaired-1.ogg", volume = 0.5},
        crafting_speed = 1,
        energy_source =
        {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = { pollution = 1 }
        },
        energy_usage = "250kW",
        crafting_categories = {"tuning-up"},
        fluid_boxes_off_when_no_fluid_recipe = true,
        fluid_boxes =
        {
          {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {0, -1},
              }
            },
            secondary_draw_orders = {north = -1}
          },
          {
            production_type = "output",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="output",
                direction = defines.direction.south,
                position = {0, 1}
              }
            },
            secondary_draw_orders = {north = -1}
          }
        },
     ll_surface_conditions = {nauvis=true, luna={plain=false, lowland=false, mountain=false, foundation=true}}
    },
    {
      type = "recipe",
      name = "molecular-purifier",
      category = "crafting",
      ingredients = mods["space-age"] and {
          {type="item", name="centrifuge", amount=1},
          {type="item", name="quality-module-2", amount=10},
          {type="item", name="carbon-fiber", amount=100},
          {type="item", name="tungsten-plate", amount=100},
      } or {
        {type="item", name="centrifuge", amount=1},
        {type="item", name="quality-module-3", amount=1},
        {type="item", name="chemical-plant", amount=20},
        {type="item", name="processing-unit", amount=20},
      },
      results = {
          {type="item", name="molecular-purifier", amount=1}
      },
      energy_required = 10,
      enabled = true
  },
  {
      type = "recipe",
      name = "tune-up-station",
      category = "crafting",
      ingredients = {
          {type="item", name="assembling-machine-2", amount=1},
          {type="item", name="quality-module", amount=10},
          {type="item", name="electric-engine-unit", amount=20},
          {type="item", name="fast-inserter", amount=20}
      },
      results = {
          {type="item", name="tune-up-station", amount=1}
      },
      energy_required = 10,
      enabled = true
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
    prerequisites = {"quality-module", "electric-engine"},
    unit = {
        count = 500,
        time = 15,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
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
    prerequisites = mods["space-age"] and {"quality-module-2", "carbon-fiber", "metallurgic-science-pack", "uranium-processing"} or {"quality-module-3", "uranium-processing"},
    unit = {
        count = mods["space-age"] and 2500 or 1000,
        time = 15,
        ingredients = mods ["space-age"] and {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"space-science-pack", 1},
            {"production-science-pack", 1},
            {"agricultural-science-pack", 1},
            {"metallurgic-science-pack", 1}
        } or {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1}
        }
    }
  }
})

tune_up_data = {
  recipes = {}
}

function tune_up_data.AddIngredient(recipe, ingredient, amount, byproduct)
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
        local found = false
        for k2, v2 in pairs(v) do
          if v2[1] == ingredient and (v2[3] == "byproduct") == byproduct then
            v2[2] = v2[2] + amount
            found = true
          end
        end
        if not found then
          table.insert(v, {ingredient, amount})
        end
      end
    else
      tune_up_data.recipes[recipe].ingredients = {{{ingredient, amount, byproduct and "byproduct" or nil}}}
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
    category = "tuning-up",
    count = 5,
    energy_required = 2,
    ingredients = {{{"bearing", 1}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["iron-stick"] = {
    category = "tuning-up",
    count = 20,
    energy_required = 2,
    ingredients = {{{"invar-plate", 1}}, {{"lead-expansion-bolt", 4}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["low-density-structure"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 2,
    ingredients = {{{"plastic-bar", 4}, {"loadbearing-lattice", 1}, {"iron-stick", 2, "byproduct"}}, {{"plastic-bar", 4}, {"ll-aluminium-plate", 1}, {"iron-stick", 2, "byproduct"}}, {{"plastic-bar", 4}, {"steel-plate", 3}, {"iron-stick", 2, "byproduct"}}}
}

tune_up_data.recipes["engine-unit"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 10,
    ingredients = {{{"tungsten-plate", 1}, {"galvanized-tubing", 1, "byproduct"}}, {{"tungsten-plate", 1}, {"pipe", 1, "byproduct"}}, {{"iron-gear-wheel", 5}}}
}

tune_up_data.recipes["electric-engine-unit"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"superconductor", 3}, {"semiboloid-stator", 1}, {"copper-cable", 1, "byproduct"}}, {{"superconductor", 3}, {"iron-gear-wheel", 1}, {"copper-cable", 1, "byproduct"}}, {{"advanced-circuit", 1}, {"semiboloid-stator", 1}, {"copper-cable", 1, "byproduct"}}, {{"advanced-circuit", 1}, {"iron-gear-wheel", 1}, {"copper-cable", 1, "byproduct"}}}
}

tune_up_data.recipes["flying-robot-frame"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 20,
    ingredients = {{{"supercapacitor", 2}, {"transceiver", 1}}, {{"tracker", 1}, {"electronic-circuit", 1, "byproduct"}}, {{"supercapacitor", 3}}, {{"transceiver", 2}, {"battery", 3}}, {{"advanced-circuit", 2}, {"battery", 2}}}
}

tune_up_data.recipes["copper-cable"] = {
    category = "tuning-up",
    count = 8,
    energy_required = 2,
    ingredients = {{{"electronic-circuit", 1}}}
}

tune_up_data.recipes["electronic-circuit"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"plastic-bar", 1}}}
}

tune_up_data.recipes["advanced-circuit"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 2,
    ingredients = {{{"sulfuric-acid", 5}, {"integrated-circuit", 1}}, {{"sulfuric-acid", 5}, {"electronic-circuit", 1}}}
}

tune_up_data.recipes["processing-unit"] = {
    category = "tuning-up",
    count = 4,
    energy_required = 20,
    ingredients = {{{"speed-module", 1}, {"efficiency-module", 1}, {"productivity-module", 1}, {"quality-module", 1}, {"advanced-circuit", 4, "byproduct"}}}
}

tune_up_data.recipes["speed-module"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"fast-gearbox", 2}}, {{"electric-motor", 5}, {"electronic-circuit", 1, "byproduct"}}, {{"iron-gear-wheel", 15}}}
}

tune_up_data.recipes["efficiency-module"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"high-pressure-valve", 2}}, {{"battery", 5}, {"copper-cable", 3, "byproduct"}}}
}

tune_up_data.recipes["productivity-module"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"engine-unit", 2}, {"plastic-bar", 1, "byproduct"}}}
}

tune_up_data.recipes["quality-module"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"stepper-motor", 2}, {"electronic-circuit", 1, "byproduct"}}, {{"advanced-circuit", 2}, {"electronic-circuit", 1, "byproduct"}}}
}

tune_up_data.recipes["wood"] = {
    category = "purification",
    count = 2,
    energy_required = 1,
    ingredients = {{{"nutrients", 3}, {"wood", 1}, {"water", 50}}, {{"sulfur", 1}, {"wood", 1}, {"water", 50}}}
}

tune_up_data.recipes["coal"] = {
    category = "purification",
    count = 2,
    energy_required = 1,
    ingredients = {{{"sulfur", 1}, {"heavy-oil", 5}}}
}

tune_up_data.recipes["carbon"] = {
    category = "purification",
    count = 2,
    energy_required = 2,
    ingredients = {{{"coal", 2}, {"sulfuric-acid", 5}}}
}

tune_up_data.recipes["sulfur"] = {
    category = "purification",
    count = 2,
    energy_required = 1,
    ingredients = {{{"coal", 1}, {"petroleum-gas", 5}}}
}

tune_up_data.recipes["plastic-bar"] = {
    category = "purification",
    count = 3,
    energy_required = 6,
    ingredients = {{{"bioflux", 1}, {"petroleum-gas", 5}}, {{"toluene", 1}, {"petroleum-gas", 15}}, {{"plastic-bar", 3}, {"petroleum-gas", 75}}}
}

tune_up_data.recipes["battery"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 3,
    ingredients = {{{"sulfur", 2}, {"electronic-circuit", 1}}}
}

tune_up_data.recipes["explosives"] = {
    category = "purification",
    count = 2,
    energy_required = 2,
    ingredients = {{{"gunpowder", 1}}, {{"carbon", 1}, {"water", 5}}, {{"coal", 1}, {"light-oil", 10}}}
}

if not mods["space-age"] then
  tune_up_data.recipes["iron-ore"] = {
      category = "purification",
      count = 5,
      energy_required = 1,
      ingredients = {{{"iron-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
  }

  tune_up_data.recipes["copper-ore"] = {
      category = "purification",
      count = 5,
      energy_required = 1,
      ingredients = {{{"copper-ore", 5}, {"stone", 1}, {"nitric-acid", 25}}, {{"copper-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
  }
end

tune_up_data.recipes["stone"] = {
    category = "purification",
    count = mods["space-age"] and 10 or 20,
    energy_required = mods["space-age"] and 5 or 10,
    ingredients = mods["space-age"] and {{{"copper-ore", 2}, {"iron-ore", 2}, {"water", 30}}} or {{{"uranium-238", 1}}}
}

tune_up_data.recipes["stone-brick"] = {
    category = "purification",
    count = 5,
    energy_required = 5,
    ingredients = {{{"stone", 3}, {"carbon", 1}}, {{"stone", 3}, {"coal", 1}}}
}

tune_up_data.recipes["concrete"] = {
    category = "purification",
    count = 5,
    energy_required = 5,
    ingredients = {{{"galvanized-rod", 1}, {"stone-brick", 1}}, {{"iron-stick", 1}, {"stone-brick", 1}}}
}

tune_up_data.recipes["refined-concrete"] = {
    category = "purification",
    count = 5,
    energy_required = 5,
    ingredients = {{{"lead-expansion-bolt", 1}, {"concrete", 5}}, {{"iron-stick", 2}, {"concrete", 5}}}
}

tune_up_data.recipes["iron-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"iron-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"iron-ore", 5}}}
}

tune_up_data.recipes["steel-plate"] = {
  category = "purification",
  count = 5,
  energy_required = 10,
  ingredients = {{{"carbon", 3}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"coal", 2}, {"iron-ore", 10}}}
}

tune_up_data.recipes["copper-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"copper-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"copper-ore", 5}}}
}

tune_up_data.recipes["calcite"] = {
  category = "purification",
  count = 20,
  energy_required = 10,
  ingredients = {{{"stone", 5}, {"promethium-asteroid-chunk", 1}}}
}

tune_up_data.recipes["promethium-asteroid-chunk"] = {
  category = "purification",
  count = 1,
  energy_required = 1,
  surface_conditions = {{property="pressure", min=0, max=0}},
  ingredients = {{{"uranium-235", 1}}}
}

tune_up_data.recipes["uranium-238"] = {
  category = "purification",
  count = 100,
  energy_required = 100,
  ingredients = {{{"depleted-uranium-fuel-cell", 1}, {"sulfuric-acid", 100}}}
}

tune_up_data.recipes["uranium-235"] = {
  category = "purification",
  count = 1,
  energy_required = 10,
  ingredients = {{{"depleted-uranium-fuel-cell", 1}, {"sulfuric-acid", 100}}}
}

tune_up_data.recipes["copper-bacteria"] = {
  category = "purification",
  count = 4,
  energy_required = 2,
  result_is_always_fresh = true,
  ingredients = {{{"copper-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"copper-bacteria", 1}, {"nutrients", 5}, {"growth-serum", 5}}, {{"copper-bacteria", 1}, {"nutrients", 8}}}
}

tune_up_data.recipes["iron-bacteria"] = {
  category = "purification",
  count = 4,
  energy_required = 2,
  result_is_always_fresh = true,
  ingredients = {{{"iron-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"iron-bacteria", 1}, {"nutrients", 5}, {"growth-serum", 5}}, {{"iron-bacteria", 1}, {"nutrients", 8}}}
}

tune_up_data.recipes["carbon-fiber"] = {
  category = "purification",
  count = 2,
  energy_required = 10,
  surface_conditions = {{property="pressure", min=4000, max=4000}},
  ingredients = {{{"carbon", mods["IfNickelMk2"] and 3 or 1}, {"water", 10}}}
}

tune_up_data.recipes["bioflux"] = {
  category = "purification",
  count = 10,
  energy_required = 10,
  ingredients = {{{"lithium", 1}, {"fertilizer-slurry", 100}}, {{"lithium", 1}}}
}

tune_up_data.recipes["tungsten-plate"] = {
  category = "purification",
  count = 5,
  energy_required = 20,
  ingredients = {{{"tungsten-ore", 10}, {"holmium-plate", 1}, {"electrolyte", 20}}}
}

tune_up_data.recipes["tungsten-carbide"] = {
  category = "purification",
  count = 5,
  energy_required = 20,
  ingredients = {{{"tungsten-ore", 5}, {"holmium-plate", 1}, {"light-oil", 30}}}
}

tune_up_data.recipes["tungsten-ore"] = {
  category = "purification",
  count = 5,
  energy_required = 10,
  ingredients = {{{"tungsten-ore", 5}, {"calcite", 1}}}
}

tune_up_data.recipes["holmium-plate"] = {
  category = "purification",
  count = 10,
  energy_required = 4,
  ingredients = {{{"electrolyte", 50}, {"holmium-ore", 1}}}
}

tune_up_data.recipes["holmium-ore"] = {
  category = "purification",
  count = 5,
  energy_required = 2,
  ingredients = {{{"electrolyte", 20}, {"holmium-ore", 1}, {"bioflux", 1}}}
}

tune_up_data.recipes["superconductor"] = {
  category = "tuning-up",
  count = 3,
  energy_required = 2,
  ingredients = {{{"electrolyte", 5}, {"carbon-fiber", 1}}}
}

tune_up_data.recipes["supercapacitor"] = {
  category = "tuning-up",
  count = 2,
  energy_required = 4,
  ingredients = {{{"lithium", 1}, {"tungsten-carbide", 1}, {"advanced-circuit", 1}}}
}

tune_up_data.recipes["lithium-plate"] = {
  category = "purification",
  count = 10,
  energy_required = 30,
  ingredients = {{{"lithium-plate", 2}, {"sulfuric-acid", 50}, {"calcite", 1}}}
}

tune_up_data.recipes["quantum-processor"] = {
  category = "tuning-up",
  count = 50,
  energy_required = 250,
  ingredients = {{{"speed-module-2", 1}, {"efficiency-module-2", 1}, {"productivity-module-2", 1}, {"quality-module-2", 1}}}
}

tune_up_data.recipes["speed-module-2"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"speed-module", 1}, {"electric-engine-unit", 5}, {"lubricant", 30}}}
}

tune_up_data.recipes["efficiency-module-2"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"efficiency-module", 1}, {"heavy-cable", 5}, {"petroleum-gas", 30}}, {{"efficiency-module", 1}, {"electronic-circuit", 10}, {"petroleum-gas", 30}}}
}

tune_up_data.recipes["productivity-module-2"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"productivity-module", 1}, {"flying-robot-frame", 5}, {"sulfuric-acid", 30}}}
}

tune_up_data.recipes["quality-module-2"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"quality-module", 1}, {"processing-unit", 5}, {"light-oil", 30}}}
}

tune_up_data.recipes["speed-module-3"] = {
  category = "tuning-up",
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"speed-module-2", 1}, {"quantum-processor", 5}, {"tungsten-plate", 20}}, {{"speed-module-2", 1}, {"processing-unit", 10}, {"express-transport-belt", 5}}}
}

tune_up_data.recipes["efficiency-module-3"] = {
  category = "tuning-up",
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"efficiency-module-2", 1}, {"quantum-processor", 5}, {"carbon-fiber", 20}}, {{"efficiency-module-2", 1}, {"processing-unit", 10}, {"solar-panel", 1}}}
}

tune_up_data.recipes["productivity-module-3"] = {
  category = "tuning-up",
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"productivity-module-2", 1}, {"quantum-processor", 5}, {"pentapod-egg", 20}}, {{"productivity-module-2", 1}, {"processing-unit", 10}, {"assembling-machine-3", 1}}}
}

tune_up_data.recipes["quality-module-3"] = {
  category = "tuning-up",
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"quality-module-2", 1}, {"quantum-processor", 5}, {"supercapacitor", 20}}, {{"quality-module-2", 5}, {"processing-unit", 10}, {"recycler", 1}}}
}

tune_up_data.recipes["biter-egg"] = {
  category = "purification",
  count = 1,
  result_is_always_fresh = true,
  energy_required = 5,
  ingredients = {{{"tree-seed", 1}, {"growth-serum", 10}}, {{"tree-seed", 1}, {"nutrients", 5}}}
}

tune_up_data.recipes["raw-fish"] = {
  category = "purification",
  count = 5,
  result_is_always_fresh = true,
  energy_required = 10,
  ingredients = {{{"tree-seed", 5}, {"biter-egg", 1}, {"growth-serum", 5}}, {{"tree-seed", 5}, {"biter-egg", 1}}}
}

tune_up_data.recipes["wood"] = {
  category = "purification",
  count = 1,
  energy_required = 2,
  ingredients = {{{"nutrients", 1}}}
}

tune_up_data.recipes["nutrients"] = {
  category = "purification",
  count = 5,
  energy_required = 1,
  ingredients = {{{"spoilage", 5}, {"fertilizer-slurry", 5}}, {{"spoilage", 5}}}
}

tune_up_data.recipes["spoilage"] = {
  category = "purification",
  count = 5,
  energy_required = 1,
  ingredients = {{{"nutrients", 1}}}
}

tune_up_data.recipes["pentapod-egg"] = {
  category = "purification",
  count = 1,
  result_is_always_fresh = true,
  energy_required = 5,
  ingredients = {{{"iron-bacteria", 2}, {"nutrients", 10}}}
}

tune_up_data.recipes["burner-inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"iron-stick", 2}}}
}

tune_up_data.recipes["inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"iron-gear-wheel", 1}}}
}

tune_up_data.recipes["long-handed-inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"linkages", 2}}, {{"iron-gear-wheel", 2}}}
}

tune_up_data.recipes["fast-inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"electric-motor", 3}}, {{"electronic-circuit", 3}}}
}

tune_up_data.recipes["bulk-inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"complex-joint", 2}}, {{"electric-engine-unit", 1}}}
}

tune_up_data.recipes["stack-inserter"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"carbon-fiber", 5}, {"bioflux", 5}, {"grabber", 1}}, {{"carbon-fiber", 5}, {"bioflux", 5}}, {{"low-density-structure", 1}, {"processing-unit", 1}}}
}

tune_up_data.recipes["pipe"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 1,
  ingredients = {{{"galvanized-steel-plate", 1}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["pump"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 1,
  ingredients = {{{"high-pressure-valve", 1}}, {{"iron-gear-wheel", 3}}}
}

tune_up_data.recipes["transport-belt"] = {
  category = "tuning-up",
  count = 2,
  energy_required = 1,
  ingredients = {{{"iron-gear-wheel", 1}}}
}

tune_up_data.recipes["fast-transport-belt"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"flywheel", 1}, {"rubber", 1}}, {{"iron-gear-wheel", 2}, {"rubber", 1}}, {{"flywheel", 1}, {"iron-gear-wheel", 1}}, {{"iron-gear-wheel", 3}} }
}

tune_up_data.recipes["express-transport-belt"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"engine-unit", 1}, {"bearing", 2}}, {{"engine-unit", 1}, {"iron-gear-wheel", 4}}}
}

tune_up_data.recipes["small-electric-pole"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"wood", 1}}}
}

tune_up_data.recipes["medium-electric-pole"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"electronic-circuit", 2}}}
}

tune_up_data.recipes["big-electric-pole"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 2,
  ingredients = {{{"electronic-circuit", 4}}}
}

tune_up_data.recipes["substation"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 3,
  ingredients = {{{"processing-unit", 1}, {"electrolyte", 10}}, {{"processing-unit", 1}}}
}

tune_up_data.recipes["assembling-machine-1"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"inserter", 2}, {"iron-gear-wheel", 2}}}
}

tune_up_data.recipes["assembling-machine-2"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 2,
  ingredients = {mods["space-age"] and {{"electric-engine-unit", 2}, {"advanced-circuit", 2}} or {{"fast-inserter", 2}, {"engine-unit", 2}}}
}

tune_up_data.recipes["assembling-machine-3"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"supercapacitor", 5}, {"tungsten-plate", 5}, {"carbon-fiber", 5}}, {{"bulk-inserter", 1}, {"electric-engine-unit", 2}}}
}

tune_up_data.recipes["chemical-plant"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"pump", 2}, {"pipe", 5}}}
}

tune_up_data.recipes["oil-refinery"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"pump", 5}, {"concrete", 15}}}
}

tune_up_data.recipes["centrifuge"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"electric-engine-unit", 20}, {"processing-unit", 10}}}
}

tune_up_data.recipes["tune-up-station"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"bulk-inserter", 10}, {"complex-joint", 10}, {"processing-unit", 10}}, {{"bulk-inserter", 10}, {"processing-unit", 10}}}
}

tune_up_data.recipes["molecular-purifier"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"quality-module-3", 1}, {"tungsten-carbide", 50}, {"bioflux", 50}, {"non-reversible-tremie-pipe", 10}}, {{"quality-module-3", 1}, {"tungsten-carbide", 50}, {"bioflux", 50}}, {{"quality-module-3", 1}, {"processing-unit", 10}}}
}

tune_up_data.recipes["lab"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"advanced-circuit", 5}}}
}

tune_up_data.recipes["electric-furnace"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"steel-furnace", 1}, {"cooling-fan", 1}}, {{"steel-furnace", 1}}}
}

tune_up_data.recipes["steel-furnace"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"refined-concrete", 10}}}
}

tune_up_data.recipes["stone-furnace"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"stone-brick", 1}}}
}

tune_up_data.recipes["beacon"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"superconductor", 15}, {"quality-module-2", 1}}, {{"quality-module-2", 1}}}
}

tune_up_data.recipes["electric-mining-drill"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"engine-unit", 2}}}
}

tune_up_data.recipes["pumpjack"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"pump", 2}, {"tungsten-plate", 1}}, {{"pump", 2}, {"fluid-regulator", 1}}, {{"pump", 2}, {"offshore-pump", 2}}}
}

tune_up_data.recipes["offshore-pump"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"pipe", 2}}}
}

tune_up_data.recipes["solar-panel"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"advanced-circuit", 5}}}
}

tune_up_data.recipes["accumulator"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"superconductor", 5}}, {{"battery", 2}}}
}

tune_up_data.recipes["boiler"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 2,
  ingredients = {{{"stone-furnace", 1}}}
}

tune_up_data.recipes["steam-engine"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"engine-unit", 1}}}
}

tune_up_data.recipes["steam-turbine"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"electric-engine-unit", 5}, {"high-pressure-valve", 10}}, {{"electric-engine-unit", 5}, {"pipe", 10}}}
}

tune_up_data.recipes["heat-exchanger"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"heat-pipe", 1}, {"tungsten-plate", 5}}, {{"heat-pipe", 1}, {"low-density-structure", 5}}}
}

tune_up_data.recipes["nuclear-reactor"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"heat-pipe", 10}, {"tungsten-plate", 25}}, {{"heat-pipe", 10}, {"refined-concrete", 50}}}
}

tune_up_data.recipes["heat-pipe"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 2,
  ingredients = {{{"tungsten-plate", 1}, {"hardened-hull", 1}}, {{"tungsten-plate", 1}}, {{"hardened-hull", 4}, {"water", 50}}, {{"steel-plate", 5}, {"water", 50}}}
}

tune_up_data.recipes["fusion-reactor"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"fluoroketone-cold", 100}, {"quantum-processor", 50}, {"supercapacitor", 50}}}
}

tune_up_data.recipes["fusion-generator"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"fluoroketone-cold", 50}, {"quantum-processor", 10}, {"supercapacitor", 10}}}
}

tune_up_data.recipes["foundry"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"tungsten-plate", 10}, {"electric-furnace", 2}, {"express-transport-belt", 10}}}
}

tune_up_data.recipes["big-mining-drill"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"productivity-module-2", 1}, {"electric-mining-drill", 5}, {"tungsten-plate", 10}}}
}

tune_up_data.recipes["electromagnetic-plant"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"quality-module-2", 1}, {"assembling-machine-3", 1}, {"supercapacitor", 50}}}
}

tune_up_data.recipes["recycler"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"quality-module-1", 1}, {"assembling-machine-2", 1}, {"superconductor", 20}}, {{"quality-module-1", 1}, {"assembling-machine-2", 1}}}
}

tune_up_data.recipes["biochamber"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"jellynut-seed", 1}, {"yumako-seed", 1}, {"carbon-fiber", 5}}}
}

tune_up_data.recipes["jellynut-seed"] = {
  category = "purification",
  count = 1,
  energy_required = 3,
  ingredients = {{{"jelly", 5}, {"bioflux", 1}, {"growth-serum", 50}}, {{"jelly", 10}, {"bioflux", 1}}}
}

tune_up_data.recipes["yumako-seed"] = {
  category = "purification",
  count = 1,
  energy_required = 3,
  ingredients = {{{"yumako-mash", 5}, {"bioflux", 1}, {"growth-serum", 50}}, {{"yumako-mash", 10}, {"bioflux", 1}}}
}

tune_up_data.recipes["biolab"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"bioflux", 30}, {"quantum-processor", 10}}}
}

tune_up_data.recipes["heating-tower"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"steel-furnace", 1}}}
}

tune_up_data.recipes["lightning-rod"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 2,
  ingredients = {{{"rubber", 5}}, {{"plastic-bar", 5}}}
}

tune_up_data.recipes["lightning-collector"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"efficiency-module", 1}, {"electrolyte", 20}}}
}

tune_up_data.recipes["captive-biter-spawner"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"biochamber", 1}, {"biter-egg", 10}}}
}

tune_up_data.recipes["cryogenic-plant"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"chemical-plant", 2}, {"biochamber", 2}, {"fluorine", 30}}}
}

tune_up_data.recipes["cargo-bay"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"low-density-structure", 15}}}
}

tune_up_data.recipes["crusher"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-carbide", 10}, {"electric-engine-unit", 5}, {"lubricant", 20}}}
}

tune_up_data.recipes["asteroid-collector"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"stack-inserter", 2}, {"processing-unit", 5}, {"lubricant", 20}}}
}

tune_up_data.recipes["thruster"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"superconductor", 30}, {"pump", 2}, {"lubricant", 20}}}
}

tune_up_data.recipes["gun-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"invar-plate", 2}, {"iron-gear-wheel", 5}}, {{"steel-plate", 2}, {"iron-gear-wheel", 5}}}
}

tune_up_data.recipes["flamethrower-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"pump", 5}}}
}

tune_up_data.recipes["laser-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"processing-unit", 1}}}
}

tune_up_data.recipes["artillery-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"radar", 15}}}
}

tune_up_data.recipes["artillery-wagon"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"radar", 15}}}
}

tune_up_data.recipes["railgun-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 50}, {"quantum-processor", 50}, {"fluoroketone-cold", 50}}}
}

tune_up_data.recipes["tesla-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 10}, {"superconductor", 50}, {"laser-turret", 4}}}
}

tune_up_data.recipes["rocket-turret"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 10}, {"gun-turret", 10}}}
}

tune_up_data.recipes["radar"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"advanced-circuit", 2}}}
}

tune_up_data.recipes["stone-wall"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"refined-concrete", 1}}}
}

tune_up_data.recipes["gate"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 1,
  ingredients = {{{"refined-concrete", 1}}}
}

tune_up_data.recipes["grenade"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"explosives", 5}}}
}

tune_up_data.recipes["cluster-grenade"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"explosives", 15}}}
}

tune_up_data.recipes["poison-capsule"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"sulfur", 1}, {"petroleum-gas", 20}}}
}

tune_up_data.recipes["slowdown-capsule"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"jelly", 2}}, {{"plastic-bar", 1}, {"heavy-oil", 10}}}
}

tune_up_data.recipes["defender-capsule"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 20,
  ingredients = {{{"gun-turret", 1}}}
}

tune_up_data.recipes["distractor-capsule"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 40,
  ingredients = {{{"laser-turret", 1}}}
}

tune_up_data.recipes["destroyer-capsule"] = {
  category = "tuning-up",
  count = 20,
  energy_required = 320,
  ingredients = {{{"tesla-turret", 1}}, {{"roboport", 1}}}
}

tune_up_data.recipes["firearm-magazine"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 5,
  ingredients = {{{"steel-plate", 1}}}
}

tune_up_data.recipes["piercing-rounds-magazine"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 10,
  ingredients = {{{"explosives", 10}}}
}

tune_up_data.recipes["uranium-rounds-magazine"] = {
  category = "tuning-up",
  count = 10,
  energy_required = 40,
  ingredients = {{{"tungsten-plate", 1}}}
}

tune_up_data.recipes["shotgun-shell"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 5,
  ingredients = {{{"explosives", 3}}}
}

tune_up_data.recipes["piercing-shotgun-shell"] = {
  category = "tuning-up",
  count = 5,
  energy_required = 5,
  ingredients = {{{"copper-plate", 10}}}
}

tune_up_data.recipes["flamethrower-ammo"] = {
  category = "purification",
  count = 1,
  energy_required = 5,
  ingredients = {{{"pipe", 1}, {"light-oil", 10}}}
}

tune_up_data.recipes["cannon-shell"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"rocket", 1}}}
}

tune_up_data.recipes["explosive-cannon-shell"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"explosive-rocket", 1}}}
}

tune_up_data.recipes["rocket"] = {
  category = "tuning-up",
  count = 10,
  energy_required = 30,
  ingredients = {{{"rocket-fuel", 1}}}
}

tune_up_data.recipes["explosive-rocket"] = {
  category = "tuning-up",
  count = 10,
  energy_required = 30,
  ingredients = {{{"rocket-fuel", 1}, {"explosives", 10}}}
}

tune_up_data.recipes["atomic-bomb"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"quantum-processor", 5}, {"promethium-asteroid-chunk", 5}}, {{"rocket-fuel", 10}, {"uranium-238", 30}}}
}

tune_up_data.recipes["artillery-shell"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"explosive-cannon-shell", 2}}}
}

tune_up_data.recipes["railgun-ammo"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"cannon-shell", 1}}}
}

tune_up_data.recipes["pistol"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"raw-fish", 1}}}
}

--rocket launcher and tesla gun are the only personal gun used in crafting.
--other personal guns + armors are such a tiny cost in comparison that i am fine forcing you to upcycle or craft from quality parts
--unclear on grid equipment because it is also used to outfit spidertrons so is in some sense "infrastructure"
tune_up_data.recipes["rocket-launcher"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"advanced-circuit", 2}}}
}

tune_up_data.recipes["tesla-gun"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"processing-unit", 5}}}
}

tune_up_data.recipes["roboport"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 10,
  ingredients = {{{"flying-robot-frame", 10}, {"processing-unit", 5}}}
}

tune_up_data.recipes["logistic-robot"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{{"rocket-control-unit", 1}}, {{"advanced-circuit", 3}}}
}

tune_up_data.recipes["construction-robot"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 5,
  ingredients = {{"tracker", 1}, {{"advanced-circuit", 2}}}
}

tune_up_data.recipes["rocket-silo"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 30,
  ingredients = {{{"quantum-processor", 100}, {"tungsten-carbide", 200}, {"carbon-fiber", 200}}, {{"space-science-pack", 25}, {"low-density-structure", 100}}}
}

tune_up_data.recipes["satellite"] = {
  category = "tuning-up",
  count = 1,
  energy_required = 20,
  ingredients = {{{"radar", 25}, {"roboport", 10}}}
}

require("bz-compat")
require("ll-compat")
