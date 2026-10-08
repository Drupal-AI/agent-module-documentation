<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, access checks, controllers, forms & bulk action

All routes are in `notify_widget.routing.yml`. Two custom access checks (in
`notify_widget.services.yml`, tagged `access_check`) enforce that a user only ever reaches or acts
on their own notifications:

- **`_user_can_access_notifications`** → `NotificationPageAccessChecker`
  (`src/Access/NotificationPageAccessChecker.php`): allowed only if the `{user}` route entity id
  equals `current_user->id()`.
- **`_user_owns_notification`** → `UserOwnsNotificationAccessChecker`
  (`src/Access/UserOwnsNotificationAccessChecker.php`): allowed only if a row exists with
  `id = {notificationId}` **AND** `uid = current_user->id()` (ownership is checked against the
  logged-in user, not the `{user}` param).

## Route table

| Route | Path | Access requirement | Handler |
|---|---|---|---|
| `notify_widget.settings` | `/admin/config/system/notify-widget` | `administer site configuration` | `NotifyWidgetSettingsForm` |
| `notify_widget.send_action_confirm` | `/admin/people/send-notification` | `administer site configuration` | `NotifyWidgetSendActionConfirmForm` |
| `notify_widget.goto_notification` | `/notification/{id}/view` | `_user_is_logged_in: TRUE` | `NotifyWidgetController::__invoke` |
| `notify_widget.notifications` | `/user/{user}/notifications` | `_user_can_access_notifications` | `NotificationsController::__invoke` |
| `notify_widget.notifications.mark_as_read` | `/user/{user}/notifications/{notificationId}/read` | `_user_owns_notification` | `NotificationsController::markRead` |
| `notify_widget.notifications.mark_as_unread` | `/user/{user}/notifications/{notificationId}/unread` | `_user_owns_notification` | `NotificationsController::markUnread` |
| `notify_widget.notifications.mark_all_read` | `/user/{user}/notifications/markallread` | `_user_can_access_notifications` | `NotificationsController::markAllRead` |
| `notify_widget.delete_notification_confirm` | `/user/{user}/notifications/{notificationId}/delete` | `_user_owns_notification` | `DeleteNotificationConfirmForm` |
| `notify_widget.delete_all_notification_confirm` | `/user/{user}/notifications/deleteall` | `access content` | `DeleteAllNotificationsConfirmForm` |

`{user}` is an `entity:user` param constrained to `\d+`; `{notificationId}`/`{id}` are `\d+`.

## Controllers

- **`NotifyWidgetController::__invoke(int $id)`** (`src/Controller/NotifyWidgetController.php`):
  fetches `getNotificationsForUser(0, $id)` — `uid = 0` resolves to the current user, so the query
  is `uid = current_user AND id = $id`, scoping the lookup to the caller's own rows. If found it
  `markAsRead($id)` and redirects to the stored `link`; otherwise throws `NotFoundHttpException`.
- **`NotificationsController::__invoke(User $user)`** (`src/Controller/NotificationsController.php`):
  first calls `purgeOldNotificationsIfNeeded()`, then renders a paged `#type => table` of the
  user's notifications (`getNotificationsForUserPaged($uid, 20)`) with a per-row dropbutton
  (Go to link / Mark read-unread / Delete) plus a "Delete all" button; dropbutton links use
  `current_user->id()` for the `{user}` arg. Cell values (title/text/type) are rendered through
  the table theme and thus auto-escaped. `markRead`/`markUnread` call the API by
  `$notificationId` and redirect to the `destination`; `markAllRead(User $user)` calls
  `markAllAsReadByUserId($user->id())`.

## Forms

- **`DeleteNotificationConfirmForm`** (`_user_owns_notification` gated): deletes the
  `{notificationId}` via `deleteNotification()`.
- **`DeleteAllNotificationsConfirmForm`**: `submitForm()` deletes with
  `deleteAllNotificationsByUserId((int) currentUser()->id())` — it operates on the **logged-in
  user's own** rows (the `{user}` route param is not used for the deletion).
- **`NotifyWidgetSettingsForm`**: see [config/settings.md](../config/settings.md).

## Bulk "Send notification" action

`NotifyWidgetSendAction` (`src/Plugin/Action/NotifyWidgetSendAction.php`,
`@Action(id = "notify_widget_send_action", type = "user")`) appears in the People (`/admin/people`)
bulk-operations select. `executeMultiple()` stashes the selected accounts in
`tempstore.private` and the action's `confirm_form_route_name` sends the admin to
`NotifyWidgetSendActionConfirmForm` (`/admin/people/send-notification`), which collects title /
message / type / URL and calls `notify_widget.api->send('bulk', …)` once per selected uid.

The action's `access()` checks `hasPermission('send bulk notifications')`, but **the module ships
no `notify_widget.permissions.yml` defining that permission** — so it is grantable to no role and
the action is reachable only by user 1 (who bypasses access). Treat the bulk action as
effectively superuser-only until the permission is declared. Content it stores is later
auto-escaped on display.
