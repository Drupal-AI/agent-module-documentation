<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Toolbar Menu (default_toolbar_menu) — agent index

**Assigns a default Toolbar Menu to each user role and applies it on login.**

- **Version:** 3.0.x
- **Core:** ^10 || ^11
- **Requires:** toolbar_menu (contrib)
- **Config route:** `default_toolbar_menu.default_admin_menu_setting_form` → `/admin/config/user-interface/toolbar_menu/setting`
- **Config object:** `default_toolbar_menu.setting` (`default_menu` array of role→menu maps)
- **Permission:** `set default toolbar menu for roles`
- **Library:** `default_toolbar_menu/default_toolbar_menu` (JS, jQuery/drupal)
- **Mechanism:** `hook_user_login` writes chosen menu to `state` key `default_toolbar_menu:<uid>`; `hook_page_attachments` attaches JS for authenticated users with `access toolbar`.

**Security:** Admin config route permission-gated (`set default toolbar menu for roles`); no anonymous or mutating endpoints; only affects toolbar UI. Selection applied at login only.

See [configure/settings.md](configure/settings.md)