# Installation

## Requirements

Telephone Formatter needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Telephone** module (`telephone`) enabled — the formatter only applies
  to core `telephone` fields. Drupal enables it automatically as a dependency.
- The **`giggsey/libphonenumber-for-php`** PHP library (`^8.0`) — this is Google's
  libphonenumber port that does the actual parsing and formatting. Installing the
  module with Composer pulls it in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/telephone_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`giggsey/libphonenumber-for-php` library and update any shared dependencies as
needed. Installing via Composer (rather than downloading the module archive) is
important here, because the module will not work without that library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/telephone_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_formatter -y
```

Drupal turns on the core `telephone` dependency for you if it is not already
enabled.

There is no settings page. To start using it, choose the **Formatted telephone**
formatter on a Telephone field's **Manage display** screen — see the
[overview](../index.md#how-to-use-it).
