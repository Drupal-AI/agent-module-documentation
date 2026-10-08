<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Keycloak provides Social Auth integration for Keycloak.

---

Social Auth Keycloak lets users **log in with a Keycloak** identity provider — a Social Auth network plugin
adding a (self-hosted) Keycloak realm as an OAuth2/OIDC login/registration provider. It depends on Social API
and Social Auth, in the Social package.

Use it to offer Keycloak SSO. It is an authentication feature and, like other Social Auth network plugins, it is
**thin**: it supplies the Keycloak client/endpoints and user mapping, while the **OAuth flow — the `state` CSRF
check and token exchange — is handled by the Social Auth framework's controller**. Store the Keycloak **client
ID/secret** as secrets over HTTPS, point it at your trusted Keycloak realm, and review Social Auth's account-
linking/auto-registration settings. It has no access-control role of its own beyond authentication. Configure
the Keycloak network credentials.

---

- Offer login with Keycloak.
- Add Keycloak as an OAuth/OIDC provider.
- Support self-hosted Keycloak.
- Depend on Social API and Social Auth.
- Supply Keycloak client/endpoints + mapping.
- Be a thin network plugin.
- Let Social Auth handle the OAuth flow + state check.
- Store the client ID/secret as secrets.
- Use HTTPS + a trusted realm.
- Review account-linking settings.
- Have no access-control role of its own.
- Configure the Keycloak credentials.
- Handle Keycloak login.
- Log users in.
- Configure the network.
- Authenticate via Keycloak.
- Handle the integration.
- Map Keycloak users.
- Secure the credentials.
- Provide Keycloak SSO.
