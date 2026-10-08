<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce USAePay — agent index

**On-site** Drupal Commerce credit-card payment gateway for **USAePay**, talking to
USAePay's **SOAP** API (`ueSecurityToken` authentication). The customer enters card
details on your own checkout form; the module relays them server-side to USAePay
and records a `commerce_payment` against the order from the API response. Supports
authorize-only + capture, void, refund, and reusable stored payment methods
(USAePay customer vault).

- **Version** `2.0.0-beta3` (beta — pre-release; API/config may still change).
- **Package** `Commerce (contrib)`. **License** GPL-2.0-or-later.
- **Core** `^10 || ^11` (`commerce_usaepay.info.yml`).
- **Dependencies** `commerce:commerce_payment`; composer requires
  `drupal/commerce ^2.4 || ^3`.
- **Runtime requirement:** the PHP **`soap`** extension must be installed/enabled
  (the gateway builds a `\SoapClient`). No external Composer libraries.
- Covered by Drupal's security-advisory policy; project created 2012-10-26.

## What ships

Very small module — one plugin plus one helper service. No routes, no controllers,
no permissions, no webhook, no `.module`/`.install`, no JS/library, no templates.

- `src/Plugin/Commerce/PaymentGateway/USAePay.php` — the
  `@CommercePaymentGateway(id = "usaepay")` plugin. Extends
  `OnsitePaymentGatewayBase`, implements `USAePayInterface` and
  `ContainerFactoryPluginInterface`. `payment_method_types = {"credit_card"}`;
  credit-card types amex / dinersclub / discover / jcb / mastercard / visa. Holds
  the config form, all payment operations, the customer/payment-method vaulting,
  the per-call `getSoapClient()` factory, and the `buildToken()` auth helper.
- `src/Plugin/Commerce/PaymentGateway/USAePayInterface.php` — marker interface
  extending `OnsitePaymentGatewayInterface`, `SupportsAuthorizationsInterface`,
  `SupportsRefundsInterface`.
- `src/ErrorHelper.php` — service `commerce_usaepay.error_helper` (constructed with
  `@logger.factory`). Translates `\SoapFault`/`\Exception` and USAePay response
  `ResultCode`s into Commerce payment exceptions and logs to the
  `commerce_usaepay` channel.
- `commerce_usaepay.services.yml` — registers the error-helper service.
- `config/schema/commerce_usaepay.schema.yml` — typed config for the three gateway
  credential keys (`wsdl_key`, `source_key`, `pin`).

## Configuration (gateway plugin settings)

Set on the Commerce payment-gateway entity at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** → **USAePay**.
Keys/defaults from `defaultConfiguration()` (USAePay.php:90-96), all rendered as
required text fields by `buildConfigurationForm()` (USAePay.php:101-129):

| Key | Type | Notes |
| --- | --- | --- |
| `wsdl_key` | textfield (required) | The USAePay SOAP WSDL endpoint key (e.g. `ABCD1234`) created in the USAePay developer console; forms the WSDL URL. |
| `source_key` | textfield (required) | Merchant-account source key from the USAePay Merchant Console; identifies the merchant in `ueSecurityToken`. |
| `pin` | textfield (required) | PIN for the source key; hashed into the token. Mandatory here because the SOAP `sale` path requires it. |

Plus the standard Commerce gateway `mode` (test/live) and `display_label`.
**Mode mapping:** `getMode() === 'test'` targets `https://sandbox.usaepay.com`
(USAePay "Sandbox"); live targets `https://usaepay.com`. USAePay's separate "test"
mode is not supported — "Test" in the form means Sandbox (see README).

## SOAP client & authentication

- `getSoapClient()` (USAePay.php:76-85) builds a **fresh** `\SoapClient` per call
  from the WSDL URL (`{sandbox|www}.usaepay.com/soap/gate/<wsdl_key>/usaepay.wsdl`).
  Throws `\RuntimeException` if `wsdl_key` is empty. No client options are passed —
  TLS peer verification is left at PHP's secure `SoapClient` default.
