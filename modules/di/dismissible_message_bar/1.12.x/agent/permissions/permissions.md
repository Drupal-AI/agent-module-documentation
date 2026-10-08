<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `dismissible_message_bar.permissions.yml`, enforced by
`DmbNotificationsEntityAccessControlHandler` (per-operation) and the routing.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer dmb notifications entities` | **true** | Notification-type (bundle) admin: `/admin/structure/dmb_notification_types` collection + add form. Trusted-admin only. |
| `add dmb notifications entities` | no | Create a notification entity (`checkCreateAccess`). |
| `edit dmb notifications entities` | no | Update operation. |
| `delete dmb notifications entities` | no | Delete operation. |
| `view published dmb notifications entities` | no | View a published notification entity. |
| `view unpublished dmb notifications entities` | no | View an unpublished (draft) notification. |
| `view all dmb notifications entity revisions` | no | View revisions. |

Notes:
- The add/edit/delete/view permissions are **not** `restrict access: true`, so they can be granted to
  lower-trust content-editor roles. Editing a notification lets that role author Paragraph content that
  renders (via the standard Paragraph view builder / core field formatters, which sanitize output) into
  a bar shown to site visitors — this is the module's intended content-authoring capability, comparable
  to editing a block or node body.
- The public block only surfaces notifications returned by `returnAllNotifications()`, whose entity query
  runs with `accessCheck(TRUE)` — so viewers must satisfy `view published dmb notifications entities`.
