<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Security Login Secure (by miniOrange) provides brute-force protection — blocking IPs and accounts after failed login attempts — and talks to a miniOrange backend for registration and API-key exchange.

---

Marketed as a comprehensive security solution, this miniOrange module's actual feature is brute-force protection: it blocks IP addresses and user accounts after repeated failed login attempts, a legitimate and useful control. Registration, API-key retrieval (/rest/customer/key) and the auth challenge are calls to miniOrange's xecurify.com API. Use the brute-force feature if wanted, with the usual IP-ban caveats: shared-IP false positives, real client IP behind a proxy.

---

- Block brute-force login attempts.
- Ban IPs after failed logins.
- Block accounts after failed logins.
- Protect the login form.
- Consider shared-IP false positives.
- Use the real client IP behind a proxy.
- Harden the login.
- Rate-limit logins.
- Review the miniOrange integration.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.