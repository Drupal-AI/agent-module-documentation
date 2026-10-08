Restrict By IP limits Drupal user login and/or the availability of specific user roles to allowed IP address ranges (CIDR notation). Restrictions can be global (all logins), per-user, or per-role, and unmatched requests fail closed.

---

The module enforces three independent allow-list layers. A **global login** list (`login_range` config) and a **per-user** list (the `restrict_by_ip_ranges` base field on the user entity) are checked at login time by `LoginFirewall`: login is allowed when the global list matches, or the user list matches, or neither is configured; otherwise it is denied. Denial is applied both as an inline error on the user login form (`validateIpRestriction`, so the user is never authenticated then bounced) and by a request `FirewallSubscriber` that logs an already-authenticated user out and redirects them to a configurable error page or the login page. A **per-role** list (`role.<role_id>` config) is enforced on every request by `RoleFirewall`/`RoleRestrictionSubscriber`: a role whose configured range does not contain the request IP is stripped from the user for that request (the `authenticated` and `anonymous` pseudo-roles are never restricted). The client IP comes from Symfony's `Request::getClientIp()`, so it respects Drupal's configured trusted reverse-proxy settings and does **not** trust a raw `X-Forwarded-For` header unless proxies are configured — the real socket IP is used by default. Ranges are validated as IPv4/IPv6 CIDR (`IPTools`); a malformed range never matches, so mistakes fail toward restriction. Other modules can add/remove ranges at runtime via `hook_restrict_by_ip_ranges_alter()` and its per-type variants. Two Drush commands (`restrict_by_ip:status`, `restrict_by_ip:allow`) inspect restrictions and recover from lockouts. The single permission, `administer restrict by ip`, is `restrict access: true` and also gates viewing/editing the per-user IP field.

---

- Allow site logins only from an office/VPN IP range site-wide.
- Restrict a specific admin account to log in only from a fixed IP.
- Let most users log in anywhere but pin privileged accounts to trusted IPs.
- Remove the `administrator` role unless the user is on the corporate network.
- Grant an "editor" role only while the user is inside an allowed IP range.
- Keep a role's permissions available on-site but revoke them off-network per request.
- Lock the login form to a list of allowed CIDR ranges (IPv4 or IPv6).
- Redirect denied logins to a custom "access denied" error page.
- Show a custom message when a login is refused because of the user's IP.
- Show a message when a role is dropped due to an IP change.
- Recover from an accidental lockout with `drush restrict_by_ip:allow <cidr>`.
- Add your current public IP to a user's allow list with `drush restrict_by_ip:allow <cidr> --user=admin`.
- Audit whether a given IP would be allowed to log in with `drush restrict_by_ip:status <ip> --user=admin`.
- List all configured global, per-user, and per-role ranges via the status command.
- Manage global ranges as configuration (config split / settings.php override friendly).
- Set per-user allowed ranges on the user edit form (admins only).
- Add office ranges from `settings.php` at runtime via `hook_restrict_by_ip_login_global_ranges_alter()`.
- Force the admin role onto the office network without configuring it in the UI (role alter hook).
- Pull allow-list ranges from an external IP database and inject them via the alter hook.
- Enforce IP restrictions correctly behind a load balancer using Drupal's trusted-proxy settings.
- Combine login and role restrictions for layered access control.
- Provide compliance evidence that admin access is IP-restricted.
