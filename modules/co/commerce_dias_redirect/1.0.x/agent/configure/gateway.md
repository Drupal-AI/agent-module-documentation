<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the DIAS payment gateway

Add at **Commerce > Configuration > Payment > Payment gateways** → *DIAS Payment Redirect* (plugin id `dias_redirect`).

Required fields (`DiasPaymentRedirect::buildConfigurationForm`):
- `api_order_registration_url` — DIAS endpoint used to register an order and obtain the bank `formUrl`.
- `api_get_order_status_url` — DIAS endpoint used to poll order status on return and in cron.
- `username` / `password` — merchant credentials from the bank agreement.

These are persisted in the payment gateway plugin configuration.

Notes:
- Currency is hard-coded to `978` (EUR) in `DiasPaymentRedirectForm`.
- Amount is `(int) $order->getTotalPrice()->getNumber() * 100` (integer euros × 100), which truncates fractional euro amounts.
- The gateway loads plugin config by the hard-coded gateway id `dias_payment` in the controller and cron; the configured gateway must use that machine id.
