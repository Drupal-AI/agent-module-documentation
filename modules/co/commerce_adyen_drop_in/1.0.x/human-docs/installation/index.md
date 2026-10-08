# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- **Drupal Commerce** with **Commerce Payment** (`commerce`,
  `commerce_payment`).
- The **Adyen PHP API library** (`Adyen\Client`), installed via Composer.
- An **Adyen account** with an API key, client key, HMAC key, merchant account,
  and (for production) a live endpoint prefix.

## Install with Composer

Requiring the module with Composer will also pull in the Adyen PHP SDK it depends
on. From the project root:

```bash
composer require drupal/commerce_adyen_drop_in -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install shared
dependencies, including the Adyen PHP library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_adyen_drop_in -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_adyen_drop_in -y
```

## Store your Adyen credentials as secrets

The **API key**, **client key**, and **HMAC key** are secrets and must never be
committed to version control. With DDEV, save them as environment variables and
expose them through Key entities:

```bash
ddev dotenv set .ddev/.env --adyen-api-key=<value> --adyen-client-key=<value> --adyen-hmac-key=<value>
ddev restart
```

Then create Key entities (install the Key module first if needed with
`ddev composer require drupal/key && ddev drush en key -y`) using the env
provider and reference them from the gateway configuration.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to add the Adyen Drop-in
gateway and set up the webhook. In **test** mode, place an order, complete payment
through the Drop-in with an Adyen test card, and confirm the payment is recorded
after Adyen's webhook is received and validated.
