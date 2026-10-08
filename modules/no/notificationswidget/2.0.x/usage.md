<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notifications Widget adds the bell icon familiar from social platforms: a dropdown that lists recent site activity with an unread count, updated in place as the viewer reads, deletes, or clears items.

---

The module watches entity create/update/delete and, for any bundle you have enabled, writes a row into its own `notifications` table with a token-replaced message such as "Article X has been created by [user:name]" plus a link. A block plugin (`notification_widget_block`) renders those rows as a bell-and-dropdown for authenticated users, tracking per-user read and delete state in two side tables (`notifications_actions`, `notifications_clear_all`); a small JavaScript client posts read / delete / clear-all back to a REST endpoint (`POST /api/notification_update`) so the count changes without reloading the page. Configuration is one config object edited by two admin forms under `administer site configuration`: a per-bundle settings form at `/admin/config/system/notifications_widget` (enable which of Create/Update/Delete are logged, the message template, and the link per action) and a logger form at `/admin/config/people/notifications_widget/loggers` (exclude bundles, or add extra entity types like profile or paragraphs). Messages support Drupal tokens for `user`, `node`, `taxonomy_term`, and `comment`. Other modules can log their own items by calling the `notifications_widget.logger` service, and the `notifications` table is exposed to Views with relationships to node, comment, term, profile, and message. The block's Twig template assumes Bootstrap/Glyphicon CSS. The project machine name (`notificationswidget`) differs from the module name (`notifications_widget`), which matters for `drush en`; the documented `2.0.x` branch has only alpha releases, the newest being `2.0.0-alpha9`.

---

- Show a notification bell with an unread count.
- List recent activity in a dropdown.
- Notify editors when content of a given type is created.
- Log a notification from another module via `logNotification()`.
- Update the unread count without a page reload.
- Give authenticated users an in-site activity feed.
- Mark a notification as read.
- Delete a single notification from the list.
- Clear all notifications at once.
- Customise the message per action with tokens like `[node:title]`.
- Link each notification to the related entity with `[entity:url]`.
- Choose which entity ops (Create/Update/Delete) are logged per bundle.
- Exclude specific bundles from being logged.
- Add extra entity types (profile, paragraphs, message) to the logger.
- Place the bell as a block via Block layout.
- Show only other users' activity ("skip own activities").
- Show an admin-oriented feed of everyone's activity.
- Build a custom notifications listing with Views.
- Relate notifications back to nodes, comments, or terms in a view.
- Surface taxonomy term changes to editors.
- Notify on comment creation.
- Reduce reliance on email for in-site alerts.
- Give an intranet a familiar notification pattern.
- Track what a user has already seen via per-user read markers.
