<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACL API functions, tables & node-access hooks

All functions are **procedural**, defined in `acl.module` (globally available once the module
is enabled). There are no services. `$module` is the client module's machine name; a list is
identified by a free-form `$name` (string) and/or `$figure` (int) — use either or both.

## Tables (`acl.install`)

- **`acl`** — one row per list: `acl_id` (serial PK), `module`, `name` (varchar, nullable),
  `figure` (int, nullable).
- **`acl_user`** — membership: `acl_id`, `uid` (PK `acl_id,uid`).
- **`acl_node`** — node grants: `acl_id`, `nid`, `grant_view`, `grant_update`, `grant_delete`
  (tiny int 0/1), `priority` (small int). PK `acl_id,nid`.

## Create / delete lists

- `acl_create_acl($module, $name = NULL, $figure = NULL): int` — insert a list, returns new `acl_id`.
- `acl_delete_acl($acl_id)` — delete the list and its `acl_user` + `acl_node` rows.

## Manage users on a list

- `acl_add_user($acl_id, $uid)` — add a user (idempotent; skips if already present).
- `acl_remove_user($acl_id, $uid)` / `acl_remove_all_users($acl_id)`.
- `acl_has_users($acl_id): int` — count of users. `acl_has_user($acl_id, $uid): int`.
- `acl_get_uids($acl_id): array` — the uids. `acl_get_usernames($acl_id): array` — uid → display name.

## Attach a list to nodes (the grants)

- `acl_node_add_acl($nid, $acl_id, $view, $update, $delete, $priority = 0)` — grant this list
  view/update/delete on one node (replaces any existing row for that acl_id+nid).
- `acl_node_add_acl_record(array $record)` — same via an assoc array
  (`acl_id`, `nid`, `grant_view`, `grant_update`, `grant_delete`, `priority`).
- `acl_add_nodes(SelectInterface $subselect, $acl_id, $view, $update, $delete, $priority = 0)` —
  grant a list access to **every node** returned by a `nid` subquery (bulk).
- `acl_node_remove_acl($nid, $acl_id)` — detach one list from one node.
- `acl_node_clear_acls($nid, $module)` — remove all of a module's lists from a node.

## Look up lists

- `acl_get_id_by_name($module, $name, $figure = NULL): ?int`
- `acl_get_id_by_figure($module, $figure): ?int`
- `acl_get_ids_by_user($module, $uid, $name = NULL, $figure = NULL): array`

## Embeddable form

- `acl_edit_form(FormStateInterface $form_state, $acl_id, $label = NULL, $new_acl = FALSE)` —
  returns a user-list edit widget (from `acl.admin.inc`) you can embed in your own form.

## Node-access integration (implemented by ACL for you)

- `hook_node_grants()` → returns `['acl' => [acl_ids the current user is in]]` (realm `acl`).
- `hook_node_access_records()` → for each `acl_node` row, emits a grant **only if** the owning
  `module`'s `hook_enabled()` returns TRUE **and** the list has users (`acl_has_users`);
  otherwise emits a 0/0/0 **deny** with the same gid/priority.
- `hook_node_delete()` deletes the node's `acl_node` rows; `hook_user_cancel()` deletes the
  user's `acl_user` rows.
- `hook_node_access_explain()` renders a human explanation (calling the client's
  `hook_acl_explain()` if present).

**Important:** ACL is a node-access module, so after creating/removing grants you typically
need node access to be rebuilt (`node_access_rebuild()` / `drush php-eval "node_access_rebuild();"`)
for `access` checks to reflect them, and enabling ACL itself requires a permissions rebuild.
