<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, global config & submenu icons

## Install & enable

```bash
composer require drupal/advanced_mega_menu
drush en advanced_mega_menu -y
```

No module dependencies are declared in `advanced_mega_menu.info.yml`. In practice you also need core
**Views** (to embed View blocks) and, for the REST endpoint, core **REST + Serialization**. Grant the
restricted permission **`administer advanced mega menu`** (`advanced_mega_menu.permissions.yml`,
`restrict access: true`) to trusted roles — it gates every route in this module.

## Config object: `advanced_mega_menu.settings`

Schema `advanced_mega_menu.schema.yml` (`type: config_object`), install defaults
`config/install/advanced_mega_menu.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_menus` | sequence of string | `[]` | Machine names of menus that render as mega menus. |
| `disable_assets` | boolean | `false` | When `true`, `hook_preprocess_menu` does **not** attach the module's `advanced_mega_menu` CSS/JS library — style it yourself. |
| `submenu_icon` | mapping | (unset) | Expand/collapse indicator settings (below). |

`submenu_icon` mapping keys: `enabled` (int), `separate_states` (int), `source`
(`unicode`\|`icon_font`), `unicode_expand`, `unicode_collapse`, `font_expand`, `font_collapse`,
`element` (`span`\|`i`), `aria`, `aria_expand`, `aria_collapse`.

## Settings form — `MegaMenuContentSettingsForm`

Route `advanced_mega_menu.megamenu_content.settings` at
**`/admin/structure/advanced-mega-menu/settings`** (this is the `configure` route; also linked from
*Structure → Advanced Mega Menu → Configuration*). Extends `ConfigFormBase`, form id
`advanced_mega_menu_settings_form`.

- Renders one checkbox per site menu (`menuStorage->loadMultiple()`); checked menus are written to
  `enabled_menus` in `submitForm()`. An enabled menu shows an inline *Configure Mega Menu* link to
  its `entity.menu.edit_form`.
- **Submenu icons & accessibility** fieldset: enable icon, separate expand/collapse states, icon
  source (Unicode symbols vs icon-font class), the actual symbols/classes, HTML element, and ARIA
  labels. On save: font classes go through a strict `preg_replace('/[^a-zA-Z0-9\s\-_]/','')`
  sanitizer and are format-validated by `advanced_mega_menu_are_valid_classes()`
  (regex `^[a-zA-Z_][a-zA-Z0-9\-_]*$`, required when source = icon_font); ARIA labels are run
  through `Xss::filter()`.
- **Disable Mega Menu JavaScript and CSS** checkbox → `disable_assets`.

The icon render array is built by `advanced_mega_menu_get_submenu_icons()` in the `.module` file and
exposed to the menu template as the `submenu_icon` variable.

## Enabling a menu (two ways)

- **Per menu:** `hook_entity_operation_alter` adds an *Enable Mega Menu* / *Disable Mega Menu*
  operation to each menu on *Structure → Menus*, linking to route `advanced_mega_menu.toggle`
  (`/admin/structure/menu/{menu_id}/mega-menu/{action}`). `AdvancedMegaMenuController::toggle()`
  adds/removes the menu id in `enabled_menus` and redirects to the menu collection.
- **In bulk:** tick menus on the settings form above.

Only menus present in `enabled_menus` are altered at render time (`hook_preprocess_menu`,
`hook_theme_suggestions_menu_alter`) and get the builder links injected into the menu-edit form
(`hook_form_menu_edit_form_alter`).
