<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, status flow, routes, cron & drush

## Services

- **`commerce_opp.opp_service`** → `OpenPaymentPlatformService` (`OpenPaymentPlatformServiceInterface`).
  Args: `entity_type.manager`, `keyvalue`, `logger.factory`, `config.factory`. Methods:
  - `getOppGatewayIds($only_active = TRUE, array $config_filter = [], array $plugins = [])` — entity query for
    the six OPP gateway plugin ids (optionally active-only / filtered by `configuration.*` / by plugin).
  - `processPendingPaymentIntents()` — loads `new`-state payments (on gateways with
    `cron_process_pending_payment_intents`) not yet past the expiry threshold and calls
    `$gateway->checkAndUpdateTransactionStatus($payment)`.
  - `deleteExpiredPaymentIntents()` — deletes `new`-state payments (on gateways with
    `cron_delete_expired_payment_intents`) older than the threshold.
  - `getExpiresThreshold()` — `state:system.cron_last` minus `cron_expiration_threshold`.
- **`commerce_opp.brand_repository`** → `BrandRepository` (`BrandRepositoryInterface`). Loads brand metadata
  (label, commerce card type, sync/async, direct-debit/authorization support) from `data/payment-methods.json`
  into `Brand` value objects. Used to map OPP `paymentBrand` → Commerce card type and workflow support.

## Gateway API (`CopyAndPayBase` / `CopyAndPayInterface`)

All requests use `getHttpClientRequestOptions()`: `Authorization: Bearer <access_token>` header + `entityId`
param, sent as form params (POST) or query (GET) via the shared `http_client` (TLS verified).

- `prepareCheckout($params, $payment)` → `POST {host}/v1/checkouts`; stores response `id` in `opp_checkout_id`.
- `getCheckoutStatus($payment)` → `GET {host}/v1/checkouts/{opp_checkout_id}/payment` → `processTransactionStatus()`.
  (Used on the return / thank-you page.)
- `getTransactionReport($payment)` → `GET {host}/v1/query?merchantTransactionId={payment id}` (bulletproof lookup;
  handles 404 unfinished / 429 rate-limit). Used by cron + MB WAY polling + drush.
- `processTransactionStatus($payment, array $status)` → builds a `Transaction\Status\*` via `Factory::newInstance()`,
  records AVS/registration/brand, and (for `SuccessOrPending` DEBIT/PREAUTH) verifies the returned amount+currency
  equals the order amount (throws `InvalidResponseException` on mismatch), then returns the status object.
- `checkAndUpdateTransactionStatus($payment)` → report-based; applies `authorize` / `authorize_capture` / `capture`
  (success) or `void` (rejected); skips pending.
- `createPayment()` (reused/stored method → `POST /v1/registrations/{id}/payments`), `capturePayment()`,
  `voidPayment()`, `refundPayment()`, `deletePaymentMethod()` (→ `DELETE /v1/registrations/{id}`) — all
  `POST /v1/payments/{remote_id}` with `paymentType` `CP`/`RV`/`RF`.
- `onReturn($order, $request)` — reads `id` (checkout id) + `resourcePath` from the query, loads the payment by
  checkout id, asserts the order matches, re-queries status via `getCheckoutStatus()`, and finalizes via
  `onReturnAction()` (creates/updates the payment method, applies the workflow transition, cleans up unused intents).
- `getPayableAmount($order)` — dispatches `AlterPaymentAmountEvent` (`OpenPaymentPlatformPaymentEvents::ALTER_AMOUNT`)
  then rounds; override point for discounts.

### Transaction status classes (`src/Transaction/Status/`)

`Factory::newInstance($response, $brand)` maps `result.code` (regex per class) to one of: `Success`,
`SuccessNeedingReview`, `Pending`, `Chargeback`, or many `Rejected*` subclasses (external/communication/system/
async/risk/validation…). Success = `/^(000\.000\.|000\.100\.1|000\.[36])/`. Unknown codes throw
`\InvalidArgumentException`. Status objects are serializable (`toArray()`) for the MB WAY session store.

## Payment types & workflow

`PaymentTypes` constants: `PA` (preauthorization), `DB` (debit), `CD` (credit), `CP` (capture), `RV` (reversal),
`RF` (refund), `RC` (receipt). `getPaymentTypeParameter()` picks `DB` vs `PA` from the checkout `payment_process`
pane's `capture` flag and the brand's `supportsDirectDebit()`/`supportsAuthorization()`. `hook_workflows_alter`
allows the `void` transition from the `new` state.

## Routes

- `commerce_opp.check_transaction_status`: `/opp/check-transaction-status/{commerce_payment}/{type}` (default
  `type = DB`), controller `TransactionController::checkStatus`, custom access `TransactionController::checkAccess`
  (cart owner — authenticated user id == order customer, or anonymous with the order in the cart session — AND
  `access checkout` permission), `no_cache`. Returns JSON (`pending`/`success`/`rejected`/`error`) for Ajax or a
  render array attaching `commerce_opp/check_transaction_status` (`js/opp.checkStatus.js`) for the polling page.
- `commerce_opp.settings`: `/admin/commerce/config/payment/opp`, perm `administer commerce_payment_gateway`.

## Cron

`commerce_opp_cron()` → `processPendingPaymentIntents()` then `deleteExpiredPaymentIntents()`. Keep
*Process pending payment intents on cron* enabled unless webhooks are configured — OPP does not push
notifications by default, only the checkout id on the return URL, so a customer who never returns would
otherwise leave the order stuck.

## Drush

`commerce_opp:transaction-status <payment_id> [--type=report|checkout]` (alias `opp:ts`),
class `Commands\PaymentCommands` — prints `getTransactionReport()` (default) or `getCheckoutStatus()` for an
OPP payment. Read-only diagnostic.
