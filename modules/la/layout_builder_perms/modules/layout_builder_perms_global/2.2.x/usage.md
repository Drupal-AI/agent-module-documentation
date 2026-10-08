Adds seven global Layout Builder permissions — one per operation (add/edit/remove sections; add/config/remove/reorder blocks) — that apply everywhere, regardless of content type or layout.

---

This submodule of Layout Builder Advanced Permissions registers a single `global`
`LayoutBuilderPermission` plugin (`GlobalPermission`) whose deriver
(`GlobalLayoutBuilderPermissions`) emits one permission per operation in
`AccessManagerInterface::LAYOUT_BUILDER_OPERATIONS`. The plugin applies to every request for its
operation (it only checks the `operation` context, no layout/entity scoping), so these are the
coarse "can this role do X anywhere" gates. Because the parent's `AccessManager` AND-combines all
matching plugins, enabling this alongside a scoped submodule means a user needs both the global
permission and the scoped one. It is the submodule auto-enabled on update from 1.x for backward
compatibility. Permissions appear on `/admin/people/permissions` once enabled; no config UI.

The seven permissions (machine name → operation): `create layout builder sections` (section_add),
`edit layout builder sections` (section_edit), `remove layout builder sections` (section_remove),
`create layout builder blocks` (block_add), `config layout builder blocks` (block_config),
`remove layout builder blocks` (block_remove), `reorder layout builder blocks` (block_reorder).

---

- Grant a role the ability to add sections anywhere Layout Builder is used.
- Grant editing of existing sections site-wide without add/remove.
- Allow removing sections globally for a trusted layout admin.
- Let a role add blocks in any layout regardless of content type.
- Permit block configuration everywhere while withholding block removal.
- Allow removing blocks globally.
- Allow reordering blocks globally while forbidding structural section changes.
- Build a "layout viewer + block tweaker" role (config blocks only).
- Provide a near-equivalent of core `configure any layout` split into seven toggles.
- Combine with per-content-type permissions so global perms set the floor and node perms scope it.
- Keep backward compatibility with layout_builder_perms 1.x behavior (auto-enabled on update).
- Give a role add + config + reorder blocks but never remove.
- Separate section management from block management across two roles.
- Assign each of the seven operations to a different role for fine editorial separation.
- Export the seven permissions to roles in configuration for repeatable deployments.
- Reduce use of the powerful core `configure any layout` permission by substituting granular globals.
