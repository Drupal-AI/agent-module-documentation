# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- These modules enabled (Composer pulls them in for you):
  - **[Address](https://www.drupal.org/project/address)** (`address`)
  - **[Search API](https://www.drupal.org/project/search_api)** (`search_api`)
- A working Search API index that includes an Address field.

## Install with Composer

From the project root:

```bash
composer require drupal/address_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address and Search API modules and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_processor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_processor -y
```

There is no settings form and no submodules. After enabling, turn the processor on
inside your Search API index's **Processors** tab and reindex — see the "How to use
it" section of the [overview](../index.md).
