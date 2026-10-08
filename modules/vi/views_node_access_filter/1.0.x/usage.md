Views Node Access Filter adds a non-exposable Views filter, "Editable", on the Content and Content revision tables that restricts a view's results to only the nodes the current user has edit (update) access to — typically to make the /admin/content listing show editors only what they can edit.

---

The module adds an "Editable" filter to `node_field_data` and `node_field_revision` via `hook_views_data_alter`; the filter plugin (`Editable`, id `views_node_access_filter_editable`) tags the SQL query with `views_node_access_filter_editable`, and `hook_query_TAG_alter` then sets the query metadata `op = update` and adds the core `node_access` tag so core's `node_query_node_access_alter()` joins the node access table filtering for UPDATE grants. To make update access work for list queries (core only registers *view* grants in the node access registry for performance), the module implements `hook_node_grants()` and `hook_node_access_records()` to register per-role, per-content-type edit grants ("edit any … content" for gid 0, "edit own … content" for the owner id) mirroring core's permission model, and uses `hook_module_implements_alter` to order its hooks correctly relative to core. Crucially it is fail-closed: the filter cannot be exposed (`canExpose()` returns FALSE, so no exposed input/URL parameter can weaken it), its own grants set `grant_view = 0` (they never grant view), and `hook_node_access_records_alter` re-adds core's default *view* grant only when no other node-access module has defined records — so enabling the module does not open up view access that core would otherwise deny. Grants are rebuilt automatically when a role changes (`hook_ENTITY_TYPE_update` on user roles) and via the standard core triggers (node save, permission save, module enable/disable); the update hook flags a rebuild on install. It has no config UI (`configure` null), no settings, no permissions of its own, and works only with SQL Views. Caveat (documented in `hook_help`): node-access modules that change update access purely through `hook_node_access()` without registering grants are not reflected, and the filter is SQL-only (throws for non-SQL query backends).

---

- Restrict /admin/content (or a cloned content view) to only nodes the current editor can edit.
- Build an editor dashboard that lists just the content a user is allowed to modify.
- Add an "Editable" boolean-style filter to any node-based view without exposing it to visitors.
- Filter a Content revisions view to revisions of nodes the user can update.
- Give section editors a My-editable-content listing based on "edit own/any" permissions.
- Constrain a bulk-operations (VBO) view so operations only target editable nodes.
- Combine with role-based edit permissions to scope large multi-editor sites.
- Show a moderation queue limited to items the current user can actually edit.
- Provide a per-user "content I can work on" block sourced from a view.
- Ensure a view respects `edit any <type> content` / `edit own <type> content` grants in SQL.
- Keep the access constraint fail-closed (no exposed filter to tamper with via request params).
- Preserve normal view access for anonymous/other users when the module is enabled (default view grant is retained when no other node-access module is active).
- Integrate with other node-access modules that DO register grants (module defers to them for view).
- Add editor-friendly UX to a custom admin listing without writing a custom filter plugin.
- Filter contextual/related-content views down to editable nodes for inline-edit workflows.
- Rebuild node grants automatically after changing a role's edit permissions.
- Scope a Views REST export/display to a user's editable nodes.
- Replace ad-hoc "author = current user" filters with real edit-access checking.
- Use as a building block for delegated content administration on multi-team sites.
