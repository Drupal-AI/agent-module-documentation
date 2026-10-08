<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup After Login

After a user logs in, JS calls a JSON endpoint that returns an admin-configured title/message, which is shown as a SweetAlert2 popup. Two variants are supported: a 'first login' popup (shown only once) and an 'always' popup (shown every login). Both are limited to roles the admin selects.

---

# Installing & configuring

- Enable the module (depends on the SweetAlert2 library module) and configure at `admin/config/popup_after_login` (permission `administer site configuration`).
- Select target roles and set the title + full-HTML message for the first-login and always-on popups.
- Leaving a title blank disables that popup.
- Config stored in `popup_after_login.settings`.

---

- `hook_user_login()` sets a per-username session flag (`first_*` or `always_*`).
- `hook_preprocess_page()` attaches the JS and the site base URL to `drupalSettings`.
- The JS fetches `/popup_after_login_get_results.json` (route permission `access content`).
- The controller returns the popup title/message only if the current user has one of the selected roles.
- The first-login popup unsets its session flag after returning (shown once).
- The always popup returns every login while its flag is set.
- If the user is not in a targeted role, the endpoint returns a `stop` marker and nothing shows.
- Popup content is entirely admin-configured (full_html) — no untrusted/user input is reflected.
- The JSON endpoint discloses only the admin-set message for the current session, keyed by the current user.
- There is no redirect logic, so no open-redirect vector.
- Role labels are HTML-escaped in the settings form.
- The full_html message is trusted admin content (self-XSS at most, requires `administer site configuration`).
- Session flags are namespaced by account name.
- Depends on the `sweetalert2` library module for rendering.
- Useful for T&C reminders, welcome notes, or role-specific announcements at login.
- Uninstall removes settings; no persistent user data is stored.
