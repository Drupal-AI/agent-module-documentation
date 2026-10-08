# Installation

## Requirements

- **Drupal core 10.5, 11, or 12** (`drupal/core: ^10.5 || ^11 || ^12`).
- For the migration Drush commands, **Drush 12.5.2 or newer** (or Drush 13).
- No other modules or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_error_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_error_status -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_error_status -y
```

There are no submodules. There is no settings form to configure — you use the module by
adding its condition to a block. See the ["How to use it" section on the overview
page](../index.md#how-to-use-it).
