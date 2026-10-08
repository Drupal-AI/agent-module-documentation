<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feide Login adds Feide OAuth single sign-on, mapping Feide users to Drupal accounts via ExternalAuth.

---

Feide Login lets users authenticate with Feide — the Norwegian federated identity provider for education and research — using an OAuth 2.0 authorization-code flow. On return it maps the Feide user (by email) to a Drupal account via the ExternalAuth module, optionally auto-registering new users.

The `/feide_redirect` callback completes the login. Client credentials are stored via the Key module (env-backed). Depends on `externalauth` and `key`; supports Drupal 9, 10, and 11.

---

- Log in with Feide OAuth.
- Use the authorization-code flow.
- Map Feide users to Drupal accounts.
- Use ExternalAuth for mapping.
- Optionally auto-register users.
- Store client credentials via Key.
- Keep credentials env-backed.
- Depend on `externalauth` and `key`.
- Support Drupal 9, 10, and 11.
- Target Norwegian education/research.
- Key login on email.
- Provide federated SSO.
- Redirect to Feide to authenticate.
- Finalize login via ExternalAuth.
