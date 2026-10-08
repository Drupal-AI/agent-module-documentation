Layout Builder Advanced Permissions replaces core Layout Builder's coarse "configure any layout / configure all layouts" gate with fine-grained, pluggable permissions so you can grant specific layout actions (add/configure/remove/reorder blocks; add/edit/remove sections) scoped by global action, content type, entity bundle, layout, layout type, or inline block type.

---

The base module ships one permission — `access layout builder page` — and a pluggable
`LayoutBuilderPermission` plugin type (manager `plugin.manager.layout_builder_perms`, plugins in
`Plugin/LayoutBuilderPermission`). Enable one or more of its six submodules to expose granular
permissions; the base module alone defines no per-operation restrictions. It works by (1)
subscribing to route alter (`RouteSubscriber`) to add a `_layout_builder_perms_access`
requirement, mapping each core Layout Builder route to one of seven operations (`block_add`,
`block_config`, `block_remove`, `block_reorder`, `section_add`, `section_edit`,
`section_remove`); (2) an `AdvancedAccessCheck` that delegates those operations to `AccessManager`,
which loads the permission plugins whose context filters (operation/layout/entity type/bundle/
block type) match and AND-combines their results; and (3) overriding the `overrides` section
storage plugin (`OverridesSectionStorage`) so per-entity layout access is granted by
`access layout builder page` OR a per-bundle "configure own editable …" permission instead of
core's `configure any layout`. It also filters the Layout Builder UI (`LayoutBuilderElement::preRender`)
to strip add/edit/remove/move links and reorder handles the user cannot use. Granular permissions
appear on `/admin/people/permissions` once the relevant submodule is enabled. Dynamic per-bundle
"configure own editable {bundle} {type} layout overrides" permissions are generated for every
layout-override-enabled display. `AccessManager` defaults to *allowed* for any operation no plugin
matches. There are no config forms and no Drush commands — everything is driven
by role permissions.

---

- Let editors add and configure blocks in a node layout but forbid removing or reordering them.
- Allow section changes only on specific content types (Article yes, Landing page no).
- Grant "add block" per content type so blog authors can only edit blog layouts.
- Restrict which core layouts (one-column, two-column, etc.) a role may place as sections.
- Permit a role to configure existing sections but never add or remove sections.
- Let a role place only certain inline block types (e.g. "Callout") inside a given layout.
- Give a role `access layout builder page` to reach the layout UI without core `configure any layout`.
- Scope override editing to content the user owns via "configure own editable … layout overrides".
- Hide unusable add/edit/remove links and drag handles from the Layout Builder toolbar per role.
- Prevent block reordering while still allowing block configuration.
- Delegate landing-page building to a marketing role without exposing site-wide layout admin.
- Allow adding sections of a specific layout type only (e.g. only "Two column" layouts).
- Differentiate "choose a layout for a new section" from "configure an existing section" permission.
- Combine per-bundle and per-layout permissions to build a precise editorial matrix.
- Add your own `LayoutBuilderPermission` plugin to gate a bespoke operation/context.
- Let a role remove blocks but not sections (or vice-versa).
- Give trusted layout builders global block/section permissions via the Global submodule.
- Enforce that only owners can override their profile/user-entity layouts.
- Keep layout permissions in code by assigning them to roles in config.
- Restrict inline-block creation of a given type to a given layout for brand-safety.
- Provide graduated Layout Builder access across many roles on a large editorial team.
- Reduce reliance on the powerful core `administer …`/`configure any layout` permission.
- Audit exactly which layout operations each role can perform from the permissions page.
- Let contributors edit their own page layouts while admins manage default (template) layouts.
