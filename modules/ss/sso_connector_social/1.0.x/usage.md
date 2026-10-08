<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector Social adds OAuth2 social login providers with proper state validation.

---

SSO Connector – Social Login adds OAuth2 social login to the SSO Connector suite — supporting Google, Microsoft, GitHub, LinkedIn, Facebook and generic OAuth2 providers, so users can sign in with their social accounts, with per-provider connect/callback endpoints.

Security: the callback validates the OAuth CSRF `state` (`validateState`) before finalizing login — proper login-CSRF protection. Provider client secrets should be stored securely (env-backed). Permissions cover administration (`administer sso connector social`) and self-service (`manage own social accounts`). Depends on `sso_connector`, core `user`, `block`, `file`, and `image`; requires Drupal 11.2+.

---

- Add OAuth2 social login.
- Support Google/Microsoft/GitHub/LinkedIn/Facebook.
- Support generic OAuth2 providers.
- Provide connect/callback endpoints.
- Validate the CSRF state on callback.
- Protect against login-CSRF.
- Store provider secrets securely (env-backed).
- Gate admin with `administer sso connector social`.
- Gate self-service with `manage own social accounts`.
- Depend on `sso_connector` and core `user`.
- Depend on core `block`/`file`/`image`.
- Require Drupal 11.2+.
- Let users sign in socially.
- Link social accounts.
- Support single sign-on.
- Configure providers
- Handle OAuth callbacks
- Secure social login
