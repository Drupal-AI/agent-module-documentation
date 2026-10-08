# Installation

## Requirements

- **Drupal 8.8, 9 or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **Drupal Commerce** with the **Payment** module — the module depends on
  `commerce` and `commerce_payment`, enabled automatically as dependencies.
- A **Eurobank / Modirum vPOS** merchant agreement, which supplies your merchant
  id, the vPOS post URL and your shared secret.

There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_eurobank_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_eurobank_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_eurobank_redirect -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **Eurobank Payment Redirect** appears in the list of
plugins, the module is installed correctly. Continue to
[Configuration](../configuration/index.md).

> **Note on testing:** Eurobank does not accept test credit cards the way some
> other banks do, so test against Eurobank's own test vPOS endpoint before going
> live.
