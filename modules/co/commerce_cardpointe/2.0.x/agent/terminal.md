<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integrated terminal (Clover Flex) — entity, admin UI & Terminal API

Optional card-present path. Enabled by adding the `cardpointe_credit_card_terminal` payment-method type
to the gateway and configuring `terminal.site` + `terminal.api_key`.

## Terminal config entity — `commerce_cardpointe_terminal`

`src/Entity/Terminal.php` (+ `TerminalInterface`). A content/config entity representing one registered
Clover Flex device, keyed by **HSN** (hardware serial number), bound to a `commerce_payment_gateway`.

- **Storage** `TerminalStorage` (`TerminalStorageInterface`): `loadMultipleByPaymentGateway()`.
- **Access** `TerminalAccessControlHandler` + `Access/TerminalViewAccessCheck` — gates on the
  `manage commerce_cardpointe terminals` permission and the parent gateway's access; `view own` path for
  the terminal owner; update/delete blocked while the terminal is locked (an `unlock` op re-checks).
- **List/forms** `TerminalListBuilder`, `Form/TerminalForm`, `Form/TerminalDeleteForm`,
  `Form/RefreshTerminalsForm` (pulls the device list from the Terminal API and syncs local entities).
- **Validation constraints** `Plugin/Validation/Constraint/TerminalNameUnique` + `TerminalHsnUnique`.
- **Routes** (`.routing.yml`) under `/admin/commerce/config/payment-gateways/manage/{commerce_payment_gateway}/terminals`
  (`collection`, `add`, `refresh`); requirements use `_entity_create_any_access` /
  `_entity_access: commerce_payment_gateway.update`. Views config in `config/install`, templates + CSS.

## Terminal payment flow — `PaymentMethodAddForm::buildCreditCardTerminalForm()` / `terminalAuthSubmit()`

The add-payment-method form (terminal bundle) shows a terminal selector + **Authorize Card** /
**Disconnect** AJAX buttons. Session key + HSN are held in the PHP session. `terminalAuthSubmit()`:
ping/reconnect as needed → `dateTime()` sync → `authCard($order)`. On approval it creates the
`commerce_payment`, stores the payment method (type/last4/expiry from the terminal result), updates the
order's total-paid, and redirects to the payment collection. Amount charged is the **server-side order
balance**.

## Terminal API client — `src/IntegratedTerminalApi.php`

Endpoint (`getEndpoint`): `https://{terminal.site}{-uat}.cardpointe.com/api/`. Auth header
`Authorization: {terminal.api_key}` plus `x-cardconnect-sessionkey` after connect. Methods map to the
CardConnect Terminal API: `listTerminals` (v1), `terminalDetails` (v3), `connect`/`disconnect`/`ping`/
`dateTime`/`display`/`cancel` (v2), `authCard` (v3). `authCard` builds its `amount` from
`$order->getBalance()` via `toMinorUnits()` (server-side), `capture` from the gateway `intent`. Uses the
core Guzzle `http_client` (default TLS verification). A rich exception hierarchy
(`src/Exception/*`) maps API error strings to typed exceptions (`InvalidSessionKeyException`,
`NoRequestQueueRegisteredException`, `TerminalInUseException`, `TerminalCredentialsException`, …).
Request/response debug logging is gated by the same `log.request` / `log.response` settings.
