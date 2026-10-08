# Base settings

Config object `ckeditor5_plugin_pack.settings` (schema
`config/schema/ckeditor5_plugin_pack.schema.yml`). UI at `/admin/config/ckeditor5-plugin-pack`
(route `ckeditor5_plugin_pack.settings`, form `Drupal\ckeditor5_plugin_pack\Form\SettingsForm`).
Gated by `administer site configuration`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `dll_location` | string | `''` | Location from which the CKEditor 5 DLL/library assets are loaded (self-hosted path). |
| `block_cdn` | bool | false | If TRUE, do not load CKEditor assets from the external CDN — use the local/DLL location instead (for compliance / offline sites). |

Services behind the form:
- `ckeditor5_plugin_pack.core_library_version_checker`
  (`Utility\LibraryVersionChecker`) — checks installed CKEditor library versions and warns on
  outdated plugins.
- `ckeditor5_plugin_pack.config_handler.settings`
  (`Config\SettingsConfigHandler`) — reads/writes the settings and resolves library definitions.

The base module also registers one editor plugin itself: **Drupal powered by**
(`ckeditor5_plugin_pack__drupal_powered_by`, class
`Plugin/CKEditor5Plugin/DrupalPoweredBy`).
