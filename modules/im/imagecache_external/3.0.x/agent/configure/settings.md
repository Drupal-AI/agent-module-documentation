<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Imagecache External

Config object **`imagecache_external.settings`** (defaults in `config/install/`). Admin form:
route `imagecache_external.admin_settings`, path `/admin/config/media/imagecache_external`,
permission `administer imagecache external`.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `imagecache_directory` | string | `externals` | Directory (under the default scheme) where fetched images are cached — full URI e.g. `public://externals`. |
| `imagecache_subdirectories` | boolean | `false` | If TRUE, nest cached files in 2 hashed subdirs (`/<h0>/<h1>/`) to avoid a huge flat dir. |
| `imagecache_default_extension` | string | `.jpg` | Extension appended when the source URL has none. |
| `imagecache_external_batch_flush_limit` | integer | `1000` | Files per queue chunk when flushing. |
| `imagecache_external_hosts` | string | `''` | Whitespace-separated list of allowed hosts (used when whitelist is on). |
| `imagecache_external_management` | string | `unmanaged` | `unmanaged` = plain saved file; `managed` = create a `File` entity. |
| `imagecache_external_use_whitelist` | boolean | `false` | If TRUE, only fetch images whose host matches `imagecache_external_hosts`. |
| `imagecache_fallback_image` | integer (fid) | `0` | File id served when a fetch fails; `0` = none. |
| `imagecache_external_allowed_mimetypes` | sequence | jpg/jpeg/png/gif/webp (+charset variants) + octet-stream | MIME types accepted when fetching. |
| `imagecache_external_cron_flush_frequency` | integer (days) | `0` | Flush the cache every N days on cron; `0` = never. |
| `imagecache_external_cron_flush_originals` | boolean | `true` | Whether cron flush also removes the original cached files. |
| `svg_settings.allowed_tags` | sequence | `[]` | Extra SVG tags allowed by the sanitizer (empty = library defaults). |
| `svg_settings.allowed_attributes` | sequence | `[]` | Extra SVG attributes allowed by the sanitizer. |

```bash
drush cget imagecache_external.settings
drush cset imagecache_external.settings imagecache_directory 'externals' -y
drush cset imagecache_external.settings imagecache_external_use_whitelist 1 -y
drush cset imagecache_external.settings imagecache_external_hosts 'cdn.example.org example.com' -y
```

## Host whitelist

When `imagecache_external_use_whitelist` is TRUE, `imagecache_external_validate_host()` splits
`imagecache_external_hosts` on whitespace and requires the image URL's host to match one entry
(substring/`\.?host` regex). Non-matching hosts are refused and logged. With the whitelist off,
any host is fetched. Test with `drush imagecache-external:validate-host <host>`.

## Managed vs unmanaged

`imagecache_external_management`:
- `unmanaged` — the fetched bytes are written with `FileSystem::saveData()`; no DB record.
- `managed` — written with `file.repository` `writeData()`, creating a `File` entity (usable by
  file-aware features, but must be tracked/cleaned yourself).

## Displaying external image URLs on a field

Two field formatters render a `link`/`string`/`text` field that stores an image URL:

- `imagecache_external_image` — settings `imagecache_external_style` (an image style) and
  `imagecache_external_link` (link to content/file/nothing).
- `imagecache_external_responsive_image` — settings `imagecache_external_responsive_style`
  (a responsive image style) and `imagecache_external_link`.

Set them on the field's *Manage display*; config lands in
`core.entity_view_display.<…>` → `content.<field>.type` = the formatter id.

## Flushing the cache

- Manual: flush form at `/admin/config/media/imagecache_external/flush` (route
  `imagecache_external.imagecache_external_flush_form`).
- Cron: set `imagecache_external_cron_flush_frequency` (days). `imagecache_external_cron()`
  queues deletions into the `imagecache_external_flush_images` queue in
  `imagecache_external_batch_flush_limit`-sized chunks.
