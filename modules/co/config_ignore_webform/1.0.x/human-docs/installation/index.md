# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Config Ignore** (`config_ignore`) version **^3** — the generic ignore engine
  this module extends.
- **Webform** (`webform`) version **^6** — the module whose config is being
  ignored.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_ignore_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Config Ignore and Webform if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_ignore_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_ignore_webform -y
```

Config Ignore and Webform are required dependencies and are enabled with it.

## Verify it worked

Open the settings form from either **Structure → Webforms → Config ignore**
(`/admin/structure/webform/config/ignore`) or **Configuration → Development →
Configuration synchronization → Webforms**
(`/admin/config/development/configuration/webform-ignore`). Confirm it lists your
non-template webforms and option lists so you can choose which should still sync —
see [Configuration](../configuration/index.md).
