<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Reminders and Notifications (content_reminders) — agent index

Schedules **cron-driven email reminders about individual nodes**. Editors set a recipient list, a
send date/time and an optional message; on cron the module emails the recipients a link to the node
plus the message, then disables the reminder so it fires once. Package `Other`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0. No contrib dependencies (uses core **node** + the mail system).

## What it actually provides

- **Config entity** `content_reminder` (`src/Entity/ContentReminder.php`, `ContentReminderInterface`) —
  fields: `id`, `label`, `status`, `nid`, `emails` (comma-separated string), `date_time` (Unix
  timestamp), `message`. `admin_permission = "administer content reminder"`.
- **Service** `content_reminders.content_reminder` → `ContentReminderService` — injects the inline
  reminder fieldset into node edit forms and handles its AJAX save.
- **Settings config** `content_reminders.settings` with one key `content_types` (which content types
  get the inline fieldset), edited by `ContentRemindersSettingsForm`.
- **Controller** `ContentReminderController::preview` — renders a reminder's fields as an item list.
- **Permission** `administer content reminder`. **Config schema** for both config objects.
- Hooks in `content_reminders.module`: `hook_help`, `hook_preprocess_html` (adds CSS under the
  `adminimal_theme`), `hook_form_alter` (inline fieldset), `hook_entity_delete` (cleanup),
  `hook_cron` (send + disable), `hook_mail` (build message).

## Solution docs

- **Config entity, routes, service, cron send + hook_mail, list/preview** →
  [entity/reminders.md](entity/reminders.md)
- **Enabling content types (settings form + config object)** →
  [config/settings.md](config/settings.md)

## Routes (all admin-gated)

- `content_reminders.form` `/admin/config/development/content_reminders` — `administer site configuration`.
- `entity.content_reminder.collection|add_form|edit_form|delete_form` under `/admin/structure/content_reminder`
  and `entity.content_reminder.preview_page` `/…/{content_reminder}/preview` — `administer content reminder`.
