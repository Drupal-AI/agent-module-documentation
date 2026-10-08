# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No additional contrib module dependencies. (You will use it together with
  Drupal's Migrate system to define the imports it runs.)

## Install with Composer

From the project root:

```bash
composer require drupal/batch_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_import -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_import -y
```

Then grant its permission to the trusted operator who will run migrations, and
run the batched import — see [How to use it](../index.md#how-to-use-it).
