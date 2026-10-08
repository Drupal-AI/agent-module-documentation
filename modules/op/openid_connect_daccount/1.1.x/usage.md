<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
d ACCOUNT OpenID Connect Client enables OpenID Connect sign-on with d ACCOUNT connect.

---

d ACCOUNT OpenID Connect Client **enables sign-on with d ACCOUNT connect** — an OpenID Connect client plugin
that lets users authenticate to Drupal via the "d ACCOUNT" identity provider. It is built on the `openid_connect`
contrib module (a hard dependency).

Use it to add d ACCOUNT login. It is an **authentication** feature and it delegates the protocol mechanics to the
trusted **openid_connect** module: the OAuth **`state` parameter / CSRF (login-CSRF) protection, code→token
exchange and user mapping are handled by openid_connect**, not reimplemented here — this module supplies the d
ACCOUNT provider endpoints/claims. Security essentials: store the **OAuth client ID/secret as secrets** (env/Key),
serve over HTTPS, and keep **openid_connect updated** (its state handling is your login-CSRF defense). It layers on
core authentication. Configure the d ACCOUNT client credentials and endpoints.

---

- Authenticate via d ACCOUNT connect.
- Provide an OpenID Connect client plugin.
- Add d ACCOUNT login.
- Depend on the openid_connect module.
- Delegate protocol mechanics to openid_connect.
- Rely on openid_connect for state/CSRF + token exchange + user mapping.
- Supply the d ACCOUNT provider endpoints/claims.
- Store the OAuth client ID/secret as secrets (env/Key).
- Serve over HTTPS + keep openid_connect updated (login-CSRF defense).
- Layer on core authentication.
- Configure the d ACCOUNT credentials + endpoints.
- Handle d ACCOUNT login.
- Authenticate users.
- Configure the client.
- Log users in.
- Map identities.
- Handle OIDC.
- Exchange tokens.
- Secure the credentials.
- Provide d ACCOUNT OIDC login.
