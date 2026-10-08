# Hooks — how notifications get logged

Implemented in `notifications_widget.module`. The three entity hooks are the automatic logging path;
the service (`notifications_widget.logger`) is the manual path (see [../api/service.md](../api/service.md)).

## Entity CRUD → notification

`hook_entity_insert`, `hook_entity_update`, `hook_entity_delete` all follow the same pattern for the
saved/deleted entity's bundle:

1. Read `notifications_widget.settings`.
2. `{bundle}_enable` CSV must contain the matching verb — `Create` (insert), `Update` (update),
   `Delete` (delete) — otherwise nothing is logged.
3. Build `$message` from `{bundle}_noti_{create|update|delete}_message` (content) and
   `{bundle}_redirect_{create|update|delete}_link` (content_link), with `id` and `bundle` from the
   entity, then call `logNotification($message, '<verb>', $entity)`.

So enabling notifications for a bundle is purely a matter of the config keys in
[../configure/settings.md](../configure/settings.md); no code change is needed for the built-in
supported types. Only `user`, `node`, `taxonomy_term`, `comment` are actually persisted (the service
guards on those); other content entity types are filtered out inside the service.

## Other hooks

| Hook | Purpose |
|---|---|
| `hook_help` | Help text on `help.page.notifications_widget`. |
| `hook_page_top` | On admin routes, if `notfication_widget_conf` is unset and the user has `administer site configuration`, shows the "save the settings once" nag (skipped on update/status pages). |
| `hook_theme` | Declares the `notifications_widget` theme hook (variables `uid`, `notification_type`, `total`, `unread`, `notification_list`). |
| `hook_views_data` | Adds the `notifications` base table + relationships/fields — see [../views/notifications.md](../views/notifications.md). |
