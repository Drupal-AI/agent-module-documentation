<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reassign Deleted User Content / Media — agent index

Reassigns a deleted user's content to another user during account cancellation, and provides a
bulk node re-author action. **No configuration** (`configure: null`), no permissions of its own.

- **The two ways to use it: the account-cancel method and the bulk action / form** →
  [configure/reassigning.md](configure/reassigning.md)
- **Internals: the Action plugin, hooks, MediaBatchService, tables touched** →
  [api/internals.md](api/internals.md)

Key facts:
- Adds user-cancel method `user_cancel_reassign_content` (via
  `hook_user_cancel_methods_alter`); the cancel forms gain a required "Choose user to assign"
  autocomplete when it's selected.
- On cancel: nodes via `node_mass_update`, node revisions via direct `node_field_revision` /
  `node_revision` updates, `content_moderation` states, media (`MediaBatchService`), groups
  (uid). Comments are **anonymized**, not reassigned.
- Bulk action: `reassign_user_content_action` (`system.action`, type `node`) → tempstore →
  form at `/admin/content/reassign-author` (route `reassign_user_content.reassign_author`,
  permission `access content`).
- Requires `node`, `user`; media/group/comment/content_moderation handling is conditional.
