# Configure per-region restrictions

1. Enable the **Per Layout Region** plugin (`entity_view_mode_restriction_by_region`) on the
   global admin page `/admin/config/content/layout-builder-restrictions` (permission:
   *configure layout builder restrictions*, from the parent module). Set its weight relative to
   the parent `entity_view_mode_restriction` plugin.
2. On each view mode's Layout Builder defaults ("Manage layout") form, the restrictions UI now
   exposes, **for every region of every allowed layout**, a whitelist/blacklist of blocks and
   block categories (`AllowedBlocksForm` + `js/display_mode_form.js`).
3. Save. Rules are stored as third-party settings and exported with the display config.

## Notes
- Provides config schema `layout_builder_restrictions_by_region.settings` (no admin settings
  form of its own beyond the per-view-mode UI).
- Implements the parent's `LayoutBuilderRestrictionInterface` — its plugin filters block
  definitions and validates block moves scoped to the destination region.
- **Enable it after** the parent "Per Entity View Mode" restriction and you must re-save each
  entity's layout restrictions for the region rules to take effect.
- A `RouteSubscriber` and `RestrictionPluginConfigAlter` wire it into the Layout Builder and
  parent-module forms.
