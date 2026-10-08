Config Log Views exposes the `config_log` database table to Views and ships a ready-made report of configuration changes at `/admin/reports/config-log`, complete with a From/To diff of each change.

---

This submodule of Configuration Log adds `hook_views_data()` that registers the `config_log` base table with Views, providing field/sort/filter/argument handlers for every column (`clid`, `uid` with a relationship to the user table, `created` as a date, `data`, `originaldata`, `name`, `old_name`) plus a virtual `diff_field`. That diff field is a custom Views field plugin, `config_log_diff` (class `ConfigLogDiff`), which reconstructs a line-by-line diff of the stored original vs new YAML using core's `DiffFormatter`, honouring the `leading_context_lines` / `trailing_context_lines` settings from `config_log.settings`, and collapsing long diffs into a `details` element. A `hook_views_pre_render()` attaches the core `system/diff` CSS library so the diff renders with the standard From/To styling. The module installs one default view, `views.view.config_log`, whose Page display serves `admin/reports/config-log` (menu item "Config Log" under Reports). Because the whole feature is a normal view, you can clone it, add exposed filters (e.g. by user or config name), or embed it in a block. Its `configure` link points back at the parent module's settings form (`config_log.admin`).

---

- Give administrators a browsable *Reports → Config Log* screen of every configuration change.
- Show an inline From/To diff for each change without writing any code.
- Filter the config change log by configuration name (e.g. only `views.*` or `field.*`).
- Filter or argument the log by the acting user via the built-in relationship to the users table.
- Sort configuration changes by date to see the most recent edits first.
- Expose a date filter to review config activity within a specific window.
- Add an exposed "Operation" filter to see only deletes or only renames.
- Clone the shipped `config_log` view to build a custom compliance/audit report.
- Embed a "recent configuration changes" block on an admin dashboard using the view.
- Control how many unchanged context lines surround each diff via `config_log.settings`.
- Collapse very long diffs behind an expandable "Text too long to display" details element.
- Provide a non-developer-friendly UI over the raw `config_log` table.
- Export the log as CSV/JSON by adding a data export display to the view.
- Page through large volumes of config-change history with a standard Views pager.
- Restrict the report to specific config names by adding a contextual filter.
- Build a per-user "what did this admin change" report using the uid relationship.
- Surface renames (old vs new config name) using the `old_name` field.
- Reuse the `config_log_diff` field handler in your own custom view of the table.
- Audit a deployment window by filtering the log by `created` timestamp range.
