<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
bulk_comment_delete lets an administrator delete comments in bulk, grouped by the content type of the node each comment is attached to. It presents a form listing content types with their comment counts, then a confirmation step, then runs the deletions through the Batch API.

Use it to clean up spam or obsolete comments across a whole content type at once.
---
Enable with `drush en bulk_comment_delete` (depends on core `comment`). The tool is at `/admin/content/bulk-comments` (route `bulk_comment_delete.delete_comment`), with a confirm step at `/admin/content/bulk-comments/delete`. Both routes require the module's `administer bulk commnet delete` permission (note the typo in the permission machine name).

The build form (`src/Form/DeleteBulkCommentForm.php`) queries `comment_field_data` joined to `node` to count comments per type; the confirm form (`src/Form/ConfirmCommentDelete.php`) collects the chosen types (passed via `$_SESSION`), loads matching comment ids, and deletes them with `\Drupal::entityTypeManager()->getStorage('comment')->delete()` in a batch.
---
- Delete all comments attached to a given content type.
- Purge spam comments across an entire bundle at once.
- Clean up comments after retiring a content type.
- Review comment counts per content type before deleting.
- Confirm a destructive bulk delete before it runs.
- Process large comment deletions via the Batch API.
- Remove test comments left over from QA.
- Restrict bulk comment deletion to a specific permission.
- Avoid deleting comments one by one in the UI.
- Free up database space from unwanted comments.
- Target comments by the type of the commented node.
- Run the cleanup from the standard admin content area.
- Batch-delete without hitting PHP timeout limits.
- Give moderators a scoped bulk-delete capability.
- Reset a content type's discussion during a relaunch.
- Combine with spam detection to mass-remove flagged comments.