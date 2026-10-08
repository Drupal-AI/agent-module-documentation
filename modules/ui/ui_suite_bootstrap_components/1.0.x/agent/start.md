<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite Bootstrap components (ui_suite_bootstrap_components) — agent index

**Opinionated Bootstrap 5 Single-Directory Components (card, hero, features, comment) plus an Icon API pack for the UI Suite / UI Patterns ecosystem.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10 || ^11 || ^12
- **Package:** UI Suite
- **Components:** `components/{card,hero,features,comment}/*.component.yml` + `*.twig`; hero ships `stories/*.story.yml`. Props use `ui-patterns://attributes` refs; slots image/header/content/footer.
- **Icons:** `ui_suite_bootstrap_components.icons.yml` (Icon API).
- **No** PHP, routes, services, permissions or config forms — pure presentational SDC.
- **Use:** via UI Patterns/UI Suite/Layout Builder, or `{{ include('ui_suite_bootstrap_components:card') }}`.

**Security:** presentation-only module with no server-side code, routes or endpoints; nothing to gate. Rendering safety is governed by the consuming theme/UI Patterns and standard Twig autoescaping. No security findings.

See [extend/components.md](extend/components.md).
