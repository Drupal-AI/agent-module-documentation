<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dispatch pipeline, user settings, and site settings

## Pipeline
1. **Event** — `NotificationSystemDispatchSubscriber::onNewNotification(NewNotificationEvent)`
   (subscribes to `notification_system_new_notification`). For each `getUsers()` audience uid:
   - if forced-dispatch is configured **and** the notification `isForced()`, **or** the user's
     send mode is `SEND_MODE_IMMEDIATELY` → `NotificationDispatcherService::queue([$notification], $uid)`.
   - else append `{provider, notification_id}` to that user's `notification_dispatch_bundle`
     (create if none; query uses `accessCheck(FALSE)` to find the user's existing bundle).
2. **Bundle flush (cron)** — `notification_system_dispatch_cron()` loads every
   `notification_dispatch_bundle`; if the owner's send mode is now immediate, or daily/weekly and the
   last dispatch is older than 24h/7d, it resolves each `notification_reference` to a model,
   `queue()`s them, deletes the bundle, and records `setLastDispatchTimestamp()`.
3. **Queue** — `NotificationDispatcherService::queue(array $notifications, $userId)`:
   - if the state whitelist is enabled and the user is not on it → return (drop).
   - forced bypass: if `forced_dispatcher` set and `$notifications[0]->isForced()`, create one queue
     item straight to that dispatcher (no bundling of forced items).
   - for every dispatcher: skip if the user disabled it (`UserSettingsService::dispatcherEnabled`);
     per notification, skip if the user declined that dispatcher+group
     (`dispatcherGroupEnabled`, using `notification_system.settings:group_mappings` to map type→group);
     create a queue item `{user, dispatcher, notifications:[{provider, notification_id}]}` when at
     least one notification remains.
4. **Worker** — `Plugin/QueueWorker/DispatchQueue` (`cron = 30s`): reloads each notification via
   `notification_system->loadNotification($provider, $id)`, instantiates the dispatcher, loads the
   user, and calls `dispatch($user, $notifications)`. (No explicit failure/retry handling — a
   `@todo`.)

## `notification_dispatch_bundle` entity
`@ContentEntityType` id `notification_dispatch_bundle`, base table same, `uid = user_id`,
published trait. Field `notifications` = `notification_reference` (unlimited). Access handler
`NotificationDispatchBundleAccessControlHandler` — all ops require
`administer notification dispatch bundle entities`. It is an internal accumulator, not a
user-facing entity.

## `UserSettingsService` (`user.data`, module key `notification_system_dispatcher`)
- `dispatcherEnabled($dispatcherId, $userId=NULL)` — per-channel on/off; default from config
  `default_enabled_dispatchers` when unset.
- `dispatcherGroupEnabled($dispatcherId=NULL, $groupId=NULL, $userId=NULL)` — per-channel/per-group
  matrix (`dispatch_groups_enabled`), defaulting to opt-in.
- `getSendMode()/setSendMode()` — 1–3, validated; default from config `send_mode`.
- `getLastDispatchTimestamp()/setLastDispatchTimestamp()`.
- All methods default `$userId` to the **current user** when omitted.

## `UserSettingsForm` + block
`Form/UserSettingsForm` (id `notification_system_dispatch_usersettings`) renders a checkbox per
dispatcher and per group, plus a send-mode select when `enable_bundling` is on; every change fires
the `::autosave` AJAX callback which writes straight to `UserSettingsService` for the current user.
`Plugin/Block/UserSettingsBlock` embeds that form and is shown to **authenticated users only**
(`blockAccess`: `!isAnonymous()`).

## Site settings (`SettingsForm` → `notification_system_dispatch.settings`)
- `send_mode` (default), `enable_bundling`, `default_enabled_dispatchers` (checkboxes),
  `forced_dispatcher` (select incl. "- Disabled -").
- Whitelist lives in **state**: `notification_system_dispatch.enable_whitelist` +
  `notification_system_dispatch.whitelist` (array of uids) — a testing gate, not exported config.
- Route `/admin/config/system/notification-system-dispatch`, permission
  `administer notification_system_dispatch configuration`.
