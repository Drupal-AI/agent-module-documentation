# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- A **QuickBooks Online account** of your own, and an **Intuit developer account**
  with an app created in it (this is where the OAuth credentials come from — see
  [Configuration](../configuration/index.md)).
- The **QuickBooks PHP SDK**, which Composer installs automatically as a
  dependency — you do not download it separately.

## Install with Composer

From the project root:

```bash
composer require drupal/quickbooks_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the QuickBooks PHP
SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quickbooks_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quickbooks_api -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Quickbooks API**
(`/admin/config/quickbooks_api/adminsettings`). If the settings form loads, the
module and its SDK are installed correctly. The next step is to enter your Intuit
app credentials and connect — see [Configuration](../configuration/index.md).
