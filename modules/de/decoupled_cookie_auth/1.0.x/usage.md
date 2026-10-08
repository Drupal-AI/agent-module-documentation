<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Cookie Auth

Smooths over rough edges when a decoupled frontend uses Drupal's cookie authentication, covering registration, auto-login, login-URL tokens, and password-reset flows.

- Supports registering by email + password only (auto-generates a unique username).
- Automatically logs a user in after they register via the JSON registration endpoint.
- Redirects login-related URLs to a configured frontend page.

---

## Installation & configuration

- Enable; configuration form at `/admin/config/decoupled_cookie_auth/configuration` (perm `administer site configuration`).
- Option **allow_registration_only_email** enables username-less JSON registration.
- Config object: `decoupled_cookie_auth.configuration`.
- Event subscribers handle redirect responses, access-denied, and requests (see `*.services.yml`).
- Works alongside core REST user registration (`rest.user_registration.POST`).
- Set the frontend login page used to rewrite the `[site:login-url]` token.

---

## Usage & behaviour / security

- `hook_ENTITY_TYPE_create` generates a unique username from the email local-part when registering only by email (route + JSON checked).
- `hook_ENTITY_TYPE_insert` auto-logs-in the just-registered account **only** when the request is the JSON registration route, the user is anonymous, email verification is off, and the account is active.
- This auto-login is the same trust model as core: a user logging into the account they just created — VERIFIED SOUND, not a privilege escalation.
- `hook_ENTITY_TYPE_load` skips the current-password constraint only when the current user has a valid one-time login `pass-reset-token`, compared with `hash_equals` against the session value.
- `hook_ENTITY_TYPE_update` clears the password-reset session flag after the user's own account is updated.
- `hook_tokens_alter` rewrites `[site:login-url]` to the frontend login page.
- The username-uniqueness loop uses an entity query with `accessCheck(FALSE)` for an internal name lookup (no data exposure).
- Email is validated with the core email validator before use.
- All privileged actions are constrained to the current user's own account and the registration route.
- No external HTTP calls, no SSRF, no unauthenticated mutation beyond core's own registration endpoint.
- Intended for headless/decoupled sites using cookie (session) auth rather than tokens.
- Pair with CORS and standard REST/JSON:API setup.
- Tests live under `tests/`.
- Redirect/access-denied/request event subscribers are wired in `decoupled_cookie_auth.services.yml`.
- Read: `decoupled_cookie_auth.module`, `src/EventSubscriber/`, `src/Form/ConfigurationForm.php`.
