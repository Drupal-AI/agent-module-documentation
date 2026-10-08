# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autowire_plugin_trait -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autowire_plugin_trait -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autowire_plugin_trait -y
```

Or enable **Autowire Plugin Trait** from *Extend* (`/admin/modules`).

The module must be enabled so its trait is available on the autoloader, but there is
nothing to configure and no submodules. Once enabled, `use` the trait in your custom
plugins — see [How to use it](../index.md#how-to-use-it).
