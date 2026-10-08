<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome configuration (settings.php)

Tome has **no `tome.settings` config object and no configure route**. Output locations and
the content encoder are set as `$settings` in `settings.php` (read via `Settings::get()`).
All paths are relative to the **Drupal root** (the docroot, e.g. `web/`), so `../content`
resolves to a sibling of the docroot.

| Setting | Default | Meaning |
|---|---|---|
| `tome_content_directory` | `../content` | Where Tome Sync writes content JSON + `meta/index.json`. |
| `tome_files_directory` | `../files` | Where Tome Sync exports managed files (`/public` subdir for public files). |
| `tome_static_directory` | `../html` | Where Tome Static writes generated HTML (returned by `getStaticDirectory()`). |
| `tome_book_outline_directory` | `../extra` | Where Book module outlines are exported. |
| `tome_sync_encoder` | `json` | Content encoder; `yaml` is available but experimental (see `TomeSyncServiceProvider`). |
| `tome_static_path_exclude` | `[]` | Array of paths to exclude from static generation (e.g. system paths). |
| `tome_static_cache_exclude` | `[]` | Array of paths that Tome Static should never cache. |

Recommended companion setting: point config sync at a tracked directory, e.g.
`$settings['config_sync_directory'] = '../config';`.

Example:
```php
$settings['tome_content_directory'] = '../content';
$settings['tome_static_directory'] = '../html';
$settings['tome_static_path_exclude'] = ['/admin', '/user'];
```

Runtime state (not config), managed by `tome_static`:
- `tome_static.url` — the base URL used for the last static build.
- `tome_static.building` — TRUE while a build is running.

`tome_static_cron` is the **only** Tome piece with a real config object
(`tome_static_cron.settings:base_url`) — see its own docs.
