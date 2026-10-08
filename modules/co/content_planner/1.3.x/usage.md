Content Planner gives editorial teams a Drupal admin Dashboard plus two companion tools — a Content Calendar and a Content Kanban board — for planning, scheduling and tracking content through its moderation workflow.

---

The base module provides a configurable **Dashboard** at `/admin/content-planner/dashboard` built from pluggable "dashboard block" widgets (`DashboardBlock` plugin type). Shipped widgets include a User widget (editors + their moderation stats), up to ten Views widgets (embed any View by `view_id.display_id`), and three Text/HTML widgets (free `full_html` content via `check_markup`). Widgets are ordered, titled, per-role-restricted and configured on the Dashboard settings page (`administer content planner dashboard settings`); the settings live in the `content_planner.dashboard_settings` config object as a `blocks` array. The module depends on core `image`, core `content_moderation` and contrib `scheduler`, and on install it also enables both submodules. A toolbar item links to the dashboard. It defines two permissions (`view content planner dashboard`, `administer content planner dashboard settings`) and a `DashboardService`/`DashboardSettingsService` pair for reading state. The Calendar and Kanban submodules add their own routes, permissions and, for Kanban, a `content_kanban_log` entity that records every moderation-state change. Content is planned against Content Moderation workflows, so a valid moderation workflow with at least one enabled entity type is a prerequisite for the boards to show anything.

---

- Give editors a single planning dashboard aggregating widgets, calendar and kanban.
- Embed any existing View (e.g. "unpublished articles") as a dashboard widget.
- Show a team roster widget with each editor's content-moderation statistics.
- Add free-form Text/HTML notes or announcements to the dashboard.
- Restrict individual dashboard widgets to specific user roles.
- Reorder and retitle dashboard widgets to suit an editorial team.
- Add a "Content Planner" toolbar shortcut for quick access.
- Plan a year of content visually on a month-by-month calendar.
- Drag a node in the calendar to change its scheduled/publish date.
- Colour-code calendar entries by content type.
- Duplicate an existing node directly from the calendar to reuse it as a template.
- Automatically set a Scheduler publish date when creating content from the calendar.
- Show author profile thumbnails on calendar entries.
- Visualise nodes as cards on a Kanban board grouped by moderation state.
- Move a card between Kanban columns to transition its moderation state (respecting transition permissions).
- Filter the Kanban board by workflow, content type or user.
- Log and review every moderation-state change as `content_kanban_log` entities.
- Report on how much content sits in each workflow state.
- Limit which content types appear in the calendar and kanban via Content Type Config.
- Give reviewers a read-only overview of the editorial pipeline.
- Surface recently published / upcoming content on the dashboard.
- Coordinate a marketing team around scheduled publication dates.
- Track editorial throughput over a configurable date range.
- Provide role-scoped dashboards (e.g. writers vs editors) via per-widget role settings.
