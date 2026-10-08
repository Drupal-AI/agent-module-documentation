<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y AddThis — agent index

Configurable block that renders AddThis social-sharing icons for the current page. Part of
the Open Y (YMCA) distribution; works standalone. No dependencies, no permissions of its own,
no Drush commands.

Quick facts:
- Settings form: `/admin/openy/settings/openy-addthis` (route `openy_addthis.settings`, perm `administer site configuration`).
- Config object: `openy_addthis.settings`.
- Block: "Open Y AddThis Block" — place via Block Layout.
- Uninstall: guarded by `AddThisUninstallValidator`; use `/admin/modules/uninstall/openy-addthis` (perm `administer modules`) to clean up block instances first.
- Note: relies on the external AddThis widget, which has been discontinued by its vendor.
