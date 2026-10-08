<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logout Token provides an endpoint to retrieve the logout (CSRF) token during a user's session, so front-end code can perform a CSRF-safe logout.

---

Logout Token provides an endpoint (`/session/logout/token`, GET) that returns the current user's
logout CSRF token — so decoupled/JavaScript front ends can obtain the token needed to call Drupal's
CSRF-protected logout route and log the user out securely. It uses Drupal's CSRF token generator to
produce the token for the authenticated session. It is in the Custom package.

Use it in decoupled/headless setups where the front end needs to trigger logout. It is a session/auth
helper that supports the correct, CSRF-protected logout flow (rather than weakening it) — the token is
tied to the current session and is what Drupal's logout expects. Confirm the endpoint returns the token
only to the authenticated session owner (which is the design). Consume the token from the front end to
perform logout.

---

- Get the logout CSRF token.
- Support decoupled logout.
- Return the token for the session.
- Enable CSRF-safe logout.
- Use Drupal's CSRF token generator.
- Serve GET /session/logout/token.
- Let JS front ends log out securely.
- Tie the token to the session.
- Support headless setups.
- Return the token to the session owner.
- Perform correct logout flow.
- Not weaken logout security.
- Consume the token to log out.
- Trigger logout from the front end.
- Provide a token endpoint.
- Support the logout route.
- Handle decoupled sessions.
- Get a valid logout token.
- Log out via the token.
- Enable secure logout.
