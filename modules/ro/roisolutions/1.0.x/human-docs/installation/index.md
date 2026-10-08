# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Key** module (`key`) — this is a hard dependency, used to store your ROI
  Solutions API username and password securely. Composer pulls it in automatically.
- Credentials for the ROI Solutions (Revolution CRM) REST API, obtained from ROI
  Solutions.

There are no additional third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/roisolutions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/roisolutions -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en roisolutions -y
```

Drupal enables the Key dependency at the same time.

## Verify it worked

Log in as an administrator and go to **Configuration → ROI Solutions → REST API**
(`/admin/config/roisolutions/settings/rest-api`). If the settings form loads, the
module is installed and ready to configure — continue to
[Configuration](../configuration/index.md) to store your credentials.
