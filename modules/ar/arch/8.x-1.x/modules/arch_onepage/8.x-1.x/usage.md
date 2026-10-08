<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Onepage is the default one-page checkout UI for the Arch suite: it registers a `onepage` checkout-type plugin whose form collects billing, shipping and payment on a single AJAX-driven page, then saves the order and redirects to the chosen payment method.

---

`arch_onepage` provides the `onepage` `checkout_type` plugin (`Plugin\CheckoutType\Onepage`, form
class `Form\OnepageCheckoutForm`) that `arch_checkout` renders at `/checkout` when it is the
configured default. The form has three fieldsets — Personal/Billing data, Shipping (method + address
selector, with instore or new/address-book options), and Payment (method radios + note) — wired with
AJAX callbacks to recompute shipping and payment fees as the shopper changes selections. On submit it
sets the order status, optionally creates and logs in a new user (when an anonymous shopper ticks
"Create new account"), attaches billing/shipping `OrderAddressData`, applies the selected
`ShippingMethod` and `PaymentMethod` fees, calls `Order::updateTotal()` and saves, then redirects to
the payment method's `getCallbackRoute()` with `?order=<id>`. All order amounts are computed
server-side from the catalog price and the method fees — the client never supplies a price. The
module also exposes `OnepageController` at `/checkout/onepage` (an alternate direct entry point that
builds the same form) and preprocesses an order-summary sidebar (`arch_checkout_op_summary`) showing
line items, shipping and grand total. It attaches the `arch_onepage/onepage-checkout` JS library and
depends on `arch_checkout` (runtime: `arch_cart`, `arch_order`, `arch_payment`, `arch_shipping`,
optionally `arch_addressbook`).

---

- Offer a single-page checkout instead of a multi-step flow.
- Collect billing name, address, company and tax number in one form.
- Let shoppers reuse the billing address as the shipping address ("same as billing").
- Let shoppers enter a separate shipping address.
- Let shoppers pick a saved address when `arch_addressbook` is enabled.
- Offer in-store pickup as a shipping option (hides the shipping-address selector).
- Recompute shipping cost live when the shipping method changes (AJAX).
- Recompute the payment fee live when the payment method changes (AJAX).
- Let anonymous shoppers optionally create an account during checkout.
- Auto-generate a username and random password for the created account and email the details.
- Require a valid, not-already-registered email for guest checkout.
- Capture an order note from the customer.
- Attach billing and shipping addresses to the order record.
- Apply the selected payment method's fee (currency-exchanged if needed) to the order.
- Apply the selected shipping method's price to the order.
- Save the order and hand off to the payment gateway callback route.
- Show a live order-summary sidebar with items, shipping and grand total.
- Serve as the reference implementation of a `checkout_type` plugin.
