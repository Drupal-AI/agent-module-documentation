<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Dialog Hotkey (login_dialog_hotkey) — agent index

**Opens the login form in a modal/off-canvas dialog for anonymous users on a configurable hotkey.**

- **Version:** 1.0.x (1.0.0-rc1)
- **Core:** ^10 || ^11
- **Configure:** `login_dialog_hotkey.settings` → `/admin/config/user-interface/login-dialog-hotkey` (perm `configure login dialog hotkey`).
- **Routes:** settings form (above); `/admin/login-dialog-hotkey/offcanvas-example` (perm `administer site configuration`) — demo only.
- **Key hook:** `login_dialog_hotkey_page_attachments()` attaches the library + `drupalSettings.loginDialogHotkey` **only for anonymous users**.
- **Permissions:** `configure login dialog hotkey`.
- **Security:** settings route permission-gated; only non-sensitive presentation config (key, modifiers, dialog type, redirect) is exposed to the client. Login runs through core `user.login`, so core auth/flood/CSRF still apply. No mutating anonymous endpoints.

See [configure/settings.md](configure/settings.md).