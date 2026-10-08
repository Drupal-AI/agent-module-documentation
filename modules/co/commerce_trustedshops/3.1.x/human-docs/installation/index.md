# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Store** (`commerce_store`).
- The **Trusted Shops PHP SDK** (`antistatique/trustedshops-php-sdk`) — an
  external PHP library used to talk to the Trusted Shops API. Composer installs it
  automatically when you require the module.
- A **Trusted Shops account** with your **TSID** and API credentials. Product
  reviews require an appropriate Trusted Shops package.

## Version note

Use the branch that matches your Drupal and Commerce versions:

| Drupal core | Commerce TrustedShops | Drupal Commerce |
|-------------|-----------------------|-----------------|
| 10.x        | 3.0.x or 3.1.x        | 2.33.x or 3.x   |
| 11.x        | 3.1.x                 | 3.x             |

This guide covers the **3.1.x** branch.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_trustedshops -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
and it pulls in the Trusted Shops PHP SDK for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_trustedshops -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_trustedshops -y
```

Commerce and Commerce Store are enabled automatically as dependencies if they
aren't already.

## Verify it worked

Go to **Commerce → Configuration → TrustedShops**
(`/admin/commerce/config/trustedshops`). If the Shops admin page loads, the module
is installed. Continue to [Configuration](../configuration/index.md) to create your
Shop entity and connect the service.
