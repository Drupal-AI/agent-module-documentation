Adds per-layout block permissions, so block add/config/remove/reorder can be granted separately for each layout type (e.g. allow adding blocks only inside two-column layouts).

---

This submodule registers a `layout` `LayoutBuilderPermission` plugin (`LayoutPermission`) whose
deriver (`LayoutLayoutBuilderPermissions`) generates one permission per (layout × block
operation) for every available core layout. It covers the four **block** operations
(`block_reorder`, `block_add`, `block_config`, `block_remove`); `applies()` narrows to requests
whose section layout id matches the plugin. Permission machine names follow
`{action} {component}s in {layout_id} layouts` — e.g. `add blocks in layout_twocol layouts`,
`remove blocks in layout_onecol layouts`. AND-combined by the parent's `AccessManager`, so
pairing with a global or per-bundle submodule requires all matching permissions. Permissions
appear on `/admin/people/permissions`; no config UI, no Drush.

---

- Allow adding blocks only inside two-column layouts.
- Forbid block removal in one-column layouts while allowing it elsewhere.
- Permit block configuration in a specific layout type only.
- Restrict block reordering to certain layouts.
- Let a role add and configure blocks in approved layouts but not remove them.
- Scope where a role may place blocks by layout structure.
- Prevent junior editors from adding blocks to complex multi-region layouts.
- Grant remove-block only inside a designated layout type.
- Separate block config from block removal per layout.
- Combine with block-type-per-layout permissions for finer control.
- Allow reorder-only block access within a given layout.
- Keep per-layout block permissions in exported role configuration.
- Roll out a new layout and gate which block operations it permits.
- Give designers full block operations in all layouts, editors only in basic ones.
- Restrict block additions in hero/landing layouts to marketing roles.
- Build a per-layout block-operation matrix across roles.
