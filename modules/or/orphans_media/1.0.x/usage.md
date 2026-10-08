<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orphans Media finds media entities that nothing references and offers to delete them, reclaiming the storage a long-running site accumulates in unused uploads.

---

Media libraries grow in one direction. An editor uploads three versions of an image and uses one; a node referencing a document is deleted and the document stays; a migration imports assets that were never placed. None of it is visible, all of it is backed up and moved between environments, and on an older site it can be most of the file storage. After enabling the module (which needs core **Media**), an administrator with the **Access Orphans Media delete** permission opens **Configuration → Media → Orphans Media** (`/admin/config/media/orphans-media`), where a table lists the unreferenced items. You can filter by **media bundle**, by **title**, and by **created** / **updated** date ranges, sort the columns, choose a page size, then select rows and delete them in a batch after a confirmation screen; developers can hook into `pre_delete` / `post_delete` **events** to log or clean up alongside each deletion. The important caution is about what "orphan" can detect: reference tracking finds media referenced by **entity-reference fields** only; it does **not** reliably find media referenced from inside **rich-text fields** as an embedded item, from **Layout Builder** section configuration, from a **serialised setting**, or from another module's own tables. A media item used only in one of those ways looks orphaned and is not — so treat the list as candidates for review rather than a delete queue, take a backup, and confirm what the site actually uses to reference media before running it. Deletion is irreversible, and a missing image on a live page is a visible failure.

---

- Find media nothing references.
- Reclaim storage from unused uploads.
- Clean up leftover assets after a migration.
- Reduce backup size.
- Tidy a media library grown over years.
- Review unreferenced documents before removal.
- Free disk space on a small host.
- Prepare a site for a move between environments.
- Reduce media library clutter.
- Filter orphan candidates by media bundle.
- Narrow the list by created or updated date range.
- Search orphan candidates by title.
- Delete selected media in a confirmed batch.
- Delete leftover files after content removal.
- Find assets imported but never placed.
- Clean up test media.
- Restrict cleanup to a trusted role via its own permission.
- Log or clean up related data on each deletion via pre/post-delete events.
- Reduce the time it takes to restore a backup.
- Support a storage-cost reduction effort.
