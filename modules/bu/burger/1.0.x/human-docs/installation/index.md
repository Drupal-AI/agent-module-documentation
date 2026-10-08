# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency. This is the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/burger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/burger -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en burger -y
```

There is no required configuration. Once enabled, place the Burger Menu block in
a theme region as described in the [overview](../index.md#how-to-use-it).
