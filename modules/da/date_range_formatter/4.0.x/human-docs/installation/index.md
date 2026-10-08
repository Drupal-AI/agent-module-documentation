# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — provides the date‑range
  field type this formatter renders.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/date_range_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_range_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_range_formatter -y
```

If Datetime Range is not yet enabled, enable it too
(`drush en datetime_range -y`).

## Verify it worked

Edit the **Manage display** of an entity that has a date‑range field. In that
field's **Format** dropdown you should now see **Date Range Formatter**. Choose it,
open its settings to set the start/end formats, same‑day collapse, and separator,
then save and view an entity to confirm the range renders as you intend. See
["How to use it"](../index.md#how-to-use-it) for the full steps.
