<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple IP Login logs users in automatically based on their client IP address, matched against configured IP wildcard rules mapped to user accounts.

---

Simple IP Login automatically authenticates a user when their client IP matches a configured IP
wildcard rule. Administrators define IP Wildcard config entities that map an IP pattern to a user
account; when a request's client IP matches, the module calls `user_login_finalize()` to establish a
full authenticated session — like `ip_login`, this is a trusted-network / kiosk auto-login mechanism.
It is configured at the IP Wildcard collection and provides its own permissions.

**Security is the central consideration** (identical in nature to `ip_login`):
- **It grants a full session by source IP.** Only use it for genuinely trusted, controlled networks.
- **Shared IPs are dangerous.** In NAT/CGNAT/office/VPN environments many people share one public IP;
  everyone from that IP is logged in as the mapped account. Never map an IP shared by untrusted users,
  and never map a high-privilege account on a shared network.
- **It relies on correct reverse-proxy configuration.** The module reads `$request->getClientIp()`,
  which honours Drupal's trusted-proxy settings and does not blindly trust `X-Forwarded-For`. But if
  the site sits behind a proxy/CDN and `settings.php` is misconfigured to trust all proxies, an
  attacker can spoof `X-Forwarded-For` and impersonate any mapped user — configure
  `reverse_proxy`/`trusted_hosts` correctly first.
Within those constraints it is a legitimate convenience; outside them it is an authentication-bypass
foot-gun. The risk lives in deployment/configuration, which the adopter owns.

---

- Auto-login a user by client IP.
- Match IP wildcard rules to accounts.
- Log in without a password on trusted networks.
- Define IP Wildcard config entities.
- Use for kiosks/trusted office IPs.
- Avoid mapping shared/NAT IPs.
- Never map admin accounts on shared networks.
- Rely on correct trusted-proxy config.
- Know getClientIp honours trusted proxies.
- Prevent X-Forwarded-For spoofing via config.
- Grant a full session on match.
- Configure via the IP Wildcard collection.
- Provide its own permissions.
- Treat it as trusted-network auth only.
- Understand it's an auth-bypass risk if misused.
- Map only trusted IPs to users.
- Establish a session via user_login_finalize.
- Restrict to controlled devices.
- Own the deployment/config risk.
- Compare with ip_login's model.
