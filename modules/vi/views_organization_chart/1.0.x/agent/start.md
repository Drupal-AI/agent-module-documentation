<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_organization_chart — agent index

Views **style plugin** that renders a view's rows as an organization chart (a top-down
hierarchy tree of boxes joined by reporting lines) using the Highcharts `organization`
chart type. You point the style at two view fields — a **name** field and an
entity-reference **parent** field — and it draws each row as a node linked to its parent.
Works with any entity that a view can list (users, taxonomy terms, nodes) as long as the
display exposes a self-referencing parent field. Optional title, avatar image and per-level
colors.

- Depends (functionally) on core **views**. Core: `^9 || ^10 || ^11 || ^12`. GPL-2.0-or-later.
- **No settings page, no routes, no permissions, no drush, no hooks for integrators.**
  Configured entirely in the Views UI: set a display's Format to "Organization chart".
- Loads Highcharts (5 scripts) from the `code.highcharts.com` CDN — see theme/rendering.md.

Solution docs:
- **Configure a view to render as an org chart (which fields, colors)** → [views/style.md](views/style.md)
- **How rows become chart nodes/edges; template, library, CDN assets, drupalSettings** → [theme/rendering.md](theme/rendering.md)

Key facts:
- Style plugin id `views_organization_chart` — class `Drupal\views_organization_chart\Plugin\views\style\ViewsOrganizationChart` extends `StylePluginBase`; theme `views_style_views_organization_chart`.
- Style options: `name_field` (required), `parent_field` (required; only `entity_reference_label` fields offered), `title_field`, `image_field` (only `image` fields offered), `levels_color` (default `silver,#980104,#359154`).
- Preprocess `template_preprocess_views_style_views_organization_chart()` in `views_organization_chart.module` builds the node/edge arrays and attaches them as drupalSettings.
- Template `templates/views-style-views-organization-chart.html.twig`.
- Asset library `views_organization_chart/views_organization_chart`.
- Config schema `views.style.views_organization_chart` (declares key `wrapper_class`).
- Chart DOM element id and drupalSettings key: `{view_id}-{display_id}` (e.g. `staff-page_1`).
