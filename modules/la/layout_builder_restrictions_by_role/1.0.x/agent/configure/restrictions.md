<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-role Layout Builder restrictions

## Enable the plugin

This is a plugin for `layout_builder_restrictions`. Enable the **Per Role** restriction
(`restriction_by_role`) under Structure → Layout Builder Restrictions
(`layout_builder_restrictions.restriction_plugin_config_form`), stored in
`layout_builder_restrictions.plugins` → `plugin_config[restriction_by_role][enabled]`. The
per-view-mode UI is only added (`_form_entity_view_display_edit_form_alter`) when that flag is not
`FALSE`.

## Two places restrictions live

1. **Global defaults** — config object `layout_builder_restrictions_by_role.settings`.
2. **Per view mode** — third-party settings key `entity_view_mode_restriction_per_role` under the
   `layout_builder_restrictions` namespace on each `entity_view_display` config entity. A view mode
   falls back to the global defaults **unless** its settings contain a truthy `override_defaults`.

Both use the identical structure (schema
`layout_builder_restrictions.entity_view_mode_restriction_per_role` and
`layout_builder_restrictions_by_role.settings`):

| Key | Meaning |
|---|---|
| `layout_restriction` | `all` = no layout-specific restrictions; otherwise layout-specific rules apply. |
| `allowed_layouts` | `[layout_id][role] = role` — which roles may use which layout. |
| `__blocks` | Global block rules: `[role][category] = { restriction_type, restrictions[block_id] }`. |
| `__layouts` | Layout-specific block rules: `[layout_id][role][category] = { restriction_type, restrictions[block_id] }`. |
| `override_defaults` | (per-view-mode only) when truthy, use this display's own settings instead of the global defaults. |

`restriction_type` is one of `all` (unrestricted), `whitelisted` (only listed blocks allowed), or
`blacklisted` (listed blocks denied). Custom content blocks get special handling: with no "Custom
blocks" rule the plugin matches on the block **type** ("Custom block types") resolved from the
block's UUID; with a "Custom blocks" rule set it matches the whole category.

## Admin forms / routes (all require `configure layout builder restrictions`, `restrict access: true`)

| Route | Path | Edits |
|---|---|---|
| `…by_role.default_layouts` | `/admin/config/content/layout-builder-restrictions/by-role` | Global allowed layouts (`DefaultAllowedLayoutsForm`; extra `accessCheck` also requires the plugin enabled). |
| `…by_role.default_allowed_blocks` | `/admin/layout-builder-restrictions/…/default-allowed-blocks-form` | Global block rules (AJAX subform). |
| `…by_role.default_layout_allowed_blocks` | `/admin/layout-builder-restrictions/…/default-layout-allowed-blocks-form` | Global layout-specific block rules. |
| `…by_role.allowed_blocks` / `…by_role.layout_allowed_blocks` | `/admin/layout-builder-restrictions/…/allowed-blocks-form` etc. | Per-view-mode block / layout-block subforms (rendered into the Manage Display edit form). |

## Evaluation semantics (grounding — `src/Plugin/LayoutBuilderRestriction/RestrictionByRole.php`)

- `isBlockAllowed()` iterates `currentUser->getRoles(TRUE)` and returns **true if ANY role allows
  the block** (`array_filter` of per-role results, most-permissive-wins). `getRoles(TRUE)` excludes
  the locked `anonymous`/`authenticated` roles, so rules must be attached to real named roles.
- `alterSectionDefinitions()` removes a layout when no current role permits it (empty
  `allowed_layouts[layout_id][role]`) and `layout_restriction !== 'all'`.
- Per-role block check order: global `__blocks` rule for the category → if a whitelist/blacklist
  would deny, `checkLayoutSpecificOverrideBeforeDenying()` can still allow it via a layout-specific
  whitelist → then the layout-specific `__layouts` rule.
- When a display/config has **no** restriction data, the hooks return the definitions unchanged (no
  restriction).

## Note (by design)

If restriction data is missing/empty the plugin returns everything unrestricted (fail-open), and
"most-permissive role wins" means adding a permissive role widens access. Both are by design and only
affect users who already hold core Layout Builder editing rights (`configure any layout` /
`configure editable layouts`, `restrict access: true`) — i.e. trusted layout editors. This is a
usability/refinement layer, not an access boundary for untrusted users.
