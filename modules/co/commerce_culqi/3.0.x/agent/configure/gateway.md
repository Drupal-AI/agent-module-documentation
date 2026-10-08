<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Culqi

1. Enable the module (pulls in `commerce_payment` and `basic_auth`).
2. Add a **Culqi** card payment gateway and a **Culqi Cash** gateway under Commerce → Configuration → Payment gateways; enter your Culqi **public** and **secret** keys.
3. Add the cash message checkout pane to the checkout flow if you offer PagoEfectivo.
4. The front-end Culqi JS tokenizes the card and calls `commerce_culqi/create_charge` / `create_order`.

## Endpoints
- `commerce_culqi/create_charge` — `CulqiController::createCharge` → `CulqiService::createCharge($request->request)`. **_access: 'TRUE' (anonymous).**
- `commerce_culqi/create_order` — `CulqiController::createOrder`. **_access: 'TRUE'.**
- `commerce_culqi/order_event` — `OrderEventController::orderEvent`, `_auth: basic_auth`, `_user_is_logged_in: TRUE`, `no_cache`.

## Security (recorded Danger 3)
`create_charge` runs anonymously and the charge amount is taken from the client request rather than recomputed from the Commerce order total, letting a caller set an arbitrary charge amount (price manipulation). Mitigation for operators: validate the amount server-side against the order before charging, and/or restrict the endpoint. This is documented per the review note and was not re-investigated here.
