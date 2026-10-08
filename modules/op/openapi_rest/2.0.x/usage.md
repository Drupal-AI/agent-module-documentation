<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAPI REST plugs into the OpenAPI module to auto-generate a Swagger 2.0 / OpenAPI specification describing every resource exposed by Drupal core's REST module, so decoupled clients and API-doc UIs can consume the site's REST API.

---

The module is a single `@OpenApiGenerator` plugin (id `rest`) contributed to the `openapi` module. It has no settings form, no configure route, and no config or schema of its own — it works entirely by reading the site's existing `rest_resource_config` entities (the config the core REST module and the REST UI produce) and describing them. For each enabled REST resource it walks the routing system to find the real route, HTTP method, path parameters, supported `_format` MIME types, and authentication providers, then emits an OpenAPI 2.0 `paths` section. For entity resources it uses the `schemata` / `schemata_json_schema` modules' `SchemaFactory` to build a JSON Schema `definitions` block for each entity type and bundle (bundles are expressed with OpenAPI `allOf` polymorphism). The finished spec is served as JSON by the openapi module at `/openapi/rest?_format=json` (gated by the `access openapi api docs` permission) and listed at `/admin/config/services/openapi`; if an `openapi_ui` module (e.g. Swagger UI or ReDoc) is installed it can render the same generator interactively. Because it only describes what core REST already exposes, enabling or disabling a REST resource immediately changes the generated document. It supports query options `entity_type_id`, `bundle_name`, and `resource_types=entities` to scope the output.

---

- Generate an OpenAPI/Swagger 2.0 spec for a Drupal site's core REST API without hand-writing it.
- Feed the `/openapi/rest?_format=json` document into Swagger UI or ReDoc (via an `openapi_ui` module) for interactive API docs.
- Give a decoupled/headless front-end team a machine-readable contract for the REST endpoints.
- Auto-generate client SDKs with `swagger-codegen`/`openapi-generator` from the produced spec.
- Document the exact path, method, and `_format` for each enabled REST resource.
- Expose JSON Schema `definitions` for every REST-enabled entity type using schemata.
- Show bundle-specific schemas (e.g. Article vs Page) via OpenAPI `allOf` polymorphism.
- Surface which authentication providers (basic_auth, cookie, oauth2) secure each resource.
- Provide QA/testing tools a spec to validate REST responses against.
- Keep API documentation automatically in sync as REST resources are enabled or disabled.
- Scope generated output to one entity type with the `entity_type_id` option.
- Scope generated output to a single bundle with the `bundle_name` option.
- Restrict the spec to entity resources only with `resource_types=entities`.
- Import the spec into Postman or Insomnia to explore the REST API.
- Publish an API reference page for internal or partner developers.
- Audit which core entities are reachable over REST from a single document.
- Discover the request-body schema required to POST or PATCH an entity resource.
- Verify the CSRF/token security requirements of REST write operations from the spec.
- Drive contract tests in CI against the generated OpenAPI document.
- Compare REST API surface across environments by diffing the generated specs.
- Onboard new developers with a browsable, always-current REST API description.
- Combine with `openapi_jsonapi` on the same site to also document the JSON:API surface (separate generator).
