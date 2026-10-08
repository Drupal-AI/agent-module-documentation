JSON:API Extras layers limited configuration on top of Drupal core's zero-config JSON:API, letting you rename resource types and fields, change paths, disable resources/fields, and transform field output through enhancer plugins.

---

Core JSON:API deliberately exposes every entity type and field with no configuration, which leaks Drupal's internal naming (`node--article`, `field_body`) and structure to API consumers. JSON:API Extras makes that surface configurable without giving up the automatic implementation. It decorates the JSON:API resource-type repository so that, per resource, you can override the **resource type name**, the **URL path**, disable the resource entirely, and for each field: rename its public name, hide it, or attach an **enhancer** that reshapes the value on the way out and back (date formatting, JSON string parsing, nested-value extraction, single-value flattening, entity/UUID link rewriting). These overrides are stored as `jsonapi_resource_config` config entities, so they are exportable and deployable. A global settings form controls the API path prefix (default `jsonapi`), whether collections include a total count, whether resources are disabled by default (a whitelist approach for locking down the API), and configuration-integrity validation. Field enhancers are a plugin type (`ResourceFieldEnhancer`) you can extend, built on the Shaper transformation library. A helper service, `EntityToJsonApi`, renders any entity to its JSON:API representation in PHP without an HTTP round-trip. Its `jsonapi_defaults` submodule adds default includes/filters/sorting per resource. It is a cornerstone module for decoupled/headless Drupal builds.

---

- Rename `node--article` to a clean `article` resource type.
- Expose `field_body` as `body` to hide Drupal's field naming.
- Change the API path prefix from `/jsonapi` to `/api`.
- Give a resource a custom URL path (e.g. `/api/articles`).
- Disable resource types you don't want exposed to the API.
- Hide sensitive fields (internal flags, admin metadata) from responses.
- Lock down the API by disabling all resources by default, enabling a whitelist.
- Format timestamp/date fields to ISO-8601 or a custom format via an enhancer.
- Parse a JSON-string field into a real nested object in responses.
- Flatten a single-cardinality field so it isn't wrapped in an array.
- Extract one value from a nested/compound field with the nested enhancer.
- Rewrite entity-reference and UUID fields into resolvable links.
- Include a total record count in collection responses for pagination UIs.
- Export API configuration as config for deploy across environments.
- Standardize public field names across bundles for a frontend contract.
- Build a stable API contract decoupled from Drupal's internal schema.
- Provide a clean, documented API for a React/Vue/Next.js front end.
- Render an entity to JSON:API in PHP via the EntityToJsonApi service.
- Generate JSON:API payloads inside a custom controller or queue worker.
- Validate configuration integrity on import to catch broken field overrides.
- Write a custom field enhancer for a bespoke value transformation.
- Set default includes so clients get related data without query params (with jsonapi_defaults).
- Apply default filters/sorting/page limits per resource (with jsonapi_defaults).
- Simplify client code by shaping responses server-side instead of in the browser.
