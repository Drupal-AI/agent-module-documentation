<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Konnect — agent index

Off-site Drupal Commerce payment gateway for **Konnect** (konnect.network), a
Tunisian PSP. The shopper is redirected to Konnect's hosted page (bank cards,
E-Dinar, Flouci) and returns; the order is completed after a server-side,
authenticated re-fetch of the transaction.

- **Version** 1.1.0. **Package** `Commerce (Tunisia)`.
- **Core** `^9.4 || ^10 || ^11` (from `commerce_konnect.info.yml`).
- **Dependencies** `commerce:commerce_payment`, `commerce:commerce_order`
  (Drupal Commerce 2.x per README).
- **License** GPL-2.0-or-later. Not covered by Drupal's security advisory policy;
  created 2026-01.

## What ships (only two PHP classes)

- `src/Plugin/Commerce/PaymentGateway/Konnect.php` — the
  `@CommercePaymentGateway(id = "konnect")` plugin, extends
  `OffsitePaymentGatewayBase`. Declares `payment_method_types = {"credit_card"}`
  and credit-card types amex/dinersclub/discover/jcb/maestro/mastercard/visa.
  Provides the offsite form, config form, `onReturn()`, and the shared
  `apiCall()` HTTP helper.
- `src/PluginForm/KonnectPaymentForm.php` — the `offsite-payment` plugin form
  (`PaymentOffsiteForm`) that creates the remote payment and redirects the buyer.

There is **no** routing.yml, services.yml, permissions.yml, config schema,
`.module`, `.install`, or `composer.json` in this release.

## Configuration (gateway plugin settings)

Set on the Commerce payment-gateway entity
(`/admin/commerce/config/payment-gateways`). Keys and defaults from
`defaultConfiguration()`:

| Key | Type | Notes |
| --- | --- | --- |
| `api_key` | textfield (required) | Konnect API key; used as Basic-auth username. |
| `api_secret` | textfield (required) | Konnect API secret; Basic-auth password. Store via env/Key. |
| `api_url` | select (required) | Fixed options only: Live `https://api.konnect.network/api/v2` or Sandbox `https://api.preprod.konnect.network/api/v2`. |
| `receiver_wallet_id` | textfield (required) | Konnect wallet that receives funds. |
| `send_email` | checkbox (default TRUE) | Let Konnect send the payment receipt. |
| `webhook_url` | textfield (optional) | Forwarded to Konnect as `webhookUrl` at payment creation. |

## Payment flow

1. **Create (redirect out).** `KonnectPaymentForm::buildConfigurationForm()`
   builds a `POST /payments` body — `receiverWalletId`, `amount`
   (`$payment->getAmount()->getMinorUnits()`, TND millimes = 3 decimals),
   `currency`, `orderId => $order->id()`, buyer name/email from the billing
   profile, `acceptedPaymentMethods` (`balance`, `bank_card`, `wallet`),
   `successUrl`/`failUrl` from the checkout return/cancel URLs, and optional
   `webhookUrl` — then calls `Konnect::apiCall('POST', '/payments', $data)` and
   redirects to `$response['payment_url']`.
2. **Return (completion).** `Konnect::onReturn()` reads `payment_id` from the
   query, then **re-fetches the transaction server-side** with
   `apiCall('GET', '/payments/'.$payment_id)` (HTTP Basic auth). It binds the
   result to this order (`response.orderId` must equal the order id), completes
   only when the API status is exactly `CAPTURED`, records a `commerce_payment`
   with `remote_id => response.id`, and **dedups by `remote_id`** so a repeated
   return is idempotent. Amount recorded is the order's own total.
3. **`apiCall($method, $endpoint, $data)`** — shared Guzzle helper: builds
   `api_url . $endpoint`, sends JSON body when present, sets
   `auth => [api_key, api_secret]` (Basic), returns the decoded JSON array. TLS
   verification is left at Guzzle's secure default.

## Security posture (positive)

Completion truth comes from Konnect's authenticated API, not the request: the
return re-fetches `GET /payments/{id}` with Basic auth, requires
`response.orderId === order.id` (rejects ID switching), completes only on strict
`status === 'CAPTURED'`, and is idempotent on `remote_id`. The API host is a fixed
two-option select (no free-text endpoint). Store the Konnect API key/secret in an
environment variable / Key entity — never commit them or paste the raw secret into
config that is exported to VCS.

## See also

- `../usage.md` — task-oriented summary.
- `../human-docs/` — UI setup guide for site builders.
