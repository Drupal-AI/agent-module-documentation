<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco Business Rules plugins

## Reacts-on: "Transaction response" (`transaction_response`)

`Plugin/BusinessRulesReactsOn/GatewayTransactionResponse`. Site builders attach a Business Rule to this event.
The event subscriber `EventSubscriber/TransactionResponseListener::onTransactionResponse()` listens for
`GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` (priority 1000) and dispatches a `BusinessRulesEvent`
carrying the ePayco transaction data under `arguments['epayco']['transaction_data']`, using the reacts-on
definition's `eventName`.

## Variable: "ePayco payment info" (`epayco_empty_payment`)

`Plugin/BusinessRulesVariable/EmptyPaymentVariable`. An empty payment-info variable; the "Fetch payment" action
fills it. The sample structure comes from `RemotePaymentProcessingTrait::getEmptySamplePaymentData()`, which lists
the ePayco `x_*` response fields (e.g. `x_ref_payco`, `x_amount`, `x_response`, `x_cod_response`,
`x_transaction_state`, billing/customer fields).

## Action: "Fetch payment" (`epayco_fetch_payment`)

`Plugin/BusinessRulesAction/FetchPaymentAction` (uses `RemotePaymentProcessingTrait`). Settings:

- `variable` — which `epayco_empty_payment` variable to fill.
- `reference_origin` — where the payment reference comes from: `custom`, `path_argument` (N-th path fragment),
  `query_string` (a query key), or `event_argument` (from the parent "Transaction response" event).
- `reference_value` — the value/reference (required unless `event_argument`; must be a positive integer for
  `path_argument`).

`fetchPaymentVariables()` resolves the reference per `reference_origin`. For `event_argument` it reads
`epayco.transaction_data` from the event; otherwise it calls `epayco.handler->getTransactionRemoteData($reference)`.
The result is normalized with `normalizePaymentData($data, '->')` and written back into the variable set: the base
variable gets the raw array, and each `variable->subkey` gets the matching flattened scalar value.

Config schema (`config/schema/epayco_business_rules.schema.yml`): `business_rules.action.type.epayco_fetch_payment`
(`variable`, `reference_origin`, `reference_value`) and `business_rules.variable.type.epayco_empty_payment`.
