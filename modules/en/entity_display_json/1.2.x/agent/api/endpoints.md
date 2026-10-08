<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoints, routes & permission

All routes in `entity_display_json.routing.yml`: `methods: [GET]`, `requirements` include
`_format: 'json'` and `_permission: 'access entity display json'`. Per-entity, per-view and
per-field view access is enforced on top of the permission (see [builder.md](builder.md)).

## Permission

`entity_display_json.permissions.yml` declares one permission:
`access entity display json` (title "Access Entity Display JSON endpoints"). It is the only gate on
all three routes.

## `GET /ejson` — site info

Route `entity_display_json.info` → `Controller/EntityDisplayJsonInfo::getInfo()`. Returns a
`CacheableJsonResponse`:

- `apiVersion` (`EntityJsonBuilderInterface::API_VERSION` = `'1.0'`), `site_name`, `site_slogan`
  (from `system.site`), `default_language`, and `languages` (map of `langcode → {label, path}`,
  the path coming from `language.negotiation` `url.prefixes`).
- If the site front page resolves to an entity (via `PathEntityResolver::resolve()` on
  `system.site` `page.front`), adds `homepage_uuid` and `homepage_entity_type`.
- Cache tags from both config objects; context `languages:language_interface`; homepage entity
  added as a cacheable dependency.

## `GET /ejson/resolve?path=/…` — path to pointer

Route `entity_display_json.resolve` → `Controller/EntityDisplayJsonResolver::resolve()`. Bridges a
URL-first front end to the UUID-keyed build route.

- Reads `?path=` via `query->getString('path','')`; a non-scalar `path` → HTTP 400; empty or a
  path without a leading `/` → `NotFoundHttpException`.
- Delegates to `PathEntityResolver::resolve($path)` (`src/PathEntityResolver.php`), which uses
  `PathValidatorInterface::getUrlIfValidWithoutAccessCheck()` and understands two route shapes:
  `entity.{entity_type}.canonical` (loads the entity) and `view.{view_id}.{display_id}` (loads the
  `view` config entity, display id from the route). Returns `{entity, display_id}` or NULL.
- Enforces `$entity->access('view', NULL, TRUE)` — denies with `AccessDeniedHttpException` — before
  returning the pointer.
- Response: `apiVersion`, `entity_type`, `uuid`, `id`, `display_id`. `?display_id=` may override
  the resolved display (the build route's converter validates it when followed). Cache contexts
  `url.query_args:path` / `:display_id`; entity + access added as dependencies.

## `GET /ejson/{entity_type}/{uuid}/{display_id}` — build

Route `entity_display_json.build` → `Controller/EntityDisplayJsonController::build()`.
`display_id` defaults to `default`.

- `{display_id}` uses param type `entity_display_id` → `ParamConverter/EntityDisplayIdConverter`
  (service tagged `paramconverter`): for content entity types the value must be `default` or a
  registered view mode of that entity type, else it returns NULL → 404; `view` entities and
  unknown types pass through untouched.
- `build()`: 404 if `$entity_type` is not a known definition; loads by UUID with
  `getStorage($entity_type)->loadByProperties(['uuid' => $uuid])`; 404 if none. Reads
  `?lang=` (default `default`). Calls `builder->serialize($entity, $langcode, $display_id, $cacheability)`.
- Wraps the serialized data in an envelope: `apiVersion`, `langcode`
  (`$entity->language()->getId()`), `translations` (`builder->getAvailableTranslations()`, empty
  for `view`). Fires `hook_entity_display_json_response_alter($payload, $context)`. Adds cache
  contexts `url.query_args:lang` and `url.query_args:page`; returns `CacheableJsonResponse` with
  the collected cacheability.

`processEntity()` and `getAvailableTranslations()` on the controller are `@deprecated` shims
delegating to the builder service.
