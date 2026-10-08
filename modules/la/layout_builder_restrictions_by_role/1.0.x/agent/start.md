<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Restrictions By Role — agent index

A `LayoutBuilderRestriction` plugin (`id: restriction_by_role`) for the Layout Builder Restrictions
module that limits blocks/layouts per user role — globally by default and per view mode via override.
Depends on `layout_builder_restrictions`. Provides config schema; no permissions or Drush of its own
(config forms use the parent's `configure layout builder restrictions` permission).

- **Enabling the plugin, config object + all keys, defaults vs per-view-mode override, the
  whitelist/blacklist model, evaluation semantics, routes/forms** →
  [configure/restrictions.md](configure/restrictions.md)

Key facts:
- Plugin `RestrictionByRole` implements `alterBlockDefinitions`, `alterSectionDefinitions`,
  `blockAllowedinContext`, `inlineBlocksAllowedinContext`.
- Global defaults config: `layout_builder_restrictions_by_role.settings`. Per-view-mode overrides:
  third-party settings `entity_view_mode_restriction_per_role` on `entity_view_display` (used only
  when its `override_defaults` is truthy).
- Evaluation is **most-permissive-wins**: a block/layout is allowed if ANY of the current user's
  roles allows it (`isBlockAllowed`), and roles are read with `getRoles(TRUE)` (locked
  anonymous/authenticated roles excluded).
- Only refines already-privileged Layout Builder editors; see [configure/restrictions.md](configure/restrictions.md)
  for the by-design default-allow note.
