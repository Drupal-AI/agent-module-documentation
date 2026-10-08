<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Steam API wraps the Steam Web API in injectable Drupal services for retrieving game news, player profiles, friends, ban status and game/achievement stats.

---

The module exposes three services — `steam_api.news` (ISteamNews), `steam_api.user` (ISteamUser: player summaries, friend lists, ban status) and `steam_api.userstats` (ISteamUserStats) — all extending a common `SteamApiBase` that performs Guzzle GET requests, decodes JSON and caches responses. Responses are cached in `cache.default` under a `steam_api:<sha256(url)>` key for the configured TTL (default 300s, set 0 to disable). It is a server-side integration only: there is no user login, no Steam OpenID authentication, and no public routes beyond the admin settings form — so it does not authenticate site users and carries no auth-bypass surface.

Configure it at `/admin/config/services/steam_api` (route `steam_api.settings`, gated by `administer site configuration`): enter your Steam Web API key and the cache TTL. The API key is stored in the `steam_api.settings` config object (plaintext, as is typical for a service credential) and is only ever sent to Steam as a query parameter over the Guzzle client; it is redacted from any logged error messages. Consume the services from your own code via dependency injection, passing 64-bit SteamID(s) to the getter methods.

---
- Fetch news items for a Steam application/game id.
- Retrieve player summaries (profile data) for one or more SteamIDs.
- Get a player's friend list by SteamID.
- Look up VAC/ban status for players.
- Retrieve a player's achievements for a game.
- Retrieve global or per-player game stats.
- Cache Steam responses to stay within API rate limits.
- Tune the cache TTL, or disable caching by setting it to 0.
- Store the Steam Web API key via the admin settings form.
- Inject `steam_api.user` into a custom block to show a player's avatar.
- Build a Drupal view/controller that lists a clan's members' statuses.
- Display latest game news on a landing page.
- Show achievement progress for a linked Steam account.
- Enrich user profiles with Steam profile data.
- Wrap the services in a custom REST resource for a decoupled frontend.
- Log and monitor Steam API errors (key is auto-redacted in logs).
- Batch-fetch player summaries by passing comma-separated SteamIDs.
- Restrict the settings form to site administrators only.
