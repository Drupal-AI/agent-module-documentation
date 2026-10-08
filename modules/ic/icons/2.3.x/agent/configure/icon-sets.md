<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Icon Sets (the `icon_set` config entity)

An **Icon Set** is a config entity (`Drupal\icons\Entity\IconSet`) that binds a chosen IconLibrary
plugin to its settings (e.g. the on-disk library path). Every icon in the site is addressed as
`<icon_set_id>:<icon_name>`. There is no module settings form; you manage icon sets through the
entity's admin UI or in code/config.

## Admin UI / routes

Handlers: list builder `IconSetListBuilder`, forms `IconSetForm` (add/edit) + `IconSetDeleteForm`,
route provider `IconSetHtmlRouteProvider` (extends `AdminHtmlRouteProvider`). All routes are gated
by the entity `admin_permission` **`administer site configuration`**.

| Route name | Path | Purpose |
|---|---|---|
| `entity.icon_set.collection` | `/admin/appearance/icon_set` | List / add icon sets (menu link under Appearance) |
| `entity.icon_set.add_form` | `/admin/appearance/icon_set/add` | Create (choose a plugin) |
| `entity.icon_set.canonical` / `.edit_form` | `/admin/appearance/icon_set/{icon_set}` `/edit` | Edit settings |
| `entity.icon_set.delete_form` | `/admin/appearance/icon_set/{icon_set}/delete` | Delete |

Add is two-step (`IconSetForm`): first pick label, machine id and a **plugin** (from
`plugin.manager.icon_library`); the entity is saved and you are redirected to the edit form, where the
selected plugin's configuration form (`buildConfigurationForm()`) is rendered inside a `settings`
fieldset via `SubformState`. For the JSON providers (fontawesome/fontello/icomoon) that form asks for
a **Library Path** (relative to `DRUPAL_ROOT`); on submit `processJson()` reads the provider's
metadata file under that folder and caches the icon list into `settings`.

## Config object & schema

Config name: `icons.icon_set.<id>`. Schema `icons.icon_set.*` (config_entity), exported keys:

| Key | Type | Notes |
|---|---|---|
| `id` | string | Machine name |
| `label` | label | Human name |
| `plugin` | string | IconLibrary plugin id (`fontawesome` / `fontello` / `icomoon` / custom) |
| `description` | text | Optional |
| `settings` | `icon_set.settings.[%parent.plugin]` | Per-plugin settings (e.g. `library_path`, cached `icons`, `prefix`) |

`IconSet::getPlugin()` lazily builds the plugin via `IconLibraryPluginCollection` from `plugin` +
`settings`; returns `NULL` if `plugin` is empty or unknown.

## Create in code

```php
\Drupal::entityTypeManager()->getStorage('icon_set')->create([
  'id' => 'my_set',
  'label' => 'My set',
  'plugin' => 'icomoon',
  'settings' => ['library_path' => 'libraries/icomoon'],
])->save();
```

For the JSON providers, saving with a valid `library_path` through the form populates
`settings['icons']`/`prefix`; setting it purely in code will not run `processJson()`, so populate
`settings['icons']` yourself or re-save via the form. Config export gives a portable YAML
(`icons.icon_set.my_set.yml`).

## Notes

- More than one icon set → `IconsManager::getIconOptions()` groups options by set label (optgroups).
- Each provider submodule builds a per-set CSS library in `hook_library_info_build()` keyed by the
  set id, pointing at the library folder's stylesheet; `Icon::build()` attaches
  `<provider_module>/<set_id>` when an icon is rendered.
