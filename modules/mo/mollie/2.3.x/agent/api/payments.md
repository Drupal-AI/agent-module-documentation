# API: payments, the `mollie.mollie` service, routes

## The connector service `mollie.mollie`

`Drupal\mollie\Mollie` (args: `messenger`, `config.factory`, `mollie.config_validator`).

| Method | Returns | Notes |
|---|---|---|
| `getClient()` | `?MollieApiClient` | Builds and statically caches a `Mollie\Api\MollieApiClient`, adds a `Drupal/<version>` version string, and calls `setApiKey()` with the test or live key per `useTestMode()`. `null` on incompatible platform / API error (logged). |
| `useTestMode()` | `bool` | `hasTestApiKey()` AND `mollie.config:test_mode`. |
| `getMethods(float $amount, string $currency)` | `array` | Active Mollie payment methods for the amount, keyed `id => description` (calls `methods->allActive`). |
| `getStatuses()` | `array` | The 7 `Mollie\Api\Types\PaymentStatus` values → human labels (open, canceled, pending, authorized, expired, failed, paid). |
| `get(EntityTypeInterface $type, string $conjunction)` | `?QueryInterface` | Entity-query factory for `mollie_payment` (→ `PaymentQuery`) and `mollie_customer` (→ `CustomerQuery`); this service is the entity storages' `getQueryServiceName()`. |

## The `mollie_payment` entity (API-backed)

`Drupal\mollie\Entity\Payment` (extends `TransactionBase`), storage
`Drupal\mollie\Entity\PaymentStorage` (extends `TransactionStorageBase`). The entity is **not**
fieldable and is **not** stored locally — every load/save round-trips to the Mollie API:

- **Load** (`doLoadMultiple`): `mollieApiClient->payments->get($id)`, then mapped to entity fields
  (`createEntityFromTransaction`). So `getStatus()`, `getAmount()`, `getCurrency()`, etc. always
  reflect the current Mollie-side state, not any caller input.
- **Save** (create): `createTransactionFromEntity` → `mollieApiClient->payments->create($values)`,
  attaching `redirectUrl` (route `mollie.redirect`), `webhookUrl` (route
  `mollie.webhook.status_change`), and `metadata` = `{context, context_id}`. The created Mollie id
  and `checkout_url` are written back onto the entity.
- Entity queries return ids fetched from Mollie (`payments->page()`); there is no local query.

### Create a payment

```php
$storage = \Drupal::entityTypeManager()->getStorage('mollie_payment');
$payment = $storage->create([
  'amount' => 12.50,
  'currency' => 'EUR',            // allowed: EUR, USD
  'description' => 'Membership 2026',
  'method' => 'ideal',            // optional; omit to let Mollie show all methods
  'issuer' => 'ideal_INGBNL2A',   // optional, only used when method is ideal
  'context' => 'my_module',       // your module identifies itself here
  'context_id' => '42',           // your entity id; echoed back on redirect/webhook
]);
$payment->save();
$checkoutUrl = $payment->getCheckoutUrl(); // send the visitor here to pay
```

Read-only fields populated from Mollie on load: `status`, `mode`, `created`, `changed`,
`refunded_amount`/`refunded_currency`, `refundable_amount`/`refundable_currency`,
`captured_amount`/`captured_currency`, `charged_back_amount`/`charged_back_currency`, `method`,
`issuer`, `checkout_url`. Accessors: `getStatus()`, `getAmount()`, `getCurrency()`, `getMode()`,
`getContext()`, `getContextId()`, `getDescription()`, `getCheckoutUrl()`, plus the refund/capture/
chargeback getters.

The admin add form (`/mollie/payment/add`, `PaymentForm`) generates a UUID `context_id` and sets
`context = 'form'`; it ajax-loads available methods for the entered amount/currency.

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `mollie.admin` | `/admin/mollie` | `access mollie payments overview` | Admin menu block. |
| `entity.mollie_payment.collection` | `/admin/mollie/payments` | `access mollie payments overview` | Payments list. |
| `entity.mollie_payment.canonical` | `/mollie/payment/{mollie_payment}` | `mollie_payment.view` | View one payment. |
| `entity.mollie_payment.add-form` | `/mollie/payment/add` | create access | Add a payment. |
| `mollie.configuration` | `/admin/config/services/mollie` | `administer mollie` | Settings form. |
| `mollie.redirect` | `/mollie/redirect/{context}/{context_id}` | `TRUE` | Customer return URL after paying; dispatches `MollieRedirectEvent`, then redirects (default: payments collection). |
| `mollie.webhook.status_change` | `/mollie/webhook/{context}/{context_id}` | `TRUE` | Mollie status webhook (see below). |
| `mollie.webhook.aftercare` | `/mollie/webhook/{context}/{context_id}/aftercare` | `TRUE` | Post-paid webhook for refunds/chargebacks (experimental). |

## Webhook flow (`WebhookController`)

`invokeStatusChangeHook`: reads the Mollie payment `id` from the request, records the invocation in
the `mollie_last_webhook_invocation` key/value collection, then **loads the `mollie_payment` entity
for that id** — which fetches the payment from the Mollie API server-side. It dispatches
`MollieTransactionStatusChangeEvent` (carrying the API-loaded entity) so submodules can react, and
returns an empty response whose HTTP code reflects whether subscribers handled it (200 OK, else
500). Once the payment reaches `paid`, the controller re-points the payment's `webhookUrl` to
`mollie.webhook.aftercare` (via `payment->update()`), so later refund/chargeback callbacks land on
`invokeAftercareHook`, which dispatches `MollieTransactionRefundEvent` / `MollieTransactionChargebackEvent`.

If the payment id doesn't resolve to a `mollie_payment`, the controller returns `200` (as Mollie
advises) and does nothing.
