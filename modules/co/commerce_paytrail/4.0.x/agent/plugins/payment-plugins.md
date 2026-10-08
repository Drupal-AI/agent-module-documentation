<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment plugins provided

Commerce Paytrail defines no new plugin *types*; it implements existing Commerce plugin types.

## Payment gateway plugins (`@CommercePaymentGateway`)

| id | Label | Class | Base | payment_method_types |
|---|---|---|---|---|
| `paytrail` | Paytrail | `Plugin/Commerce/PaymentGateway/Paytrail` | `PaytrailBase` → `OffsitePaymentGatewayBase` | `paytrail` |
| `paytrail_token` | Paytrail (Credit card) | `Plugin/Commerce/PaymentGateway/PaytrailToken` | `PaytrailBase` | `paytrail_token` |

Both extend abstract **`PaytrailBase`** (implements `PaytrailInterface extends
OffsitePaymentGatewayInterface, SupportsRefundsInterface`). Both set
`requires_billing_information = FALSE`.

- **`paytrail`** — redirect flow. Off-site form `PaytrailOffsiteForm` calls the API to fetch
  available payment providers/groups and renders a submit button per provider; selecting one POSTs
  to that provider's URL (`REDIRECT_POST`). `onReturn()`/`onNotify()` → `handlePayment()` creates a
  payment, authorizes, and captures when the API status is `ok`.
- **`paytrail_token`** — tokenized card. Implements `SupportsStoredPaymentMethodsInterface`,
  `SupportsVoidsInterface`, `SupportsAuthorizationsInterface` (in addition to refunds).
  `credit_card_types = {amex, mastercard, visa}`. Off-site form `PaytrailTokenForm` POSTs to
  `…/tokenization/addcard-form`. On return it fetches the card for the tokenization id, stores a
  `commerce_payment_method`, then runs a **MIT** (merchant-initiated) authorize and optional
  capture. Supports `voidPayment()` (revert auth hold), `capturePayment()`, `deletePaymentMethod()`.

### Notable `PaytrailBase` methods
- `getAccount(): int`, `getSecret(): string`, `getLanguage(): string` (auto-maps site langcode
  fi/sv → FI/SV, else EN), `isLive(): bool` (`mode === 'live'`).
- `getReturnUrl()`, `getCancelUrl()` → `commerce_payment.checkout.return|cancel`;
  `getNotifyUrl()` → `commerce_payment.notify` (all absolute).
- `getClient(): PaytrailClient` (memoized), built by `PaytrailClientFactory`.
- `onNotify()` short-circuits `event=refund-success|refund-cancel` with a bare 200, else delegates
  to the gateway's `onNotifySuccess()`.
- `refundPayment()` (from `SupportsRefundsInterface`) — asserts state completed/partially_refunded,
  validates the refund amount, refunds via `RefundRequestBuilder`, sets refunded/partially_refunded.

## Payment method type plugins (`@CommercePaymentMethodType`)

| id | Class |
|---|---|
| `paytrail` | `Plugin/Commerce/PaymentMethodType/Paytrail` |
| `paytrail_token` | `Plugin/Commerce/PaymentMethodType/PaytrailToken` |

The `paytrail_token` bundle (fields: `card_type`, `card_number`, `card_exp_month`, `card_exp_year`)
is installed by update hook `commerce_paytrail_update_9002` for sites upgrading from earlier
versions.

## Off-site plugin forms

- `PluginForm/OffsiteRedirect/PaytrailOffsiteForm` — provider selection + `REDIRECT_POST`.
- `PluginForm/OffsiteRedirect/PaytrailTokenForm` — add-card `REDIRECT_POST` to Paytrail
  tokenization endpoint. Reads `$form['#capture']` (checkout flow transaction mode).
