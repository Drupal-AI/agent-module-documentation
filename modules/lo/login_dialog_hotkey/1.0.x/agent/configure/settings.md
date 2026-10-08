<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Login Dialog Hotkey

Route: `login_dialog_hotkey.settings` → `/admin/config/user-interface/login-dialog-hotkey`
Permission: `configure login dialog hotkey`
Config object: `login_dialog_hotkey.settings`

Settings (read in `login_dialog_hotkey_page_attachments()` and emitted as `drupalSettings.loginDialogHotkey`):
- `key` — the trigger key.
- `alt_key`, `ctrl_key`, `meta_key`, `shift_key` — required modifier flags.
- `dialog_type` — modal or off-canvas.
- `redirect_type`, `redirect_destination` — post-login redirect behaviour.
- `username.description` is not part of this module (see lowercase_username).

The front-end library `login_dialog_hotkey/login-dialog-hotkey` is attached **only when the current user is anonymous**; authenticated users never receive the handler. The config cache tags are attached so edits invalidate cached pages.

Drush/API: no custom Drush commands or public service. All behaviour is driven by config + the attached JS. To script configuration, set the keys above on `login_dialog_hotkey.settings` via `drush config:set` or a config import.