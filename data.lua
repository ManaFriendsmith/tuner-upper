local item_sounds = require("__base__/prototypes/item_sounds")
local assembler2pipepictures = table.deepcopy(require("__base__/prototypes/entity/assembler-pictures").assembler2pipepictures)

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
        impact_categories={"metal-large"},
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
            pipe_picture = assembler2pipepictures,
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
            pipe_picture = assembler2pipepictures,
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
            pipe_picture = assembler2pipepictures,
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
            pipe_picture = assembler2pipepictures,
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
        impact_categories={"metal-large"},
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
            pipe_picture = assembler2pipepictures,
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
            pipe_picture = assembler2pipepictures,
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
      categories={"crafting"},
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
      enabled = false
  },
  {
      type = "recipe",
      name = "tune-up-station",
      categories={"crafting"},
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
          table.insert(v, {ingredient, amount, byproduct})
        end
      end
    else
      tune_up_data.recipes[recipe].ingredients = {{{ingredient, amount, byproduct}}}
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
    categories={"tuning-up"},
    count = 5,
    energy_required = 2,
    ingredients = {{{"bearing", 1}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["iron-stick"] = {
    categories={"tuning-up"},
    count = 20,
    energy_required = 2,
    ingredients = {{{"invar-plate", 1}}, {{"lead-expansion-bolt", 4}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["low-density-structure"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 2,
    ingredients = {{{"plastic-bar", 4}, {"loadbearing-lattice", 1}, {"iron-stick", 2, "byproduct"}}, {{"plastic-bar", 4}, {"ll-aluminium-plate", 1}, {"iron-stick", 2, "byproduct"}}, {{"plastic-bar", 4}, {"titanium-plate", 1}, {"iron-stick", 2, "byproduct"}}, {{"plastic-bar", 4}, {"steel-plate", 3}, {"iron-stick", 2, "byproduct"}}}
}

tune_up_data.recipes["engine-unit"] = {
    categories={"tuning-up"},
    count = 2,
    energy_required = 10,
    ingredients = {{{"tungsten-plate", 1}, {"galvanized-tubing", 1, "byproduct"}}, {{"tungsten-plate", 1}, {"pipe", 1, "byproduct"}}, {{"iron-gear-wheel", 5}}}
}

tune_up_data.recipes["electric-engine-unit"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"superconductor", 3}, {"semiboloid-stator", 1}, {"copper-cable", 1, "byproduct"}}, {{"superconductor", 3}, {"iron-gear-wheel", 1}, {"copper-cable", 1, "byproduct"}}, {{"advanced-circuit", 1}, {"semiboloid-stator", 1}, {"copper-cable", 1, "byproduct"}}, {{"advanced-circuit", 1}, {"iron-gear-wheel", 1}, {"copper-cable", 1, "byproduct"}}}
}

tune_up_data.recipes["flying-robot-frame"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 20,
    ingredients = {{{"supercapacitor", 2}, {"transceiver", 1}}, {{"tracker", 1}, {"electronic-circuit", 1, "byproduct"}}, {{"supercapacitor", 3}}, {{"transceiver", 2}, {"battery", 3}}, {{"advanced-circuit", 2}, {"battery", 2}}}
}

tune_up_data.recipes["copper-cable"] = {
    categories={"tuning-up"},
    count = 8,
    energy_required = 2,
    ingredients = {{{"electronic-circuit", 1}}}
}

tune_up_data.recipes["electronic-circuit"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 1,
    ingredients = {{{"plastic-bar", 1}}}
}

tune_up_data.recipes["advanced-circuit"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 2,
    ingredients = {{{"sulfuric-acid", 5}, {"integrated-circuit", 1}}, {{"sulfuric-acid", 5}, {"electronic-circuit", 1}}}
}

tune_up_data.recipes["processing-unit"] = {
    categories={"tuning-up"},
    count = 6,
    energy_required = 20,
    ingredients = {{{"speed-module", 1}, {"efficiency-module", 1}, {"productivity-module", 1}, {"quality-module", 1}, {"advanced-circuit", 4, "byproduct"}}}
}

tune_up_data.recipes["speed-module"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"fast-gearbox", 2}}, {{"electric-motor", 5}, {"electronic-circuit", 1, "byproduct"}}, {{"iron-gear-wheel", 15}}}
}

