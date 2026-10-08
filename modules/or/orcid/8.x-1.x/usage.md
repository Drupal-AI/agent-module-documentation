<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ORCID allows account creation and login with ORCID OAuth2.

---

ORCID lets users **create an account and log in with ORCID** (OAuth2), and lets existing users connect their
ORCID iD to their account. It provides its own permissions, in the ORCID package.

Its OAuth callback is `OauthController::redirectPage()` (route `/orcid/oauth`, `_access: 'TRUE'`), which exchanges
the returned `code` for tokens and then logs the user in, registers a new account, or links the ORCID iD to the
current account.

---

- Log in / register with ORCID OAuth2.
- Connect an ORCID iD to an account.
- Provide its own permissions.
- Handle ORCID login.
- Authenticate via ORCID.
- Configure the OAuth app.
- Link accounts.
- Handle the integration.
- Log users in.
- Provide ORCID login.
