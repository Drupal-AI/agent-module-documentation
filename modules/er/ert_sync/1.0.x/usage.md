<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Translation Sync keeps entity-reference field values aligned across a node's translations. When a node is saved, it looks at the node's entity-reference fields and propagates the source values into the node's other translations (by default only filling empty targets or when cardinality differs), then saves the affected translations via Batch API.
It is aimed at multilingual sites where certain reference fields (e.g. related content, media, taxonomy) should stay identical across all translations rather than being maintained separately per language.
---
Install with `drush en ert_sync`; there is no configuration UI, routes or permissions. The logic runs entirely in `hook_entity_update`: it iterates the node bundle's field definitions, finds `entity_reference` fields, and calls a synchronization routine that compares the source translation's values against each translation and updates the translation when the target is empty (or counts differ). A `dont_update_translate` flag is set on entities saved by the batch to prevent recursive re-processing.
Because it operates purely inside the entity update hook on server-side save flows (no HTTP endpoint of its own), its surface is limited to the normal node-save path; who can save a node is governed by core node access. Note the hook's guard means it only acts when the recursion flag is present on the entity, so review behaviour on a staging site before relying on it.
---
- Install: `composer require drupal/ert_sync && drush en ert_sync -y`.
- No configuration screen — behaviour is automatic on node update.
- Saving a node propagates its entity-reference field values to translations.
- By default only empty target fields (or differing cardinality) are updated.
- Updated translations are saved via a Batch API process.
- Keeps related-content/media/taxonomy references consistent across languages.
- Uses `dont_update_translate` to avoid recursive re-saving during the batch.
- Works on the `node` entity type's translatable reference fields.
- Only fields present as translatable on the bundle are considered.
- Reduces manual per-language maintenance of shared reference fields.
- No routes, permissions or endpoints are added.
- Access is governed by normal node edit/save permissions.
- Batch shows a per-translation save message and a completion summary.
- Test on staging — the update-hook guard affects when sync actually runs.
- Uninstall to stop synchronization; existing values are left in place.
- Pair with content_translation for the multilingual setup it assumes.
