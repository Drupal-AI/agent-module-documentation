<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eWeLink — the `pjanisio/ewelink-api-php` library integration

All eWeLink cloud communication is delegated to the Composer library `pjanisio/ewelink-api-php` (`^3`, namespace `pjanisio\ewelinkapiphp`). The Drupal module never talks to the CoolKit HTTP API directly; it instantiates the library's classes. This doc summarises the parts the module uses so an agent need not read the vendor source.

## Classes the module uses
- `HttpClient` — entry point; instantiated as `new HttpClient()` (constructor accepts an optional `array $configOverrides`, which the module does not pass). On construction it validates config via `Utils::validateConfig()` and, on invalid config, echoes the errors and `exit`s. Provides `getToken()`, `getDevices()`, `getLoginUrl()`, `getGatewayUrl()`, `postRequest()`, `getRequest()`.
- `Token` — OAuth token lifecycle: `getToken()` (authorization-code exchange, POST `/v2/user/oauth/token`), `refreshToken()` (POST `/v2/user/refresh`, grant `refresh_token`), `checkAndRefreshToken()`, `getAccessToken()`, `getTokenData()`, `clearToken()`, `redirectToUrl()`. Tokens are loaded from and written to `token.json` in `JSON_LOG_DIR` (`writeTokenFileIfChanged()`).
- `Devices` — device operations; the module calls `setDeviceStatus($deviceId, $params, $index = 0)` (e.g. `['switch' => 'on', 'outlet' => 0]`) and `getDevicesList()`.
- `Constants`, `Config`, `Utils`, `Home` — support classes (region gateways, config resolution, signing, family data).

## Config resolution order (`Config::load()`)
Merged as **overrides > `config.json` > `Constants.php` fallback** (`array_merge(fallbackConfig(), json, overrides)`). Keys: `APPID`, `APP_SECRET`, `REDIRECT_URL`, `EMAIL`, `PASSWORD`, `REGION`, `DEBUG`, `JSON_LOG_DIR`.
- `Constants.php` ships placeholder values (`your_app_id`, `your_app_secret`, `your_region`, …), so out of the box `validateConfig()` fails and `HttpClient` bails.
- Since the Drupal module passes **no** overrides, real credentials must live in the library's `Constants.php` (or a `config.json` under `JSON_LOG_DIR`, which defaults to the library directory, `Constants::JSON_LOG_DIR = __DIR__ . '/..'`). The Drupal `ewelink.settings` values are not fed to the library in this release (see [`../config/settings.md`](../config/settings.md)).

## Regional gateways (`HttpClient::getGatewayUrl()`)
`cn` → `https://cn-apia.coolkit.cn`; `as` → `https://as-apia.coolkit.cc`; `us` → `https://us-apia.coolkit.cc`; `eu` → `https://eu-apia.coolkit.cc`. OAuth login URL is built by `createLoginUrl($state)` → `https://c2ccdn.coolkit.cc/oauth/index.html?…` with `clientId`, `authorization` (HMAC sign of `APPID_seq` with `APP_SECRET`), `seq`, `redirectUrl`, `nonce`, `state`, `grantType=authorization_code`.

## Request mechanics
`postRequest()` / `getRequest()` build headers (`X-CK-Appid`, `X-CK-Nonce`, and either `Authorization: Bearer <accessToken>` for token-auth calls or `Authorization: Sign <hmac>` for app-signed calls) and perform the HTTP call with `file_get_contents()` over a `stream_context_create()` context (standard PHP HTTPS streams). Responses are `json_decode`d; a non-zero `error` throws, and `error === 401` clears the token and redirects to the login URL. When `Constants::DEBUG === 1` the library writes a `debug.log`.

## Dependencies
`pjanisio/ewelink-api-php` requires PHP `>=7.4` (matches the module's `composer.json`). It also bundles WebSocket support (`WebSocketClient`), which the Drupal module does not use.