- `buildToken()` (USAePay.php:477-500) builds USAePay's `ueSecurityToken`: a random
  `seed`, `PinHash = ['Type' => 'sha1', 'Seed' => seed, 'HashValue' =>
  sha1(source_key . seed . trim(pin))]`, plus `SourceKey` and the request
  `ClientIP`. Every SOAP call is authenticated with this token; credentials are not
  sent in the clear beyond the verified TLS channel.

## Payment operations (all in USAePay.php)

| Method | Lines | SOAP call(s) | State transition |
| --- | --- | --- | --- |
| `createPayment($payment, $capture)` | 155-205 | `runCustomerTransaction` with `Command` = `Sale` (capture) or `AuthOnly`; `Amount` = `$payment->getAmount()->getNumber()`, `Invoice`/`OrderID` from the order | `new` → `completed` (Sale) or `authorization` (AuthOnly); stores `RefNum` as `remoteId` |
| `capturePayment($payment, $amount?)` | 210-234 | `captureTransaction(token, refNum, number, 'ReAuth')` | `authorization` → `completed` |
| `voidPayment($payment)` | 239-253 | `voidTransaction(token, refNum)` | `authorization` → `authorization_voided` |
| `refundPayment($payment, $amount?)` | 258-284 | `refundTransaction(token, refNum, number)` | `completed`/`partially_refunded` → `partially_refunded` or `refunded` |
| `createPaymentMethod($payment_method, $payment_details)` | 289-328 | vaulting (below) | stores last-4/expiry locally, sets `remoteId` |
| `deletePaymentMethod($payment_method)` | 333-350 | `getCustomerPaymentMethods` + `deleteCustomerPaymentMethod` | deletes remote + local |

The charge amount is always taken **server-side** from the payment entity
(`getAmount()`), which Commerce derives from the order total — no request field
sets the amount. State transitions are guarded by `assertPaymentState()` /
`assertRefundAmount()`.

## Card data & customer vaulting

This is an **on-site** gateway: the customer's card fields
(`$payment_details['number']`, `['expiration']`, `['security_code']`) are collected
by Commerce's on-site payment-method form and handed to `createPaymentMethod()`,
which relays them server-side to USAePay:

- For an **authenticated** owner, a USAePay customer is created once
  (`createRemoteCustomer()`, `addCustomer`) and its customer number stored on the
  user via `setRemoteCustomerId()`; later cards update the billing address
  (`updateRemoteCustomerBilling()`). For **anonymous** checkout the customer number
  is kept in the `commerce_usaepay` private tempstore.
- The card itself is vaulted with `createRemotePaymentMethod()` →
  `addCustomerPaymentMethod` (`CardNumber`, `CardExpiration`, `CardCode`), and the
  returned id becomes the payment-method `remoteId`.
- Locally the module stores only the **last four digits**
  (`substr($payment_details['number'], -4)`), card type, and expiry on the
  `commerce_payment_method` entity — never the full PAN or CVV.

Serve checkout over HTTPS and meet the PCI obligations that apply to any gateway
where card details are entered on your own site.

## Error handling

`ErrorHelper` (src/ErrorHelper.php):
- `handleErrors($response)` maps USAePay `ResultCode`: `A` = approved (return);
  `D` = declined → `SoftDeclineException` / `HardDeclineException` (by `ErrorCode`
  lists) else `InvalidRequestException`; `E` = error → `InvalidRequestException`;
  `V` = verification/AVS → `DeclineException`.
- `handleException($e)` logs the `SoapFault` faultstring / exception message and
  rethrows as `PaymentGatewayException`. Only the error text is logged (channel
  `commerce_usaepay`) — never card fields or credentials.

## Security posture (positive)

The payment outcome is read from the **authenticated SOAP API response**
(`ResultCode`), not from any client field, and the charge **amount is taken
server-side** from the payment entity. Each SOAP call is authenticated with a
freshly built `ueSecurityToken` (`sha1(source_key + seed + pin)`). The SOAP client
is created without weakening options, so **TLS certificate verification uses PHP's
secure default**. The module exposes no custom route, controller, or webhook. Keep
the WSDL key, source key, and PIN confidential (store them via a settings/env
override rather than committing store config to VCS), and run checkout over HTTPS.

## See also

- `../usage.md` — task-oriented summary.
- `../human-docs/` — UI setup guide (installation, configuration) for site builders.
