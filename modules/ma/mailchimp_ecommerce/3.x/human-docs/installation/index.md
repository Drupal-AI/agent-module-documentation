# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **Drupal Commerce** and its supporting modules — the module depends on
  `commerce`, `commerce_cart`, `commerce_checkout`, `commerce_order`,
  `commerce_price`, and `commerce_product`, plus `address`, `profile`, and
  `state_machine`. These come in with the Commerce package.
- The base **Mailchimp** module, which provides the API connection and the
  Mailchimp PHP library (v3.0.0 or higher on Drupal 8/9/10+).
- A **Mailchimp account and API key**.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_ecommerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Commerce, Address, Profile, State Machine, and Mailchimp dependencies as needed.
If you don't already have the base Mailchimp module, add it too:

```bash
composer require drupal/mailchimp -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_ecommerce -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_ecommerce -y
```

Dependencies (Commerce, Mailchimp, and the rest) are enabled automatically if they
aren't already.

## Verify it worked

First connect the base **Mailchimp** module to your account (see
[Configuration](../configuration/index.md)). Then place a test order in your store
and confirm the corresponding customer/order appears in your Mailchimp account's
e-commerce data.
