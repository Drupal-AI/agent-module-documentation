Adds the most granular block permissions: block operations scoped by both inline block content type and layout type, so you can allow (say) only "Callout" inline blocks inside two-column layouts.

---

This submodule registers an `inline_block_type_in_layout` `LayoutBuilderPermission` plugin
(`InlineBlockTypeInLayoutPermission`) whose deriver (`InlineBlockTypeInLayoutPermissions`)
generates one permission per (layout × block_content type × block operation). It covers the four
block operations and narrows via `applies()` to requests where both the section layout id and the
inline **block content bundle** match the plugin (using the `block` and `layout` contexts).
Permission machine names follow `{action} {block_type} {component}s in {layout_id} layouts` —
e.g. `add basic blocks in layout_twocol layouts`. This is the finest scope the project offers and
AND-combines with any other matching submodule permission through the parent's `AccessManager`.
Permissions appear on `/admin/people/permissions`; no config UI, no Drush. (The `block` context on
`add_block` is supplied by the parent's `ContentBlockTypePluginContext` event subscriber.)

---

- Allow adding only "Callout" inline blocks inside two-column layouts.
- Forbid a specific inline block type in a specific layout for brand safety.
- Permit configuring "Basic" inline blocks but not "Hero" ones in a given layout.
- Restrict block removal to certain block types within certain layouts.
- Scope inline block creation by both content type and layout structure.
- Let marketing add promo blocks in hero layouts only.
- Prevent editors from placing rich media blocks in narrow layouts.
- Grant reorder for a block type inside one layout type only.
- Combine block-type and layout scoping for tightly-curated pages.
- Allow "Quote" blocks in one-column layouts but nowhere else.
- Keep the finest-grained block permissions in exported role config.
- Roll out a new inline block type and gate exactly where it may be used.
- Give designers all block types in all layouts, editors a curated subset.
- Restrict a role to configuring existing blocks of one type in one layout.
- Enforce editorial standards on which block types appear in which layouts.
- Build a block-type × layout permission matrix across roles.
