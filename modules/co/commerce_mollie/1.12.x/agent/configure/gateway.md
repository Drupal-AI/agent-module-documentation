# Commerce Mollie — gateway plugin, flow & webhook

## Plugin `mollie` (`Plugin/Commerce/PaymentGateway/Mollie`)

`OffsitePaymentGatewayBase`, `payment_method_types = {"mollie"}`, `requires_billing_information = FALSE`,
offsite form `MolliePaymentOffsiteForm`. Add it at
`/admin/commerce/config/payment-gateways` (standard Commerce payment-gateway entity — the module has
no `configure` route of its own).

### Configuration (`defaultConfiguration` / `buildConfigurationForm`)
| Key | Notes |
|---|---|
| `api_key_test` | required; default placeholder `test_` |
| `api_key_live` | required; default placeholder `live_` |
| `mode` | `test` \| `live` (inherited from base gateway) |
| `callback_domain` | optional; base URL used to build the webhook. Include scheme, no trailing `/`. Empty = current host. |

`create()` sets the SDK API key only when the configured key differs from the placeholder default and
matches the selected `mode`. On the form it warns if `commerce_order.commerce_order_type.default`
workflow lacks a `validation` step. Schema:
`commerce_payment.commerce_payment_gateway.plugin.mollie` (`api_key_test`, `api_key_live`,
`callback_domain`).

## Offsite payment flow
1. `MolliePaymentOffsiteForm::buildConfigurationForm()` builds `data` (`return`, `cancel`, `total`)
   and calls `createRemotePayment()`.
2. `createRemotePayment()` builds a Mollie payment: `amount` (currency + 2dp value), `description`
   (`@store order @order_id`), `redirectUrl = data['return']`, `webhookUrl = getNotifyUrl()`,
   `metadata.order_id`, optional `locale` (mapped from current language). Saves the remote id/state on
   the Commerce payment, then redirects (GET) to Mollie's `checkoutUrl`.
3. `getNotifyUrl()` = route `commerce_payment.notify` for this gateway, absolute, `base_url` =
   `callback_domain`.

## Return controller
Route `commerce_mollie.checkout.mollie_return/{commerce_order}` →
`MollieReturnController::returnFromMollieMiddleware`. Access: `CheckoutController::checkAccess`
(+ `_module_dependencies: commerce_checkout`). It loads the order's Mollie payments, takes the last
one, and:
- remote state failed/expired/canceled → warning message + redirect to `commerce_payment.checkout.cancel`.
- order paid OR remote state != open → redirect to `commerce_payment.checkout.return`.
- still open → kill page cache and render `mollie_return` theme with a reload link.
This controller only routes the browser; it does not change payment state.

## Webhook `onNotify(Request $request)` — authoritative status
1. Reads Mollie payment id from `$request->get('id')`; if absent, decodes JSON body and reads `id`.
2. `loadByRemoteId($id)`; returns empty `JsonResponse` if no local payment.
3. **Re-fetches the payment from Mollie: `$this->getApi()->payments->get($id)`** and switches on the
   returned `status` (NOT any status in the request):
   - `paid` → transition `authorize_capture`
   - `canceled` → `authorize` then `void`
   - `open` → `authorize`
   - `failed` → `authorize` then `void`
   - `expired` → `authorize` then `expire`
   Then `setRemoteState()` + `save()`.
4. Returns empty 200 `JsonResponse`.

Security note: because status is re-fetched server-to-server from Mollie, a forged/replayed webhook
POST cannot spoof an order into the paid state — the worst an attacker can do by POSTing a known
payment id is trigger the module to re-sync that payment to its true Mollie status.
