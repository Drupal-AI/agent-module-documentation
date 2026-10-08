# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- No other module dependencies. (The Spectrum Colorpicker library the widget uses
  is handled by the module.)

## Install with Composer

From the project root:

```bash
composer require drupal/field_color -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_color -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_color -y
```

## Verify it worked

Go to any bundle's **Manage fields**, click **Add field**, and a **Color** field
type should be available. See the [overview](../index.md#how-to-use-it) for adding
and customising the picker.
