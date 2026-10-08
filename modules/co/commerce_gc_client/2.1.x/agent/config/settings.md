<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, config, schema, secret storage & events

## Routes (`commerce_gc_client.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `commerce_gc_client.webhook` | `/gc_client/webhook` | `access content` (signature-authenticated) |
| `commerce_gc_client.connect_complete` | `/gc_client/connect_complete` | `configure store` |
| `commerce_gc_client.currencies` | `/admin/commerce/config/currencies/gocardless` | `configure store` |
| `commerce_gc_client.migrate_credentials` | `/admin/config/system/commerce-gc-client/migrate-credentials` | `administer site configuration` |
| `commerce_gc_client.mandate` | `/admin/commerce/orders/{commerce_order}/gocardless` | `administer commerce_order` |
| `commerce_gc_client.adjustment_action` | `/gc_client/adjustment_action/{action}/{order_id}/{sid}` | `administer commerce_order` |
| `commerce_gc_client.payment_cancel_form` | `.../{commerce_order}/gocardless/payment_cancel/{payment_id}` | `administer commerce_order` |
| `commerce_gc_client.mandate_cancel_form` / `_change_form` / `_reinstate_form` | `/user/{user}/orders/{commerce_order}/mandate_*/{view_mode}` | `_entity_access: commerce_order.view` + `view own commerce_order+administer commerce_order` |
| `commerce_gc_client.mandate_change_complete` / `_reinstate_complete` | `/user/{user}/orders/{commerce_order}/mandate_*_complete/{view_mode}` | same as above |
| `commerce_gc_client.product_variation.recurrence_rules` | `/product/{commerce_product}/variations/{commerce_product_variation}/edit/recurrence_rules` | `_entity_access: commerce_product.update` + custom access (variation type is GC-enabled) |

No `.permissions.yml` — the module defines no permissions of its own.

## Configuration

- **`commerce_gc_client.settings`** (config object, `config/schema`): `partner_url`
  (default `https://seamless-cms.co.uk`), `product_variation_types` (list of GC-enabled
  variation type ids), `partner_user_<mode>` / `partner_pass_<mode>` /
  `webhook_secret_<mode>` (legacy config slots, nulled after migration to private files),
  `currency_schemes` (per-currency `scheme`/`enabled`/`countries` — GBP/EUR/USD/SEK/AUD/NZD/
  DKK/CAD by default).
- **Per-gateway** config (`commerce_payment_gateway_configuration` schema for
  `gocardless_client`): `currencies`, `instant_payments`, `countries`, `payment_limit`,
  `email_warnings`, `log_webhook`, `log_api`.
- Install (`hook_install`) enables schemes matching store default currencies and creates the
  `product_gocardless` / `product_variation_gocardless` types. Also ships two `core.date_format`
  configs (`gocardless`, `gocardless_client`).

## Secret storage

Partner password and webhook secret are stored in `private://commerce_gc_client/` files
(`partner_user_<mode>`, `partner_pass_<mode>`, `webhook_secret_<mode>`) with restrictive
permissions, and cleared from config. Helpers in `.module`:
`commerce_gc_client_get_webhook_secret()`, `commerce_gc_client_save_webhook_secret()`,
`commerce_gc_client_check_private_directory()`, `commerce_gc_client_get_ssl_status()`.
`hook_requirements` reports a warning while secrets remain in config and links the migration
route; `hook_update_9201` / `Controller/CredentialsMigrateController` perform the migration.
All outbound Guzzle calls verify TLS unless
`$settings['commerce_gc_client_skip_ssl_verification']` is set (documented for sandbox).

## Events {#events}

Dispatched (`Event/GoCardlessEvents`), all alterable by subscribers:

- `MANDATE_DETAILS` (`commerce_gc_client_mandate_details`) — before mandate creation.
- `BILLING_REQUEST_FLOWS` (`…_billing_request_flows`) — before creating the checkout flow.
- `SHIPMENT` (`…_shipment`) — proportion an order's shipping cost to an item.
- `PAYMENT_DETAILS` / `PAYMENT_CREATED` / `PAYMENT_NEXT` — around payment creation & next-date.
- `SUBS_DETAILS` — before subscription creation.
- `WEBHOOK` — after processing each verified webhook event.

Bundled subscribers (`commerce_gc_client.services.yml`): `CartEventSubscriber`
(copies variation GC data onto the order item on add-to-cart), `ShipmentEventSubscriber`
(flat-rate shipping proportioning), `PaymentEventSubscriber` (filters the gateway by supported
currency at checkout), `GoCardlessEventSubscriber` (reacts to PAYMENT_DETAILS/PAYMENT_CREATED).

## Other services / plugins

- `commerce_gc_client.gocardless_partner` — `GoCardlessPartner` API client (session auth to
  partner site, GET/POST proxy, per-mode credentials).
- `plugin.manager.commerce_gc_client.recurrence_rules` — recurrence-rules plugin manager
  (plugin "standard" `RecurrenceRulesPlugin`, attribute `Attribute/RecurrenceRules`).
- `Plugin/Commerce/ExchangerProvider/GoCardlessExchanger` — Commerce Exchanger rate provider
  using GoCardless FX rates.
- `Plugin/views/field/GcMandateStatus` — views field for mandate status.
