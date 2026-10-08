<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comment Revision UI surfaces Drupal's built-in comment revision data through the same version-history / revert / delete interface that nodes have.

---

Comment entities are revisionable in core but ship no UI. This module registers the standard entity revision routes for comments and marks them as admin routes via a route subscriber (`CommentRevisionUiSubscriber`), so editors get `version_history`, `revision`, `revision_revert_form` and `revision_delete_form` pages for comments. Access is controlled by a mix of static "any" permissions and dynamic per-comment-type permissions generated in `CommentRevisionUiPermissions::permissions()` (e.g. `view comment <bundle> revisions`, `revert comment <bundle> revisions`).

There are no custom controllers, forms or external calls — it leans entirely on core's entity revision handlers and access system. Grant the revision permissions only to trusted roles, since reverting or deleting comment revisions is a content-mutation operation.

---
- View the revision history of any comment
- Inspect a specific historical comment revision
- Revert a comment to an earlier revision
- Delete an individual comment revision
- Grant `view any comment revisions` to auditors
- Grant `revert any comment revisions` to moderators
- Grant `delete any comment revisions` sparingly
- Use per-comment-type permissions for granular control (e.g. per bundle)
- Track who changed a comment and when
- Restore comment text lost to an accidental edit
- Treat comment revision pages as admin (uses admin theme)
- Audit moderation activity on threaded discussions
- Compare an edited comment against its prior version
- Give auditors read-only access to comment history
- Scope revision permissions per comment type/bundle
- Recover legitimate wording after vandalism was reverted
