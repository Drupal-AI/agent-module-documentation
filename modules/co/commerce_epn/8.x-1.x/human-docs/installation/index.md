# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (this is an on‑site gateway
  built on Commerce Payment). Use a current Commerce 2.x release.
- An **eProcessingNetwork (EPN)** merchant account (your account username and
  Restrict Key). A public test account is available for trying it out.
- Optionally, **Commerce Recurring** if you want recurring payments.

There are no additional PHP library requirements — transactions are posted with
Guzzle over HTTPS.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_epn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_epn -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_epn -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways** and click
**Add payment gateway**. Choose **eProcessingNetwork gateway** and save — out of
the box it is wired to EPN's **test** account, so you can place a test order
straight away. (The test gateway declines any transaction whose total ends in
"1" — e.g. $10.01 — which is a handy way to test a decline.) Then continue to
[Configuration](../configuration/index.md) to replace the test credentials with
your own before going live.
