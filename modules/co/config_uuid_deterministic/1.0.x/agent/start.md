<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config UUID Deterministic (config_uuid_deterministic) — agent index

`name: 'Config UUID Deterministic'`, version **1.0.3** (`1.0.x`).
Makes Drupal **configuration** UUIDs deterministic using **UUIDv5** (name-based SHA-1)
so the same config object always gets the same UUID across installs/environments,
making `config:export` / `config:import` and migration reruns idempotent (no UUID churn
in git diffs). Depends only on core `system`. Core `^9.4 || ^10 || ^11`, PHP `>=8.1`,
Composer dep `ramsey/uuid ^4.7`. No routes, no permissions, no forms, no admin page,
no config schema. Config-only tool — no content or access-control role.

## Mechanism (how the UUID is derived)

- Fixed namespace UUID `00000000-0000-0000-0000-000000000000` (a `NAMESPACE` const
  duplicated across the storage/generator classes).
- **Root config entity:** `uuid = Uuid::uuid5(NAMESPACE, <config_name>)`, e.g.
  `Uuid::uuid5(NS, 'node.type.article')`. (The `ConfigUuidGenerator::generate()` method
  supports a richer `config:<collection>:<name>` string, but the active/file/cached
  storage decorators and the normalizer all use the bare config **name** only.)
- **Nested plugin instances** (`[id, uuid]` pairs — image effects, filter formats,
  view displays/handlers): `Uuid::uuid5(NS, '<config_name>|<seg1>|<seg2>|...|<plugin_id>')`
  via `ConfigUuidRemapper::remapNested()` (recursive; re-keys children under the new uuid).
- Deterministic-UUID rewrite is applied only when the data already contains a `uuid`
  key (config entities). Simple config (no uuid) is left untouched.

## Where it hooks in

- `config_uuid_deterministic.module`:
  - `hook_field_storage_config_create()` — stamps the deterministic uuid on new
    `field.storage.*` before save (so hashed table names are created from it).
  - `hook_entity_presave()` — forces the deterministic uuid on any `ConfigEntityInterface`.
- Service decorators (`config_uuid_deterministic.services.yml`):
  - `config.storage.active` → `DeterministicActiveStorage` (extends core `DatabaseStorage`) —
    rewrites uuids on read/write; also maintains the `config.entity.key_store.<type>`
    key_value uuid→name mappings on write/delete.
  - `config.storage` → `DeterministicCachedStorage` (extends core `CachedStorage`) —
    rewrites on `read`/`readMultiple`/`write`.
- `ConfigUuidDeterministicServiceProvider::alter()` swaps the `config.storage.sync`
  factory to `ConfigSyncStorageFactory::getSync()`, returning `FileStorageDeterministic`
  (extends core `FileStorage`) — rewrites uuids on export/import read & write. Only
  swaps when the default core factory (`FileStorageFactory::getSync`) is in place.

## Skip-list / safety (in `FieldTableNameChecker` trait + `.module`)

- **`system.site` is never touched** (its uuid is a security token that must match
  across environments) — hard skip in every code path.
- **`field.storage.*` with hashed table names**: when a field's table name would exceed
  core's 48-char limit AND tables already exist under the current (random) UUID's hash,
  the UUID is left unchanged to avoid breaking DB table references
  (`hasConflictingHashedTables()` / `_config_uuid_deterministic_should_skip()`).
- **Content entities** (nodes, users, media, terms, files) are unaffected — the core
  `uuid` service is not decorated; content keeps random UUIDv4.

## Drush command

`config-uuid-deterministic:normalize` (alias `cud:normalize`) — one-time backfill that
rewrites existing random UUIDs to deterministic ones in active (and optionally sync)
storage. Idempotent. See [tools/normalize.md](tools/normalize.md).

## Files

- `.module` — the two hooks + `_config_uuid_deterministic_should_skip()`.
- `src/Config/ConfigUuidGenerator.php` — UUIDv5 helpers.
- `src/Config/ConfigUuidRemapper.php` — recursive nested-plugin remap.
- `src/Config/ConfigUuidNormalizer.php` — storage-wide normalize (used by Drush).
- `src/Config/{DeterministicActiveStorage,DeterministicCachedStorage,FileStorageDeterministic}.php` — storage decorators.
- `src/Config/{ConfigSyncStorageFactory,FieldTableNameChecker}.php` — sync factory + skip trait.
- `src/Commands/ConfigUuidDeterministicCommands.php` — Drush command.
