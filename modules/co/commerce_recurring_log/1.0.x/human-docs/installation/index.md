# Installation

## Requirements

- **Drupal 9.2, 10, 11, or 12** (`core_version_requirement: ^9.2 || ^10 || ^11 ||
  ^12`).
- **Commerce Recurring** (`commerce_recurring`) — the subscription framework whose
  events are logged.
- **Commerce Log** (`commerce_log`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite, which provides
  the underlying logging system.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_recurring_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_recurring_log -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_recurring_log -y
```

That's all — logging begins automatically for all subscriptions, with no further
configuration.

## Verify it worked

Open a subscription's **admin page** and confirm a **Subscription activity**
section is present. Once a subscription event occurs (for example a state change
or price change), it should be recorded there.
