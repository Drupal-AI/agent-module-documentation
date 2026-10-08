<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badgr API service (BadgrService)

Service id `badgr_badge.service`, class `Drupal\badgr_badge\BadgrService` implements
`BadgrServiceInterface`. Args: `@current_user`, `@http_client` (Guzzle), `@entity_type.manager`,
`@logger.factory`. All calls target fixed `https://api.badgr.io` endpoints and pass
`'verify' => TRUE` (TLS verification on).

## Endpoint constants
- `TOKEN_API` = `/o/token`
- `USER_AUTHENTICATE_API` = `/v2/users/self`
- `ISSUERS_API` = `/v2/issuers`
- `BADGECLASS_API` = `/v2/badgeclasses`

## Auth methods
- `initiate(array $post_details): ?array` — POST `form_params` (`username`/`password`) to
  `TOKEN_API`; returns decoded token payload (or the error body on a request exception).
- `refreshToken(string $refresh_token): ?array` — POST `grant_type=refresh_token`; returns new
  token payload; logs on failure.
- `setHeader(string $access_token): array` — builds `Authorization: Bearer <token>` + JSON headers.
- `userAuthenticate(string $access_token): bool` — GET `USER_AUTHENTICATE_API`; TRUE when
  `data['status']['success']`.
- `reauthenticateToken(string &$access_token, string $badgr_account_id): void` — loads the
  `badgr_account` node, reads `field_badgr_refresh_token`, calls `refreshToken()`, and **persists**
  the new `field_badgr_access_token` / `field_badgr_refresh_token` back to the node.
- `ensureAuthenticated()` (protected) — every data call runs this first: if `userAuthenticate()`
  fails it calls `reauthenticateToken()`.

## Data methods
- `createIssuer()`, `updateIssuer()` (GET/PUT/DELETE), `listAllIssuers()`,
  `listAllExistingIssuers()` (returns `[entityId => name]`).
- `createIssuerBadges()`, `listAllBadges()`, `listAllExistingBadges()` (grouped by issuer),
  `updateBadges()` (GET/PUT/DELETE).
- `awardBadges(&$access_token, $post_details, $entity_id, $badgr_account_id)` — POST to
  `BADGECLASS_API/{entity_id}/assertions` (award a badge assertion).
- `getAwardedBadges(&$access_token, $badgr_account_id, $entity_id, $recipient)` — GET assertions
  filtered by `recipient` email (used to detect an already-awarded badge before issuing).

Shared `apiRequest($method, $url, $options)` (protected) decodes the JSON body and logs
`RequestException` messages to channel `badgr_badge`. `updateIssuer()`/`updateBadges()` only attach
`form_params` for `PUT` with non-empty details and otherwise fall back to `GET`.
