# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Drupal Commerce** with the order, price, payment and checkout modules —
  the module depends on `commerce_order`, `commerce_price`, `commerce_payment`
  and `commerce_checkout`, which are enabled automatically as dependencies.
- A configured **payment gateway** to actually take the donations. This module
  does not process payments itself; pair it with a Commerce gateway (ideally one
  that supports recurring payments if you want monthly donations).

There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_donation_flow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_donation_flow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_donation_flow -y
```

## Verify it worked

Log in as an administrator and go to **Administration → Commerce →
Configuration → Donation settings**
(`/admin/commerce/config/donation-settings`). If the donation settings page
loads, the module is installed correctly. Continue to
[Configuration](../configuration/index.md) to complete the donation setup.
