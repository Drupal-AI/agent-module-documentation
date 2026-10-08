<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `notification_provider` plugin type

The single extension point of the core module. A provider knows how to list, load and (optionally)
mark-read notifications for a user, wherever they are stored.

## Pieces
- Manager: `NotificationProviderPluginManager` (service `plugin.manager.notification_provider`),
  discovery dir `Plugin/NotificationProvider`, interface `NotificationProviderInterface`,
  annotation `Drupal\notification_system\Annotation\NotificationProvider`, cache key
  `notification_provider_plugins`, alter hook `notification_provider_info`.
- Base class: `NotificationProviderPluginBase` (supplies `label()` and `id()` from the annotation).
- Annotation fields: `id`, `title`, `description`.

## Interface (`NotificationProviderInterface`)
- `label()` / `id()` — from the annotation.
- `getTypes(): string[]` — the notification *type* keys this provider emits (used by the
  type→group mapping form and by `NotificationSystem::getTypes()`).
- `getNotifications(AccountInterface $user, $includeReadNotifications = FALSE): NotificationInterface[]`
  — list notifications for `$user`. **A provider is responsible for scoping its own query to the
  passed `$user`.**
- `markAsRead(AccountInterface $user, string $notificationId): bool|string` — mark read; return
  `TRUE` on success or a string error message. A provider that has no read concept can return an
  error string.
- `load($notificationId): NotificationInterface|bool` — load one notification model by its
  provider-specific id, or `FALSE`.

## Writing one
```php
/**
 * @NotificationProvider(
 *   id = "my_provider",
 *   title = @Translation("My provider"),
 *   description = @Translation("Notifications from my source.")
 * )
 */
class MyProvider extends NotificationProviderPluginBase implements NotificationProviderInterface {
  public function getTypes() { return ['my_event']; }
  public function getNotifications(AccountInterface $user, $includeReadNotifications = FALSE) {
    // Build model/Notification objects scoped to $user->id().
  }
  public function markAsRead(AccountInterface $user, string $notificationId) { return TRUE; }
  public function load($notificationId) { return FALSE; }
}
```
Return `model\Notification` value objects (see [../api/notification-service.md](../api/notification-service.md)).
Implement `model\ReadableNotificationInterface` on your model if items are dismissable — the block
and service use `isReadBy($uid)` to sort/filter read items.

## How the service uses providers
`NotificationSystem::getProviders()` instantiates every plugin definition (catching
`PluginException` and surfacing it via messenger). `getNotifications()` merges each provider's list,
`usort`s by priority DESC then timestamp DESC, moves read items to the end when read items are
included, and optionally bundles by group. `markAsRead()` and `loadNotification()` create the named
provider instance and delegate.

## Nested provider type in the database submodule
`notification_system_database` defines a *second*, finer plugin type — `db_notification_provider`
(`Plugin/DbNotificationProvider`, manager `plugin.manager.db_notification_provider`) — whose only
job is to advertise notification *types* for stored entities. The single core `database` provider
aggregates all `db_notification_provider::getTypes()`. See the database submodule docs.
