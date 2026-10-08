<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Notify — permissions

Defined in `comment_notify.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer comment notify` | The settings form (`/admin/config/people/comment_notify`, routes `comment_notify.settings` and `comment_notify.unsubscribe`). Change global comment-notification settings. |
| `subscribe to comments` | Whether the "Notify me when new comments are posted" checkbox is added to the comment form. Users with `administer comments` also see it. |

Notes:
- The per-subscription disable route `comment_notify.disable/{hash}` requires only
  `access content` (so an unsubscribe link in an email works for anyone with the hash).
- These are plain permissions (no `restrict access` flag); grant them to roles as usual.
