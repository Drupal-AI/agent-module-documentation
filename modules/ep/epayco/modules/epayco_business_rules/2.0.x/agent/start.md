<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco Business Rules (epayco_business_rules) — agent index

Business Rules integration submodule of **ePayco**. Package `ePayco`. Core `^8.7.7 || ^9` (info.yml — not 10/11).
GPL-2.0-or-later. Version-dir 2.0.x (`^2.0@dev` checkout). Depends on `epayco:epayco` and
`business_rules:business_rules`.

## What it provides

- **Action plugin** `epayco_fetch_payment` — `Plugin/BusinessRulesAction/FetchPaymentAction` ("Fetch payment"):
  queries ePayco for payment data and writes it into an empty variable.
- **Variable plugin** `epayco_empty_payment` — `Plugin/BusinessRulesVariable/EmptyPaymentVariable`
  ("ePayco payment info"): the target variable holding a payment-data sample structure.
- **Reacts-on plugin** `transaction_response` — `Plugin/BusinessRulesReactsOn/GatewayTransactionResponse`
  ("Transaction response"): a Business Rules event driven by ePayco's transaction event.
- **Event subscriber** `epayco_business_rules.transaction_response`
  (`EventSubscriber/TransactionResponseListener`) — subscribes to
  `GatewayTransactionEvents::EPAYCO_TRANSACTION_RESPONSE` (priority 1000) and re-dispatches it as the
  `transaction_response` Business Rules event.
- **Trait** `RemotePaymentProcessingTrait` — `getEmptySamplePaymentData()` (the ePayco `x_*` field template) and
  `normalizePaymentData()` (flattens to `key->subkey` with value/type).
- **Config schema** `config/schema/epayco_business_rules.schema.yml` (variable + action mappings).

No permissions, routes, Drush.

## Solution docs

- [plugins/business-rules.md](plugins/business-rules.md) — the action, variable, reacts-on event and data flow.
