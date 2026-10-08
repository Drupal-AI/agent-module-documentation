# Configure the PWA manifest

Config object **`pwa.config`**; form route `pwa.config_manifest` →
`/admin/config/services/pwa/manifest` (permission `administer pwa`). The manifest is served at
`/manifest.json` (route `pwa.manifest`, permission `access pwa`).

## Keys (with shipped defaults)

| Key | Default | Manifest field / meaning |
|---|---|---|
| `name` | `''` | `name` — full app name |
| `short_name` | `''` | `short_name` — home-screen label |
| `app_id` | (unset) | `id` — stable app identity |
| `description` | `''` | `description` (added only if non-empty) |
| `start_url` | `/` | `start_url` |
| `scope` | `/` | `scope` |
| `display` | `standalone` | `display` — `standalone`/`fullscreen`/`minimal-ui`/`browser` |
| `orientation` | `any` | `orientation` |
| `theme_color` | `#ffffff` | `theme_color` (also emitted as a `theme-color` meta tag) |
| `background_color` | `#ffffff` | `background_color` |
| `lang` | `''` | `lang` (added only if set) |
| `dir` | `auto` | `dir` (added only if set) |
| `categories` | `[]` | `categories` (added only if non-empty) |
| `cross_origin` | false | If TRUE, manifest `<link>` gets `crossorigin=use-credentials` (site behind HTTP auth) |
| `image_fid` / `image_small_fid` / `image_very_small_fid` | NULL | File ids for the 512 / 192 / 144 px icons (fallback: bundled `assets/icon-*.png`) |
| `manifest_path_mode` | `all_except_listed` | Path selection mode (see below) |
| `manifest_paths` | `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*` | Newline-separated path patterns |

```bash
drush cget pwa.config display
drush cset pwa.config display fullscreen -y
drush cset pwa.config name 'My PWA App' -y
```

```php
\Drupal::configFactory()->getEditable('pwa.config')
  ->set('short_name', 'MyPWA')
  ->set('theme_color', '#0678be')
  ->save();
```

## Where the manifest link is added

`pwa_manifest_should_be_added()` matches the current path (and its alias) against `manifest_paths`:

- `manifest_path_mode = all_except_listed` → the manifest link is added **everywhere except** the
  listed patterns (the default; admin/batch/node-add are excluded).
- Any other value (the include mode) → the link is added **only on** the listed patterns.
- Empty `manifest_paths` → added on all pages.

The link and the `theme-color` meta are only emitted for users with the `access pwa` permission.
Verify the generated manifest with `curl -s https://<site>/manifest.json`.
