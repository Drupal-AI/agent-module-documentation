# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module — Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements. This module is
minimally maintained, so test it on a copy before running it against production
content.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_replace -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_replace -y
```

## Grant the permission

Replacing terms requires the **replace taxonomy terms** permission (in addition to
delete access to the specific term). Go to **People → Permissions**
(`/admin/people/permissions`) and grant *replace taxonomy terms* to the roles that
should be able to consolidate terms.

## Verify it worked

Open any taxonomy term as a user who has the permission. You should see a **Replace**
tab on the term (and a **Replace** entry in its operations dropdown on the vocabulary
overview). See the [main guide](../index.md#how-to-use-it) for the replacement flow.
