# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- An **NfP365 CRM** account with credentials for the **OpenAPI** and **WebAPI**
  (issued for your Dynamics 365 / NfP365 environment).

There are no third‑party PHP library requirements and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/nfp365_crm_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nfp365_crm_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nfp365_crm_api -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web Services → NfP365 CRM
API** (`/admin/config/services/nfp365-crm-api`). If the credentials form loads, the
module is installed. Continue with [Configuration](../configuration/index.md) to
enter your OpenAPI and WebAPI credentials before making any API calls.
