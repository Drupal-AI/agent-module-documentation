# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **Update** (`update`) and **Block** (`block`) modules enabled — both are
  part of Drupal core and are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advupdate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advupdate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advupdate -y
```

The expanded update email is **on by default**, so it is active as soon as the
module is enabled — the next core update notification email will include the full
project detail. See [Configuration](../configuration/index.md) to toggle that
behavior or to place the Security Updates block.

## Verify it worked

Go to **Reports → Available updates → Settings**
(`/admin/reports/updates/settings`). You should see a new checkbox, *"Expand the
report using 'Update Manager Advanced' module"*, ticked by default. That confirms
the module is installed and active.
