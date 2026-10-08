# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** 2.4+ or 3 (`drupal/commerce: ^2.4 || ^3`). Specifically
  Commerce's **Price** module (`commerce_price`), which Drupal enables as a
  dependency.
- For the remote providers that need one, an **API key or account** with the
  rate provider (Fixer, Currencylayer, Open Exchange Rates). ECB and TransferWise
  do not require a key.

There are no additional third-party Composer packages beyond Commerce itself.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_exchanger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed (including Commerce, if it pulls in an update).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_exchanger -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_exchanger -y
```

Enabling the module does nothing on its own until you create at least one
exchange-rate source. Head to [Configuration](../configuration/index.md) to set
one up.

## Permission

Commerce Exchanger adds the permission **Administer commerce exchanger
settings** (`administer commerce exchanger settings`), which controls access to
the Exchange rates configuration and the manual "Run import" action. Grant it to
store administrators at **People → Permissions**.

## A note on API keys and secrets

The remote providers that need credentials (Fixer, Currencylayer, Open Exchange
Rates) take an API key you enter in the provider's configuration. Treat that key
as a secret: don't commit it to version control in a plain config export. Follow
your project's convention for secrets — store the value in an environment
variable and inject it, rather than hard-coding it into committed configuration.

This module ships no submodules.
