# Commerce Authorize.net — manual setup guide

**Commerce Authorize.net** (`commerce_authnet`) connects a Drupal Commerce store
to an [Authorize.Net](https://www.authorize.net/) merchant account so you can take
real card and eCheck payments at checkout. It plugs into Commerce's payment system
as a set of **payment gateway** plugins — you add one, enter your Authorize.Net API
credentials, and your checkout flow can authorize, capture, void and refund
payments through Authorize.Net.

Four gateway types ship in the box. **Accept.js** (`authorizenet_acceptjs`) is the
recommended one: it collects the card on your own checkout page but tokenizes it in
the browser with Authorize.Net's JavaScript, so raw card numbers never touch your
server. **Accept Hosted** (`authorizenet_accept_hosted`) renders Authorize.Net's own
card form inside a secure iframe. **eCheck** (`authorizenet_echeck`) takes ACH /
bank-account payments. **Visa Checkout** (`authorizenet_visa_checkout`) is legacy and
deprecated — don't use it on new stores.

Every gateway shares three credentials — an **API Login ID**, a **Transaction Key**,
and a public **Client Key** — plus a **mode** switch between *test* (an Authorize.Net
sandbox/developer account) and *live*. Because the Transaction Key is a secret, this
guide shows how to keep it out of plain configuration. The Accept.js gateway also
defines a full payment workflow, so you can run authorize-only transactions and
capture them later, void authorizations before they settle, refund completed
payments, and route fraud-flagged transactions into a "needs review" state.

This guide is written for a **human** setting up the gateway through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Commerce and
   Authorize.Net library dependencies with Composer, then enable it.
2. [Configuration](configuration/index.md) — add a payment gateway, choose a plugin,
   enter your API credentials safely, and pick test or live mode.

## Where it lives in the admin menu

Commerce Authorize.net has **no settings page of its own**. Everything is configured
as a Commerce payment gateway at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Each gateway you add there is a
`commerce_payment_gateway` config entity that stores the plugin choice, credentials
and mode. Once a live gateway exists and is enabled, it appears as a payment option in
your store's checkout flow.
