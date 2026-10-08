<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce DIAS (commerce_dias_redirect) — agent index

**Off-site Commerce payment gateway integrating the Greek DIAS bank redirection service.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependencies:** commerce:commerce, commerce:commerce_payment
- **Gateway plugin:** `dias_redirect` (OffsitePaymentGatewayBase), offsite-payment form `DiasPaymentRedirectForm`.
- **Service:** `commerce_dias_redirect.dias_api_service` (`DiasApiService`) — orderRegistration + getOrderStatus over `@http_client`.
- **Route:** `commerce_dias_redirect.payment_callback` → `/commerce_dias_redirect/callback/{commerce_order}` (`_access: 'TRUE'`, `no_cache: TRUE`).
- **Config:** api_order_registration_url, api_get_order_status_url, username, password (stored in gateway plugin config).
- **Cron:** resets checkout step of unpaid draft DIAS orders older than 900s.

**Security:** the return callback is anonymous (`_access: 'TRUE'`) but re-fetches authoritative payment status from the DIAS API before completing — it does not trust a client-supplied status or amount (payment amount = server-side `$order->getBalance()`).

See [configure/gateway.md](configure/gateway.md) and [api/callback.md](api/callback.md).
