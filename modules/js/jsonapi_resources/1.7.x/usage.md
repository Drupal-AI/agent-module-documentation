<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Resources is a **developer framework** that lets a module define its own JSON:API-compliant endpoints at routes of its choosing. Drupal core's JSON:API auto-generates routes for every entity type but does not let you create custom URLs; this module fills that gap so you can return exactly the collection, aggregate, or shaped payload a decoupled front end needs while still emitting standards-compliant JSON:API documents that reuse existing resource types.

---

The module ships **no routes, resources, config, permissions, or Drush commands of its own** — enabling it exposes nothing. It provides an authoring convention: declare an ordinary route in your `module.routing.yml`, but instead of a `_controller` route default use a `_jsonapi_resource` default that names a class (or a service id). That class must extend `Drupal\jsonapi_resources\Resource\ResourceBase` (or a subclass) and declare a public `process(Request $request, …)` method whose extra arguments are upcast route parameters (e.g. an entity). The route path must begin with `/%jsonapi%` — a placeholder the module rewrites to the site's JSON:API base path (`/jsonapi` by default). A route-alter subscriber (`Unstable\Routing\ResourceRoutes`, priority 6000) validates the resource class at route-build time (it must subclass `ResourceBase`, expose a public `process()`, must NOT set `_controller`, and must either declare a `_jsonapi_resource_types` array default or override `getRouteResourceTypes()`), then forces the `api_json` content type + format requirements, enables all authentication providers, and defaults the route to `GET` unless `methods:` says otherwise. Inside `process()` you build a `ResourceObjectData` (of `ResourceObject`s) and hand it to the inherited `createJsonapiResponse()`, which returns a cache-aware `ResourceResponse` that JSON:API normalizes. Three base classes climb in capability: `ResourceBase` (any data source — config, remote API, computed), `EntityResourceBase` (helpers to turn entities into resource objects with access checks), and `EntityQueryResourceBase` (entity-query collections with JSON:API filter/sort/pagination via `getEntityQuery()`, `getPaginatorForRequest()`, and `loadResourceObjectDataFromEntityQuery()`). Note that much of the code sits in an `Unstable\` namespace that is explicitly **not** part of the public PHP API — only the `ResourceBase` family (outside `Unstable`) is safe to depend on.

---

- Expose a custom "featured content" endpoint at `/jsonapi/featured-content` that returns a hand-picked node collection.
- Build a `/jsonapi/user/{user}/content` route returning only the articles authored by a given user.
- Create a `/jsonapi/me` endpoint that returns the currently authenticated user's own resource object.
- Aggregate across entity types in one document (e.g. recent nodes + recent comments) that core JSON:API cannot express in a single request.
- Return a JSON:API document backed by a **configuration object** rather than an entity (e.g. `/jsonapi/site-info` from `system.site`).
- Accept a `POST` to a custom route to create an entity with extra server-side logic (e.g. add a comment, create a reminder for a user).
- Add a computed/derived collection such as "articles ordered by comment count" using a raw SQL `SelectInterface` query joined into JSON:API output.
- Provide a decoupled/headless front end with tailored read endpoints that still speak the JSON:API media type its client library already understands.
- Keep JSON:API's sparse-fieldsets, `include`, filtering, sorting, and pagination behavior on a custom collection by extending `EntityQueryResourceBase`.
- Force a relationship to always be included in the response (e.g. always embed `uid` on an author-articles collection).
- Return a non-entity, read-only resource type you define inline with `new ResourceType(...)` and `ResourceTypeAttribute`s.
- Serve an endpoint whose result set is scoped by a bound route parameter (a user, a group) so per-row access checks can be skipped safely.
- Attach precise cacheability (cache tags/contexts) to a custom response so it invalidates correctly when its source data changes.
- Wire route access with the same requirements as any route (`_permission`, `_entity_access`, `_entity_create_access`, `_custom_access`, `_user_is_logged_in`).
- Register a resource as a **service** (with dependencies injected) instead of a bare class, by using the service id as the `_jsonapi_resource` value.
- Restrict a resource route to specific HTTP methods with `methods: ['POST']` (or DELETE, which returns 204 and skips resource-type validation).
- Return several resource types from one route by listing them all in `_jsonapi_resource_types`.
- Paginate a large custom collection with the built-in offset/limit paginator and emit `next`/`prev` pagination links.
- Migrate a bespoke REST controller to JSON:API semantics without abandoning your custom URL structure.
- Prototype an endpoint that may eventually be folded into Drupal core JSON:API (the module is explicitly a staging ground for that).
- Combine with `jsonapi_extras` (a dev dependency) to further customize resource type naming/field aliases on the reused resource types.
