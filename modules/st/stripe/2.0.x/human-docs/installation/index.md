# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The official **`stripe/stripe-php`** SDK (any of versions `^7` through `^16`),
  installed automatically as a Composer dependency. Because of this library, you
  must install this module **with Composer** — a plain download won't work.
- A **Stripe account** with API keys (both test and live are available in the
  Stripe dashboard).
- No other Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/stripe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required `stripe/stripe-php` SDK and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stripe -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stripe -y
```

Enabling the module does nothing visible on its own — Stripe.js starts loading
site‑wide, but there's no payment until you enter API keys and add a payment
element to a form. Head to [Configuration](../configuration/index.md) to enter your
keys.

## Optional submodule — Stripe examples

The **Stripe examples** submodule (`stripe_examples`) ships a complete, working
demo: a simple checkout form, a checkout block, and an event subscriber that sets a
fixed payment total. It's the fastest way to see the pieces fit together, and a
good pattern to copy for your own forms.

```bash
drush en stripe_examples -y
```

It requires the base Stripe module (already present after the steps above). Treat
it as a learning/reference module rather than something to run in production.
