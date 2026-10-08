# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** and **Taxonomy** modules — these are the only entity types the
  uniqueness check supports, and they are enabled on most sites already.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/allow_only_one -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allow_only_one -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allow_only_one -y
```

There is no settings page to visit. Configuration happens when you add the **Allow
Only One** field to a content type or vocabulary and set its uniqueness rule — see
[the overview](../index.md) for the steps.
