# Configure Stage File Proxy

Settings form: `/admin/config/system/stage_file_proxy` (route `stage_file_proxy.admin_form`,
permission `administer stage_file_proxy settings`). Config object: `stage_file_proxy.settings`.

**Recommended:** because this module must only run on non-production sites, set config in
`settings.php` / `settings.local.php` rather than exported config. If you do use the UI plus
config sync, keep it out of production with [Config Split](https://www.drupal.org/project/config_split).

## Settings — `stage_file_proxy.settings`

| Key | Default | Meaning |
|---|---|---|
| `origin` | `''` | **Required.** Origin website, no trailing slash (e.g. `https://example.com`). May embed URL-encoded HTTP Basic Auth: `https://user:pa%26ss@example.com`. Nothing is proxied until this is set. |
| `origin_dir` | `''` | Remote files path if it differs from local (multisite). Empty → falls back to the local public files path (e.g. `sites/default/files`). |
| `hotlink` | `false` | If `true`, serve a `301` redirect to the file on the origin instead of downloading a local copy. |
| `use_imagecache_root` | `true` | If `true`, for `/styles/` (image-style) URLs, fetch the **original** image from the origin and let the image module regenerate derivatives locally; speeds up later style requests. |
| `verify` | `true` | Verify the origin's SSL certificate on HTTPS requests. |
| `excluded_extensions` | `''` | Comma-separated extensions never fetched when hotlink is off, e.g. `mp3,ogg`. |
| `proxy_headers` | `''` | Extra HTTP headers for the proxied request, one per line, `Name|Value` (e.g. `Referer|https://example.com/`). |

## settings.php form

```php
// No trailing slash on origin.
$config['stage_file_proxy.settings']['origin'] = 'https://example.com';
$config['stage_file_proxy.settings']['verify'] = TRUE;
$config['stage_file_proxy.settings']['hotlink'] = FALSE;
$config['stage_file_proxy.settings']['use_imagecache_root'] = TRUE;
$config['stage_file_proxy.settings']['origin_dir'] = 'sites/default/files';
$config['stage_file_proxy.settings']['excluded_extensions'] = 'mp3,ogg';
```

## Drush config form

```bash
drush config-set stage_file_proxy.settings origin https://example.com
drush config-set stage_file_proxy.settings hotlink FALSE
```

## Notes

- `origin` is validated as a URL by the form and by a schema `Regex` constraint that rejects a
  trailing `/`; the form/`ConfigTarget` also trims trailing `/ ` before saving.
- Hotlink vs download: hotlink stores nothing locally (301 to origin, good for very large or
  rarely-needed files); the default download mode caches a local copy after the first request.
- Config schema lives in `config/schema/stage_file_proxy.schema.yml`.
- Auto-enable after a DB sync: add a `sql-sync` `target-command-specific` `enable` entry for
  `stage_file_proxy` to your dev Drush site alias (see the module's `INSTALL.md`).
