# OpenAPI REST — manual setup guide

**OpenAPI REST** (`openapi_rest`) automatically generates an OpenAPI / Swagger 2.0
specification that describes every resource your site exposes through Drupal core's
**REST** module. Instead of hand-writing and maintaining an API contract, you enable
this module and get a machine-readable document that decoupled front ends, API-doc
UIs, testing tools, and client-SDK generators can all consume — and that stays in sync
automatically as you enable or disable REST resources.

Under the hood it is a plug-in for the **OpenAPI** module: it reads your site's
existing REST resource configuration, walks the routing system to find each resource's
real path, HTTP method, supported formats, and authentication providers, and builds
the OpenAPI `paths` section. For entity resources it uses the Schemata modules to
generate a JSON Schema for each entity type and bundle. The finished spec is served by
the OpenAPI module as JSON at `/openapi/rest?_format=json`, and if you also install an
OpenAPI UI module (such as Swagger UI or ReDoc) you can browse the same spec
interactively.

This is a developer/decoupled tool with **no settings form, no configuration page, and
no Drush commands of its own**. It works entirely by describing what core REST already
exposes — so the way you "configure" it is by enabling the REST resources you want
documented. It has several module dependencies (REST, OpenAPI, Schemata, and Schemata
JSON Schema), all installed for you by Composer.

This guide is written for a **human** installing the module and viewing the spec. If
you want terse, token-cheap references for an AI coding agent — the generator id, the
query options, and how paths and definitions are built — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   OpenAPI and Schemata dependencies) and enable the modules.

## Where it lives in the admin menu

OpenAPI REST adds no admin page of its own — it registers a **generator** with the
OpenAPI module. The OpenAPI module lists the available generators at **Configuration →
Web services → OpenAPI** (`/admin/config/services/openapi`), where the REST generator
appears once this module is enabled. The generated document itself is fetched at
`/openapi/rest?_format=json`.

## How to use it

There is nothing to configure on the module itself — you drive its output by managing
your REST resources:

1. **Enable and configure REST resources.** The spec only documents **enabled** REST
   resources, so first turn on the ones you want to expose (using core REST plus, for
   a UI, the contrib REST UI module). Every resource you enable appears in the spec;
   every one you disable drops out.
2. **Fetch the spec.** Request `GET /openapi/rest?_format=json`. This route is
   provided by the OpenAPI module and is gated by its **Access OpenAPI api docs**
   permission, so grant that permission to whoever (or whatever service) needs the
   document. You can narrow the output with the query options `entity_type_id`,
   `bundle_name`, and `resource_types=entities`.
3. **Browse it interactively (optional).** Install an OpenAPI UI module — Swagger UI or
   ReDoc — to render the same generator's output as a browsable, always-current API
   reference at `/admin/config/services/openapi`.
4. **Feed it into your toolchain.** Import the JSON into Postman or Insomnia, generate
   client SDKs with `openapi-generator`/`swagger-codegen`, or run contract tests in CI
   against it. Because the document is regenerated from live config, it always
   reflects the site's current REST surface.

For the generator id and how to call it programmatically, see the
[`agent/`](../agent/start.md) docs.
