# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Address](https://www.drupal.org/project/address)** module (`address`)
  enabled. This is the module Address for Rep. of Moldova extends, and Composer
  will pull it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/address_md -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_md -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_md -y
```

That is all. There is no configuration form and no submodules. From now on, any
Address field set to Moldova will show the added city field and district list. To
confirm it worked, add or edit an Address field, fill it in on a form, and choose
**Moldova** as the country.
