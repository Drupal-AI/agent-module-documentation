<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reassign Deleted User Content / Media adds an account-cancellation method that, when you delete a user, hands all of that user's content — nodes (and revisions), media, and groups — to another user you choose, while anonymizing their comments. It also ships a bulk "Reassign selected content to user" action for re-authoring nodes.

---

The module has no configuration; it works by extending Drupal's user-cancellation flow. Via `hook_user_cancel_methods_alter()` it adds a new cancel method, `user_cancel_reassign_content` ("Delete the account and make its content, media, and groups belong to another user"), and `hook_form_alter()` adds a "Choose user to assign" entity-autocomplete to the single (`user_cancel_form`) and multiple (`user_multiple_cancel_confirm`) cancel forms, shown/required only when that method is selected. On cancellation (`hook_user_cancel()` / a `hook_batch_alter()` override of the core `_user_cancel` batch op) it reassigns the deleted user's nodes with `node_mass_update(['uid' => …])`, updates old revisions directly in `node_field_revision` and `node_revision`, moves `content_moderation` draft revisions, reassigns media through a batched `MediaBatchService`, and re-owns `group` entities (batched above 10). Comments are **anonymized** (owner set to anonymous, author name set to the site's anonymous name) rather than reassigned. Validation blocks choosing a user who is themselves being deleted. Separately, it provides a core Action plugin `reassign_user_content_action` (a `system.action` config, entity type `node`) that stores the selected nodes in a private tempstore and redirects to `/admin/content/reassign-author` (the `AssignAuthorForm`), where you pick a user to become the author of those nodes. Requires only `node` and `user`; media, group, comment and content_moderation handling activate when those modules are present.

---

- Delete a user account and transfer all their nodes to another user in one step.
- Reassign a leaving employee's content to their manager during account cancellation.
- Move a deleted user's media items to a replacement owner.
- Re-own a deleted user's groups (Group module) to another user.
- Anonymize a deleted user's comments instead of leaving broken authorship.
- Reassign historical node revisions, not just the current revision, to the new user.
- Carry over content-moderation draft revisions to the new owner.
- Bulk re-author selected nodes to a chosen user via the content admin "Reassign selected content to user" action.
- Consolidate content ownership before removing stale accounts.
- Prevent orphaned content when cleaning up spam or bot accounts.
- Choose the target user with an autocomplete on the account cancel form.
- Guard against assigning content to a user who is also being deleted in a multi-delete.
- Batch-process large numbers of media, groups, or comments so cancellation doesn't time out.
- Keep content live and attributed after GDPR-driven account deletions.
- Hand off an author's articles to an editor account when they leave the organization.
- Re-author a batch of nodes selected from the content overview to a single owner.
- Merge two contributors' content under one account by reassigning then deleting.
- Notify the cancelled account by email (respecting the core cancel-notify option) while reassigning.
- Ensure comment threads remain intact (as anonymous) after their author is removed.
- Apply the reassign method during either single or multiple user cancellation.
- Use the reassign-author form reached from the bulk action to pick the destination user.