tune_up_data.recipes["efficiency-module"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"high-pressure-valve", 2}}, {{"battery", 5}, {"copper-cable", 3, "byproduct"}}}
}

tune_up_data.recipes["productivity-module"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"engine-unit", 2}, {"plastic-bar", 1, "byproduct"}}}
}

tune_up_data.recipes["quality-module"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"stepper-motor", 2}, {"electronic-circuit", 1, "byproduct"}}, {{"advanced-circuit", 2}, {"electronic-circuit", 1, "byproduct"}}}
}

tune_up_data.recipes["wood"] = {
    categories={"purification"},
    count = 2,
    energy_required = 1,
    ingredients = {{{"nutrients", 3}, {"wood", 1}, {"water", 50}}, {{"kr-biomass", 1}, {"wood", 1}, {"water", 50}}, {{"sulfur", 1}, {"wood", 1}, {"water", 50}}}
}

tune_up_data.recipes["coal"] = {
    categories={"purification"},
    count = 2,
    energy_required = 1,
    ingredients = {{{"sulfur", 1}, {"heavy-oil", 5}}}
}

tune_up_data.recipes["carbon"] = {
    categories={"purification"},
    count = 2,
    energy_required = 2,
    ingredients = {{{"coal", 2}, {"sulfuric-acid", 5}}}
}

tune_up_data.recipes["sulfur"] = {
    categories={"purification"},
    count = 2,
    energy_required = 1,
    ingredients = {{{"coal", 1}, {"petroleum-gas", 5}}}
}

tune_up_data.recipes["plastic-bar"] = {
    categories={"purification"},
    count = 3,
    energy_required = 6,
    ingredients = {{{"bioflux", 1}, {"organotins", 15}}, {{"bioflux", 1}, {"petroleum-gas", 5}}, {{"toluene", 1}, {"organotins", 15}}, {{"toluene", 1}, {"petroleum-gas", 15}}, {{"plastic-bar", 3}, {"petroleum-gas", 30}, {"organotins", 45}}, {{"plastic-bar", 3}, {"petroleum-gas", 75}}}
}

tune_up_data.recipes["rocket-fuel"] = {
    categories={"purification"},
    count = 1,
    energy_required = 5,
    ingredients = {{{"toluene", 1}, {"solid-fuel", 1}, {"light-oil", 15}}, {{"sulfur", 1}, {"solid-fuel", 1}, {"light-oil", 15}}}
}

tune_up_data.recipes["solid-fuel"] = {
    categories={"purification"},
    count = 4,
    energy_required = 1,
    ingredients = {{{"toluene", 1}, {"solid-fuel", 2}, {"petroleum-gas", 10}}, {{"coal", 1}, {"solid-fuel", 2}, {"petroleum-gas", 10}}}
}

tune_up_data.recipes["battery"] = {
    categories={"tuning-up"},
    count = 3,
    energy_required = 3,
    ingredients = {{{"sulfur", 2}, {"electronic-circuit", 1}}}
}

tune_up_data.recipes["explosives"] = {
    categories={"purification"},
    count = 2,
    energy_required = 2,
    ingredients = {{{"gunpowder", 1}}, {{"carbon", 1}, {"water", 5}}, {{"coal", 1}, {"light-oil", 10}}}
}

