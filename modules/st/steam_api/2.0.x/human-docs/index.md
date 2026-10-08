# Steam API — manual setup guide

**Steam API** (`steam_api`) is a developer integration module: it wraps the
official [Steam Web API](https://steamcommunity.com/dev) in a set of injectable
Drupal services, so your own code can pull data about games and players — news
items, player profiles, friend lists, ban status, and achievement/game stats —
without writing the HTTP plumbing yourself.

It provides three services, each covering one Steam API class:

- **`steam_api.news`** — game news (ISteamNews).
- **`steam_api.user`** — player summaries, friend lists, and ban/VAC status
  (ISteamUser).
- **`steam_api.userstats`** — global and per-player achievements and game stats
  (ISteamUserStats).

All three share a common base that makes a Guzzle GET request to Steam, decodes
the JSON, and caches the response (by default for 300 seconds, tunable — set the
TTL to 0 to disable caching). That caching keeps you within Steam's rate limits.

This is a **server-side integration only**. It does not log site users in, has no
Steam OpenID authentication, and exposes no public routes beyond its admin
settings form — so it has no user-facing surface of its own. To display anything,
you inject one of the services into your own block, controller, REST resource, or
View and call its methods with 64-bit SteamIDs. If you want actual "sign in with
Steam" login, that is the separate **Steam Login** module, which builds on this
one.

The only configuration it needs is your Steam Web API key. The key is stored in
the module's configuration (in plaintext, as is normal for a service credential),
is only ever sent to Steam as a query parameter, and is redacted from any logged
error messages.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command and enabling the
   module.
2. [Configuration](configuration/index.md) — entering your Steam API key and
   tuning the cache.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Steam API**
(`/admin/config/services/steam_api`, route `steam_api.settings`), gated by the
**Administer site configuration** permission.

## How to use it

The module surfaces its features only through code. Inject a service — for example
`steam_api.user` — into your own class and call a getter such as
`getPlayerSummaries('76561198000000000')` (SteamIDs can be a comma-separated list
for batch lookups). Use that to build things like a block showing a player's
avatar, a landing page listing latest game news, or a profile enriched with Steam
data.
