<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Wise (commerce_wise) — agent index

A **Drupal Commerce offsite payment gateway for Wise Quick Pay**
(`https://wise.com/p/business/quickpay`). At checkout the shopper is redirected (GET) to
a Wise Quick Pay payment link; Wise then notifies the store of the deposit through a
webhook, which the module maps back to the order and records a payment. info.yml name:
**Commerce Wise** — "Provides Commerce integration for Wise." Package `Commerce (contrib)`.
Core `^10 || ^11`. License GPL-2.0-or-later. Installed as **1.0.0** (version dir `1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`** and
  **`commerce:commerce_order`** (both required).
- Composer (`composer.json`): `drupal/core ^10 || ^11`, `drupal/commerce ^3`. No PHP
  libraries, no HTTP-client SDK.

## What it provides (from source)

- **One payment gateway plugin** — `wise_quick_pay` (label "Wise Quick Pay", display
  label "Wise"), `src/Plugin/Commerce/PaymentGateway/QuickPay.php`. Uses the PHP
  attribute `#[CommercePaymentGateway]`, extends `OffsitePaymentGatewayBase`, implements
  `QuickPayInterface`, `payment_type: payment_default`, `requires_billing_information: FALSE`.
- **Offsite redirect form** — `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php`
  (`offsite-payment` form), a `buildRedirectForm(..., 'get')` to the Wise Quick Pay URL.
- **Two alter events** — `src/Event/WiseEvents.php`:
  - `commerce_wise.quick_pay_link` (`QuickPayLinkEvent`, carries order, reference, balance
    `Price`) — alter the redirect reference/amount before the link is built.
  - `commerce_wise.quick_pay_reference` (`QuickPayReferenceEvent`, carries reference and
    optional order) — alter how an incoming webhook's `transfer_reference` maps to a local
    order.
- **No** `.install`, `.module`, `routing.yml`, `services.yml`, `.permissions.yml`,
  `config/` schema, templates, or JS. It defines no routes or permissions of its own; the
  webhook endpoint `/payment/notify/{commerce_payment_gateway}` is provided by
  `commerce_payment`.

## Configuration (gateway form)

From `defaultConfiguration()` / `buildConfigurationForm()` (`QuickPay.php`):

- **`wise_tag`** (textfield, required) — the Wise business account @tag used in the pay link.
- **`public_key`** (textarea, required) — Wise's public key used to verify webhook
  signatures (copied from Wise's event-handling docs; sandbox vs production).
- **`account_type`** (select, required) — only option is `business`.
- **`logging`** (checkbox) — log webhook event bodies to the `commerce_wise` logger channel.
- **`mode`** — inherited test/live from the Commerce gateway base; selects the Wise host
  (`live` → `https://wise.com`, `test` → `https://sandbox.transferwise.tech`, from
  `QuickPayInterface::WISE_API_URL`).

## Payment flow (from source)

1. **Redirect** — `generateQuickPayUrl()` dispatches `QuickPayLinkEvent`, then builds
   `{host}/pay/business/{wise_tag}?amount={total}&currency={code}&description={reference}`
   (reference = order id by default). `PaymentOffsiteForm` submits it as a GET redirect.
2. **Notify** — `onNotify(Request)` reads the raw body, calls `verifyWebhookSignature()`
   (RSA-SHA256 `openssl_verify` of the `X-Signature-SHA256` header against the configured
   `public_key`), optionally logs the body, JSON-decodes it, and for
   `event_type === 'balances#update'` with a numeric `transfer_reference` dispatches
   `QuickPayReferenceEvent`, loads the order by that reference, calls `createPayment()`
   (records a `completed` `commerce_payment` with `remote_id = data.balance_id`), then
   `applyTransitionById('place')`, `unlock()`, `save()` on the order.

## Solution docs

- Setup and gateway configuration → [../usage.md](../usage.md) and the human guide under
  [../human-docs/](../human-docs/index.md).
