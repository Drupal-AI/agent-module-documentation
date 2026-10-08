View access per node (VAPN) is a simple per-node access-control module: on the content types you enable, each node gets a "View access per node" field where you pick the roles allowed to view that specific node.

---

VAPN only controls the **view** operation on nodes — it never affects create, update, or delete. You first select which content types (node bundles) it applies to on its settings form (`/admin/config/people/vapn`, config `vapn.settings` key `bundles`). For every enabled bundle the module attaches a computed `vapn` field (an unlimited entity-reference to `user_role`) defined in code via `hook_entity_bundle_field_info()`/`hook_entity_field_storage_info()`; it appears as a **View access per node** vertical tab (details group `advanced`) on the node edit form, rendered with the `options_buttons` (checkboxes) widget. Its `hook_node_access()` then decides view access: if a node has one or more roles selected, only users holding at least one of those roles may view it (everyone else is denied); if **no** roles are selected the module skips that node entirely and leaves access to core/other modules. The `bypass vapn` permission always grants view access; `use vapn` and `administer vapn` gate access to edit the field itself (via `hook_entity_field_access()`), and `administer vapn` is required to reach the settings form. Because it uses only `hook_node_access`, it composes reasonably with other access modules. (VAPN 3.x stores the roles in the `vapn` entity field; the old 2.x `{vapn}` database table and `manage vapn settings` permission are migrated away by `vapn_update_9000`.)

---

- Restrict a specific news article so only "editor" and "manager" roles can view it.
- Publish a node that is visible to authenticated users but hidden from anonymous visitors.
- Enable per-node view access only on the "Page" content type, leaving other types unaffected.
- Give a single sensitive node role-based visibility without building a full permissions scheme.
- Let content authors choose, per node, which roles may see it via a checkbox tab on the edit form.
- Create members-only content by selecting only a "member" role on those nodes.
- Keep draft-like nodes visible to staff roles while hidden from the public.
- Grant an "administrator"-style role blanket view access with the `bypass vapn` permission.
- Limit who can set per-node visibility using the `use editablefields`-style `use vapn` permission.
- Restrict access to HR or board documents modeled as nodes to specific internal roles.
- Apply role-gated visibility to a custom content type used for internal announcements.
- Leave a node open to everyone simply by selecting no roles (VAPN then does nothing for it).
- Combine with core publishing status: unpublished stays admin-only, published is role-gated by VAPN.
- Turn per-node access on for several content types at once from the settings form.
- Provide a lightweight alternative to complex node-access grant modules for view-only gating.
- Hide premium/subscriber nodes from anonymous users by selecting a "subscriber" role.
- Let a club/community site show certain pages only to logged-in members' roles.
- Configure which roles can view event nodes for a private event microsite.
- Prevent a role from seeing certain nodes by never granting it on those nodes.
- Migrate an old D7/2.x "View Permissions Per Node" setup into the 3.x field-based model.
- Audit per-node visibility by reading each node's `vapn` role-reference field.
- Restrict view access on a per-node basis without writing any custom access code.
- Keep view-access rules with the content (in the node itself) rather than in central config.
