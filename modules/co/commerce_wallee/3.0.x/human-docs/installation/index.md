# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- **Drupal Commerce** (`commerce`) and Commerce **Payment**
  (`commerce_payment`) — enabled automatically as dependencies. This is the
  Commerce 3 integration.
- The **Wallee PHP SDK** (`wallee/sdk`) — installed automatically by Composer
  when you require the module, so there is nothing extra to fetch.
- A **Wallee account** with a Space ID, application User ID, and API secret.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_wallee -W
```

Composer will pull in the `wallee/sdk` PHP library alongside the module. The
`-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_wallee -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_wallee -y
```

## Submodules

- **wstack** (`wstack`) — the shared SDK / webhook layer that Commerce Wallee is
  built on. Enable it as part of the integration:

  ```bash
  drush en wstack -y
  ```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm **Wallee** appears as a plugin. Then continue with
[Configuration](../configuration/index.md).
