# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **`/admin/config/calendar-event-notifications`** (route
   `calendar_event_notifications.settings`).

The values are saved to the `calendar_event_notifications.settings` config
object.

## What you configure

- **Enable notifications** — the switch that turns email reminders on.
- **Subject template** and **body template** — the email's subject and body,
  written with **Token** placeholders. Tokens are replaced against the event
  node when a message is built, so you can drop the event's title, date, and
  other values straight into the text.

Save the form to store the templates.

## How reminders are sent

- When a `calendar_event_notification` node is **added, updated, or deleted**,
  the module builds a message from your templates and sends it to the address in
  that node's **notify email** field (`field_notify_mail`).
- **Scheduled reminders** are dispatched from **cron**, so how promptly they go
  out depends on how often cron runs.
- The **run once** flag (`field_cron_run_once`) stops a scheduled reminder from
  firing more than once.
- Mail is delivered through Drupal's core mail manager — there is no third-party
  mail service involved.

## Creating events

Create content of the **`calendar_event_notification`** type and fill in the
event date, the notify email address, and the assigned user. Display the events
on a FullCalendar View using the View the module ships. You can extend the setup
by adding fields to the content type or altering the message in a custom hook.
