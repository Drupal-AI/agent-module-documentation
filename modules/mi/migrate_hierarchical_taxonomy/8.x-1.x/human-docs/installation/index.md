# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- Core's **Taxonomy** module (`taxonomy`).
- The contributed **Migrate Plus** module (`drupal/migrate_plus`) — this is a
  hard requirement.

There are no PHP library requirements of its own beyond those pulled in by the
modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_hierarchical_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_hierarchical_taxonomy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_hierarchical_taxonomy -y
```

Drupal enables core Migrate, core Taxonomy, and Migrate Plus automatically as
dependencies if they are not already on.

## Verify it worked

Confirm the module and its dependencies are enabled (for example on the
**Extend** page, or with `drush pm:list --status=enabled`). There is no settings
form to check — the module is ready once it and Migrate Plus are enabled, and you
put it to work from your migration YAML (see "How to use it" on the
[overview page](../index.md)).
