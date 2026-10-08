<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bakery provides single sign-on across sites sharing a second-level domain: a parent site issues a signed, encrypted cookie that child sites trust to log the same user in.

---

Running several Drupal sites under one domain — app.example.com, docs.example.com, shop.example.com — and wanting a user to log in once and be recognised everywhere is the classic single-sign-on problem within one organisation. Bakery solves it the cookie way: a designated parent site authenticates the user and issues a cookie, signed and encrypted, that the child sites read and trust to establish the same session. It is a long-standing Drupal SSO approach for sites that share a second-level domain.

Because the cookie *is* the cross-site authentication token, the whole security of the scheme rests on how that cookie is signed, verified and deserialized. The mechanism: HMAC-SHA256 signing with a shared `bakery_key`, encryption of the payload, a freshness check, and — importantly — the signature is verified *before* the payload is deserialized.

Operationally, the shared `bakery_key` is the crown jewel: it must be identical across the sites and must never reach version control or a database dump, since anyone with it can forge SSO cookies for any user. For a multi-site-one-domain SSO need, Bakery is the established tool; treat its key with the seriousness of a master credential.

---

- Log in once across sibling sites.
- Provide SSO on one domain.
- Share a session across subdomains.
- Issue a signed SSO cookie.
- Trust a parent site's login.
- Recognise a user on child sites.
- Authenticate once, use everywhere.
- Run multi-site SSO.
- Share the bakery_key securely.
- Keep the SSO key out of git.
- Set up a parent/child SSO.
- Sign cookies with HMAC-SHA256.
- Verify signature before use.
- Bound cookie lifetime with freshness.
- Protect the shared key.
- Encrypt the SSO payload.
- Federate logins on a domain.
- Provide cross-site sessions.
- Treat the key as a master credential.
- Adopt an established SSO approach.
- Avoid per-site logins.