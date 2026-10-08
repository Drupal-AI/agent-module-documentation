<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable And Enable All Assign Block gives administrators a single form to switch every block assigned to a chosen theme region on or off at once, instead of toggling blocks one by one.
---
The module adds an admin section at `/admin/config/disable_enable_all_assign_block` and a settings form at `/admin/config/disable_enable_all_assign_block/deaab_settings_advanced` (route `disable_enable_all_assign_block.settings_advanced`), both gated by the `administer site configuration` permission. The form lists the default theme's regions as checkboxes (built from `block.repository` + `system_region_list`). On submit it reads all `block.block.*` config entries, keeps those belonging to the site's default theme, then **disables** every block whose region is checked and **enables** every block whose region is unchecked, saving each block entity.

This is an admin site-building convenience. There are no anonymous or web-service routes; all access requires the powerful `administer site configuration` permission. Implementation note: the submit handler reads block config rows directly from the `{config}` table and `unserialize()`s the stored data to determine each block's theme/region — trusted configuration data behind an admin-only route. Be aware the toggle is region-wide and applies to the default theme, so unchecking a region will re-enable all of its blocks.
---
- Disable every block in a region in one click.
- Re-enable every block in a region by unchecking it.
- Bulk-manage block status per region of the default theme.
- Quickly blank out a sidebar/footer during maintenance.
- Toggle header/footer block groups together.
- Avoid editing blocks individually on Block layout.
- Select multiple regions to disable at once.
- Restore regions by unchecking and saving.
- Keep the region selection persisted in config.
- Gate the operation behind `administer site configuration`.
- Prepare a stripped-down layout for a campaign page set.
- Reset visible blocks after a theme change.
- Operate only on the configured default theme's blocks.
- Review which regions are currently toggled off.
- Speed up region-wide block cleanup during a redesign.
- Persist region toggles as exportable configuration.