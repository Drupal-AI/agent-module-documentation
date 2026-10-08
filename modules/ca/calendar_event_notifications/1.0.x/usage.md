<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar event notifications

## What it is / when to use

- Ships a `calendar_event_notification` node type (event date, notify e-mail, assigned user, run-once flag) and sends e-mail reminders about appointments.
- Use when editors create appointment/event nodes and the assigned user should be notified on add/update/delete or on a scheduled date.
- Builds on FullCalendar View for display and Token for message templating.

---

## Install & configure

- Requires `fullcalendar_view`, `datetime_range`, and `token`; install all via Composer.
- Configuration form: `/admin/config/calendar-event-notifications` (route `calendar_event_notifications.settings`, permission `administer site configuration`).
- Configure the notification subject/body templates (token-enabled) and enabling of notifications.
- Notifications are dispatched from cron, so a working cron/queue is required.

---

## Usage & API notes

- Enabling the module installs the `calendar_event_notification` content type plus its fields (`field_event_date`, `field_notify_mail`, `field_user`, `field_cron_run_once`).
- A bundled View (`calendar_event_notification`) renders the events, intended for FullCalendar View.
- On node insert/update/delete the `.module` builds and queues/sends a mail to the configured recipient.
- The `field_cron_run_once` flag prevents a scheduled reminder from firing more than once.
- Mail bodies are assembled with Token replacement against the event node.
- Uses core `MailManager` for delivery; no third-party mail service.
- Settings are stored in the `calendar_event_notifications.settings` config object.
- The settings route sets `no_cache: TRUE` and is an admin route.
- Recipient address comes from the node's `field_notify_mail` value.
- Intended audience: sites needing lightweight appointment reminders without a full CRM.
- Event dates use the core `datetime_range` field type.
- Assigned user reference (`field_user`) links an event to a Drupal account.
- Cron frequency determines how promptly scheduled notifications go out.
- No public/anonymous routes are exposed; only the admin settings form.
- Extend by adding fields to the content type or altering the mail in a custom hook.
- Uninstalling removes the module config but review the created content type/fields before removal.
