<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePayco API operations (epayco_api) — agent index

Experimental submodule of **ePayco**. Adds one POST endpoint that runs ePayco SDK operations / REST lookups via
the base `epayco.handler` service. Package `ePayco (Experimental)`. Core `^8.7.7 || ^9 || ^10 || ^11`.
GPL-2.0-or-later. Version-dir 2.0.x (`^2.0@dev` checkout). Depends on `epayco:epayco`.

## What it provides

- **Route `epayco_api.endpoint`** — `POST /epayco/api/operation`, controller
  `Drupal\epayco_api\Controller\Operation::process`, requirement `_permission: execute epayco_api operations`.
- **Permission** `execute epayco_api operations` (`epayco_api.permissions.yml`).

No config, no schema, no services of its own, no Drush.

## Endpoint contract → [api/operation-endpoint.md](api/operation-endpoint.md)

Body must include non-empty `type` and `config`. `type` ∈ `factory:system`, `factory:custom`, `transaction:info`,
`reference:info`, `pse:banks`. Returns `JsonResponse` with `status`/`result` (and `message` on error).

## Solution docs

- [api/operation-endpoint.md](api/operation-endpoint.md) — the operation types, payloads and responses.
