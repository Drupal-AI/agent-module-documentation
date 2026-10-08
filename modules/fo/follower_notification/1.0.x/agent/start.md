<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Follower Notification (follower_notification) — agent index

**Bell/email notifications to a member's followers (Flag Follower) on node publish and to authors on new comments; stored in a custom `notifications` table.**

- **Version:** 1.0.x (from `1.0.2`) · **Package:** PanKM
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Module machine name:** `follower_notifications` (files/hooks are `follower_notifications_*`; project/dir is `follower_notification`).
- **Depends:** `flag:flag`, `flag_follower:flag_follower`.
- **Route:** `follower_notifications.admin_settings_form` at /admin/config/follower_notifications/adminsettings (`_permission: 'access administration pages'`, admin route).
- **Hooks:** `node_insert`, `comment_insert`, `entity_access` (marks read), `mail`, `theme`, `page_attachments`.
- **Security:** settings route admin-gated; DB writes use the query builder with bound params (no raw SQL). Behavioural note: `hook_entity_access` issues an UPDATE on every access check (write-on-read); relies on a custom `notifications` table existing.
