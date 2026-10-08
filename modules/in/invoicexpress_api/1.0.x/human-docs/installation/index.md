# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **direct contract with InvoiceXpress** and an **API key** (plus your account
  details) obtained from your InvoiceXpress dashboard. The module cannot do
  anything useful without valid InvoiceXpress credentials.
- No additional PHP libraries are required by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/invoicexpress_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/invoicexpress_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en invoicexpress_api -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Web services →
InvoiceXpress API** (`/admin/config/services/invoicexpress_api`). If the
credentials form loads, the module is installed. Enter your API credentials there
(see [Configuration](../configuration/index.md)) to complete the setup. Because
the module is a developer integration, the real test is calling one of its
services from custom code and confirming a record is created in your
InvoiceXpress account.
