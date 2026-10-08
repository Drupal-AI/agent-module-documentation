<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & log management

## Settings — `commerce_stripe_webhook_event.settings`

There is no dedicated settings form (the `configure` link goes to the parent
`commerce_stripe.settings`); edit the config object directly.

| Key | Default | Meaning |
|---|---|---|
| `retention_time` | `2592000` | Seconds to keep **processed** webhook events before they expire (30 days). |
| `queue` | `false` | If true, process events asynchronously via AdvancedQueue instead of synchronously. |

```bash
drush config:get commerce_stripe_webhook_event.settings
drush config:set commerce_stripe_webhook_event.settings queue 1 -y
drush config:set commerce_stripe_webhook_event.settings retention_time 86400 -y
```

## Overview & purge UI

- **Overview:** `/admin/commerce/config/stripe-webhook-events`
  (route `commerce_stripe_webhook_event.overview`, permission `view commerce stripe webhook event`).
  A Views-driven list with a Stripe event-type filter; each row links to a details page
  (`…/{webhook_event_id}`).
- **Purge processed events:** `/admin/commerce/config/stripe-webhook-events/confirm`
  (route `commerce_stripe_webhook_event.confirm`, permission `purge commerce stripe webhook event`).

## Data model & processing

Events are rows in the `commerce_stripe_webhook_event` **database table** (not a config/content
entity), written by `WebhookEvent::insert($request, $event, $signature)`. Status constants on
`WebhookEvent`: `STATUS_UNPROCESSED = 0`, `STATUS_SUCCEEDED = 1`, `STATUS_FAILED = 2`,
`STATUS_SKIPPED = 3`. When `queue` is enabled, jobs run through the AdvancedQueue job type
`commerce_stripe_webhook_event` (queue worker `commerce_stripe_webhook_event_processor`);
otherwise `WebhookEvent::process()` runs synchronously during the webhook request.
