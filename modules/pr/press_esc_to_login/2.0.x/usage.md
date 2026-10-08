<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Press ESC to Login is a convenience module: for anonymous visitors it adds a tiny JavaScript key handler so pressing the Escape key from any page sends the browser to the login page.

---

`hook_page_attachments()` checks whether the current user is anonymous; only then does it attach the library and set `drupalSettings.pressEscToLogin.loginPath` to `<base_url>/user`. The bundled `press_esc_to_login.js` listens for keydown and, on the Escape key, navigates `window.location.href` to that path. Nothing is attached for authenticated users, so the shortcut is inert once logged in.

This is purely a client-side navigation helper — it does not change authentication, permissions, sessions, or routing. It simply redirects to the standard `/user` login form (users still authenticate normally there), so it does not weaken auth in any way. The login path is hardcoded to `/user`, so it will not follow a customized login URL. Setup is just enabling the module; there is no configuration.
---
- Let anonymous users jump to the login page with the Escape key
- Provide a fast keyboard route to /user on any page
- Avoid typing the login URL manually during development
- Speed up logging into admin on staging sites
- Works on multisite (uses the site's base URL + /user)
- Disable the shortcut automatically for logged-in users
- Enable a lightweight editor/admin convenience with no config
- Attach the handler only for anonymous sessions
- Pair with a hidden or unlinked login page
- Use during QA to reach the login form quickly
- Give content teams a quick keyboard path back to login
- Attach the tiny script only on anonymous page requests
- Add an admin convenience shortcut across the whole site
- Keep the shortcut inert once a user has authenticated
- Reach /user from deep pages without editing the URL bar
- Deploy with zero configuration or permissions
