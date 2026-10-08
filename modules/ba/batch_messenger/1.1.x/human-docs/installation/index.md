# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- No additional contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/batch_messenger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_messenger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_messenger -y
```

There is nothing to configure — call the API from your own batch/queue code. See
[How to use it](../index.md#how-to-use-it).
