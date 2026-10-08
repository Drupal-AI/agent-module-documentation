Taxonomy Bulk Actions adds checkboxes and a bulk-action selector to the taxonomy term overview page so you can delete, publish or unpublish many terms at once.

---

Via `hook_form_alter` on the core `taxonomy_overview_terms` form, the module adds a per-term checkbox column, a "select/deselect all" toggle, an action `<select>`, and an "Apply to selected items" button (with a small JS helper library). The available actions come from a `taxonomy_bulk_actions` **plugin type** (annotation `@TaxonomyBulkActions`, manager `plugin.manager.taxonomy_bulk_actions`); three ship: Delete, Publish and Unpublish selected terms. Each plugin declares an optional `vids` list to limit it to certain vocabularies and an `access(AccountProxyInterface)` method that is checked both when building the options and before executing — Delete allows `delete terms in <vid>` or `administer taxonomy`; Publish/Unpublish require `administer taxonomy`. Applying an action collects the selected term ids (or all terms in the vocabulary when "select all" is used), loads them, and runs the action inside a Batch (`executeMultiple()` per term), with a completion message. There is no configuration page, no permissions of its own, and no config; it relies entirely on core taxonomy permissions. The form only appears on the term overview, which itself requires `administer taxonomy`.

---

- Delete many taxonomy terms at once from the term overview.
- Publish multiple terms in one batch.
- Unpublish multiple terms in one batch.
- Select all terms in a vocabulary and act on them together.
- Clean up a large, messy vocabulary quickly.
- Bulk-remove obsolete tags after a content migration.
- Unpublish seasonal terms out of season, then republish later.
- Apply an action to a hand-picked subset of terms via checkboxes.
- Add a custom bulk action (e.g. set a field) by writing a `taxonomy_bulk_actions` plugin.
- Restrict a custom bulk action to specific vocabularies via `vids`.
- Gate a bulk action behind a custom permission via its `access()` method.
- Batch-process large term sets without timeouts.
- Give editors a faster term-management workflow than one-by-one edits.
- Purge test/demo terms before launch.
- Enforce `delete terms in <vid>` permission for term deletion.
- Provide publish/unpublish controls for moderated taxonomies.
- Reduce clicks when curating category vocabularies.
- Bulk-tidy an imported glossary or tag list.
- Operate only on terms of the currently viewed vocabulary.
- Show a completion message summarising the applied action.