if not mods["space-age"] then
  tune_up_data.recipes["iron-ore"] = {
      categories={"purification"},
      count = 5,
      energy_required = 1,
      ingredients = {{{"iron-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
  }

  tune_up_data.recipes["copper-ore"] = {
      categories={"purification"},
      count = 5,
      energy_required = 1,
      ingredients = {{{"copper-ore", 5}, {"stone", 1}, {"nitric-acid", 25}}, {{"copper-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
  }
end

tune_up_data.recipes["stone"] = {
    categories={"purification"},
    count = mods["space-age"] and 10 or 20,
    energy_required = mods["space-age"] and 5 or 10,
    ingredients = mods["space-age"] and {{{"copper-ore", 2}, {"iron-ore", 2}, {"water", 30}}} or {{{"uranium-238", 1}}}
}

tune_up_data.recipes["stone-brick"] = {
    categories={"purification"},
    count = 5,
    energy_required = 5,
    ingredients = {{{"stone", 3}, {"carbon", 1}}, {{"stone", 3}, {"coal", 1}}}
}

tune_up_data.recipes["concrete"] = {
    categories={"purification"},
    count = 5,
    energy_required = 5,
    ingredients = {{{"galvanized-rod", 1}, {"stone-brick", 1}}, {{"iron-stick", 1}, {"stone-brick", 1}}}
}

tune_up_data.recipes["refined-concrete"] = {
    categories={"purification"},
    count = 5,
    energy_required = 5,
    ingredients = {{{"lead-expansion-bolt", 1}, {"concrete", 5}}, {{"iron-stick", 2}, {"concrete", 5}}}
}

tune_up_data.recipes["iron-plate"] = {
    categories={"purification"},
    count = 10,
    energy_required = 10,
    ingredients = {{{"iron-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"iron-ore", 5}}}
}

tune_up_data.recipes["steel-plate"] = {
  categories={"purification"},
  count = 5,
  energy_required = 10,
  ingredients = {{{"carbon", 3}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"coal", 2}, {"iron-ore", 10}}}
}

tune_up_data.recipes["copper-plate"] = {
    categories={"purification"},
    count = 10,
    energy_required = 10,
    ingredients = {{{"copper-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"copper-ore", 5}}}
}

tune_up_data.recipes["calcite"] = {
  categories={"purification"},
  count = 20,
  energy_required = 10,
  ingredients = {{{"stone", 5}, {"promethium-asteroid-chunk", 1}}}
}

tune_up_data.recipes["promethium-asteroid-chunk"] = {
  categories={"purification"},
  count = 1,
  energy_required = 1,
  surface_conditions = {{property="pressure", min=0, max=0}},
  ingredients = {{{"uranium-235", 1}}}
}

tune_up_data.recipes["uranium-238"] = {
  categories={"purification"},
  count = 100,
  energy_required = 100,
  ingredients = {{{"depleted-uranium-fuel-cell", 1}, {"sulfuric-acid", 100}}}
}

tune_up_data.recipes["uranium-235"] = {
  categories={"purification"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"depleted-uranium-fuel-cell", 1}, {"sulfuric-acid", 100}}}
}

tune_up_data.recipes["copper-bacteria"] = {
  categories={"purification"},
  count = 4,
  energy_required = 2,
  result_is_always_fresh = true,
  ingredients = {{{"copper-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"copper-bacteria", 1}, {"nutrients", 5}, {"growth-serum", 5}}, {{"copper-bacteria", 1}, {"nutrients", 8}}}
}

tune_up_data.recipes["iron-bacteria"] = {
  categories={"purification"},
  count = 4,
  energy_required = 2,
  result_is_always_fresh = true,
  ingredients = {{{"iron-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"iron-bacteria", 1}, {"nutrients", 5}, {"growth-serum", 5}}, {{"iron-bacteria", 1}, {"nutrients", 8}}}
}

tune_up_data.recipes["carbon-fiber"] = {
  categories={"purification"},
  count = 2,
  energy_required = 10,
  surface_conditions = {{property="pressure", min=4000, max=4000}},
  ingredients = {{{"carbon", mods["IfNickelMk2"] and 3 or 1}, {"water", 10}}}
}

tune_up_data.recipes["bioflux"] = {
  categories={"purification"},
  count = 10,
  energy_required = 10,
  ingredients = {{{"lithium-plate", 1}, {"fertilizer-slurry", 100}}, {{"lithium-plate", 1}}}
}

tune_up_data.recipes["tungsten-plate"] = {
  categories={"purification"},
  count = 5,
  energy_required = 20,
  ingredients = {{{"tungsten-ore", 10}, {"holmium-plate", 1}, {"electrolyte", 20}}}
}

tune_up_data.recipes["tungsten-carbide"] = {
  categories={"purification"},
  count = 5,
  energy_required = 20,
  ingredients = {{{"tungsten-ore", 5}, {"holmium-plate", 1}, {"light-oil", 30}}}
}

tune_up_data.recipes["tungsten-ore"] = {
  categories={"purification"},
  count = 5,
  energy_required = 10,
  ingredients = {{{"tungsten-ore", 5}, {"calcite", 1}, {"zirconium-tungstate", 1}}, {{"tungsten-ore", 5}, {"calcite", 1}}}
}

tune_up_data.recipes["holmium-plate"] = {
  categories={"purification"},
  count = 10,
  energy_required = 4,
  ingredients = {{{"electrolyte", 50}, {"holmium-ore", 1}}}
}

tune_up_data.recipes["holmium-ore"] = {
  categories={"purification"},
  count = 5,
  energy_required = 2,
  ingredients = {{{"electrolyte", 20}, {"holmium-ore", 1}, {"bioflux", 1}}}
}

tune_up_data.recipes["superconductor"] = {
  categories={"tuning-up"},
  count = 3,
  energy_required = 2,
  ingredients = {{{"electrolyte", 5}, {"carbon-fiber", 1}}}
}

tune_up_data.recipes["supercapacitor"] = {
  categories={"tuning-up"},
  count = 2,
  energy_required = 4,
  ingredients = {{{"lithium-plate", 1}, {"tungsten-carbide", 1}, {"advanced-circuit", 1}}}
}

tune_up_data.recipes["lithium-plate"] = {
  categories={"purification"},
  count = 10,
  energy_required = 30,
  ingredients = {{{"lithium-plate", 2}, {"sulfuric-acid", 50}, {"calcite", 1}}}
}

tune_up_data.recipes["quantum-processor"] = {
  categories={"tuning-up"},
  count = 50,
  energy_required = 250,
  ingredients = {{{"speed-module-2", 1}, {"efficiency-module-2", 1}, {"productivity-module-2", 1}, {"quality-module-2", 1}}}
}

tune_up_data.recipes["speed-module-2"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"speed-module", 1}, {"electric-engine-unit", 5}, {"lubricant", 30}}}
}

tune_up_data.recipes["efficiency-module-2"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"efficiency-module", 1}, {"heavy-cable", 5}, {"petroleum-gas", 30}}, {{"efficiency-module", 1}, {"electronic-circuit", 10}, {"petroleum-gas", 30}}}
}

tune_up_data.recipes["productivity-module-2"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"productivity-module", 1}, {"flying-robot-frame", 5}, {"sulfuric-acid", 30}}}
}

tune_up_data.recipes["quality-module-2"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"quality-module", 1}, {"processing-unit", 5}, {"light-oil", 30}}}
}

tune_up_data.recipes["speed-module-3"] = {
  categories={"tuning-up"},
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"speed-module-2", 1}, {"quantum-processor", 5}, {"tungsten-plate", 20}}, {{"speed-module-2", 1}, {"processing-unit", 10}, {"express-transport-belt", 5}}}
}

