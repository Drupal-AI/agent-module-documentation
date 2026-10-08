# Commerce Payment Extra — manual setup guide

**Commerce Payment Extra** (`commerce_payment_extra`) adds a small automation layer on top of Drupal
Commerce payments. The base module is mostly plumbing for developers: it provides a service that works out
which of an order's payments can be **captured** or **voided**, override points for that logic, and two
background jobs (run through **Advanced Queue**) that actually perform a capture or void through the payment
gateway. Payments still flow through Commerce's normal payment handling and access rules — this module drives
that machinery rather than replacing it, and it has no access-control role of its own.

The features people actually turn on live in its submodule, **`commerce_payment_extra_order`**
("Synchronize orders"). Once enabled and configured, it can:

- **Capture** an order's payments automatically when the order is moved to *completed* (fulfilled).
- **Void** an order's payments automatically when the order is *canceled*.
- **Automatically place** draft orders that are already authorized in full but whose customer never returned
  to finish checkout (a cron/Drush job).

All three are **off by default** on a fresh install — you switch them on from the submodule's settings page.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module and the
   `commerce_payment_extra_order` submodule.

## Configuration and where it lives in the admin menu

The **base** module has no settings page — it only exposes the service, events, and jobs. The
**`commerce_payment_extra_order` submodule** adds a settings form at
**Commerce → Configuration → Payment → Payment Extra**
(`/admin/commerce/config/payment/extra-order`, requires the *Administer payment gateways* permission). There
you enable auto-capture on completion, auto-void on cancellation, and the cron auto-placement of authorized
orders (choosing which payment gateways qualify and the time window to look in).

Because the capture/void work is queued rather than run inline, the submodule adds an Advanced Queue queue,
`commerce_payment_extra_order`. Process it on cron or manually:

```bash
drush advancedqueue:queue:process commerce_payment_extra_order
```

You can inspect queued items at
`/admin/config/system/queues/jobs/commerce_payment_extra_order`.

This guide is written for a **human** clicking through the admin UI. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.
