# Installation

> **Before you install:** this module **bulk‑deletes content entities and their
> translations**, and the deletion is **irreversible**. Take a database backup
> before using it, and review the warnings in the [overview](../index.md).

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Intended for **multilingual** sites (it operates on entity translations), so
  you will normally have core's language and content‑translation modules enabled.

There are no other module dependencies, and no PHP library or third‑party
Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/delete_entity_translations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delete_entity_translations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delete_entity_translations -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Regional and language →
Delete Entity Translations**
(`/admin/config/regional/delete-entity-translations`). If the screen loads, the
module is active. Do **not** run a deletion until you have taken a backup and
confirmed your selection — see the [overview](../index.md) for the full workflow
and warnings.
