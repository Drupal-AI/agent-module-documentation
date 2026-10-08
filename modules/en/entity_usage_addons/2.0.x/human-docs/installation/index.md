# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Usage** module (`entity_usage`) — this is a required dependency.
  Install and configure it first, and run its bulk update so existing content is
  tracked, otherwise the formatters will have no data to show.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_addons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you don't already have Entity Usage installed, Composer
will bring it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_addons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_addons -y
```

## Verify it worked

Add an **ID** field to an administrative View, choose the **Entity Usage** field
formatter for its output, and confirm usage links or counts render. Alternatively,
apply the formatter on a field in **Manage display** and view an entity you know is
referenced. If nothing shows, confirm Entity Usage is configured to track the
relationships you care about and that its bulk update has run.
