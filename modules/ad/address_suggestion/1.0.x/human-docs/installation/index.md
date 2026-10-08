# Installation

## Requirements

- **Drupal 9.2, 10, 11, or 12** (`core_version_requirement: ^9.2 || ^10 || ^11 || ^12`).
- The **[Address](https://www.drupal.org/project/address)** module (`address`)
  enabled. Composer pulls it in for you.
- Access to an address-lookup provider for the suggestions (configured per field
  in the widget settings).

## Install with Composer

From the project root:

```bash
composer require drupal/address_suggestion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_suggestion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_suggestion -y
```

There is no settings form and no submodules. After enabling, turn on autocomplete
per field by choosing the Address suggestion widget on a content type's **Manage
form display** and picking a provider — see the "How to use it" section of the
[overview](../index.md).
