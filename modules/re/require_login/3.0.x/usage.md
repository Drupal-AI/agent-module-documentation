<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Require Login forces user authentication across a Drupal site: any anonymous visitor is redirected to the login page, turning the whole site (or a subset of paths) into a private, login-gated experience.

---

The module registers an event subscriber (`LoginEventSubscriber`) on `KernelEvents::REQUEST` (priority 31) and `KernelEvents::EXCEPTION`. For every main (non-sub) request by an **anonymous** user it asks the `require_login.requirements_manager` service to `evaluate()`, and on a positive result issues a `TrustedRedirectResponse` to the login path with a `destination` query so the user returns to where they were. Out of the box **all pages require login** — the default `require_login.settings` config carries a single `request_path` condition with empty `pages`, which evaluates TRUE everywhere. You narrow the requirement with core **condition plugins** (Request Path, and other context-aware conditions the form exposes) combined with AND: all configured conditions must pass (or be neutral) for login to be enforced. A small allow-list of `PROTECTED_ROUTES` (user login/register/password-reset, and CSS/JS/image-style asset routes) is always reachable so users can actually log in. Settings live at `/admin/config/people/login-requirements` (route `require_login.settings`, permission `administer require login`): `login_path` (defaults to `/user/login`), `login_message` (a warning shown after redirect), `login_destination` (fixed post-login target, else the current URL), and `extra.include_403` / `extra.include_404` (also gate the access-denied and not-found pages). A `hook_require_login_evaluation_alter(&$eval)` hook lets code override the final decision per request.

---

- Make an entire staging or pre-launch site private behind login.
- Build a members-only site where anonymous users can only see the login page.
- Gate an intranet/extranet so all content requires authentication.
- Redirect anonymous visitors to a custom login path instead of `/user/login`.
- Show a "Please sign in" message when redirecting unauthenticated users.
- Send users to a fixed landing page (e.g. `/dashboard`) after they log in.
- Require login only on paths under `/members` using the Request Path condition.
- Require login everywhere except a few public pages (Request Path with negate).
- Also force login on the 403 access-denied page (recommended, `include_403`).
- Also force login on the 404 not-found page (recommended, `include_404`).
- Lock down a client demo site without configuring per-node access.
- Prevent anonymous crawling/indexing by requiring authentication site-wide.
- Combine multiple conditions so login is required only in a specific context.
- Keep asset and login routes reachable so the login flow still works.
- Override the enforcement decision in code via `hook_require_login_evaluation_alter()`.
- Provide a simple alternative to complex permission/role setups for "logged-in only" sites.
- Preserve the originally requested URL as the post-login destination.
- Restrict a subsection of a mostly-public site to authenticated users.
- Set up a temporary "coming soon, log in to preview" gate.
- Ensure editors must authenticate before reaching any admin or content page.
- Export the whole configuration for repeatable deployment across environments.
- Route anonymous users of a decoupled/preview site to a login screen.
