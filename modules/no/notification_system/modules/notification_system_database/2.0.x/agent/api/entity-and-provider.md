<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `notification` entity, read tracking, cron, and the `database` provider

## Entity `notification` (`src/Entity/Notification.php`)
`@ContentEntityType` id `notification`, base table `notification`, data table
`notification_field_data`, `translatable = TRUE`, `admin_permission = "administer notification"`,
`field_ui_base_route = entity.notification.settings`. Route provider `AdminHtmlRouteProvider`;
forms add/edit = `NotificationForm`, delete = core `ContentEntityDeleteForm`; list builder
`NotificationListBuilder`; views_data via `EntityViewsData`.

Base fields (`baseFieldDefinitions`):
- `user_id` — entity_reference → user, **cardinality unlimited, required** (the audience).
- `provider_id` — string, required (id of the *db* notification provider that created it).
- `notification_type` — string, required (the type key used for group mapping).
- `created` — created timestamp.
- `title` — string, required, translatable (`label`).
- `body` — string_long, optional, translatable (view type `basic_string`).
- `link` — link field (generic, no title).
- `sticky` — boolean (default FALSE) — if TRUE cannot be marked read.
- `priority` — list_integer with allowed values 1–5 (default 3 = medium).
- `forced` — boolean (default FALSE) — dispatch bypasses user settings.
- `expires` — datetime, optional.

`preSave()` truncates the title to 255 chars. `toNotificationModel()` builds a
`model/DatabaseNotification` (provider `database`, id = entity id, type, created ts, title, sticky,
priority, forced; sets body + link if present; `setEntityId()`).

`postSave()` — **on insert only** — dispatches `NewNotificationEvent` and invalidates
`notification_system:read:{uid}` for each audience user. `postDelete()` deletes the entity's rows
in `notification_system_database_read`.

## Read tracking (`notification_system_database_read`)
Schema (`.install`): `id` serial, `uid` int, `entity_id` int, `timestamp` int, index
`uid__entity_id (uid, entity_id)`. "Read" is a `(uid, entity_id)` row — per recipient, not on the
entity. `DatabaseNotification::isReadBy($uid)` does a `countQuery()` on that table (cached per uid).

## Provider `database` (`src/Plugin/NotificationProvider/DatabaseNotificationProvider.php`)
`@NotificationProvider(id="database")`. Injects `entity_type.manager` +
`plugin.manager.db_notification_provider`.
- `getNotifications(AccountInterface $user, $includeReadNotifications = FALSE)` — entity query
  `condition('user_id', $user->id())` with `accessCheck(TRUE)`, load, convert to models, and
  (unless `$includeReadNotifications`) drop those `isReadBy($user->id())`. **Scoped to the passed
  user's audience.**
- `markAsRead(AccountInterface $user, string $notificationId)` — load by id; return an error
  string if not found, if `$user` is **not in the notification's `user_id` audience**
  ("This notification is of another user."), or if it is sticky; otherwise insert a read row (once)
  and return TRUE.
- `getTypes()` — union of every `db_notification_provider` plugin's `getTypes()`.
- `load($notificationId)` — load entity → model, or FALSE.

## Nested `db_notification_provider` plugin type
Discovery `Plugin/DbNotificationProvider`; interface `DbNotificationProviderInterface`
(`label()`, `id()`, `getTypes()`); base `DbNotificationProviderPluginBase`; annotation
`@DbNotificationProvider(id,title,description)`; manager `plugin.manager.db_notification_provider`;
alter `db_notification_provider_info`. Implement one to advertise the `notification_type` strings
your stored notifications use, so they appear in the type→group mapping form.

## Cron (`notification_system_database_cron`)
1. Delete notifications whose `expires < now` (`accessCheck(FALSE)`).
2. If `read_purge_days` > 0: for each read row older than the window, remove that uid from the
   notification's `user_id` audience and delete the read row.
3. Delete notifications with **no** `user_id` audience left.
User delete hook removes the user from `notification__user_id` and their `_read` rows.
