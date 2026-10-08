# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Block** module (part of standard Drupal), since the module is
  configured entirely through a block.
- The module is designed to be **compatible with the core Slick module** and the
  Slick carousel library; have Slick available so the carousels have a library to
  drive.

There are no additional PHP or third-party library requirements declared by the
module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_pro_customizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slick_pro_customizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick_pro_customizer -y
```

## Verify it worked

Place the **Slick Pro Customizer** block (see *How to use it* in the
[main guide](../index.md)), configure one carousel element pointing at some markup
on the page, and load that page. The targeted markup should behave as a working
Slick carousel with the options you chose.
