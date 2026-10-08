# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** core (2.x or 3.x) with the **Payment** module
  (`commerce_payment`) enabled — this is the dependency, and there are no
  additional PHP libraries.
- An **ifthenpay account** with the credentials for each payment method you plan
  to enable (for example the MB key for dynamic Multibanco references, and the card
  key for credit-card payments).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ifthenpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_ifthenpay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling the base module gives you **Multibanco references**:

```bash
drush en commerce_ifthenpay -y
```

## Submodules — enable only the payment methods you need

Each additional payment method ships as a submodule. Enable the ones you want:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **MB WAY** | `commerce_ifthenpay_mbway` | Sends a payment push to the customer's phone at checkout, with a storefront re-send option and admin-side push creation. |
| **Credit card** | `commerce_ifthenpay_cc` | Redirect-based credit-card payments through ifthenpay, with security-key verification on return. |

For example, to add MB WAY:

```bash
drush en commerce_ifthenpay_mbway -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the ifthenpay gateway(s) for the methods you enabled appear in the list.
Then follow [Configuration](../configuration/index.md) to enter your credentials
and register the callback URLs in the ifthenpay backoffice.
