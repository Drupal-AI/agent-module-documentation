<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla JavaScript Lightbox (vvjl) — agent index

A **Views style plugin** that renders view rows as a clickable image grid opening into an accessible
lightbox modal, built with vanilla JavaScript (no jQuery). Package **VVJ**. Version **2.0.0**
(doc dir `2.x`). License GPL-2.0-or-later. Core `^11.3 || ^12`, **PHP >= 8.3**.

**Dependencies (module):** `views`, `filter`, and **`vvj_core`** (the shared v2 foundation — supplies
the style base class, token resolver, `safe_html` Twig filter, focus-trap JS, and validation bounds).
No routes, no controllers, no permissions, no Drush, no settings form. Config lives per-view in the
Views style options.

## What it provides (from source)

- **One Views style plugin**: `Lightbox` (id **`views_vvjl`**, theme `views_view_vvjl`), in
  `src/Plugin/views/style/Lightbox.php`, extending `Drupal\vvj_core\Plugin\views\style\VvjStylePluginBase`.
  Custom element tag `vvjl-lightbox`; no deep-linking, no separate `vvjl-style` CSS library.
- **Two theme hooks** (`views_view_vvjl`, `views_view_vvjl_fields`) declared by `src/Hook/VvjlThemeHook.php`,
  with templates `templates/views-view-vvjl.html.twig` and `views-view-vvjl-fields.html.twig`.
- **Preprocess hooks** (`src/Hook/VvjlPreprocessHooks.php`): builds grid `data-*` attributes, the
  rgba overlay string (`hexToRgb`), rewrites per-row theme suggestions, adds the legacy `vvj-lightbox` class.
- **Two Views tokens** `[vvjl:FIELD]` / `[vvjl:FIELD:plain]` (`src/Hook/VvjlTokenHooks.php`), delegating
  to `vvj_core.token_resolver`, reading the **first row** of the view for header/footer/empty text.
- **Help page** at `/admin/help/vvjl` rendering README.md (`src/Hook/VvjlHelpHook.php`).
- **Config schema** `views.style.views_vvjl` (`config/schema/vvjl.schema.yml`); an optional demo view
  `config/optional/views.view.vvjl_example.yml`.
- **Constants** in `src/VvjlConstants.php` (animation values, grid/overlay defaults, validation bounds).
- **JS**: `js/vvjl-lightbox-element.js` (the `<vvjl-lightbox>` custom element) + `js/vvjl.js`; library `vvjl/vvjl`.
- `vvjl.install` ships `vvjl_update_10001` which auto-enables `vvj_core` on a 1.x → 2.x upgrade.

## Solution docs

- **Set up the lightbox on a view, every style option, config schema, tokens, upgrade** →
  [views/lightbox.md](views/lightbox.md)
