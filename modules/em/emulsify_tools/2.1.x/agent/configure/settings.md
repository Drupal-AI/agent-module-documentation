<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `emulsify_tools.settings`

The module has **no configure route** and **no settings form of its own**. It stores a single config
object, `emulsify_tools.settings` (schema `config/schema/emulsify_tools.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `admin_theme_favicon_themes` | sequence of strings | `[]` | Machine names of themes whose **generated favicon package should also be applied on admin pages**. |

## How it is normally set

Via the Emulsify theme settings form: `AdminThemeFaviconHooks` implements
`hook_form_system_theme_settings_alter()` to add an admin-favicon toggle to a supported (Emulsify or child)
theme's settings; saving it adds/removes that theme's machine name from `admin_theme_favicon_themes`.
`hook_page_attachments_alter()` then reuses that theme's already-generated favicon package on admin routes.
It only *reuses* an existing Emulsify package; it does not generate one or replace the theme's frontend
head-tag attachment.

## Read / set via drush

```bash
drush config:get emulsify_tools.settings admin_theme_favicon_themes

# Make the 'my_theme' generated favicon also apply on admin pages:
drush php:eval '\Drupal::configFactory()->getEditable("emulsify_tools.settings")
  ->set("admin_theme_favicon_themes", ["my_theme"])->save();'
```

`isEnabledForTheme($theme)` (on `AdminThemeFaviconManager`, service
`emulsify_tools.admin_theme_favicon_manager`) returns TRUE when the theme is a supported Emulsify theme and
is present in this list. Setting a non-Emulsify theme name is stored but has no effect (it is not
"supported").
