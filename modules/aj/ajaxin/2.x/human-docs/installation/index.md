# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- The **Blazy** module, **version 3.x or newer** (`blazy:blazy (>= 3.x)`).
  Composer pulls it in automatically when you require Ajaxin.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajaxin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Blazy and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajaxin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajaxin -y
```

Drupal enables Blazy at the same time as a dependency. The loading animation is
active immediately during AJAX requests — there is no required configuration.
