<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, generation and verification

## Install

```bash
composer require drupal/themed_fast_404
drush en themed_fast_404 -y
drush cron          # REQUIRED: nothing is served until the static file exists
```

## Settings — `/admin/config/system/themed_fast_404`

| Field | Config key | Default | Notes |
|---|---|---|---|
| Use system 404 path | `use_system_404` | `false` | Scrape `system.site:page.404` instead of this module's `/page-not-found` |
| Base URL | `base_url` | `''` | Prefix used when building the URL to scrape. Set it when cron cannot determine the host (common on hosts that run cron without a URI) |
| 404 page body | `404_body` | `The requested page could not be found.` | Rendered by the module's own 404 controller |

```bash
drush cget themed_fast_404.settings
drush cset themed_fast_404.settings base_url 'https://example.com' -y
drush cset themed_fast_404.settings 404_body '<h1>Not found</h1><p>Try search.</p>' -y
drush cron    # regenerate
```

`base_url` and `404_body` are translatable config (`themed_fast_404.config_translation.yml`), so
per-language wording is possible on a multilingual site.

## What ends up in core config

The module never writes `system.performance`; it overrides it at read time:

```php
// ConfigOverrider::loadOverrides()
$overrides['system.performance']['fast_404']['html']          = file_get_contents($static_404_url);  // if generated
$overrides['system.performance']['fast_404']['exclude_paths'] = '/\/(?:styles)|(?:system\/files)\//';
$overrides['system.performance']['fast_404']['paths']         = '/\.*$/i';
```

Check what core sees, remembering `drush cget` shows overridden values by default:

```bash
drush cget system.performance fast_404.paths            # overridden value
drush cget system.performance fast_404.paths --include-overridden=0   # stored value
```

Two things to understand before deploying:

1. **`paths` matches everything.** Core's fast 404 normally targets asset-looking paths; this
   module widens it to all 404s on purpose. Anything you need excluded must go in
   `exclude_paths`, and the module's regex only spares `/styles/` and `/system/files/`. If you
   serve other file routes (e.g. a custom private-download path), core will answer 404s there
   with the static HTML instead of your handler's response.
2. **The path overrides apply immediately on install**, before any static file exists. Until cron
   runs, `fast_404.html` is not overridden, so core falls back to its own default HTML string.

## Generation

```bash
drush cron                                    # hook_cron() → buildStatic404()
ls -l web/sites/default/files/page-not-found-*.html
drush php:eval 'print \Drupal::service("themed_fast_404.manager")->getStatic404url();'
```

One file per **enabled** language: `public://page-not-found-{langcode}.html`. Adding a language
requires another cron run before that language has a themed 404.

Failure mode worth knowing: `buildStatic404()` does
`$html = @file_get_contents($url); $this->fileRepository->writeData($html, $destination, FileExists::Replace);`
— the fetch is silenced, so an unreachable URL (bad `base_url`, HTTP auth, self-signed cert on the
internal hostname) writes an **empty** file, and visitors then get an empty 404 body. Verify the
file is non-empty after the first cron:

```bash
find web/sites/default/files -name 'page-not-found-*.html' -size -1c   # lists empty (broken) files
```

## Regenerating after a theme or content change

The static file is a snapshot. Re-run cron (or press the rebuild button on the settings form)
after: theme changes, CSS/JS aggregation flushes, editing `404_body`, adding a language, or
changing `use_system_404` / `base_url`.

```bash
drush cron
# or, targeted:
drush php:eval '\Drupal::service("themed_fast_404.manager")->buildStatic404();'
```

## Verify the end result

```bash
# Should return the themed markup with a 404 status.
curl -si https://example.com/this-path-does-not-exist | head -20

# Image derivatives must still work (excluded path).
curl -sI https://example.com/sites/default/files/styles/thumbnail/public/x.jpg | head -3
```

## Uninstall

Removing the module removes the override, so core reverts to whatever is stored in
`system.performance`. The generated `page-not-found-*.html` files are left in `public://` —
delete them by hand if you care.
