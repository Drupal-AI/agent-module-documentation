<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Dialog Hotkey opens the user login form in a modal or off-canvas dialog when an anonymous visitor presses a configurable key combination.
---
The module registers a settings form at `/admin/config/user-interface/login-dialog-hotkey` (permission `configure login dialog hotkey`) where you choose the trigger key plus modifier flags (alt/ctrl/meta/shift), the dialog type (modal or off-canvas), and a post-login redirect type and destination. Those settings are read in `login_dialog_hotkey_page_attachments()` and pushed to the front end as `drupalSettings.loginDialogHotkey`, but **only for anonymous users**, together with the `login_dialog_hotkey/login-dialog-hotkey` library that binds the key handler and opens the dialog.

Everything exposed to the browser is non-sensitive presentation config (key, modifiers, dialog type, redirect). The login itself still runs through Drupal's standard `user.login` form, so all normal authentication, flood control, and CSRF protections apply. A second route `/admin/login-dialog-hotkey/offcanvas-example` (permission `administer site configuration`) renders a demo off-canvas form for administrators. Typical setup: enable the module, open the settings form, pick a hotkey and dialog style, and save.
---
- Enable a keyboard shortcut that opens the login dialog for anonymous visitors.
- Configure the trigger key at `/admin/config/user-interface/login-dialog-hotkey`.
- Require Alt/Ctrl/Meta/Shift modifiers to avoid accidental triggering.
- Choose between a modal dialog and an off-canvas (side) dialog.
- Set where users land after a successful login (redirect type/destination).
- Preview the off-canvas style via the admin example route.
- Give power users a fast keyboard path to log in without visiting `/user/login`.
- Grant the `configure login dialog hotkey` permission to trusted editors.
- Keep the login experience on-page (dialog) instead of a full page load.
- Use the settings-page JS helper that displays the currently chosen key.
- Restrict the hotkey feature to anonymous sessions only (authenticated users are unaffected).
- Theme the dialog via standard Drupal dialog/off-canvas CSS.
- Combine with contrib login-security modules; core auth flow is unchanged.
- Change the hotkey later without code by editing config.
- Disable the module to remove the front-end key handler entirely.