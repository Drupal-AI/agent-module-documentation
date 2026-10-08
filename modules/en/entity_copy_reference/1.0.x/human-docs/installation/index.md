# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies.

The module currently supports cloning **nodes** only.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_copy_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_copy_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_copy_reference -y
```

## Verify it worked

The module does nothing visible until you configure it. Head to
[Configuration](../configuration/index.md), choose at least one content type to
make copyable, and set how its references should be handled. Then grant the
module's cloning permission (**People → Permissions**) to the roles that should be
allowed to copy, and check that a copy action appears on a node of that content
type.
