Commerce Authorize.net integrates Authorize.Net with Drupal Commerce, providing payment gateway plugins (Accept.js credit cards, Accept Hosted, eCheck, and legacy Visa Checkout) that let a Commerce store take card and eCheck payments through an Authorize.Net merchant account.

---

The module supplies Commerce **payment gateway plugins**, each configured as a
`commerce_payment_gateway` config entity: `authorizenet_acceptjs` (on-site credit cards via
the Accept.js JS tokenizer — the primary/recommended gateway), `authorizenet_accept_hosted`
(off-site/hosted card form in an iframe), `authorizenet_echeck` (ACH/eCheck, a manual payment
method type `authnet_echeck`), and `authorizenet_visa_checkout` (legacy, deprecated). Every
gateway shares three credential settings — **`api_login`** (API Login ID), **`transaction_key`**,
and **`client_key`** (public client key) — plus a Commerce **mode** of `test` (sandbox) or
`live`; Accept.js adds `enable_credit_card_icons`, Accept Hosted adds `captcha_security` and
`card_code_required`, and Visa Checkout adds `visa_checkout_api_key` (see the config schema in
`config/schema/commerce_authnet.schema.yml`). Accept.js defines its own payment workflow
`payment_acceptjs` (`commerce_authnet.workflows.yml`) with states for authorization, review,
decline, capture, void, expire and refund, supporting authorize-only and authorize-and-capture,
plus fraud "needs review" handling. The gateway plugins talk to Authorize.Net through the
`commerceguys/authnet` PHP library; a route serves the Accept Hosted iframe communicator, an
`EcheckTransactionVerifier` service polls eCheck settlement status, and six dispatched events
(`AuthorizeNetEvents`) let you alter transaction requests and hosted-payment/payment-profile
data. Setup is code/UI-light: add a payment gateway at
`/admin/commerce/config/payment-gateways`, pick an Authorize.net plugin, enter the API
credentials and mode. **The module has no `configure` route, no permissions, and no Drush of
its own; live charges require a real Authorize.Net account, so all configuration/state lives in
the `commerce_payment_gateway` config entity.**

---

- Accept on-site credit card payments in a Commerce store via Authorize.Net Accept.js.
- Offer an off-site hosted card form (Accept Hosted) rendered in a secure iframe.
- Take ACH/eCheck (bank account) payments through Authorize.Net eCheck.
- Configure a sandbox (test mode) gateway against an Authorize.Net developer account.
- Switch a gateway from test to live once credentials are verified.
- Store API Login ID, Transaction Key, and Client Key on the payment gateway config entity.
- Run authorize-only transactions and capture them later from the order admin.
- Run authorize-and-capture in a single checkout step.
- Void an authorization before it settles.
- Refund or partially refund a completed Authorize.Net payment.
- Route fraud-flagged transactions into a "needs review" state for manual approve/decline.
- Require the card security code (CVV) on the hosted payment form.
- Enable CAPTCHA security on the Accept Hosted form.
- Show credit card brand icons on the Accept.js checkout pane.
- Reuse stored payment methods (customer payment profiles) for returning buyers.
- Verify eCheck settlement status asynchronously via the transaction verifier service.
- Customize the outgoing Authorize.Net transaction request via a CREATE/REFUND/VOID event subscriber.
- Alter hosted payment page settings (button, return options) via the hosted-payment-settings event.
- Add or modify customer payment profile data via the payment-profile events.
- Restrict accepted card types (Visa/MasterCard by default; Amex/Discover need Authorize.Net approval).
- Deploy the gateway configuration across environments as exported Commerce config.
- Integrate Authorize.Net payment into a multi-step Commerce checkout flow.
- Migrate a legacy Visa Checkout gateway configuration (deprecated) onto Accept.js.
- Provide a manual eCheck payment method type (`authnet_echeck`) alongside credit cards.
