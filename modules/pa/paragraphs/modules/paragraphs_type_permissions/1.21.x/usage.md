Paragraphs Type Permissions (a submodule of Paragraphs) generates per-paragraph-type view/create/edit/delete permissions so you can control exactly which roles may use each Paragraphs type.

---

By default any user who can edit a host entity's paragraphs field may add or edit any allowed paragraph type. This submodule adds four dynamically generated permissions for **each** Paragraphs type — view, create, edit, and delete content of that type — plus a global "bypass" permission for administrators. The permissions are produced by `ParagraphsTypePermissions` (registered via `permission_callbacks` in `paragraphs_type_permissions.permissions.yml`), so new permissions appear automatically whenever you add a Paragraphs type. This lets you, for example, let a junior editor role use only "text" and "image" paragraphs while reserving a "raw HTML" or "webform" paragraph for trusted roles. It has no configuration form or config schema — you assign the generated permissions on the normal People → Permissions page. It depends only on the main Paragraphs module.

---

- Allow a role to create "text" paragraphs but not "embed code" paragraphs.
- Restrict a powerful "raw HTML" paragraph type to administrators only.
- Let contributors edit but not delete a given paragraph type's content.
- Hide sensitive paragraph types from lower-trust editor roles.
- Grant view-only access to a paragraph type for certain roles.
- Reserve a "webform" or "block" paragraph for site builders.
- Give a marketing role create rights on promo/CTA paragraph types only.
- Enforce editorial governance over which components each team can use.
- Bypass all per-type checks for admins via the global bypass permission.
- Automatically expose permissions for every newly added paragraph type.
- Separate create vs. edit vs. delete rights per paragraph type.
- Limit translators to viewing rather than structurally changing paragraphs.
- Build a tiered content model where advanced components require elevated roles.
- Prevent accidental use of deprecated paragraph types by revoking create rights.
- Align paragraph-type access with an existing role hierarchy.
- Audit which roles can manage which structured components.
