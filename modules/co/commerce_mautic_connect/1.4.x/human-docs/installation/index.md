# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce**, specifically the **Cart** module (`commerce_cart`).
- The **Advanced Mautic Integration** module
  (`advanced_mautic_integration`), which holds the connection to your Mautic
  instance. Composer installs it as a dependency.
- A reachable **Mautic instance** with API access enabled and API credentials.
- *(Optional)* **Commerce Exchanger** for automatic currency conversion when you
  compute customer metrics across multiple currencies.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_mautic_connect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Advanced Mautic
Integration and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_mautic_connect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_mautic_connect -y
```

This also enables Advanced Mautic Integration if it isn't already on.

## Verify it worked

After enabling, continue to [Configuration](../configuration/index.md) to connect
your Mautic instance. Once connected, add an item to a cart and confirm the
contact and cart data appear in Mautic — that end-to-end check is the surest sign
the integration is working.
