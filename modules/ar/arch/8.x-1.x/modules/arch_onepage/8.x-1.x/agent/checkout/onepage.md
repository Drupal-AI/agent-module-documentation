<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The onepage checkout form

`Form\OnepageCheckoutForm` (`getFormId() = 'arch_onepage_checkout'`) is the single-page checkout.
`Plugin\CheckoutType\Onepage::buildForm()` wraps it in the `arch_checkout_op` theme plus an
`arch_checkout_op_summary` sidebar; `arch_checkout` renders it at `/checkout`.

## Form structure (`buildForm`)

- **Billing** (`billingForm`): `email` (readonly + prefilled for logged-in users), plus address
  fields from `getAddressFields()`: firstname, lastname, company, `tax_number` (required/visible only
  when company is filled), address, address2, postcode, country (options from
  `getAvailableCountries()` — currently hardcoded `HU`), city. A "Create new account" checkbox is
  shown to anonymous users.
- **Shipping** (`shippingForm`): `shipping_methods` radios (AJAX `changeShippingMethod`),
  `shipping_address_selector` (`sameas` / `new_shipping` / `choose_address` when `arch_addressbook`
  is present), a new-shipping-address subform, and required phone prefix + number. The address
  selector is hidden when the method is `instore`.
- **Payment** (`paymentForm`): `payment_method` radios (options from
  `PaymentMethodManager::getAvailablePaymentMethods($order)`, AJAX `changePaymentMethod`) and a
  free-text `note`.

## AJAX callbacks

- `changeShippingMethod()` — `Xss::filter`s the chosen method, sets it on the order, invokes
  `hook_shipping_method_changed`, returns an `AjaxResponse` (lets shipping modules update the
  summary).
- `changePaymentMethod()` — triggers a `checkout.onepage.phaseRecheck` DOM event.

## Validation (`validateForm`)

- AJAX submissions short-circuit (only a method was chosen).
- Clears `shipping_*` field errors when "same as billing" is used.
- For anonymous users, rejects an `email` that already belongs to an account (prompts login).

## Submit (`submitForm`) — order creation

1. Determine `order_currency` (order's currency, else `EUR`).
2. Set order status to the `checkout` status **if it exists** (it is not shipped by default) else
   `getDefaultOrderStatus()` (= `cart`).
3. If anonymous + "create account" → `createUser()`: `User::create()`, email set, generated unique
   username, random 12-char password, activated, saved, `user_login_finalize()`, and
   `_user_mail_notify('register_no_approval_required')`. Order owner set to the (new or current)
   user.
4. Set `shipping_method` and `payment_method`; instantiate the payment plugin; compute
   `getPaymentFee($order)` (exchanged to order currency if needed) → `setPaymentFee()`.
5. Store the optional `note` in the order `data`.
6. Build billing `OrderAddressData` (`buildBillingAddress`); shipping is a clone of billing
   (`sameas`), a new address (`buildShippingAddress`), or a loaded address-book item
   (`loadSelectedShippingAddress`, scoped to the order owner's `user_id`).
7. If a `ShippingMethod` is set, compute `getShippingPrice($order)` (exchanged if needed) →
   `setShippingPrice()`.
8. `Order::updateTotal()` (applies shipping + payment fees), `Order::save()`.
9. `setRedirect($payment_method->getCallbackRoute(), ['order' => $order->id()])`.

## Notes

- All monetary values come from the catalog/price layer and the method fee objects; the form never
  reads a price/total from the request, so there is no client-side price tampering surface here.
- Country list and the `checkout` status branch are effectively placeholders (see `@todo`s in
  source); the default status a new order keeps is `cart`.
