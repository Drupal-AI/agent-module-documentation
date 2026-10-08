# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) enabled.
- **Advanced Queue** (`drupal/advancedqueue`) — required by Composer and used to run the capture/void jobs.
  Composer pulls it in automatically.

The `commerce_payment_extra_order` submodule additionally depends on Commerce's **Order** module
(`commerce_order`), which is already present in any Commerce store. There are no third-party PHP libraries or
special extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payment_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Advanced Queue and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/commerce_payment_extra -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payment_extra -y
```

You can also enable it from **Extend** (`/admin/modules`). The base module on its own only exposes an API
(a service, events, and queue job types) — enable the submodule below to get the order automations most
sites want.

## Submodules

Commerce Payment Extra ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce Payment Extra - Synchronize orders** | `commerce_payment_extra_order` | Auto-capture on order completion, auto-void on cancellation, cron/Drush auto-placement of fully-authorized draft orders, and the settings form to configure them. |

Enable it the same way:

```bash
drush en commerce_payment_extra_order -y
```

## Configure and process the queue

After enabling the submodule, visit its settings at
**`/admin/commerce/config/payment/extra-order`** (requires the *Administer payment gateways* permission) and
turn on the automations you want — everything is off by default.

The capture/void work is queued, so schedule the queue processor (on cron, or run it manually):

```bash
drush advancedqueue:queue:process commerce_payment_extra_order
```

## Verify it worked

Confirm both modules are enabled on **Extend** (`/admin/modules`). Then, with the submodule's options turned
on, exercise the behavior — for example move an order with an authorized payment to *completed* and confirm a
capture job is queued (and captured once the queue is processed), or to *canceled* to confirm a void job is
queued. Queued items are visible at `/admin/config/system/queues/jobs/commerce_payment_extra_order`.
