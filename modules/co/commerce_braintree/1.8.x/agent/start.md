# Commerce Braintree — agent index

On-site Drupal Commerce payment gateway for Braintree (cards, PayPal, PayPal Credit) with optional
3-D Secure 2. Uses the `braintree/braintree_php` SDK; cards are tokenized in-browser into a nonce. No
module settings page (`configure` null) — all config is on the payment-gateway entity. No permissions,
no Drush. Requires `commerce_payment`.

- **Configure the `braintree_hostedfields` gateway, keys, currencies, 3DS, the 3DS checkout pane** →
  [configure/gateway.md](configure/gateway.md)
- **Extend the transaction: the `commerce_braintree.transaction_data` event** →
  [api/events.md](api/events.md)

Key facts:
- Gateway plugin id `braintree_hostedfields` (`HostedFields extends OnsitePaymentGatewayBase`),
  payment method types `credit_card`, `paypal`, `paypal_credit`.
- Config keys (schema `commerce_payment.commerce_payment_gateway.plugin.braintree_hostedfields`):
  `merchant_id`, `public_key`, `private_key`, `merchant_account_id` (per-currency map), `3d_secure`
  (`''`|`enabled`|`required`), `enable_credit_card_icons`.
- 3DS: checkout pane `braintree_3ds_review` on the `review` step.
- Braintree JS loaded from `js.braintreegateway.com` (v3.92.1) with SRI integrity hashes.
- **No webhook/IPN route exists in this branch** — nothing to verify signatures on.
