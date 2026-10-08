# JSON:API Schema — manual setup guide

**JSON:API Schema** (`jsonapi_schema`) publishes a machine-readable **JSON Schema**
(draft 2019-09 hyper-schema) describing every non-internal JSON:API resource your
site exposes. In other words, alongside core's JSON:API data endpoints, it adds
`.../schema` endpoints that tell a client the exact shape of each document,
resource object, and relationship the API serves. That lets front-ends and tooling
validate requests and responses, generate typed client code, power API explorers,
and keep contracts in sync as fields are added or removed.

For each resource type it exposes several schemas: an entrypoint schema listing all
locatable collections, an **individual document** schema, a **collection document**
schema, a **resource object** schema (mapping fields to attributes and
relationships, with a `type` constant), and **related** schemas for each
relationship. Only *enabled* JSON:API fields are included, so disabled fields are
correctly omitted. Responses are cacheable and are invalidated when your resource
types change, so the published schema always tracks the live API.

This is a developer- and integration-oriented module. It has **no configuration,
no permissions, and no Drush commands** — enable it and the schema endpoints appear
automatically. The schema routes are public (they describe structure, not data),
consistent with schema being metadata. If you also install the optional
[JSON:API Hypermedia](https://www.drupal.org/project/jsonapi_hypermedia) module,
this module advertises `targetSchema` / schema links directly in JSON:API responses
— no extra code needed.

This guide is written for a **human** (developer) setting the module up. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin page — the module has no configuration. Its schema endpoints hang
off your JSON:API base path (by default `/jsonapi`).

## How to use it

Once enabled, the schema endpoints are available immediately. They hang off the
JSON:API base path (default `/jsonapi`). For a resource type with path `<path>`
(for example `/node/article`):

| Endpoint | Returns |
|---|---|
| `/jsonapi/schema` | Entrypoint schema linking every locatable collection's schema. |
| `/jsonapi<path>/schema` | Schema for an **individual** resource document. |
| `/jsonapi<path>/collection/schema` | Schema for a **collection** document (listing). |
| `/jsonapi<path>/resource/schema` | Schema for the **resource object** itself (attributes/relationships, `type` const). |
| `/jsonapi<path>/resource/relationships/<field>/related/schema` | Document schema for resources reachable through relationship `<field>`. |

For example, fetch the resource-object schema for articles from
`/jsonapi/node/article/resource/schema`. To list every generated schema route on
your site, run `drush route | grep jsonapi_schema` (routes appear only for
non-internal resource types).

### Extending the schema output (developers)

Field-level schema shapes are produced by a chain of tagged **`schema_json`
normalizer** services (one per data type, plus a fallback). To customise or add
schema for a custom field/data type, register a normalizer service tagged
`{ name: normalizer, priority: N }` — with a higher priority than the normalizer
you want to override — that restricts itself to the `schema_json` format and your
data-definition type. See the sibling
[agent docs](../agent/extend/normalizers.md) for the full list and an example.
