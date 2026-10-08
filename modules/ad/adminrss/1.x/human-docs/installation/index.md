# Installation

## Requirements

- **Drupal 9.5 or newer** (`core_version_requirement: >=9.5`).

There are no third-party Composer or PHP library requirements. Note the current
release is a development snapshot (`1.x-dev`).

## Install with Composer

From the project root:

```bash
composer require drupal/adminrss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adminrss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adminrss -y
```

Once enabled, the moderation settings are under **Configuration → Web services →
Admin RSS** (`/admin/config/services/adminrss`) — see
[Configuration](../configuration/index.md).
