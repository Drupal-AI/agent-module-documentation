<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller, permissions (core module)

Controller: `src/Controller/NotificationSystemController.php`. Injected: `notification_system`
service, `renderer`, `entity_type.manager`, `current_user`, `request_stack`.

## Routes (`notification_system.routing.yml`)
| Route | Path | Method | Permission | Controller/form |
|---|---|---|---|---|
| `notification_system.example` | `/notification-system/example` | GET | `access content` | `::build` |
| `notification_system.getnotifications` | `/notification-system/get-notifications/{display_mode}` | GET | `access content` | `::getNotifications` |
| `notification_system.markasread` | `/notification-system/read/{providerId}/{notificationId}` | GET | `access content` | `::markAsRead` |
| `notification_system.notification_groups.mapping` | `/admin/structure/notification-group/mapping` | GET/POST | `administer site configuration` | `GroupMappingForm` |

Plus the `notification_group` entity routes (collection/add/edit/delete) under
`/admin/structure/notification-group`, gated by `administer site configuration`.

## Controller methods
- `build()` — debug page: a `#table` of the current user's notifications (via
  `getNotifications($this->currentUser())`), `max-age=0`. Development aid.
- `getNotifications($display_mode)` — renders the current user's unread notifications HTML for the
  block's AJAX call; `?showRead` query param includes read items; returns a plain `Response`
  (`max-age=0`). Delegates to `buildRenderableNotifications()`.
- `markAsRead(string $providerId, string $notificationId)` — calls
  `notificationSystem->markAsRead($this->currentUser(), $providerId, $notificationId)`; on success
  returns JSON `{status: success}` (200) and invalidates cache tag
  `notification_system:read:{uid}`; on failure JSON `{status: error, message}` (400).
- `buildRenderableNotifications($displayMode, $showRead)` — builds `notification_item` render
  arrays; in `bundled` mode wraps them per `notification_group`.

All three visitor-facing methods act on `$this->currentUser()` / `$this->currentUser` — the acting
user is always the session user; the id path arguments identify the notification within its
provider, and the provider owns the ownership/authorization decision for that id (the database
provider's `markAsRead()`, for example, checks the notification's audience).

## Permissions
The core module ships **no** `notification_system.permissions.yml` entries. Access relies on core
`access content` (routes) and `administer site configuration` (group admin + mapping). Submodules
add their own permissions (`administer notification`, `access notification overview`,
`administer notification_system_dispatch configuration`, etc.).
