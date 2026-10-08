<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Matomo Noscript (piwik_noscript) — agent index

Adds Matomo's `<noscript>` tracking image to the bottom of every page, so Matomo counts visits from
clients that do not run JavaScript. The OOP `hook_page_bottom` implementation
(`src/Hook/PageBottom.php`, `#[Hook('page_bottom')]`) inserts a `<noscript class="piwik-noscript">`
`html_tag` whose child is a `#create_placeholder` + `#lazy_builder` calling the trusted callback
`piwik_noscript:getImage`. That callback (on the `piwik_noscript` service) reads the **Matomo
module's** config (`matomo.settings`: `site_id`, `url_https`) and renders a `#theme => 'image'` tag
pointing at `<url_https>js/?idsite=…&rec=1&url=…&action_name=<page title>`. It emits nothing until
those two config values exist, and honors the Matomo module's page/role visibility helpers
(`_matomo_visibility_pages()`, `_matomo_visibility_user()`) when that module is installed. When the
`matomo` module is **not** enabled, it also attaches a small JS library that `fetch()`es the same URL
with the `document.referrer` appended (`urlref=`), because a plain `<img>` cannot send the referrer.

The module has no settings form of its own — configuration lives entirely in `matomo.settings`, set
either by installing the [Matomo module](https://www.drupal.org/project/matomo) or by adding
`$config['matomo.settings']['site_id']` / `['url_https']` to `settings.php`. **Name note:** Piwik was
renamed Matomo in 2018; the project machine name keeps the old spelling while the human name/description
use the new one (a search hazard, not a functional one). Consent caveat: the noscript image is still a
tracking request to a third-party endpoint, and consent managers that block JS trackers may not block
an `<img>` inside `<noscript>`.

- Depends on: nothing hard (`.info.yml` declares no `dependencies`). Soft: `matomo.settings` config,
  optionally the `matomo` module (for visibility rules; when present, the referrer JS is skipped).
- Core: `^11.1 || ^12`. Package: none declared.
- No settings page / `configure` route. No permissions, no drush, no plugin types, no own config
  schema or install config.
- Provides: one service + public interface, `hook_page_bottom`, one alter hook
  (`hook_piwik_noscript_options_alter`), one JS library.

## What you'd do → where

- **Add / override the Matomo tracking query parameters (idsite, action_name, url, custom dimensions)** →
  [api/services.md](api/services.md) (`hook_piwik_noscript_options_alter`)
- **Call the tracking-image / URL builder from PHP, or reuse the `piwik_noscript` service** →
  [api/services.md](api/services.md)
- **Turn on tracking** (no settings form of its own) → set `matomo.settings` `site_id` + `url_https`
  via the Matomo module or `settings.php` (see Key facts).

## Key facts (real machine names)

- Service: `piwik_noscript` (`Drupal\piwik_noscript\PiwikNoscript`, `autowire: true`), interface alias
  `Drupal\piwik_noscript\PiwikNoscriptInterface`. Methods: `getImage()`, `getOptions()`,
  `getUrl(array $options)`, `getConfig()`.
- Hook: `hook_page_bottom` — OOP class `Drupal\piwik_noscript\Hook\PageBottom` (`#[Hook('page_bottom')]`,
  `__invoke(array &$page_bottom)`); adds render key `piwik_noscript`
  (`<noscript class="piwik-noscript">`) with `#lazy_builder` = `['piwik_noscript:getImage', []]`.
- Trusted callback / lazy builder id: `piwik_noscript:getImage` (`#[TrustedCallback]`).
- Alter hook: `hook_piwik_noscript_options_alter(array &$options)` — fired in `getOptions()` via
  `moduleHandler->alter('piwik_noscript_options', $options)`; `$options['query']` holds the Matomo params.
- Library: `piwik_noscript/piwik_noscript` (asset `piwik_noscript.js`; deps `core/drupalSettings`).
  drupalSettings key: `piwikNoscript.url`.
- Config read (not owned by this module): `matomo.settings:site_id`, `matomo.settings:url_https`.
- Tracking endpoint built as `Url::fromUri($url_https . 'js/')` with query
  `action_name`, `idsite`, `rec=1`, `url` (+ `send_image=0` on the JS path).
- Cache contexts added by `getImage()`: `url` (always), `user` (only when Matomo per-role visibility applies).
- `configure` = null. No routes, permissions, drush, plugin types, or config schema.
