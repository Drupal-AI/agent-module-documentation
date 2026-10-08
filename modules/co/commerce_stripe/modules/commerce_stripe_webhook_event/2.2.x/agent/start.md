<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stripe Webhook Events — agent index

Submodule of Commerce Stripe. Logs every incoming Stripe webhook to the
`commerce_stripe_webhook_event` DB table so events can be reviewed, audited, purged, and
optionally reprocessed. Requires `commerce_stripe`; queue processing needs `advancedqueue`.

Key facts:
- Overview UI: `/admin/commerce/config/stripe-webhook-events` (route `commerce_stripe_webhook_event.overview`); details + purge-confirm routes alongside.
- Config object `commerce_stripe_webhook_event.settings`: `retention_time` (default 2592000s), `queue` (bool).
- Async processing (when `queue: true`): AdvancedQueue job type `commerce_stripe_webhook_event`, queue worker `commerce_stripe_webhook_event_processor`.
- Statuses: 0 unprocessed, 1 succeeded, 2 failed, 3 skipped (`WebhookEvent` constants).
- `configure` link points back to the parent `commerce_stripe.settings` form.

- **Settings (retention, queue) + overview/purge** → [configure/settings.md](configure/settings.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
