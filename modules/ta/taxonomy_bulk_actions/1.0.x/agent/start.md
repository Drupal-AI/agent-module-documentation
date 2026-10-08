# Taxonomy Bulk Actions — agent index

Adds checkboxes + a bulk-action selector (Delete / Publish / Unpublish) to the core
`taxonomy_overview_terms` page. No config page (`configure` null), no own permissions — uses core
taxonomy permissions. The overview form itself requires `administer taxonomy`.

- **Add your own bulk action (`taxonomy_bulk_actions` plugin type)** →
  [plugins/action.md](plugins/action.md)

Key facts:
- Injected via `taxonomy_bulk_actions_form_alter` on form id `taxonomy_overview_terms`; submit
  handler `taxonomy_bulk_actions_apply` runs the chosen action in a Batch (`executeMultiple`).
- Plugin type `taxonomy_bulk_actions`: annotation `@TaxonomyBulkActions`
  (`src/Annotation/TaxonomyBulkActions.php`, fields `id`, `description`, `vids`), manager
  `plugin.manager.taxonomy_bulk_actions`, interface `TaxonomyBulkActionsInterface`, base
  `TaxonomyBulkActionsManagerBase`, dir `src/Plugin/TaxonomyBulkActions/`.
- Shipped plugins: `taxonomy_bulk_action_delete` (needs `delete terms in <vid>` or
  `administer taxonomy`), `taxonomy_bulk_action_publish` / `taxonomy_bulk_action_unpublish`
  (need `administer taxonomy`). Each plugin's `access()` is checked when listing options AND
  before executing.
