Submodule of AbuseIPDB that plugs Drupal core's Ban module in as AbuseIPDB's ban backend.

---

`abuseipdb_core_ban` registers one tagged service, `abuseipdb_core_ban.ban_manager`
(`CoreBanAbuseipdbBanManager`, tag `abuseipdb_ban_manager`), that implements the parent module's
`AbuseipdbBanManagerInterface` on top of core's `ban.ip_manager` (`Drupal\ban\BanIpManager`). Once
enabled, "Ban (Core)" appears in the Ban Manager dropdown on `/admin/config/services/abuseipdb`;
selecting it makes every AbuseIPDB ban (form check, path check, path report, manual report) add the
IP to core's ban list, blocking it from the site. The submodule has no config, no routes, and no
permissions of its own; uninstalling it resets the parent's `ban_manager` back to `- None -` if it
was the active backend. This is the backend the README recommends for basic setups.

---

- Use Drupal core's Ban module as the enforcement backend for AbuseIPDB (no extra contrib module).
- Select "Ban (Core)" as the Ban Manager on the AbuseIPDB settings form to route all bans through core Ban.
- Permanently block IPs that AbuseIPDB flags as abusive using core's ban list.
- Automatically ban abusive form submitters via core Ban when Form Check "Ban IP" is enabled.
- Ban IPs that hit checked paths through core Ban when Paths Check "Ban IP" is enabled.
- Ban IPs that hit blacklisted/report paths through core Ban when Paths Report "Ban IP" is enabled.
- Ban an IP through core Ban at the moment you manually report it on the Report tab.
- Let AbuseIPDB answer `isBanned()` checks against core's ban list via `BanIpManager::isBanned()`.
- Manage the resulting bans in the standard core Ban UI at `/admin/config/people/ban`.
- Swap ban backends without code by choosing between None, Ban (Core), and Advanced ban.
- Cleanly reset the ban manager to None on uninstall so no dangling backend reference remains.