tune_up_data.recipes["efficiency-module-3"] = {
  categories={"tuning-up"},
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"efficiency-module-2", 1}, {"quantum-processor", 5}, {"carbon-fiber", 20}}, {{"efficiency-module-2", 1}, {"processing-unit", 10}, {"solar-panel", 1}}}
}

tune_up_data.recipes["productivity-module-3"] = {
  categories={"tuning-up"},
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"productivity-module-2", 1}, {"quantum-processor", 5}, {"pentapod-egg", 20}}, {{"productivity-module-2", 1}, {"processing-unit", 10}, {"assembling-machine-3", 1}}}
}

tune_up_data.recipes["quality-module-3"] = {
  categories={"tuning-up"},
  count = mods["space-age"] and 1 or 5,
  energy_required = mods["space-age"] and 60 or 120,
  ingredients = {{{"quality-module-2", 1}, {"quantum-processor", 5}, {"supercapacitor", 20}}, {{"quality-module-2", 5}, {"processing-unit", 10}, {"recycler", 1}}}
}

tune_up_data.recipes["biter-egg"] = {
  categories={"purification"},
  count = 1,
  result_is_always_fresh = true,
  energy_required = 5,
  ingredients = {{{"tree-seed", 1}, {"growth-serum", 10}}, {{"tree-seed", 1}, {"nutrients", 5}}}
}

tune_up_data.recipes["raw-fish"] = {
  categories={"purification"},
  count = 5,
  result_is_always_fresh = true,
  energy_required = 10,
  ingredients = {{{"tree-seed", 5}, {"biter-egg", 1}, {"growth-serum", 5}}, {{"tree-seed", 5}, {"biter-egg", 1}}}
}

