Ban lets administrators block visits to a Drupal site from individual IP addresses; banned IPs get a plain 403 response very early in the request, and an optional settings.php allowlist protects chosen IPs/subnets from ever being banned.

---

This is the contrib continuation of Drupal's former core Ban module (project `drupal/ban`,
machine name `ban`). Banned IPs are stored in a dedicated database table `ban_ip` (columns `iid`,
`ip`) and managed through the `ban.ip_manager` service (`BanIpManager`, `backend_overridable`),
which offers `banIp()`, `unbanIp()`, `isBanned()`, `findAll()`, `findById()`, and
`unbanAllIps()`. A registered HTTP middleware (`ban.middleware`, priority 250 so it runs before
page cache) checks the client IP on every request and returns a 403 for banned addresses. Admins
manage the list at **Configuration → People → IP address bans** (`/admin/config/people/ban`,
permission `ban IP addresses`), which lists banned IPs, adds new ones (single IPv4/IPv6 only —
subnet ranges are intentionally not supported for performance), and unbans single or multiple
addresses. An **allowlist** is defined only in `settings.php` via `$settings['ban_allowlist']`
(single IPs or CIDR subnet ranges, IPv4 or IPv6); those addresses can never be banned. CLI
commands (`ban:ban`, `ban:unban`, `ban:list`, `ban:flush`) are provided as Symfony Console
commands runnable via `dr` (Drupal CLI 11.4+) or Drush (13.7+). The module also ships a Drupal 7
`blocked_ips` migration. It has no configuration object of its own (the older `ban.settings`
config was removed in `ban_update_11002`).

---

- Block a specific abusive IP address from reaching any page of the site.
- Stop a spambot or scraper hammering the site by banning its IP.
- Return a fast 403 to a malicious IP before Drupal renders or serves a cached page.
- Ban an IPv6 address as easily as an IPv4 one.
- Add an IP to the ban list quickly from the admin UI at /admin/config/people/ban.
- Unban a single previously banned IP address from the UI.
- Select and unban multiple banned IP addresses at once.
- Allowlist your office/static company IP in settings.php so it can never be accidentally banned.
- Allowlist an entire trusted subnet range (e.g. `10.0.0.0/24`) via `$settings['ban_allowlist']`.
- Ban an IP from a deploy script or cron using the `ban:ban` CLI command.
- Unban an IP non-interactively with `ban:unban` in automation.
- List all currently banned IPs from the command line with `ban:list`.
- Flush the entire ban list in one command with `ban:flush`.
- Programmatically ban an IP from custom code via the `ban.ip_manager` service.
- Check whether a given IP is currently banned via `BanIpManager::isBanned()`.
- Migrate blocked IPs from a Drupal 7 site using the bundled `d7_blocked_ips` migration.
- Override the ban backend (e.g. store bans elsewhere) by decorating the `backend_overridable` `ban.ip_manager` service.
- Prevent an admin from accidentally banning their own IP (the admin form blocks that).
- Enforce a policy of blocking known bad actors' IPs during a DDoS or abuse incident.
- Temporarily ban an IP and later remove it when the abuse stops.
- Keep the ban check cheap and early by relying on the module's high-priority HTTP middleware.
