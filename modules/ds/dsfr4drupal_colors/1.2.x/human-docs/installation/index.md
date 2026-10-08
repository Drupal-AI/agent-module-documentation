# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Cron** running on your site — the DSFR color palette is imported
  automatically from the official DSFR sources on a cron job.
- Recommended: the base **DSFR for Drupal** theme, since this module is part of
  the DSFR for Drupal suite and is meant to be used with it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr4drupal_colors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr4drupal_colors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr4drupal_colors -y
```

After enabling, let cron run once so the module can import the current DSFR
palette (or run it manually with `drush cron`).

## Verify it worked

Add a new field to a content type (**Structure → Content types → *(type)* →
Manage fields → Add field**) and confirm a **DSFR color** field type is offered.
Then see [Configuration](../configuration/index.md) for the per‑field options.
