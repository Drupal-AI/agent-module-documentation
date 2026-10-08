# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Cart** (`commerce_cart`) enabled — it ships with Drupal Commerce.
- **Token** (`token`) — a contributed module that provides the tokens used to
  personalize the reminder emails; Composer pulls it in automatically.
- A working **outbound mail** configuration on your site (and, ideally, cron
  running on a schedule), since reminders are sent as email on a delay.

There are no third‑party Composer libraries or special PHP extensions required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_reminder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and any
other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cart_reminder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_reminder -y
```

## Verify it worked

Log in as an administrator and open
`/admin/config/commerce/cart-reminder/settings` — the reminder settings form
should load. Before sending anything to real customers, turn on **test mode** and
set a test address (see [Configuration](../configuration/index.md)), create a test
cart, and confirm a reminder email arrives at the test address with a working
restore link.

> **Note:** this module is not currently covered by Drupal's security advisory
> policy. Keep it updated and test changes on a staging site before deploying.
