<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Payeezy provides Payeezy (First Data) payment gateway plugins for Drupal Commerce.

---

Commerce Payeezy integrates **Payeezy (First Data / Global Gateway e4)** with Drupal Commerce,
supplying two `commerce_payment_gateway` plugins: a **hosted (off-site) gateway**
(`commerce_payeezy_hosted_gateway`), where the shopper is redirected to Payeezy's hosted pay page and
POSTed back, and an **on-site gateway** (`commerce_payeezy_onsite_gateway`), where the card is entered
on your own checkout and tokenized against Payeezy (TransArmor) so only a token plus the card's
`last4`/type/expiry are stored locally. It depends on Commerce, Commerce Payment and Commerce Order.

Each gateway is configured as a payment-gateway config entity holding its credentials and Commerce
`mode` (`test`/`live`). The **hosted** gateway takes `x_login`, `transaction_key`, `x_response_key`,
`transaction_url` and an `hmac_calculation` choice (MD5 or SHA-1); its checkout form builds a
signed POST redirect (`x_fp_hash = hash_hmac(algo, x_login^x_fp_sequence^x_fp_timestamp^x_amount^x_currency_code, transaction_key)`)
and its return handler recomputes the response hash from `x_response_key`/`x_login`/`x_trans_id`/`x_amount`
and, on a match, records an authorization payment for the **server-side order total**
(`$order->getTotalPrice()`), so the recorded amount is never taken from the shopper. The **on-site**
gateway takes `api_key`, `api_secret_key`, `merchant_token`, `transaction_url`, `ta_token`, `token_type`
and `security_token_url`; it tokenizes the card, then supports purchase, capture, void and refund via
Payeezy's transactions API using HMAC-SHA256 request authentication over Drupal's HTTP client. There are
no custom routes, permissions, Drush commands or services — all configuration lives in the
`commerce_payment_gateway` config entity.

Use it to accept Payeezy card payments. Add a gateway at
`/admin/commerce/config/payment-gateways`, choose the hosted or on-site Payeezy plugin, enter your
Payeezy developer-account credentials and `transaction_url`, pick Test or Live mode, and attach it to
your checkout flow. Keep the credentials (`transaction_key`, `x_response_key`, `api_secret_key`,
`merchant_token`) out of version control — store them via your environment and restrict who can
administer payment gateways.

---

- Provide Payeezy (First Data) payment gateway plugins for Drupal Commerce.
- Offer a hosted (off-site) gateway and an on-site gateway.
- Configure each gateway as a `commerce_payment_gateway` config entity.
- Enter Payeezy credentials from a developer account.
- Tokenize cards on the on-site gateway (store only a token + last4/type/expiry).
- Support purchase, capture, void and refund on the on-site gateway.
- Sign the hosted redirect with an HMAC of the server-side amount.
- Record the hosted payment amount from the server-side order total.
- Authenticate on-site API requests with HMAC-SHA256 over Drupal's HTTP client.
- Depend on Commerce, Commerce Payment and Commerce Order.
- Have no custom routes, permissions, Drush or services.
- Store credentials as secrets, out of version control.
- Restrict who can administer payment gateways.
- Add the gateway at /admin/commerce/config/payment-gateways.
- Set Test or Live mode.
- Attach the gateway to a checkout flow.
- Process Payeezy card payments.
