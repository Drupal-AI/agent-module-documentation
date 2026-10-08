<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fblikebutton settings form + config

Global configuration for the **per-node** Like button. File: `src/Form/FblikebuttonFormSettings.php`
(`extends ConfigFormBase`, form id `fblikebutton_settings`, editable config `fblikebutton.settings`).

## Route / access / menu

- Route `fblikebutton.settings` — path `/admin/config/user-interface/fblikebutton`, `_form` =
  `FblikebuttonFormSettings`, requirement `_permission: 'administer fblikebutton'`
  (`fblikebutton.routing.yml`).
- Menu link `fblikebutton.settings` under `system.admin_config_ui`
  (`fblikebutton.links.menu.yml`); also the module's `configure` link in info.yml.

## Config object `fblikebutton.settings`

Defaults from `config/install/fblikebutton.settings.yml`; types from
`config/schema/fblikebutton.schema.yml` (`type: config_object`). All keys except `node_types` are `string`.

| Key | Form field (`buildForm`) | Widget / options | Default | Notes |
|-----|--------------------------|------------------|---------|-------|
| `node_types` | `fblikebutton_node_types` | checkboxes of `node_type_get_names()` | `{article: article}` | schema `sequence` of string; which content types get the button |
| `layout` | `fblikebutton_layout` | select: `standard`, `box_count`, `button_count`, `button` | `standard` | widget layout |
| `size` | `fblikebutton_size` | select: `small`, `large` | `small` | |
| `action` | `fblikebutton_action` | select: `like`, `recommend` | `like` | verb shown in the button |
| `colorscheme` | `fblikebutton_colorscheme` | select: `light`, `dark` | `light` | |
| `language` | `fblikebutton_language` | textfield | `en_US` | Facebook locale code (e.g. `fr_FR`); goes into the SDK URL |
| `width` | `fblikebutton_width` | textfield | `''` (empty) | pixel width, standard layout only |

The form groups fields into two `details` elements: *Visibility settings* (`node_types`) and *Appearance
settings* (the rest).

## Submit behavior

`submitForm()` calls `parent::submitForm()`, writes each value into `fblikebutton.settings`, `save()`s, then
`Cache::invalidateTags(['entity_field_info'])` — necessary because `hook_entity_extra_field_info()` derives
the extra display field from `node_types`, so the field/display cache must be rebuilt when the enabled types
change.

## After configuring

Enabling a content type here only *registers* the extra field. It renders on nodes only when the
`fblikebutton` component is placed on that type's **Manage display** view mode AND the viewer has
`access fblikebutton` (see [../behavior/attach.md](../behavior/attach.md)). Per-block appearance is set
separately on each block instance (see [../plugins/block.md](../plugins/block.md)).
