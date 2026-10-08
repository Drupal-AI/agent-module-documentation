<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Display Title gives nodes two titles — an internal admin title and a "display title" shown to site visitors — by adding a `display_title` base field and swapping it in when the node is viewed.

---

The module adds a `display_title` string base field to all nodes (`hook_entity_base_field_info`) and replaces the node entity class with `NodeDisplayTitle`, which overrides `getTitle()` and `label()` to return the display title on non-admin routes when one is set. It also implements `hook_ENTITY_TYPE_load`: on front-end (non-admin) routes that are not the node's own edit/delete form, it copies `display_title` into the node's `title` so the visitor-facing title is used consistently, while admin pages and the edit/delete forms keep showing the real admin title. A settings form (`/admin/config/content/display-title-settings`, permission `manage display title field settings`) selects which content types expose the field.

Access to the field on the node form is controlled by two permission families: the global `access display title field` and per-bundle `access {bundle} display title field` permissions (provided via `NodeDisplayTitlePermissions`), combined with the per-bundle enable flag stored in `node_display_title.settings:bundles`. The field is only shown on the form when the user has the permission and the bundle is enabled. There are no anonymous or mutating endpoints — just an admin config form and permission-gated form field — so there are no notable security concerns beyond standard field access control.

---

- Show visitors a different node title than editors see in the admin
- Add a `display_title` field to selected content types
- Choose which content types use display titles at the settings form
- Keep a descriptive admin/internal title for editorial workflows
- Present a cleaner, marketing-friendly title to the public
- Override the visitor-facing title without changing the stored admin title
- Preserve the real title on node edit and delete forms
- Keep admin listings showing the admin title for findability
- Grant `access display title field` to let a role edit display titles
- Grant per-bundle `access {bundle} display title field` for granular control
- Restrict display-title settings management via `manage display title field settings`
- Localise display titles per node (field supports langcode)
- Use display title in node view without extra template code
- Differentiate SEO/page title from internal reference title
- Roll out display titles to one content type at a time
- Hide the field from roles lacking the permission
- Combine with view modes that render the (swapped) node title
- Migrate long internal titles to concise public titles
- Audit which bundles have display titles enabled via config
- Uninstall cleanly to remove the added base field
