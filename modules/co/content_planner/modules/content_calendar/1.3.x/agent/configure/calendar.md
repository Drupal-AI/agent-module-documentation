# Content Calendar configuration

## Routes (`CalendarController`)

- `content_calendar.calendar` — `/admin/content-calendar/{year}` (view; `view content calendar`).
- `content_calendar.current` — `/admin/content-calendar/show-current-year`.
- `content_calendar.calendar_redirect` — `/admin/content-calendar/redirect/{year}/{month}`.
- `content_calendar.settings` — `/admin/content-calendar/settings` (SettingsForm;
  `administer content calendar settings`). This is the `configure` route.
- `content_calendar.upate_node_publish_date` (sic) —
  `/admin/content-calendar/update-node-publish-date/{node}/{date}` (date `YYYY-MM-DD`);
  JSON endpoint that rewrites the node's `created` (and Scheduler `publish_on` when set).
- `content_calendar.duplicate_node` — `/node/{node}/duplicate`; clones the node, appends
  " clone" to the title, saves, redirects.

## `content_calendar.settings` config object

```
show_user_thumb: false                 # show author picture on entries
bg_color_unpublished_content: ''       # CSS colour for unpublished nodes
add_content_set_schedule_date: false   # prefill Scheduler publish_on for calendar-created nodes
```

Schema in `config/schema/config_type_config.schema.yml`.

## `content_type_config` config entity

Selects which content types show on the calendar and their colour. Config entity type
`content_type_config` (`ConfigEntityBase`), `config_prefix: content_type_config`,
`admin_permission: administer site configuration`. Exported keys: `id`, `label`, `color`.
CRUD UI under `/admin/content-calendar/content-type-config` (add/edit/delete). Service
`content_calendar.content_type_config_service` (`loadAllEntities()` etc.). If none are
configured the calendar shows a "not configured yet" message.

## Scheduler integration

`SchedulerPublishSubscriber` (event subscriber) and `content_calendar_form_node_form_alter`
wire calendar-created nodes to the Scheduler module's `publish_on` field. Requires the
`scheduler` module (a dependency of the parent `content_planner`).
