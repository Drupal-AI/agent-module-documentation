<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Restrict Login Page by IP restricts access to the user login page based on the visitor's IP address, using an allow-list of IPs/CIDR ranges.

---

Restrict Login Page by IP restricts access to the user login page to an administrator-configured
allow-list of IP addresses/ranges (CIDR) — so the login form is only reachable from approved networks
(e.g. an office/VPN), reducing exposure of the login endpoint to the internet and blunting credential-
stuffing/brute-force from other locations. Its access check allows access when no ranges are configured
(feature off until set), denies as a precaution if the request is unavailable (fail-closed), and otherwise
allows only matching client IPs. It depends on core User and is configured at `restrict_login_ip.settings`.

Use it to lock the login page to trusted networks. Security notes: it uses `$request->getClientIp()`, which
is the correct API (it honours Drupal's trusted-proxy settings and doesn't blindly trust `X-Forwarded-For`)
— **but** if the site is behind a proxy/CDN and `settings.php` is misconfigured to trust all proxies, an
attacker could spoof `X-Forwarded-For` to appear to be on an allowed IP and bypass the restriction, so
configure `reverse_proxy`/`trusted_hosts` correctly first. Also keep at least one allowed path/network for
yourself so you don't lock out all admins, and remember it restricts the *login page*, not other
authentication routes — confirm all login entry points are covered.

---

- Restrict the login page by IP.
- Allow login only from approved IPs/ranges.
- Reduce login-endpoint exposure.
- Blunt credential-stuffing from other IPs.
- Use CIDR allow-list.
- Allow when no ranges set (off until configured).
- Deny as a precaution if request unavailable (fail-closed).
- Use getClientIp (honours trusted-proxy config).
- Configure reverse_proxy/trusted_hosts first.
- Prevent X-Forwarded-For spoofing via correct proxy config.
- Keep an allowed network for admins.
- Avoid locking out all admins.
- Depend on core User.
- Configure at restrict_login_ip.settings.
- Confirm all login entry points are covered.
- Lock login to office/VPN.
- Restrict login access.
- Allow only matching client IPs.
- Reduce brute-force surface.
- Gate the login page by IP.
