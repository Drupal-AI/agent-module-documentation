# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** module enabled — this is the
  only dependency. Drupal will pull in what it needs when you enable the module.
- A **Payrexx account**. You will need your Payrexx *instance name* and an *API
  secret* from the Payrexx admin panel. (One way to find your instance name: it
  is the first part of the URL you log in at — for example the `instancename` in
  `https://instancename.payrexx.com/`.)

The module also uses the official **Payrexx PHP SDK** (`payrexx/payrexx ^1.7`) and
requires **PHP 8.1+**; Composer pulls the SDK in for you automatically. Drupal
Commerce itself is required as `drupal/commerce ^3.0`.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payrexx_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_payrexx_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payrexx_integration -y
```

You can also enable it from the **Extend** page in the admin UI.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
If **Payrexx (Redirect to Payrexx)** appears in the list of plugins, the module
is installed correctly. Continue to [Configuration](../configuration/index.md) to
finish the setup.
