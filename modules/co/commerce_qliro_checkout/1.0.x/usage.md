<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Qliro Checkout integrates the Qliro Checkout off-site payment gateway with Drupal Commerce.

---

Commerce Qliro Checkout integrates Qliro Checkout — a Nordic payment/checkout provider — with Drupal Commerce as an off-site gateway. It embeds Qliro's checkout, exposes notification/validation and shipping-method callback endpoints, and drives order state through Qliro's Merchant API.

Payment state is managed via server-side Merchant API calls (`Qliro\MerchantApi\Order`); the module's `/commerce_qliro_checkout/validate/{gateway}` callback is anonymous, and in this release its `onValidation()` handler is a stub (no-op), so completion relies on the server-side API rather than trusting the callback body. Configure Qliro API credentials securely (env-backed). Depends on Commerce `commerce_payment`; supports Drupal 10 and 11.

---

- Integrate Qliro Checkout.
- Provide an off-site gateway.
- Embed Qliro's checkout.
- Expose callback endpoints.
- Drive state via Qliro's Merchant API.
- Manage payment server-side.
- Note the anonymous validate endpoint.
- Note `onValidation()` is a stub in this release.
- Configure API credentials securely.
- Keep credentials env-backed.
- Depend on Commerce `commerce_payment`.
- Support Drupal 10 and 11.
- Handle the redirect flow.
- Support Nordic payments.
- Fetch order state via the API.
- Complete orders server-side.
- Provide shipping-method callbacks.
- Integrate with checkout.
