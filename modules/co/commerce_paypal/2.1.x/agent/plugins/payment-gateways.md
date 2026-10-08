<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateway plugins

commerce_paypal does **not** define its own plugin types. It provides five
`commerce_payment_gateway` plugins (Commerce's plugin type, managed by
`plugin.manager.commerce_payment_gateway`). Each is declared with a
`#[CommercePaymentGateway]` / `@CommercePaymentGateway` annotation in
`src/Plugin/Commerce/PaymentGateway/` and becomes selectable when you add a Payment gateway
in Commerce.

## The five plugin ids

| Plugin id | Class | Label | Status | Off-site? |
|---|---|---|---|---|
| `paypal_checkout` | `Checkout` | PayPal Checkout (Preferred) | **Preferred / active** | Smart Payment Buttons (on-site JS + PayPal popup) |
| `paypal_fastlane` | `Fastlane` | Fastlane by PayPal (Preferred) | **Preferred / active** | On-site branded card form |
| `paypal_express_checkout` | `ExpressCheckout` | PayPal - Express Checkout (Legacy-Deprecated) | Legacy | Off-site redirect |
| `paypal_payflow` | `Payflow` | PayPal - Payflow (Legacy) | Legacy | On-site (credit_card) |
| `paypal_payflow_link` | `PayflowLink` | PayPal - Payflow Link (Legacy) | Legacy | Off-site / iframe |

All five declare `modes = { "test" = Sandbox, "live" = Live }`, so the gateway's `mode`
key is `test` or `live`.

## Per-plugin configuration keys

The gateway config entity stores base keys (`display_label`, `mode`, `payment_method_types`,
`collect_billing_information`) under `configuration`, plus these plugin-specific keys (see
`config/schema/commerce_paypal.schema.yml`):

- **`paypal_checkout`** — `payment_solution` (default `smart_payment_buttons`), **`client_id`**,
  **`secret`** (REST app credentials), `intent` (`capture` | `authorize`), `disable_funding[]`,
  `disable_card[]`, `shipping_preference` (default `get_from_file`), `update_billing_profile`,
  `update_shipping_profile`, `style{}`, `enable_on_cart`, `webhook_id`,
  `enable_webhook_request_logging`, `enable_credit_card_icons`, `payment_selection_display{}`.
- **`paypal_fastlane`** — **`client_id`**, **`secret`**, `intent`, `allowed_brands[]`,
  `update_billing_profile`, `update_shipping_profile`, `webhook_id`, `styles{}`.
- **`paypal_express_checkout`** — **`api_username`**, **`api_password`**, **`signature`**,
  `shipping_prompt`, `solution_type`. (Legacy NVP/SOAP API.)
- **`paypal_payflow`** — **`partner`**, **`vendor`**, **`user`**, **`password`**.
- **`paypal_payflow_link`** — `partner`, `vendor`, `user`, `password`, `trxtype`,
  `redirect_mode`, `reference_transactions`, `emailcustomer`, `log{request,response}`,
  `cancel_link`.

## How registration works

1. Enabling the module makes the plugins discoverable (annotation-based discovery — no
   `*.info.yml` entry per gateway).
2. An admin adds a Payment gateway at `/admin/commerce/config/payment-gateways/add`, picks
   one of the plugins above, and enters `mode` + credentials. This writes a
   `commerce_payment.commerce_payment_gateway.<machine_id>` config entity whose `plugin`
   property is the plugin id and whose `configuration` array holds the values above.
3. `paypal_checkout` and `paypal_fastlane` also ship optional checkout flows
   (`config/optional/commerce_checkout.commerce_checkout_flow.paypal_checkout.yml`,
   `…paypal_fastlane.yml`) and their own checkout panes / payment method types
   (`paypal_checkout`, `paypal_fastlane`).

See [../configure/gateways.md](../configure/gateways.md) to create one via Drush/PHP.
