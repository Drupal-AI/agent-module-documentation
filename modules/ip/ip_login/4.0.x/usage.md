<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP Login automatically logs a user in by matching their client IP address against per-user configured IPs, ranges or wildcards — a trusted-network / kiosk auto-login mechanism.

---

IP Login automatically authenticates a user when the request's client IP falls within a range
configured on that user's account (stored via the Field IP address module). An early HTTP middleware
checks the client IP before the page cache, and if it matches an active user's configured IP range,
the module calls `user_login_finalize()` to establish a full authenticated session — no password
entry. It supports single IPs, ranges and wildcards, path restrictions for where auto-login applies,
and permissions (`administer ip login`, `log in as another user`) governing whether a matched user may
instead log in as someone else.

**Security is the central consideration.** Auto-login by IP grants a full authenticated session based
solely on source IP, so it must be used only for genuinely trusted, controlled networks:
- **Shared IPs are dangerous.** In NAT/CGNAT/office/VPN environments many people share one public IP;
  everyone from that IP is logged in as the single mapped account. Map only IPs that correspond to one
  trusted person or a kiosk whose shared access is intended.
- **It depends on correct reverse-proxy configuration.** The module uses `$request->getClientIp()`,
  which is the correct API — it honours Drupal's trusted-proxy settings and does not blindly trust
  `X-Forwarded-For`. But if the site is behind a proxy/CDN and `settings.php` is misconfigured to
  trust all proxies (or trust forwarded headers from untrusted sources), an attacker can spoof
  `X-Forwarded-For` and impersonate any mapped user. Configure `reverse_proxy`/`trusted_hosts`
  correctly before relying on this.
- **Map cautiously and never to high-privilege accounts on shared networks.** Auto-logging into an
  admin account by IP turns any access to that network path into admin access.

Used within those constraints (kiosks, single-tenant office IPs, controlled devices) it is a
legitimate convenience; outside them it is an authentication-bypass foot-gun. The code itself uses the
correct client-IP API and filters to active users; the risk is in deployment/configuration, which the
adopter owns.

---

- Auto-login a user by matching their client IP.
- Support single IPs, ranges and wildcards.
- Log in without a password on trusted networks.
- Configure per-user IP ranges via Field IP address.
- Restrict auto-login to specific paths.
- Use for kiosks or single-tenant office IPs.
- Avoid mapping shared/NAT IPs to one user.
- Depend on correct reverse-proxy/trusted-host config.
- Know getClientIp honours trusted-proxy settings.
- Prevent X-Forwarded-For spoofing via correct proxy config.
- Never auto-login admins on shared networks.
- Grant a full authenticated session on match.
- Check IP in early middleware before page cache.
- Govern login-as-another via permissions.
- Filter matches to active users only.
- Treat it as trusted-network auth only.
- Understand it is an auth-bypass risk if misused.
- Map only IPs tied to one trusted person.
- Configure at ip_login.settings.
- Depend on user and field_ipaddress.
