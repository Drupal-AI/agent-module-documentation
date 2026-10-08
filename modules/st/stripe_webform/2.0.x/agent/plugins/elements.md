# Stripe Webform elements

Two Webform elements, both thin subclasses of `StripeWebformElementBase`
(`src/Plugin/WebformElement/`):

| Element id | Class | Purpose |
|---|---|---|
| `stripe` | `StripeWebformCC` | Stripe credit-card element (card fields placeholder). |
| `stripe_paymentrequest` | `StripeWebformPaymentRequest` | Payment Request button (Apple Pay / Google Pay / browser wallets). |

Both are `composite = TRUE`, category "Stripe". Add them from the Webform build UI like any element.

## Element properties (defaults in `StripeWebformElementBase`)

Set on the element's configuration form (all support Webform tokens, incl. submission tokens):

| Property | Default | Meaning |
|---|---|---|
| `stripe_currency` | `usd` | 3-letter currency code. |
| `stripe_country` | `US` | 2-letter Stripe account country. |
| `stripe_shared` | `TRUE` | Share one payment config across all Stripe elements on the form. |
| `stripe_label` | `''` | Payment label (falls back to the webform title). |
| `webform_stripe_amount` | `''` | Amount to charge (numeric; tokens allowed). |
| `webform_stripe_amount_multiply` | `TRUE` | Multiply the amount by 100 before sending to Stripe (dollars→cents). |
| `webform_stripe_subscriptions` | `FALSE` | Capture the payment method for off-session reuse (subscriptions). |
| `stripe_name` / `stripe_email` / `stripe_receipt_email` | `''` | Billing + receipt email. |
| `stripe_billing_address1/2`, `_city`, `_state`, `_country`, `_postal_code`, `_phone` | `''` | Billing details. |

## Behaviour (`prepare()` and validation)

- `prepare()` copies each property onto `#`-prefixed keys, computes `#stripe_amount` (float, ×100 when
  `amount_multiply`), defaults the label to the webform title, and — when subscriptions are on — sets
  `#stripe_paymentintent['setup_future_usage'] = 'off_session'`. It also registers default submit
  selectors (`.webform-button--next`, `.webform-button--submit`).
- `validateStripeAmount()` enforces Stripe's per-currency **minimum charge amount** (e.g. USD 50 = $0.50,
  GBP 30, JPY 5000, …) and warns for non-USD currencies near the minimum.
- `validateConfigurationForm()` **rejects the element on AJAX-enabled webforms** (payment is client-side).
- The value stored is the PaymentIntent id; `formatTextItem()` renders it (with field prefix/suffix).

## Payment wiring

The base `stripe` module's JS creates the PaymentIntent client-side. `StripeWebformEventSubscriber::
handleStripePayment()` (on `StripeEvents::PAYMENT`) reads the prepared element and calls
`$event->setTotal()`, `setBillingName/Email/City/Country/Address1/2/PostalCode/State/Phone()` and the
`receipt_email` setting so the charge carries the element's amount + billing data. See
[../api/events.md](../api/events.md).
