<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-form-mode themes

Form: **`/admin/config/content/form_mode_manager/theme-switcher`**
(route `form_mode_manager.theme_switcher_settings`, form `FormModeThemeSwitcherForm`,
permission `administer site configuration`). Config object:
**`form_mode_manager_theme_switcher.settings`**.

## Config shape

```yaml
form_mode_manager_theme_switcher.settings:
  type:
    <form_mode_id>: admin | <system_theme_key> | _custom
  form_mode:
    <form_mode_id>: <specific_theme_name>   # only used when type is _custom
```

- **`<form_mode_id>`** is the form-mode route's `_entity_form` operation with `.` → `_`.
  E.g. the `node.contributor` form mode → key `node_contributor`.
- **`type.<id>`** chooses the theme kind:
  - `admin` → the site admin theme (only if the user has `view the administration theme`).
  - a system theme key (e.g. `default`) → that theme from system config.
  - `_custom` → the theme named in `form_mode.<id>`.

## Resolution logic (`FormModeThemeNegotiator`)

1. `applies()` returns true only for routes with the `_form_mode_manager_entity_type_id` option
   **and** either a `form_mode_theme` route option or a configured `type.<id>`.
2. `determineActiveTheme()`:
   - a `form_mode_theme` route option wins outright;
   - else if `type.<id>` is `admin` and allowed → admin theme;
   - else if `type.<id>` is a plain key → that system theme;
   - else if `_custom` → `form_mode.<id>` theme.

## Example (Drush)

Make the `node.contributor` form-mode forms use the admin theme:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_manager_theme_switcher.settings")
  ->set("type.node_contributor", "admin")->save();'
```

Use a specific custom theme (e.g. `claro`) for that mode:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_manager_theme_switcher.settings")
  ->set("type.node_contributor", "_custom")
  ->set("form_mode.node_contributor", "claro")->save();'
```

Read it back:

```bash
drush cget form_mode_manager_theme_switcher.settings type
```
