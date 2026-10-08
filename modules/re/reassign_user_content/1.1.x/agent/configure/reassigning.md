<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Reassign User Content (two flows)

There is no settings page. The module offers two ways to move content ownership.

## Flow 1 — when deleting a user (account cancel)

1. Go to a user's **Cancel account** (`/user/{uid}/cancel`) or bulk-cancel from People
   (`user_multiple_cancel_confirm`).
2. Choose the cancel method **"Delete the account and make its content, media, and groups
   belong to another user."** (machine id `user_cancel_reassign_content`).
3. A **Choose user to assign** autocomplete appears (required for this method) — pick the
   destination user. (You cannot pick a user who is also being deleted.)
4. Confirm. The module reassigns the deleted user's content to the chosen user and anonymizes
   their comments.

What moves to the new user:

| Content | Handling |
|---|---|
| Nodes (current) | `node_mass_update(['uid' => $target])` |
| Node revisions | direct update of `node_field_revision.uid` and `node_revision.revision_uid` |
| Content Moderation states | `content_moderation_state_field_revision.uid` (if module on) |
| Media | `MediaBatchService::reassignUserMedia()` (if media on) |
| Groups | `group.uid` set to target (batched when > 10; if group on) |
| Comments | **anonymized** — owner set to 0, author name set to the site's anonymous name |

## Flow 2 — bulk re-author selected nodes

1. On the content overview (`/admin/content`), select nodes and run the action
   **"Reassign selected content to user"** (`reassign_user_content_action`, a `system.action`
   for the `node` entity type). The action only offers nodes you may update (it checks node
   `update` access and `uid` field edit access).
2. You are redirected to **`/admin/content/reassign-author`** (route
   `reassign_user_content.reassign_author`, the `AssignAuthorForm`).
3. Pick the destination user and **Assign**; the selected nodes (held in your private
   tempstore, key `reassign_user_content` / `selected_nodes`) are re-authored to that user.

The reassign-author route requires the `access content` permission.
