# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2.0 || ^10 || ^11`).
- Core's **Views** (`views`) and **Datetime** (`datetime`) modules, enabled
  automatically as dependencies.
- The **FullCalendar**, **Moment.js**, and **RRule** JavaScript libraries. By
  default these load from a CDN, so there is nothing to install; to host them
  locally instead, place them under your site's `/libraries` directory.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fullcalendar_view -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullcalendar_view -y
```

There is no settings form to configure. Once enabled, the **Full Calendar
Display** format becomes available when you build a view — see the
[overview](../index.md#how-to-use-it) for the per‑view setup.

## Optional submodule — the view generator

Full Calendar View ships one submodule, **FullCalendar View Generator**
(`fullcalendarview_generator`), which adds a Drush command to scaffold calendar
views for you:

```bash
drush en fullcalendarview_generator -y
```

Enable it if you would rather generate a starter calendar view from the command
line than build one by hand.
