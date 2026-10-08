OpenAPI generates an OpenAPI (Swagger 2.0) specification document describing a Drupal site's web-service API surface, so the endpoints can be consumed by standard OpenAPI tooling. It is a framework: it defines an `openapi_generator` plugin type but ships no generators itself — you install an integration module (OpenAPI REST and/or OpenAPI JSON:API) to describe actual endpoints.

---

The module exposes downloadable JSON specification documents at `/openapi/{generator}` (permission-gated by `access openapi api docs`, `_format: json`) and an admin landing page at `/admin/config/services/openapi` (route `openapi.downloads`) that lists every available generator with View/Download links. Each generator is an `openapi_generator` plugin whose class extends `OpenApiGeneratorBase`; the base class assembles the spec skeleton (`swagger: "2.0"`, info, host, basePath, security definitions derived from the site's authentication providers, tags, definitions, consumes/produces, paths) and subclasses fill in `getPaths()`, `getDefinitions()`, `getApiName()` and `getApiDescription()`. A param converter turns the `{openapi_generator}` route slug into a plugin instance, and request `options` (e.g. `exclude`, `entity_mode`, `entity_type_id`, `bundle_name`) filter which entity types and bundles appear. The core module has no configuration form and no default config; the only dependency is core's Serialization module. To render the spec in a browser you additionally install the separate OpenAPI UI project (Redoc / Swagger UI), which enables the `openapi.documentation` route (`/admin/config/services/openapi/{ui}/{generator}`). Because it produces a portable spec, the output feeds Swagger Editor, Swagger Codegen, Postman, and any OpenAPI-aware client generator. Without any generator plugin installed the downloads page shows a warning prompting you to enable OpenAPI REST or OpenAPI JSON:API.

---

- Publish a machine-readable OpenAPI/Swagger 2.0 spec describing your Drupal REST or JSON:API endpoints.
- Give frontend/mobile teams a downloadable contract for a decoupled Drupal backend.
- Feed the generated JSON into Swagger Editor to browse and refine API documentation.
- Generate typed API client SDKs with Swagger Codegen / OpenAPI Generator from the spec.
- Import the spec into Postman or Insomnia to scaffold request collections.
- Expose interactive API docs in-site by pairing with the OpenAPI UI module (Redoc or Swagger UI).
- Provide a stable download URL (`/openapi/rest`, `/openapi/jsonapi`) that CI can pull for contract testing.
- Detect breaking API changes by diffing successive spec downloads in a pipeline.
- Document available authentication schemes (basic_auth, OAuth2, CSRF token) automatically from enabled auth providers.
- Restrict who can view API documentation via the `access openapi api docs` permission.
- Limit a spec to content entities or config entities only using the `entity_mode` option.
- Scope a spec to a single entity type or bundle via `entity_type_id` / `bundle_name` options.
- Exclude sensitive entity types or bundles from published docs with the `exclude` option.
- Build a custom generator plugin to document a bespoke REST module or contributed API.
- Alter or extend discovered generators through the `hook_openapi_generator_alter()` alter hook.
- Programmatically obtain a spec array by loading a generator plugin and calling `getSpecification()`.
- List all available generators in code via the `plugin.manager.openapi.generator` service.
- Offer an admin "API Resources" landing page under Config → Web services for site builders.
- Onboard third-party integrators with self-service, standards-based API reference docs.
- Drive automated mock servers (e.g. Prism) from the exported specification.
- Validate API responses against the published schema definitions in tests.
- Serve JSON:API and core REST specs side by side by enabling both integration modules.
- Version-control the exported spec as an artifact alongside application code.
- Provide OAuth2 flow metadata (authorization/token URLs) in the spec for API consumers.
- Convert the entity/bundle model definitions into request/response schemas for client tooling.
