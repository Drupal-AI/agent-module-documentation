Submodule of AbuseIPDB that plugs the Advanced ban (advban) module in as AbuseIPDB's ban backend.

---

`abuseipdb_advban` registers one tagged service, `abuseipdb_advban.ban_manager`
(`AdvbanAbuseipdbBanManager`, tag `abuseipdb_ban_manager`), that implements the parent module's
`AbuseipdbBanManagerInterface` on top of the Advanced ban module's `advban.ip_manager`. Once enabled,
"Advanced ban" appears in the Ban Manager dropdown on `/admin/config/services/abuseipdb`; selecting
it makes every AbuseIPDB ban (form check, path check, path report, manual report) go through
Advanced ban's IP manager, which supports features such as temporary/expiring bans. The submodule
has no config, no routes, and no permissions of its own; uninstalling it resets the parent's
`ban_manager` back to `- None -` if it was the active backend.

---

- Use the Advanced ban module (temporary/expiring IP bans) as the enforcement backend for AbuseIPDB.
- Select "Advanced ban" as the Ban Manager on the AbuseIPDB settings form to route all bans through advban.
- Apply time-limited bans to IPs that AbuseIPDB flags as abusive instead of permanent core bans.
- Automatically ban abusive form submitters via Advanced ban when Form Check "Ban IP" is enabled.
- Ban IPs that hit checked paths through Advanced ban when Paths Check "Ban IP" is enabled.
- Ban IPs that hit blacklisted/report paths through Advanced ban when Paths Report "Ban IP" is enabled.
- Ban an IP through Advanced ban at the moment you manually report it on the Report tab.
- Let AbuseIPDB answer `isBanned()` checks against Advanced ban's ban list (supports its bool/array return).
- Swap ban backends without code by choosing between None, Core Ban, and Advanced ban.
- Keep Core Ban and Advanced ban integrations installable side by side and pick one at runtime.
- Cleanly reset the ban manager to None on uninstall so no dangling backend reference remains.
