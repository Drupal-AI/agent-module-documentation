<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Restrictions By Role is a plugin for the Layout Builder Restrictions module that limits which blocks a role may place and which layouts a role may use in Layout Builder — globally by default, or overridden per entity view mode.

---

The module registers a `LayoutBuilderRestriction` plugin (`id: restriction_by_role`) named "Per Role". Its `RestrictionByRole` class implements the restriction hooks Layout Builder calls while a user edits a layout: `alterBlockDefinitions()` (which blocks appear in the "Add block" list), `alterSectionDefinitions()` (which layouts are offered), `blockAllowedinContext()` (whether a block may be moved into a section), and `inlineBlocksAllowedinContext()`. Restrictions are stored two ways: **site-wide defaults** in the config object `layout_builder_restrictions_by_role.settings`, and **per-view-mode** overrides saved as third-party settings (`entity_view_mode_restriction_per_role`) on the `entity_view_display` config entity, edited through a form-alter on the Manage Display screen. A view mode uses the global defaults unless its `override_defaults` flag is set. Each restriction is expressed per role + block category as a `restriction_type` of `all` (unrestricted), `whitelisted`, or `blacklisted`, with an optional layout-specific layer (`__layouts`) and a global block layer (`__blocks`); layouts allowed per role live under `allowed_layouts`. Evaluation is **most-permissive-wins across the user's roles**: `isBlockAllowed()` returns true if *any* of the current user's (non-locked) roles allows the block, mirroring how Drupal grants access. All of this only refines what a user who already has core Layout Builder editing rights (`configure any layout`, `restrict access: true`) may do; the admin config forms are gated by the parent module's `configure layout builder restrictions` permission (also `restrict access: true`). The plugin must be enabled under Layout Builder Restrictions' plugin config for the Manage Display UI and enforcement to appear.

---

- Let only editors (not authors) place certain blocks in Layout Builder.
- Restrict which core/system blocks a role can add to a layout.
- Whitelist a specific set of blocks for a role, hiding everything else.
- Blacklist a few dangerous/irrelevant blocks for a role while allowing the rest.
- Limit which layout plugins (one-column, two-column, etc.) a role may choose.
- Restrict custom block types a role may place separately from core blocks.
- Restrict inline (Layout Builder inline) blocks per role.
- Apply one set of restrictions globally across all Layout Builder-enabled displays.
- Override the global defaults for a single entity view mode (e.g. a special landing bundle).
- Allow a block only within a specific layout for a given role (layout-specific whitelist).
- Deny a block within a specific layout for a role (layout-specific blacklist).
- Give higher-trust roles more blocks/layouts while restricting lower-trust editors.
- Keep marketing editors limited to approved marketing blocks in Layout Builder.
- Prevent a role from using experimental or deprecated layouts.
- Combine several roles on one user so the least-restrictive role's allowances apply.
- Centralise per-role block/layout governance as configuration (exportable).
- Constrain block choices per bundle+view-mode to enforce a design system.
- Reduce clutter in the Add Block list by hiding blocks a role never needs.
