<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Color API

## Feature switches (`colorapi.settings`)

| Key | Default | Effect |
|---|---|---|
| `enable_color_field` | `true` | Registers the `colorapi_color_field` field type (removed via `hook_field_info_alter` when false). |
| `enable_color_entity` | `false` | Registers the `colorapi_color` config entity type + its `/admin/config/color/colors` UI (removed via `hook_entity_type_alter` / `hook_menu_links_discovered_alter` when false). |

- **Settings form:** `/admin/config/color/settings` (route `colorapi.color_settings`, form
  `colorapi_module_settings_form`), reachable from the "Colors" config section at
  `/admin/config/color` (route `colorapi.admin_config`, the `configure` route).
- **Permission:** `administer colors` gates all `/admin/config/color/*` routes.
- Saving the form calls `drupal_flush_all_caches()`, so a toggle takes effect immediately.

### Guards (validation on the settings form)

- You **cannot disable the Color entity** while `colorapi_color` entities still exist in the
  database ("delete the content before you can disable the Color entity type").
- You **cannot disable the Color field** while any `colorapi_color_field` field exists — the
  form lists the offending `entity_type.field_name`(s).

### Drush / config

```bash
# Read the switches:
drush cget colorapi.settings
drush cget colorapi.settings enable_color_entity

# Enable the Color entity type (then rebuild so the entity type registers):
drush cset colorapi.settings enable_color_entity true -y && drush cr
```

Note the submit handler stores the values cast to `int` (`1`/`0`); config reads back as
truthy/falsy — compare loosely (`== true`) when introspecting.

## Managing Color configuration entities

When `enable_color_entity` is true:

- **List:** `/admin/config/color/colors` (route `entity.colorapi_color.collection`).
- **Add / Edit / Delete:** `/admin/config/color/colors/add` etc.
- Each `colorapi_color` config entity exports `id`, `label`, `color` (a `hexadecimal_color`
  string). Config name: `colorapi.colorapi_color.<id>`.

```php
// Create a named color in code (entity type must be enabled first):
\Drupal\colorapi\Entity\Color::create([
  'id' => 'brand_red',
  'label' => 'Brand Red',
  'color' => '#FF0000',
])->save();
```
