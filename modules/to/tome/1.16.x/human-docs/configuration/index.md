# Configuration

Tome is unusual: it has **no admin settings form and no `tome.settings` config
object**. You configure it in two places — a handful of `$settings` keys in
`settings.php` that decide where exported files go, and the `tome:*` Drush
commands that actually do the work. (The one exception is the optional
`tome_static_cron` submodule, which does have a real config object — see its own
docs.)

## Where the files go — `settings.php`

Add the keys you need to `settings.php`. All paths are relative to the **Drupal
root** (the docroot, for example `web/`), so `../content` resolves to a sibling of
the docroot — a good place to keep exported files under version control.

| Setting | Default | Meaning |
|---|---|---|
| `tome_content_directory` | `../content` | Where Tome Sync writes content JSON and its index. |
| `tome_files_directory` | `../files` | Where Tome Sync exports managed files (public files land in a `/public` subdirectory). |
| `tome_static_directory` | `../html` | Where Tome Static writes the generated static HTML — this is the directory you deploy. |
| `tome_book_outline_directory` | `../extra` | Where core Book module outlines are exported. |
| `tome_sync_encoder` | `json` | The content encoder. `yaml` exists but is experimental; JSON is recommended. |
| `tome_static_path_exclude` | `[]` | An array of paths to skip during static generation (for example `/admin`, `/user`). |
| `tome_static_cache_exclude` | `[]` | An array of paths Tome Static should never cache. |

It is also recommended to point Drupal's config sync at a tracked directory so
configuration is versioned alongside content:

```php
$settings['config_sync_directory'] = '../config';
```

A typical block in `settings.php`:

```php
$settings['tome_content_directory'] = '../content';
$settings['tome_static_directory'] = '../html';
$settings['tome_static_path_exclude'] = ['/admin', '/user'];
```

## The Drush workflow

Run these from the site root (prefix with `ddev` on the host under DDEV).

**Content, config, and files (Tome Sync):**

- `drush tome:export` — the initial full export of all config, content, and files
  to disk. Supports `--process-count` and `--entity-count` for large sites.
- `drush tome:import` — import everything back from disk (run after a fresh
  `drush si <profile> -y` to rebuild a site).
- `drush tome:import-partial` — import only what changed since the last import.
- `drush tome:export-content node:1` / `drush tome:import-content …` — export or
  import specific entities.
- `drush tome:clean-files` — delete exported files no longer referenced by any
  content or config.

**Static HTML (Tome Static):**

- `drush tome:static --uri=https://example.com` — render every public path to
  static HTML. Passing `--uri` with your real production URL is **important** —
  without it, absolute links in the output can be wrong. Other useful options
  include `--path-pattern=<regex>` (export only matching paths), `--process-count`,
  and `--run-server`.
- `drush tome:preview` — serve the generated static directory locally (default
  port 8889) so you can check the build before deploying.

## Admin pages

If you prefer the browser, Tome exposes pages under **Configuration → Tome**:
Tome Static at `/admin/config/tome/static` and Tome Sync at
`/admin/config/tome/sync`. These let you trigger and monitor exports and static
builds, and download a static snapshot, without dropping to the command line — but
the Drush commands remain the primary and most flexible interface.
