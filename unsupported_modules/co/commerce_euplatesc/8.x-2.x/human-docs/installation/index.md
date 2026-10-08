# Installation

## Requirements

- **Drupal 10.3 or 11.1** (`core_version_requirement: ^10.3 || ^11.1`).
- **Drupal Commerce** with the **Payment** module — the module depends on
  `commerce` and `commerce_payment`, enabled automatically as dependencies.
- A **EuPlatesc.ro** merchant account, which supplies your merchant id and secret
  key.

There are no additional PHP libraries or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_euplatesc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_euplatesc -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_euplatesc -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If **EuPlatesc Checkout** appears in the list of plugins,
the module is installed correctly. Continue to
[Configuration](../configuration/index.md).
