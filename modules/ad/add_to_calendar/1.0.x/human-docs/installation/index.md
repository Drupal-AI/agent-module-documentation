# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Drupal core's **Datetime Range** module (`datetime_range`) enabled — this is the
  only dependency, and Drupal enables it automatically when you turn on Add to
  Calendar. It provides the event start/end date field the calendar links are
  built from.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/add_to_calendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_to_calendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_to_calendar -y
```

There is no global settings page. To put the calendar links on an event, add the
computed field to your content type and arrange it on **Manage display** — see
[How to use it](../index.md#how-to-use-it).
