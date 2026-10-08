<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inbox view, VBO actions, block, autocomplete, hooks, cron, drush

## The inbox — `config/install/views.view.all_privatemsg_threads.yml`

Views view on base table `pm_index`.

- **default / page_1** (`/messages`) — table of subject, message count, participants, last updated.
  Access perm `privatemsg write messages`; **query-level** `uid_current` filter on the owner
  relationship restricts rows to the current user. Exposed filters: subject, member name (uid), tag.
  A hidden `deleted IS EMPTY` filter hides soft-deleted threads. Carries the VBO bulk form.
- **page_2** (`/user/%user/messages`) — admin display, access perm `administer site configuration`,
  uid contextual argument. For staff to inspect a user's threads.

## VBO actions — `src/Plugin/Action/*`

All four extend `ViewsBulkOperationsActionBase`, type `privatemsg_thread`, and delegate access to a
thread entity operation:

| Action | `access()` calls | `execute()` |
|---|---|---|
| `PrivatemsgReadThreadAction` (mark read) | `access('mark_read')` | updates caller's `pm_thread_history` access time |
| `PrivatemsgUnreadThreadAction` (mark unread) | `access('mark_unread')` | `markThreadGroupAsUnread` for caller |
| `PrivatemsgRemoveThreadAction` (remove) | `access('remove_thread')` | `markAsDeleted()` + save; removes caller from group members if >2 |
| `PrivatemsgChangeTagsAction` (change tags) | `access('change_tags')` | sets `tags` + save |

The `access('<op>')` handler checks a permission only, not ownership (see access-model.md and the
security review). Mark read/unread `execute()` only touch the caller's own history rows (harmless on
others' threads), but `remove`/`change_tags` mutate the loaded thread entity directly.

## Block, badge, autocomplete plugins

- `Plugin/Block/PrivateMessagesBlock` (`privatemsg_block`) — renders an "All messages (N)" unread
  counter using `getUnreadThreadCount()`; cache max-age 0.
- `PrivateMsgLazyBuilder` — lazy builders for the account-menu unread badge
  (`renderMenuItemTitle`) and the profile "Send this user a private message" link
  (`renderUserProfileLink`, which checks both users have messaging enabled and the write perm).
- `Plugin/EntityReferenceSelection/*` — `PrivatemsgUserSelection`, `PrivatemsgTagSelection`,
  `PrivatemsgUserBlockedSelection`, `PrivatemsgViewsUserSelection` selection handlers.
- `Plugin/EntityReferenceSelection/PrivatemsgAutocompleteMatcher` — **decorates**
  `entity.autocomplete_matcher`. Filters user suggestions (excludes blocked, messaging-disabled and
  self), adds role suggestions (only `allowed_roles`, gated by `privatemsg send to role`), scopes
  tag suggestions to the current user's own tags, and scopes the inbox member filter to users the
  current user has actually corresponded with.
- `Plugin/views/field/PrivatemsgMessagesCounterViewsField` — the "Messages count" column.
- `Plugin/DevelGenerate/*` — Devel Generate plugins for seeding threads (dev only).

## Hooks — `src/Hook/PrivatemsgHooks.php`

`preprocess_privatemsg_thread` (paginates messages 50/page, attaches reply form when member, builds
tag/leave links), `preprocess_privatemsg_message` (unread markers, per-message delete/block links,
avatar), `user_view` + `entity_extra_field_info` (profile send-link and enable/notify settings),
`user_insert` (defaults enable+notify on), `cron` (hard-delete messages soft-deleted longer than
`remove_after` days), `mail`, `taxonomy_term_insert` (stamps tag author), plus several views
render/query alters for the inbox. Tag output is escaped with `Html::escape()`.

## Drush — `src/Drush/Commands/PrivatemsgCommands.php`

`privatemsg:1to2` (alias `pmsg1to2`) migrates data from privatemsg 1.x tables (`pm_index_old`,
`pm_message_old`) into the 2.x entity model. Migration submodules
(`privatemsg_migration_d6`, `_d6_2`, `_d7`) provide migrate_plus source/destination plugins for
Drupal 6/7 imports.
