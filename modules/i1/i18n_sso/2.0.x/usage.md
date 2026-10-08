<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Internationalization Single Sign-On provides SSO functionality over a multi-language, multi-domain configuration, sharing login between language domains.

---

Internationalization Single Sign-On (i18n_sso) provides single sign-on across a site that uses multiple
domains for different languages — so a user logged in on one language domain is transparently logged in on
the sibling language domains, sharing the session across the configured domains. It depends on core Language
and System, in the Multilingual package.

Use it to share login across per-language domains. Its design is sound: it issues a short-lived, randomly
generated token (`Crypt::randomBytesBase64()`, 10-minute lifetime, bound to the user's uid and IP, stored in
the DB and cleaned up by cron) that the sibling domain exchanges to establish the session, and its CORS
handling only echoes `Access-Control-Allow-Origin` for the **configured** language domains (from
`language.negotiation` `url.domains`), never a wildcard, when sending credentialed cross-domain requests.
When adopting: serve all domains over **HTTPS** (so the token isn't exposed in transit), and keep the list of
language domains accurate (only trusted sibling domains should be in the allow-list). It is an
authentication/session feature; it grants login across your own domains and has no other access-control role.
Configure the language domains.

---

- Share login across language domains.
- Provide SSO for multi-domain i18n.
- Log the user in on sibling domains.
- Depend on core Language and System.
- Issue a short-lived random token (10-min).
- Bind the token to uid and IP.
- Clean up expired tokens via cron.
- Restrict CORS to configured language domains (no wildcard).
- Serve all domains over HTTPS.
- Keep the language-domain allow-list accurate.
- Only allow trusted sibling domains.
- Have no other access-control role.
- Share the session securely.
- Configure the language domains.
- Exchange the token cross-domain.
- Grant login across own domains.
- Handle multi-domain SSO.
- Establish sibling sessions.
- Configure SSO domains.
- Enable cross-domain login.
