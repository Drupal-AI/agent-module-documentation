<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role login page lets an administrator build several standalone login pages, each at its own URL, each restricted to a chosen set of roles, and each sending its users to its own destination after a successful sign-in.

---

Core gives a site one login form at `/user/login` and one destination rule. Role login page turns that into as many login pages as you want to define. From `admin/config/login/role_login_settings` an administrator adds a page by giving it a **URL path** (e.g. `staff-login`), a set of **allowed roles**, custom **field labels** (username, password, submit button), a **page title**, a **form CSS class**, two custom **error messages**, and a **redirect path**. Each saved page becomes a live route rendered by a bespoke `FormBase` (`RoleLoginForm`), reachable **only by anonymous users** (`_user_is_logged_in: 'FALSE'`); definitions live in a custom database table (`role_login_page_settings`), not in configuration, and the routes are rebuilt from that table by a `route_callbacks` provider (`RoleLoginRoutes::routes()`) on every cache clear. When someone submits one of these forms, the module authenticates the credentials with core's `user.auth` service, then checks whether the authenticated account holds **at least one** of that page's allowed roles: on a role mismatch it shows the page's role-mismatch error and does **not** log the user in; on a match it calls `user_login_finalize()` and redirects to the page's configured path (or `/` when none is set). Version **2.0.3**, core `^8` through `^11`, behind the single permission `administer role login settings`. Two things are worth being precise about, because login is where a small mistake is a large one. **A distinct login page is presentation, not separation:** every one of these forms authenticates against the same user table, so the credentials that work at one page work at any page whose role set the account matches — the page controls *where* a user lands and *which roles* may enter, not *which passwords are valid*. If the requirement is that certain accounts must not authenticate at a public entrance at all, that is `disable_login_by_domain`, an IP restriction, or a genuinely separate site. And **the redirect is administrator-configured and validated as an internal route** (`path.validator`/`getUrlIfValid()` with a real route name on save), and the submit handler explicitly overwrites the request's `destination` — so, unlike core's `?destination=` handling, the landing page here cannot be steered by a request parameter into an external target.

---

- Give staff their own branded login page at `/staff-login` and land them on the editorial dashboard.
- Give members a separate login page that only member-role accounts can use.
- Build a supplier or partner portal login that looks like the portal, not like Drupal's `/user/login`.
- Restrict a login page to a single role so accounts without it are refused with a custom message.
- Send each audience to a different post-login destination from one module instead of a custom `hook_user_login()`.
- Relabel the username field to "Employee ID" (or any label) on a specific login page.
- Relabel the password and submit-button text per login page.
- Set a custom "you do not have permission to log in here" message per page.
- Set a custom "invalid credentials" message per page.
- Add a CSS class to a login form so a theme can style that entrance distinctly.
- Land administrators on the content list after they sign in at an admin login page.
- Route course participants to their course area after login.
- Route volunteers to their rota page after login.
- Provide multiple role-scoped entrances on a multi-audience membership site.
- Keep each login page anonymous-only so logged-in users are redirected away from it.
- Define several login pages that all authenticate against the same accounts but differ in labels, allowed roles, and destination.
- Rename or move a login page's URL later by editing its settings row.
- Delete a login page (and its route) when an audience no longer needs it.
- Give a fixed internal landing path per role-scoped login page.
- Present a themed alternative to core's login for one group without hiding `/user/login` from others.
