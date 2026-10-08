# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core's **Locale** module (`locale`, "Interface Translation") enabled —
  this is the one dependency, and Drupal enables it as a dependency when you turn
  on this module.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_translation_deployments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_translation_deployments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_translation_deployments -y
```

## Verify it worked

Place a custom `.po` file (for example `project_specific-custom.nb.po`) in your
configured translations directory, then run `drush locale-update`. Check that your
overridden strings now appear on the site in that language. See
["How to use it"](../index.md#how-to-use-it) for the full workflow.
