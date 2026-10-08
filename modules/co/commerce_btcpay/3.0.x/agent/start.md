<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce BTCPay (commerce_btcpay) — agent index

A **Drupal Commerce off-site payment gateway for BTCPay Server** — accept Bitcoin, Lightning
Network, and altcoin payments through a self-hosted (or hosted) BTCPay Server using its
**Greenfield API**. Off-site redirect flow: Commerce creates a BTCPay invoice, redirects the buyer
to the BTCPay checkout, and settles the payment from **server-authoritative** invoice state.
Depends on `commerce_checkout`, `commerce_payment`. Package `Commerce`. Core `^10 || ^11`. License
GPL-2.0-or-later. Installed as **3.0.0-alpha2** (version dir `3.0.x`).

3.x is a breaking rewrite onto the Greenfield API (1.x/2.x used the legacy BitPay-compatible API and
must be uninstalled first).

## Dependencies

- Drupal modules: **`commerce:commerce_checkout`**, **`commerce:commerce_payment`** (`.info.yml`).
- PHP: **`btcpayserver/btcpayserver-greenfield-php` `^2.8`**, plus PHP extensions **`ext-bcmath`**
  and **`ext-openssl`** (`composer.json`). `hook_requirements()` blocks install if the Greenfield
  client class is absent.

## What it provides (from source)

- **Payment gateway plugin** `btcpay_redirect` (`Plugin/Commerce/PaymentGateway/BtcPayRedirect`,
  extends `OffsitePaymentGatewayBase`), live-only (`modes = {live}`, the mode field is hidden),
  `requires_billing_information = FALSE`. Off-site form
  `PluginForm/BtcPayRedirectForm` creates the invoice and redirects (GET) to `checkoutLink`.
- **Routes** (`.routing.yml`): `commerce_btcpay.notify` (POST `/payment/notify/{gateway}`, the
  Commerce IPN endpoint → `onNotify`); `commerce_btcpay.api_key_authorize`
  (POST, CSRF + `administer commerce_payment_gateway`, begins authorization);
  `commerce_btcpay.api_key_callback` (public POST, receives the BTCPay redirect and stages an
  encrypted key candidate only); `commerce_btcpay.api_key_confirm` (admin form that verifies and
  saves).
- **Services** (`.services.yml`): `secret_encryptor` (AES-256-GCM, `Security/SecretEncryptor`),
  `credential_storage` (encrypted, non-exportable key/value), `authorization_state` (one-time
  expirable state), `server_url_policy` (HTTPS enforcement), `api_key_verifier`,
  `webhook_event_storage` (idempotency/ordering), `api_key_manager`, logger channel.
- **Config schema** (`btcpay_redirect`): `server_url`, `store_id`, `webhook_id`, `send_buyer_email`,
  `debug_mode` — **no secrets in config**. API key + webhook secret live only in encrypted key/value
  storage. Two update hooks (`8001`, `8002`) migrate legacy secrets out of exported config;
  `hook_uninstall` wipes all key/value stores; `hook_entity_delete` purges credentials on gateway
  delete.
- **JS library** `api_key_redirect` (`js/api-key-redirect.js`) drives the "Generate API Key" button.
- **Unit tests** for URL policy, secret encryptor, invoice binding, invoice status, webhook payload,
  webhook event storage, API-key permissions, authorization state.
- No module-defined permissions (uses core `administer commerce_payment_gateway`); no Drush commands.

## Solution docs

- **Off-site payment flow — invoice creation, redirect, `onReturn`, `onNotify` webhook, invoice
  binding, invoice→payment-state mapping** → [gateway/payment-flow.md](gateway/payment-flow.md)
- **Configuration form, API-key authorization flow, credential encryption, HTTPS server-URL policy**
  → [config/authorization.md](config/authorization.md)
