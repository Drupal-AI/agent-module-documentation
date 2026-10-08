# Installation

## Requirements

- **Drupal 10.2+, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- The **Helper** module (`helper`) must be installed — it is a required dependency.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_is_public -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Helper
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_is_public -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_is_public -y
```

Drush will enable the Helper module too if it is not already on.

## Verify it worked

There is no UI to check. Once the module is enabled, the `entity_is_public()` API is
available for other modules to call. Confirm the module is enabled at **Extend**
(`/admin/modules`) or with `drush pml --status=enabled | grep entity_is_public`.
