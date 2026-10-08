# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Basket** (Drupal AlternativeCommerce) store module — EtherAPI is a Basket
  payment method and needs Basket installed and set up as your store.
- An **etherapi.net** account, with an API key for each crypto currency you want to
  accept and a receiving wallet address.

## Install with Composer

From the project root:

```bash
composer require drupal/etherapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/etherapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en etherapi -y
```

Make sure the Basket store module is enabled as well.

## Verify it worked

Go to Basket's payment settings (**/admin/basket/settings-payment**). When creating
a payment point you should be able to choose **EtherAPI** as the service. After
creating it, you'll get a link through to the gateway's own settings page at
`/admin/config/development/etherapi`. Continue with
[Configuration](../configuration/index.md) to enter your API key(s) and wallet
address.
