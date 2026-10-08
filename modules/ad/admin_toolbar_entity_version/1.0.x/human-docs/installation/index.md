# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) enabled — this is the only dependency, and
  Drupal enables it automatically as needed.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_entity_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_entity_version -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar_entity_version -y
```

There is no configuration form. Once enabled, view an entity that has revisions (such
as a node) and the Toolbar shows the version/revision information for the entity
you're viewing.
