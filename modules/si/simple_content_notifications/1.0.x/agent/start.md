<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Content Notifications (simple_content_notifications) — agent index

Emails a configured recipient list when nodes are **created / updated / deleted**, and on cron
emails a periodic **digest of content overdue for review**. Package `Content`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `1.0.x` (installed 1.0.3).
**No module dependencies** (uses core node), no composer requirements, no Drush, no submodules,
no config schema files.

- **Both config objects, every key, the two settings forms, routes & permission** →
  [config/settings.md](config/settings.md)
- **How notifications actually fire — hooks, cron, mail keys, gating logic** →
  [api/notifications.md](api/notifications.md)

## What it provides (from source)

- **Hooks in `simple_content_notifications.module`:** `hook_help`, `hook_mail` (keys
  `create_node`, `update_node`, `delete_node`, `review`), `hook_node_insert/update/delete`,
  `hook_theme` (`needs_review_page`), `hook_cron`. Plus procedural helpers
  `simple_content_notifications_prep()` and `simple_content_notifications_check_last_revised()`.
- **Two config forms** (`src/Form/`): `ContentNotificationSettingsForm` (config
  `simple_content_notifications.settings`) and `ContentReviewNotificationSettingsForm` (config
  `simple_content_notifications.review_settings`, injects the `state` service).
- **One controller** `src/Controller/NeedingReview::reportPage()` → theme `needs_review_page`
  (template `templates/needs-review-page.html.twig`).
- **Permission** `administer content notifications` (`*.permissions.yml`, `restrict access: true`).
- **Routes** (`*.routing.yml`): `.settings` and `.needing_review_settings` (both
  `_permission: administer content notifications`) and `.needing_review`
  (`_permission: administer content`).
- **State key** `simple_content_notifications.review_notifications_next_send` (per-environment
  next-send date, moved out of config by update hook 9002).

## Key behaviour

- CRUD notifications only fire when `..._active` is on, the node's bundle is in the configured
  types, and the current base URL contains the configured live domain (unless in-dev is allowed).
  The acting editor's own address is filtered out of recipients.
- Review digest runs in `hook_cron`: queries nodes with the configured date field, keeps those
  older than the relative cutoff (`review_notifications_due`, default `-6 months`), and mails one
  HTML table no more often than `review_notifications_delay` (default `+7 days`).
