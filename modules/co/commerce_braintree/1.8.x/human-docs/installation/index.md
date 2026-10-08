# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** `~2.25 || ^3`, with its **Payment** module (`commerce_payment`)
  enabled — this is a required dependency.
- The **Braintree PHP SDK** (`braintree/braintree_php` `^6.12`) — a Composer library the
  module uses to talk to Braintree. Composer installs it automatically.
- A **Braintree merchant account** (a sandbox account for testing, a live account for
  production) and its API credentials: merchant ID, public key, and private key.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_braintree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Drupal Commerce and the
Braintree PHP SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_braintree -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_braintree -y
```

If Drupal Commerce and its payment module aren't enabled yet, enable them too (Composer will
have downloaded them):

```bash
drush en commerce_payment -y
```

Enabling the module makes the **Braintree (Hosted Fields)** gateway plugin available, but no
payments can be taken until you add and configure a gateway with your Braintree credentials.

## Next step

Head to [Configuration](../configuration/index.md) to add the gateway, enter your
credentials, and (optionally) turn on 3‑D Secure.
