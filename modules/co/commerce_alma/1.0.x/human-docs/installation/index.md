# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Commerce Payment** (`commerce_payment`) from Drupal Commerce.
- An **Alma account** with a merchant API key.

This is a **beta** release (`1.0.0-beta1`) — test carefully before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_alma -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install shared
dependencies, including the Alma SDK the module relies on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_alma -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_alma -y
```

## Store your Alma API key as a secret

Your Alma **API key** is a secret and must never be committed to version control.
With DDEV, save it as an environment variable and expose it through a Key entity:

```bash
ddev dotenv set .ddev/.env --alma-api-key=<value>
ddev restart
```

Then create a Key entity (install the Key module first if needed with
`ddev composer require drupal/key && ddev drush en key -y`) using the env provider
and reference it from the gateway configuration.

## Make sure cron runs

Alma captures depend on a cron job that revisits authorized payments to capture
them. Confirm Drupal cron runs regularly (a real system cron is best for a
production store) so payments finalise reliably.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to add the Alma gateway. In
**test** mode, place an order, complete the Alma redirect flow, and confirm the
payment moves to captured after the module fetches the authoritative state from
Alma (and cron runs).
