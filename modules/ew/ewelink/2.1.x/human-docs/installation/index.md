# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The eWeLink API PHP library, which the module uses to communicate with eWeLink's
  cloud (installed via Composer along with the module).
- An eWeLink account and credentials for the devices you want to control (see
  [Configuration](../configuration/index.md)).
- Outbound HTTPS access from your web server to the eWeLink cloud.

## Install with Composer

From the project root:

```bash
composer require drupal/ewelink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the eWeLink
PHP library and any shared dependencies at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ewelink -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ewelink -y
```

Enabling the module creates the **Open the Door User** role and the **Access the Open
the Door page** permission.

## Verify it worked

Log in as an administrator and open **People → Permissions** to confirm the **Access
the Open the Door page** and Activity permissions appear, and **People → Roles** to
confirm the **Open the Door User** role was created. Then continue to
[Configuration](../configuration/index.md) to connect your eWeLink account.
