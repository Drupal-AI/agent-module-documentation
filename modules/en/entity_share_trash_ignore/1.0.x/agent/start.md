<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Share Trash Ignore (entity_share_trash_ignore) — agent index

Adds one **Entity Share Client import processor** that **skips importing entities already in the local Trash bin**, avoiding the 500 error caused when Entity Share re-creates an entity whose UUID is still held by a trashed copy. Package `Web services`. Version **1.0.0-rc2**. Core `^10 || ^11`.

Dependencies (info.yml / composer.json): `entity_share:entity_share_client`, `trash:trash` (Entity Share `^3.0 || ^4.0`, Trash `^3.0`). No permissions, routes, services, config, hooks, install file, or submodules of its own.

- **The `trash_ignore` import processor: mechanism, pipeline stage, and behavior** →
  [plugins/ignore-trash-processor.md](plugins/ignore-trash-processor.md)

## What it actually is

- One plugin: `IgnoreTrash` (`@ImportProcessor` id **`trash_ignore`**, label *"Ignore trash"*, `locked = true`), in `src/Plugin/EntityShareClient/Processor/IgnoreTrash.php`, extending `entity_share_client`'s `ImportProcessorPluginBase` and implementing `PluginFormInterface` (empty form).
- Runs at stage `is_entity_importable` with weight **-5**. Because it is `locked`, it is always active once the module is enabled — nothing to configure.
- Affects only the **client / import** side of Entity Share. Does not push, does not alter published state, provides no field/formatter/widget.

## Mechanism (from source)

- `isEntityImportable(RuntimeImportContext, array $entity_json_data)` decides importability:
  1. Splits the JSON:API `type` (`"$type--$bundle"`).
  2. If `trash.manager` `isEntityTypeEnabled($type, $bundle)` is FALSE → return TRUE (import normally).
  3. Loads the local entity by `uuid` (from `$entity_json_data['id']`) inside `trashManager->executeInTrashContext('inactive', …)` so soft-deleted entities are loadable.
  4. No local match → TRUE. Local entity whose `deleted` field `isEmpty()` (not trashed) → TRUE.
  5. Otherwise the entity is in trash → `messenger()->addError()` names the entity, `logger` (channel `piipe_entity_share`) warns, and it returns **FALSE** (skip import).
- Services injected in `create()`: `entity_type.manager`, `entity_type.bundle.info`, `jsonapi.resource_type.repository`, `entity_share_client.state_information`, `logger.factory`, `trash.manager`.

See the solution doc for the full method walk-through and operational notes.
