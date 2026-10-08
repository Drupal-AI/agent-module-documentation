<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
League OAuth Login provides OAuth login using the League OAuth2 client, with provider submodules (GitHub, GitLab).

---

League OAuth Login provides OAuth 2.0 single-sign-on login built on the League OAuth2 client — letting
users log in with an external OAuth provider (it ships `league_oauth_login_github` and `league_oauth_login_gitlab`
provider submodules, and is extensible to others). On login it uses External Authentication to map the OAuth
identity to a Drupal account. It depends on the samlauth-style externalauth flow, in the Custom package.

Use it for OAuth SSO login. Store the OAuth client secret as a secret and use HTTPS.

---

- Provide OAuth 2.0 SSO login.
- Use the League OAuth2 client.
- Ship GitHub/GitLab provider submodules.
- Map the OAuth identity to a Drupal account.
- Store the OAuth client secret as a secret.
- Use HTTPS.
- Configure the OAuth provider.
- Handle OAuth login.
- Map identities.
- Handle SSO login.
- Configure providers.
- Log in via OAuth.
