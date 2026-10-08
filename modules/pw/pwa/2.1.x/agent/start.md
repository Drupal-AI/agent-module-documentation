# PWA — agent index

Generates a web app manifest at `/manifest.json` from the `pwa.config` config object and links it
(plus a `theme-color` meta) into pages, making a Drupal site an installable Progressive Web App.

- **`pwa.config` keys, the manifest form, path rules, the `/manifest.json` route** →
  [configure/manifest.md](configure/manifest.md)
- **The `pwa.manifest` service (`toArray()`) and `hook_pwa_manifest_alter()`** →
  [api/manifest-service.md](api/manifest-service.md)

Key facts:
- Config object `pwa.config`; form route `pwa.config_manifest` → `/admin/config/services/pwa/manifest`
  (permission `administer pwa`). Manifest served at `/manifest.json` (route `pwa.manifest`, permission `access pwa`).
- Manifest fields from config: `name`, `short_name`, `start_url`, `display`, app `id`, `theme_color`,
  `background_color`, `scope`, `orientation`, icons (`image_fid`/`image_small_fid`/`image_very_small_fid`),
  optional `description`, `categories`, `lang`, `dir`.
- Where the manifest link is added is governed by `manifest_path_mode`
  (`all_except_listed` / include mode) + `manifest_paths` (newline path patterns).
- Permissions: `administer pwa` (config), `access pwa` (manifest link + service worker attach).
- Submodules (nested): `pwa_a2hs` (Add-to-Home-Screen block), `pwa_extras` (Apple/iOS meta),
  `pwa_service_worker` (offline service worker).
