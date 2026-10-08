<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Container Queries Responsive Images (cqri) — agent index

Extends Core Responsive Image so an image field selects its source from the size of its **container** (DOM element) rather than the **viewport**. Version `1.0.0-alpha2`, core `^10 || ^11`, package Media.

## Depends on
- Core module `responsive_image` (declared in `cqri.info.yml`); pulls in Core `breakpoint`, `image`.
- Composer: `npm-asset/container-picture-element` `^0.1.0` — the `container-picture-element` JS library, expected at `/libraries/container-picture-element/dist/container-picture.global.js` (loaded as an ES module via `cqri.libraries.yml`).

## What it provides
- **Field formatter** `container_queries_responsive_image` (label "Container queries responsive image"), for `image` fields — class `ContainerQueriesResponsiveImageFormatter` extends Core's `ResponsiveImageFormatter`. Only lists responsive image styles whose `breakpoint_group == 'cqri'`.
- **Breakpoint group** `cqri` with one breakpoint `cqri.cqri` (`cqri.breakpoints.yml`), empty `mediaQuery`, multiplier `1x`.
- **Library** `cqri/cqri` (`cqri.libraries.yml`) — the container-picture ES module, attached at render time.
- **Themes** `cqri_formatter` and `cqri_item` (`hook_theme()` in `cqri.module`), templates `templates/cqri-formatter.html.twig` (emits `.cqri-container` with `container-type: inline-size`) and `templates/cqri-item.html.twig` (emits `<container-picture>` with `<source container="…">`).
- **Preprocess handlers** (service-resolved via `class_resolver`): `HookHandler\PreprocessCqriFormatter` (swaps the responsive_image theme for `cqri_item`, attaches the library) and `HookHandler\PreprocessCqriItem` (builds `<source>` attributes, replacing `media`/`srcset`/`sizes` with a per-source `container` attribute).
- **Config schema** `field.formatter.settings.container_queries_responsive_image` (inherits Core's `field.formatter.settings.responsive_image`).
- **Example config** `config/install/responsive_image.styles.container_query.yml` — a ready-made `container_query` responsive image style on the `cqri` group.

## No routes, permissions, services.yml, drush commands, or settings form.

## Solution docs
- [agent/fields/formatter.md](fields/formatter.md) — install, enable the formatter on a field, the `cqri` breakpoint group, the `container_query` example style, rendering pipeline, and the JS library requirement.
