# Installation

## Requirements

- **Drupal 10.3 or newer** for the 2.0.x series
  (`core_version_requirement: ^10.3 || ^11`). (If you need Drupal 8/9/10, the
  older 1.1.x series covers those.)
- **Drupal Commerce** with **Commerce Payment** enabled (`commerce_payment`).
- A **CardPointe / CardConnect (Clover Connect) merchant account** with API
  credentials. For card‑present payments you'll also need a **Clover Flex**
  terminal.

The module should be installed **via Composer** — the zip files on the project
page are for reference only. There are no third‑party PHP library requirements
beyond what Composer resolves.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cardpointe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_cardpointe -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cardpointe -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**, click
**Add payment gateway**, and confirm the **CardPointe** plugin(s) — the Hosted
iFrame and Terminal gateways — appear in the list. Then continue to
[Configuration](../configuration/index.md).
