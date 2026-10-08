<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NotificationSystem service, Notification model, and the new-notification event

## Service `notification_system` (`src/Service/NotificationSystem.php`)
Constructor args: `entity_type.manager`, `plugin.manager.notification_provider`, `config.factory`,
`messenger`.

- `getProviders(): NotificationProviderInterface[]` — instantiate every provider plugin.
- `getNotifications(AccountInterface $user, $bundled = FALSE, $includeReadNotifications = FALSE)`
  — merge all providers' `getNotifications($user, …)`, sort by **priority DESC, then timestamp
  DESC**; if read items are included, `ReadableNotificationInterface` items already read by
  `$user` are moved to the end; if `$bundled`, returns an array keyed by group id (ungrouped under
  `'NONE'`).
- `getTypes(): string[]` — unique, sorted union of every provider's `getTypes()`.
- `markAsRead(AccountInterface $user, string $providerId, string $notificationId): bool|string`
  — create the named provider and call its `markAsRead($user, $notificationId)`; returns the
  provider's boolean/error, or the `PluginNotFoundException` message.
- `loadNotification($providerId, $notificationId)` — delegate to `provider->load()`; `FALSE` on
  plugin error.
- `bundleNotifications(array $notifications)` — group by type using
  `notification_system.settings:group_mappings`; unmapped/empty → `'NONE'`.
- `getTypeToGroupMappings()` (protected) — reads `group_mappings` config into `type => group_id`.

## Model `model/Notification` (`src/model/Notification.php`)
A plain value object implementing `model/NotificationInterface`. Constructor:
`__construct($provider, $id, $type, array $users, $timestamp, $title, $body = NULL, ?Url $link = NULL, $sticky = FALSE, $priority = PRIORITY_MEDIUM, $forced = FALSE)`.
Getters/setters for each property; `addUser()/removeUser()`. `$link` is a `\Drupal\Core\Url`.

Priority constants on `NotificationInterface`: `PRIORITY_LOWEST=1`, `PRIORITY_LOW=2`,
`PRIORITY_MEDIUM=3`, `PRIORITY_HIGH=4`, `PRIORITY_HIGHEST=5`.

- `sticky = TRUE` → cannot be marked read/dismissed.
- `forced = TRUE` → dispatch bypasses user channel settings (see dispatch submodule).
- `users` = audience (array of uids); a notification can target many users.

### `ReadableNotificationInterface` (`model/ReadableNotificationInterface.php`)
`isReadBy(int $user): bool`. Implement on a model when items can be marked read; the controller and
service use it to compute per-item `isRead` and to sort read items last.

The database submodule subclasses this as `model/DatabaseNotification` (adds `setEntityId()` /
`getEntityId()`, resolves `getUsers()` from the entity's `user_id` field, and caches `isReadBy()`
via the `notification_system_database_read` table).

## Event `Event/NewNotificationEvent`
`EVENT_NAME = 'notification_system_new_notification'`. Public property `$notification`
(a `NotificationInterface`). Dispatched by the database entity's `postSave()` on **insert only**
(not on update). The dispatch submodule subscribes to it to queue outbound delivery. If you write
your own provider/storage, dispatch this event yourself after persisting a notification so the
dispatch pipeline sees it.