tune_up_data.recipes["wood"] = {
  categories={"purification"},
  count = 1,
  energy_required = 2,
  ingredients = {{{"nutrients", 1}}}
}

tune_up_data.recipes["nutrients"] = {
  categories={"purification"},
  count = 5,
  energy_required = 1,
  ingredients = {{{"spoilage", 5}, {"fertilizer-slurry", 5}}, {{"spoilage", 5}}}
}

tune_up_data.recipes["spoilage"] = {
  categories={"purification"},
  count = 5,
  energy_required = 1,
  ingredients = {{{"nutrients", 1}}}
}

tune_up_data.recipes["pentapod-egg"] = {
  categories={"purification"},
  count = 1,
  result_is_always_fresh = true,
  energy_required = 5,
  ingredients = {{{"iron-bacteria", 2}, {"nutrients", 10}}}
}

tune_up_data.recipes["burner-inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"iron-stick", 2}}}
}

tune_up_data.recipes["inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"iron-gear-wheel", 1}}}
}

tune_up_data.recipes["long-handed-inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"linkages", 2}}, {{"iron-gear-wheel", 2}}}
}

tune_up_data.recipes["fast-inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"electric-motor", 3}}, {{"electronic-circuit", 3}}}
}

tune_up_data.recipes["bulk-inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"complex-joint", 2}}, {{"electric-engine-unit", 1}}}
}

tune_up_data.recipes["stack-inserter"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"carbon-fiber", 5}, {"bioflux", 5}, {"grabber", 1}}, {{"carbon-fiber", 5}, {"bioflux", 5}}, {{"low-density-structure", 1}, {"processing-unit", 1}}}
}

tune_up_data.recipes["pipe"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 1,
  ingredients = {{{"galvanized-steel-plate", 1}}, {{"steel-plate", 1}}}
}

tune_up_data.recipes["pump"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 1,
  ingredients = {{{"high-pressure-valve", 1}}, {{"iron-gear-wheel", 3}}}
}

tune_up_data.recipes["transport-belt"] = {
  categories={"tuning-up"},
  count = 2,
  energy_required = 1,
  ingredients = {{{"iron-gear-wheel", 1}}}
}

tune_up_data.recipes["fast-transport-belt"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"flywheel", 1}, {"rubber", 1}}, {{"iron-gear-wheel", 2}, {"rubber", 1}}, {{"flywheel", 1}, {"iron-gear-wheel", 1}}, {{"iron-gear-wheel", 3}} }
}

tune_up_data.recipes["express-transport-belt"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"engine-unit", 1}, {"bearing", 2}, {"iron-gear-wheel", 1, "byproduct"}}, {{"engine-unit", 1}, {"iron-gear-wheel", 4}}}
}

tune_up_data.recipes["small-electric-pole"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"wood", 1}}}
}

tune_up_data.recipes["medium-electric-pole"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"electronic-circuit", 2}}}
}

tune_up_data.recipes["big-electric-pole"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 2,
  ingredients = {{{"electronic-circuit", 4}}}
}

tune_up_data.recipes["substation"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 3,
  ingredients = {{{"processing-unit", 1}, {"electrolyte", 10}, {"copper-cable", 1, "byproduct"}}, {{"processing-unit", 1}, {"copper-cable", 1, "byproduct"}}}
}

tune_up_data.recipes["assembling-machine-1"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"inserter", 2}, {"iron-gear-wheel", 2}}}
}

tune_up_data.recipes["assembling-machine-2"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 2,
  ingredients = {mods["space-age"] and {{"electric-engine-unit", 2}, {"advanced-circuit", 2}} or {{"fast-inserter", 2}, {"engine-unit", 2}}}
}

tune_up_data.recipes["assembling-machine-3"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"supercapacitor", 5}, {"tungsten-plate", 5}, {"carbon-fiber", 5}}, {{"bulk-inserter", 1}, {"electric-engine-unit", 4}}}
}

tune_up_data.recipes["chemical-plant"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"pump", 2}, {"pipe", 5}}}
}

tune_up_data.recipes["oil-refinery"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"pump", 5}, {"concrete", 15}}}
}

tune_up_data.recipes["centrifuge"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"electric-engine-unit", 20}, {"speed-module-2", 2}}}
}

