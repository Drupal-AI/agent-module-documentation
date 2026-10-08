# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10.0`).
- These modules enabled (Composer pulls them in for you):
  - **[AddToAny](https://www.drupal.org/project/addtoany)** (`addtoany`) — the base
    module whose service configuration this field reuses.
  - Core **Node** (`node`) and **Link** (`link`).

## Install with Composer

From the project root:

```bash
composer require drupal/addtoany_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
AddToAny module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addtoany_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addtoany_field -y
```

There is no settings form and no submodules. After enabling, add the AddToAny field
to a content type through the Field UI — see the "How to use it" section of the
[overview](../index.md).
