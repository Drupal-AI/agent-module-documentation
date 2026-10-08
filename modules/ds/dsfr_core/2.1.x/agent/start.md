<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Core (dsfr_core) — agent index

Base module of the **DSFR** (Systeme de Design de l'Etat / French State Design System) suite. It
renders no front-end components itself; it provides **shared services, admin pages, and
field/text-format tooling** that the sibling DSFR modules (dsfr_block, dsfr_menu, dsfr_paragraph,
dsfr_twig_components) and the DSFR theme build on. Package `DSFR`. Core `^10 || ^11`. License
GPL-2.0-or-later.

> This on-disk copy is a **Git dev checkout** of the `2.1.x` branch — `dsfr_core.info.yml` has no
> `version:` and no `composer.json` ships. Treat version as `2.1.x` (dev).

## Dependencies (info.yml)
- `dsfr_twig_components`, `form_options_attributes`, `style_selector` (all Drupal modules).
- Expects the separate **DSFR theme** (drupal.org/project/dsfr) to be present; most pages degrade
  to a "theme missing" message otherwise. No `composer.json` → no external composer/library deps.

## What it provides
- **4 services** (`dsfr_core.services.yml`): `dsfr_core.tools` (`Tools`), `dsfr_core.fieldStorage`
  (`FieldStorage`), `dsfr_core.fieldManage` (`FieldManage`), `dsfr_core.filterEditor`
  (`FilterEditor`).
- **1 permission** (`dsfr_core.permissions.yml`): `administer dsfr_core settings`.
- **10 routes** (`dsfr_core.routing.yml`) across 4 controllers + 1 form — admin settings/theme/
  get-started/fields pages, icon & pictogram browsers, and two JSON-generate endpoints.
- **Menu links** under Structure (`dsfr_core.links.menu.yml`): DSFR → Settings/Theme/Icons/
  Pictograms.
- **4 theme hooks** (`hook_theme`): `dsfr_settings`, `dsfr_get_started`, `_icons`, `_pictograms`
  (templates in `templates/`).
- **3 asset libraries** (`dsfr_core.libraries.yml`): `dsfr_color_selector`, `preact_icons`,
  `preact_pictograms` — the last two load a bundled **Preact** picker app (`dist/js/*.min.js`,
  sources in `src/preact/**`).
- **Install hook + form_alter** (`dsfr_core.module`): relaxes image `alt_field_required`, creates
  the `restricted_html_dsfr` text format, attaches the colour-selector library to all forms.
- No config schema (no `config/` dir), no Drush commands, no plugin types, no submodules.

## Solution docs
- **Admin pages & routes** (settings, theme redirect, get-started, fields report) →
  [config/admin-pages.md](config/admin-pages.md)
- **Icon & pictogram browsers + JSON generators + Preact app + JSON data** →
  [browser/icons-pictograms.md](browser/icons-pictograms.md)
- **Field/text-format tooling** (`FieldStorage`, `FieldManage`, `FilterEditor`, `TestForm`) →
  [fields/field-tooling.md](fields/field-tooling.md)
- **Services, the `Tools` helper API, hooks & install** →
  [api/services-hooks.md](api/services-hooks.md)
