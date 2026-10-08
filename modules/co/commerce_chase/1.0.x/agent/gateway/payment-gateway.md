<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# chase_hpf payment gateway plugin

`src/Plugin/Commerce/PaymentGateway/HostedPaymentForm.php` — plugin id **`chase_hpf`**, extends
`OnsitePaymentGatewayBase`.

## Plugin annotation

```
id = "chase_hpf"
label / display_label = "Orbital® Hosted Payment Form"
forms = { "add-payment-method" = HostedPaymentFormForm }
payment_method_types = {"credit_card"}
credit_card_types = { amex, dinersclub, discover, jcb, maestro, mastercard, visa }
requires_billing_information = TRUE
```

`create()` injects `logger.channel.commerce_payment` into `$this->logger`.

## Configuration form

`defaultConfiguration()` keys: `api_username`, `api_password`, `hosted_secure_id`, `merchant_id`,
`terminal_id` (default `001`), `bin` (default `000002`), `allowed_types` (all card labels),
`required` (default `minimum`) — plus the base plugin config (`mode`, `display_label`, etc.).

`buildConfigurationForm()` renders:

| Field | `#type` | Notes |
|---|---|---|
| `hosted_secure_id` | textfield (required) | "Secure Account ID" — the merchant's Hosted Payment account |
| `api_username` | textfield (required) | Orbital connection username |
| `api_password` | textfield (required) | Orbital connection password |
| `terminal_id` | textfield (required) | Orbital Gateway TerminalID |
| `merchant_id` | textfield (required) | Orbital Merchant ID (distinct from login username) |
| `bin` | select | `000001` Stratus / `000002` PNS |
| `allowed_types` | checkboxes | Card-icon options shown on the form |
| `required` | radios | `minimum` (number + expiry required) or `all` (all fields required) |

`submitConfigurationForm()` copies each value back into `$this->configuration`. Config is stored as
plain payment-gateway plugin configuration (no Key entity, no config schema shipped by the module).

## Endpoints

- `serviceUrl()` — HPF base for building the iframe URL: test
  `https://www.chasepaymentechhostedpay-var.com/hpf/1_1/`, prod
  `https://www.chasepaymentechhostedpay.com/hpf/1_1/`. (Mode `test` matches; only `prod` matches the
  production branch — a gateway left in the default `live` mode returns `''` here unless mode is
  literally `prod`.)
- `initUrl()` — HPF init URLs (test/prod). Present but not referenced elsewhere in this version.
- `getJsLibrary()` — returns `commerce_chase/hosted-payment-form-live` in `live` mode, else `-test`.
- SOAP WSDL is chosen in `SoapGateway::getWsdl()` (see api/orbital-soap.md).

## Payment lifecycle

- **`createPayment(PaymentInterface $payment, $capture = TRUE)`** — asserts state `new`, builds a
  `SoapGateway` for the payment's gateway, and sends a `ChargeProfile` (`NewOrder`) with
  `order_id`, `payment_method`, `price = $payment->getAmount()`, `capture`. `\SoapFault`s are mapped
  to Commerce exceptions by numeric Orbital response code: `HardDecline` (1003–1008),
  `SoftDecline`, `InvalidRequest`, else `PaymentGatewayException` (large explicit code lists +
  ranges). On success it inspects `$response->return->approvalStatus`: `'0'` → HardDecline, `'2'` →
  InvalidResponse; otherwise sets state to `completed` (capture) or `authorization` (auth-only),
  stores `txRefNum` as the payment remote id, saves. **If the payment method is not reusable**, it
  immediately `ProfileDelete`s the remote profile and blanks the local `remote_id`.
- **`capturePayment($payment, Price $amount = NULL)`** — asserts `authorization`; sends
  `MarkForCapture` with the payment and `toMinorUnits($amount ?: $payment->getAmount())`. Failures
  are logged (`logger->warning`) and re-thrown as a generic `PaymentGatewayException`.
- **`voidPayment($payment)`** — asserts `authorization`; sends `VoidTransaction` (`Reversal`).
  Same logging/exception handling.
- **`deletePaymentMethod($payment_method)`** — sends `ProfileDelete` for the remote id, then deletes
  the local payment method entity.
- **`createPaymentMethod($payment_method, array $payment_details)`** — requires `card_type`,
  `card_number`, `expiration_month`, `expiration_year`, `remote_id` (throws
  `InvalidArgumentException` if any empty). Maps the Chase card-type label via `mapCreditCardType()`,
  stores `card_number` (the masked value from the tokenizer), expiry, sets the remote id
  (the `customerRefNum` token) and computed expiry timestamp, saves. No full PAN or CVV is stored.

`mapCreditCardType()` maps Chase labels (`American Express`, `Diners Club`, `Discover`, `JCB`,
`Mastercard`, `Visa`) to Commerce card-type ids; an unknown label throws `HardDeclineException`.

## Cron

`commerce_chase_cron()` finds `chase_hpf` gateways, then non-reusable payment methods with a
`remote_id` that are **not** attached to a non-draft order, and for each sends a `ProfileDelete`
(swallowing exceptions) and blanks the local `remote_id`. This garbage-collects stored Orbital
profiles for one-off cards.
