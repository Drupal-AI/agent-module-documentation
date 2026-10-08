<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Manager (entity_reference_manager) — agent index

A content-**merge** tool (the project name is misleading): merge duplicate **nodes / taxonomy terms / media** into one survivor and re-point every `entity_reference` field on the site from the source(s) to the target, then optionally delete the sources. Package `Content`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2. **No module dependencies** (works on core entity/field APIs; only acts on node/taxonomy_term/media entity types).

- **The merge UI, routes, form flow, options, and the Drush command** → [tools/merge.md](tools/merge.md)
- **The service + tagged-handler architecture (how a merge is analyzed/executed, batch ops, how to add a handler)** → [api/handlers.md](api/handlers.md)

## What it actually is (from source)

- **One permission**: `administer entity reference manager` (`entity_reference_manager.permissions.yml`).
- **One admin form**, `Form\ContentMergeForm` (`getFormId` = `entity_reference_manager_form`), served by four routes (`entity_reference_manager.routing.yml`):
  - `entity_reference_manager.form` — `/admin/content/entity-reference-manager` (central form).
  - `entity_reference_manager.node_merge` — `/node/{node}/manage-references`.
  - `entity_reference_manager.taxonomy_merge` — `/taxonomy/term/{taxonomy_term}/manage-references`.
  - `entity_reference_manager.media_merge` — `/media/{media}/manage-references`.
- **Menu/task links**: an admin-content menu link (`links.menu.yml`) and per-entity "Merge" canonical tabs (`links.task.yml`); `hook_entity_operation()` (`entity_reference_manager.module`) adds a "Merge" operation to node/term/media rows.
- **One service** `entity_reference_manager.manager` = `Service\ContentMergeManager` (entity_type.manager, database, logger, lock, tagged handler iterator).
- **Three tagged handlers** (`entity_reference_manager.handler`): `Handler\NodeMergeHandler`, `Handler\TaxonomyTermMergeHandler`, `Handler\MediaMergeHandler`, all implementing `Handler\ContentMergeHandlerInterface`. `ContentMergeServiceProvider::alter()` also re-registers them via `registerHandler` method calls.
- **One Drush command** `erm-merge` (`Commands\EntityReferenceManagerCommands`, `drush.services.yml`).
- No config objects, **no config schema**, no `.install`, no external HTTP, no plugin types.

## Key facts for agents

- Merge is **two-step**: submit → per-field impact analysis (`ContentMergeManager::analyze`) → confirm → execute (`ContentMergeManager::execute`) → Batch API rewrites references and (unless *Keep source*) deletes sources.
- Options: **Keep source entity after merge** (`keep_source`) and **Update references in revisions too** (`update_revisions`).
- Source and target must be the **same entity type** and (when a bundle is chosen) the same bundle; source ≠ target is enforced in `validateForm`.
- References are matched/rewritten by walking `entity_field.manager` field map for `entity_reference` fields whose `target_type` matches the entity type.
