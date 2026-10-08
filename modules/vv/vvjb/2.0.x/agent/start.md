<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript Basic Carousel (VVJB) — agent index

**What it is.** A Views **style plugin** (`views_vvjb`, class
`Drupal\vvjb\Plugin\views\style\BasicCarousel`) that renders any View's results as an
accessible, responsive, autoplay-capable **carousel** built in plain JavaScript — no
jQuery, no bundled slider library. It is the "Basic Carousel" member of the VVJ
("Vanilla Views JavaScript", package `VVJ`) family and, in 2.x, extends the shared
`vvj_core` foundation (`VvjStylePluginBase`, token resolver, JS `ElementBase`).

**Mechanism (verified from source).**
- The style plugin adds a Views format; each View row becomes a slide. Works with
  Fields rows OR entity/Content rows (`requiresFieldsRow()` returns `FALSE`); the
  shipped example view uses `entity:node` teaser rows.
- `hook_theme` (`VvjbThemeHook`) registers theme hook `views_view_vvjb` →
  template `templates/views-view-vvjb.html.twig`, which emits a custom element
  `<vvjb-carousel>` wrapping the rows plus arrow/dot/play-pause/progress/counter
  controls. All behavior is client-side.
- `VvjbPreprocessHooks::preprocessViewsViewVvjb` turns the ~18 saved options into
  `data-*` attributes (via `VvjbConstants::DATA_ATTRIBUTE_MAP`) read by the JS.
  It also adds legacy wrapper classes `vvj-basic-carousel` and the dot-style class
  (`bar-dots` / `square-dots`) on the `views_view` wrapper.
- JS: `js/vvjb-carousel-element.js` defines the `<vvjb-carousel>` custom element
  extending `Drupal.Vvj.ElementBase` from `vvj_core`; `js/vvjb.js` wires the
  `Drupal.behaviors.vvjbCarousel` behavior and the `Drupal.vvjb.*` public API shim.

**Facts.**
- Version **2.0.0**; core `^11.3 || ^12`; **PHP 8.3+** — no Drupal 10 path.
- Dependencies: `drupal:views`, `drupal:filter`, **`vvj_core:vvj_core`** (auto-installed
  by composer; `vvjb_update_10001` enables it on a 1.x→2.x upgrade).
- **No routes, no controllers, no permissions, no forms** of its own beyond the Views
  style options form (gated by Views' own "administer views" access). No `configure`
  admin page. Provides config schema for `views.style.views_vvjb`.
- License GPL-2.0-or-later. Maintainer: Alaa Haddad (flashwebcenter).
- Help page at `/admin/help/vvjb` renders the module README (via `VvjbHelpHook`).

**Because it is a Views style plugin**, everything Views offers still applies: filters,
sorts, contextual arguments, pagers, caching and access are unchanged — the carousel is
purely the rendering layer.

## Contents
- `config/views-style.md` — the `views_vvjb` style: every option key, default, bound,
  validation rule, and the `data-*` attribute it maps to.
- `api/javascript-and-tokens.md` — the `Drupal.vvjb.*` public JS API and the
  `[vvjb:FIELD]` / `[vvjb:FIELD:plain]` Views tokens.

## Setup
1. `composer require drupal/vvjb:^2.0` (pulls `vvj_core`), `drush en vvjb`.
2. Edit a View → set **Format** to *Views Vanilla JavaScript Basic Carousel* → **Show**
   Fields (or Content) → configure orientation / items-per-screen / autoplay / navigation.
3. Optional reference view `views.view.vvjb_example` installs from `config/optional/`
   when its ID is free.
