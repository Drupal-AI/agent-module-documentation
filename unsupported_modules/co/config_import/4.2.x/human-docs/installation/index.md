# Installation

## Requirements

- **Drupal 11** only (`core_version_requirement: ^11`).
- No other modules and no third‑party Composer or PHP library dependencies.

## Install with Composer

Note the naming: the **project** on drupal.org is `confi`, so that's the Composer
package you require, even though the module you enable is `config_import`.

```bash
composer require drupal/confi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `config_import` (not `confi`):

```bash
drush en config_import -y
```

The module ships no submodules and has no configuration screen. Once enabled, use
the `config_import.importer` service from your own code — see the
[main guide](../index.md#how-to-use-it).
