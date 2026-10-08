<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript 3D Carousel (vvjc) — agent index

A single Views **style plugin** that renders result rows as an accessible, vanilla-JS **3D
carousel**. No jQuery. Front-end runs in a `<vvjc-carousel>` custom element on the `vvj_core`
foundation. Version **2.0.0**, package **VVJ**, license **GPL-2.0-or-later**.

- **Core:** `^11.3 || ^12`, **PHP** `>=8.3`.
- **Module deps:** `views`, `filter`, `vvj_core` (`vvj_core:vvj_core`). Composer also pulls
  `drupal/vvj_core:^2.0`. No permissions, no routes, no controllers, no Drush.
- **Fourth member of the VVJ family** (accordion, basic carousel, tabs share `vvj_core`).

## What it provides (from source)

- **Views style plugin** `Carousel3D` (id **`views_vvjc`**, theme `views_view_vvjc`), in
  `src/Plugin/views/style/Carousel3D.php`, extending `vvj_core`'s `VvjStylePluginBase`. Works with
  **any** row style (`requiresFieldsRow()` → FALSE). 19 persisted option keys.
- **Config schema** `views.style.views_vvjc` (`config/schema/vvjc.schema.yml`) — no standalone
  config object; options live in each View.
- **Theme + template** `views_view_vvjc` → `templates/views-view-vvjc.html.twig`
  (`src/Hook/VvjcThemeHook.php`).
- **Preprocess hooks** (`src/Hook/VvjcPreprocessHooks.php`) — derive the RGBA per-item background
  from hex+opacity, add the legacy `vvj-carousel` class.
- **Token hooks** (`src/Hook/VvjcTokenHooks.php`) — `[vvjc:FIELD]` / `[vvjc:FIELD:plain]`, resolved
  via `vvj_core.token_resolver`.
- **Help hook** (`src/Hook/VvjcHelpHook.php`) — renders README.md at `/admin/help/vvjc`.
- **Constants** `src/VvjcConstants.php` — width/height/interval presets, bounds, deeplink reserved
  words.
- **Libraries** (`vvjc.libraries.yml`) — `vvjc`, `vvjc-admin`, and five breakpoint CSS libraries
  `vvjc__576/768/992/1200/1400`. **JS public API** `Drupal.vvjc.*`.
- **Optional config** `config/optional/views.view.vvjc_example.yml` (installs when no ID conflict;
  page `/vvjc-example`, block, entity:node teaser rows).
- **Install hook** `vvjc_update_10001()` auto-enables `vvj_core` on the 1.x → 2.x upgrade.

## Solution docs

- **The style plugin, all options + config schema, template, libraries, tokens, help, upgrade
  contract** → [views-style/carousel.md](views-style/carousel.md)
- **The `Drupal.vvjc.*` JavaScript API** → [api/javascript.md](api/javascript.md)
