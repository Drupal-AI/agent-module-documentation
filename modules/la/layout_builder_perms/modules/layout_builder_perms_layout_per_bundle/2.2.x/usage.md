Adds section permissions scoped by both entity type + bundle and layout type, so section operations can be granted for a specific layout on a specific bundle (any entity type, not just nodes).

---

This submodule registers an `entity` `LayoutBuilderPermission` plugin (`EntityPermission`) whose
deriver (`EntityLayoutBuilderPermissions`) generates section-operation permissions for every
(entity type × bundle × layout × section-operation) combination among displays with
`layout_builder.allow_custom = TRUE`. Unlike the Node submodule (nodes only) it covers any
layout-override-enabled entity type. It covers the three section operations, splitting
`section_edit` into "add" (choose a layout for a new section) and "edit" (reconfigure existing)
via the section's `layout_builder_perms.action` third-party setting; `applies()` narrows to the
matching layout id, entity type, and bundle. Permission machine names follow
`{action} {layout_id} layouts on {bundle} {entity_type} entities` — e.g.
`add layout_onecol layouts on article node entities`. AND-combined by the parent's
`AccessManager`. Permissions appear on `/admin/people/permissions`; no config UI, no Drush.

---

- Allow adding a specific layout only on Article nodes.
- Grant section editing for two-column layouts on the User entity's overrides.
- Restrict a role to one layout type on one bundle for tightly-controlled pages.
- Permit section removal only on a chosen bundle-and-layout pairing.
- Scope layout permissions to non-node entities (e.g. media, taxonomy_term, user) too.
- Build a per-bundle, per-layout editorial matrix beyond what the Node submodule offers.
- Let a role add one-column sections on Landing Page but nothing else.
- Differentiate choosing a new section's layout from reconfiguring an existing one.
- Give designers all layouts on a marketing bundle while editors get one.
- Combine with block-per-layout permissions for full-stack scoping.
- Allow editing existing sections of a layout on a bundle without adding new ones.
- Restrict complex layouts to specific high-value bundles only.
- Enable overrides on a custom entity bundle and expose its scoped section permissions.
- Keep entity+bundle+layout permissions in exported role configuration.
- Prevent a role from placing a given layout on any bundle except the approved one.
- Delegate section management for a single content model precisely.
