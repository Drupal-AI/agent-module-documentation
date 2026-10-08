<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External identity-provider authentication for decoupled Drupal (JWT, MFA, user linking).

---

Headless IdP provides external identity provider authentication for decoupled Drupal — JWT validation, MFA challenge/response, and user linking, headless-first — exposing a JSON auth API (`/auth/login`, `/session`, `/auth/challenge`, `/auth/logout`, `/auth/migrate`) for a decoupled frontend.

Security: the login flow is defensively built — it verifies the password via a real provider (`authenticatePassword()`), applies IP- and user-scoped **flood/brute-force protection** (mirroring core's user.flood defaults), returns **generic errors to avoid account enumeration**, and completes legacy-password migration only after the legacy password is proven. Depends on `simple_oauth` and `externalauth`; supports Drupal 10.2+ and 11.

---

- Authenticate a decoupled frontend.
- Provide a JSON auth API.
- Validate JWTs.
- Support MFA challenge/response.
- Link external-IdP users.
- Verify passwords (real provider).
- Apply IP/user flood protection.
- Return generic anti-enumeration errors.
- Depend on `simple_oauth` and `externalauth`.
- Support Drupal 10.2+ and 11.
- Serve headless auth.
- Handle user linking
- Support Drupal.
- Support Drupal.
- Support Drupal.
