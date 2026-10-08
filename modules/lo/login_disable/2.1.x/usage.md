Lets a site temporarily prevent users from logging in — for everyone except roles granted a bypass permission — with an optional secret access key that must be appended to the login URL, plus optional force-logout of current sessions.

---

When activated (`login_disable_is_active`), the module alters the user login form and login block: unless the configured secret `login_disable_key` is present as a query-string argument on the URL (e.g. `/user/login?admin`), the name/password fields are disabled and the form's validate/submit handlers are removed, so the form cannot be used. IP-based flood control (reusing core's `user.flood` limits) blocks repeated key guesses. The real authentication boundary is `hook_user_login`: after any successful login, if the account lacks the `bypass disabled login` permission the session is immediately cleared, effectively refusing access and showing a customizable message. A `LoginDisableAccessCheck` is also attached to the REST login route (`user.login.http`) requiring the key when one is set. The settings form (`/admin/config/people/login-disable`, permission `administer permissions`) toggles activation, sets the key and message, and offers "force logout" which deletes all sessions except user 1 and the current admin. The `bypass disabled login` permission is marked `restrict access: TRUE`. Note the module ships a default key of `admin`.

---

- Put a site into "members can't log in" mode during maintenance without taking the whole site offline.
- Temporarily lock out all logins after a security incident while admins retain access.
- Run a soft launch where only staff (with the bypass permission) can log in.
- Require a secret `?key` on the login URL so the login form is hidden from casual/anonymous visitors.
- Give trusted admins a bookmarkable login URL (`/user/login?yourkey`) that still works while login is disabled.
- Block brute-force guessing of the access key with built-in IP flood control (core login limits).
- Refuse login to any role lacking `bypass disabled login`, even if they know the key.
- Show a custom "member access temporarily disabled" message to blocked users.
- Force-log-out all currently logged-in users (except user 1 and yourself) when disabling login.
- Restrict the login gate to specific roles by granting `bypass disabled login` only to those roles.
- Also gate the REST/JSON login endpoint (`user.login.http`) behind the access key.
- Freeze member activity during a data migration or content freeze.
- Reduce login attack surface on a staging/pre-prod site by hiding the login form behind a key.
- Prevent new logins during a scheduled deployment window.
- Keep the site fully browsable for anonymous users while pausing authenticated access.
- Re-enable normal login instantly by unchecking activation (no code changes).
