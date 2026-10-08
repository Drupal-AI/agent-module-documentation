<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ACL is a developer API that lets other modules build per-user access control lists and grant those users view/update/delete access to individual nodes; it has no UI and does nothing on its own.

---

ACL registers a Drupal node-access **realm `acl`** and stores its data in three database tables: `acl` (each list: `acl_id`, owning `module`, plus a free-form `name` and/or numeric `figure`), `acl_user` (which `uid`s belong to a list) and `acl_node` (which `nid` a list grants access to, with `grant_view`/`grant_update`/`grant_delete` flags and a `priority`). A client module creates a list with `acl_create_acl($module, $name, $figure)`, adds users with `acl_add_user($acl_id, $uid)`, and attaches the list to nodes with `acl_node_add_acl($nid, $acl_id, $view, $update, $delete, $priority)` (or `acl_add_nodes()` for a subquery of many nodes). At runtime ACL implements `hook_node_grants()` (returning realm `acl` with the `acl_id`s the current user belongs to) and `hook_node_access_records()` (emitting a grant per `acl_node` row — but only if the owning module confirms it is active via its `hook_enabled()` and the list actually has users; otherwise it emits a deny). It also cleans up automatically: `hook_node_delete()` drops a node's `acl_node` rows and `hook_user_cancel()` drops a cancelled user's `acl_user` rows. A rich set of lookup helpers (`acl_get_id_by_name`, `acl_get_id_by_figure`, `acl_get_ids_by_user`, `acl_has_user`, `acl_has_users`, `acl_get_uids`, `acl_get_usernames`) let client modules find and inspect lists, and `acl_edit_form()` provides an embeddable user-list widget. Because Drupal treats it as a node-access module, **enabling ACL forces a permissions rebuild**. It also ships D6/D7→D8+ migrate source/destination plugins for upgrading legacy ACL data.

---

- Build a "private node shared with specific users" feature where an editor picks who can see a node.
- Grant a named group of users edit access to a particular node without using roles.
- Let a client module give per-user view/update/delete access to individual nodes.
- Implement document-level permissions (e.g. only assigned reviewers can edit a given article).
- Share a single ACL across several nodes via `acl_add_nodes()` and a node subquery.
- Track a list by a human-readable `name` (e.g. `editors`) and look it up with `acl_get_id_by_name()`.
- Track a list by a numeric `figure` (e.g. an external id) and look it up with `acl_get_id_by_figure()`.
- Find every ACL a given user belongs to for a module with `acl_get_ids_by_user()`.
- Check whether a user is on a list with `acl_has_user()` before showing an action.
- List the usernames granted by a node's ACL with `acl_get_usernames()` for an admin report.
- Deny access when a list exists but has no users (ACL emits a deny grant automatically).
- Add or remove a user from a list on the fly with `acl_add_user()` / `acl_remove_user()`.
- Clear an entire list's membership with `acl_remove_all_users()`.
- Detach an ACL from a node with `acl_node_remove_acl()` or clear all of a module's ACLs from a node with `acl_node_clear_acls()`.
- Embed the ACL user-selection form inside your own settings form via `acl_edit_form()`.
- Explain a node's ACL grants in the node-access debug view by implementing `hook_acl_explain()`.
- Gate a list's grants behind your module's active state via `hook_enabled()`.
- Co-exist with the core node_access system and other node-access modules (each is its own realm).
- Prioritise competing grants with the `priority` argument on `acl_node_add_acl()`.
- Grant view-only vs full edit by toggling the `grant_view`/`grant_update`/`grant_delete` flags.
- Automatically drop a node's ACL rows when the node is deleted (no manual cleanup).
- Automatically drop a user's ACL memberships when the user account is cancelled.
- Migrate Drupal 6/7 ACL data into Drupal 10/11 using the bundled migrate plugins.
- Use it as the shared ACL backend so multiple access modules interoperate without knowing each other.
