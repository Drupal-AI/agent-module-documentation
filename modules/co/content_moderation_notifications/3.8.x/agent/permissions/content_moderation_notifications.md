# Permissions — content_moderation_notifications

The module defines **one** permission (`content_moderation_notifications.permissions.yml`):

| Permission | Machine name | Gates |
|---|---|---|
| Administer content moderation notifications | `administer content moderation notifications` | The notifications collection/list route and, as the config entity's `admin_permission`, create/edit/delete/enable/disable of every `content_moderation_notification`. |

- It is a restricted admin permission — grant only to trusted roles (it lets a user configure who
  receives moderation emails, including ad-hoc external addresses).
- Manage it on People → Permissions (`/admin/people/permissions`).
- Receiving a notification requires **no** permission; recipients are chosen by the notification's
  config (author / roles / ad-hoc emails / user fields). Role recipients are still individually
  access-checked for `view` on the moderated entity before being emailed.
