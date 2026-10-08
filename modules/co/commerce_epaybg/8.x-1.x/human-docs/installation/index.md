# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module — the module depends on
  `commerce` and `commerce_payment` (Commerce Payment 8.x‑2.21 or newer),
  enabled automatically as dependencies.
- An **ePay.bg** merchant account, which supplies your MIN (merchant id), secret
  key and account email.

There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_epaybg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_epaybg -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_epaybg -y
```

Enabling the module runs an install hook that creates the
`commerce_epaybg_payments` table, which maps ePay invoices to Commerce orders so
notifications resolve to the correct order.

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **EpayBG (Redirect to EpayBG system)** appears in the
list of plugins, the module is installed correctly. Continue to
[Configuration](../configuration/index.md).
