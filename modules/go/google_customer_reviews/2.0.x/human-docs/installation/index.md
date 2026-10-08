# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Checkout** (`commerce_checkout`),
  enabled automatically as dependencies.
- A **Google Merchant Center** account with a merchant ID and the Customer Reviews
  program available.

## Install with Composer

From the project root:

```bash
composer require drupal/google_customer_reviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_customer_reviews -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush pm:enable google_customer_reviews -y
drush cr
```

## Verify it worked

Go to **Configuration → Web services → Google Customer Reviews**
(`/admin/config/services/google-customer-reviews`) — the settings form should load.
The checkout pane is added automatically to the *complete* step of your default
checkout flow. Continue to [Configuration](../configuration/index.md) to enter your
merchant ID and place the badge.
