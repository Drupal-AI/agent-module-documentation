# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** and **User** modules.
- **Smart Date** (`smart_date`) and **Smart Date Starter Kit**
  (`smart_date_starter_kit`) — this kit extends the Starter Kit.
- **FullCalendar** (`fullcalendar`) for the calendar display.
- **Add content by bundle** (`add_content_by_bundle`).

You don't need to install these one by one — requiring the module with Composer
pulls in all of them.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_date_calendar_kit -W
```

The Composer package name (`drupal/smart_date_calendar_kit`) matches the module's
machine name (`smart_date_calendar_kit`). The `-W` (`--with-all-dependencies`)
flag lets Composer download and install all the necessary modules (Smart Date,
FullCalendar, the Starter Kit and helpers) and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_date_calendar_kit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_date_calendar_kit -y
```

This installs the Events content type, the related views, and the FullCalendar
display, all connected via tab navigation.

## Verify it worked

The calendar won't render while it's empty, so create at least one event at
`/node/add/event`, then visit `/events/calendar` — your event should appear on the
calendar.
