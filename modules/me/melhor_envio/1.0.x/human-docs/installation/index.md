# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Drupal Commerce** with the **Commerce Shipping** module (`commerce_shipping`)
  installed and configured — this is the required dependency, and rate calculation
  only makes sense within a working Commerce checkout.
- A **Melhor Envio account** and **API credentials** (an access token) for the Melhor
  Envio API. Melhor Envio offers a sandbox environment for testing as well as
  production.

There are no PHP library requirements. Note the module is **not covered by Drupal's
security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/melhor_envio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Commerce Shipping
(and its own dependencies) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/melhor_envio -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en melhor_envio -y
```

Commerce Shipping is enabled automatically as a dependency if it is not already on.

## Verify it worked

Go to **Commerce → Configuration → Shipping → Shipping methods**
(`/admin/commerce/shipping-methods`) and click **Add shipping method**. In the plugin
selector you should now be able to choose **Melhor Envio**. If it is there, the
module is installed — continue with [Configuration](../configuration/index.md) to
enter your API credentials.
