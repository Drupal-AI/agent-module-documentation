Drupal Perimeter Defence bans the IP address of any visitor who triggers a 404 ("page not found") for a URL that matches a configured list of suspicious regex patterns (e.g. `wp-admin`, `.aspx`, `.jsp`). Banning is delegated to Drupal core's Ban module.

---

The module registers a single event subscriber on the kernel `EXCEPTION` event. When a request throws a `NotFoundHttpException` (a 404), the subscriber compares the request path against the `not_found_exception_patterns` regex list in `perimeter.settings`. On a match it calls core Ban's `ban.ip_manager` service to add the client IP to the `ban_ip` table, after which core Ban returns a 403 for every subsequent request from that IP. An optional flood threshold/window lets an IP make a configurable number of matching requests before the ban actually lands (threshold `0`, the default, bans immediately). A whitelist of IPs and CIDR ranges, plus the `bypass perimeter defence rules` permission, exempt trusted clients. The module is deliberately tiny and cache-friendly: bans only fire on uncached 404 exceptions, so legitimate cached traffic is untouched. It also integrates with the Honeypot module via `hook_honeypot_reject()` to ban IPs that fail a honeypot check. Banned IPs are managed (viewed and removed) on core Ban's admin page at `/admin/config/people/ban`.

---

- Ban bots that scan for `wp-admin`, `wp-login.php`, or other WordPress paths on a Drupal site
- Ban scanners probing for `.aspx`, `.asp`, or `.jsp` files on a PHP/Linux stack
- Automatically block IPs generating floods of 404s from vulnerability scanners
- Reduce log noise and CPU load caused by automated exploit probes
- Harden a site that is actively being targeted by hackers or bots
- Add custom URL regex patterns that should trigger an instant ban
- Give offenders a grace count via a flood threshold before banning (e.g. ban on the 3rd probe)
- Limit the ban window so counters reset after a configurable time (default 1 hour)
- Whitelist office or CDN IPs / CIDR ranges so they are never banned
- Exempt trusted authenticated users with the `bypass perimeter defence rules` permission
- Delegate a security team's "URL banning patterns" management via a dedicated permission
- Delegate IP whitelist management to a separate role via its own permission
- Feed banned IPs into core Ban so they can be reviewed/unblocked in one place
- Ban IPs that fail a Honeypot form submission (spam registration/comment bots)
- Protect a fresh site launch from opportunistic mass-scan traffic
- Throttle brute-force discovery of admin or login endpoints
- Turn a curated list of "known bad" probe paths into an automatic blocklist
- Combine with `fast_404` to keep 404 handling cheap while still banning probers
- Audit who was banned and why via the `Perimeter` logger channel entries
- Quickly unban a mistakenly-banned IP with a single `drush sql:query` delete
- Roll out perimeter defence as config (patterns/whitelist/thresholds) across environments
- Block automated content-management endpoint probes (`blog_edit.php`, `my_blogs`, etc.)
- Stop `episerver` / `.NET`-targeting scanners hitting an unrelated Drupal host
- Provide a lightweight, dependency-light alternative to a full WAF for small sites
