<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maintenance Exempt lets you whitelist visitors from Drupal's maintenance mode by IP address (single or CIDR range), by request path/URL, or by a secret query-string key — in addition to core's `access site in maintenance mode` permission.

---

The module overrides core's `maintenance_mode` service with `Drupal\maintenance_exempt\MaintenanceModeExempt`, which extends core `MaintenanceMode` and reimplements `exempt(AccountInterface $account)`. Core calls `exempt()` on every request while maintenance mode is on to decide whether to let the request through. The override returns `TRUE` (bypass the maintenance page) when any of these match: the account holds core's `access site in maintenance mode` permission; the client IP (`Request::getClientIp()`) is in the configured exempt IP list, or falls inside a configured CIDR range; the current request path (or its system/aliased path) matches one of the configured exempt URL patterns (`PathMatcher::matchPath`); or a configured secret query-string **key** is present in `$_GET` (which then stores the exemption in `$_SESSION` so subsequent requests in that session stay exempt). Settings live in config `maintenance_exempt.settings` (`exempt_ips`, `exempt_urls`, `query_key`, all newline-separated strings) and are edited by three extra fieldsets that the module adds to core's Maintenance-mode form (`admin/config/development/maintenance`, via `hook_form_system_site_maintenance_mode_alter`). All three exemption mechanisms are **off until an admin fills them in** — with empty config the service behaves exactly like core. There are no permissions, no plugins, no Drush; it ships only a small config schema.

---

- Let your office/VPN IP address keep browsing the site while it's in maintenance mode.
- Exempt a whole IP range (CIDR, e.g. `203.0.113.0/24`) so a whole team can preview.
- Give a client a "magic link" (`?preview` style query key) that bypasses the maintenance splash.
- Keep a health-check / uptime-monitor path reachable during maintenance via URL exemption.
- Allow a webhook or callback path to keep working while the rest of the site is down.
- Let an external status page fetch a specific path even during maintenance.
- Exempt a specific landing page (e.g. a launch teaser) while everything else is locked.
- Permit a payment-gateway return URL to complete during a maintenance window.
- Combine IP + query-key exemptions for layered "who can see the site" control.
- Persist a visitor's exemption for their whole session once they use the query key.
- Preview aliased paths during maintenance (matches both the alias and its system path).
- Let QA reach the site by IP without granting them the maintenance-access permission/role.
- Whitelist a CDN or reverse-proxy origin IP so it can warm caches during maintenance.
- Give an SEO/monitoring bot a keyed URL to crawl select pages during a deploy.
- Exempt an API endpoint path so integrations don't fail during scheduled downtime.
- Provide a temporary "back door" URL to demonstrate a fix to a stakeholder mid-maintenance.
- Scope exemptions narrowly (one path) instead of granting a role site-wide maintenance access.
- Set the exempt config from the standard core Maintenance-mode admin form (no separate UI).
- Show the current client IP on the form to make adding your own address easy.
- Override the exempt lists per environment via `settings.php` (`$config['maintenance_exempt.settings']`).
