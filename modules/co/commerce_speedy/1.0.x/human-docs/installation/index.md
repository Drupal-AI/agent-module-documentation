# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Shipping** (`commerce_shipping`) — Speedy is a shipping method plugin, so the
  Commerce Shipping stack must be installed.
- **Anonymous Session** (`anonymoussession`) — a contrib dependency that Composer will
  fetch.
- Core's **Telephone** (`telephone`) field module.
- A **Speedy account** with API credentials — see Configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_speedy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed — including the `anonymoussession` contrib dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_speedy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_speedy -y
```

Enabling the module also pulls in `commerce_shipping`, `anonymoussession`, and `telephone`
if they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`) and add a shipping method — **Speedy** should appear as
a plugin option. Continue to [Configuration](../configuration/index.md) to enter your API
credentials and finish the setup.
