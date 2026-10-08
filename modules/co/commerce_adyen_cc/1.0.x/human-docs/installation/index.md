# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3||^10`).
- **Drupal Commerce** (`commerce`), including Commerce Payment, for the payment
  gateway framework.
- An **Adyen account** with API credentials (API key, HMAC key, merchant
  account). Review Adyen's own README/setup notes — during testing you'll need
  specific test card numbers and may need to configure your risk profile to allow
  trusted test email addresses so transactions aren't rejected for fraud.

This is a development (`1.0.x` dev) release — test carefully before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_adyen_cc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_adyen_cc -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_adyen_cc -y
```

## Store your Adyen credentials as secrets

Your Adyen **API key** and **HMAC key** are secrets and must never be committed to
version control. With DDEV, save them as environment variables and expose them
through a Key entity:

```bash
ddev dotenv set .ddev/.env --adyen-api-key=<value> --adyen-hmac-key=<value>
ddev restart
```

Then create Key entities (install the Key module first if needed with
`ddev composer require drupal/key && ddev drush en key -y`) using the env
provider, and reference those keys from the gateway configuration rather than
pasting the raw values into the form.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to add the Adyen payment
gateway. Once configured in **test** mode, place a test order using Adyen's test
card numbers and confirm the payment is recorded against the order.
