<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce GNU Taler adds a GNU Taler off-site payment gateway to Drupal Commerce.

---

GNU Taler is a privacy-preserving electronic-payment system. This module registers a
`commerce_gnu_taler` off-site payment gateway (`OffsitePaymentGatewayBase`) that talks to a
Taler *merchant backend* over its REST API. At checkout it creates a redirect order on the
backend (`POST private/orders`) and sends the shopper to the Taler wallet page; on return it
re-fetches the order status from the backend (`GET private/orders/{id}`) and only records a
`completed` payment when the backend reports `order_status == 'paid'`, using the amount from
the backend's `contract_terms` rather than any client-supplied value. Refunds call
`POST private/orders/{id}/refund` and email the shopper a Taler refund URI.

Configure the gateway at *Commerce → Configuration → Payment gateways*: set the Backend URL
and an API Key (sent as an RFC 8959 `Authorization: Bearer secret-token:...` header) plus a
refund-delay in days. The default configuration ships the public demo backend
(`backend.demo.taler.net/instances/sandbox/`) and a demo token — replace both for production.
The backend client (`TalerClient`) uses Drupal's shared Guzzle client with default TLS
verification; the gateway verifies backend protocol compatibility and currency support before
creating an order. Currency `KUD` is mapped to the Taler `KUDOS` key.

---

- Enable GNU Taler payments in a Drupal Commerce store.
- Add a `commerce_gnu_taler` payment gateway in the Commerce UI.
- Point the gateway at a self-hosted Taler merchant backend URL.
- Replace the demo backend URL before going live.
- Set the backend API key as a `secret-token:` bearer token.
- Configure the number of days a customer may request a refund.
- Verify the backend is protocol-compatible during gateway setup.
- Restrict the gateway to currencies the backend supports.
- Redirect shoppers off-site to the Taler wallet to complete payment.
- Record a completed payment only after the backend confirms `paid`.
- Capture the paid amount from backend contract terms, not the cart.
- Issue full or partial refunds through the Taler backend.
- Email customers a Taler refund URI when a refund is granted.
- Track remote order id / status on the Commerce payment entity.
- Sell products priced in KUDOS (demo currency) via the KUD mapping.
- Use the sandbox backend for integration testing.
- Theme the refund notification email (`commerce_gnu_taler_refund`).
- Combine with other Commerce gateways as an alternate payment option.
