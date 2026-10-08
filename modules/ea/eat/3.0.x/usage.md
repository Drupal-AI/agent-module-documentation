<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Auto Term (EAT) automatically generates a taxonomy term named after an entity (currently node) each time the entity is created, records the entity-to-term mapping, and keeps the term title in sync on edit and removes it on delete.
---
Configure which node bundles map to which vocabularies at `/admin/config/system/eat` (route `eat.settings`, permission `administer site configuration`). EAT then uses `hook_form_alter` to attach a submit handler to those bundles' add/edit forms: on create it makes a term (reusing an existing term of the same name if present) in each selected vocabulary and writes a row to its `{eat}` table linking entity id, term id and vocabulary; on edit it renames the linked term to match the new title; `hook_entity_delete` removes the mapping and the term. A Views argument-default plugin (`eat`, "Content ID from path for EAT") can supply the mapped term id from the current node's path, and a Drush command `eat-add-single` (alias `eatas`) plus a batch form let you backfill existing content.

The batch backfill is exposed at `/admin/config/system/eat/batch` (route `eat.batch_update`) — note this route is gated only by `_permission: 'access content'`, which is granted to anonymous users by default, yet its submit handler runs `Eat::matchupEntitiesToSet()` which creates taxonomy terms and `{eat}` rows for all configured nodes (a mutating operation). Treat that as an over-broad permission for a write action and restrict access (or place it behind the admin settings only). Otherwise operate EAT by mapping bundles to vocabularies and letting content authoring drive term creation.
---
- Auto-create a taxonomy term when a node is created.
- Mirror the node title as the term name.
- Map specific node bundles to specific vocabularies.
- Reuse an existing same-named term instead of duplicating.
- Keep the term title updated when the node title changes.
- Delete the term and mapping when the node is deleted.
- Backfill existing nodes via the batch import form.
- Add a single mapping from the CLI with `drush eatas`.
- Feed the mapped term id into a View via the argument-default plugin.
- Build "related content by auto-term" listings.
- Maintain a 1:1 node↔term taxonomy automatically.
- Assign a node's auto-term across multiple vocabularies.
- Drive contextual Views filters from the node's auto-term.
- Restrict the batch route so only admins can trigger term creation.
- Review the `{eat}` table for entity-to-term mappings.
- Configure mappings at `/admin/config/system/eat`.