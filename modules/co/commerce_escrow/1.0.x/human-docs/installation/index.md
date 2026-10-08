# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce Core 3**, with the **Payment** and **Order** modules — the
  module depends on `commerce_payment` and `commerce_order`.
- **Commerce Product** (`commerce_product`) — see the important note below.
- An **Escrow.com** account (or developer access) for the account you will
  configure.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_escrow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_escrow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Because the shipped version (1.0.2) references a **Commerce Product** class in a
hook without declaring it as a dependency, enable `commerce_product` **alongside**
Commerce Escrow, or the site will fatal:

```bash
drush en commerce_escrow commerce_product -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. If the Escrow (Escrow Pay / Escrow Offer) plugins appear
in the list, the module is installed correctly. Continue to
[Configuration](../configuration/index.md).
