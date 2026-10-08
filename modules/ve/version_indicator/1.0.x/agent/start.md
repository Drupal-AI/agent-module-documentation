<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Version Indicator (version_indicator) — agent index

**Displays a configurable release-version badge in the core Navigation footer.**

- **Version:** 1.0.x (release 1.0.0)
- **Core:** ^11.1 || ^12  ·  **Depends:** `drupal:navigation`
- **Route:** `version_indicator.settings` → `/admin/config/system/version-indicator` (permission `administer version indicator`, `restrict access: true`)
- **Config:** `version_indicator.settings` (`version`, default `v0.0.0`)
- **Services:** `version_indicator.info` (VersionInfo — reads version + cache tags), `version_indicator.navigation_footer_manager` (adds/removes the block in `navigation.block_layout`)
- **Block:** `version_indicator_navigation_footer` (NavigationVersionBlock, renders `navigation:badge`); hidden from Block UI via `hook_block_alter`.

**Security:** Single admin config route, permission-gated with `restrict access: true`; no anonymous or mutating endpoints. The version string is admin-set free text rendered as a badge slot label.

See [configure/settings.md](configure/settings.md)
