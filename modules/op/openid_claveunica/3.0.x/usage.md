<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenID ClaveUnica adds ClaveÚnica login on top of OpenID Connect, with a hash-gated complete-profile step.

---

OpenID ClaveUnica helps integrate ClaveÚnica — Chile's national digital identity — with the OpenID Connect module, so users can authenticate with their ClaveÚnica account. It adds a complete-profile step for new users and per-client configuration.

The complete-account route `claveunica/complete-account/{user}/{client}/{hash}` is gated by a custom access check and the form validates the per-user hash (`checkHashCompleteProfile`) before calling `user_login_finalize()`. The underlying OAuth flow is handled by the OpenID Connect base module; store client credentials securely (env-backed). Depends on `openid_connect`; supports Drupal 9.5+, 10.2+, and 11.

---

- Integrate ClaveÚnica login.
- Build on OpenID Connect.
- Authenticate Chile's national identity.
- Add a complete-profile step.
- Support per-client configuration.
- Gate complete-account with custom access.
- Validate a per-user hash before login.
- Finalize login after the hash check.
- Rely on OpenID Connect for OAuth.
- Store client credentials securely.
- Depend on `openid_connect`.
- Support Drupal 9.5+, 10.2+, and 11.
- Serve Chilean government/citizen sites.
- Provide federated SSO.
- Complete new-user profiles.
- Configure clients.
- Handle ClaveÚnica.
- Support national identity login
