# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Drupal Commerce** with the **Commerce Shipping** stack — Swiss Post is a shipping method
  plugin, so Commerce Shipping must be installed to use the shipping/label features. (The CH/LI
  address-verification feature works without Commerce Shipping.)
- A **Swiss Post account** with API credentials — an OAuth Client ID/Secret and franking
  license for label generation, and/or Address Web Services credentials for address
  verification. These are entered on the **Swiss Post Settings** page, not on the shipping
  method form.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_swiss_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_swiss_post -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_swiss_post -y
```

## Verify it worked

Go to **Configuration → Web services → Swiss Post Settings**
(`/admin/config/services/swiss-post-settings`) — the settings form should load. Then, under
**Commerce → Configuration → Shipping methods** (`/admin/commerce/shipping-methods`), add a
shipping method and confirm **Swiss Post** appears as a plugin option. See "How to use it" in
the [overview](../index.md) for entering your API credentials and configuring the method.
