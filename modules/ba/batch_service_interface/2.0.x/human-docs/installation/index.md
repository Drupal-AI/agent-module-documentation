# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No additional contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/batch_service_interface -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_service_interface -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_service_interface -y
```

There is nothing to configure — define your batch services from code.

## Optional: the example submodule

The project ships an example submodule, **Batch Example** (`batch_example`), that
demonstrates how to declare and run a batch as a service. Enable it if you want a
working reference to copy from:

```bash
drush en batch_example -y
```

It depends on the base Batch Service Interface module, which is already present
once you have installed it above. See
[How to use it](../index.md#how-to-use-it).
