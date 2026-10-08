<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Merge Translations lets content editors combine separate single-language nodes into one translated node, recreating Drupal 7-style translation relationships that are lost after migrating to Drupal's core content-translation system.

---

The module adds a **Merge translations** tab to every node (`/node/{node}/merge_translations`, gated by the `merge_permissions admin` permission). On that form the current node is the *target*; for each site language a row lets you pick a *source* node (entity autocomplete restricted to the same content type) whose values become that language's translation on the target. Submitting copies each source node's field values into the target as a new translation via `addTranslation()` (existing translations are left untouched, with a warning). Before adding, values pass through the `hook_merge_translations_prepare_alter` alter hook so other modules can adjust them. A per-form "Action with source node after import" option can additionally delete the source node — but that option only appears, and the deletion only runs, when the user has node delete access (`bypass node access`, `delete any/own <type> content`), with a final `access('delete')` check. The form is disabled when the content type is not translatable or the node already has all translations. There is no config UI (`configure` is null) and no config schema; it depends on core `content_translation`.

---

- Rebuild translation sets after migrating content from Drupal 7's translation model.
- Merge several orphaned single-language nodes into one multilingual node.
- Add a German translation to an English node by pointing at an existing German node.
- Combine per-language nodes of the same content type into a single translated node.
- Copy field values from a source-language node into the target as a new translation.
- Bulk-attach translations for every language in one form submission.
- Optionally delete the source node(s) after merging (when the editor has delete access).
- Keep existing translations intact (the form warns instead of overwriting them).
- Restrict source selection to the same content type as the target node.
- Give a specific role the ability to merge translations via the `merge_permissions admin` permission.
- Alter incoming values before they become a translation with `hook_merge_translations_prepare_alter`.
- Normalise a legacy content set into core content-translation structure.
- Consolidate duplicate language nodes created by editors into one entity.
- Prepare content for language switching by unifying translations under one node.
- Provide editors a UI-driven alternative to writing a custom translation-merge script.
