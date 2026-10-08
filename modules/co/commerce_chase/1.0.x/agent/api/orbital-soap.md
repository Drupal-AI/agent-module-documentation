<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orbital SOAP API client (ChaseOrbitalApi/)

A thin wrapper over PHP's `\SoapClient` for the Chase Orbital / Paymentech gateway.

## SoapGateway (factory)

`src/ChaseOrbitalApi/SoapGateway.php`. Constructed from a `PaymentGatewayInterface`; throws
`ChaseOrbitalApi\Exception\Gateway` if the gateway plugin id is not `chase_hpf`. Factory methods
return request objects: `chargeProfile()` → `ChargeProfile`, `captureTransaction()` →
`MarkForCapture`, `voidTransaction()` → `VoidTransaction`, `profileFetch()` → `ProfileFetch`,
`profileDelete()` → `ProfileDelete`. `getGateway()` exposes the entity; `getWsdl()` returns the
WSDL by mode:

- live: `https://ws1.chasepaymentech.com/PaymentechGateway/wsdl/ChasePaymentechGateway.wsdl`
- else (test): `https://wsvar1.chasepaymentech.com/PaymentechGateway/wsdl/ChasePaymentechGateway.wsdl`

## RequestBase / RequestInterface

`RequestBase` implements the flow: its constructor creates `new \SoapClient($gateway->getWsdl(),
['exceptions' => TRUE, 'trace' => TRUE])` (default TLS certificate verification — not disabled).
`send(array $data)` validates required keys (`validateParameters`), builds the request body via the
subclass `getParameters()`, and calls `$soapClient->{getRequestType()}(new \SoapParam(...))`.
`getMinorUnitsConverter()` returns `commerce_price.minor_units_converter`. Subclasses implement
`getParameters()`, `getRequiredKeys()`, `getRequestType()`.

## Request classes

| Class | `getRequestType()` | Required keys | Purpose / notable fields |
|---|---|---|---|
| `ChargeProfile` | `NewOrder` | payment_method, price, capture, order_id | Charges a stored profile. `transType = AC` (capture) or `A` (auth); `useCustomerRefNum` = payment method remote id (token); `amount` = `toMinorUnits(price)`; `ccExp` from stored expiry; AVS fields from billing profile; `mitStoredCredentialInd = Y`, `mitMsgType = CSTO`, `industryType = EC`, `version = 4.0`. |
| `MarkForCapture` | `MarkForCapture` | payment, amount | `amount` = `toMinorUnits(amount)`, `orderID`, `txRefNum` = payment remote id. |
| `VoidTransaction` | `Reversal` | payment | `txRefNum` = payment remote id; empty `txRefIdx`. |
| `ProfileFetch` | `profileFetch` | remote_id | Sends `orbitalConnectionUsername`/`orbitalConnectionPassword`, `customerRefNum`. |
| `ProfileDelete` | `ProfileDelete` | remote_id | Sends `orbitalConnectionUsername`/`orbitalConnectionPassword`, `customerRefNum`. |

All requests include `bin`, `version = 4.0`, `merchantID` from gateway config. `ChargeProfile`
also derives AVS values from the payment method billing profile — note `avsCity` is populated with
`given_name . ' ' . family_name` (the cardholder name) rather than the locality, and
`avsCountryCode` is blanked unless the country is one of `US/UK/CA/GB`.

Amounts are always taken from the server-side Commerce `Price` (payment amount) and converted with
the minor-units converter; no amount originates from the browser.

## Exceptions

`Exception/ChaseException` (extends `\Exception`) is the base; `Exception/Gateway` (extends it) is
thrown when a non-`chase_hpf` gateway is passed to `SoapGateway`. Orbital response/`\SoapFault`
codes are translated to Commerce payment exceptions in the gateway plugin (see
gateway/payment-gateway.md), not here.
