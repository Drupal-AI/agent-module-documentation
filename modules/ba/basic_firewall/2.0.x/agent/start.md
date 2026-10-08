<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Firewall (basic_firewall) — agent index

**Server-side request firewall**: an HTTP stack middleware (priority 280, after reverse-proxy, before page cache) evaluates allow/challenge/block rule plugins against every request before routing and authentication.

**Version:** 2.0.x (2.0.0-beta1). Core: `^11.2 || ^12`. Depends on core `user`.

Key routes: dashboard `basic_firewall.dashboard` at `/admin/config/system/basic-firewall`; rules, settings, storage, logging, challenge, presets, advanced (YAML), test, compiled, blocked, unblock, rebuild — all under that path. Permissions: `administer basic firewall` (restricted), `view basic firewall reports`, `unblock basic firewall clients` (restricted). Config object `basic_firewall.settings`; rule types are `basic_firewall_rule_type` plugins (IpAddress, UserAgent, Url, Asn, GeoLocation, RateLimit, Crs, VulnerabilityScore, AbuseIpdb). Drush: `basic-firewall:rebuild|status|rules` (aliases `bfw:*`). Kill switch: `$settings['basic_firewall_enabled'] = FALSE;`.

**Security:** all admin routes permission-gated (two of three permissions marked `restrict access`); enforcement runs server-side in a middleware ahead of the page cache, so it is not client-bypassable. No anonymous or mutating endpoints. No TLS-disabled outbound calls found.

See [configure/firewall.md](configure/firewall.md) and [drush/commands.md](drush/commands.md).