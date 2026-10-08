# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Configuration Manager** module (`config`).

There are no third‑party PHP library requirements. This is the 8.x‑1.4 release.

The download the module adds is gated by core's `export configuration` permission —
a permission marked *restricted* in core. Grant it only to trusted administrators,
as you would for core's own configuration export and import screens.

## Install with Composer

From the project root:

```bash
composer require drupal/config_single_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_single_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_single_export -y
```

There is nothing to configure.

## Verify it worked

Go to `/admin/config/development/configuration/single/export`, pick a configuration
item, and confirm a **Download** button now appears at the bottom of the form.
Clicking it should download the selected configuration as a YAML file with the
correct filename.
