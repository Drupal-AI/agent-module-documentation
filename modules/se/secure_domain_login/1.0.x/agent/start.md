<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Secure Domain Login (secure_domain_login) — agent index
**Redirects `/user` requests to the front page when the request Host is not on an allowed-domains whitelist.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Config route:** `secure_domain_login.config` → `/admin/config/secure-domain-login` (perm `administer secure domain login configuration`)
- **Service:** `secure_domain_login.secure_domain_login` — kernel RESPONSE event subscriber (`SecureDomainLogin::onRespond`)
- **Config key:** `secure_domain_login.config:whitelist_domains` (comma-separated)

**Security:** Admin config route is permission-gated; no anonymous mutating endpoints. The access guard itself is coarse and best-effort: it trusts the client Host header, matches `/user` as a substring, fires only at response time, and an empty whitelist redirects all `/user` traffic. Not a substitute for server-level host restrictions.

See [configure/settings.md](configure/settings.md)
