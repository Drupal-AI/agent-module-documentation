# Content Planner Calendar — agent index

A Content Planner submodule: a year calendar of nodes at `/admin/content-calendar/{year}`.
Depends on `content_planner`. Integrates with Scheduler (`publish_on`). `configure` route:
`content_calendar.settings`.

- **Settings, the `content_type_config` entity, routes, calendar endpoints** →
  [configure/calendar.md](configure/calendar.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `content_calendar.settings`: `show_user_thumb` (bool),
  `bg_color_unpublished_content` (string), `add_content_set_schedule_date` (bool).
- Config entity `content_type_config.*` (`{id,label,color}`) selects + colours the content
  types shown; managed under `/admin/content-calendar/content-type-config`
  (admin_permission `administer site configuration`).
- Reschedule endpoint `content_calendar.upate_node_publish_date`
  (`/admin/content-calendar/update-node-publish-date/{node}/{date}`) rewrites the node `created`
  and Scheduler `publish_on`; duplicate endpoint `content_calendar.duplicate_node`
  (`/node/{node}/duplicate`).
- Four permissions, all `restrict access: true`: `view content calendar`,
  `manage content calendar`, `manage own content calendar`, `administer content calendar settings`.
