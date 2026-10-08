<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Default Toolbar Menu

1. Enable `toolbar_menu` and create one or more Toolbar Menu entries.
2. Grant roles `access toolbar` and access to their target toolbar menu.
3. Go to `/admin/config/user-interface/toolbar_menu/setting` (permission `set default toolbar menu for roles`).
4. For each role, select the menu it should default to; save.
5. Users receive the menu on their **next login** (stored in `state` as `default_toolbar_menu:<uid>`).

Config is stored in `default_toolbar_menu.setting:default_menu` as a list of `{role, menu}` rows and can be exported with the site configuration.
