# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- Core's **Views** and **Datetime** modules (`views`, `datetime`), enabled —
  Drupal enables them as dependencies automatically.
- The **FullCalendar.io library**, provided by the companion module
  `drupal/fullcalendar_io` (`^6.1`), which Composer pulls in for you. This is what
  supplies the actual calendar JavaScript/CSS assets.

Optional, for extra date handling:

- **Date Recur** (`drupal/date_recur`) — recurring-date support (dev-tested).
- **Smart Date** (`drupal/smart_date`) — Smart Date field support (dev-tested).

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and bring in the `fullcalendar_io` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fullcalendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullcalendar -y
```

## Optional submodule — Legend

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **FullCalendar Legend** | `fullcalendar_legend` | A Views area handler that prints a color legend beneath the calendar, matching the per-bundle and per-taxonomy colors you set on the FullCalendar style. |

Enable it if you use color-coded events and want a legend:

```bash
drush en fullcalendar_legend -y
```

## Verify it worked

Create or edit a View, and in its **Format** section you should now be able to
choose **FullCalendar** as the style. Continue to
[Configuration](../configuration/index.md) to set it up.
