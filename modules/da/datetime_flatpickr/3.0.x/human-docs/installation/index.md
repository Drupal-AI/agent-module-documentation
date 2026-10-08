# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Datetime** module (`datetime`) enabled — Drupal enables it
  automatically as a dependency. (Date‑range widgets also need core's **Datetime
  Range** module.)
- The **flatpickr** JavaScript library — loaded from a CDN by default, so nothing
  to install unless you prefer to self‑host it (see below).

There are no third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_flatpickr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_flatpickr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_flatpickr -y
```

Then head to [Configuration](../configuration/index.md) to put a Flatpickr widget
on a date field.

## Optional: self-host the flatpickr library

Out of the box the module loads flatpickr (version 4.6.11) from a CDN. To avoid
the external dependency, download the flatpickr library and place it so that the
file `libraries/flatpickr/dist/flatpickr.js` exists. The module detects the local
copy automatically and uses it instead of the CDN — no configuration needed.

## Optional submodules

Two submodules extend the picker to other tools. Enable whichever you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Flatpickr for Better Exposed Filters** | `datetime_flatpickr_bef` | Turns Views exposed date filters into flatpickr pickers. Requires the Better Exposed Filters module. |
| **Flatpickr for Webform** | `datetime_flatpickr_webform` | Adds a flatpickr date element to Webform. Requires the Webform module. |

For example:

```bash
drush en datetime_flatpickr_webform -y
```
