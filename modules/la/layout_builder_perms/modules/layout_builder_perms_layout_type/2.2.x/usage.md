Adds per-layout-type section permissions, so section add/edit/remove can be granted separately for each core layout plugin (one-column, two-column, etc.).

---

This submodule registers a `layout_type` `LayoutBuilderPermission` plugin (`LayoutTypePermission`)
whose deriver (`LayoutTypePermissions`) generates section-operation permissions per available
layout id. It covers the three **section** operations (`section_add`, `section_edit`,
`section_remove`), with an extra derivative for `section_edit` split into the "add" case
(choosing a layout for a new section) versus the "edit" case (reconfiguring an existing section),
distinguished by the layout's `layout_builder_perms.action` third-party setting. `applies()`
narrows to requests whose layout id matches. Permission machine names follow
`{action} layouts of type {layout_id}` — e.g. `add layouts of type layout_onecol`,
`remove layouts of type layout_twocol`. Combined with AND semantics by the parent's
`AccessManager`. Permissions appear on `/admin/people/permissions`; no config UI, no Drush.

---

- Allow a role to add only one-column sections.
- Forbid two-column layouts for a role while allowing single-column.
- Permit editing existing sections of a given layout type without adding new ones.
- Restrict which layout templates junior editors may place as sections.
- Grant remove-section only for a specific layout type.
- Separate "choose a layout for a new section" from "reconfigure an existing section" permission.
- Let brand-safe roles use only approved layout types.
- Prevent use of complex multi-column layouts by less-trusted roles.
- Allow a role to add and edit but never remove sections of a layout type.
- Build a curated set of allowed layouts per role.
- Combine with the per-bundle Layout submodule for layout-and-bundle scoping.
- Give designers all layout types while limiting editors to basic ones.
- Restrict a role to editing existing sections of any type but adding none.
- Keep layout-type permissions in exported role configuration.
- Roll out a new custom layout and gate who may place it.
- Limit section removal to layout admins for structural stability.
