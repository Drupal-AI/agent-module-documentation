# Installation

## Requirements

- **Drupal 9, 10.1+, or 11** (`core_version_requirement: ^9 || ^10.1 || ^11`).
- **Drupal Commerce** version 2 or 3 (`drupal/commerce: ^2.0 || ^3.0`), with its
  **Checkout** submodule (`commerce_checkout`) enabled — this is the dependency
  the module declares.
- A working **mail transport**. The module sends through Commerce's mail handler,
  which uses Drupal's mail system — for reliable delivery, pair it with a real
  transport such as SMTP or Symfony Mailer.
- **Cron running on a real schedule.** Reminders are sent only during cron, so a
  site whose cron never runs will never send.

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_abandoned_carts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in Drupal Commerce if it isn't already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_abandoned_carts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_abandoned_carts -y
```

Grant the administration permission to whoever will manage it:

```bash
drush role:perm:add administrator 'administer commerce abandoned carts'
```

There are **no submodules**. Remember that the module ships with **test mode on**,
so no customer receives anything until you configure it and turn test mode off —
see [Configuration](../configuration/index.md).
