# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Commerce Payment** (`commerce_payment`) enabled — it ships with Drupal
  Commerce.
- A **CCAvenue merchant account**, which provides the Merchant ID, Access Code, and
  Working Key the gateway needs.
- Outbound HTTPS from your server to CCAvenue, and an HTTPS checkout on your own
  site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ccavenue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_ccavenue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ccavenue -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can **add a gateway**
of type **CCAvenue Redirect**. Then follow [Configuration](../configuration/index.md)
to enter your credentials and run a test transaction — but note (see the
configuration notes) that "test" mode still hits CCAvenue's production endpoint, so
treat any test run accordingly.
