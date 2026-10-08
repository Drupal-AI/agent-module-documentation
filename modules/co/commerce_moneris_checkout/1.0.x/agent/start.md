<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Moneris Checkout (commerce_moneris_checkout) — agent index

A Drupal Commerce **offsite payment gateway** for **Moneris Checkout (MCO)** — Moneris's hosted,
iframe-embedded card checkout (Canada / US). The card form is served inside a Moneris iframe on the
Commerce *Payment* step; card data never touches Drupal (PCI: SAQ-A style). Package **Commerce
(contrib)**. Depends on **`commerce:commerce_payment`** (Drupal Commerce Payment) and the Composer
library **`smmccabe/moneris`**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **The gateway plugin, config fields, ticket preload + receipt confirmation flow** →
  [gateway.md](gateway.md)
- **The three dispatched events (extension points)** → [events.md](events.md)

## What it actually is

- One payment gateway plugin: `MonerisCheckout` (id **`moneris_checkout`**, label *"Moneris
  Checkout"*), in `src/Plugin/Commerce/PaymentGateway/MonerisCheckout.php`, extending Commerce's
  `OffsitePaymentGatewayBase`. `payment_method_types = {"credit_card"}`; card types amex/discover/
  jcb/mastercard/visa; `requires_billing_information = FALSE`. Modes: **`qa`** ("Testing") and
  **`prod`** ("Production").
- One offsite plugin form: `MonerisCheckoutForm` (`src/PluginForm/MonerisCheckoutForm.php`), which
  performs the Moneris **preload** call to obtain a ticket and renders the iframe placeholder.
- Interface `MonerisCheckoutInterface`; response-constant classes `MonerisCheckoutResponseCodes`
  (`001` success, `902`, `2001`–`2003`) and `MonerisCheckoutResponseStates` (`complete`, `cancel`,
  `error`).
- Three events under `src/Event/` + `MonerisCheckoutEvents` constants.
- Theme hook `commerce_moneris_checkout` (`templates/commerce-moneris-checkout.html.twig`), JS
  behavior (`js/commerce_moneris_checkout.js`), and libraries `moneris_checkout` (local) plus
  `moneris_checkout_qa` / `moneris_checkout_prod` (remote Moneris `chkt_v2.00.js`).
- Provides **no routes, no permissions, no Drush, no plugin types, no install hooks** of its own.
  It rides Commerce's offsite return/cancel routes (`commerce_payment.checkout.return` /
  `.cancel`). Provides config schema for the gateway plugin (`config/schema/`).

## Payment flow (from source)

1. **Preload / ticket** — `MonerisCheckoutForm::getTicket()` POSTs `action=preload` (store_id,
   api_token, checkout_id, `txn_total` = server-side order amount, order_no, cart, contact/
   shipping/billing details) to `<gateway>/chktv2/request/request.php` via Guzzle. The returned
   **ticket** + `order_no` are stored on the order as `moneris_checkout` data and reused if the
   step is revisited.
2. **Iframe** — the ticket is passed to `drupalSettings`; `js/commerce_moneris_checkout.js` boots
   Moneris's `monerisCheckout()` widget, which renders the card form and on completion redirects
   the browser to Commerce's return/cancel URL with `?ticket&response_code&response_state`.
3. **Confirmation** — `MonerisCheckout::onReturn()` requires ticket/response_code/response_state,
   requires `response_code === '001'` (strict), then calls **`getReceipt($ticket)`** — an
   **authenticated server-to-Moneris `action=receipt` call** — requires `success === 'true'` and
   `receipt.result === 'a'` (approved, else `HardDeclineException`), and **binds the receipt's
   `order_no` to the order's stored MCO `order_no`** before creating the `commerce_payment`. The
   payment **amount is `$order->getBalance()` (server-side)**; `remote_id` = receipt
   `reference_no`. Confirmation is authenticated against Moneris, not read from the returning
   request. TLS verification is on (default Guzzle); the request URL is a hardcoded per-mode
   constant (no SSRF surface). See [gateway.md](gateway.md).
