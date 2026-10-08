<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Spamicide — agent index

Honeypot anti-spam: adds a CSS-hidden `feed_me` field to selected forms and rejects submissions
that fill it in. One `spamicide` config entity per protected form (keyed by `spamicide_form_id`).
Manage at `admin/structure/spamicide` (`configure` = `entity.spamicide.collection`).

- **Protection entities, the honeypot/validate flow, settings, admin mode, permissions** →
  [configure/protection.md](configure/protection.md)

Key facts:
- `hook_form_alter` matches an enabled `spamicide` entity to `$form_id`, adds a hidden `feed_me`
  textfield + `spamicide_validate`, attaches library `spamicide/spamicide` (hides the field via CSS).
- `spamicide_validate`: non-empty `feed_me` → form error, optional watchdog log (form id + client IP)
  + counter increment, then redirect to current page (front page for login).
- Install auto-protects: `contact_message_feedback_form`, `contact_message_personal_form`,
  `user_register_form`, `user_login_form`, `comment_comment_form`.
- Settings `spamicide.settings`: `spamicide_admin_mode` (adds "protect this form" links),
  `spamicide_log_attempts`, `spamicide_counter`.
- Permission: `administer spamicide` (entity CRUD); settings form gated by `administer site configuration`.
- Honeypot field name is hardcoded `feed_me` in this release. No deps, no plugins, no Drush.
