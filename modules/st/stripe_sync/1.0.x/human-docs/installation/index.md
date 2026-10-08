# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Stripe** module (`stripe`) — a hard dependency. Stripe Sync relies
  on it for the Stripe client and, crucially, for verifying incoming webhook
  signatures before dispatching events.
- A **Stripe account** with API keys and a webhook signing secret.
- HTTPS in production, so Stripe callbacks and checkout redirects are secure.

## Install with Composer

From the project root:

```bash
composer require drupal/stripe_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Stripe base
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stripe_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stripe_sync -y
```

Enabling it also brings in the Stripe base module if it is not already on. Stripe
Sync auto-provisions the user fields it needs (customer id, subscription id,
status, expiry, checkout mode) at install time — you do not have to add those
fields by hand.

## Verify it worked

After enabling, confirm the Stripe base module has its API keys and webhook
signing secret configured (see [Configuration](../configuration/index.md)), then
check that the new Stripe fields appear on a user profile and that the admin user
search page is available. Because this module manages roles automatically, do the
first run on a test/staging environment before pointing it at production users.
