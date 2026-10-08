<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Version Indicator

## Set the version
Route `version_indicator.settings` → `/admin/config/system/version-indicator`
(`VersionIndicatorSettingsForm`, `ConfigFormBase`), permission
`administer version indicator` (restricted). One required textfield **Release
version** (maxlength 128) saved to config `version_indicator.settings:version`
(install default `v0.0.0`).

## Where it shows
The value renders as a badge in the **Navigation** module footer. On module
install, `NavigationFooterManager::addVersionBlock()` injects the block
`version_indicator_navigation_footer` into `navigation.block_layout` section 0,
footer region (skipped if `navigation` is absent or the block is already
present). Uninstall calls `removeVersionBlock()` to strip it out.

`NavigationVersionBlock::build()` outputs a `#component` `navigation:badge`
with `status: info` and the version as the label slot, tagged with
`config:version_indicator.settings` so the badge cache-clears when the version
changes. `hook_block_alter` sets `allow_in_navigation` and `_block_ui_hidden`,
so the block is managed through the Navigation layout rather than the standard
Block UI.
