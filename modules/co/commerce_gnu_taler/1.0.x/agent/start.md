<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce GNU Taler (commerce_gnu_taler) — agent index

**Off-site Drupal Commerce payment gateway for GNU Taler.**

- **Version:** 1.0.x  **Core:** ^10 || ^11
- **Depends:** commerce_payment
- **Plugin:** payment gateway `commerce_gnu_taler` (`src/Plugin/Commerce/PaymentGateway/Taler.php`), off-site.
- **Config:** per-gateway `backend_url`, `backend_api_key`, `refund_delay` (default backend = public demo, default key = demo token — replace).
- **Backend client:** `TalerClient` (`src/TalerClient.php`) → `GET config`, `POST private/orders`, `GET private/orders/{id}`, `POST .../refund`; bearer-token auth, default Guzzle TLS.
- **No local routes / no webhook.** Return handled by `onReturn()` which re-fetches order status and requires `order_status == 'paid'`; amount taken from backend `contract_terms`.
- **Security:** payment recorded only on backend-confirmed `paid` status; amount is server-authoritative, not client-set; no unauthenticated callback endpoint. Demo backend + demo API key shipped as defaults.

See [configure/gateway.md](configure/gateway.md).