tune_up_data.recipes["tune-up-station"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"bulk-inserter", 10}, {"complex-joint", 10}, {"processing-unit", 10}}, {{"bulk-inserter", 10}, {"processing-unit", 10}}}
}

tune_up_data.recipes["molecular-purifier"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"quality-module-3", 1}, {"tungsten-carbide", 50}, {"bioflux", 50}, {"non-reversible-tremie-pipe", 10}}, {{"quality-module-3", 1}, {"tungsten-carbide", 50}, {"bioflux", 50}}, {{"quality-module-3", 1}, {"processing-unit", 10}}}
}

tune_up_data.recipes["lab"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"advanced-circuit", 5}}}
}

tune_up_data.recipes["electric-furnace"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"steel-furnace", 1}, {"cooling-fan", 1}}, {{"steel-furnace", 1}}}
}

tune_up_data.recipes["steel-furnace"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"refined-concrete", 10}}}
}

tune_up_data.recipes["stone-furnace"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"stone-brick", 1}}}
}

tune_up_data.recipes["beacon"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"superconductor", 15}, {"quality-module-2", 1}}, {{"quality-module-2", 1}}}
}

tune_up_data.recipes["electric-mining-drill"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"engine-unit", 2}}}
}

tune_up_data.recipes["pumpjack"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"pump", 2}, {"tungsten-plate", 1}}, {{"pump", 2}, {"fluid-regulator", 1}}, {{"pump", 2}, {"offshore-pump", 2}}}
}

tune_up_data.recipes["offshore-pump"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"pipe", 2}}}
}

tune_up_data.recipes["solar-panel"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"advanced-circuit", 3}, {"solar-cell", 5}}, {{"advanced-circuit", 5}}}
}

tune_up_data.recipes["accumulator"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"supercapacitor", 1}}, {{"battery", 2}}}
}

tune_up_data.recipes["boiler"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 2,
  ingredients = {{{"stone-furnace", 1}}}
}

tune_up_data.recipes["steam-engine"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"engine-unit", 1}}}
}

tune_up_data.recipes["steam-turbine"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"electric-engine-unit", 5}, {"high-pressure-valve", 10}}, {{"electric-engine-unit", 5}, {"pipe", 10}}}
}

tune_up_data.recipes["heat-exchanger"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"heat-pipe", 1}, {"tungsten-plate", 5}}, {{"heat-pipe", 1}, {"low-density-structure", 5}}}
}

tune_up_data.recipes["nuclear-reactor"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"heat-pipe", 10}, {"tungsten-plate", 25}}, {{"heat-pipe", 10}, {"refined-concrete", 50}}}
}

tune_up_data.recipes["heat-pipe"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 2,
  ingredients = {{{"tungsten-plate", 1}, {"hardened-hull", 1}}, {{"tungsten-plate", 1}}, {{"hardened-hull", 4}, {"water", 50}}, {{"steel-plate", 5}, {"water", 50}}}
}

tune_up_data.recipes["fusion-reactor"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"fluoroketone-cold", 100}, {"quantum-processor", 100}, {"supercapacitor", 50}, {"efficiency-module-2", 10}}}
}

tune_up_data.recipes["fusion-generator"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"fluoroketone-cold", 50}, {"quantum-processor", 25}, {"supercapacitor", 10}, {"speed-module-2", 2}}}
}

tune_up_data.recipes["foundry"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 10}, {"electric-furnace", 2}, {"express-transport-belt", 10}}}
}

tune_up_data.recipes["big-mining-drill"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"productivity-module-2", 1}, {"electric-mining-drill", 5}, {"tungsten-plate", 10}}}
}

tune_up_data.recipes["electromagnetic-plant"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"quality-module-2", 1}, {"assembling-machine-3", 1}, {"supercapacitor", 50}}}
}

tune_up_data.recipes["recycler"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  surface_conditions = {{property="magnetic-field", min=99, max=99}},
  ingredients = {{{"quality-module", 1}, {"assembling-machine-2", 1}, {"superconductor", 20}}, {{"quality-module", 1}, {"assembling-machine-2", 1}}}
}

tune_up_data.recipes["biochamber"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"jellynut-seed", 1}, {"yumako-seed", 1}, {"carbon-fiber", 5}}}
}

