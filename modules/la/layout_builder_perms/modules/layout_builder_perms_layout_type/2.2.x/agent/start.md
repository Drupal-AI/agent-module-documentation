# layout_builder_perms_layout_type — agent index

Submodule of [layout_builder_perms](../../../../2.2.x/agent/start.md). Adds **per-layout-type**
section permissions (section_add/edit/remove, per core layout plugin id). No config UI, no Drush.

- Plugin: `LayoutTypePermission` (id `layout_type`, contexts `layout` + `operation`) via deriver
  `LayoutTypePermissions`. `applies()` requires the section's layout id to match; a second
  `section_edit` derivative separates the "add" (choose layout) vs "edit" (reconfigure) case via
  the `layout_builder_perms.action` third-party setting on the section.
- Permission pattern: `{action} layouts of type {layout_id}` (e.g. `add layouts of type layout_onecol`).
- Scope is section operations only (not block operations). AND-combined by the parent
  `AccessManager`. See parent [permissions](../../../../2.2.x/agent/permissions/permissions.md) /
  [access model](../../../../2.2.x/agent/extend/access-model.md).
