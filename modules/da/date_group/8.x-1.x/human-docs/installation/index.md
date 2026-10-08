# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — this provides the
  date‑range field type this formatter works on. (On Drupal 8 this requires core
  8.2.0 or later.)
- No third‑party Composer or PHP library requirements.

> This is a **beta** release (8.x‑1.0‑beta4). Check the collapsed output against
> your timezone, all‑day, and multilingual needs before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/date_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_group -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_group -y
```

If Datetime Range is not yet enabled, enable it too (`drush en datetime_range -y`).

## Verify it worked

Edit the **Manage display** of an entity that has a date‑range field. In the
**Format** dropdown for that field you should now see **Date Group** as an option.
Choose it, pick a date‑only format, save, and view an entity with a multi‑day
range — the two dates should render as a single collapsed string. See
["How to use it"](../index.md#how-to-use-it) for the full steps.
