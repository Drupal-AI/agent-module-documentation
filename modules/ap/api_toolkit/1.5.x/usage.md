API Toolkit is a developer framework that cuts the boilerplate of building custom JSON API endpoints in Drupal, providing typed request classes, standardised JSON responses, and cached entity normalizations.

---

Use API Toolkit when core JSON:API is too generic and you want hand-tailored custom API endpoints without rewriting the same request-parsing, validation, response-shaping and cache-invalidation code each time. Request classes (extending `ApiRequestBase`) declare typed public properties that are automatically populated from POST bodies (`application/json`, `application/x-www-form-urlencoded`, `multipart/form-data`), query parameters and route attributes, and are validated by Symfony's validator using PHP type hints, nullability, default values, backed enums and constraint attributes — an argument value resolver injects a fully-built, validated request object straight into your controller method. Response classes nest data under a `data` key, add `pagination`/`links` for paged endpoints, and (for route formats you opt in via `api_toolkit.settings`) turn thrown `ApiValidationException`s and other errors into a consistent `{"errors": [...]}` JSON body. The `CachedNormalizer` service caches individual entity/field-item normalizations and auto-invalidates them by cache tags, with a placeholder mechanism for per-user/per-time dynamic values and efficient nested normalizations. The module ships extra validation constraints, an entity-UUID param converter, and translated validation messages. It does nothing by itself — you write the routes, controllers, request classes and normalizers in your own module.

---

- Build a custom REST-style endpoint that returns a hand-picked JSON shape instead of JSON:API's generic document format.
- Define a request class with typed properties (`public string $title;`, `public ?int $limit;`) and get automatic type coercion and validation.
- Require a property by typing it non-nullable with no default; make it optional by making it nullable or giving it a default value.
- Restrict a property to a fixed set of values by type-hinting it as a PHP 8.1 backed enum (invalid input lists the allowed cases and the string is converted to the enum instance).
- Add Symfony validation constraints (`#[Assert\Length]`, `#[Assert\NotBlank]`, `#[Assert\Url]`, `#[Assert\All]`) to request properties via attributes or annotations.
- Validate that a referenced entity exists by ID/UUID/any field with the `EntityExists` constraint before acting on it.
- Enforce uniqueness of a submitted value against existing entities with the `EntityUnique` constraint.
- Validate that a submitted string is a valid installed language code with the `Langcode` constraint.
- Validate that a source ID exists in a migration's map with the `MigrationSourceExists` constraint.
- Toggle validation per route with the `_api_validation` route option, or globally with the `auto_validate` setting; run specific validation groups with `_api_validation_groups`.
- Inject the built request object directly as a controller argument (no manual parsing) via the `ApiRequestResolver` value resolver.
- Return a standardised single-item or list response with `JsonResponse::createWithData()` (everything under `data`).
- Return a paged list with `PagedJsonResponse::createWithPager()` — adds `pagination` (currentPage, totalPages, totalItems, limit) and prev/next `links`.
- Return cacheable equivalents (`CacheableJsonResponse`, `CacheablePagedJsonResponse`) that carry cacheability metadata for Dynamic Page Cache.
- Emit consistent error responses automatically: thrown `ApiValidationException`s become `{"errors":[{"path":...,"message":...}]}` for your configured `route_formats`.
- Return a JSON (instead of HTML) maintenance-mode response for API routes when the site is offline.
- Cache expensive per-entity normalizations individually with the `api_toolkit.cached_normalizer` service and have them invalidated automatically when the entity changes.
- Placeholder highly dynamic parts of a normalization (current user, current time) so the cached entry stays valid while the dynamic value is recomputed on read.
- Use placeholders to cache nested entity normalizations separately from their parent (good for entities with many child references).
- Upcast an entity UUID in a route path to a full entity object using the `entity_uuid:<type>` param converter type.
- Translate built-in Symfony and custom-constraint validation messages by importing the shipped `.po`/`.pot` files under `translations/`.
- Try everything end-to-end by enabling the `api_toolkit_examples` submodule, which ships working CRUD endpoints under `/api/example-pages`.
