<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Blueprint — core architecture

All classes are in `Drupal\entity_blueprint\*` (`src/`). Services are autowired in `entity_blueprint.services.yml`.

## Blueprint shape

A blueprint is a plain PHP array / JSON object: `entity_type` (required), `bundle`, optional `langcode`, a
`fields` object of field values, and `layout_builder__layout` as a **separate top-level key** (not inside
`fields`). An internal `_root_entity` marker (`{field, value}`) makes the deserializer load an existing entity
instead of creating one. Full/summary/component are the three serialization modes.

## Serialize / deserialize / operations

- `BlueprintSerializer` (`entity_blueprint.serializer`, iface `BlueprintSerializerInterface`): `serialize()`,
  `serializeSummary()` (tree of UUIDs, no values), `serializeComponent($entity, $uuid, $langcode)`.
- `BlueprintDeserializer` (`.deserializer`): `deserialize(array $data, array $options)`. Phase A =
  `StructuralValidator::validate()`; on `validate_only` returns `BlueprintResult::validated()`. Phase B loads or
  creates the entity (`loadOrCreateEntity()`), runs `SemanticValidator::validateEntityAccess()`, handles
  translation (adds/gets translation, skips non-translatable fields on non-default langcode), runs
  `validateFieldAccess()` (excluding `layout_builder__layout`, whose core edit access is forbidden by design),
  applies each field through its `FieldHandler`, deserializes the layout via `LayoutDeserializer`, then runs
  scoped `validateConstraints()`. Returns a `BlueprintResult` with the **unsaved** entity, warnings, and deferred
  operations. It never saves.
- `BlueprintOperations` (`.operations`, iface `BlueprintOperationsInterface`): targeted, UUID-addressed CRUD that
  avoids full round-trips — `createEntity`, `getBlueprint(Summary)`, `getComponent`, `updateComponent`,
  `updateElement`, `addComponent`, `removeComponent`, `updateFields`, `restructureLayout`, `reorderField`,
  `batchOperations`. `updateFields` rejects `layout_section` and `entity_reference_revisions` types. Write paths
  build unsaved entities; caller persists.
- `batchOperations()` snapshots the entity (`snapshotEntity()` records layout sections via `Section::toArray()`,
  field values, and recursive paragraph state), applies ops sequentially, collects structural errors across ops
  but rolls back (`restoreEntity()`) on the first semantic failure — atomic all-or-nothing. `applyOperation()`
  also json-decodes string-encoded nested params (LLMs double-encode).

## Validation & results

- `Validator\StructuralValidator` (Phase A, cheap, schema-shaped) and `Validator\SemanticValidator` (Phase B:
  entity access, field access, constraint validation scoped to submitted fields).
- `Result\BlueprintResult` (iface `BlueprintResultInterface`) with `BlueprintError`
  (`path`, `code`, `message`, `context`, `hint`, `operationIndex`), `BlueprintWarning`, and `TargetType`
  (ADDED/REMOVED/REORDERED/RESTRUCTURED/`*`). `toArray()` renders the AI/CLI-facing payload. `ResolvedElement`,
  `ComponentContext`, `ComponentLocator`, `BlueprintElementResolver`, `CurrentEntityContext` support locating and
  resolving nested components by UUID.

## Access (central, fail-closed)

`Access\BlueprintAccessChecker` (`.access_checker`) is the single access authority. Enforcement checks are
fail-closed (neutral = denied): `entityAccess()` (delegates to `$entity->access()`, works on unsaved entities),
`createAccess()`, `fieldVisible()`, `fieldEditable()`. `fieldDefinitionAccess()` (schema advertising only) is
fail-open against neutral. Surgical writes in `BlueprintOperations::validateAndApplyFields()` call
`fieldEditable()` per field; the deserializer calls `validateFieldAccess()`. Trusted CLI simply doesn't call the
checker; there is no bypass toggle.

## Storage & workspace

`EntityStorageHandler` (`.storage_handler`) routes `load()`/`persist()` to the right backend: tempstore_plus
(`EntityTempstoreRepository`) if present → Layout Builder tempstore (`LayoutBuilder\LayoutTempstoreHelper`) for
layout-compatible entities → direct `save()`. New/`force_save` entities always go to the DB. `persist()` calls
`assertWorkspaceAllowed()` — with Workspaces enabled and no active workspace it throws
`Exception\WorkspaceRequiredException`. Fires `hook_entity_blueprint_entity_persisted`. The Layout Builder helper
is injected only when `layout_builder` is installed (via `EntityBlueprintServiceProvider`), keeping the handler
loadable without it.

## Backends (dispatch)

`Dispatch\BlueprintBackendResolver` collects `entity_blueprint.backend`-tagged services (iface
`BlueprintBackendInterface`) and `resolve($entity_type_id)` picks the first that `supports()` it.
`Dispatch\ContentBlueprintBackend` (priority -10) handles fieldable content entities; the config submodule adds a
higher-priority backend for config entities.

## Field handlers

`FieldHandler\FieldHandlerManager` (`.field_handler_manager`, `service_collector` tag
`entity_blueprint.field_handler`, keyed by `field_types`) dispatches per field. Built-ins: `TextFieldHandler`
(`text_long`, `text_with_summary`), `EntityReferenceFieldHandler` (`entity_reference`, "shared" strategy —
lookup by target_id/_label), `LinkFieldHandler` (`link`), `FileFieldHandler` (`file`, `image`),
`InlineEntityFieldHandler` (`entity_reference_revisions`, "inline" strategy — full nested serialization).
Extend `FieldHandlerBase` (implement `doSerialize()`/`doDeserialize()`); results are `FieldHandlerResult` and may
carry `DeferredOperation` objects for async work. `getProcessableFieldDefinitions()` filters entity keys, revision
metadata, computed/internal fields, then applies `hook_entity_blueprint_processable_fields_alter()`.

## Layout Builder & opaque data

`LayoutBuilder\LayoutSerializer`/`LayoutDeserializer` convert `layout_builder__layout` sections. `LbPlusAdapter`
wraps optional `lb_plus`/core section-storage APIs (all optional service args), extracting/serializing inline
`block_content`. `OpaqueDataMerger` merges only declared managed keys and preserves undeclared opaque keys
(`third_party_settings`, `layout_settings`, inline block `configuration`) from prior state.
`InlineBlockRestrictionChecker` honors `layout_builder_restrictions`. `ManagedKeysRegistry`
(`.managed_keys_registry`) resolves which opaque keys are AI-managed per entity type/bundle.
`SkillType\SkillTypeManager` (+ default/create_entity/current_entity types) composes on-demand skill instructions.
