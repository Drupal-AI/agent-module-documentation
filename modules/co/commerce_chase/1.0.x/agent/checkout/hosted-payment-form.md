<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hosted Payment Form checkout flow

`src/PluginForm/HostedPaymentFormForm.php` (extends Commerce `PaymentMethodAddForm`), plus
`js/hpf.js`, `css/hpf.css`, `.libraries.yml`, and the `Event/` alter events.

## Form build

`buildCreditCardForm()` replaces the normal card fields with five **hidden** inputs — `card_type`
(`.chase-card-type`), `card_number` (`.chase-card-number`), `expiration_month` (`.chase-exp-month`),
`expiration_year` (`.chase-exp-year`), `remote_id` (`.chase-remote-id`) — and an `<iframe>`
(`#commerce-chase-orbital-hpf-iframe`, name `embedded-orbital-form`) whose `src` is the Chase HPF
URL. It computes `remote_id = "<order_id>-<request_time>"` (the `customerRefNum` token), attaches
the mode-specific library, and passes `drupalSettings.commerce_chase.remoteId`. It then dispatches
`ChaseEvents::BUILD_IFRAME` (`BuildIframeEvent`, carrying the form + form state) so other modules can
alter the element.

`validateCreditCardForm()` and `submitCreditCardForm()` are intentionally empty — validation happens
in the HPF JS and the actual processing happens later in the gateway plugin's `createPayment`.

## Iframe URL / query

`buildCheckoutIframeUrl()` builds the query on `serviceUrl()`:

- `hostedSecureID` = config `hosted_secure_id`
- `action = buildForm`, `formType = 5`, `cardIndicators = N`, `collectAddress = 0`
- `hosted_tokenize = store_only` — **tokenize only**; the card is stored at Chase and a token
  returned, so the raw PAN/CVV is never posted to the Drupal server
- `css_url` = current scheme+host + module path to `css/hpf.css`
- `allowed_types` = pipe-joined enabled card labels from config
- `required` = config `required`
- `customer_email` = order email
- `sessionId` = `csrf_token->get(order_id)` (passed to Chase; not used to authorize a local route)
- `customerRefNum` = the `remote_id` token

Before returning, it dispatches `ChaseEvents::BUILD_IFRAME_QUERY` (`BuildIframeQueryEvent`, carrying
the query array + payment method) so modules can alter query parameters.

## JS callbacks (js/hpf.js)

`Drupal.behaviors.chaseOrbitalHpf` exposes the global callbacks that Chase's `hpfParent.min.js`
invokes: `cancelCREPayment`, `whatCVV2`, `creHandleErrors`/`creHandleDetailErrors` (log to console,
disable the complete button on error), `startCREPayment`, and **`completeCREPayment(transaction)`**.
On success the last writes `transaction.ccType/ccNumber/expMonth/expYear` into the hidden fields,
writes `drupalSettings.commerce_chase.remoteId` into `.chase-remote-id`, and submits the checkout
form. The behavior also hides the default checkout "next" button when the iframe is present. The
`ccNumber` supplied by the tokenizer is a masked value; the charge itself uses the `customerRefNum`
token, not this field.

## Libraries (.libraries.yml)

- `hosted-payment-form-test` — `js/hpf.js` + external
  `https://www.chasepaymentechhostedpay-var.com/hpf/js/hpfParent.min.js`
- `hosted-payment-form-live` — `js/hpf.js` + external
  `https://www.chasepaymentechhostedpay.com/hpf/js/hpfParent.min.js`

Both depend on `core/drupal`, `core/drupalSettings`, `core/jquery`.

## Events (Event/)

`ChaseEvents::BUILD_IFRAME` (`commerce_chase.build_iframe`) and `BUILD_IFRAME_QUERY`
(`commerce_chase.build_iframe_query`), with event classes `BuildIframeEvent` (form + form state
getters) and `BuildIframeQueryEvent` (query array + payment method getters). Subscribe to these to
customize the rendered iframe element or the HPF URL query.
