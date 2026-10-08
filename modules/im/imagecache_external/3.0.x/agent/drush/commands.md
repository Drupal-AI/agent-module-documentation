<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/ImagecacheExternalCommands.php` (registered via `drush.services.yml`).
All three are thin wrappers over the module's functions/config.

| Command | Args | What it does |
|---|---|---|
| `imagecache-external:generate` | `<url>` | Calls `imagecache_external_generate_path($url)` — pre-fetches/creates the local cached copy and logs its real path (or a failure notice). Use to warm the cache. |
| `imagecache-external:set-default-image` | `<fid>` (default `0`) | Sets `imagecache_external.settings:imagecache_fallback_image` to the given file id — the fallback image served when a fetch fails. |
| `imagecache-external:validate-host` | `<host>` | Reports whether the whitelist is on, the configured hosts, and whether `<host>` passes `imagecache_external_validate_host()`. |

```bash
# Warm the cache for a remote image:
drush imagecache-external:generate 'https://example.com/photo.jpg'

# Set fallback image to file entity 42:
drush imagecache-external:set-default-image 42

# Check whether a host is allowed by the current whitelist config:
drush imagecache-external:validate-host cdn.example.org
```

There is no dedicated flush Drush command — flushing is done via the admin flush form / cron
(`imagecache_external_cron_flush_frequency`).
