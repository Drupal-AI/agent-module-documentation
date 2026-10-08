<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Rave (commerce_rave) — agent index

**Off-site Drupal Commerce payment gateway for Flutterwave "Rave" (card/mobile-money, Africa): render the Rave inline/hosted checkout at the payment step, then verify the transaction server-side against Rave's API on return.**

- **Version:** 2.0.x
- **Core:** `^9 || ^10 || ^11`
- **Requires:** `commerce:commerce_payment` (Drupal Commerce). `composer.json` pins `drupal/commerce_payment:^3`. No non-Drupal PHP libraries.
- **Provides:** one payment-gateway plugin, no routes/services/permissions/hooks/`.install`.

## Architecture
- **Gateway plugin** `rave` — `src/Plugin/Commerce/PaymentGateway/Rave.php`, class `Rave extends OffsitePaymentGatewayBase implements RaveInterface`.
  - `payment_method_types = {"credit_card"}`; `modes = {staging, live}`; off-site form `offsite-payment => PaymentOffsiteForm`.
  - Config keys (`defaultConfiguration`): `public_key`, `secret_key`, `payment_flow` (`iframe` | `hosted_payment_page`), `pay_button_text`, `txref_prefix` (default `rave`). Schema: `config/schema/commerce_rave.schema.yml` (config type id `plugin.rave_iframe`).
  - Endpoints: live `https://api.ravepay.co`, staging `http://flw-pms-dev.eu-west-1.elasticbeanstalk.com` (legacy Rave v3 host; see [payment/verification.md](payment/verification.md)).
- **Off-site form** — `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php`, class `PaymentOffsiteForm extends BasePaymentOffsiteForm`. Builds the Rave payload (public key, amount, customer email/name from the billing profile, `txref = {txref_prefix}-{orderId}`, currency, country, `redirect_url = #return_url`), computes the Rave sha256 `integrity_hash` (sorted payload values + secret key, `calculateChecksum`), and hands the payload to the inline JS via `drupalSettings.rave.transactionData`.
- **Client JS** — `js/commerce_rave.form.js` auto-submits the checkout form and calls Rave's `getpaidSetup()` (from `flwpbf-inline.js`, loaded per mode in `commerce_rave.libraries.yml`) to open the iframe/hosted checkout.

## Payment flow
1. **Checkout (off-site build):** `PaymentOffsiteForm::buildConfigurationForm` assembles the payload and attaches the mode-specific Rave inline library; the JS opens the Rave iframe or redirects to the hosted payment page.
2. **Return:** `Rave::onReturn(OrderInterface $order, Request $request)` reads Rave's `resp` param, extracts `flwRef`, and calls `verifyTransaction($flwRef)` — a **server-side authenticated POST** to `/flwv3-pug/getpaidx/api/verify` sending the merchant secret key (`SECKEY`).
3. **Bind + record:** on a verified `status=success` / `data.status=successful` result, it compares the verified `charged_amount` to the order total and, on a match, creates a `commerce_payment` in state `authorization` with `remote_id = flw_ref`, `remote_state = status`.

## Security posture (positive)
- Completion is driven by an **authenticated server-side verify call** to Flutterwave (secret key required), not by the browser redirect's own status — see [payment/verification.md](payment/verification.md).
- The verified **charged amount is compared to the order total** before any payment is recorded.
- **No inbound webhook/IPN route** and no custom routing: verification is pull-based, so there is no unauthenticated callback surface. (`RaveInterface` marks a webhook as a future `@todo`.)
- Live mode uses HTTPS (`api.ravepay.co`); Guzzle TLS verification is left at its secure default.

## Subdocs
- [configure/gateway.md](configure/gateway.md) — add and configure the gateway, keys, payment flow, modes.
- [payment/verification.md](payment/verification.md) — the return/verify flow in detail.
