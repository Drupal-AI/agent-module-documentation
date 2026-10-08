# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party libraries and no module dependencies beyond Drupal core. The
  condition works with core's block system out of the box.

## Install with Composer

From the project root:

```bash
composer require drupal/ip_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_condition -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_condition -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), edit a block, and
open its **Visibility** settings. You should now see an **IP address** condition
available. Configuring it there is covered in "How to use it" on the
[overview page](../index.md).
