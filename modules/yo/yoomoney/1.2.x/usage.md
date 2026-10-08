<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YooMoney integrates the YooMoney/YooKassa payment platform with Drupal Commerce as an off-site (redirect) payment gateway, adding card, SBP, SberPay and e-money acceptance with optional 54-FZ receipt generation.

---

YooMoney (project `yoomoney`, machine name `yookassa`) provides a Drupal Commerce off-site payment gateway plugin backed by the official `yoomoney/yookassa-sdk-php` SDK. The shop is connected to YooMoney through an OAuth flow driven from the payment-gateway settings form, which stores the resulting access token in the gateway configuration and registers the notification webhook automatically. At checkout the customer is redirected to the YooKassa hosted payment page (`ConfirmationType::REDIRECT`); on return and via YooKassa's server-to-server notification the module re-fetches the payment from the YooKassa API and moves the Commerce payment/order to the completed state, capturing two-stage payments where needed. It also supports Russian 54-FZ fiscalization: building receipt data from the order's items, tax rates and payment subject/mode, and optionally sending a "second receipt" when an order reaches a chosen status. Requires Commerce (`commerce_payment`, `commerce_tax`, `commerce_cart`), PHP 8.0+, cURL, and the YooKassa PHP SDK (loaded via Ludwig).

---

- Accept online payments on a Drupal Commerce store through YooMoney / YooKassa.
- Offer the YooKassa hosted checkout so customers pick a payment method on YooKassa's side.
- Take bank-card payments (Visa, Mastercard, Maestro, Mir) via YooKassa.
- Take payments through the Faster Payments System (SBP), SberPay, T-Pay and YooMoney wallet.
- Connect a store to a YooMoney merchant profile with the built-in OAuth "Connect your store" flow.
- Switch a connected gateway between a test store and a real store.
- Automatically register YooKassa webhooks (payment succeeded/canceled/waiting-for-capture, refund succeeded) during OAuth setup.
- Confirm payment outcomes reliably by re-querying the YooKassa API rather than trusting the browser return.
- Capture two-stage (waiting-for-capture) payments automatically.
- Generate 54-FZ receipts and send receipt data to YooMoney together with the order.
- Map each Commerce tax rate to a YooKassa VAT code for correct receipt fiscalization.
- Set a default tax system (OSN, USN, ENVD, ESN, PSN) for receipts.
- Choose a default payment subject (commodity, service, job, etc.) and payment mode (full prepayment, full payment, credit, etc.).
- Send a "second receipt" automatically when an order transitions to a chosen status.
- Customize the payment description shown to the customer, with `%order_id%` (and other order field) placeholders.
- Run multiple YooKassa gateways with distinct machine names, each with its own notification URL.
- Review a per-gateway notification URL to configure in the YooMoney merchant profile.
- Inspect module activity through Drupal's dblog channel `yookassa`.
- Localize the admin UI (ships Russian translations).
- Provide a single "Pay" button at checkout instead of listing every payment method on-site.
