# Installation

## Requirements

- **PHP 8.0 or newer.**
- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/field_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_access -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_access -y
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
field_access`. Enabling the module changes nothing on its own — it takes effect
only once you define permission maps in PHP. There is **no settings page**; see the
overview's [How to configure access](../index.md#how-to-configure-access) and the
module's README for the array structure.
