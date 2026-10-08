# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_selection_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_selection_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_selection_handler -y
```

## Verify it worked

Go to **Manage form display** for an entity that has a link field, open the
**Widget** select list, and confirm **Link with selection handler** appears as an
option. Select it, press the gear/Edit button, and the reference‑method
configuration should appear (see the [overview](../index.md) for the known
first‑save workaround).
