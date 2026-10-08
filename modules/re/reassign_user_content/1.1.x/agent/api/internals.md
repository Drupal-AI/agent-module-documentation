<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals — hooks, action, service, tables

## Hook implementations (`reassign_user_content.module`)

- `hook_user_cancel_methods_alter()` — registers the `user_cancel_reassign_content` method
  (label mentions media/groups when those modules are enabled).
- `hook_form_alter()` — adds the required `user_to_assign` entity_autocomplete (target `user`)
  to `user_cancel_form` and `user_multiple_cancel_confirm`, visible only for that method; adds
  a validate callback (`reassign_user_content__cancel_user_form_validate`) preventing the target
  from being one of the accounts being deleted.
- `hook_user_cancel()` — the reassignment logic (nodes, revisions, moderation, media, groups;
  comment anonymize). Runs directly for a single cancel.
- `hook_batch_alter()` — swaps the core `_user_cancel` batch operation for
  `reassign_user_content__reassign_user_content` so multi-user cancellation uses this flow
  (core's `_user_cancel` only knows its built-in methods).

## Reassignment details

- Nodes: `node_mass_update($nids, ['uid' => $target], NULL, TRUE)` (loads `node.admin` inc).
- Revisions: raw `db->update('node_field_revision')` / `db->update('node_revision')`
  (`revision_uid`) filtered by the old uid; content_moderation the same on its revision table.
- Comments: `_reassign_user_content_anonymize_comments()` — per translation sets owner 0 and
  author name to `user.settings:anonymous`; batched (chunks of 5) when > 10 comments.
- Groups: set `uid` on each `group`; batched (`_reassign_user_content_group`, 10 at a time)
  when > 10 groups.
- Media: `MediaBatchService::reassignUserMedia($medias, $target_uid)`.

## The Action plugin

`src/Plugin/Action/ReassignUserContentAction.php`, attribute `#[Action(id:
'reassign_user_content_action', label: 'Reassign selected content to user', type: 'node')]`.
- `access($node, $account)` = node `update` access **andIf** `uid` field `edit` access.
- `executeMultiple($entities)` stores the node ids in `tempstore.private` bin
  `reassign_user_content` (key `selected_nodes`) and redirects to
  `reassign_user_content.reassign_author`. `execute()` is intentionally empty.
- Shipped as `config/install/system.action.reassign_user_content_action.yml`.

## Form & service

- `Form\AssignAuthorForm` (form id `reassign_user_content_assign_author`) — reads the tempstore
  node ids and re-authors them to the chosen `user_to_assign`.
- `MediaBatchService` — resolved via `class_resolver` (not a declared service); batches media
  re-ownership.
