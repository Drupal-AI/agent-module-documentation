# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- Core's **Field** module (`field`) — enabled on virtually every Drupal site
  already, and enabled automatically as a dependency.
- The PHP **intl** extension, which provides the `NumberFormatter` class the
  formatter is built on. Most Drupal‑ready PHP installations (including DDEV's)
  ship it; if number formatting does not appear, confirm intl is loaded.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/number_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/number_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en number_formatter -y
```

## Verify it worked

Visit the **Number formats** collection page (route
`entity.number_format.collection`) and confirm you can add a new format. Then edit
a number field's **Manage display**, choose the **Number Formatter** formatter,
and confirm your named format is selectable.
