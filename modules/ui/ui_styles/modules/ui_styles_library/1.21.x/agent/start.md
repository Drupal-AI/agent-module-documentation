<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Library — agent index

Adds a read-only **Styles library** styleguide page listing every declared UI Styles style and
option with live previews. No stored config; its state is the route + a permission.

- **Route, permission, controller, and theme hook** →
  [configure/styles-library.md](configure/styles-library.md)

Key facts:
- Page: `/admin/appearance/ui/styles` (route `ui_styles_library.overview`,
  `StylesLibraryController::overview`).
- Permission: **`access_ui_styles_library`** (provided by this module).
- Renders `getGroupedDefinitions()` via theme hook `ui_styles_overview_page`
  (`ui-styles-overview-page.html.twig`), using the stylesheet generator for previews.
- Menu parent: `ui_suite.index` (*Appearance → UI libraries*, `/admin/appearance/ui`).
