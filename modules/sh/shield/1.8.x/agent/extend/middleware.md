# How the shield decides (middleware)

`Drupal\shield\ShieldMiddleware` (service `shield.middleware`, `http_middleware` tag,
priority **250** — runs before the page cache so shielded pages are never served from cache).
`handle()` evaluates bypasses in order; the first match sets `X-Shield-Status` and lets the
request through:

1. `disabled` — `shield_enable` is off.
2. `skipped (subrequest)` — not the main request.
3. `skipped (cli)` — `PHP_SAPI === 'cli'` and `allow_cli` is on.
4. `skipped (path)` — path matches per `method`/`paths` (EXCLUDE=0 / INCLUDE=1, alias-aware).
5. `skipped (http method)` — request method is in `http_method_allowlist`.
6. `skipped (ip)` — client IP matches `allowlist` (via `IpUtils::checkIp`, supports CIDR).
7. `skipped (domain)` — request host matches `domains`.

Otherwise it reads the configured credentials (provider `shield` / `key` / `multikey`),
compares against `PHP_AUTH_USER`/`PHP_AUTH_PW` (or a decoded `HTTP_AUTHORIZATION` /
`REDIRECT_HTTP_AUTHORIZATION` header) using `hash_equals` for the password. Match →
`authenticated` and the request proceeds; no/incorrect credentials → **HTTP 401** with a
`WWW-Authenticate` header and status `pending`.

`shield.response_subscriber` (`ShieldSubscriber`) sets the 401 response and greeting.
`unset_basic_auth_headers` (default on) strips the Basic Auth header before Drupal so core
`basic_auth` login doesn't collide with the shield. The `X-Shield-Status` header is only
emitted when `debug_header` is enabled.
