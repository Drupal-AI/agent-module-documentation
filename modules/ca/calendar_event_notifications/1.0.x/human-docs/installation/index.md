# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Three module dependencies, all installable via Composer:
  - **FullCalendar View** (`fullcalendar_view`) — displays the events on a
    calendar.
  - **Datetime Range** (`datetime_range`) — the field type used for event
    dates.
  - **Token** (`token`) — powers the templated email subject and body.
- A working **cron** run, since scheduled reminders are dispatched from cron.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_event_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in FullCalendar
View, Datetime Range, and Token and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_event_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_event_notifications -y
```

Enabling it installs the `calendar_event_notification` content type along with
its fields (`field_event_date`, `field_notify_mail`, `field_user`, and
`field_cron_run_once`) and a bundled View for FullCalendar.

## Next step

Set the email templates on the settings form — see
[Configuration](../configuration/index.md).
