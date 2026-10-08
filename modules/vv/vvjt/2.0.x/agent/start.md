<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Vanilla Javascript Tabs (VVJT) — agent index

**What it is.** A Views **style plugin** (`views_vvjt`, class
`Drupal\vvjt\Plugin\views\style\Tabs`) that renders a View's rows as an accessible
**tab group** built in plain JavaScript — no jQuery, no bundled tabs library. It is the
"Tabs" member of the VVJ (package `VVJ`) family and, in 2.x, extends the shared
`vvj_core` foundation (`VvjStylePluginBase`, token resolver, JS `ElementBase`).

**Mechanism (verified from source).**
- The style plugin adds a Views format; **each View row becomes one tab**. It requires
  the *Fields* row style — `requiresFieldsRow()` inherits the base default `TRUE`, so the
  row is force-switched to `fields`, a "requires Fields" validation fires, and an info
  message links to the example view.
- `hook_theme` (`VvjtThemeHook`) registers `views_view_vvjt` → template
  `templates/views-view-vvjt.html.twig`, plus a row theme hook `views_view_vvjt_fields`
  → `templates/views-view-vvjt-fields.html.twig`. The **row template** emits the first
  field, then a literal `<div class="vvjt-separator"></div>`, then the remaining fields.
- The **main template** renders each row via `row.content|render`, splits the string on
  `<div class="vvjt-separator"></div>`: part 0 → the tab **button** (a `<button>`, or an
  `<a href="#tabs-{id}-{n}">` when deep-linking is on), part 1 → the tab **pane**
  (`role="tabpanel"`). Both halves are output through the `safe_html` Twig filter
  (from `vvj_core`) — they are already-rendered, autoescaped Views field output.
- `VvjtPreprocessHooks` rewrites the row `#theme` suggestion `views_view_fields` →
  `views_view_vvjt_fields`, and adds the legacy `vvj-tabs` class to the `views_view`
  wrapper (vvj_core's preprocess adds `.vvj-component` / `.vvj-vvjt`). Unlike vvjb, VVJT
  does **not** map options to `data-*` attributes — the Twig template consumes
  `options.*` directly and emits CSS custom properties (`--bg-buttons`, `--bg-panes`,
  `--vertical-width`, `--horizontal-width`, `--vertical-height`) inline.
- JS: `js/vvjt-tabs-element.js` defines the `<vvjt-tabs>` custom element extending
  `Drupal.Vvj.ElementBase`; `js/vvjt.js` registers `Drupal.behaviors.VVJTabs` and the
  `Drupal.vvjt.*` public API shim. Deep linking runs through `vvj_core`'s
  `Drupal.Vvj.wireDeeplink` / `writeDeeplinkHash`. All behavior is client-side, all JS
  local (no CDN).

**Facts.**
- Version **2.0.0**; core `^11.3 || ^12`; **PHP 8.3+** — no Drupal 10 path.
- Dependencies: `drupal:views`, `drupal:filter`, **`vvj_core:vvj_core`** (auto-installed
  by composer; `vvjt_update_10001` enables it on a 1.x→2.x upgrade).
- **No routes, no controllers, no permissions, no forms** of its own beyond the Views
  style options form (gated by Views' own "administer views" access). No `configure`
  admin page. Provides config schema for `views.style.views_vvjt`.
- License GPL-2.0-or-later. Maintainer: Alaa Haddad (flashwebcenter).
- Help page at `/admin/help/vvjt` (via `VvjtHelpHook`).

**Because it is a Views style plugin**, everything Views offers still applies: filters,
sorts, contextual arguments, pagers, caching and access are unchanged — the tab group is
purely the rendering layer.

## Contents
- `config/views-style.md` — the `views_vvjt` style: the first-field→button /
  rest→pane row contract, every option key with default, bound, and validation rule.
- `api/javascript-and-tokens.md` — the `Drupal.vvjt.*` public JS API, deep-linking, and
  the `[vvjt:FIELD]` / `[vvjt:FIELD:plain]` Views tokens.

## Setup
1. `composer require drupal/vvjt:^2.0` (pulls `vvj_core`), `drush en vvjt`.
2. Edit a View → set **Format** to *Views Vanilla JavaScript Tabs* → **Show** must be
   *Fields*. First field = tab button, remaining fields = pane. Configure
   layout / animation / styling / responsive / deep-linking in the format settings.
3. Optional reference view `views.view.vvjt_example` installs from `config/optional/`
   when its ID is free.
