Content Calendar (a Content Planner submodule) renders a year-long, month-by-month calendar of nodes so editorial teams can plan and reschedule publication visually.

---

The calendar lives at `/admin/content-calendar/{year}` (plus a "current year" and month-jump redirect). Which content types appear, and their colour, is controlled by `content_type_config` **config entities** managed at `/admin/content-calendar/content-type-config` (admin permission `administer site configuration`). Global options live in the `content_calendar.settings` config object: `show_user_thumb`, `bg_color_unpublished_content`, and `add_content_set_schedule_date` (auto-fill a Scheduler publish date when adding content from the calendar). The `CalendarController` exposes JSON/redirect endpoints to drag a node to a new date (`updateNodePublishDate`, updates the node's `created` and, if set, Scheduler `publish_on`) and to duplicate a node (`duplicateNode`, `/node/{node}/duplicate`). A `SchedulerPublishSubscriber` and a `hook_form_node_form_alter` integrate with the Scheduler module so calendar-created content can be scheduled. Four permissions scope viewing vs managing (all `restrict access: true`). The submodule ships config schema for both the settings object and the `content_type_config` entity.

---

- Plan a whole year of publications on twelve month grids.
- Restrict the calendar to specific content types via Content Type Config entities.
- Colour-code each content type on the calendar for at-a-glance scanning.
- Drag a node card to a new day to change its creation/publish date.
- Auto-schedule (Scheduler `publish_on`) content created from the calendar.
- Highlight unpublished content with a configurable background colour.
- Show author profile thumbnails on calendar entries.
- Duplicate a node ("… clone") straight from the calendar to reuse it.
- Jump directly to a given month/year via the redirect routes.
- Give a marketing team a shared editorial publishing timeline.
- Coordinate content types (news, blog, events) on one calendar.
- Review what was published in past months of the year.
- Preview upcoming scheduled content for the rest of the year.
- Let editors reschedule campaigns by moving cards instead of editing nodes.
- Provide a read-only calendar to stakeholders (view-only permission).
- Configure per-type colours to distinguish evergreen vs timely content.
- Combine with Content Kanban for both timeline and workflow-board views.
- Set default scheduling behaviour for calendar-created nodes.
- Surface recently and soon-to-be published nodes in a summary.
- Use the calendar as the planning surface for a content-moderation workflow.
