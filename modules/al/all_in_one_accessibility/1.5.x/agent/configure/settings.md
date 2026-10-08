<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring All in One Accessibility

- **Settings form:** `/admin/config/development/all-in-one-accessibility/ada_compliance`
  (route `all_in_one_accessibility.admin.allinoneaccessiblity`, form `UseridForm`).
- **Permission:** `all_in_one_accessibility_settings` (restricted; "Add ADA Tool/Script all
  over the site").
- **Config object:** `all_in_one_accessibility.userid.settings` — created on first save; there
  is **no `config/install` default**, so `\Drupal::config(...)->get()` returns empty until the
  form is saved (or you create it with `getEditable`).

## Keys written by the form (`UseridForm::submitForm`)

| Key | Meaning / typical value |
|---|---|
| `userid` | Skynet Technologies **licence token** for the widget (blank = free version). |
| `colorcode` | Widget brand colour (hex without validation here). |
| `statement_link` | URL of your accessibility statement page. |
| `position` | Fixed corner; default `bottom_right` (e.g. `bottom_left`, `top_right`, `top_left`). |
| `widget_size` | Button size; default `regularsize`. |
| `aioa_icon_type` | Icon style; default `aioa-icon-type-1`. |
| `aioa_icon_size` / `aioa_icon_sizes` | Icon size; default `aioa-default-icon`. |
| `is_widget_custom_size` / `is_widget_custom_size_mobile` | `0/1` toggles for custom sizing. |
| `widget_icon_size_custom` / `widget_icon_size_custom_mobile` | Custom icon size values. |
| `is_widget_custom_position` | `0` = fixed corner (`position`); `1` = custom pixel offsets. |
| `widget_position_left` / `_right` / `_top` / `_bottom` | Custom pixel offsets (used when `is_widget_custom_position` = 1). |
| `nofreeversion` | Flag distinguishing free vs licensed behaviour (form default 1). |

```bash
# Read / set via drush (config object name is all_in_one_accessibility.userid.settings):
drush cget all_in_one_accessibility.userid.settings
drush cset all_in_one_accessibility.userid.settings position bottom_left -y
drush cset all_in_one_accessibility.userid.settings userid 'YOUR-LICENCE-TOKEN' -y
```

The saved values are read on every page by `hook_library_info_build()` and encoded into the
external widget's script URL — see [../api/embedding.md](../api/embedding.md). The heavy
accessibility functionality lives in that hosted widget, so local configuration is limited to
these appearance/licence options.
