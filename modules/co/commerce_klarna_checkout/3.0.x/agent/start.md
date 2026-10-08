<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_klarna_checkout — agent start

Integrates **Klarna Checkout** (Klarna's *hosted* checkout, rebranded **Kustom Checkout** on the
3.x branch) with **Drupal Commerce**. This is the full hosted-checkout product — an HTML snippet
from Klarna is embedded in the payment step and collects payment + customer details. It is a
different project from `commerce_klarna` and `commerce_klarna_payments`.

Ships a single **offsite payment gateway plugin** (`klarna_checkout`), not a new plugin type.
Depends on `commerce:commerce_payment`; requires the `centarro/kco_rest` (`^5`) PHP client and
`commerce` `^2.37 || ^3`. Core `^10.3 || ^11`. Version **3.0.0**. Optional integration with
`commerce_shipping` (dev-suggested) for per-tax-rate shipment splitting.

There is **no dedicated settings route** — the gateway is created/edited on Commerce's own
Payment gateways admin at `/admin/commerce/config/payment-gateways` (permission
`administer commerce_payment_gateway`). No routes, permissions, hooks, or `.install` are defined
by this module; the only YAML is services + config schema.

## How money is confirmed (posture)

Order/payment state is bound to the **authenticated Klarna order** re-fetched from Klarna's API,
not to request-supplied data. On the push callback the module loads the Klarna order over the
authenticated connector and creates the Commerce payment from Klarna's own
`order_amount`/`purchase_currency`, binding to the Commerce order via the Klarna
`merchant_reference2`. Acknowledgement is idempotent (`loadByRemoteId`). Payment amounts on
capture/refund are computed server-side from Commerce prices.

## Subdocs

- **Gateway plugin: config fields, transaction modes, capture/void/refund** → [payment-gateway.md](payment-gateway.md)
- **Checkout lifecycle: offsite form, push/return/validation callbacks, confirmation pane** → [checkout-flow.md](checkout-flow.md)
- **Extension points: events, request builder, shipment price splitter** → [events.md](events.md)

## Key classes

| Concern | Class |
| --- | --- |
| Gateway plugin | `Plugin/Commerce/PaymentGateway/KlarnaCheckout` |
| Offsite redirect form (renders Klarna snippet) | `PluginForm/OffsiteRedirect/KlarnaCheckoutForm` |
| "complete" step snippet | `Plugin/Commerce/CheckoutPane/KlarnaCheckoutConfirmation` |
| Klarna API calls (kco_rest wrapper) | `KlarnaManager` (built by `KlarnaManagerFactory`, service `commerce_klarna_checkout.manager_factory`) |
| Validation push handler | `CallbackHandler` |
| Builds the Klarna order request from a Commerce order | `RequestBuilder` |
| Per-tax-rate shipment amount splitting (needs commerce_shipping) | `ShipmentPriceSplitter` (registered only if commerce_shipping is present, via `CommerceKlarnaCheckoutServiceProvider`) |
| Address/total sync + total-match check | `EventSubscriber/KlarnaEventSubscriber` |
| Cancel Klarna order on Commerce order cancel | `EventSubscriber/OrderSubscriber` |

## Limitation for evals

Live Klarna/Kustom calls need real credentials and outbound network. In a sandbox you can create
and introspect the gateway **config entity** (`commerce_payment.commerce_payment_gateway.*` with
plugin id `klarna_checkout` + its settings) but cannot complete a real transaction.
