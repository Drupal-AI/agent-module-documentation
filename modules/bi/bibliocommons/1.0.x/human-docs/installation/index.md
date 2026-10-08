# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Key** (`key`) and **Field** (`field`) modules.
- The contributed **WSData** module (`wsdata:wsdata`).
- The contributed **UI Patterns** module (`ui_patterns:ui_patterns`).
- A **BiblioCommons account and API key** for the library catalog you want to pull
  lists from.

Composer fetches the contributed dependencies when you require the module with the
`-W` flag; the core modules are enabled automatically as dependencies.

> **Note:** This release is an alpha (`1.0.0-alpha4`). Test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/bibliocommons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch and update the WSData
and UI Patterns dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bibliocommons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibliocommons -y
```

Drupal enables the Key and Field dependencies automatically; make sure WSData and UI
Patterns are enabled too. Once active, continue to
[Configuration](../configuration/index.md) to store your API key securely and connect
your catalog.
