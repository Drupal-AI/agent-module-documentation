<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config: the interactive_map entity, settings, routes & permissions

## Install / enable

`drush en simple_interactive_maps`. Pulls in `field_group`, `file`, `filter` (core) and the
composer dep `drupal/field_group ^3.4 || ^4.0`. Submodules `congressional_districts_118` and
`us_state_county_maps` are optional and only add more base-map plugins.

## Permissions (`simple_interactive_maps.permissions.yml`)

- `administer interactive_map` — the only module permission; gates every map admin route and is the
  entity `admin_permission`.
- Site-wide settings form is gated by core `administer site configuration` (not the above).
- `access content` gates the three read/render endpoints (map data, AJAX loader, thumbnail).

## The `interactive_map` config entity

`src/Entity/InteractiveMap.php` — `#[ConfigEntityType(id: 'interactive_map', config_prefix:
'interactive_map')]`, implements `InteractiveMapInterface`. Handlers: `InteractiveMapListBuilder`,
add/edit form `InteractiveMapForm`, delete `EntityDeleteForm`.

`config_export` keys: `id`, `label`, `base_map`, `description` (`{value, format}`), `fill_color`,
`hover_color`, `stroke_color`, `regions`, `groups`. Default colours `#4ba0a6` / `#076369` /
`#e6e6e6` (fill/hover/stroke).

- `base_map` = the id of a `map_definition` plugin (e.g. `us_states_territories`). `MapBuilder`
  fails fast with `PluginNotFoundException` if it no longer exists.
- `regions` = keyed array (region id → override). Per region: `label`, `tooltip {value, format}`,
  `hidden` (bool), `fill_color`/`stroke_color`/`hover_color`/`text_color`, `group`, and
  `action {plugin_id, plugin_configuration}`.
- `groups` = keyed array. Per group: `label`, `override_colors`(+colours), `override_tooltip`
  (+`tooltip`), `override_action`(+`action`). A region names its group via its `group` key; group
  overrides are applied over the region in `MapDataLoader::applyGroupOverrides()`.

Entity methods: `getEmbedCode()` returns `[interactive_map map=<id>]`; `getRegions()/setRegions()`,
`getGroups()/setGroups()`, `deleteGroup()`, `compareGroupsData()` (recursive array compare, used by
the group forms).

Config schema for all of the above is in `config/schema/simple_interactive_maps.schema.yml`
(`simple_interactive_maps.interactive_map.*`). `action.plugin_configuration` is `type: ignore`
(free-form per action plugin).

## Site settings (`simple_interactive_maps.settings`)

Config object, `src/Form/SettingsForm.php`, route `simple_interactive_maps.settings` at
`/admin/config/system/interactive-map-settings`. Default install values
(`config/install/simple_interactive_maps.settings.yml`):

- `default_fill_color` `#4ba0a6`, `default_stroke_color` `#e6e6e6`, `default_hover_color`
  `#076369`, `default_text_color` `#000000`.
- `default_state_tooltip` `{value: '', format: full_html}`.
- `show_shortcodes` (bool, schema only) — whether to surface the copy-paste embed shortcode.

These seed new maps/regions; per-map and per-region/group values override them at render time.

## Admin routes (`simple_interactive_maps.routing.yml`, all `administer interactive_map` unless noted)

- Entity CRUD: `entity.interactive_map.collection` `/admin/structure/interactive-map`, `.add_form`,
  `.edit_form`, `.delete_form`.
- `simple_interactive_maps.map_regions_form` `.../regions` and `...map_regions_table_form`
  `.../regions-table` — region controllers (`MapRegionController`, `MapRegionTableController`).
- `simple_interactive_maps.region_edit` `.../region/{region_id}` — `Form\RegionEditForm`.
- Groups: `.../groups` (`MapGroupController`), `.../add-group` & `.../edit-group/{group}`
  (`Form\GroupAddForm`), `.../group-modal` (`GroupModalForm`), `.../delete-group/{group}`
  (`GroupDeleteConfirmForm`).
- `simple_interactive_maps.map_preview` `.../preview` — `MapPreviewController` (renders `#theme
  interactive_map`).
- Tools: `.../tools` (`MapToolsController`), region/group export (`RegionExportController`,
  `GroupExportController`), region/group import (`Form\RegionDataImportForm`,
  `Form\GroupDataImportForm`). See embedding/embed.md.
- `simple_interactive_maps.editor_dialog` `/admin/simple-interactive-maps/editor-dialog` —
  `Form\EditorDialogForm` (the CKEditor map picker).
- `simple_interactive_maps.settings` — `administer site configuration`.
- `.../thumbnail`, `/map-data/ajax/fetch`, `/simple-interactive-maps/ajax` — `access content`
  (render endpoints; see embedding/embed.md).

Menu/task/action links: `links.menu.yml` (Structure + Config/System entries),
`links.task.yml` (Edit / Regions / Groups / Preview / Tools tabs), `links.action.yml`
("Add interactive map").
