Change author action adds a bulk **action** to nodes (and media) that reassigns the author/owner of the selected items to a chosen user, via a two-step confirm form and a batch process.

---

The module (package "User interface") depends on the contrib `action` module and is based on the Bulk Update Fields codebase. It ships two action config entities using one plugin `change_author_action_base`: `change_author_action_base` for `node` and `change_media_author_action_base` for `media`. On the admin content listing, selecting items and choosing the "Change author" action stashes the selected entities in private tempstore (`change_author_ids`, keyed by current user id) and redirects to a confirm form at `/admin/change_author_action`. That route requires the core **`administer users`** permission (a `restrict access: TRUE`, trusted-admin permission). The form is a two-step wizard: step 1 asks for the new author via a user `entity_autocomplete` (anonymous excluded), step 2 shows a confirmation listing the affected items' titles; submitting runs a batch (`ChangeAuthorAction::updateFields`) that, for each entity whose owner differs, calls `setOwnerId()`, `setNewRevision()`, and `save()`. The action plugin's own `access()` check requires `update` access on each entity, so only content the user may edit can be selected. Config schema is provided (minimal). There is no settings page (`configure` null), no permissions defined by the module itself, and no Drush commands.

---

- Bulk-reassign the author of many nodes to a single user in one operation.
- Change the owner of selected media items in bulk.
- Hand off content ownership when an editor leaves or changes roles.
- Consolidate authorship of imported/migrated nodes under a canonical account.
- Fix incorrect authorship after a content migration.
- Reassign articles from a shared service account to individual editors (or vice versa).
- Set a uniform author across a batch of legacy content.
- Use the admin content view's bulk-action dropdown to change author without editing each node.
- Confirm the target author and review the affected item list before applying.
- Create new revisions when changing authorship so history is preserved.
- Skip items that already have the chosen author (no needless revision).
- Limit reassignment to content the operator can already edit (entity `update` access).
- Restrict the whole operation to trusted staff via the `administer users` permission.
- Reassign ownership of a topic's content to a new section editor.
- Batch-process large selections without PHP timeouts (uses Batch API).
- Reassign author on both nodes and media from the same module.
- Clean up authorship on demo/seed content before launch.
- Transfer authorship as part of an editorial reorganization.
- Provide a simple alternative to writing a custom VBO/action for author changes.
- Register additional entity-type actions by cloning the shipped action config with the same plugin.
