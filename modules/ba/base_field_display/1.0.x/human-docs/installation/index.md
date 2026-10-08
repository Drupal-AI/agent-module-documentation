# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0** or later.
- Core's **Path** module (enabled on any standard site).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/base_field_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/base_field_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en base_field_display -y
```

There is no configuration screen. Once enabled, go to any entity's **Manage
display** screen and you will find its base fields available to arrange and format
— see [How to use it](../index.md#where-it-lives--how-to-use-it).
