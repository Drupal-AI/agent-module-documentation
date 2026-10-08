<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comment Delete replaces core's all-or-nothing comment deletion with configurable per-field rules for how a deleted comment's threaded replies are handled, plus fine-grained permissions and an optional delete time limit.

---

The module hangs its configuration off each **comment field** as third-party settings (there is no global settings page and `configure` is null). On a comment field's edit form it adds a "Comment Delete" section where you choose the allowed delete **operations** — hard (delete comment and its replies), partial hard (delete comment and move replies up one thread level), and soft (delete comment but keep replies) — plus operation visibility, custom labels and confirmation messages (token-enabled), a soft-delete mode (unset field values or set unpublished), author anonymization, a default operation, and an optional time limit. At runtime it alters the comment delete confirmation form to offer the enabled operations, overrides comment `delete` access via `hook_comment_access()` using a rich permission scheme, and executes the chosen operation through the `comment_delete.manager` service, recalculating thread structure via `comment_delete.thread_manager`. It defines both static permissions (delete own/any comment, with "anytime" variants that ignore the time limit) and **dynamically generated per-field permissions** (delete own/any/replies for each entity-type + bundle + comment field, and "allow <op>" toggles gating which operations a role may pick).

---

- Let users delete their own comments while preserving the replies underneath them (soft delete).
- Delete a spam comment and all of its replies in one action (hard delete).
- Remove an off-topic comment but promote its replies up one level so the thread stays readable (partial hard delete).
- Give moderators an "anytime" permission to delete comments even after the normal time limit.
- Allow authors to delete their own comment only within N seconds of posting via the delete time limit.
- Let a comment author delete immediate replies to their own comment (reply-owner permissions).
- Anonymize the author of a soft-deleted comment to the site's Anonymous user while keeping the thread intact.
- Blank out a soft-deleted comment's subject and custom fields ("unset values" mode) instead of showing removed text.
- Keep thread levels intact by setting soft-deleted comments to unpublished instead of unsetting them.
- Customize the confirmation message shown after each delete operation, using comment tokens.
- Rename the operation labels editors see (e.g. call soft delete "Redact comment").
- Restrict which roles may perform hard vs soft deletes per comment field with the "allow <op>" permissions.
- Force a single delete behavior by hiding the operation chooser (invisible visibility) and setting a default op.
- Only show the operation chooser when more than one operation is actually available to the user.
- Provide different delete rules for a blog's comment field versus a forum's comment field.
- Preserve discussion continuity on a busy forum by defaulting to partial hard delete.
- Let support staff delete any comment on a knowledge-base while regular users delete only their own.
- Comply with a "users may remove their own contributions" policy without cascading reply loss.
- Recalculate comment thread ordering automatically after a partial hard delete.
- Automatically hard-delete a soft-deleted comment when it turns out to have no replies.
- Offer a time-boxed "undo" window where a freshly posted comment can still be deleted by its author.
- Apply distinct confirmation copy per operation so users understand what will happen to replies.
- Grant fine-grained delete rights per content type by using the generated per-field permissions.
- Migrate away from custom comment-deletion code by expressing the rules as field third-party settings.
