<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Paragraphs (bs_slider_paragraphs) — agent index

Integration submodule of **BS Slider**. Provides a Paragraphs **behavior** plugin that renders a
paragraph's multi-value field as a slider. Package `Media`. Depends on **`bs_slider`** and
**`paragraphs`**. Core `^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The behavior plugin, its config/behavior forms and render path** →
  [behavior/paragraphs-behavior.md](behavior/paragraphs-behavior.md)

## What it provides (from source)

- Behavior plugin **`bs_slider`** ("BS Slider"),
  `src/Plugin/paragraphs/Behavior/BsSliderParagraphsBehavior.php`, extends
  `ParagraphsBehaviorBase`, implements `BsSliderPluginOptionInterface` +
  `ContainerFactoryPluginInterface`.
- Type-level config form (`buildConfigurationForm`): a `field_name` select (fields with
  cardinality > 1) and a `bs_slider` fieldset of checkboxes for each optionset, each expanding to
  the plugin's option form (view-mode selects) via AJAX.
- Per-paragraph `buildBehaviorForm`: a `bs_slider` select of the enabled optionsets ("- None -"
  default), stored as a behavior setting.
- `view()` loads the chosen optionset's plugin and calls `$plugin->view($build[$field_name],
  $bs_slider, $options)` to wrap the mapped field's items.
- `getPluginOptions('target_field_view_modes')` returns the mapped entity-reference field's target
  view modes. No config schema, routes, permissions, JS or templates of its own.

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
