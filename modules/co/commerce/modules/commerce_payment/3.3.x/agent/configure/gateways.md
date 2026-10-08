# Payment configuration

- `commerce_payment_gateway` (config entity) — an instance of a gateway plugin with its
  credentials, **mode** (test/live), collect-billing setting and conditions. Manage at
  `/admin/commerce/config/payment-gateways` (`commerce_payment.configuration`).
- `commerce_payment` (content entity) — a recorded payment (amount, state, remote id)
  against an order.
- `commerce_payment_method` (content entity) — a reusable, tokenized customer instrument
  (e.g. saved card), owned by a customer and provided by a gateway.

Checkout: add the **Payment information** / **Payment process** panes to the checkout flow
(see commerce_checkout) — they collect or select a method and run the gateway.

## Permissions (`commerce_payment.permissions.yml` + dynamic)
- `administer commerce_payment_gateway` — manage gateways (restricted).
- `administer commerce_payment` / `manage commerce_payment` — manage recorded payments.
- Payment-method permissions are generated for managing own/any stored methods.

Concrete processor integrations (Stripe, Braintree, PayPal…) are separate contrib modules
providing gateway plugins; `commerce_payment_example` shows the API. Config schema:
`config/schema/commerce_payment.schema.yml`.
