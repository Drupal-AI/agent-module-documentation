<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LDAP SSO Auth logs users into Drupal from a single sign-on identity the web server has already established — Kerberos, NTLM or an SSO proxy setting a `$_SERVER` variable such as `REMOTE_USER` — and resolves that username against the servers configured by the LDAP module.

---

Install it with `composer require drupal/ldap` and enable `ldap_sso_auth` alongside its dependencies `ldap_servers` and `ldap_authentication` (`drush en ldap_sso_auth`); it requires Drupal `^9 || ^10 || ^11`. The premise is that authentication happens **before** Drupal sees the request: your web server negotiates Kerberos (`mod_auth_kerb`), NTLM (`mod_auth_sspi`) or an upstream SSO proxy, and the resulting username lands in a server variable. Configure the module at **Administration › Configuration › People › LDAP servers › SSO Auth** (`/admin/config/people/ldap/sso-auth`, which needs the *administer site configuration* permission). The main setting is **Server variable containing the user** (`ssoVariable`, default `REMOTE_USER`); the form conveniently prints the live value your web server is currently sending so you can confirm what to point it at. Turn on **Split user name and realm** if identities arrive as `user@realm` (on by default, right for `mod_auth_kerb`), and **Strip REMOTE_USER of domain name** if you also want manual logins without the realm to reach the same account. Use **Excluded Paths** and **Excluded Hosts** to skip SSO on specific pages or hostnames — the module already skips `/user/login`, `/user/logout`, `/user/password`, `/user/login/sso` and password-reset links. Under **Login customization** you can redirect users to an internal path on logout (`redirectOnLogout` / `logoutRedirectPath`, validated as an internal Drupal path). At runtime a Drupal authentication provider reads the variable, optionally splits the realm and strips the domain, hands the name to `ldap_authentication`'s SSO login validator and finalises the Drupal login when the LDAP server recognises it — no password is exchanged with Drupal. Because there is no password available, the settings form will refuse to enable SSO against an LDAP server whose bind method is per-user or anonymous-then-user. The project recommends **not** enabling the core Internal Page Cache module; the module ships a page-cache policy that bypasses the cache when an SSO identity is present.

---

- Log intranet users into Drupal from an Apache/Kerberos negotiation with no login prompt.
- Accept an NTLM-authenticated Windows desktop identity via `mod_auth_sspi`.
- Sign users in from an upstream SSO reverse proxy that sets `REMOTE_USER`.
- Map an SSO username onto a Drupal account through the LDAP module's servers.
- Point the module at `REDIRECT_REMOTE_USER` instead of `REMOTE_USER` when your web server uses it.
- Diagnose which server variable the web server is actually sending, from the settings form.
- Split a `user@realm` identity before the LDAP lookup.
- Strip a `@domain` suffix or `domain\` prefix from the remote username.
- Reconcile SSO logins with manual LDAP logins so they hit one account.
- Exclude specific paths (for example maintenance or health-check URLs) from SSO.
- Exclude specific hostnames from SSO on a multi-hostname site.
- Keep the core login, logout, password and password-reset pages working alongside SSO.
- Redirect users to a chosen internal path after they log out.
- Reuse an existing corporate LDAP directory for site access without storing passwords in Drupal.
- Combine SSO with the LDAP module's user provisioning and role mapping.
- Confirm an LDAP server's bind method is compatible with password-less SSO before enabling.
- Provision Drupal accounts on first SSO visit via `ldap_authentication`'s login validator.
- Run SSO on a stack where authentication is handled entirely at the web-server layer.
- Audit an inherited site that already has this module enabled and see how identities are resolved.
- Decide whether a deployment needs a real Kerberos/NTLM negotiation or an SSO proxy.
