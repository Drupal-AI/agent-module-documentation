<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Layout — selecting, storing, and rendering a layout

How the module attaches a core Layout API layout to an `entity_view_display` and renders it.
All behavior is in four files; there is no config UI beyond the Manage display form and no config
object of its own.

## Install / enable

- `drush en display_layout` (or via the UI). Requires `layout_discovery` and `field_ui` (pulled
  in as dependencies). `hook_install()` sets the module weight to `1` so its
  `hook_entity_type_alter()` runs after Layout Builder's — do not reset the weight to 0.

## Choosing a layout (the form)

1. Go to *Manage display* for a bundle/view mode, e.g.
   `/admin/structure/types/manage/article/display`.
2. Expand **"Display layout settings"** (a `details` element added by
   `DisplayLayoutFormTrait::getLayoutForm()`).
3. **Select a layout** — the `display_layout_id` select. Options come from
   `getLayoutOptions()`: every definition from `plugin.manager.core.layout`
   (`getDefinitions()`), grouped by the layout's `getCategory()` (falling back to "Other"),
   labeled with `getLabel()`. `#empty_value` is `_none`.
4. Save. On submit the edit form does:
   - `unsetThirdPartySetting('display_layout', 'layout')` first, then
   - if the chosen value is non-empty and not `_none`,
     `setThirdPartySetting('display_layout', 'layout', $layout_id)`.

After saving, `getRegions()` returns the layout's regions so Field UI's region table shows one row
per region for dragging fields.

## Which form class is active

`display_layout_entity_type_alter()` swaps the `entity_view_display` **edit** form class:

- Layout Builder **installed** → `LBEntityViewDisplayLayoutEditForm` (extends core
  `LayoutBuilderEntityViewDisplayForm`).
- Layout Builder **not installed** → `EntityViewDisplayLayoutEditForm` (extends core
  `EntityViewDisplayEditForm`).

In the Layout Builder variant, `isLayoutBuilderEnabled()` checks
`$this->entity instanceof LayoutBuilderEnabledInterface && $this->entity->isLayoutBuilderEnabled()`.
If Layout Builder is enabled **for that display**, the module adds no selector and saves nothing —
Layout Builder's own regions/UI take over (`getRegions()` calls `parent::getRegions()`). Only when
Layout Builder is off for that display does Display Layout's selector appear and save.

Access to these forms is entirely inherited from core's Field UI Manage display routes (the same
`administer …display` permissions); Display Layout adds no routes or permission checks of its own.

## Region model (`getLayoutRegions()`)

- For a chosen layout, iterates `LayoutDefinition::getRegions()` and builds
  `regions[region_id] = ['title' => label, 'message' => 'No field is displayed.']`.
- If no layout (or `_none`), falls back to a single `content` region.
- Always appends a `hidden` region titled *Disabled* (`'message' => 'No field is hidden.'`) — the
  standard place to drop fields you don't want rendered.

## Render-time alteration (`DisplayLayoutEntityViewAlter::alter()`)

`hook_entity_view_alter()` → `DisplayLayoutEntityViewAlter` (constructed with
`plugin.manager.core.layout`). On each entity view build:

1. Read `layout_id = $display->getThirdPartySetting('display_layout', 'layout')`. Empty → return
   (no change).
2. `getDefinition($layout_id, FALSE)`; if it is not a `LayoutDefinition` (e.g. the layout was
   removed) → return, so the display renders normally without the layout wrapper.
3. `createInstance($layout_id)`; seed `layout_regions` with every region name.
4. For each `$display->getComponents()` entry, read its `region`; if that region exists in the
   layout, **move** the field's already-built render array out of `$build[$field_name]` into
   `layout_regions[$region][$field_name]`.
5. `$layout_build = $layout->build($layout_regions);` then `$build['content'] = $layout_build;`.

The layout output is nested under `$build['content']` (not replacing `$build`) deliberately, so the
entity wrapper stays for **caching, contextual links, and theme-hook suggestions**. Fields whose
region is not part of the layout are left where they are.

## Storage / config export

- Stored as `third_party_settings.display_layout.layout: <layout_plugin_id>` on the
  `core.entity_view_display.<entity>.<bundle>.<view_mode>` config entity. It exports/imports with
  that display config. Fields' per-region assignment is stored by core in each component's
  `region` key as usual.
- Do not run Display Suite alongside this module — their display configuration does not map.
