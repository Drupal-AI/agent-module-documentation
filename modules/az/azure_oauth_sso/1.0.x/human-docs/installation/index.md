# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Microsoft Entra ID (Azure AD)** tenant where you can register an application
  (to obtain a client ID and client secret) and set the redirect URI.

There are no other module dependencies and no third‑party Composer or PHP library
requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_oauth_sso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_oauth_sso -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_oauth_sso -y
```

After enabling, register the Azure application and enter its credentials — see
[Configuration](../configuration/index.md).
