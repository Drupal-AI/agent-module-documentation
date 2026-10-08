# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`), which provides the date
  range field this module extends. Drupal enables it automatically as a
  dependency.

There are no third‑party Composer packages, PHP extensions, or JavaScript
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_range_until_now -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_range_until_now -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_range_until_now -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a Date range field)* → Manage
fields**, edit the field, and look for the new **"Until now"** setting. Enable it,
then on **Manage form display** choose this module's widget for the field — the end
date should no longer be required — and on **Manage display** choose its formatter.
Create a piece of content with the field left "ongoing" and confirm it renders as
"… – Until now".
