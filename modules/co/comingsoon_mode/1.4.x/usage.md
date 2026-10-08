<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coming Soon Mode provides an easy setup for a coming-soon landing page for anonymous users.

---

Coming Soon Mode provides an easy **"coming soon" landing page** — while enabled, visitors are redirected
to a configurable landing page (ideal for a pre-launch site), with the login/password-reset routes (and
optionally registration) and static assets still reachable. It uses a request event-subscriber to redirect,
gated by the `access website in comingsoon mode` permission, provides its own permissions, in the maintenance
package.

Use it to show a pre-launch page while letting privileged users in. **Important:** it is a **soft redirect
gate, not a security boundary.** It redirects requests for users who are anonymous or lack the permission —
users **with** `access website in comingsoon mode` (and logged-in users per config) see the real site — but
because it works by redirecting page requests, do **not** rely on it to protect genuinely sensitive content
(use real access control / an access-restricted environment for that). Its allow-list intentionally passes
static files and the auth routes. Configure the landing page and who may bypass it.

---

- Redirect visitors to a coming-soon page.
- Serve a pre-launch landing page.
- Let privileged users see the real site.
- Keep login/reset (and optional register) reachable.
- Gate by access website in comingsoon mode.
- Use a request event-subscriber.
- TREAT it as a soft gate, not a security boundary.
- Not rely on it for sensitive content.
- Use real access control where needed.
- Pass static files and auth routes.
- Provide its own permissions.
- Configure the landing page/bypass.
- Handle coming-soon mode.
- Show a landing page.
- Configure the gate.
- Redirect anonymous users.
- Handle the redirect.
- Gate the site.
- Configure comingsoon.
- Provide a pre-launch page.
