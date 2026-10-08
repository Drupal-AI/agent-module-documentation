<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Schema HTTP endpoints

Routes are generated at runtime (`src/Routing/Routes.php`) for **every non-internal** JSON:API
resource type, hanging off the JSON:API base path (default `/jsonapi`; whatever `jsonapi.base_path`
is). All schema routes carry `_access: 'TRUE'` — they are **public** (structure only, not data).
Responses are `application/json` JSON Schema documents (`$schema: https://json-schema.org/draft/2019-09/hyper-schema`).

## Paths & route names

Given a resource type with type name `<type>` (e.g. `node--article`) and path `<path>`
(e.g. `/node/article`):

| Path | Route name | Returns |
|---|---|---|
| `/jsonapi/schema` | `jsonapi_schema.entrypoint` | Entrypoint hyper-schema linking every locatable collection's schema. |
| `/jsonapi<path>/schema` | `jsonapi_schema.<type>.item` | Schema for an **individual** resource document (`data` = one resource object). |
| `/jsonapi<path>/collection/schema` | `jsonapi_schema.<type>.collection` | Schema for a **collection** document (`data` = array of resource objects). Only for locatable types. |
| `/jsonapi<path>/resource/schema` | `jsonapi_schema.<type>.type` | Schema for the **resource object** itself: `type` const + `attributes`/`relationships` definitions. |
| `/jsonapi<path>/resource/relationships/<field>/related/schema` | `jsonapi_schema.<type>.<field>.related` | Document schema for the resource(s) reachable through relationship `<field>`. |

## What the resource-object schema contains

`getResourceObjectSchema()` composes:
- `allOf` referencing the canonical JSON:API resource schema (`https://jsonapi.org/schema#/definitions/resource`).
- `definitions.type` = `{ "const": "<type>" }`.
- `definitions.attributes` / `definitions.relationships` built from the resource type's **enabled**
  fields only (disabled JSON:API fields are omitted); both get `additionalProperties: false`.
- Relationship entries carry hyper-schema `links` with `targetSchema` pointing at the related
  resource's schema route.

## Notes

- Multiple target resource types on a relationship produce an `anyOf` of resource-object `$ref`s.
- Titles are humanised from entity-type + bundle labels (`getSchemaTitle()`).
- To enumerate all schema routes: `drush route | grep jsonapi_schema` (they appear only for
  non-internal resource types).
