<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Follower Notification builds a lightweight social-notification system: when a community member publishes a node (or receives a comment), everyone following that member gets a bell notification and/or an email.
---
It builds on the Flag and Flag Follower modules — followers are the users who have flagged the author. On `hook_node_insert` for a published node of a configured type, it queries the `flagging` table for the author's followers and inserts a row per follower into a custom `notifications` table (entity id, author uid, action, recipient uid, title, status, created). On `comment_insert` it notifies the content author, again writing a bell row and/or sending mail (`hook_mail` key `new_comment`) depending on the admin `comment_notify` setting. A theme hook `follower_notifications` renders a notification count/body, and `hook_entity_access` marks a viewer's notifications for that node as read by updating the table. The settings form lives at `/admin/config/follower_notifications/adminsettings` behind `access administration pages`.

All database work uses the Drupal query builder with bound conditions/values (no raw SQL concatenation). Note two behavioural points for operators: the module maintains its own non-config `notifications` table (schema expected to exist), and `hook_entity_access` performs an UPDATE on every entity access check to clear the viewer's unread flags — a write-on-read side effect worth knowing for performance. No external services or public mutation endpoints are exposed.
---
- Let members follow each other via Flag Follower.
- Choose which content types trigger follower notifications.
- Notify followers when a member publishes a node.
- Send a bell notification to each follower.
- Send an email notification to followers (mail option).
- Notify a content author when someone comments on their content.
- Configure comment notifications as bell, mail, or both.
- Render a notification count in the site header/theme.
- Mark notifications as read when the target content is viewed.
- Store notifications in a dedicated `notifications` table.
- Localise the new-comment email via `hook_mail`.
- Use the site mail address as the notification sender.
- Restrict settings to admins (`access administration pages`).
- Build a community activity feed from stored notifications.
- Exclude the author from being notified of their own actions.
- Only notify for published content (status == 1).
