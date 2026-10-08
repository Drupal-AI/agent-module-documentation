# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or higher.
- **No external libraries or module dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_weight_analyst -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_weight_analyst -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_weight_analyst -y
```

## Verify it worked

Navigate to **Configuration → Development → Module Weight Analyst**. You should see the
Integrity Dashboard with a Health Score and the interactive weights table. Because
changing weights affects routing and security layers, do your auditing and any
adjustments on a local or staging environment before applying them to production — see
"How to use it" in the [overview](../index.md).
