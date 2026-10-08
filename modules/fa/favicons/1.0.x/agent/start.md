<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Favicons (favicons) — agent index

Generates a favicon / app-icon set and a web app manifest from **one uploaded PNG**, and injects the icon and
manifest markup into the `<head>` of every page. Package `SEO`. License GPL-2.0-or-later. Version **1.0.2**
(version dir `1.0.x`). Core `^10 || ^11.1`. No dependencies, no submodules, no third-party libraries, no Drush.

## What it provides (from source)

- **One settings form**: `Drupal\favicons\Form\FaviconConfigForm` (form id `favicon_config_form`,
  route `favicons.settings.form` at `/admin/config/search/favicons`, permission `administer favicons`).
  Edits the `favicons.settings` config object. → [config/settings.md](config/settings.md)
- **One service** `favicons.generator` = `Drupal\favicons\FaviconsGenerator`: builds/loads icon derivatives via
  two core Image styles. → [api/generator.md](api/generator.md)
- **Two public controllers** on `Drupal\favicons\Controller\FaviconsController`:
  `siteWebmanifest()` (route `favicons.site.webmanifest`, `/site.webmanifest`) and `faviconSvg()`
  (route `favicons.svg`, `/favicon.svg`), both requiring `access content`. → [routes/endpoints.md](routes/endpoints.md)
- **Head injection**: `favicons_page_attachments()` in `favicons.module` adds the icon `<link>` tags, the SVG
  favicon link and the manifest link to every page head. → [routes/endpoints.md](routes/endpoints.md)
- **One permission**: `administer favicons` (`restrict access: TRUE`), title *Upload and configure favicon*.
- **Config**: object `favicons.settings` with schema `config/schema/favicons.settings.schema.yml`
  (`name`, `short_name`, `theme_color`, `background_color`, `favicon` fid).
- **Two Image styles** shipped as optional config: `96x96` and `180x180` (`image_scale`, `upscale: false`).
- **Menu link** `favicons_settings` under `system.admin_config_search`; `hook_install()` sets module weight 9999.

## What it does NOT provide

No entities, no plugin types, no fields/formatters, no blocks, no Drush commands, no external HTTP calls,
no credentials/secrets. The only config is `favicons.settings`.

## Install / operate

1. `composer require drupal/favicons` then `drush en favicons -y`.
2. `drush cr` — the high install weight (9999) only takes effect after a cache rebuild.
3. Visit `/admin/config/search/favicons`, upload a square PNG, set name / short name / theme + background colour,
   save. Derivatives are generated into `public://favicons/` and the head tags appear on every page.
