<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Basic Firewall evaluates every incoming request against configurable allow/challenge/block rules before routing, sessions, authentication and the page cache run, so rejected traffic is cheap to serve.

It registers an HTTP middleware (`http_middleware.basic_firewall`, priority 280 — after the reverse-proxy middleware so the client IP is trustworthy, before page_cache so cache hits are still firewalled) that runs the compiled rule set server-side; enforcement cannot be bypassed from the client. Rules are stored as Drupal configuration and compiled into a file in the private directory (a rebuildable cache). Rule types are plugins: IP address, user agent, URL, ASN, GeoLocation, rate limit, CRS/vulnerability score, and AbuseIPDB. A role-bypass path defers evaluation to REQUEST priority 290 (just below authentication) so trusted roles can be exempted. The firewall can be switched off per environment with `$settings['basic_firewall_enabled'] = FALSE;` in settings.php.

All administrative routes under `/admin/config/system/basic-firewall` require `administer basic firewall` (a restricted permission); the dashboard and blocked-client list also honour `view basic firewall reports`, and releasing a client needs `unblock basic firewall clients`. Drush commands `basic-firewall:rebuild`, `basic-firewall:status` and `basic-firewall:rules` cover CI/ops tasks. Rules export with `drush config:export` and travel between environments like any other config.
---
Configure the firewall, its rules, storage, logging, challenge flow and presets from the admin UI, or manage it via Drush.
---
- Block a single IP address or CIDR range from reaching the site
- Allow-list an office or CDN IP so it is never challenged
- Rate-limit requests per client to blunt brute-force and scraping
- Block requests by user-agent string (bad bots, scanners)
- Block or allow requests to specific URL patterns
- Restrict access by country using a GeoLocation rule
- Block traffic from an entire ASN
- Score requests against a Core Rule Set / vulnerability heuristic
- Consult AbuseIPDB reputation before allowing a request
- Reorder rules by weight so allow rules win over block rules
- Exempt a trusted Drupal role from firewall evaluation
- Import a preset rule bundle shipped with the module
- Test how a hypothetical request would be evaluated before going live
- View the compiled configuration the firewall actually reads
- Rebuild the compiled config after editing rules (`drush bfw:rebuild`)
- Review the list of currently blocked clients
- Unblock a client that was blocked in error
- Report the firewall's runtime state with `drush bfw:status`
- List all configured rules with `drush bfw:rules`
- Disable the firewall on a local/dev environment via settings.php
- Send firewall events to a dedicated logger channel
- Export firewall rules as configuration for deployment
- Choose a storage backend for blocked-client state