# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dcs_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dcs_popup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dcs_popup -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Digital Climate
Strike Popup Settings** (`/admin/config/dcs_popup/settings`). Choose a widget (see
[Configuration](../configuration/index.md)), save, and then visit the front end to
confirm the popup appears for visitors.
