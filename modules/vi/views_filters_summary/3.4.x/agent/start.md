<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Exposed Filters Summary — agent index

Provides a Views **area handler** `views_filters_summary` that prints a summary of the currently
applied exposed filters (with optional remove/reset links) in a view's Header, Footer, or Empty
area. No config route, no permissions — it is configured per view display. Depends on `views`.

- **Add & configure the area: all handler options, the `content` tokens, drush/config shape** →
  [configure/area.md](configure/area.md)
- **Extend it: the alter hooks it invokes (`hook_views_filters_summary_*`) and how submodules use them** →
  [api/hooks.md](api/hooks.md)
- **Theme it: templates, variables, JS/CSS library** →
  [theming/templates.md](theming/templates.md)

Key facts: area plugin id `views_filters_summary` (class `ViewsFiltersSummary` extends views
`Result`), registered via `hook_views_data`. Config lives inside the view under
`display_options.{header|footer|empty}.views_filters_summary` (schema `views.area.views_filters_summary`).
Content tokens: `@total`, `@result_label`, `@exposed_filter_summary`. 11 optional submodules add
support for other filter-providing modules via the alter hooks. This module ships no `configure`
route and no permissions.
