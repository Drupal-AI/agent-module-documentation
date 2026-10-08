# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** — this is a hard requirement; older PHP versions generate
  errors.
- The contrib **Stripe** module, version **2.0 or newer** (`stripe`) — a hard
  dependency that handles the Stripe API calls and webhook signature verification.
- The **Webform** module, version **6.1 or newer**.
- A **Stripe account** with API keys and a webhook signing secret.

## Install with Composer

Installing with Composer is the recommended way, because it pulls in all
dependencies:

```bash
composer require drupal/stripe_webform_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Stripe and
Webform modules and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stripe_webform_payment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stripe_webform_payment -y
```

This enables the Stripe base module and Webform as well if they are not already
on.

## Verify it worked

Open the build page of any webform and add an element — a **Stripe payment**
element type should now be available. Before it can take a live payment, the
Stripe base module needs its API credentials and webhook signing secret
configured; see [Configuration](../configuration/index.md).
