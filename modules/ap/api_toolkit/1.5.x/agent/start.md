<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Toolkit (api_toolkit) — agent index

A **developer framework for hand-building custom JSON API endpoints** — the tailored alternative to
core JSON:API. It ships nothing user-facing and has **no routes, no permissions, no admin UI, no Drush**;
you consume its classes/services from your own module. Package `API`. Depends only on core
**`serialization`**. Requires **PHP 8.1**, core `^10 || ^11`. License GPL-2.0-or-later. Version **1.5.1**.
composer: `symfony/property-access`, `symfony/cache`.

Three pillars — pick the doc you need:

- **Request classes + validation** (typed properties auto-filled from the request, validated, injected
  into your controller) → [api/requests.md](api/requests.md)
- **Standardised JSON responses + error/maintenance handling + settings** (`data`/`pagination`/`links`
  envelopes, auto error JSON, the `api_toolkit.settings` config) → [api/responses.md](api/responses.md)
- **Cached normalizations + placeholders + entity-UUID param converter** (the
  `api_toolkit.cached_normalizer` service) → [normalizers/cached-normalizer.md](normalizers/cached-normalizer.md)
- **Custom validation constraints** (EntityExists, EntityUnique, Enum, Langcode, MigrationSourceExists)
  → [plugins/validators.md](plugins/validators.md)
- **Config keys + services + how everything wires together** → [config/settings.md](config/settings.md)

## What it actually provides (from source)

- **Request layer** — `Request\ApiRequestBase` (abstract, implements `ApiRequestInterface` +
  `RefinableCacheableDependencyInterface`); `Normalizer\ApiRequestNormalizer` denormalizes a Symfony
  `Request` (or array) into a typed request object with coercion + validation;
  `ArgumentResolver\ApiRequestResolver` (a value resolver, unshifted to the front of core's resolver
  chain by `ApiToolkitServiceProvider::alter()`) injects the built object into controller args and
  optionally validates it.
- **Response layer** — `Response\JsonResponse` / `PagedJsonResponse` and cacheable variants
  `CacheableJsonResponse` / `CacheablePagedJsonResponse`; `ApiErrorJsonResponse` (violation list →
  `errors`). `EventSubscriber\ExceptionJsonSubscriber` (priority −40) renders exceptions on api_toolkit
  routes as standardised JSON; `EventSubscriber\MaintenanceModeSubscriber` returns JSON 503 for API
  routes in maintenance mode.
- **Normalization layer** — `Normalizer\CachedNormalizer` (service `api_toolkit.cached_normalizer`,
  extends Symfony `Serializer`, own cache bin `api_toolkit_normalizer`) caches per-entity/field-item
  normalizations; `Normalizer\Placeholder\Placeholder` + `PlaceholderArgument(Type)` defer dynamic/nested
  values. `Cache\CacheableMetadataWithKeys` adds explicit cache keys.
- **Validation constraints** (`src/Plugin/Validation/Constraint/*`) — `EntityExists`, `EntityUnique`,
  `Enum`, `Langcode`, `MigrationSourceExists` (each with a `*Validator`).
- **Param converter** — `ParamConverter\EntityUuidConverter` (`paramconverter.api_toolkit.entity_uuid`),
  handles route param type `entity_uuid:<entity_type>`.
- **Exception** — `Exception\ApiValidationException` (extends Symfony `HttpException`, carries a
  `ConstraintViolationList`).
- **Config** — `api_toolkit.settings` (`route_formats`, `auto_validate`) with schema; installed default
  `auto_validate: true`, `route_formats: {}`. Update hooks `8001`–`8004` in `api_toolkit.install`.

## Submodule

- **API Toolkit Examples** (`api_toolkit_examples`) — a demonstration/reference module with working CRUD
  endpoints under `/api/example-pages`. Not for production. Documented separately at
  [modules/api_toolkit_examples/1.5.x/agent/start.md](../modules/api_toolkit_examples/1.5.x/agent/start.md).

## Access control is your job

API Toolkit provides zero access control of its own. Every endpoint you build with it must declare its
own route `_permission`/`_access`/`_custom_access` and check entity/field `access()` in the controller —
exactly as you would for any custom controller. The module only shapes request parsing, validation and
response formatting.
