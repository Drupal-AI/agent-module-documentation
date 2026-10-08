<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Amazon provides Social Auth integration for Amazon.

---

Social Auth Amazon adds **"Login with Amazon"** to the **Social Auth** framework — letting users register/
log in with their Amazon account via OAuth 2.0. It provides the Amazon network/auth-manager plugins; the
redirect, callback and user handling are done by the Social Auth base module. It depends on `social_auth`, in
the Social package.

Use it to offer Amazon social login. It touches authentication, and it delegates correctly: this module has
**no callback controller of its own** (its own routes are unused/commented) — the OAuth flow, including the
**`state` (CSRF) validation**, is handled by the **Social Auth base module's** controller, so it inherits the
framework's standard CSRF-protected flow rather than re-implementing it. Security notes: store the Amazon
**client secret** as a secret (via the framework's settings/Key), use HTTPS, and review which accounts auto-
register. It has no access-control role beyond `administer social api authentication`. Configure the Amazon
client ID/secret.

---

- Add Login with Amazon (OAuth).
- Register/log in with an Amazon account.
- Provide Amazon network plugins.
- Delegate the flow to Social Auth.
- Have no callback controller of its own.
- Inherit the framework's state (CSRF) validation.
- Store the Amazon client secret as a secret.
- Use HTTPS.
- Review auto-registration.
- Depend on social_auth.
- Have no access-control role beyond the admin permission.
- Configure the client ID/secret.
- Handle Amazon login.
- Provide social login.
- Configure OAuth.
- Handle the integration.
- Log in via Amazon.
- Configure Amazon auth.
- Delegate CSRF handling.
- Provide Amazon SSO.
