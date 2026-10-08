<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring WalkScore

## API key
`/admin/config/services/walkscore` (`WalkScoreForm`, config `walkscore.settings`, perm
`administer walkscore`): enter the Walk Score API key (`api_key`).

## How a score is fetched
`walkscore.service` (`WalkScore::getWalkScore($location)`):
1. builds `$address` from `street`, `city`, `province`;
2. assembles a query: `wsapikey`, `address` (urlencoded), `lat`, `lon`, `format=json`;
3. GETs `https://api.walkscore.com/score?...` via the Guzzle `@http_client`;
4. on `status == 1` returns `walkscore` (0–100), else logs and returns 0.

`getScoreDescription()` / `getScoreDescriptionDetail()` map the number to labels;
`getStatusCodeDescription()` maps API status codes (invalid key, quota exceeded, IP blocked…).

## Displaying it
Add the WalkScore field (WalkScoreItem/Widget) to a bundle with a geolocation value and
set the display to WalkScoreFormatter. `printTest()` renders a sample using a fixed address.

## Notes
- Endpoint host is fixed (`api.walkscore.com`) — no user-controlled URL.
- TLS uses Guzzle defaults (verification on).
- The API key is saved in `walkscore.settings`.
