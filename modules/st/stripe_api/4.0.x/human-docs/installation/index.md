# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to store your Stripe secret
  key outside the database and outside exported configuration.
- You must manage your site with **Composer**, because the module pulls in the
  Stripe PHP library as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/stripe_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Stripe PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stripe_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

The Composer package name (`drupal/stripe_api`) matches the module's machine name
(`stripe_api`).

## Enable the module

```bash
drush en stripe_api -y
```

Drupal will enable the Key module at the same time if it is not already on.

## Store your Stripe secret key as a Key

Because the Stripe secret key is a credential, keep it out of the database and
out of version control. The recommended pattern is an environment variable read
through a Key entity:

1. Save the value into your environment. Under DDEV, for example:
   `ddev dotenv set .ddev/.env --stripe-secret-key=sk_live_…` then
   `ddev restart` (never commit `.ddev/.env`).
2. Create a Key entity that reads that environment variable, using Key's built-in
   "environment" provider.

You then select that Key on the Stripe API settings form — see
[Configuration](../configuration/index.md).

## Verify it worked

Enable the module, then visit **Configuration → Web services → Stripe API**
(`/admin/config/services/stripe_api`). If the settings form loads, the module and
its Stripe library are installed. Developers can confirm the client works by
injecting the `@stripe_api.stripe_api` service and calling `getStripeClient()`.
