<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment plugins provided

Commerce Stripe does not define new plugin *types*; it implements existing Commerce plugin
types (payment gateways, payment method types, a checkout pane).

## Payment gateway plugins (`@CommercePaymentGateway`)

| id | Label | Base | payment_method_types |
|---|---|---|---|
| `stripe_payment_element` | Stripe Payment Element | `OffsitePaymentGatewayBase` | `stripe_card` (recommended) |
| `stripe` | Stripe Card Element (legacy) | `OnsitePaymentGatewayBase` | `credit_card` |

## Payment method type plugins (`@CommercePaymentMethodType`)

Local payment methods a Payment Element gateway can offer:

| id | Label |
|---|---|
| `stripe_card` | Card |
| `stripe_affirm` | Affirm (Preview) |
| `stripe_klarna` | Klarna (Preview) |
| `stripe_paypal` | Stripe PayPal |
| `stripe_cashapp` | Cash App (Preview) |
| `stripe_us_bank_account` | ACH Direct Debit |
| `stripe_alipay` | Alipay |
| `stripe_wechat_pay` | WeChat Pay |
| `stripe_link` | Link |
| `stripe_amazon_pay` | Amazon Pay (Preview) |

All extend `StripePaymentMethodTypeBase` and implement `StripePaymentMethodTypeInterface`
(`buildLabel()`, logos, etc.).

## Checkout pane

- `stripe_review` (`@CommerceCheckoutPane`) — the Stripe review pane; config
  `button_id`, `auto_submit_review_form`, `setup_future_usage`
  (schema `commerce_checkout.commerce_checkout_pane.stripe_review`).
