<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: adds auto-unblock behavior on top of Login Security so temporarily blocked accounts are re-enabled automatically.
- When: Login Security blocks users after failed attempts and you want them freed after a time window without admin action.

---

- Enable the module; it depends on and extends the `login_security` module.
- Configure the options on the Login Security settings form (`login_security.settings`) — this module adds fields there.

---

- `hook_form_alter()` injects `auu_user`, `auu_message_opt`, and `auu_message` options into `login_destination_settings`/Login Security settings.
- `auu_user` toggles automatic unblocking of users blocked by Login Security.
- `auu_message_opt` toggles whether a message is shown to the unblocked user.
- `auu_message` holds the message text displayed on unblock.
- Settings persist in the `auu.settings` config object.
- Unblocking triggers once the configured Login Security block window has elapsed.
- Use it to reduce admin overhead from manually unblocking locked-out users.
- No custom routes or permissions are added; it rides Login Security's admin UI.
- The `#states` logic hides the message fields when auto-unblock is off.
- Depends entirely on Login Security being installed and configured.
- Blocked accounts are re-enabled programmatically rather than by an admin.
- Keep Login Security's thresholds sensible so accounts aren't unblocked too eagerly.
- Message display is optional and configurable.
- Test by triggering a temporary block and waiting for the window to expire.
- Suitable for sites wanting brute-force protection without permanent lockouts.
- Version 1.1.x supports Drupal 8/9/10.
