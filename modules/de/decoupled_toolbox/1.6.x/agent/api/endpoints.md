<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox — collection endpoint, REST resource, filters, events

## Enable

`drush en decoupled_toolbox -y`. Installation (`decoupled_toolbox_install()`) calls
`EntityViewDisplayManager::prepareDecoupledDisplayForAllEntityTypes()` (creates the `decoupled`
view mode + displays) and seeds `decoupled_toolbox.settings:version = 1.00`.

## Routes & permission

- `decoupled_toolbox.entity_decoupled_data.collection` — `GET
  /decoupled-api/{type}/{bundle}/collection`, `_controller:
  EntityDecoupledDataController::collection`, `requirements: _permission: 'access decoupled api'`
  (`decoupled_toolbox.routing.yml`, `decoupled_toolbox.permissions.yml`).
- `decoupled_toolbox.settings` — settings form, `_permission: administer site configuration`.
- Group sub-module adds `GET /decoupled-api/group/{gid}/{type}/{bundle}/collection` (same
  permission).

`{type}` is an entity type id (`node`, `taxonomy_term`, …); `{bundle}` is the bundle
(`article`, `tags`, …). For bundleless entity types pass the type id again as the bundle.

## Request flow (from source)

`EntityDecoupledDataController::collection()` → `RequestEntity::getCollection($request, $type,
$bundle)`:

1. `validateParameterAndOption()` validates `offset` (>=0 int) and `limit` (>=1 int, or the
   configured default/required/unlimited behaviour), checks the type/bundle exist via
   `entity_type.bundle.info`, and calls `checkIfProcessable()`.
2. `checkIfProcessable()` dispatches `ProcessableCheckEvent` on
   `DecoupledControllerEvents::EVENT__PROCESSABLE_CHECK`; if a subscriber sets a **forbidden**
   access result the request is rejected (`InvalidParameterException` → HTTP 400). No subscriber
   ⇒ allowed.
3. Builds an entity query: `->accessCheck($options['accessCheck'] ?? FALSE)->range($offset,
   $limit)`, adds the bundle condition when the type has a bundle key, appends filter conditions
   (below), then dispatches `AlterQueryEvent` (`EVENT__ALTER_QUERY`) so code can mutate the
   query, and executes it.
4. For each id, `DecoupledRenderer::renderByEntityTypeAndId()` renders the entity through the
   `decoupled` (or `?display=`) view display; `onBaseEntityRenderBuilt()` dispatches the
   controller rendered-output event (the location solver subscribes here); when
   `include_version` is set the `version` is appended as `decoupled_toolbox`.
5. Returns a `CacheableJsonResponse` with cache tags and the `url.query_args` cache context.

Errors map to responses: `InvalidParameterException` → 400, `CouldNotRetrieveContentException`
→ 404, `UnavailableDecoupledViewDisplayException` → 501, `QueryException`/`\Exception` → 400/500.
Bodies are suppressed unless the `decoupled_toolbox.state.debug_enabled` **setting** (via
`Settings::get`, i.e. `settings.php`) is TRUE.

## Query-string parameters

- `offset` (int, default 0) — items to skip.
- `limit` (int, default per settings) — item count; may be unlimited or required per config.
- `display` (string, default `decoupled`) — machine name of the view display to render.
- `filter[{i}][f]=<field machine name>` — field to filter on (required per filter).
- `filter[{i}][v]=<value>` or repeated `filter[{i}][v][]=<value>` — value(s) (required).
- `filter[{i}][c]=<operator>` — one of `=`, `<>`, `>`, `>=`, `<`, `<=`, `STARTS_WITH`,
  `CONTAINS`, `ENDS_WITH`, `IN`, `NOT IN`, `BETWEEN` (defaults to `=`).

Filters are applied by `FilterTrait::appendConditionsFromQueryParameters()`, which throws a
`QueryException` on a missing `f`/`v`, dispatches `ConditionPreprocessEvent`
(`EVENT__CONDITION_PREPROCESS`, used by the Decoupled Router sub-module to translate an alias
into an entity condition), then calls `$query->condition($f, $v, $c)`. Values feed core entity
query conditions (parameterised), not raw SQL.

Example:
`/decoupled-api/node/article/collection?offset=0&limit=50&filter[0][f]=title&filter[0][v]=Hello&filter[1][f]=field_tag&filter[1][v][]=10&filter[1][v][]=1337&filter[1][c]=IN`

## REST resource

`CollectionResource` (`@RestResource id = "deoupled_toolbox_collection"`, canonical
`/decoupled-api/{type}/{bundle}/collection`) `::get()` calls the same
`RequestEntity::getCollection()` and returns a `ResourceResponse`. Enable/permission it through
the core REST / `rest_ui` configuration; its per-method permission is governed by core REST, but
the underlying data assembly is identical to the controller (same access model — see below).

## Events (developer extension)

- `DecoupledControllerEvents::EVENT__ALTER_QUERY` → `AlterQueryEvent` (mutate the query).
- `DecoupledControllerEvents::EVENT__PROCESSABLE_CHECK` → `ProcessableCheckEvent`
  (return `AccessResult::forbidden()` to block a request).
- `FilterInterface::EVENT__CONDITION_PREPROCESS` → `ConditionPreprocessEvent` (rewrite/cancel a
  single filter condition).
- `RequestEntityInterface::EVENT__CONTROLLER__ON_RENDERED_OUTPUT_BUILT` → `OnRenderedOutputBuiltEvent`
  (alter the assembled per-entity output; the location solver uses this).
- `DecoupledRenderer::EVENT__RENDERER__OUTPUT__RENDERED__PREFIX . <entity_type_id>` →
  `RenderedOutputEvent` (alter one entity's field values right after formatting).

## Access model (operate carefully)

The endpoint is gated by the dedicated `access decoupled api` permission, and the response is
scoped to the fields the site builder placed on the decoupled display. The endpoint does not
layer its own per-entity filtering on top of that, so treat the permission and the display
configuration as the access boundary: grant `access decoupled api` only to trusted roles, keep
the decoupled display limited to fields intended for the consumer, and pass `accessCheck: TRUE`
(the collection accepts it as an option) or add an `EVENT__PROCESSABLE_CHECK` subscriber /
`EVENT__ALTER_QUERY` condition when you need per-entity gating. The
`decoupled_toolbox.state.debug_enabled` flag should stay unset/false in production so error
bodies and stack traces are not returned.
