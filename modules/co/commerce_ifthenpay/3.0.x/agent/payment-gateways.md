<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateway plugins, config & checkout

All three plugins are `@CommercePaymentGateway`s configured under
`/admin/commerce/config/payment-gateways`. Config is stored per gateway with schema in each
submodule's `config/schema/*.schema.yml`.

## `ifthenpay` — Multibanco (base)

File `src/Plugin/Commerce/PaymentGateway/Ifthenpay.php`. `PaymentGatewayBase` +
`ManualPaymentGatewayInterface` + `SupportsNotificationsInterface`, `payment_type = payment_manual`,
`requires_billing_information = FALSE`. Forms: `add-payment` → `ManualPaymentAddForm`,
`receive-payment` → `PaymentReceiveForm` (admin ops; also `void-payment` operation).

### Config fields (`buildConfigurationForm`)

| Field | Notes |
|---|---|
| `reference_mode` | radios `api` / `local`. New gateways preselect `api`; stored default stays `local` so existing sites don't change behaviour on update. |
| `mb_key` | MB Key for API mode (visible only in API mode; required in API mode). |
| `use_sandbox` | checkbox — use `.../reference/sandbox` endpoint. ifthenpay warns production abuse can lock the account; always test on sandbox. |
| `expiry_days` | API mode; must be one of `0, 1-31, 45, 60, 90, 120, 180, 365, 730` or empty (never expires). |
| `multibanco_entidade` | 5 digits, offline mode (validated `^\d{5}$`). |
| `multibanco_subentidade` | 3 digits, offline mode (validated `^\d{3}$`). |
| `multibanco_chaveAntiPhishing` | anti-phishing key — **always required**, authenticates the callback. |
| `instructions` | `text_format`, shown on the checkout completion page. |

`validateConfigurationForm()` **trims** the credential-ish keys (`TRIMMED_CONFIG_KEYS`) before
validating/storing — whitespace pasted into an MB Key otherwise causes an opaque 403 from ifthenpay;
re-saving an old gateway fixes it. Mode-specific validation enforces MB Key/expiry (API) or
entity/sub-entity digit format (offline).

### Payment lifecycle

- `createPayment()`: in API mode calls `createApiPayment()` (requests a dynamic reference, stores
  `request_id`/`entity`/`expiry_date`/`sandbox` in `order->getData('commerce_ifthenpay')[payment_id]`,
  sets state `pending`; **no fallback to local generation** — a colliding local ref is the bug API
  mode exists to prevent). Offline mode sets `pending` (or `completed` if `$received`).
- `buildPaymentInstructions()`: renders the `multibanco_instructions` theme with entity + spaced
  reference + amount (+ expiry in API mode). Existing payments render from the stored remote id;
  offline new payments compute + persist the reference as the remote id.
- `receivePayment()` / `voidPayment()` / `refundPayment()`: standard manual-gateway transitions.
- `generateMbRef()` (static): the ifthenpay 9-digit check-digit algorithm.
  `processOrderIdForReference()` maps order ids > 9999 via `(abs(crc32(id)) % 9000) + 1000` and logs
  a warning; `checkForOrderIdCollisions()` warns when a mapped id resembles an existing reference.

## `ifthenpay_mbway` — MB WAY (`commerce_ifthenpay_mbway`)

File `.../Plugin/Commerce/PaymentGateway/IfthenpayMbway.php`. `PaymentGatewayBase` +
`OnsitePaymentGatewayInterface` + `HasPaymentInstructionsInterface` + `SupportsVoidsInterface` +
`SupportsNotificationsInterface`. `payment_method_types = {commerce_ifthenpay_mbway}`,
`payment_type = payment_ifthenpay_mbway`.

- **Payment method type** `commerce_ifthenpay_mbway` (`PaymentMethodType/Mbway.php`) — one required
  bundle field `mbway_number`. Checkout form `MbwayPaymentMethodAddForm` collects it (`#type => tel`,
  required; `createPaymentMethod()` only checks non-empty).
- Config: `mbway_key` (required), `callback_antiphishing` (required), `instructions`.
- `createPayment()` guards against a **duplicate push** (a checkout refresh during the ifthenpay call
  would push twice): `findLiveRequest()` looks for an authorization/completed payment on the same
  order within a 90s window and throws `DuplicatePaymentRequestException` instead of pushing again.
- `sendPaymentRequest()` (also called by the repayment service, bypassing the duplicate guard) POSTs
  `MbWayKey`/`canal=03`/`referencia=order_id`/`valor`/`nrtlm=mbway_number` to
  `https://mbway.ifthenpay.com/IfthenPayMBW.asmx/SetPedidoJSON` with `'verify' => TRUE`; on
  `Estado === '000'` it stores `IdPedido` as the remote id and sets state `authorization`; otherwise
  throws `HardDeclineException`.

## `ifthenpay_cc` — Credit card (`commerce_ifthenpay_cc`)

File `.../Plugin/Commerce/PaymentGateway/IfthenpayCC.php`. `OffsitePaymentGatewayBase`,
`payment_method_types = {credit_card}`, card types amex/maestro/mastercard/visa. Config: `cccard_key`
(required). Uses the gateway `mode` (test/live) to pick the endpoint.

- Off-site form `PluginForm/IfThenPayCCForm` (`offsite-payment`): POSTs order id/amount/success/
  error/cancel URLs (JSON) to `https://ifthenpay.com/api/creditcard/init/{cccard_key}` (or
  `/sandbox/init/`); on `Status == '0'` stores `RequestId` as remote id, sets state `authorization`,
  and redirects (via `NeedsRedirectException`, to avoid URL-encoding 403s) to the returned
  `PaymentUrl`. There is **no async notify** for CC — confirmation is the browser return
  (`onReturn()`), verified by security key + amount. See [callbacks.md](callbacks.md).
