# Installation

## Requirements

KeyCRM builds on Drupal Commerce, so you need:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with its **Product** and **Order** components — the module
  depends on `commerce`, `commerce_product`, and `commerce_order`.
- A **KeyCRM account** and a valid **API token** with permission to create
  leads/orders in KeyCRM.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/keycrm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Drupal Commerce
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keycrm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keycrm -y
```

Enabling KeyCRM will also enable the Commerce modules it depends on if they are
not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → KeyCRM**
(`/admin/config/services/keycrm`). If the settings form loads, the module is
installed. Continue to [Configuration](../configuration/index.md) to enter your
API token — until you do, orders will not be sent to KeyCRM.
