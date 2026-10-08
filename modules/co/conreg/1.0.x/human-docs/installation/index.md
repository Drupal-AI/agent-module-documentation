# Installation

## Requirements

- **Drupal 11.2+ or 12** (`core_version_requirement: ^11.2 || ^12`).
- Three contrib module dependencies — **Key** (`drupal/key`), **Token**
  (`drupal/token`) and **Easy Email** (`drupal/easy_email`) — pulled in
  automatically by Composer.
- The **Stripe PHP library** (`stripe/stripe-php`), also installed via Composer —
  required to accept payments (install is blocked without it). You will then set up
  Stripe API keys (see [Configuration](../configuration/index.md)) before payments
  work.

This project is an early **beta** (`1.0.0-beta2`) and is **not covered by
Drupal's security advisory policy**. Treat it as work in progress and test
thoroughly before running a live event on it.

## Install with Composer

From the project root:

```bash
composer require drupal/conreg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will also bring in the Stripe PHP library that
ConReg requires.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conreg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conreg -y
```

## Verify it worked

After enabling, ConReg's registration and management functionality is available
and a default open event has been created for you, but it is **not yet ready to
take paid sign‑ups** — you still need to configure your event's membership types
and Stripe payment keys. Continue to [Configuration](../configuration/index.md)
for those post‑install steps.
