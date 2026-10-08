# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

This module requires no modules outside of Drupal core, and there are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/emergency_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emergency_notification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emergency_notification -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Emergency
Notification settings**. If the settings form loads, the module is installed.
Nothing appears on the site until you configure a notification and enable it — see
[Configuration](../configuration/index.md).
