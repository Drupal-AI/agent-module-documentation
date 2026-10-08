<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Tiny Slider (bs_slider_tiny_slider) — agent index

Library submodule of **BS Slider**. Provides one Tiny Slider (tns) `BsSlider` plugin. Package
`Media`. Depends on **`bs_slider`**. Core `^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The plugin, YAML config and JS init** → [plugins/tiny-slider.md](plugins/tiny-slider.md)

## What it provides (from source)

- Plugin **`tiny_slider`** (`src/Plugin/BsSlider/BsSliderTinySlider.php`) extending
  `BsSliderBase`. `defaultConfiguration()` = `['configuration' => '']` — a single YAML textarea.
  `buildPluginOptionsForm()` adds a required `view_mode` select. `preprocess()` sets
  `data-bs-slider = 'tiny-slider'` and `data-bs-slider-options = json_encode(Yaml::parse($yaml))`.
  `view()` attaches `bs_slider_tiny_slider/tiny-slider`.
- `js/tiny-slider.js` — `Drupal.behaviors.bsSliderTinySlider`: parses the data attribute, sets
  `options.container = slider`, and calls `tns(options)`.
- Config schema `bs_slider.options.tiny_slider` (`configuration` string). Shipped optionset
  `config/install/bs_slider.configuration.tiny_slider_carousel.yml`.
- Library `bs_slider_tiny_slider/tiny-slider` → self-hosted `/libraries/tiny-slider/dist/...`.
- No dedicated template (uses the base `bs_slider` theme), no routes/permissions/services.

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
