# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) and **Field** module (`field`) — both are
  standard on almost every site and are enabled automatically as dependencies.
- A **Composer-based workflow** and a running **Revive Adserver** instance you can
  point Drupal at.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revive_adserver -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revive_adserver -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revive_adserver -y
```

## Verify it worked

Log in as an administrator and visit
**Configuration → Web services → Revive Adserver**
(`/admin/structure/services/revive-adserver`). If the settings form loads, the
module is installed correctly. Next, follow the [Configuration](../configuration/index.md)
guide to connect your Revive instance and place your first ad.
