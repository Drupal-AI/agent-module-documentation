Trash adds a site-wide recycle bin: instead of permanently deleting content entities, it soft-deletes them so they can be reviewed, restored, or purged later.

---

Trash intercepts entity deletion for the entity types you enable (nodes, taxonomy terms, menu links, files, path aliases, redirects, and other supported content entities) and, rather than removing the row, stamps a `deleted` timestamp so the entity is hidden from normal queries but still present in storage. A **Trash** admin listing at `/admin/content/trash` shows everything that has been soft-deleted, grouped per entity type, from which trusted users can restore items back to their original state or purge them for good. Behavior is controlled from a settings form at `/admin/config/content/trash`, where you choose which entity types/bundles participate and optionally enable automatic purging after a configurable period (e.g. "30 days"), handled by a queue worker on cron. Under the hood a `TrashManager` service toggles a "trash context" (active/inactive/ignore) that determines whether entity and Views queries are filtered, and per-entity-type "trash handlers" (tagged services) encapsulate the special logic each type needs when it is deleted or restored (validating unique fields, path alias conflicts, menu tree updates, and so on). The module integrates with core Workspaces and provides restore/purge actions, dynamic Views for each enabled type, Drush commands, and a set of pre/post trash-delete and trash-restore hooks so custom code can react. It is a foundational safety net that prevents accidental data loss and gives editors an undo for deletions.

---

- Give editors an "undo" for accidentally deleted nodes.
- Add a recycle bin for taxonomy terms so deleting a term is recoverable.
- Soft-delete files and restore them if a reference still needs them.
- Recover a deleted menu link without rebuilding the menu by hand.
- Recover deleted path aliases and redirects after a bad bulk operation.
- Review everything deleted site-wide from a single `/admin/content/trash` listing.
- Restore a batch of trashed entities at once from the admin UI.
- Permanently purge selected items when you are sure they are no longer needed.
- Auto-purge trashed content after a retention window (e.g. 30 days) via cron.
- Enforce a data-retention policy by combining trash with scheduled purging.
- Limit which entity types can be trashed to just the ones you care about.
- Restrict which bundles of an entity type participate in the trash bin.
- Let junior editors delete content while trusted staff control permanent purging.
- Restore trashed entities from the command line with `drush trash:restore`.
- Purge trashed entities in bulk from the command line with `drush trash:purge`.
- Export the generated Trash Views for customization with `drush trash:export-views`.
- Provide a safety net before large content migrations or imports.
- Keep deleted content out of search results and listings while retaining it.
- Use with Workspaces so trashing behaves correctly across workspace previews.
- Simplify the trash overview page when many entity types are enabled (compact mode).
- Prevent restoring an entity that would violate a unique field (validated on restore).
- React to soft-deletion in custom code via `hook_entity_trash_delete()`.
- React to restoration in custom code via `hook_entity_trash_restore()`.
- Add trash support to a custom content entity type with a trash handler service.
- Run cleanup logic before an entity is soft-deleted using a pre-trash-delete hook.
- Show the entity ID column in trash listings via the `trash_label` field formatter.
- Build a moderation-style deletion workflow where deletions are reviewed before purge.
- Protect against accidental mass deletion during editorial mistakes.
- Give a decoupled/headless backend a recoverable deletion model for content.
