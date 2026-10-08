# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9.0 || ^10.0`).
- Core's **Block** module (`block`) and **Path alias** module (`path_alias`) —
  Drupal enables these automatically as dependencies.
- No third-party Composer libraries; the PickMeUp calendar JavaScript/CSS ships
  with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_events -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_events -y
```

Enabling it installs the **`content_calendar_events`** content type with its
`field_start_date_of_the_event` and `field_end_date_of_the_event` fields, plus
the view/form displays and language settings.

## Set it up

1. Create event nodes of the `content_calendar_events` type.
2. Go to **Structure → Block layout** (`/admin/structure/block`), place the
   **Calendar Events** block in a region, and choose how many calendars (1–3) to
   show. The calendar then renders your published events.
