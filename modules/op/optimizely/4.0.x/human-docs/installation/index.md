# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 5.4 or newer** (the module's declared minimum; any supported Drupal
  version already exceeds this).
- Core's **Path Alias** module (`path_alias`) enabled — this is the only
  dependency, and it is part of core.
- An **Optimizely account**, so you have an account ID and one or more project
  codes to load. The module loads Optimizely-hosted JavaScript; it does not create
  experiments.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/optimizely -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/optimizely -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en optimizely -y
```

A **Default** project (targeting the whole site) is created automatically, but it
won't load anything until you enter your account ID and enable a project with a
real code. Continue to [Configuration](../configuration/index.md).
