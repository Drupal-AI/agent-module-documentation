<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Restrict route by IP limits chosen Drupal routes to an allowlist of IP addresses, so an administrative or sensitive path is only reachable from approved networks. Rules are configuration entities: pick a route (by name, path, wildcard, or regex), list the allowed IPs or ranges, enable it.

---

Network restriction is a layer that permissions cannot provide: a stolen administrator password is worth much less if `/user/login` or `/admin` only answers from the office range and the VPN. It is standard practice for admin interfaces, staging environments, webhook receivers, and anything whose audience is known by location rather than by identity. The usual — and stronger — place for it is the web server or the CDN, where a rule is enforced before PHP runs, costs nothing, and cannot be bypassed by an application bug. This module puts the same idea inside Drupal, as `restrict_route` configuration entities at `/admin/config/system/restrict_route_by_ip` behind an `admin restrict route by ip` permission marked `restrict access: true`. That is worth having when the infrastructure is not under your control, when the rules must move with the site's exported configuration between environments, or when they must be editable without a deployment. A rule's target route can be an exact route name (`user.login`), a path (`/user/login`), a path with a `%` wildcard (`/admin/%/content`), or a `#…#` regular expression; the edit form previews every route the rule actually covers. Allowed IPs accept single addresses, CIDR (`1.2.3.0/24`), hyphen ranges, and `*` wildcards — IPv4 only. A request is allowed when the visitor's IP matches any listed entry and denied (403) otherwise. Two things decide whether the restriction is real. **The client IP must be correct**: the module reads it with Drupal's `getClientIp()`, which trusts the real connecting address and only honours `X-Forwarded-For` when `reverse_proxy` and `reverse_proxy_addresses` are set in `settings.php` — so behind a CDN or load balancer those settings must be configured, or every request looks like it comes from the proxy. And **route coverage is not capability coverage** — restricting `user.login` does not restrict the same action reached through a REST endpoint, another form, or a different route that lands in the same place, so enumerate every route that reaches what you are protecting.

---

- Restrict admin pages to an office network.
- Limit the login form to a VPN range.
- Protect a staging environment by IP.
- Restrict a webhook or payment-callback endpoint to a provider's range.
- Lock down a reports or data-export page.
- Add a network layer on top of admin permissions.
- Restrict a route to a partner's fixed addresses.
- Reduce exposure of an admin interface without touching the web server.
- Keep the IP rules in exported configuration so they deploy with the site.
- Restrict a dangerous developer route (devel, PHP, etc.).
- Allow a CIDR block for a whole subnet.
- Allow a hyphen range (`1.2.3.10-1.2.3.20`) for a small pool.
- Use a `*` wildcard (`1.2.3.*`) for a class-C network.
- Cover several routes at once with a `/path/%` wildcard rule.
- Cover routes with a regex when names and paths vary.
- Disable a rule temporarily without deleting it.
- Turn all restrictions off in one place during an incident.
- Use "disable for localhost" so local development is never locked out.
- Enable debug logging to see which IPs are being blocked.
- Add defence in depth for admin paths as one layer among several.
- Meet a security-review requirement for IP-gated admin access.
- Preview which routes a rule will affect before enabling it.
- Restrict a JSON/API route to internal callers.
- Gate a configuration page to a known set of addresses.
