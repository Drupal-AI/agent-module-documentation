<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage, caching, Views, field & hook integration

## Storage & query (no local persistence)
- `Entity/ExternalEntityStorage.php` (extends `EntityStorageBase`) is the storage handler for
  `external_entity`. It does not read/write a local entity table; it resolves items from the remote
  source (through the bundle's connection type) and hydrates `ExternalEntity` objects, using
  `cache.external_entity` for results.
- Entity-query backends are split: `entity.query.stub` (`Entity/Query/Stub/QueryFactory`) and
  `entity.query.api` (`Entity/Query/Connection/QueryFactory`, injected `entity_type.manager`).
  `Entity/Query/SearchQuery.php` formats a query into the parameters sent to the server's
  `definition/{resource}/search` endpoint (see `plugins/plugins.md`).

## Cache bin & invalidation endpoint
- A dedicated cache bin `external_entity` is defined in `external_entity.services.yml`
  (`cache.external_entity` + `cache_factory.external_entity` + backend
  `cache.external_entity.backend.database` → `Cache/ExternalEntityDatabaseBackendFactory`). The backend
  `Cache/ExternalEntityDatabaseBackend.php` extends core `DatabaseBackend` and implements
  `CacheTagsInvalidatorInterface`, mapping cache tags to cache ids and invalidating them.
- `external_entity.api.cache.invalidator` (POST `/external-entity/api/cache/invalidator`,
  `Controller/ExternalEntityAPICacheController::invalidateCache`) is the integration endpoint the
  remote server calls to keep the consumer fresh. It expects `Content-Type: application/json` and a
  body `{"action": "update", "cache_tags": [ ... ]}`; on `action === 'update'` it invalidates the given
  tags in the `external_entity` bin and returns `{"status": "successful"}` (otherwise `"error"`). Bad
  JSON or a body missing `action`/`cache_tags` yields `BadRequestHttpException`.
- Config entities contribute cache tags too, e.g. `ExternalEntityType::getCacheTagsToInvalidate()`
  returns `connection:{connection_id}`, and `InternalEntityRenderType` adds
  `external_entity:{plugin}:{entity_type}:{bundle}`.

## Views integration (`src/Plugin/views/` + `src/Views/`)
Full Views support against the `external_entity` base table:
- query plugin `ExternalEntityQuery`, row plugins `ExternalEntityRow` + `ExternalEntityResultRow`,
  field `ExternalEntityField`, filter `ExternalEntityVariationFilter`, wizard `ExternalEntityStandard`.
- `Entity/ExternalEntityViewsData` supplies views data; helper `Views\ViewsDataHelper`
  (`external_entity.views_data_helper`, wraps `views.views_data`) and `Views\Views`.
- `Routing/ExternalEntityRouteSubscriber` overrides the `views_ui.form_add_handler` controller with
  `Form/ViewUI/AddHandler` so the Views UI add-handler dialog understands external-entity handlers.

## Entity reference field integration
- Selection handler `Plugin/EntityReferenceSelection/ExternalEntitySelection.php` — lets a normal
  entity-reference field target `external_entity` (autocomplete/lookups resolve against the remote source).
- Formatter `Plugin/Field/FieldFormatter/ExternalEntityReferenceEntityFormatter.php` — renders a
  referenced `external_entity` in a chosen view mode.
- `external_entity.module` → `hook_form_entity_view_display_edit_form_alter()` removes the core
  `entity_reference_entity_view` formatter option for fields whose `target_type` is `external_entity`
  (the module's own formatter is used instead).

## Access & hooks
- `Entity/ExternalEntityAccessHandler` extends core `EntityAccessControlHandler` and handles access for
  the `external_entity` content entity.
- `external_entity.module`: `hook_preprocess_node()` sets the node template `url` from the attached
  external entity's `getPath()` when a node carries an `external_entity` property; helper
  `external_entity_field_manager()` returns the `entity_field.manager` service.

## Services quick map (`external_entity.services.yml`)
`external_entity.options` (`ExternalEntityOptions`), `external_entity.entity_type.info`
(`Service\EntityTypeInfo`), `external_entity.views_data_helper`, `external_entity.route_subscriber`,
the three plugin managers, `entity.query.stub`, `entity.query.api`, and the cache bin trio.
No Drush commands are provided.
