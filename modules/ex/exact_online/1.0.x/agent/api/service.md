<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# exact_online.service API

`Drupal\exact_online\Service\ExactOnlineService` (`src/Service/ExactOnlineService.php`),
service id `exact_online.service`, implements `ExactOnlineServiceInterface`. This is the
entry point custom sync code should use. Constructor args (in `exact_online.services.yml`):
`config.factory`, `state`, `logger.factory`, `messenger`, `cache.default`, `datetime.time`,
`string_translation`, `request_stack`, `current_user`.

## The Connection

`getConnection(): \Picqer\Financials\Exact\Connection` lazily builds and caches a picqer
`Connection`, configured from stored settings:
- `setRedirectUrl(callback_url . '/exact-online/callback')`
- `setExactClientId(config client_id)`
- `setExactClientSecret(state exact_online.client_secret)`
- `setDivision(division)` if set
- `setBaseUrl(base_url)` if set
- `setWaitOnMinutelyRateLimitHit(TRUE)` — auto-sleeps on minutely rate-limit hits
- then `restoreTokens()` loads any stored tokens onto the connection.

Custom integration code typically calls `\Drupal::service('exact_online.service')->getConnection()`
and then uses picqer entity classes against it.

## OAuth2 methods

- `getAuthorizationUrl(): string` — returns `getConnection()->getAuthUrl()` (Exact's
  authorization-code URL). Used by the authorize route.
- `handleCallback(): bool` — reads `code` from the current request, `setAuthorizationCode()`,
  `connect()`, then `updateAndStoreTokens()`. Throws on missing code / null access token.
- `getConnectionStatus(): bool` — TRUE if a refresh token exists and (refreshing if the
  access token is expired) the connection is usable; on failure it deletes tokens + clears
  rate limits and returns FALSE.
- `resetConnection(): bool` — `deleteTokens()` + `clearApiRateLimits()`.

## Token lifecycle (interface-internal)

Tokens are stored in State `exact_online.tokens` as `access_token` / `refresh_token` /
`expires_in`:
- `updateAndStoreTokens()` (protected) — if expired, re-`connect()` using the stored refresh
  token, then saves the refreshed tokens; on a 401 it deletes the tokens.
- `restoreTokens()` / `deleteTokens()` (protected) — copy tokens between State and the
  Connection.
- `getTokenExpirationDetails(): array` — `status` is `valid` / `expiring_soon` (≤ 9 min left)
  / `expired` / `unknown` / `error`, plus `expires_at`, `remaining_hours`, timestamps.
  Access tokens last ~10 min; refresh tokens ~30 days (per Exact docs cited in source).

## Rate limits

`checkApiRateLimits()` / `setApiRateLimits()` read the picqer connection's daily & minutely
limit counters into State `exact_online.api_rate_limits.*` and throw a `RuntimeException`
when a remaining count is zero. `clearApiRateLimits()` deletes them. Note the `@todo` in
`setApiRateLimits()`: the picqer counters are only populated after a first real API call.

## Logging

`getLogs(array $filters)` / `getRecentLogs(int $limit = 10)` read State `exact_online.logs`,
supporting `type`, `start_date`, `end_date`, `limit` filters (sorted newest first). Internally
`logInfo()` / `logError()` write both to the `exact_online` logger channel and to the State
log via `addLogEntry($type, $message)` (records timestamp, type, message, current user id;
keeps the last 1000).

## Token-expiration notifier

`Drupal\exact_online\Service\TokenExpirationNotifier` (`exact_online.token_expiration_notifier`):
`checkAndNotify()` emails `system.site:mail` when `getTokenExpirationDetails()` is
`expiring_soon` (throttled to once per 24 h via State `exact_online.last_expiration_notification`).
Caveats grounded in source: the module ships **no** `hook_mail`/`.module` file and **no**
cron hook, so `mail('exact_online','token_expiration', …)` has no template and
`checkAndNotify()` is never invoked automatically — call it from your own code/cron if needed.
