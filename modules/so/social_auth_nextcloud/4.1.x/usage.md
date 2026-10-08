<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Nextcloud provides Social Auth integration for Nextcloud.

---

Social Auth Nextcloud lets users **log in with their Nextcloud account** — a Social Auth network plugin
adding a (self-hosted) Nextcloud instance as an OAuth2 login/registration provider. It depends on the Social
Auth module, in the Social package.

Use it to offer Nextcloud login. It is an authentication feature and, like other Social Auth network plugins, it
is **thin**: it supplies the Nextcloud client/endpoints and user-info mapping, while the **OAuth flow — the
`state` CSRF check and token exchange — is handled by the Social Auth framework's controller**. Store the
Nextcloud **client ID/secret** as secrets over HTTPS, point it at your trusted Nextcloud instance, and review
Social Auth's account-linking/auto-registration settings. It has no access-control role of its own beyond
authentication. Configure the Nextcloud network credentials.

---

- Offer login with Nextcloud.
- Add Nextcloud as an OAuth provider.
- Support self-hosted Nextcloud.
- Depend on the Social Auth module.
- Supply Nextcloud client/endpoints + mapping.
- Be a thin network plugin.
- Let Social Auth handle the OAuth flow + state check.
- Store the client ID/secret as secrets.
- Use HTTPS + a trusted instance.
- Review account-linking settings.
- Have no access-control role of its own.
- Configure the Nextcloud credentials.
- Handle Nextcloud login.
- Log users in.
- Configure the network.
- Authenticate via Nextcloud.
- Handle the integration.
- Map Nextcloud users.
- Secure the credentials.
- Provide Nextcloud login.
