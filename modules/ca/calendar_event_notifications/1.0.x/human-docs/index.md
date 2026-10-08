# Calendar event notifications — manual setup guide

**Calendar event notifications** (`calendar_event_notifications`) is a
lightweight way to manage appointment-style events and email reminders about
them, without a full CRM. Enabling it installs a ready-made
`calendar_event_notification` content type — each event carries a date, a
notification email address, an assigned user, and a "run once" flag — and it
sends email reminders when those events are added, updated, deleted, or reach a
scheduled date.

It is built on two other modules. **FullCalendar View** provides the visual
calendar the events are displayed on (the module ships a matching View for it),
and **Token** lets you write the reminder email's subject and body as templates
that fill in the event's own values. Reminders are dispatched from cron, so the
site needs a working cron run for scheduled notifications to go out on time.

The audience is a site where editors create appointment or event nodes and the
assigned person should be notified about them by email. There are no
public-facing routes — only an admin settings form — and nothing
security-sensitive in the way it sends mail (it uses Drupal's core mail system,
with no third-party service).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer along with its
   dependencies, and enable the module.
2. [Configuration](configuration/index.md) — the notification settings form and
   the message templates.

## Where it lives in the admin menu

The settings form is at **`/admin/config/calendar-event-notifications`** (route
`calendar_event_notifications.settings`), and requires the **Administer site
configuration** permission. Enabling the module also installs the
`calendar_event_notification` content type and its fields, which you manage as
normal content.

## How to use it

Configure the notification templates (see [Configuration](configuration/index.md)),
then create nodes of the `calendar_event_notification` type — setting the event
date, the notify email, and the assigned user. When events are added, changed,
or removed, and when scheduled reminders come due on cron, the assigned
recipient gets an email. Display the events on a FullCalendar View using the
bundled View.
