<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Entity Merge (simple_entity_merge) — agent index

Adds a **Merge** tab/operation to content entities. On a source entity you pick another
entity of the same type; every `entity_reference` (configurable + base field) that pointed
at the source is repointed to the target. The **source is NOT deleted** — the form repoints
references and then tells you "now you can delete this one." Typical use: deduplicating
taxonomy terms, consolidating users/organisations.

- No third-party dependencies. Core `^10 || ^11`.
- Settings route: `simple_entity_merge.settings` → `admin/config/content/simple_entity_merge`
  (one config key, `exclude`).
- Defines 2 permissions. No drush. No plugin types (only a local-task deriver + a dynamic
  route subscriber it uses internally).

Solutions:
- **Turn merging on/off for entity types (exclude list)** → [configure/settings.md](configure/settings.md)
- **Who can configure and who can merge** → [permissions/permissions.md](permissions/permissions.md)
- **Call the merge from your own code / understand what it rewrites** → [api/merge-service.md](api/merge-service.md)
- **How the Merge tab, operation and per-type route appear** → [hooks/entity-integration.md](hooks/entity-integration.md)

Key facts:
- Service id `simple_entity_merge.merge` = `Drupal\simple_entity_merge\SimpleEntityMerge`,
  method `mergeReferences(string $entity_type_id, int $source_id, int $destination_id)`.
- Config object `simple_entity_merge.settings`, key `exclude` (comma-delimited entity type ids;
  default `node_type,block_content_type`).
- Permissions: `administer simple_entity_merge`, `execute simple_entity_merge`.
- Per-entity route name `entity.<type>.simple_entity_merge_execute`, path
  `<canonical-or-edit-form>/merge`; form class `Merge` (id `simple_entity_merge_merge`).
- Only repoints fields of type `entity_reference` whose `target_type` equals the source type;
  no batch (loads all referencing entities at once), and a merge is not reversible — back up first.
