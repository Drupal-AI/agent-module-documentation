Lets a site temporarily prevent users from logging in — for everyone except roles granted a bypass permission — with an optional secret access key that must be appended to the login URL, plus optional force-logout of current sessions. Requires Drupal 11.3+ or 12.

---

When activated (`login_disable_is_active`), the module alters the user login form and login block: unless the configured secret `login_disable_key` is present as a query-string argument on the URL (e.g. `/user/login?admin`), the name/password fields are disabled and the form's validate/submit handlers are removed, so the form cannot be used. The real authentication boundary is `hook_user_login` (`LoginDisableHooks::userLogin`): after any successful login, if the account lacks the `bypass disabled login` permission the session is immediately cleared, effectively refusing access and showing a customizable message; this covers the form, the login block, the REST login, and one-time-login / password-reset links alike, since all of them finalize login through the same code path. A `LoginDisableAccessCheck` is also attached to the REST login route (`user.login.http`) via `LoginDisableRouteSubscriber`, returning `403 "Access key required."` when active and a key is set. The settings form (`/admin/config/people/login-disable`, permission `administer permissions`) toggles activation, sets the key and message, and offers "force logout" which deletes all sessions except user 1 and the current admin. The `bypass disabled login` permission is marked `restrict access: TRUE`. In 2.2.x the hooks are implemented as an OOP `#[Hook]` service class with thin legacy procedural wrappers. Note the module ships a default key of `admin`, which should be changed before activation.

---

- Put a site into "members can't log in" mode during maintenance without taking the whole site offline.
- Temporarily lock out all logins after a security incident while admins retain access.
- Run a soft launch where only staff (with the bypass permission) can log in.
- Require a secret `?key` on the login URL so the login form is hidden from casual/anonymous visitors.
- Give trusted admins a bookmarkable login URL (`/user/login?yourkey`) that still works while login is disabled.
- Refuse login to any role lacking `bypass disabled login`, even if they know the key.
- Show a custom "member access temporarily disabled" message to blocked users.
- Force-log-out all currently logged-in users (except user 1 and yourself) when disabling login.
- Restrict the login gate to specific roles by granting `bypass disabled login` only to those roles.
- Also gate the REST/JSON login endpoint (`user.login.http`) behind the access key.
- Block one-time-login and password-reset link logins for non-bypass roles (the session is cleared post-login).
- Freeze member activity during a data migration or content freeze.
- Reduce login attack surface on a staging/pre-prod site by hiding the login form behind a key.
- Prevent new logins during a scheduled deployment window.
- Keep the site fully browsable for anonymous users while pausing authenticated access.
- Re-enable normal login instantly by unchecking activation (no code changes).
- Cover decoupled/JSON:API front-ends by returning 403 on the REST login route when the key is absent.
- Combine the per-role bypass permission with the URL key for layered admin access during a lockdown.
