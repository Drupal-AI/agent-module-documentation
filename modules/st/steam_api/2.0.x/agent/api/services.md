<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Steam API — service reference

All services extend `SteamApiBase` and share `getResponse(string $api_url, array $options): array`,
which builds `url . ?http_build_query(options.query)`, checks `cache.default` (cid
`steam_api:sha256(url)`), issues a Guzzle `GET`, JSON-decodes, caches for `cache_ttl` seconds,
and on exception logs a key-redacted message and returns `[]`. Every getter returns `[]` early
if no API key is configured.

## steam_api.user — `SteamUserInterface`
- `getPlayerSummaries(string $steamids): array` — ISteamUser/GetPlayerSummaries/v0002.
- `getFriendList(string $steamid): array` — ISteamUser/GetFriendList/v1.
- `getPlayerBans(string $steamids): array` — ISteamUser/GetPlayerBans/v1.

## steam_api.news — `SteamNewsInterface`
- ISteamNews wrapper (news for an app id).

## steam_api.userstats — `SteamUserStatsInterface`
- ISteamUserStats wrapper (player/game achievements and stats).

## Usage
```php
public function __construct(protected SteamUserInterface $steamUser) {}
$players = $this->steamUser->getPlayerSummaries('76561198000000000');
```
`steamids` accepts a comma-separated list of 64-bit SteamIDs. The API key is read from
`steam_api.settings:steam_apikey` and sent only as the `key` query param to Steam.
