<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Components — settings, config objects & permissions

## Install / enable

`drush en layoutcomponents -y`. Pulls in a large dependency set (see start.md); the contrib deps
(`viewsreference`, `color_field`, `linked_field`, `entity_reference_revisions`,
`inline_entity_form`, `media_library_form_element`, `block_form_alter`, `jquery_ui_slider`,
`jquery_ui_tooltip`, `sliderwidget`, `video_embed_field`) must be available via Composer. Layout
Builder must be enabled and turned on for the entity view display(s) you want to build.
`hook_install`/updates: `layoutcomponents.install` ships `layoutcomponents_update_8001`
(installs the five default config objects through `LcUpdateManager::updateConfig()`) and
`_8002` (backfills `section_overwrite`/`section_label`/`section_delta` on existing node LB
displays).

## Config objects (`config/install/*`, schema `config/schema/layoutcomponents.schema.yml`)

Five `config_object`s, each edited by one settings form:

- **`layoutcomponents.general`** — `folder` (string; where exported blocks are stored, relative to
  `DRUPAL_ROOT`), `width` (string; lateral-menu width px).
- **`layoutcomponents.interface`** — `theme_type` (string; builder UI theme, e.g. light/dark).
- **`layoutcomponents.colors`** — `editor_colors_list` (string; the editor color palette; read raw
  via `Api\Color` `getRawData()['editor_colors_list']`).
- **`layoutcomponents.section`** — default section styling: `title_text`, `description_text` (text),
  `title_color`/`title_border_color`/`background_color` (type `layoutcomponents.color_setting` =
  `{settings:{color,opacity}}`), `title_type/align/size/border*`, `title_margin_top/bottom`,
  `section_type`, `full_width`/`_container`/`_container_title` (int flags), `height`/`height_size`,
  `top_padding`/`bottom_padding`, `extra_class`, `extra_attributes`.
- **`layoutcomponents.column`** — default column styling: title fields, `background_color`,
  `border_type/size/color`, four `border_radius_*`, `remove_paddings`/`_left_padding`/
  `_right_padding` (int), `extra_class`.

New LC sections/columns inherit these defaults; `LcBase::defaultConfiguration()` and the render
service (`LcLayoutRender::getSetting()`) read them.

## Settings routes & forms (`*.routing.yml`, `*.links.menu.yml`, `*.links.task.yml`)

All under **`/admin/config/layoutcomponents/settings`** (menu *Configuration → Layout Components*),
each its own form + permission:

| Route | Path | Form | Permission |
|---|---|---|---|
| `layoutcomponents.settings_general` | `/settings` | `Form\LcSettings` | `default lc general settings` |
| `layoutcomponents.interface_settings` | `/settings/interface` | `Form\LcInterfaceSettings` | `default lc interface settings` |
| `layoutcomponents.colors_settings` | `/settings/colors` | `Form\LcColorsSettings` | `default lc colors settings` |
| `layoutcomponents.section_settings` | `/settings/section` | `Form\LcSectionSettings` | `default lc section settings` |
| `layoutcomponents.column_settings` | `/settings/column` | `Form\LcColumnSettings` | `default lc column settings` |

`configure` key in info.yml points to `layoutcomponents.settings_general`. `LcSettings` is a
`ConfigFormBase` editing `layoutcomponents.general` (folder textfield defaulting to
`/config/block_content`, width number 200–1000).

## Permissions (`*.permissions.yml` + `LcPermissions`)

- **Static** (permissions.yml): `default lc general settings`, `default lc interface settings`,
  `default lc colors settings`, `default lc section settings`, `default lc column settings`.
- **Dynamic** via `permission_callbacks` → `LcPermissions::getPermissions()`: for every entity view
  display with Layout Builder `allow_custom = TRUE`, generates per bundle+entity-type:
  `create … sections`, `move all … sections`, `remove all … sections`, `configure all … sections`,
  `change all … layout sections`, `copy all … sections`, `configure all … columns`,
  `copy all … columns`, `add … blocks`, `move … blocks`, `remove … blocks`, `configure … blocks`,
  `copy … blocks`.
- The clipboard route uses **`lc clipboard`** (referenced in routing; granted alongside builder
  perms).

Access helper: `Access\LcAccessHelperTrait::getAccess($account, $permission)` returns TRUE if the
account has the permission **or** is in the `administrator` role; LC edit forms/elements gate their
per-section/-column/-block controls with it. `LcLayoutRender::getAccessByRol()` implements the
cosmetic per-section role visibility (administrators always pass).
