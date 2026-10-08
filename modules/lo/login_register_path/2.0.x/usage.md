<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Register Path changes the login and register page URL.

---

Login Register Path lets you change the URLs (paths) of the core login and register pages — so
`/user/login` and `/user/register` can be served at custom paths (e.g. `/signin`, `/join`), for branding or
mild obscurity. It is configured at `login_register_path.settings_form`.

Use it to customize login/register URLs. It is a routing/UX feature that changes where the login/register
forms live; the forms themselves still enforce Drupal's normal authentication/registration logic and access
(this is a **path change, not an auth change** — and changing the path is not a security control, since the
default paths may still work or be discoverable). It has no access-control role. Configure the custom
paths.

---

- Change the login/register page URLs.
- Serve login at a custom path.
- Serve register at a custom path.
- Configure at login_register_path.settings_form.
- Support branding.
- Change /user/login and /user/register.
- Keep the normal auth/registration logic.
- Know it's a path change, not an auth change.
- Not treat the path change as a security control.
- Have no access-control role.
- Configure the custom paths.
- Handle login paths.
- Customize URLs.
- Configure the paths.
- Change login URL.
- Handle the paths.
- Customize login/register.
- Configure register path.
- Change auth URLs.
- Set custom login path.
