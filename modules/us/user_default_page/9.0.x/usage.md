User Default Page redirects users to a configurable destination after they log in or log out, chosen by role and/or specific user, with an optional status message. Rules are stored as `user_default_page_config_entity` config entities managed at `/admin/config/people/user_default_page`.

---

The module defines a single config entity type, `user_default_page_config_entity`, each row of which holds: a label, a set of target roles (`roles`), a comma-separated list of target user IDs (`users`), a login redirect path + message, a logout redirect path + message, and a weight. On `hook_user_login` and `hook_user_logout` it loads all entities and picks a redirect: user-ID matches take priority, otherwise the highest-weight role match wins. The chosen path is passed to `user_default_page_redirect()`, which normalizes it (prepending scheme/host/base path unless it already starts with `http` or `node`), optionally rewrites `/admin` and `/user` segments when the `rename_admin_paths` module is active, and then **validates it with `path.validator:getUrlIfValid()`** before issuing a `RedirectResponse` — invalid paths fall back to an existing `redirect` module entry (if present) or a warning message, so the destination is admin-configured and validated rather than taken from a request parameter. The redirect is skipped for one-time-login (`user.reset.login`) and, on logout, for autologout routes; a `hook_alter` (`user_default_page_login_ignore_whitelist`) lets other modules add ignored routes. A `?upd=<entity id>` query param on the landing page triggers `hook_page_attachments` to display the stored login/logout message. The admin UI is gated by core's `administer site configuration` permission (the module defines no permissions of its own). Login redirect paths should be entered as internal URLs (e.g. `/node/5`).

---

- Send every authenticated user to a custom dashboard node after login.
- Redirect editors to the content admin listing on login, by role.
- Redirect administrators to the admin dashboard while sending regular users to the front page.
- Give a specific user (by UID) their own personal landing page after login.
- Show a "Welcome back" status message after a role-based login redirect.
- Redirect users to a "You have been logged out" page after logout.
- Display a custom goodbye message on the logout landing page.
- Prioritize a per-user redirect over the user's role-based redirect.
- Resolve conflicts between multiple matching roles using the entity weight.
- Keep users away from the default `/user/{uid}` profile page after login.
- Route different roles to different membership areas of the site.
- Redirect to a Views page (e.g. `/my-orders`) after login for a customer role.
- Avoid hijacking one-time login / password-reset logins (excluded automatically).
- Cooperate with the Autologout module by skipping its logout routes.
- Cooperate with Rename Admin Paths by rewriting `/admin` and `/user` path segments.
- Fall back to a Redirect-module entry when the configured path no longer exists.
- Add extra routes to the login-ignore list from a custom module via the provided alter hook.
- Configure separate login-only, logout-only, or both redirects per rule.
- Localize / customize the post-redirect message per rule.
- Manage all redirect rules from one admin listing at `/admin/config/people/user_default_page`.
