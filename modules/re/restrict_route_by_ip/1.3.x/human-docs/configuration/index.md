# Configuration

All the work happens on the **Restrict route by IP** listing at
**Configuration → System → Restrict route by IP**
(`/admin/config/system/restrict_route_by_ip`). Each entry there is a *route
restriction* — a named rule pairing one or more routes with a set of allowed IP
addresses.

## Read this first — two ways to get it wrong

**Lockout risk.** If you restrict a route such as the login form or `/admin` and
your own current IP is *not* in the allowed set, you will lock yourself out of the
page you just protected. Before restricting an authentication or admin path,
confirm your own address is included, and make sure you have a fallback — Drush
access to the server, or the ability to edit or delete the restriction from a
machine on an allowed network. A restriction can be **disabled** rather than
deleted, which is a quick way to recover.

**The client IP must be correct.** Drupal reads the visitor's address with
`getClientIp()`. Behind any CDN or load balancer that returns the *proxy's*
address unless you have configured `reverse_proxy` and `reverse_proxy_addresses`
in `settings.php`. If those are not set, the module is effectively trusting the
`X-Forwarded-For` header — which the caller can write — and your allowlist can be
spoofed. Set up trusted reverse-proxy handling in core *before* relying on IP
restrictions in production.

One more thing to keep in mind: **route coverage is not path coverage.**
Restricting `user.login` does not restrict the same functionality reached through
a REST endpoint, a URL alias, or a different route that lands in the same place.
Enumerate everything that reaches the thing you are protecting.

## Add a route restriction

Click **Add** on the listing. A form asks you to define:

- **Label / name** — a human-readable name so you can recognise the rule in the
  list later.
- **Routes** — which routes the rule applies to. You can specify them by:
  - **route name** (for example `user.login`),
  - **path** (for example `/admin/reports`),
  - **path with a wildcard**, using `%` for a segment (for example
    `/admin/%/content`),
  - a **regular expression** for more complex matching.
  Use the **preview of impacted routes** to confirm the rule matches what you
  expect — and only what you expect — before saving.
- **Allowed IP addresses** — the addresses permitted to reach those routes. Each
  entry can be a single IP, a hyphenated range (`192.0.2.10-192.0.2.20`), a
  wildcard (`192.0.2.*`), or CIDR notation (`192.0.2.0/24`). Requests from any
  other address are denied.

## Enable, disable, or remove a rule

Each restriction can be turned off without being deleted — useful for temporarily
lifting a rule (for example to recover from a lockout) or for testing. You can
also remove a restriction entirely when it is no longer needed.

## Save

Save the restriction and it takes effect for matching routes. Test from an allowed
address (you should reach the route) and, if you can, from a disallowed one (you
should be denied) to confirm the rule behaves as intended.
