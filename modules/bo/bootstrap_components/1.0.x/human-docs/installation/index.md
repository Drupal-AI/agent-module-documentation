# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`). Single Directory
  Components (SDC) are provided by Drupal core in these versions.
- No module dependencies are declared, and it carries no permissions.
- A **Bootstrap 5** front‑end context (theme) to provide the styling and behavior
  the components' markup expects.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_components -y
```

There are no submodules. Once enabled, the Bootstrap 5 components are available
to your templates and Layout Builder — see the
[overview](../index.md#how-to-use-it).
