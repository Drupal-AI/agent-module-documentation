# OpenAPI JSON:API — manual setup guide

**OpenAPI JSON:API** (`openapi_jsonapi`) generates an OpenAPI (Swagger 2.0)
specification that describes your Drupal site's **JSON:API** endpoints. OpenAPI is
the industry-standard, machine-readable way to describe a web API; once you have a
spec, front-end and mobile developers can generate typed API clients, import the
API into Postman or Insomnia, browse interactive docs, and run contract tests —
all from a single self-describing document.

The base [OpenAPI](https://www.drupal.org/project/openapi) module provides the
framework but ships no "generators" of its own. This module is one such generator:
it inspects your live JSON:API routes and, for every resource type (each entity
type and bundle), produces the OpenAPI paths for the collection, individual,
related, and relationship endpoints, complete with their query parameters
(`filter`, `sort`, `page`, `include`, `resourceVersion`), request bodies, and
responses. The payload schemas for each bundle come from the **Schemata** modules.

This is a developer-facing bridge module with **no configuration of its own** — no
settings form, no permissions, no Drush commands. All of its behavior is inherited
from the OpenAPI and JSON:API modules it builds on. Once enabled, the spec is
available at `/openapi/jsonapi`. It requires Drupal 10 or 11, and it depends on the
JSON:API, OpenAPI, Schemata, and Schemata JSON Schema modules (Composer pulls the
non-core ones in). It has no submodules.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the generator plugin, the download
options, and the read-only behavior — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

There is no settings page. The generated spec and its viewers live under the
OpenAPI module's area at **Configuration → Web services → OpenAPI**
(`/admin/config/services/openapi`), where a **JSON:API** row offers View and
Download links. Access is gated by the OpenAPI module's *Access OpenAPI API docs*
permission.

## How to use it

Once the module is enabled, the JSON:API OpenAPI spec is generated on demand:

- **Download the raw spec** as JSON from `/openapi/jsonapi`. Feed it into
  openapi-generator or swagger-codegen to build an API client, or import it into
  Postman/Insomnia.
- **Browse interactive docs** — if you also install the **OpenAPI UI** module (with
  a Redoc or Swagger UI plugin), the docs are viewable at
  `/admin/config/services/openapi/{ui}/jsonapi`.

You can narrow the output with query options on the download URL, for example
`/openapi/jsonapi?_format=json&options[entity_type_id]=node` to document only node
resources, or `options[entity_mode]=content_entities` to limit it to content
entities, or `options[exclude][]=ENTITY_TYPE--BUNDLE` to omit specific resources.

Two behaviors worth knowing:

- **Read-only mode.** JSON:API's own `read_only` setting (on by default) controls
  what is documented. When it is on, only read endpoints (GET/HEAD/OPTIONS/TRACE)
  appear; turn it off to include the create/update/delete endpoints too.
- **Internal resources are excluded** automatically — JSON:API resource types
  marked internal (disabled) never appear in the spec.

> Tip: on complex sites, generating the whole-site spec can fail if a relationship
> points at an internal/disabled resource type. If that happens, scope the request
> to a concrete type (for example `?options[entity_type_id]=node`), which sidesteps
> the problem.
