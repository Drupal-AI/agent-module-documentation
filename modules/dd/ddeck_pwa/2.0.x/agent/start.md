<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DDECK PWA (ddeck_pwa) — agent index

A UI / iOS enhancement layer **on top of the contrib PWA module**. It adds a mobile-only Bootstrap
navigation bar (SDC), Apple `apple-mobile-web-app-*` meta tags, `apple-touch-startup-image` splash
links, and swaps PWA manifest icons for theme-provided icons. It does **not** provide a manifest or
service worker itself — that stays with `pwa:pwa`.

- Package `DDECK`. Core `^10 || ^11`. License GPL-2.0-or-later. Version `2.0.0-alpha1`.
- Dependencies: **`drupal:sdc`** (Single Directory Components) and **`pwa:pwa`**. `composer.json`
  `require` is empty (deps come from Drupal, not Composer). Markup assumes **Bootstrap 6** utility
  classes provided by the theme.

- **Settings form, config object + schema, permission, route, defaults, and the PWA-title fallback** →
  [config/settings.md](config/settings.md)
- **The hooks (html preprocess, page attachments, manifest alter), the two SDC components and their JS,
  and the theme `pwa/` asset convention** → [theming/rendering.md](theming/rendering.md)

## What it provides (from source)

- **1 service**: `ddeck_pwa.context` → `Drupal\ddeck_pwa\PwaContext` (`src/PwaContext.php`), a config
  helper: `shouldShowNavigation()` reads `enable_navigation`; `getAppleAppTitle()` reads
  `apple_app_title`, falling back to `pwa.config`'s `name` when empty.
- **1 route/form**: `ddeck_pwa.settings` at `/admin/config/services/ddeck-pwa`
  (`_form: SettingsForm`, `_permission: 'administer ddeck pwa'`); menu link under
  *Configuration → Web services* (`ddeck_pwa.links.menu.yml`).
- **1 permission**: `administer ddeck pwa` (`ddeck_pwa.permissions.yml`).
- **1 config object**: `ddeck_pwa.settings` (`apple_app_title` string, `enable_navigation` bool) with
  schema in `config/schema/` and install defaults in `config/install/`.
- **1 theme hook**: `ddeck_pwa_navigation_block` (`templates/ddeck-pwa-navigation-block.html.twig`),
  which just includes the navigation SDC.
- **2 SDC components** under `components/`: `ddeck_pwa_navigation` (bottom nav bar + JS) and
  `ddeck_pwa_loader` (spinner overlay + JS). Both take no props.
- **3 hooks** in `ddeck_pwa.module`: `hook_preprocess_html()`, `hook_page_attachments_alter()`,
  `hook_pwa_manifest_alter()` (plus `hook_theme()`).

No entities, no plugin types, no Drush, no external services, no update/install hooks.
