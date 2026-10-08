<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes and controller — EnzonaPaymentController

`commerce_enzona.routing.yml` +
`src/Controller/EnzonaPaymentController.php` (extends `ControllerBase`).

## Routes

| Route | Path | Method | Access requirement | Action |
|-------|------|--------|--------------------|--------|
| `commerce_enzona.return` | `/commerce_enzona/return/{commerce_order}` | GET | `_entity_access: commerce_order.update` | `returnAction` |
| `commerce_enzona.cancel` | `/commerce_enzona/cancel/{commerce_order}` | GET | `_entity_access: commerce_order.update` | `cancelAction` |
| `commerce_enzona.webhook` | `/commerce_enzona/webhook` | POST | `_access: 'TRUE'` | `webhookAction` |
| `commerce_enzona.debug` | `/commerce_enzona/debug` | GET | `_access: 'TRUE'` | `debugAction` |
| `commerce_enzona.test` | `/commerce_enzona/test-direct` | GET | `_access: 'TRUE'` | `testDirectAction` |
| `commerce_enzona.full_debug` | `/commerce_enzona/full-debug` | GET | `_access: 'TRUE'` | `fullDebugAction` |

The `{commerce_order}` param is up-cast to a `commerce_order` entity and matched by
`\d+`. The return route sets `no_cache: TRUE`.

## Actions

- **`returnAction(Request, OrderInterface $commerce_order)`** — the EnZona return
  target. If the order's `payment_gateway` plugin id is `enzona_redirect_checkout`,
  calls `$gateway_plugin->onReturn($commerce_order, $request)` (see
  [gateway/payment-gateway.md](../gateway/payment-gateway.md)), then always
  redirects to the order canonical page (`entity.commerce_order.canonical`).
- **`cancelAction(Request, OrderInterface $commerce_order)`** — adds a "Payment was
  cancelled" warning and redirects back to the checkout payment step
  (`commerce_checkout.form`, `step => payment`).
- **`webhookAction(Request)`** — decodes the POST JSON body, reads the transaction
  id (`transaction_uuid`/`uuid`/`payment_id`), loads the `commerce_payment` by
  `remote_id`, reads a status field (`status`/`status_denom`) from the body, and if
  it is `completed`/`Completado`/`Completada` transitions the payment to
  `completed` and applies the order `place` transition. Returns plain
  `Response` codes (400 invalid payload / no uuid, 404 payment not found, 200 OK).
- **`debugAction`** — loads `commerce_order` id 1 and calls `createPayment()` with
  the site front page as return URL, printing the result.
- **`testDirectAction`** — authenticates and POSTs a hard-coded 500.00 CUP payload
  to `https://api.enzona.net/payment/v1.0.0/payments`, printing the response.
- **`fullDebugAction`** — authenticates and POSTs a hard-coded 5.00 CUP payload via
  native cURL, printing the token prefix, payload, and raw EnZona response as HTML.
- `testConnectionAction` — not wired to any route; returns a "Not implemented"
  stub.

## Drush (`commerce_enzona.drush.inc`, legacy Drush 8 API)

- **`enzona-test`** (alias `e-test`) — loads the configured gateway and calls
  `authenticate()`, reporting success/failure.
- **`enzona-payment-status <uuid>`** (alias `e-status`) — calls
  `getPaymentDetails($uuid)` and prints the JSON.

These use `hook_drush_command()` / `drush_*` callbacks, which are not registered by
Drush 12+ (the version shipped with Drupal 11); the same operations are reachable
programmatically via the plugin methods.
