<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Token Authentication registers a global authentication provider that logs a request in as the token's owner (or a configured stub user) when a valid token is presented.

Use it for simple API/machine access where you want short-lived or single-use tokens issued per user, without the weight of OAuth. Tokens can be time-based (TTL) or one-time.

- Global `authentication_provider` (priority 100) reading `X-ACCESS-AUTH-TOKEN`.
- Tokens generated as `hash('sha256', bin2hex(random_bytes(64)))` — high entropy.
- Time-based (configurable TTL 30–1800s) or one-time authentication modes.
- Users manage/invalidate their own tokens; admins can invalidate any.
- Pluggable token managers via a service-collector tag; DB-backed default manager.
- Page cache disabled for token requests (own request policy) to avoid leaks.

---

Install and configure:

- Enable `drush en access_token_auth`; visit `/admin/config/services/access-token-auth`.
- Grant restricted permissions carefully: `administer access_token_auth configuration`, `allow generate access_token_auth`, `access own access_token_auth list`, `invalidate own/any access_token_auth`, `access any access_token_auth`.
- Choose mode (time based / one time), TTL, single-token, and expired-token cleanup (via cron).
- Optionally enable a stub user to authenticate all tokens as one service account.
- Generate a token from the settings form; copy it (only last 4 chars are shown afterwards).

---

- Authenticate by sending header `X-ACCESS-AUTH-TOKEN: <token>` on any request.
- A query parameter of the same name is also accepted (avoid it — tokens then leak into logs/referrers).
- Each validation marks the token used and logs the event.
- In one-time mode, a token is rejected after first use; in time-based mode, after `expire_at`.
- `create_single_token` reuses an existing valid token instead of minting a new one.
- Users list their valid tokens at `/admin/config/services/access-token-auth/list`.
- Invalidate a token via the confirm form; `full_invalidate` also back-dates `expire_at`.
- `getTokenById()` scopes to the current user unless they hold `access any access_token_auth`.
- Cron deletes expired/used tokens when `delete_expired_tokens` is on.
- The stub-user option makes every token authenticate as one chosen account.
- Tokens are stored in the `access_token_auth` table (token, user_id, expire_at, used_status).
- Custom token managers implement `TokenManagerInterface` and are tagged `access_token_auth.token_manager`.
- The `DisallowAccessTokenRequests` policy prevents cached pages for token requests.
- Prefer the header over the query param, and keep TTLs short.
- Serve only over HTTPS so tokens are not sniffable in transit.
