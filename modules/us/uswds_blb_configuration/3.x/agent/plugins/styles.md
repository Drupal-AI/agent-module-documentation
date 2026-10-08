<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style & StylesGroup plugin types + the USWDS layout plugin

The module defines two custom annotation-based plugin types plus a derived Layout Builder layout.
Styles add CSS classes / background media / scroll effects to sections (via the layout form) and to
blocks (via `hook_form_alter`).

## `Style` plugin type

- Directory: `src/Plugin/UswdsStyles/Style/`. Annotation: `@Style` (`Annotation/Style.php`) with
  `id`, `title`, `weight`, and the code-consumed key `group_id` (binds a style to a StylesGroup).
- Interface: `Style\StylePluginInterface`; base class `Style\StylePluginBase`.
- Manager service: **`plugin.manager.uswds_styles`** (`Style\StyleManager`, subdir
  `Plugin/UswdsStyles/Style`, alter hook `uswds_blb_configuration_info`).
- Each plugin implements `buildConfigurationForm()`/`submitConfigurationForm()` (admin option
  source, e.g. `background_colors` textarea `key|label`), `buildStyleFormElements()` (the per-section
  / per-block widget), `submitStyleFormElements()` (returns the stored `{class: …}` map), and
  `build($build, $storage, $theme_wrapper)` (applies classes to the render array).

Built-in Style plugins (id → `group_id`):

| id | group_id |
| --- | --- |
| `background_color` | `background` |
| `background_media` | `background` |
| `border` | `border` |
| `box_shadow` | `shadow` |
| `margin` | `spacing` |
| `padding` | `spacing` |
| `scroll_effects` | `animation` |
| `text_alignment` | `typography` |
| `text_color` | `typography` |

## `StylesGroup` plugin type

- Directory: `src/Plugin/UswdsStyles/StylesGroup/`. Annotation: `@StylesGroup`
  (`Annotation/StylesGroup.php`) with `id`, `title`, `weight`.
- Interface: `StylesGroup\StylesGroupPluginInterface`; base `StylesGroup\StylesGroupPluginBase`.
- Manager service: **`plugin.manager.uswds_styles_group`** (`StylesGroup\StylesGroupManager`, subdir
  `Plugin/UswdsStyles/StylesGroup`).
- Built-in groups: `animation`, `background`, `border`, `shadow`, `spacing`, `typography`.

`StylesGroupManager` is the orchestration point:
- `getStylesGroups()` / `getStyles()` / `getGroupStyles($group_id)` — nested definitions sorted by
  weight.
- `getAllowedPlugins($filter)` — reads the `plugins.<group>.<style>.enabled` map from a filter config
  (`uswds_blb_configuration.section_styles` or `…block_styles`).
- `buildStylesFormElements($form, $form_state, $storage, $filter)` — renders enabled groups/styles as
  `details` elements.
- `submitStylesFormElements(...)` — collects submitted values into the stored map.
- `buildStyles($build, $plugins_storage, $theme_wrapper)` — invokes each group/style plugin's
  `build()` to add classes/markup to a render array.

## Adding a Style plugin

Create `Plugin/UswdsStyles/Style/MyStyle.php` extending `StylePluginBase`, annotate with `@Style`
(`id`, `title`, `group_id` matching a StylesGroup id, `weight`), implement the four methods above,
clear caches, then enable it on the section/block styles admin form.

## Derived USWDS Layout plugin

- `src/Plugin/Layout/UswdsLayout.php`, PHP attribute `#[Layout(id: 'uswds_blb_configuration',
  deriver: UswdsLayoutDeriver::class)]` — so the concrete Layout Builder plugin ids are
  `uswds_blb_configuration:<uswds_layout entity id>` (category `USWDS`).
- `Plugin/Deriver/UswdsLayoutDeriver` builds one derivative per `uswds_layout` config entity with
  `regions` `uswds_region_col_1..N`, `theme_hook = uswds_section`, `icon_map` from column count.
- The layout form (`buildConfigurationForm`) exposes container type, gutters, breakpoints and the
  section-style groups; `live_preview` wires `#ajax` live preview and reads the caller's own
  `active_device` value from the `uswds_blb_configuration` private tempstore
  (`UswdsLayout.php:692-694`), returning a `Ajax\RefreshResponsive` command.
