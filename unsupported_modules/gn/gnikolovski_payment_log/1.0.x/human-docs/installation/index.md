# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (enabled by default on a standard install) to build the
  screen that displays the log.
- In practice, **Drupal Commerce** and a payment gateway module that calls this
  module's logging service — Payment Log is designed to be fed by gateway
  integrations rather than used on its own.

There are no third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gnikolovski_payment_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gnikolovski_payment_log -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gnikolovski_payment_log -y
```

## Verify it worked

1. Go to **People → Permissions** and confirm the **View payment logs** permission
   is present — assign it to trusted staff only.
2. In the Views UI (**Structure → Views**) confirm you can build a view over the
   payment-log data. Once a gateway integration starts calling the logging
   service, rows will appear there.
