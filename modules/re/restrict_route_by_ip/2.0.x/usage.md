<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Restrict route by IP gates chosen Drupal routes by client IP address, so a sensitive or administrative path answers only from (or never from) the networks you name. Rules are `restrict_route` configuration entities: pick a route (by name, path, `%` wildcard, or `#…#` regex), list IPs or ranges, choose whether that list is *allowed* or *restricted*, optionally narrow it to certain HTTP methods and query parameters, and enable it at `/admin/config/system/restrict_route_by_ip`.

---

Network restriction is a layer that permissions alone cannot provide: a stolen administrator password is worth much less if `/user/login` or `/admin` only answers from the office range and the VPN. It is standard practice for admin interfaces, staging environments, webhook receivers, and anything whose audience is known by location rather than identity. The usual — and stronger — place for it is the web server or CDN, where a rule runs before PHP, costs nothing, and cannot be undone by an application bug. This module puts the same idea inside Drupal, as `restrict_route` configuration entities behind an `admin restrict route by ip` permission marked `restrict access: true`, which is worth having when the infrastructure is out of your control, when the rules must travel with the site's exported configuration, or when they must be editable without a deployment.

Each rule has two things that decide its meaning and are new or reworked in 2.0.x. First, an **Operation** mode: *Allow access* makes the IP list an **allowlist** — only the listed addresses may reach the route, everyone else gets 403; *Restrict access* makes it a **blocklist** — the listed addresses are denied and everyone else is allowed through. Pick the one that matches your intent: "lock this route to my office" is *Allow access*; "keep this one abuser out of a public page" is *Restrict access*. Second, a rule can be scoped to specific **request methods** (GET, POST, DELETE, PATCH — at least one is required) and to **URL parameters**, so the restriction engages only for matching requests. A rule's target route can be an exact route name (`user.login`), a path (`/user/login`), a path with a `%` wildcard (`/admin/%/content`), or a `#…#` regular expression; the edit form previews every route a rule actually covers. Allowed IPs accept single addresses, CIDR (`1.2.3.0/24`), hyphen ranges, and `*` wildcards — IPv4 only (ranges use `ip2long()`; an IPv6 address only matches by exact string equality).

Two operational facts determine whether the restriction is real. **The client IP must be correct**: the module reads it with Drupal's `getClientIp()`, which trusts the real connecting address and only honours `X-Forwarded-For` when `reverse_proxy` and `reverse_proxy_addresses` are set in `settings.php` — so behind a CDN or load balancer those settings must be configured, or every request looks like it comes from the proxy. And **route coverage is not capability coverage** — restricting `user.login` does not restrict the same action reached through a REST endpoint, another form, or a different route that lands in the same place, so enumerate every route that reaches what you are protecting and use the live "Impacted routes" preview to confirm coverage before enabling.

---

- Lock admin pages to an office network (Allow access + office range).
- Limit the login form to a VPN range.
- Protect a staging environment by IP.
- Restrict a webhook or payment-callback endpoint to a provider's range.
- Lock down a reports or data-export page.
- Add a network layer on top of admin permissions.
- Restrict a route to a partner's fixed addresses.
- Block a specific abusive IP or range from a public route (Restrict access + that range).
- Reduce exposure of an admin interface without touching the web server.
- Restrict a dangerous developer route (devel, PHP, etc.).
- Allow a whole subnet with a CIDR block (`1.2.3.0/24`).
- Allow a small pool with a hyphen range (`1.2.3.10-1.2.3.20`).
- Use a `*` wildcard (`1.2.3.*`) for a class-C network.
- Cover several routes at once with a `/path/%` wildcard rule.
- Cover routes with a `#…#` regex when names and paths vary.
- Scope a rule to only POST requests (e.g. form submission) via the methods field.
- Narrow a rule to requests carrying a particular URL parameter.
- Disable a rule temporarily without deleting it.
- Turn all restrictions off in one place during an incident (global status).
- Use "disable for localhost" so local development is never locked out.
- Enable debug logging to see which IPs are being denied.
- Add defence in depth for admin paths as one layer among several.
- Meet a security-review requirement for IP-gated admin access.
- Preview which routes a rule will affect before enabling it.
- Restrict a JSON/API route to internal callers.
- Keep IP rules in exported configuration so they deploy with the site.
