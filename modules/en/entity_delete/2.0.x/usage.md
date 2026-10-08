<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Delete adds an admin form at `/admin/config/entity-delete` for deleting all (or all of one bundle of) content entities of a chosen entity type in bulk, processed via the Batch API.

---

The module exposes a two-step admin flow gated by the `use entity_delete` permission (`restrict access: TRUE`). On the first form (`EntityDeleteForm`) you pick a content entity type (only `ContentEntityType` definitions are listed) and, via AJAX, an optional bundle — or `All`. Submitting redirects to a CSRF-token-protected confirmation route (`EntityDeleteConfirmationForm`); the entity type and bundle travel as query parameters. On confirm, it builds an entity query (with a few special cases: `watchdog` + `all` runs a raw `TRUNCATE` on the `watchdog` table to clear logs; the `user` entity excludes uids 0 and 1; `users` and `file_managed` labels are mapped to the `user`/`file` entity types; `comment`, `file`, `user`, `watchdog` are excluded from bundle conditions), chunks the matched IDs into batches of 25, and deletes them through `EntityTypeManager::getStorage()->delete()` in a batch operation with a completion message. There is no `.module`-level config beyond the confirmation-label config object shipped in `config/install`, no Drush command, and no config schema. It is a destructive maintenance/cleanup tool intended for trusted administrators only.

---

- Delete every node on the site in one operation (select Content → All).
- Delete all nodes of a single content type (e.g. every `article`).
- Bulk-delete all users except the anonymous (uid 0) and admin (uid 1) accounts.
- Delete all taxonomy terms, optionally scoped to one vocabulary.
- Delete all comments on the site.
- Delete all managed files (`file` entities) in bulk.
- Clear all log entries by truncating the `watchdog` table (Log Entries → All).
- Wipe all entities of a custom content entity type provided by another module.
- Clean out a staging/QA site's content before a fresh import.
- Reset content after load-testing or content-generation (e.g. Devel Generate) runs.
- Remove all Commerce entities (orders, products, variations, stores, profiles) when Commerce is installed.
- Purge a specific bundle's content while leaving other bundles intact.
- Batch-delete large content sets without hitting PHP timeouts (25-item chunks).
- Provide site builders a UI alternative to writing a custom deletion script.
- Empty a vocabulary before re-importing terms from a feed.
- Bulk-remove media entities of a given media type.
- Delete all entities of a type as part of a decommissioning / data-retention task.
- Give a trusted admin role a self-service "delete all X" button behind one permission.
- Remove test content quickly during development iterations.
- Clear accumulated log noise from `dblog` without visiting the report UI.
