Trash adds a site-wide recycle bin: instead of permanently deleting content entities, it soft-deletes them so they can be reviewed, restored, or purged later.

---

Trash intercepts entity deletion for the entity types you enable (nodes, taxonomy terms, custom menu links, files, path aliases, redirects, and other supported SQL-backed content entities) and, rather than removing the row, stamps a translatable, revisionable `deleted` timestamp field so the entity is hidden from normal queries but still present in storage. A **Trash** admin listing at `/admin/content/trash` (and `/admin/content/trash/{entity_type_id}`) shows everything that has been soft-deleted, per entity type, from which trusted users can restore items or purge them for good, individually or in bulk via a per-type Views bulk form. Behavior is controlled from a settings form at `/admin/config/content/trash`, where you choose which entity types and bundles participate and optionally enable automatic purging after a configurable period (e.g. "30 days"), handled by the `trash_entity_purge` queue worker on cron. Under the hood the `TrashManager` service toggles a "trash context" (active/inactive/ignore) that determines whether entity and Views queries are filtered, and per-entity-type "trash handlers" (tagged services) encapsulate the special logic each type needs when deleted or restored (validating unique fields, path-alias conflicts, menu-tree updates, and so on). Trash works by generating and substituting an entity storage subclass that overrides `delete()`, so even `$entity->delete()` and deletions from other modules are safely intercepted. It integrates with core Workspaces and Content Translation, provides restore/purge actions and dynamically built Views for each enabled type, Drush commands, a `trash_label` field formatter, search integration, and a set of pre/post trash-delete and trash-restore hooks so custom code can react. It is a foundational safety net that prevents accidental data loss and gives editors an undo for deletions.

---

- Give editors an "undo" for accidentally deleted nodes.
- Add a recycle bin for taxonomy terms so deleting a term is recoverable.
- Soft-delete files and restore them if a reference still needs them.
- Recover a deleted custom menu link without rebuilding the menu by hand.
- Recover deleted path aliases and redirects after a bad bulk operation.
- Review everything deleted for an entity type from the `/admin/content/trash` listing.
- Restore or purge a batch of trashed entities at once with the Views bulk form.
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
- Soft-delete and restore individual translations of multilingual content.
- Simplify the trash overview page when many entity types are enabled (compact mode).
- Prevent restoring an entity that would violate a unique field (validated on restore).
- React to soft-deletion in custom code via `hook_entity_trash_delete()`.
- React to restoration in custom code via `hook_entity_trash_restore()`.
- Add trash support to a custom content entity type with a trash handler service.
- Run cleanup logic before an entity is soft-deleted using a pre-trash-delete hook.
- Show the entity ID column in trash listings via the `trash_label` field formatter.
- Build a moderation-style deletion workflow where deletions are reviewed before purge.
- Give a decoupled/headless backend a recoverable deletion model for content.
