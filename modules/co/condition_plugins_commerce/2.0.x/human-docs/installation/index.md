# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drupal Commerce** — specifically the **Commerce Order** module
  (`commerce_order`). Composer pulls in Commerce as a dependency; Drupal will
  prompt to enable `commerce_order` when you enable this module.

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/condition_plugins_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install/update Drupal
Commerce and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/condition_plugins_commerce -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en condition_plugins_commerce -y
```

This also ensures **Commerce Order** is enabled.

## Verify it worked

On a Commerce site, edit any block via **Structure → Block layout** and open the
**Visibility** tab. On order routes you should see the new order conditions
(order type, payment gateway, product variation, base-field value) available.
