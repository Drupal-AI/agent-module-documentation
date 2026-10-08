# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core only — the module lists no other module or PHP library requirements.
- A **Netcall account** with the AI widget provisioned, and the widget's
  embed details from Netcall.

## Install with Composer

From the project root:

```bash
composer require drupal/netcall_ai_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/netcall_ai_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en netcall_ai_widget -y
```

## Verify it worked

Visit **Configuration → Web services → Netcall AI Widget**
(`/admin/config/services/netcall/ai-widget`). If the settings form loads, the module
is installed. Nothing appears to visitors until you enter your Netcall details and
enable the widget — see [Configuration](../configuration/index.md).
