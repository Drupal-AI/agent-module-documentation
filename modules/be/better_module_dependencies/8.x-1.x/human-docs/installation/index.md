# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No dependencies and no third‑party Composer or PHP library requirements — it is
  just a small JavaScript behaviour and an info file.

## Install with Composer

From the project root:

```bash
composer require drupal/better_module_dependencies -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_module_dependencies -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_module_dependencies -y
```

That is all — there is no configuration. Visit **Extend** (`/admin/modules`) and
the dependency names are now clickable links.
