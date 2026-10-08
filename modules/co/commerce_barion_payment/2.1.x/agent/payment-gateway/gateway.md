<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barion gateway: config, payment lifecycle, capture/void

All logic lives in
`src/Plugin/Commerce/PaymentGateway/BarionPaymentGateway.php` and
`src/PluginForm/BarionRedirectForm.php`.

## Configuration form

`buildConfigurationForm()` / `submitConfigurationForm()` persist these keys into the gateway's
`configuration` (defaults from `defaultConfiguration()`):

| key | form label | type | default | notes |
|-----|-----------|------|---------|-------|
| `email` | Barion email address | textfield | `''` | required; sent as transaction `Payee` |
| `private_key` | Secret key (POSKey) | textfield | `''` | required; the Barion secret used to construct every `BarionClient` (authenticates all API calls) |
| `api_version` | API version number | number | `2` | passed to `BarionClient` |
| `payment_window` | Payment Window (HMS) | 3 × 2‑digit textfields | `00:05:00` | `validateConfigurationForm()` requires each box numeric and exactly 2 chars; re‑joined with `:` |
| `locale` | Barion locale | select | `UILocale::EN` | options from `UILocale::cases()` |
| `reservation_period` | Reservation period | textfield | `0.00:30:00` | `d.hh:mm:ss`; used only for reservation (authorize‑only) payments |

Mode (`getMode()`) comes from the parent `PaymentGatewayBase`; `getSupportedModes()` reflects the
`BarionEnvironment` enum, and `test` → `BarionEnvironment::Test`, otherwise `BarionEnvironment::Prod`.

## Prepare + redirect (checkout)

`BarionRedirectForm::buildConfigurationForm()`:
1. Calls `BarionPaymentGateway::preparePayment($order, $return_url)`.
2. `preparePayment()` builds a `PreparePaymentRequestModel`:
   - `POSTransactionId` / `PaymentRequestId` / `OrderNumber` from the **order**.
   - `Total` = `order->getTotalPrice()->subtract(order->getTotalPaid())` — the **server‑side order
     amount** (throws `PaymentGatewayException` if already over‑paid). Per‑item `ItemModel`s carry
     unit/total prices and SKU from the order items.
   - `Currency` validated via `assertCurrency()` against Barion's `Currency` enum (throws if
     unsupported). `BillingAddress` from the order's billing profile.
   - `PaymentType` = `Immediate` when the checkout flow's `payment_process.capture` is on, else
     `Reservation` with `ReservationPeriod`.
   - `RedirectUrl` = Commerce return URL; `CallbackUrl` = `getNotifyUrl()` (Commerce notify route).
3. If the response `Status` !== `Prepared`, `logError()` records Barion API errors and a
   `PaymentGatewayException` is thrown.
4. On success it stores `barion_payment_id` = `PaymentId` on the **order** (`$order->setData`),
   calls `createPayment()` (local `commerce_payment`, `amount` = order total, `remote_id` =
   `PaymentId`, state mapped from Barion status), then `buildRedirectForm(... REDIRECT_GET)` sends
   the buyer to `PaymentRedirectUrl`.

## Return + notify — authoritative re‑poll (security‑relevant)

- **`onReturn($order, $request)`**: reads `barion_payment_id` **from the order** (not from the
  request), calls `getPaymentState($payment_id)`, syncs local state via `updatePaymentState()`, then
  switches on the fetched `Status`: only `Succeeded` / `Reserved` proceed; every other status throws
  a `PaymentGatewayException`.
- **`onNotify($request)`**: reads `paymentId` from the request query, then calls
  `getPaymentState($payment_id)` and, if a status came back, `updatePaymentState()`. It acts on the
  **API‑fetched** status, never on request‑supplied status.
- **`getPaymentState($payment_id)`**: `new BarionClient(private_key, api_version, env)` →
  `GetPaymentState($payment_id)`. Authenticated with the merchant Secret key, so it only returns
  data for payments belonging to this POS.
- **`updatePaymentState($payment_id, $remote_state)`**: loads the local payment by
  `remote_id == $payment_id` **AND** `payment_gateway == this gateway`; only if exactly one matches
  does it map + set state and store `remote_state`. This binds the incoming `paymentId` to a payment
  already created for this gateway.

Net effect: the posted/return status is never trusted; the order is marked paid only when Barion's
authenticated API reports it, and the paymentId is bound to a local payment of this gateway.

## State mapping

`mapState()` maps Barion status → Commerce state: `Succeeded`→`completed`,
`Reserved`/`InProgress`/`Authorized`/`PartiallySucceeded`→`authorization`, `Canceled`/`Failed`→
`authorization_voided`, `Expired`→`authorization_expired`, `Prepared`/`Started`/`Waiting`→`new`.

## Capture / void (SupportsAuthorizationsInterface)

Both require the local payment state to be `authorization` (else `PaymentGatewayException`). Each
re‑fetches the remote payment with `GetPaymentState`, reads the remote transaction, builds a
`FinishReservationRequestModel` + `TransactionToFinishModel`, and calls `FinishReservation`:

- **`capturePayment($payment, $amount = NULL)`**: if a partial `$amount` is given it rejects amounts
  greater than the reserved total, sets `Total` to the requested amount and updates the payment
  amount; then state → `completed`, remote → `Succeeded`.
- **`voidPayment($payment)`**: sets the finish transaction `Total` to `0` (releasing the
  reservation); state → `authorization_voided`, remote → `Canceled`.
