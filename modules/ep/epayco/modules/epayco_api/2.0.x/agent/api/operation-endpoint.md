<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# /epayco/api/operation endpoint

`Drupal\epayco_api\Controller\Operation` (extends `ControllerBase`, injects `epayco.handler`). Route
`epayco_api.endpoint`: `POST /epayco/api/operation`, `_permission: execute epayco_api operations`.

## `process(ServerRequestInterface $request)`

Reads the parsed body. Requires non-empty `type` and `config`, else returns
`{status:'ERROR_INSUFFICIENT_DATA', result:[], message:…}`. Dispatches on `type`:

| `type` | Handler | `config` keys | Calls |
|--------|---------|---------------|-------|
| `factory:system` | `processFactoryOperation` | `factory` (id), `element`, `callback`, `params` (JSON) | loads `epayco_factory`, `getFactoryClientInstance()`, then `executeFactoryOperation()` |
| `factory:custom` | `processFactoryOperation` | `factory` = `{api_key, private_key, language, test}`, plus `element`, `callback`, `params` | `epayco.handler->getFactory(...)`, then `executeFactoryOperation()` |
| `transaction:info` | `processTransactionInfoOperation` | `id` | `getTransactionRemoteData($id)` |
| `reference:info` | `processReferenceInfoOperation` | `id` | `getReferenceRemoteData($id)` |
| `pse:banks` | `processPseBanksOperation` | `public_key` | `getAvailablePseBanks($public_key)` |

## Responses

Success: `{status:'OK', result: <data>}`. Errors return a `status` string such as `ERROR_INVALID_FACTORY_TYPE`,
`ERROR_INVALID_FACTORY`, `ERROR_MISSING_TRANSACTION_ID`, `ERROR_MISSING_REFERENCE_ID`, `ERROR_MISSING_PUBLIC_KEY`
with an empty `result` and a translated `message`. Everything is returned as `JsonResponse`.

## Notes

- The `factory` operations run an arbitrary `element`/`callback` pair on the ePayco SDK client via
  `GatewayHandler::executeFactoryOperation()` (blocks `__construct`, requires the SDK sub-object to exist), so this
  is a thin RPC over the SDK — intended for trusted callers only. Guard the `execute epayco_api operations`
  permission accordingly.
- `factory:custom` lets the caller supply raw ePayco credentials in the request body (by design, for ad-hoc
  clients).
