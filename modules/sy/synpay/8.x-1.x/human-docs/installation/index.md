# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- A merchant account and credentials with at least one of the supported gateways
  (Alfa, CloudPayments, PayKeeper, Robokassa, Sber, Sgb, Tinkoff, YooKassa, and
  their credit/installment variants).
- HTTPS on the site — payment callbacks and credentials should never travel over
  plain HTTP.
- No dependent Drupal modules, PHP extensions, or external Composer libraries are
  listed as required.
- Note that this module is **not covered by the security advisory policy**, and its
  issue queue is maintained in Russian.

## Install with Composer

From the project root:

```bash
composer require drupal/synpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synpay -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synpay -y
```

## Verify it worked

After enabling, open the settings form at the `synpay.settings` route and confirm
you can see the list of gateway providers. Set up the gateway you use in **test /
sandbox mode** first, run a test transaction end to end, and confirm the callback is
received and verified before you switch it to live. See
[Configuration](../configuration/index.md) for the gateway settings and the security
checks to perform.
