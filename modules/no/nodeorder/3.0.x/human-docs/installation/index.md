# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Node** (`node`) and **Taxonomy** (`taxonomy`) modules — both enabled on
  most content sites, and Drupal enables them as dependencies if needed.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nodeorder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodeorder -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodeorder -y
```

Enabling the module adds a `weight` column to core's taxonomy index table, which is
where the node positions are stored. (Uninstalling the module drops that column
again.)

## Next steps

Nothing is orderable until you say so. Head to
[Configuration](../configuration/index.md) to mark a vocabulary as **Orderable**,
then use each term's **Order** tab to arrange its content. You'll also want to grant
the **order nodes within categories** permission to the editors who will do the
ordering.
