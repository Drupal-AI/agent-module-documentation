Adds per-content-type Layout Builder permissions, so each of the seven layout operations can be granted separately for each node bundle that has layout overrides enabled.

---

This submodule registers a `content_type` `LayoutBuilderPermission` plugin (`NodePermission`)
whose deriver (`NodeLayoutBuilderPermissions`) generates one permission per (content type ×
operation) for every node bundle whose view display has `layout_builder.allow_custom = TRUE`.
The plugin's `applies()` narrows to requests where the context entity is a node of the matching
bundle, so the permission only affects layouts of that content type. Permission machine names
follow `{action} {component}s on {bundle} nodes` — e.g. `add blocks on article nodes`,
`remove sections on page nodes`, `reorder blocks on landing_page nodes`. Because the parent's
`AccessManager` AND-combines matching plugins, pairing this with the Global submodule requires
both permissions; using it alone gives per-bundle-only control. Permissions appear on
`/admin/people/permissions`; no config UI, no Drush.

---

- Let blog authors add and configure blocks only on Article layouts.
- Forbid section removal on the Landing Page content type while allowing it elsewhere.
- Grant Page editors full block operations but no section changes on Page nodes.
- Give each content team layout control over just their own content type.
- Allow reordering blocks on Article but not on News.
- Permit adding sections only on marketing content types.
- Configure a role that can tweak blocks on any of several selected content types.
- Withhold block removal from junior editors on high-traffic content types.
- Separate "structure" (sections) from "content" (blocks) permissions per content type.
- Enable layout overrides on a bundle and immediately expose its seven per-operation permissions.
- Build a per-content-type editorial matrix combined with the Layout Type submodule.
- Restrict a contributor role to configuring existing blocks on Blog nodes only.
- Grant add-section on Page nodes to a landing-page builder role.
- Keep per-bundle layout permissions in exported role config.
- Scope layout editing to content types a department owns without global layout access.
- Add remove-block on Article for a cleanup/moderation role.
