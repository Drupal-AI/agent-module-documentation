<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth HID provides Social Auth integration for Humanitarian ID.

---

Social Auth Humanitarian ID lets users **log in with their Humanitarian ID (HID)** account — a Social Auth
network plugin that adds HID as an OAuth2 login/registration provider. It depends on the Social Auth module, in
the Social package.

Use it to offer HID login (for humanitarian-sector sites). It is an authentication feature and it is a **thin
network plugin on the Social Auth framework**: it supplies the HID client/endpoints and user-info mapping, while
the **OAuth flow — including the `state` CSRF check and the token exchange — is handled by the Social Auth
framework's controller**, not custom code here. Store the HID **client ID/secret** as secrets over HTTPS, and
review Social Auth's account-linking settings (auto-registration/email verification). It has no access-control
role of its own beyond authentication. Configure the HID network credentials.

---

- Offer login with Humanitarian ID.
- Add HID as an OAuth provider.
- Serve humanitarian-sector sites.
- Depend on the Social Auth module.
- Supply HID client/endpoints + user mapping.
- Be a thin network plugin.
- Let Social Auth handle the OAuth flow + state check.
- Store the HID client ID/secret as secrets.
- Use HTTPS.
- Review account-linking/auto-registration settings.
- Have no access-control role of its own.
- Configure the HID credentials.
- Handle HID login.
- Log users in.
- Configure the network.
- Authenticate via HID.
- Handle the integration.
- Map HID users.
- Secure the credentials.
- Provide HID login.
