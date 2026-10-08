# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **PHP 8.1 or newer**.
- The **[Address](https://www.drupal.org/project/address)** module (`address`,
  version `^2`) enabled. This is the module Address Iran extends, and Composer
  will pull it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/address_iran -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_iran -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_iran -y
```

That is all. There is no configuration form and no submodules. From now on, any
Address field set to Iran will show the correct province and city fields. To
confirm it worked, add or edit an Address field, fill it in on a form, and choose
**Iran** as the country — the province and city selectors should appear.
