# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- **Commerce Payment** (`commerce_payment`) from Drupal Commerce.
- An **Affirm account** — a sandbox account for testing
  (`https://sandbox.affirm.com/business/`) and a production account to go live
  (`https://www.affirm.com/business/`), each providing public and private API
  keys.

There are no extra PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_affirm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_affirm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_affirm -y
```

## Store your Affirm keys as secrets

Your Affirm **public** and **private** API keys are secrets. Keep them out of
exported configuration and version control. With DDEV, save them as environment
variables and expose them through Key entities:

```bash
ddev dotenv set .ddev/.env --affirm-public-key=<value> --affirm-private-key=<value>
ddev restart
```

Then create Key entities (install the Key module first if needed with
`ddev composer require drupal/key && ddev drush en key -y`) using the env provider
and reference them from the configuration instead of pasting the raw values.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to enter your keys, set the
mode to **sandbox**, and add the Affirm payment gateway. Then place a test order
and confirm the Affirm financing flow completes and the charge is captured against
your Affirm sandbox account.
