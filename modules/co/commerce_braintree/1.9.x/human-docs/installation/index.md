# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` `~2.25 || ^3`), specifically its
  **Payment** submodule (`commerce_payment`), which is enabled as a dependency.
- The official **`braintree/braintree_php`** SDK (`^6.12`), pulled in automatically
  by Composer.
- A **Braintree merchant account** with API credentials (merchant ID, public key,
  private key). Use a Braintree **sandbox** account for testing before going live.

## Install with Composer

Commerce Braintree **must be installed via Composer** — the tarballs on the
project page are for reference only. From the project root:

```bash
composer require drupal/commerce_braintree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the `braintree/braintree_php` SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_braintree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_braintree -y
```

This also ensures Commerce's Payment submodule is enabled.

## Keep your API credentials safe

Your Braintree private key is a secret. Rather than committing it, store it in an
environment variable and load it via DDEV, then reference it when you configure the
gateway:

```bash
ddev dotenv set .ddev/.env --braintree-private-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Use your Braintree **sandbox**
credentials while testing and switch to live credentials only when you set the
gateway to Live mode.

## Verify it worked

Go to **Commerce → Configuration → Payment → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
you should see **Braintree (Hosted Fields)** in the list of plugins. Adding and
saving it (with sandbox credentials) confirms the module and SDK are installed
correctly.

Next, see [Configuration](../configuration/index.md) to fill in credentials,
currencies, and 3-D Secure.
