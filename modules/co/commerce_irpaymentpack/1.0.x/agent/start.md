<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Iranian Payment Pack (commerce_irpaymentpack) — agent index

A **bundle of seven Iranian bank / PSP payment gateways for Drupal Commerce**,
each implemented as a standard **off-site redirect** payment gateway plugin. The
shopper is redirected to the bank's hosted page to pay and returns to the store,
where the module confirms the transaction **server-side against the bank's
verify/advice API** before completing the Commerce payment. Package
`Commerce (contrib)`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Installed
version **1.0.0-beta3** (version dir `1.0.x`). Configured through the standard
Commerce payment-gateway UI (`configure: commerce_payment.configuration`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`** and
  **`commerce:commerce_payment`**.
- No `composer.json` ships in the module. One gateway (Pasargad) additionally
  needs the **`pepco-api/php-rest-sdk`** PHP package (class `\Pasargad\Pasargad`);
  its config form and redirect form both hard-block if the class is missing.
- No custom `*.routing.yml`, `*.services.yml`, or `*.permissions.yml`, and no
  `config/` install/schema beyond the plugin config that Commerce manages — the
  return/verify routes are inherited from Commerce's `OffsitePaymentGatewayBase`.

## The seven gateways (from source)

Each is a `@CommercePaymentGateway` plugin under
`src/Plugin/Commerce/PaymentGateway/` extending `OffsitePaymentGatewayBase`, paired
with an off-site redirect form under `src/PluginForm/OffsiteRedirect/`. Several
also have a low-level API client under `src/Banks/`. All use payment method type
`credit_card`.

| Gateway (plugin id) | Class / bank client | Verify transport | Server-side verify call |
|---|---|---|---|
| `commerce_irpaymentpack_zarinpal` (Zarinpal) | `ZarinpalGateway` + `Banks/Zarinpal` | REST/JSON over cURL | `payment/verify.json` (v4) |
| `commerce_irpaymentpack_zibal` (Zibal) | `ZibalGateway` + `Banks/Zibal` | REST/JSON over cURL | `gateway.zibal.ir/v1/verify` |
| `commerce_irpaymentpack_mellat` (Mellat Bank) | `MellatGateway` + `Banks/MellatBank` | SOAP (`\SoapClient`) | `bpVerifyRequest` (+`bpInquiryRequest`/`bpReversalRequest` fallback) |
| `commerce_irpaymentpack_melli` (Melli / Sadad) | `MelliGateway` + `Banks/MelliBank` | REST/JSON over cURL | `sadad.shaparak.ir/api/v0/Advice/Verify` |
| `commerce_irpaymentpack_saman` (Saman / SEP) | `SamanGateway` | SOAP (`\SoapClient`) | `VerifyTransaction` (referencepayment.asmx) |
| `commerce_irpaymentpack_pasargad` (Pasargad) | `PasargadGateway` + `\Pasargad\Pasargad` SDK | SDK (REST) | `checkTransaction()` then `verifyPayment()` |
| `commerce_irpaymentpack_saderat` (Saderat / Sepehr) | `SaderatGateway` | REST/JSON over cURL | `sepehr.shaparak.ir/V1/PeymentApi/Advice` |

Zarinpal and Zibal expose test/live **modes**; the other five declare
`modes = {"Live"}` only. Zibal is the only plugin that injects services
(`ContainerFactoryPluginInterface`, logger factory); the rest call `\Drupal::`
statics.

## Per-gateway configuration fields

Stored on the `commerce_payment_gateway` config entity via each plugin's
`buildConfigurationForm`/`submitConfigurationForm`:

- **Zarinpal** — `zarinapl_merchant_code` (Merchant Code). Uses Commerce mode for
  sandbox.
- **Zibal** — `zibal_merchant_key` (Merchant Key; `zibal` for testing).
- **Mellat** — `mellat_terminal_id`, `mellat_username`, `mellat_password`,
  `mellat_order_base_id` (added to the shop order id to form the bank's
  forever-unique order id).
- **Melli (Sadad)** — `melli_merchant_id`, `melli_terminal_id`,
  `melli_terminal_key` (labeled "KEEP SECURE"; used as the DES-EDE3 signing key),
  `melli_order_base_id`.
- **Saman** — `saman_merchant_code`.
- **Pasargad** — `pasargad_merchant_code`, `pasargad_terminal_code`,
  `pasargad_certificate_file` (a `managed_file` uploaded to
  `private://commerce_irpaymentpack`, `.xml` only, made permanent),
  `pasargad_order_base_id`.
- **Saderat** — `saderat_terminal_id`, `saderat_order_base_id`.

## Payment flow (common shape)

1. **Redirect out** — the off-site `*Redirect` form reads the order total from the
   `commerce_payment` entity, normalizes the currency (IRR/TMN → Rial or Toman as
   the bank expects), requests a payment token/authority from the bank, creates a
   `commerce_payment` in state **`authorization`** (storing the bank reference in
   `remote_state`), and auto-POSTs (or GETs, for Melli) the shopper to the bank's
   hosted page.
2. **Return** — the gateway plugin's `onReturn()` reloads the pending
   `authorization` payment for the order, then calls the bank's **verify/advice
   API server-side** to confirm the transaction. Only on a successful verify does
   it set the payment to `completed` and store the bank reference as the remote id.
   A non-OK bank status or verify failure throws `PaymentGatewayException` /
   `InvalidRequestException`.

Currency handling: Zarinpal works in **Toman** (divides IRR by 10); Mellat, Melli,
Pasargad, Saderat and Zibal work in **Rial** (multiply TMN by 10).

### Saman's same-site return helper

`saman-redirect.php` is a **standalone script the admin manually copies beside
`index.php`**. Saman POSTs `ResNum`/`RefNum`/`State` back; because SameSite cookie
rules can drop the session on a cross-site POST, this same-origin page re-POSTs
those fields to the Commerce return URL. It restricts the `return` target to the
current host (rejecting off-host/non-http(s) URLs) and HTML-escapes every echoed
value.

## Security posture (positive)

- Every gateway **re-verifies the transaction server-side** with the bank's
  authoritative verify/advice endpoint after the shopper returns; the payment is
  moved to `completed` only when that call succeeds, never on the browser return
  parameters alone.
- **Zarinpal** sends the order amount into the verify call, so the bank binds the
  amount to the authority; a re-verified/already-used authority returns a non-100
  code and is rejected. **Saderat** compares the bank-reported paid amount to the
  order amount before completing. **Pasargad** sets the order amount on
  `verifyPayment()`. **Mellat** and **Melli** use a forever-unique per-order id
  (base id + order id) that the bank ties to the amount at request time.
- **Mellat** loads the pending payment by matching the returned `RefId` to the
  `remote_state` recorded at request time, and its verify has an inquiry +
  automatic reversal fallback so an unverifiable charge is reversed.
- **Melli** requires the verify `ResCode` key to be present (not just loosely
  equal to 0) before treating the result as success, and signs the request with a
  DES-EDE3 signature over terminal/order/amount.
- Bank **verify/advice REST and SOAP calls use HTTPS with peer and host
  certificate verification enabled** (`CURLOPT_SSL_VERIFYPEER = TRUE`,
  `CURLOPT_SSL_VERIFYHOST = 2`).
- No custom routes or permissions are added; the return endpoint is the standard
  Commerce off-site return route scoped to the order.
- Treat every bank credential (merchant/terminal id, username, password, terminal
  key, certificate file) as a **secret**: they are stored in the gateway config
  entity, so keep them out of committed/exported config (prefer environment-backed
  configuration) and restrict who holds *administer payment gateways*.

## Related docs

- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md)
- Semantic overview: [`../usage.md`](../usage.md)
