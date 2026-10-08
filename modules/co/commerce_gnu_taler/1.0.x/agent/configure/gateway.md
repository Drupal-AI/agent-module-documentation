<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GNU Taler gateway — configure

Add at *Commerce → Configuration → Payment gateways → Add payment gateway* → plugin
**GNU Taler**.

Fields (`Taler::buildConfigurationForm`):
- **Backend URL** — Taler merchant backend base, e.g. `https://backend.example.com/instances/sandbox/` (trailing slash; must end where `config`, `private/orders` resolve).
- **API Key** — sent as `Authorization: Bearer <key>`; typically `secret-token:...` (RFC 8959). Obtain from the backend `/token` endpoint.
- **Refund Delay** — days a customer may request a refund (min 1).

On save, `validateConfigurationForm()` instantiates `TalerClient` and calls `verifyBackend()`
(protocol compatibility 16–18); a failed contact blocks saving.

Flow:
- `createRedirectOrder()` — verifies currency, `POST private/orders`, stores the response in
  `order->setData('taler_post_order_response')`, redirects to `<backend>/orders/<order_id>` with token.
- `onReturn()` — `getOrderStatus()`; throws unless `paid`; creates a `completed`
  `commerce_payment` with amount from `contract_terms.amount`.
- `refundPayment()` — `POST private/orders/{id}/refund`, sets partially_refunded/refunded,
  emails the `taler_refund_uri`.

Defaults ship the public demo backend and `secret-token:sandbox` — override both for production.
