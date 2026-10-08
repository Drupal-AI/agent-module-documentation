<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Display Switch — agent index

A single Views **area handler** (`display_switch`) that renders links to switch between a
view's page/block displays while keeping exposed filters, pager and contextual filters.
No global config (`configure` null), no permissions, no Drush. Depends on core `views`.

- **Add & configure the Display switch area, `?mode=` block switching, theming** →
  [configure/area.md](configure/area.md)

Key facts:
- Plugin: `@ViewsArea("display_switch")` → `Drupal\views_display_switch\Plugin\views\area\DisplaySwitch`.
- Eligible displays = **page (path-based)** or **block** displays only; others are filtered out.
- Page display → links to the display's path; block display → links to current path with
  `?mode=<display_id>`. `hook_views_pre_view()` applies the `mode` param to switch display.
- Options stored on the area handler: `displays[<id>][enabled]` (checkbox) + `displays[<id>][label]`.
- Theme hook `views_display_switch` + template `views-display-switch.html.twig` (`links` variable).
- Mismatched filter/sort/pager/contextual-filter settings between displays produce a *warning*,
  not an error. Assumes one view per page.
