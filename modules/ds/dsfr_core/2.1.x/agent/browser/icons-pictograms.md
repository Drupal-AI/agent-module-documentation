<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Core — icon & pictogram browsers

Searchable admin browsers for the DSFR icon and pictogram libraries, plus endpoints that
(re)generate the JSON lists the browsers consume. Controllers:
`src/Controller/FilterIconsController.php`, `src/Controller/FilterPictogramsController.php`.

## Routes and permissions (verbatim from routing.yml)

| Route | Path | Controller method | `_permission` |
|---|---|---|---|
| `dsfr_core.icons` | `/dsfr/icons/{slug}` (slug default `''`) | `FilterIconsController::content` | `access administration pages` |
| `dsfr_core.generate_icons` | `/dsfr/generate/icons` | `FilterIconsController::generate` | `access administration pages` |
| `dsfr_core.pictograms` | `/dsfr/pictograms/{slug}` (slug default `''`) | `FilterPictogramsController::content` | `access administration pages` |
| `dsfr_core.generate_pictograms` | `/dsfr/generate/pictograms` | `FilterPictogramsController::generate` | `access administration pages` |

Menu links (`dsfr_core.links.menu.yml`) surface `dsfr_core.icons` and `dsfr_core.pictograms` under
Structure → DSFR. Note the browsers are reachable at both `/dsfr/icons/{slug}` and, via the menu, as
`/admin/dsfr/icons` style children — the route paths above are authoritative.

## Browse (`content($slug)`)
- `FilterIconsController::content` returns `['#theme' => '_icons', '#slug' => $slug]`.
- `FilterPictogramsController::content` returns `['#theme' => '_pictograms', '#slug' => $slug,
  '#dsfr_path' => base_path() . \Drupal::theme()->getActiveTheme()->getPath()]`.
- Templates (`templates/-icons.html.twig`, `templates/-pictograms.html.twig`, theme hooks `_icons` /
  `_pictograms` in `dsfr_core_theme()`) attach the `dsfr_core/preact_icons` /
  `dsfr_core/preact_pictograms` library and emit a container div carrying `{{ slug }}` and
  `{{ language }}` (and `{{ dsfr_path }}` for pictograms) as `data-*` attributes. The `{slug}` from
  the URL becomes the picker's initial search filter; it is emitted through Twig attribute output
  (auto-escaped), not into raw markup.

## Preact picker app
- Bundled build: `dist/js/icons_list.min.js` / `dist/js/pictograms_list.min.js` (loaded
  `type: module`), with CSS `dist/css/icons_list.min.css` / `pictograms_list.min.css`; both depend
  on `dsfr_twig_components/code_css`.
- Sources under `src/preact/` (built with Vite — `vite.config.js`, `vite.inputs.js`; `package.json`):
  `icons/` and `pictograms/` each ship an `app.jsx`, a `*-list-controller.jsx`, container, button,
  modal, code and span/svg components, plus shared `commons/` (form, pagination,
  capitalize-first-letter, valid-name, render-component). The app mounts on the container div, reads
  the `data-search`/`data-language`/`data-dsfr` attributes, renders a paginated searchable grid of
  icons/pictograms, and shows copy-ready markup/code in a modal. Client-side only (no deep review of
  the JSX logic needed for backend behaviour).

## JSON data (`src/json/`)
- `icons-list.json`, `icons-settings.json`, `pictograms-list.json`, `pictograms-settings.json`,
  `settings.json` — static catalogues of the DSFR icon/pictogram slugs (by category) and picker
  settings that feed the Preact app.

## Generate endpoints (`generate()`)
- `FilterIconsController::generate()` calls
  `Drupal\dsfr_twig_components\Twig\Resources::iconsJson('/../../temp/')`;
  `FilterPictogramsController::generate()` calls `Resources::pictogramsJson('/../../temp/')`.
- Each wraps the returned `[$message, $type]` in a DSFR alert
  (`DsfrComponents::alert(['text' => $result[0], 'type' => $result[1], 'sm' => true])`) and returns
  it as `['#markup' => ...]`.
- The regeneration/file-writing itself lives in the **dsfr_twig_components** module
  (`Resources::iconsJson` / `pictogramsJson`); dsfr_core passes a **fixed, hard-coded** relative path
  string (`'/../../temp/'`) and takes **no** request/query/slug input into that call. No remote fetch
  is performed here. Gated by `access administration pages`.
