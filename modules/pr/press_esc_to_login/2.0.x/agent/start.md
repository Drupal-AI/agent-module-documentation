<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Press ESC to Login (press_esc_to_login) — agent index

**For anonymous visitors, pressing Escape navigates to the `/user` login page via a small attached script.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Package:** Administration
- **Mechanism:** `hook_page_attachments()` — only for anonymous users — attaches `press_esc_to_login/press_esc_to_login` and sets `drupalSettings.pressEscToLogin.loginPath = base_url + '/user'`.
- **JS:** `press_esc_to_login.js` navigates to `loginPath` on the Escape keydown.
- **Config:** none.

**Security:** Client-side navigation only — no change to authentication, permissions, sessions, or routing; it redirects to the standard core `/user` login form where users authenticate normally, so it does **not** weaken auth. Attached only for anonymous users (inert when logged in). Login path hardcoded to `/user`. No security findings.
