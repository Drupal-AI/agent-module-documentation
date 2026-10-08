# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Mollie PHP API** client library, pulled in automatically by Composer.
- A **Mollie account** — you enter its API key during configuration. Sign up at
  [mollie.com](https://www.mollie.com/) and copy your test and live keys from the
  Mollie dashboard.

There are no other contributed-module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/mollie_donations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Mollie PHP
API library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mollie_donations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mollie_donations -y
```

## Verify it worked

Log in as an administrator and open
**`/admin/config/services/mollie_donations`**. You should see the donation
settings form where you enter your API key and amounts. Continue with
[Configuration](../configuration/index.md) to finish setup and publish the form.
