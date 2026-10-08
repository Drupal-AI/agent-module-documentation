<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Recycle adds a recycle bin so that deleting a content entity moves it to a recoverable bin instead of permanently removing it.

---

Entity Recycle turns entity deletion into a soft delete for the entity types and bundles you enable. When enabled for a bundle, the module attaches a locked boolean field named `recycle_bin`; the entity's delete form is re-purposed so that the first "delete" moves the entity to the bin (sets `recycle_bin = 1` and unpublishes it) and a second delete on a binned item permanently removes it. Binned items are hidden from users who lack the view-recycle-bin permission, can be listed in the bundled "Content Recycle Bin" view at `admin/content/node/recycle-bin`, and can be restored from a per-item confirmation form. An optional purge time (in minutes, on the settings form) lets cron permanently delete items that have been in the bin longer than the configured age. The module depends only on Drupal core (node), provides its own permissions, a settings form, a "Recycled entity alert" block, and a set of `hook_recycle_bin_*` invoke-all hooks for reacting to recycle/restore/delete events.

---

- Give editors an "undo" for content deletion so accidental deletes are recoverable.
- Enable a recycle bin for the Article and Page content types.
- Enable the recycle bin for a custom content entity type that has bundles.
- Move a node to the recycle bin instead of deleting it permanently.
- Restore a node from the recycle bin back to its previous state.
- Permanently delete an item that is already in the recycle bin.
- Automatically purge binned items after a set number of minutes via cron.
- Configure which entity types and bundles have recycle-bin behaviour at `/admin/config/content/entity_recycle`.
- List all content currently in the recycle bin at `admin/content/node/recycle-bin`.
- Grant a role permission to view items in the recycle bin.
- Grant a role permission to restore items from the recycle bin.
- Grant a role permission to permanently delete items from the recycle bin.
- Grant a role permission to move items into the recycle bin.
- Restrict recycle-bin administration (which types are enabled, purge time) to administrators.
- Show a warning banner on a binned entity's page using the "Recycled entity alert" block.
- Warn editors that a binned item will be permanently deleted on the next cron run.
- React to items being moved to the bin with a custom `hook_recycle_bin_recycled()` implementation.
- React to items being restored with a custom `hook_recycle_bin_entity_restored()` implementation.
- React to permanent deletion with `hook_recycle_bin_entity_pre_delete()` / `hook_recycle_bin_entity_deleted()`.
- Keep recycled items out of other views by adding a `recycle_bin = FALSE` filter to those views.
- Programmatically exclude recycled items from all views with `hook_views_query_alter()` (see the module README).
- Protect a production site against destructive editor mistakes without database backups.
- Provide a staging area for content pending final deletion review.
- Migrate away from ad-hoc "unpublish instead of delete" workflows to a first-class trash bin.
- Uninstall cleanly: the module removes its `recycle_bin` fields and the recycle-bin view on uninstall.
