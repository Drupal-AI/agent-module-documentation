# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No module dependencies. The popup behavior is built on core's jQuery, `once`, and
  `drupal` JavaScript libraries.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_popup_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_popup_blocks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_popup_blocks -y
```

Simple Popup Blocks ships no submodules. Once enabled, grant the **Administer
simple_popup_blocks** permission to the roles that should manage popups, then head to
[Configuration](../configuration/index.md) to create your first popup.
