# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer or PHP libraries, and no other contrib dependencies for
  the wall itself. To handle payments and subscriptions, add Drupal Commerce and a
  licensing module separately.

## Install with Composer

From the project root:

```bash
composer require drupal/role_paywall -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_paywall -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_paywall -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Role
Paywall** (`/admin/config/content/role_paywall`). If the settings form loads and
lets you pick entity types, the module is ready — continue to
[Configuration](../configuration/index.md).
