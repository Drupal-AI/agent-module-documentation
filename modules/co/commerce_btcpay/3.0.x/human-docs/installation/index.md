# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with **Commerce Checkout** and **Commerce Payment**
  enabled (`commerce_checkout`, `commerce_payment`).
- A **BTCPay Server** instance you can reach — self‑hosted, a third‑party host, or
  a test server — with at least a Bitcoin or Lightning wallet set up on a store.

> **Upgrading from 1.x/2.x?** Version 3.x switches to BTCPay Server's Greenfield
> API and uses new libraries and API tokens. It is a breaking change — **uninstall
> the old version first**, then install 3.x and follow the setup below.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_btcpay
```

Composer pulls in the required `btcpayserver/btcpayserver-greenfield-php` library
automatically. The module also needs the PHP `bcmath` and `openssl` extensions —
its install check will block enabling if the Greenfield library is missing.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_btcpay`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_btcpay -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**, click
**Add payment gateway**, and confirm **BTCPay** appears in the plugin list. Then
continue to [Configuration](../configuration/index.md) to pair with your BTCPay
Server.
