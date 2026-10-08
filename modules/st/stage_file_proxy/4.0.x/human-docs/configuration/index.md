# Configuration

Stage File Proxy stores its settings in the `stage_file_proxy.settings` config
object. You can edit them in the settings form at **Configuration → System → Stage
File Proxy Settings** (`/admin/config/system/stage_file_proxy`, permission
**Administer stage_file_proxy settings**) — but because the module must only run on
non‑production sites, the **recommended** approach is to set them in `settings.php`
or `settings.local.php` so they never sync to production.

## Settings

- **Origin** *(required, default: empty)* — the production website to fetch files
  from, with **no trailing slash**, for example `https://example.com`. Nothing is
  proxied until this is set. You can embed HTTP Basic Auth credentials
  (URL‑encoded) to proxy from a password‑protected site, for example
  `https://user:pa%26ss@example.com`.
- **Origin directory** (`origin_dir`, default: empty) — the remote files path if it
  differs from the local one, mainly for multisite. Leave it empty to fall back to
  the local public files path (such as `sites/default/files`).
- **Hotlink** *(off by default)* — when on, serve a `301` redirect to the file on
  the origin instead of downloading a local copy. Nothing is stored locally — good
  for very large or rarely‑needed files.
- **Use imagecache root** *(on by default)* — for image‑style (`/styles/`) URLs,
  fetch the **original** image from the origin and let Drupal's image module
  regenerate the derivative locally. This speeds up later requests for other styles
  of the same image.
- **Verify SSL** (`verify`, on by default) — verify the origin's SSL certificate on
  HTTPS requests. Turn it off only when the origin uses a self‑signed certificate.
- **Excluded extensions** (default: empty) — a comma‑separated list of file
  extensions that should never be fetched (when hotlink is off), for example
  `mp3,ogg` to skip large media.
- **Proxy headers** (default: empty) — extra HTTP headers to send with the proxied
  request, one per line as `Name|Value`, for example `Referer|https://example.com/`
  to satisfy an origin's hotlink protection.

## Setting it in settings.php (recommended)

```php
// No trailing slash on origin.
$config['stage_file_proxy.settings']['origin'] = 'https://example.com';
$config['stage_file_proxy.settings']['verify'] = TRUE;
$config['stage_file_proxy.settings']['hotlink'] = FALSE;
$config['stage_file_proxy.settings']['use_imagecache_root'] = TRUE;
$config['stage_file_proxy.settings']['origin_dir'] = 'sites/default/files';
$config['stage_file_proxy.settings']['excluded_extensions'] = 'mp3,ogg';
```

You can also set values with Drush:

```bash
drush config-set stage_file_proxy.settings origin https://example.com
drush config-set stage_file_proxy.settings hotlink FALSE
```

## Warming the cache with Drush

Instead of waiting for files to stream in on demand, you can bulk‑download every
managed file from the origin with the `stage_file_proxy:dl` command (alias `sfdl`).
It pulls all public managed files that aren't already present locally:

```bash
# Download every missing managed file from the origin.
drush sfdl

# Download only one file, by its file id.
drush sfdl --fid=123

# Skip the progress bar (useful in CI / scripts).
drush sfdl --skip-progress-bar
```

The command errors out if the origin is not configured, honors the `origin_dir` and
`verify` settings, and reports totals for files downloaded, errored, and skipped.
