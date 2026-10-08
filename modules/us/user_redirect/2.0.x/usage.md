User Redirect sends users to a configurable internal or external URL immediately after they log in or log out, with a different destination per user role and role priority deciding which one wins when a user has several roles.

---

The module is configured on a single settings form (`/admin/people/users/redirect/form/settings`, route `user_redirect.settings`) that lists every non-anonymous role in two draggable tables — one for **Login** and one for **Logout** — where you enter a Redirect URL and a weight per role. Values are stored in the `user_redirect.settings` config object under `login.<role_id>` and `logout.<role_id>` (each a map of `redirect_url` + `weight`), plus an `ignore` list of path patterns and an `ignore_for` set choosing whether those paths suppress login and/or logout redirects. On login and logout the module's `hook_user_login()` / `hook_user_logout()` implementations call the `user_redirect.service`, which reverses the user's roles (so the last-weighted / highest-priority role is checked first) and applies the first role that has a non-empty redirect URL. Internal URLs are applied by setting the request's `destination` query parameter (so core's normal redirect handling honours it); external URLs are sent immediately as a `TrustedRedirectResponse`. Before redirecting it checks the current path/alias against the `ignore` patterns and skips the redirect on a match (the shipped default ignores `/user/reset/*` so password-reset links are not hijacked). URLs are validated on save against the path validator and `UrlHelper`, accepting either an internal path starting with `/` or an external `http`/`https` URL. The module has no config/install file, so `user_redirect.settings` does not exist until you save the form once.

---

- Send administrators to `/admin/content` right after they log in.
- Send editors to a custom `/dashboard` landing page on login.
- Redirect authenticated users to the site front page after logout.
- Bounce customers to an external portal (`https://portal.example.com`) on login.
- Give each role its own post-login destination on one form.
- Use role weight/priority to pick a destination when a user holds several roles.
- Keep password-reset (`/user/reset/*`) logins from being redirected away.
- Add extra ignore paths so certain login flows (e.g. a checkout return) skip the redirect.
- Apply the ignore list to logout as well as login via the "Ignore the above paths for" checkboxes.
- Redirect a "member" role to a members-only area immediately after authentication.
- Route staff to an intranet URL while leaving anonymous visitors unaffected.
- Send users to a "thanks for visiting" page on logout.
- Provide a per-role welcome page without writing a custom `hook_user_login()`.
- Redirect an "author" role to `/node/add/article` to start creating content on login.
- Point a support role to a ticket queue view after login.
- Redirect to an external SSO/marketing site on logout.
- Standardise post-login destinations across an editorial team by role.
- Override the default landing behaviour that would otherwise send users to their profile.
- Configure redirects entirely through exported config (`user_redirect.settings`) for deployment.
- Temporarily disable a role's redirect by clearing its Redirect URL field.
- Handle both internal Drupal paths and fully-qualified external URLs from the same form.
- Prevent redirect loops by ignoring paths that must render normally after login.
- Gate the settings form behind the "administer user redirect settings" permission.
- Migrate off a bespoke login-redirect snippet to a maintained contrib module.
