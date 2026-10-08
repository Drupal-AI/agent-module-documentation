# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_extras -y
```

After enabling, configure a block under **Structure → Block layout** and review
the extra options the module adds — see
[How to use it](../index.md#how-to-use-it).
