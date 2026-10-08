<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Route Basic Auth adds HTTP basic authentication to configured routes.

---

Route Basic Auth adds HTTP Basic authentication to configured routes — protecting specific paths/routes
with a username/password prompt (in addition to Drupal's own access), useful for gating a staging area, a
preview, or an API path behind basic auth. It is configured at `route_basic_auth.settings`, provides its own
permissions, in the Authentication package.

Use it to put HTTP Basic auth in front of chosen routes. Its credential handling is **correct**: the
`CredentialsValidator` compares the provided username and password against the expected ones with
**`hash_equals()`** (constant-time, resisting timing attacks) and fails closed if the expected credentials
aren't set. Standard HTTP-Basic caveats apply and must be respected: Basic auth sends the credentials
**base64-encoded (not encrypted)** on every request, so it **must be used over HTTPS**; and the expected
username/password are stored to compare against — **store them as secrets** (settings.php/environment, not
committed config) and treat basic auth as a coarse gate, not a substitute for real per-user authentication.
Configure the protected routes and credentials.

---

- Add HTTP Basic auth to routes.
- Protect chosen paths with a password prompt.
- Gate staging/preview/API paths.
- Configure at route_basic_auth.settings.
- Provide its own permissions.
- Compare credentials with hash_equals (constant-time).
- Fail closed if expected credentials aren't set.
- ALWAYS use over HTTPS (Basic is base64, not encrypted).
- Store the expected username/password as secrets.
- Treat Basic auth as a coarse gate.
- Not substitute for per-user authentication.
- Have no other access-control role.
- Configure the protected routes.
- Handle basic auth.
- Protect routes.
- Configure credentials.
- Handle credentials securely.
- Gate routes.
- Configure the auth.
- Protect paths.
