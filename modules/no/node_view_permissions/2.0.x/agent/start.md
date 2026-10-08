# node_view_permissions — agent start

Adds per-content-type **`view own {type} content`** and **`view any {type} content`** permissions
for every node type — the view-level granularity core lacks (core only has per-type `edit own/any`
and `delete own/any`, plus one broad "access content"). Enforced through Drupal's node access grant
system (`hook_node_access_records()` + `hook_node_grants()`), so it also filters Views, listings, and
search. Depends on core `node`. No admin settings form and no `configure` route — manage everything at
**People → Permissions** (`/admin/people/permissions`).

- The permissions it adds, how grants enforce them (published/unpublished, own vs any, language) → [permissions/node_view_permissions.md](permissions/node_view_permissions.md)
