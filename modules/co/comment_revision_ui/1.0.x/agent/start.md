<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Revision UI (comment_revision_ui) — agent index

**Adds core's version-history / revert / delete revision UI to comment entities.**

- **Version:** 1.0.x
- **Core:** ^9.1 || ^10
- **Depends:** drupal:comment
- **Routes:** reuses core `entity.comment.version_history|revision|revision_revert_form|revision_delete_form`, forced to admin routes by `CommentRevisionUiSubscriber`.
- **Permissions:** static `view/revert/delete any comment revisions` + `view any comment history`, plus dynamic per-bundle permissions from `CommentRevisionUiPermissions::permissions()`.

**Security:** all access flows through core entity-revision access and the module's own permissions; no custom controllers, mutating anonymous endpoints or external I/O. Revert/delete are content mutations — restrict those permissions to trusted roles.
