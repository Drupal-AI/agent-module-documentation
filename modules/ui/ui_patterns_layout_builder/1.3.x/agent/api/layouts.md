<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the Layout Builder integration works

All logic lives in `ui_patterns_layout_builder.module` plus two small classes. There is nothing to
call or configure; this documents the wiring so you can debug or extend it.

## Hooks (`ui_patterns_layout_builder.module`)

- **`hook_layout_alter(&$definitions)`** — for each pattern definition, if a `pattern_<id>` layout
  exists it copies the pattern's `icon_map`/`icon_path` onto the layout and calls
  `$layout->setClass('\Drupal\ui_patterns_layout_builder\Plugin\Layout\PatternLayoutBuilder')`. This
  is what turns a UI Patterns pattern into a Layout Builder-aware layout.
- **`hook_module_implements_alter(&$implementations, $hook)`** — moves this module's `layout_alter`
  to run **last**, so `ui_patterns_layout` has already registered the base `pattern_<id>` layouts.
- **`hook_element_info_alter(&$info)`** — appends `PatternLayoutBuilder::processLayoutBuilderRegions`
  to the `pattern` element's `#pre_render`.
- **`hook_entity_view_alter(&$build, $entity, $display)`** — for each `PatternLayout` child under
  `$build['_layout_builder']`, injects `#context` (`type=layout`, entity type, bundle, view_mode,
  entity_id, entity, delta) so the pattern can use entity context.
- **`hook_theme_registry_alter(&$theme_registry)`** — adds a `region_attributes` variable to every
  `pattern_<id>` theme hook.

## `Plugin/Layout/PatternLayoutBuilder`

Extends `ui_patterns_layouts`' `PatternLayout` and implements `PluginFormInterface` +
`ContainerFactoryPluginInterface`. Exposes `getRegionNames()`/`getRegions()` from the plugin
definition, and `build($regions)` adds `#layout => $this` and merges `#fields` into the build so each
region resolves to a pattern field.

## `Element/PatternLayoutBuilder::processLayoutBuilderRegions` (trusted `#pre_render`)

After Layout Builder populates each region as a render array, this callback:
- looks up the pattern definition by `$element['#id']`,
- for each child key that is a pattern field, copies the region's children onto `$element['#<field>']`
  (unless a scalar string is already set there),
- moves the region's `#attributes` into `$element['#region_attributes'][<field>]` as an `Attribute`
  object.

Region keys are intentionally **not** unset (kept for Quick Edit). Net effect: block content dropped
into a Layout Builder region ends up in the matching slot of the pattern's Twig template, with
per-region attributes available as `region_attributes`.

## Gotcha

This release uses UI Patterns 1.x APIs (`Drupal\ui_patterns\UiPatterns`,
`ui_patterns_layouts\Plugin\Layout\PatternLayout`). On a site running UI Patterns 2.x those symbols
differ, so verify compatibility before relying on it there.
