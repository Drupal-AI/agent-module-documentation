<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector provides an enterprise single sign-on solution across multiple Drupal sites.

---

SSO Connector **provides single sign-on across multiple Drupal sites** — an Identity-Provider/Service-Provider
model where users authenticate at the IdP site and are signed into the connected SP sites via a token. It depends
on core User, Block and Help, and provides its own permissions, in the Authentication package.

Use it to share login across a family of Drupal sites. It is an **authentication** feature, and it is built with
the right controls: after login at the IdP, it **generates a short-lived JWT** and redirects back to the
originating SP — but only after **validating that SP against an allowlist** (`isAllowedServiceProvider`), refusing
to mint a token for a non-allowed SP, and using a **`TrustedRedirectResponse`** with a configurable short token
expiry (default ~120s). That combination (SP allowlist + short-lived signed token + trusted redirect) prevents the
usual token-leak/open-redirect abuses. Security essentials: keep the **JWT signing key/secret secret and strong**
(env/Key — a leaked signing key lets an attacker forge SSO tokens for any user), keep the **SP allowlist tight**
(only sites you control), keep token lifetimes short, and serve everything over HTTPS. Configure the IdP/SP roles,
allowed SPs and signing key.

---

- Provide cross-site SSO (IdP/SP).
- Sign users into connected SP sites.
- Use short-lived JWTs.
- Depend on core User/Block/Help + provide permissions.
- Serve authentication.
- Share login across sites.
- VALIDATE the target SP against an allowlist (isAllowedServiceProvider) before minting a token.
- Refuse to mint tokens for non-allowed SPs + redirect via TrustedRedirectResponse.
- Use a short token expiry (default ~120s).
- Keep the JWT signing key secret + strong (a leak lets attackers forge SSO tokens for any user).
- Keep the SP allowlist tight (only sites you control) + short lifetimes + HTTPS.
- Configure IdP/SP roles, allowed SPs and signing key.
- Handle SSO.
- Authenticate users.
- Configure the SSO.
- Sign users in.
- Mint tokens.
- Redirect to SPs.
- Secure the signing key.
- Provide cross-site SSO.
