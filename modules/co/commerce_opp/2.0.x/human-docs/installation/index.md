# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal Commerce with **Payment** (`commerce_payment`) enabled — the core
  dependency, enabled automatically.
- An **OPP / ACI PAY.ON merchant account** with API credentials (and, for webhooks,
  an encryption secret).
- **Advanced Queue** (`advancedqueue`) — only if you enable the webhooks submodule
  (see below). The base module does not need it.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_opp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_opp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_opp -y
```

Commerce Payment is enabled automatically as a dependency.

## Submodules

- **Commerce OPP Webhooks** (`commerce_opp_webhooks`) — handles asynchronous OPP
  payment notifications. It has a **soft dependency on Advanced Queue**
  (`advancedqueue`): the base module doesn't require it, but this submodule does, and
  it is *not* declared in the module's `composer.json`. Add Advanced Queue yourself
  before enabling the submodule:

  ```bash
  composer require drupal/advancedqueue -W
  drush en commerce_opp_webhooks -y
  ```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`). The plugin list should now include
**Open Payment Platform**. Configuring it — and the important encryption-secret step
if you use webhooks — is covered in [Configuration](../configuration/index.md).
