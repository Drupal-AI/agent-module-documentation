<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Steam API (steam_api) — agent index

**Injectable Drupal services wrapping the Steam Web API (ISteamNews / ISteamUser / ISteamUserStats).**

- **Version:** 2.0.x
- **Core:** ^10 || ^11 || ^12
- **Package:** steam
- **Configure:** `/admin/config/services/steam_api` (`steam_api.settings`, `_permission: administer site configuration`).
- **Services:** `steam_api.news`, `steam_api.user`, `steam_api.userstats` (all extend `SteamApiBase`; args: http_client, config.factory, logger.factory, cache.default).
- **Config keys:** `steam_apikey`, `cache_ttl` (default 300; 0 disables).
- **Caching:** `cache.default`, cid `steam_api:<sha256(url)>`.

**Security:** server-side integration only — NO Steam OpenID / user login and NO auth flow, so no authentication-assertion or auth-bypass surface exists (the module never calls user_login_finalize). Only route is the admin settings form gated by `administer site configuration`. The Steam API key is stored plaintext in `steam_api.settings` config (typical for a service credential, admin-only) and is redacted from logged errors (`SteamApiBase.php` getResponse catch). No anonymous or mutating endpoints.

See [api/services.md](api/services.md).
