<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PayPal Subscriptions extends Drupal Commerce's PayPal integration to support recurring billing. It adds a "PayPal recurring (Express Checkout)" payment gateway that creates a PayPal recurring payments profile at checkout, so a Commerce order can start a subscription rather than a single charge.

---

The gateway plugin `ExpressCheckoutSubscriptions` (id `paypal_express_checkout_subscription`) subclasses `commerce_paypal`'s `ExpressCheckout` gateway and reuses its offsite-payment form and NVP API plumbing. It adds a configurable billing period (Day/Week/SemiMonth/Month/Year). `setExpressCheckout()` sends the NVP `SetExpressCheckout` call with `L_BILLINGTYPE0 = RecurringPayments`; on return, `onReturn()` calls `GetExpressCheckoutDetails` server-to-server (using the token stored in the order's `paypal_express_checkout` data), saves the PayerID/email to the order, then calls `CreateRecurringPaymentsProfile` (`doExpressCheckoutDetails()`); it only records a Commerce payment (state `authorization`, remote id = PayPal PROFILEID) when PayPal returns `PROFILESTATUS == ActiveProfile`. Depends on `commerce_payment` and `commerce_paypal`. Note (see agent notes): the return handler re-fetches transaction details from PayPal via the server-issued token bound to the order and only acts on PayPal's actual API response — it is not a forgeable success callback.

---

- Sell subscriptions/memberships billed through PayPal in Drupal Commerce.
- Offer recurring billing periods (daily, weekly, monthly, yearly, semi-monthly).
- Create a PayPal recurring payments profile automatically at checkout.
- Reuse the standard Commerce PayPal Express Checkout offsite flow.
- Bind the recurring profile to a specific Commerce order and amount.
- Record a Commerce payment only when PayPal confirms an active profile.
- Support anonymous checkout by capturing the PayPal payer email onto the order.
- Configure the billing period per gateway instance in the Commerce UI.
- Add recurring donations via a Commerce product/order.
- Charge membership dues on a repeating schedule.
- Keep the PayPal PROFILEID as the payment remote id for reconciliation.
- Extend an existing commerce_paypal setup without replacing it.
- Verify checkout details server-side against PayPal before finalizing.
- Provide subscription billing without a separate recurring-billing engine.
- Localize amount/currency from the order total.
- Fail safely (throws) when PayPal reports an error or non-active profile.
