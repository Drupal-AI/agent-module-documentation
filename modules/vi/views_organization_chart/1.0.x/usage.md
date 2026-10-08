<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Organization Chart renders a view's results as an organization chart — boxes joined by lines showing reporting or hierarchical relationships — instead of as a list or table, using the Highcharts organization chart type.

---

Staff directories, committee structures and departmental hierarchies are stored as entities with a parent reference, and Views will happily list them; what a list cannot do is show the shape. This module supplies that shape as a Views style plugin, so content, filtering and sorting stay ordinary Views concerns and only the rendering changes: a view already listing staff switches to a chart with one Format setting and back again. You add two fields to the display — a name field for each node's label and an entity-reference parent field that supplies the hierarchy edges — and optionally a title/subtitle field, an avatar image field (run through the core thumbnail image style), and a comma-separated list of per-level colors. It works with any entity a view can list: taxonomy terms via their parent field, users via a manager reference, or nodes via a content reference. The Highcharts runtime is loaded from the code.highcharts.com CDN at page load, so the chart needs outbound access to that host, and there is no settings page — everything is configured per display in the Views UI. It depends functionally on core Views and runs on Drupal 9 through 12.

---

- Show a staff structure as a chart.
- Visualise a departmental hierarchy.
- Display a committee structure.
- Show reporting lines between employees.
- Render a taxonomy term hierarchy visually.
- Build an org chart from node content.
- Show a team's structure on an intranet.
- Switch a staff listing view to a chart.
- Present a board and its committees.
- Show a service or product hierarchy.
- Visualise a category tree.
- Present a project or work-breakdown structure.
- Filter a chart with ordinary Views filters.
- Show one department's branch of the tree.
- Build a directory with visual structure.
- Present a governance structure.
- Add avatar photos to each chart node.
- Colour each hierarchy level differently.
- Render an org chart without writing custom code.
- Show a manager-to-report tree from a user reference field.
