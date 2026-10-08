<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage OAuth2 client tokens (obtain, store, refresh) with verified callbacks.

---

OAuth2 Token Manager manages OAuth2 tokens — obtaining, storing and refreshing OAuth2 access/refresh tokens for connecting Drupal to third-party OAuth2 providers, so other modules can make authenticated API calls without re-implementing the OAuth2 dance.

Security: the authorization-callback controller **validates the OAuth `state` parameter** against the session-stored init state before accepting the code (CSRF protection for the OAuth flow). Store the client secret securely (env-backed). Supports Drupal 9.3+, 10, and 11.

---

- Manage OAuth2 tokens.
- Obtain/store/refresh tokens.
- Connect to OAuth2 providers.
- Enable authenticated API calls.
- Validate the OAuth `state` (CSRF).
- Store the client secret securely.
- Avoid re-implementing OAuth2.
- Support Drupal 9.3+, 10, and 11.
- Configure the provider.
- Aid integrations.
- Handle OAuth2.
- Refresh tokens
- Support Drupal.
- Support Drupal.
- Support Drupal.
