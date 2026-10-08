<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce GoCardless Client (commerce_gc_client) — agent index

Drupal Commerce integration for **GoCardless** — bank payments via Direct Debit mandates
(BACS/SEPA/ACH/etc.) plus open-banking **Instant Payments**. Provides an offsite payment
gateway `gocardless_client`, checkout redirect via GoCardless Billing Request Flows, a
signed-webhook receiver, cron-driven recurring/one-off payment creation, GoCardless
subscriptions, optional recurring child orders, and customer self-service mandate
management. Version **2.1.6**. Core `^10 || ^11`. License GPL-2.0-or-later. Package
Commerce (contrib). Version dir `2.1.x`.

## Architecture note (unusual "partner" model)

The site does **not** hold a GoCardless API token. `GoCardlessPartner` (service
`commerce_gc_client.gocardless_partner`) authenticates with a generated username/password to
the **Seamless-CMS partner site** (`partner_url`, default `https://seamless-cms.co.uk`) and
that site proxies all GoCardless API calls. "Connecting" runs an OAuth-style onboarding
against the partner. Webhooks, by contrast, are delivered **directly by GoCardless** and are
HMAC-SHA256 verified locally against a per-mode webhook secret. Bank debits are asynchronous:
an order is not settled at checkout — payment state is reconciled by the webhook receiver.

## Dependencies

- Drupal modules (`.info.yml`): `commerce_payment`, `commerce_product`, `commerce_cart`,
  `commerce_checkout` (all from the `commerce` project). Optional integration:
  `commerce_shipping`, `commerce_log`, Commerce Currency Resolver / Exchanger.
- No external PHP libraries (`composer.json` has no runtime `require` beyond Drupal).
- Requires a configured **private:// files** directory (secrets storage) and HTTPS
  (self-signed allowed in sandbox via `$settings['commerce_gc_client_skip_ssl_verification']`).

## What it provides (from source)

- **Payment gateway** `gocardless_client` (`Plugin/Commerce/PaymentGateway/GoCardlessClient`,
  offsite, modes sandbox/live) with offsite form `PluginForm/PaymentOffsiteForm`. See
  [gateway/checkout.md](gateway/checkout.md).
- **Webhook receiver** `Controller/WebhookHandler` at `/gc_client/webhook`. See
  [webhook/webhook.md](webhook/webhook.md).
- **Recurring engine**: `hook_cron` (`commerce_gc_client.module`) creates scheduled one-off
  payments / retries subscriptions; static `processPayment`/`processSubscription`; optional
  recurring child orders. See [recurring/recurring-payments.md](recurring/recurring-payments.md).
- **Customer self-service**: mandate cancel / change (update payment account) / reinstate
  forms + `Controller/MandateChangeComplete`; admin `MandatePaymentsForm` on order view.
- **Recurrence rules** plugin type (`plugin.manager.commerce_gc_client.recurrence_rules`,
  `RecurrenceRulesPlugin` "standard"), per-product-variation settings, `RecurrenceRules`
  attribute, `GcMandateStatus` views field, `GoCardlessExchanger` Commerce Exchanger plugin.
- **Events** (`Event/GoCardlessEvents`): 8 dispatched events + 4 event subscribers. See
  [config/settings.md](config/settings.md#events).
- **Config, routes, schema, secret storage, permissions** →
  [config/settings.md](config/settings.md).
- **No `.permissions.yml`** (module defines no permissions; routes reuse core/Commerce
  permissions). Install creates `product_gocardless` product + `product_variation_gocardless`
  variation types and four DB tables (`commerce_gc_client`, `_item`, `_item_schedule`,
  `_variation`).

## Data model (hook_schema)

- `commerce_gc_client` — one row per mandate: `gcid`, `order_id`, `gc_mandate_id`,
  `gc_mandate_status`, `gc_mandate_scheme`, `created`, serialized `data`
  (billing_request_id, customer_id), `sandbox`.
- `commerce_gc_client_item` — per order item: `gcid`, `item_id`, `type` (P/S),
  `gc_subscription_id`, `gc_subscription_status`, `next_payment`.
- `commerce_gc_client_item_schedule` — scheduled adjustments/events.
- `commerce_gc_client_variation` — per-variation GoCardless recurrence config.

## Solution docs

- **Checkout, gateway config, connect/disconnect, onReturn** → [gateway/checkout.md](gateway/checkout.md)
- **Webhook signature + event processing** → [webhook/webhook.md](webhook/webhook.md)
- **Cron payments, subscriptions, recurring orders, mandate self-service** → [recurring/recurring-payments.md](recurring/recurring-payments.md)
- **Routes, config, schema, secret storage, events, partner service** → [config/settings.md](config/settings.md)