--brimstuff enables crafting seeds into equal quality fruits without the need of quality-1 fruits. as such quality seeds are very valuable and there should not be so easy ways to get them.
if mods["BrimStuffMk2"] then
  tune_up_data.recipes["biochamber"].count = 2
  tune_up_data.recipes["biochamber"].ingredients[1][3][2] = 10
else
  tune_up_data.recipes["jellynut-seed"] = {
    categories={"purification"},
    count = 1,
    energy_required = 3,
    ingredients = {{{"jelly", 5}, {"bioflux", 1}, {"growth-serum", 50}}, {{"jelly", 10}, {"bioflux", 1}}}
  }

  tune_up_data.recipes["yumako-seed"] = {
    categories={"purification"},
    count = 1,
    energy_required = 3,
    ingredients = {{{"yumako-mash", 5}, {"bioflux", 1}, {"growth-serum", 50}}, {{"yumako-mash", 10}, {"bioflux", 1}}}
  }
end

tune_up_data.recipes["jellynut"] = {
  categories={"purification"},
  count = 12,
  energy_required = 6,
  ingredients = {{{"yumako-mash", 1}, {"jellynut-seed", 1}, {"growth-serum", 20}}, {{"yumako-mash", 1}, {"jellynut-seed", 1}}}
}

tune_up_data.recipes["yumako"] = {
  categories={"purification"},
  count = 12,
  energy_required = 6,
  ingredients = {{{"jelly", 2}, {"yumako-seed", 1}, {"growth-serum", 20}}, {{"jelly", 2}, {"yumako-seed", 1}}}
}


tune_up_data.recipes["biolab"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"bioflux", 30}, {"quantum-processor", 10}}}
}

tune_up_data.recipes["heating-tower"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"steel-furnace", 1}, {"heat-pipe", 1}}}
}

tune_up_data.recipes["lightning-rod"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 2,
  ingredients = {{{"rubber", 5}}, {{"plastic-bar", 5}}}
}

tune_up_data.recipes["lightning-collector"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"efficiency-module", 1}, {"electrolyte", 20}}}
}

tune_up_data.recipes["captive-biter-spawner"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"biochamber", 1}, {"biter-egg", 10}}}
}

tune_up_data.recipes["cryogenic-plant"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"chemical-plant", 1}, {"biochamber", 1}, {"quantum-processor", 5}, {"fluorine", 30}}}
}

tune_up_data.recipes["cargo-bay"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"low-density-structure", 15}}}
}

tune_up_data.recipes["crusher"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-carbide", 5}, {"diamond", 5}, {"electric-engine-unit", 5}, {"lubricant", 20}}, {{"tungsten-carbide", 10}, {"electric-engine-unit", 5}, {"lubricant", 20}}}
}

tune_up_data.recipes["asteroid-collector"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"stack-inserter", 2}, {"processing-unit", 5}, {"lubricant", 20}}}
}

tune_up_data.recipes["thruster"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"superconductor", 30}, {"pump", 2}, {"lubricant", 20}}}
}

tune_up_data.recipes["gun-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"invar-plate", 2}, {"iron-gear-wheel", 5}}, {{"steel-plate", 2}, {"iron-gear-wheel", 5}}}
}

tune_up_data.recipes["flamethrower-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"pump", 5}}}
}

tune_up_data.recipes["laser-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"processing-unit", 1}, {"optical-fiber", 10}}, {{"processing-unit", 1}}}
}

tune_up_data.recipes["artillery-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"radar", 15}}}
}

tune_up_data.recipes["artillery-wagon"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"radar", 15}}}
}

tune_up_data.recipes["railgun-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 50}, {"quantum-processor", 50}, {"fluoroketone-cold", 50}}}
}

tune_up_data.recipes["tesla-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 10}, {"superconductor", 50}, {"laser-turret", 4}}}
}

tune_up_data.recipes["rocket-turret"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"tungsten-plate", 10}, {"gun-turret", 10}}}
}

tune_up_data.recipes["radar"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"advanced-circuit", 2}}}
}

tune_up_data.recipes["stone-wall"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"refined-concrete", 1}}}
}

tune_up_data.recipes["gate"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 1,
  ingredients = {{{"refined-concrete", 1}}}
}

tune_up_data.recipes["grenade"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"explosives", 5}}}
}

