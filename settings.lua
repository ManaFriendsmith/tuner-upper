data:extend({
    {
      type = "string-setting",
      name = "tuner-upper-byproducts",
      setting_type = "startup",
      default_value = "Disabled",
      allowed_values = {"Disabled", "Per-Recipe", "Standardised"},
      order = "a"
    },
    {
      type = "bool-setting",
      name = "tuner-upper-nerf-quality-power",
      setting_type = "startup",
      default_value = true,
      order = "b"
    },
    {
      type = "bool-setting",
      name = "tuner-upper-buff-quality-science",
      setting_type = "startup",
      default_value = true,
      order = "c"
    },
    {
      type = "string-setting",
      name = "tuner-upper-extra-tiers",
      setting_type = "startup",
      default_value = "Off",
      allowed_values = {"Off", "+3", "+5"},
      order = "d"
    },
  })
