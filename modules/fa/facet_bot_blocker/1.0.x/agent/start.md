# Facet Bot Blocker — agent index

Blocks requests whose `f[]` facet query array reaches a configured depth, returning 403 (or
410) early from a kernel REQUEST subscriber. Sitewide; no Views/Facets wiring needed.

- **Settings keys, the config object, the block decision, and the dashboard** →
  [configure/settings.md](configure/settings.md)
- **The three permissions (administer / dashboard / bypass)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `facet_bot_blocker.settings`. Keys: `facets_bot_blocker_limit` (int, default 1),
  `facet_bot_blocker_return_gone` (bool → 410 vs 403), `facet_bot_blocker_html` (string).
  **No config ships by default** and there is no config schema — `get()` is null until saved.
- Blocking is `isset($_GET['f'][$limit])`: with limit N, a request carrying `f[N]` is blocked.
- Config UI: `/admin/config/system/facet-bot-blocker` (route `facet_bot_blocker.settings_form`).
  Dashboard: `/admin/reports/facet-bot-blocker` (counters only populated if Memcache or Redis is on).
- `bypass facet bot blocker` permission exempts a user; subscriber runs at priority 101.
