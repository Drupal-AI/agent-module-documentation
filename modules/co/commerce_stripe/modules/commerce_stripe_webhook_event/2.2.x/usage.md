<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Stripe Webhook Events records every incoming Stripe webhook into a database log so you can review, audit, and (optionally) reprocess them, with configurable retention and optional queue-based processing.

---

This submodule of Commerce Stripe adds a webhook-event log. When the `stripe_payment_element` gateway receives a webhook, `WebhookEvent::insert()` writes a row (event id, type, payload, Stripe signature, and a processing status) to the `commerce_stripe_webhook_event` database table; `WebhookEvent::process()`/`updateStatus()` then mark it `STATUS_SUCCEEDED` (1), `STATUS_FAILED` (2), `STATUS_SKIPPED` (3) or leave it `STATUS_UNPROCESSED` (0). An admin overview at `/admin/commerce/config/stripe-webhook-events` lists events (with a Views-based UI and a type filter), each with a details page, plus a purge-processed-events confirm form. Behaviour is controlled by the tiny `commerce_stripe_webhook_event.settings` config object: `retention_time` (seconds to keep processed events, default 2592000 = 30 days) and `queue` (when true, events are processed asynchronously through the AdvancedQueue job type `commerce_stripe_webhook_event` / queue worker `commerce_stripe_webhook_event_processor` instead of synchronously). Two restricted permissions gate viewing and purging. It requires `commerce_stripe`; queue processing additionally needs `drupal/advancedqueue`. Its `configure` link points back to the main Commerce Stripe settings form.

---

- Keep an auditable log of every Stripe webhook the site receives.
- Review a specific webhook event's payload and processing status on its details page.
- Filter the webhook-event overview by Stripe event type.
- See which webhook events failed, succeeded, were skipped, or are still unprocessed.
- Purge already-processed webhook events to keep the log table small.
- Configure how long processed events are retained (`retention_time`).
- Process webhook events asynchronously via AdvancedQueue by enabling the `queue` setting.
- Process webhook events synchronously (default) by leaving `queue` disabled.
- Debug payment issues by inspecting the raw Stripe event that triggered them.
- Confirm a webhook was actually delivered and verified (signature stored with the row).
- Grant support staff read-only access with `view commerce stripe webhook event`.
- Restrict destructive purging to admins with `purge commerce stripe webhook event`.
- Reprocess an unprocessed event through the AdvancedQueue job type.
- Retain a compliance trail of payment webhooks for a fixed window.
- Automatically expire old processed events after the retention window.
- Investigate a refund/dispute by locating its originating Stripe event in the log.
- Verify webhook processing throughput by watching the queue drain.
