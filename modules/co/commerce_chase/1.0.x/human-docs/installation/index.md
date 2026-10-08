# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Commerce Payment** (`commerce_payment`) enabled — it ships with Drupal
  Commerce. Composer pulls in `drupal/commerce` (`^2.25 || ^3`).
- The PHP **SOAP extension** (`ext-soap`) — the gateway talks to Chase's Orbital
  SOAP API through PHP's `SoapClient`.
- A **Chase Paymentech / Orbital merchant account** with the credentials the
  gateway needs: a Secure Account ID (Hosted Payment account), an Orbital API
  username and password, a Terminal ID, a Merchant ID, and your processing BIN.
  Chase requires individual merchant certification before live use.
- An HTTPS checkout and a PCI-compliant hosting setup, since this handles card
  payments.

There are no additional third-party Composer or PHP library requirements. Note the
current release is an **alpha** — pin the version and test carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_chase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_chase -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_chase -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add the **Orbital®
Hosted Payment Form** gateway. Enter your Orbital credentials, leave the gateway in
**test** mode, and run a test transaction before switching to live. Follow
[Configuration](../configuration/index.md) for the credential and safeguard
details.

> **Note:** this module is minimally maintained and the current release is an alpha.
> Test thoroughly and keep it updated.
