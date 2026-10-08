# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- Core's **User** module (always present) — the only module dependency.
- An **Azure AD / Entra ID** tenant and an **App registration** (for the client ID,
  client secret, and redirect URI).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_ad_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_ad_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_ad_login -y
```

After enabling, register an app in the Azure portal and fill in the module's
settings form — see [Configuration](../configuration/index.md).
