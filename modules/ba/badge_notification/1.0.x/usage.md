<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Badge Notification shows logged-in users small "New"/"Updated" status markers and unread-count badges, computed from Drupal core's history table and loaded asynchronously so page caching is unaffected.

---

Badge Notification adds a hidden "Content status" extra field to every content type; when that field is enabled on a view display it renders an empty placeholder, and an async JavaScript request fills it with a translated **New** or **Updated** marker based on the node's created/changed time and the current user's last-viewed timestamp in the core `history` table. It also lets you attach badges to menu links: editing a menu link exposes a "Notifications handlers" select of Views (base table `node_field_data`) whose new-item **count** is rendered next to the link. All badges on a page are collected by `Drupal.behaviors.badge_notification` and posted in one request to `/badge-notification/get/json`, which runs the matching plugin (`node_is_new`, `views_count_new`, or `views_has_new`) and returns rendered markup. Behavior is driven by two settings — a maximum content age in days and which statuses (new / updated) to show — and the plugin type is extensible.

---

- Show a "New" marker on recently created nodes the current user has never viewed.
- Show an "Updated" marker on nodes changed since the user last viewed them.
- Display an unread-item count badge on a menu link (e.g. an "Inbox" or "Articles" link).
- Drive a menu badge from any existing View whose base table is `node_field_data`.
- Show only a "New" flag on a menu link instead of a number (via `views_has_new`).
- Keep badges accurate under full page caching by loading them asynchronously after page load.
- Limit status display to content created/changed within the last N days (1–30, default 7).
- Choose whether to display "new" content, "updated" content, or both.
- Add the "Content status" field to a content type's Manage display to enable node markers.
- Attach one or more badge handlers to a single menu link and combine their results.
- Provide count badges that update automatically as core writes to the `history` table on each node view.
- Give authenticated users a lightweight "what's new since I last looked" cue in navigation.
- Highlight new forum topics, comments listings, or catalog items surfaced through a View.
- Surface unread counts for a moderation or workflow queue exposed as a View.
- Add engagement cues to a member dashboard menu without custom theming.
- Extend the system with a custom `@BadgeNotification` plugin for bespoke badge logic.
- Render badges through the overridable `badge_notification` theme hook / Twig template.
- Restrict who can attach badge handlers to menu links via the `administer badge notification` permission.
- Configure everything from a single settings form at `/admin/config/content/badge-notification`.
- Use it purely as a presentation layer over core History/Views with no new content entities.
