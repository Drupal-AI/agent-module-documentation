# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Media** (`media`) modules — Drupal enables these as
  dependencies when you turn on SD Breadcrumb.
- The optional **Token** module is recommended if you want a token browser when
  composing dynamic labels, but it is not required.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sd_breadcrumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sd_breadcrumb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sd_breadcrumb -y
```

## Verify it worked

Visit **Configuration → User interface → SD Breadcrumb**
(`/admin/config/user-interface/sd-breadcrumb`). If the settings page loads and lists
your content types, the module is active. Nothing about your breadcrumbs changes
until you configure a pattern — see [Configuration](../configuration/index.md).
