# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** module (`datetime`) — Drupal enables it automatically as a
  dependency. (You need a Date field for the formatter to apply to.)
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_card_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_card_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_card_formatter -y
```

Core's Datetime module is enabled automatically as a dependency.

## Use the formatter

Go to the **Manage display** tab of a content type (or other entity) that has a
Date field, and choose the **Calendar Card** formatter in that field's Format
column. Save, and the date renders as a calendar-page card.
