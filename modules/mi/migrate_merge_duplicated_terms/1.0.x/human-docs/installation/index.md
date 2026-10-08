# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled.
- The contributed **Migrate Plus** module (`drupal/migrate_plus`).

These requirements come from the module's project page. There are no PHP library
requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_merge_duplicated_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_merge_duplicated_terms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_merge_duplicated_terms -y
```

Make sure core Taxonomy and Migrate Plus are enabled as well (Drupal will pull in
declared dependencies automatically).

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no settings form to check — the
`merge_duplicated_terms` process plugin becomes available for use in your
migration YAML (see "How to use it" on the [overview page](../index.md)).
