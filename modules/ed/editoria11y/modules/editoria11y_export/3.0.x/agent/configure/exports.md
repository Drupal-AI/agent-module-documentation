# Export Views

The submodule installs a View (`config/optional/views.view.ed11y_export.yml`, plus related
displays) with a Views Data Export display, providing CSV export of Editoria11y dashboard data
(pages with issues, recent results, dismissals). Export links appear on the dashboard at
`/admin/reports/editoria11y` after install and a cache clear.

Customizing:
- Edit the Views at `/admin/structure/views` to add filters/fields.
- **Always edit the Page display and the Data Export display together** so the export matches
  the on-screen report.
- Export your config after changes — module updates may reset the default Views to their
  shipped defaults.

There is no dedicated settings form; all configuration is done through the Views UI. Access
follows the underlying Editoria11y dashboard permission (`manage editoria11y results`).
