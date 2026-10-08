<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Twig Components (dsfr_twig_components) — agent index

A **Twig-extension** module that adds a large set of Twig functions for building
**DSFR** (Systeme de Design de l'Etat / French State Design System) markup from templates,
plus generic HTML-markup helpers, small utility functions, an icon/pictogram catalog, and an
admin-only demo/reference page. Package `DSFR`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

> Installed here as a **git dev-checkout** — `.info.yml` has **no `version:`** (required as
> `^2.1@dev`). Version dir `2.1.x`. No `composer.json`, no `permissions.yml`, no `config/`.

Dependencies (core only): **media**, **media_library**, **text** (from `.info.yml`).
No submodules. No permissions of its own. No Drush. No config objects or schema.

## The subsystems (all in `src/Twig/`, all static classes)

- **`TwigExtension`** (service `dsfr_twig_components.twig.twig_extension`, tag `twig.extension`) —
  the only functional service. `twigFunctionsList()` maps each Twig function name to a
  `[class, method]`, and `getFunctions()` registers every one as a `TwigFunction` with
  **`is_safe => ['html']`**.
- **`DsfrComponents`** — the `dsfr_*` component functions (alert, badge, button(s), callout, card,
  tile, title, highlight, image, link, quote, notice, accordion(s), tab(s), tag(s), search,
  tooltip, franceconnect). Central builders `dsfrComponent()` / `dsfrComponentGroup()` /
  `render()`; renders `templates/dsfr-comp-*.html.twig`.
- **`Markup`** — generic tag builders (`markup`/`item`, `m_a`, `m_button`, `m_div`, `m_hr`,
  `m_img`, `m_p`).
- **`PseudoComponents`** — documentation/code helpers (`c_code`, `c_error`, `c_info`, `c_hl`,
  `c_warning`, `braces`, `chevron(s)`, `code_twig`, `comment_twig`, `var_twig`) + the
  `cIncorrect()` error fallback.
- **`ExternalTools`** — plain utility functions (`ati`/`atix`/`atx`, `not_empty_merge`,
  `convert_bytes`, `get_media_info`, `limit_string`, `uniq_id`, `calc_image_ratio`).
- **`InternalTools`** — internal helpers used by the components (attribute/class handling,
  href building, translation, pattern/size/type/color/icon setters). Not exposed to Twig.
- **`Resources`** — static catalog of DSFR version, colors, operational-component list, and the
  full **icon / pictogram** tables; `iconsJson()` / `pictogramsJson()` write JSON files.

## Routes / UI

- `dsfr_twig_components.demo` — `/dsfr/twig/{slug}` (default slug `''`),
  `_controller: TutorialsController::index`, **`_permission: 'access administration pages'`**.
  Menu link `dsfr_twig_components.demo` under `dsfr_core.settings`.
- `TutorialsController` builds the demo page (`#theme '_tutorials'`) and embeds
  `FilterFunctionsForm` (an AJAX keyword filter over `Resources::functionsReady()`).

## Other providers

- `hook_theme()` (`.module`) — theme hooks `_tutorials` and `dsfr_comp_<component>` for each
  component listed there (templates in `templates/`).
- `hook_requirements()` (`.install`) — INFO-level note suggesting the PHP **Intl** extension.
- Libraries (`.libraries.yml`) — `code_css` / `code_ajax` / `code` (Prism syntax highlight +
  copy button, assets in `dist/`) and `twig_components` (CSS).

## Solution docs

- Twig extension + every function each class exposes → [api/twig-functions.md](api/twig-functions.md)
- Icon/pictogram catalog + JSON generation (`Resources`) → [api/resources.md](api/resources.md)
- Demo page: controller, route, filter form → [api/tutorials-page.md](api/tutorials-page.md)
