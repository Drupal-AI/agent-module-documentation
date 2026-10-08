# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **User Provisioning** module (`user_provisioning`) — a hard dependency. It
  performs the actual directory API calls and OAuth token exchange; this module
  supplies the Azure‑specific configuration screens on top of it.
- An **Azure AD / Azure AD B2C tenant** and an **App registration** with Microsoft
  Graph permissions for reading/writing users, plus a client secret.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_ad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in User Provisioning
and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_ad -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_ad -y
```

Drupal will enable User Provisioning alongside it. Then work through the setup
wizard to connect your Azure tenant and configure sync — see
[Configuration](../configuration/index.md).
