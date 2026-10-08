<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Blueprint — config entities & admin settings

## entity_blueprint_config (submodule)

Depends only on `entity_blueprint`. Adds config-entity support so views, image styles, entity displays, field
config, etc. can be serialized/deserialized/validated/mutated as JSON. `lifecycle: experimental`,
`configure: entity_blueprint_config.settings`. It is the **only** submodule that provides a permission and a
config schema.

### Backend & services (`src/`)

`ConfigBlueprintBackend` (tagged `entity_blueprint.backend`, priority 0 — checked before the content backend at
-10) `supports()` any `ConfigEntityInterface`. It delegates to `ConfigSerializer`, `ConfigDeserializer`,
`ConfigSchemaBuilder`, and `ConfigOperations`; `requiresWorkspace()` is FALSE; `persist()` calls `$entity->save()`
directly. Property handlers (`PropertyHandler/`: scalar, mapping, sequence, plugin-collection) and a
`ConfigSchemaBuilder`/`ConfigSchemaBuilder` map Drupal config schema to blueprint JSON.
`ConfigEntityMetadataTrait` supplies entity-type metadata.

### Access enforcement

- `ConfigDeserializer::deserialize()` → `ConfigSemanticValidator::validate($entity, $is_new)` →
  `validateAccess()`. Create uses `BlueprintAccessChecker::createAccess()`, update uses `entityAccess(update)` —
  both **fail-closed** (neutral = denied).
- `ConfigOperations::updateProperties()` validates then re-checks via the semantic validator; the plugin-collection
  methods (`addPlugin`/`updatePlugin`/`removePlugin`/`reorderPlugins`) each call `checkWriteAccess()`
  (→ `validateAccess($entity, FALSE)`) before mutating, since they are reachable directly through the service and
  AI layer.
- `hook_entity_create_access()` (`entity_blueprint_config_entity_create_access()`) is a **grant-only** check
  (never returns forbidden): for config types on the admin allow-list it returns
  `allowedIfHasPermission($account, 'create config entities via entity_blueprint')`, else neutral. It exists
  because many config types (entity displays, field config) define no admin permission and so return neutral
  create access for everyone; fail-closed blueprint creation would otherwise block them entirely. The allow-list
  bounds *which* types; the permission bounds *who*.

### Permission (`entity_blueprint_config.permissions.yml`)

`create config entities via entity_blueprint` — `restrict access: true`. Grant only to trusted roles; it lets
blueprint operations (including AI agents acting as the user) create allow-listed permission-less config types.

### Settings form — `Form\ConfigCreateAccessForm`

Route `entity_blueprint_config.settings` at `/admin/config/development/entity-blueprint-config`,
`_permission: 'administer site configuration'`. Config object `entity_blueprint_config.settings`, key
`allowed_create_types`. It lists **only** config entity types that have **no admin permission of their own**
(`$definition->getAdminPermission()` empty) — types that already gate their own creation (image styles, filter
formats) are deliberately omitted so allow-listing can never weaken an existing permission. Schema in
`config/schema/entity_blueprint_config.schema.yml`.

## entity_blueprint_ai settings form

See ai/tools.md. Route `/admin/config/ai/entity-blueprint`, `administer site configuration`, config
`entity_blueprint_ai.settings` (`hidden_entity_types`, `hidden_bundles`) — purely controls AI **visibility** of
entity types/bundles in bundle discovery; it is not an access control (real access is enforced per operation).

## Config objects summary

- `entity_blueprint_ai.settings` — `hidden_entity_types` (array), `hidden_bundles` (map type → bundle[]).
  Install default in the AI submodule's `config/install/`.
- `entity_blueprint_config.settings` — `allowed_create_types` (array of config entity type ids).

The base `entity_blueprint` module ships **no** config, schema, routes, or permissions.
