# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer packages, PHP extensions, or JavaScript
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_reset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_reset -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a date field)* → Manage form
display**, click the gear icon on a Date, Date/Time, or Date range field, and turn
on the reset-button option. Save, then open the content edit form — the field
should now show a **Reset** button that clears its value when clicked.
