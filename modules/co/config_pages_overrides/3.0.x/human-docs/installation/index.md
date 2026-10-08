# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- The **[Config Pages](https://www.drupal.org/project/config_pages)** module
  (`config_pages`) — this is a hard dependency. Install and enable it first (or let
  Composer/Drush pull it in), then create at least one Config Pages type with the fields
  you want to expose as overrides.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_pages_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Config Pages dependency
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_pages_overrides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_pages_overrides -y
```

Drupal will enable **Config Pages** at the same time if it is not already on.

## Verify it worked

1. Make sure you have a Config Pages type with a field you want to expose (for example a
   text field for a site name). If you have none yet, create one under **Structure → Config
   pages types**.
2. Open **Structure → Config pages types → *(your type)* → Manage**, and confirm a **Config
   Overrides** tab is present. That tab is added by this module.

Once you can see the Config Overrides tab, the module is working — head to
[Configuration](../configuration/index.md) to create your first override mapping.
