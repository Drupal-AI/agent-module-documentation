# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.x**.
- [**Webhook Receiver**](https://www.drupal.org/project/webhook_receiver) — specifically
  its `webhook_receiver_defer` submodule, which provides the deferred webhook transport
  and (importantly) the authentication for inbound webhooks. Composer pulls it in as a
  dependency.
- Outbound HTTPS access from your web server to `https://www.eventbriteapi.com`.
- An Eventbrite account with a **private token** and the **organization ID** for each
  account you want to sync (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/eventbrite_one_way_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the Webhook
Receiver dependency at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eventbrite_one_way_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eventbrite_one_way_sync -y
```

Drupal enables Webhook Receiver (`webhook_receiver_defer`) automatically as a
dependency.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Eventbrite One-Way Sync Node** | `eventbrite_one_way_sync_node` | Maps synced Eventbrite events onto Drupal nodes via a configurable field mapper. Requires core's **Datetime Range** (`datetime_range`) for storing event start/end. |

Enable it only if you want events to become nodes:

```bash
drush en eventbrite_one_way_sync_node -y
```

## Verify it worked

Run the module's built-in `hook_requirements` check (visible on the **Status report**,
`/admin/reports/status`) to confirm your tokens and dependencies are in place, then run
the built-in smoke test to verify connectivity to Eventbrite. Continue to
[Configuration](../configuration/index.md) to add your tokens and set up the webhook.