tune_up_data.recipes["cluster-grenade"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"explosives", 15}}}
}

tune_up_data.recipes["poison-capsule"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"sulfur", 1}, {"petroleum-gas", 20}}}
}

tune_up_data.recipes["slowdown-capsule"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"jelly", 2}}, {{"plastic-bar", 1}, {"heavy-oil", 10}}}
}

tune_up_data.recipes["defender-capsule"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 20,
  ingredients = {{{"gun-turret", 1}}}
}

tune_up_data.recipes["distractor-capsule"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 40,
  ingredients = {{{"laser-turret", 1}}}
}

tune_up_data.recipes["destroyer-capsule"] = {
  categories={"tuning-up"},
  count = 20,
  energy_required = 320,
  ingredients = {{{"tesla-turret", 1}}, {{"roboport", 1}}}
}

tune_up_data.recipes["firearm-magazine"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 5,
  ingredients = {{{"steel-plate", 1}}}
}

tune_up_data.recipes["piercing-rounds-magazine"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 10,
  ingredients = {{{"explosives", 10}}}
}

tune_up_data.recipes["uranium-rounds-magazine"] = {
  categories={"tuning-up"},
  count = 10,
  energy_required = 40,
  ingredients = {{{"tungsten-plate", 1}}}
}

tune_up_data.recipes["shotgun-shell"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 5,
  ingredients = {{{"explosives", 3}}}
}

tune_up_data.recipes["piercing-shotgun-shell"] = {
  categories={"tuning-up"},
  count = 5,
  energy_required = 5,
  ingredients = {{{"copper-plate", 10}}}
}

tune_up_data.recipes["flamethrower-ammo"] = {
  categories={"purification"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"pipe", 1}, {"light-oil", 10}}}
}

tune_up_data.recipes["cannon-shell"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"rocket", 1}}}
}

tune_up_data.recipes["explosive-cannon-shell"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"explosive-rocket", 1}}}
}

tune_up_data.recipes["rocket"] = {
  categories={"tuning-up"},
  count = 10,
  energy_required = 30,
  ingredients = {{{"rocket-fuel", 1}}}
}

tune_up_data.recipes["explosive-rocket"] = {
  categories={"tuning-up"},
  count = 10,
  energy_required = 30,
  ingredients = {{{"rocket-fuel", 1}, {"explosives", 10}}}
}

tune_up_data.recipes["atomic-bomb"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"quantum-processor", 5}, {"promethium-asteroid-chunk", 5}}, {{"rocket-fuel", 10}, {"uranium-238", 30}}}
}

tune_up_data.recipes["artillery-shell"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"explosive-cannon-shell", 2}}}
}

tune_up_data.recipes["railgun-ammo"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"cannon-shell", 1}}}
}

tune_up_data.recipes["pistol"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"raw-fish", 1}}}
}

--rocket launcher and tesla gun are the only personal gun used in crafting.
--other personal guns + armors are such a tiny cost in comparison that i am fine forcing you to upcycle or craft from quality parts
--unclear on grid equipment because it is also used to outfit spidertrons so is in some sense "infrastructure"
tune_up_data.recipes["rocket-launcher"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"advanced-circuit", 2}}}
}

tune_up_data.recipes["tesla-gun"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"processing-unit", 5}}}
}

tune_up_data.recipes["roboport"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 10,
  ingredients = {{{"flying-robot-frame", 10}, {"processing-unit", 5}}}
}

tune_up_data.recipes["logistic-robot"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{{"rocket-control-unit", 1}}, {{"advanced-circuit", 3}}}
}

tune_up_data.recipes["construction-robot"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 5,
  ingredients = {{"tracker", 1}, {{"advanced-circuit", 2}}}
}

tune_up_data.recipes["rocket-silo"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 30,
  ingredients = {{{"quantum-processor", 100}, {"tungsten-carbide", 200}, {"carbon-fiber", 200}}, {{"space-science-pack", 25}, {"low-density-structure", 100}}}
}

tune_up_data.recipes["satellite"] = {
  categories={"tuning-up"},
  count = 1,
  energy_required = 20,
  ingredients = {{{"radar", 25}, {"roboport", 10}}}
}

local upgrade_item_in_sim = mods["BrassTacksMk2"] and "bearing" or "steel-plate"

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
