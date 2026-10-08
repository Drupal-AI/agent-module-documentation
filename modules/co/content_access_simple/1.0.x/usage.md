<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Access Simple gives content editors a compact list of roles for setting per-node view access directly on the node edit form, delegating the actual enforcement to the Content Access module's node grants.

---

The module solves the usability problem of the full Content Access per-node form (a screen of grant/view/update/delete checkboxes) by exposing only the "view" operation as an "Access and Permissions" details section on the node form. It appears only when the content type has "Per content node access control settings" enabled in Content Access and only for users holding the `access content access simple` permission. On submit it re-uses Content Access's own APIs — `content_access_save_per_node_settings()`, `acquireGrants()` and `node.grant_storage->write()` — so real node access grants are written and all cache bins are cleared; this module never bypasses access, it is purely a thinner UI over Content Access enforcement.

Configuration today is code/config only via `content_access_simple.settings.yml`: `role_config.hidden_roles` (roles removed from the list, defaulting to anonymous/authenticated/administrator), `role_config.disabled_roles` (roles shown but with disabled checkboxes), a `debug` flag that logs "complex" scenarios, and customisable `help_text_view` / `unpublished_message` strings. If a node's per-node "view own" or hidden-role "view" settings diverge from the content-type defaults the module marks the node "complex" and refuses to edit it here, directing editors to the full Content Access form. Admin-supplied message/help strings are passed through `Xss::filterAdmin()` before render.

---

- Give editors a compact per-node "who can view" role list on the node form.
- Restrict which roles may view a specific node without the full Content Access UI.
- Enable per-node view access on a content type (Content Access) so the widget appears.
- Grant the `access content access simple` permission to trusted editor roles.
- Position the "Access and Permissions" section via Manage form display.
- Hide anonymous/authenticated/administrator (default) from the editable role list.
- Add extra roles to `hidden_roles` so editors cannot toggle them.
- Show-but-lock roles via `disabled_roles` (e.g. stop lower roles editing higher roles).
- Customise the help text under the visibility checkboxes (`help_text_view`).
- Customise the unpublished-node message (`unpublished_message`).
- Auto-list roles that can view unpublished content (with view_unpublished installed).
- Turn on `debug` to log "complex" per-node scenarios to the log.
- Detect nodes whose per-node settings diverged from defaults ("complex") and edit them via the full form.
- Fall back to `/node/{nid}/access` for complex nodes.
- Let the module write real node grants (acquireGrants + node.grant_storage) on save.
- Clear all cache bins automatically after a per-node change.
- Audit which roles currently hold view access on a node before publishing.
- Simplify editorial workflows where only "view" access needs per-node control.