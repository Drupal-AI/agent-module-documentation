# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

This module requires nothing outside of Drupal core — no other modules and no PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/checkall_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/checkall_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en checkall_widget -y
```

## Choose the widget on your field

There's nothing to configure globally. To use it, go to the relevant bundle's
**Manage form display** (Structure → your entity type → Manage form display), find
an options‑buttons (checkboxes) field, and set its **Widget** to **Checkall
Widget**. Save. See the [overview](../index.md#how-to-use-it) for the full steps.

## Verify it worked

Edit a piece of content that has the field you configured. The checkbox field should
now show a check‑all / select‑all control that toggles every option at once.
