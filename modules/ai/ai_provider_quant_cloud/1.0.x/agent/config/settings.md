<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & authentication

Config object: **`ai_provider_quant_cloud.settings`** (`config/install/…settings.yml`, schema `config/schema/…schema.yml`). Settings form: `Form\QuantCloudConfigForm` at `/admin/config/ai/quant-cloud` (route `ai_provider_quant_cloud.settings_form`, permission `administer site configuration`, appears under AI providers menu).

## Install / enable

```bash
composer require drupal/ai_provider_quant_cloud   # pulls drupal/ai, drupal/key
drush en -y ai_provider_quant_cloud
```

Requires an active Quant Cloud account (QuantCDN or QuantGov Cloud).

## Config keys

Shipped defaults (`config/install`) + schema:

- `platform` — `quantcdn` (default) or `quantgov`. Selects the dashboard base URL.
- `platforms.quantcdn.dashboard_url` / `platforms.quantgov.dashboard_url` — `https://dashboard.quantcdn.io` / `https://dash.quantgov.cloud`. Used by `AuthService` for OAuth and org listing. (Clients additionally hard-code these plus `*_staging` variants in `getDashboardUrl()`.)
- `auth.method` — `oauth` or `manual`.
- `auth.access_token_key` — id of the Key entity holding the Bearer access token.
- `auth.organization_id` — machine name of the Quant organization (segments the API path).

Written by the form but **not** in `config/install` / schema (created on first save): `model.default`, `model.temperature` (0–1, default 0.7), `model.max_tokens` (1–8192, default 1000), `advanced.timeout` (5–300 s, default 30), `advanced.enable_logging` (default TRUE), `advanced.streaming_timeout` (read by the streaming client, default 60 s).

The plugin schema `ai_provider.plugin.quant_cloud` mirrors `platform` + `auth.*` for per-provider config.

## Settings form sections (`QuantCloudConfigForm::buildForm`)

1. **Platform** — radios `quantcdn` / `quantgov` (required).
2. **Authentication** — shows OAuth connect button (or "Connected via OAuth" status + Disconnect link if already connected); an auth-method radio (`oauth` / `manual`); an **Access Token Key** select (visible/required only for `manual`, populated from `key.repository`); an **Organization** select/textfield (a select if `AuthService::getOrganizations()` returns any, else a free textfield); and a live token-validity banner from `AuthService::validateToken()`.
3. **Model Defaults** (collapsed) — default model (options from `ModelsService::getModels('chat')` with a 2-item fallback), temperature, max tokens.
4. **Advanced** (collapsed) — request timeout, enable-logging checkbox.

`submitForm()` writes `platform`, `auth.method`, `auth.access_token_key`, `auth.organization_id`, `model.default/temperature/max_tokens`, `advanced.timeout/enable_logging`.

The provider is only usable (`QuantCloudProvider::isUsable()`) when `auth.access_token_key`, `auth.organization_id` and `platform` are all set.

## Authentication paths

**Manual token:** create a Key (any provider — e.g. the env provider) holding a token generated at the Quant dashboard (Profile → Create Token), then select it as the Access Token Key. Recommended for keeping the secret out of exported config.

**OAuth2** (`Controller\OAuthController` + `Service\AuthService`), routes all under `/admin/config/ai/quant-cloud/oauth/*`, all `administer site configuration`:

- `connect` — generates a random `state`, stores it in the session, builds the callback URL, and issues a `TrustedRedirectResponse` to `{dashboard}/oauth/authorize` (params: `client_id=drupal-ai-provider`, `response_type=code`, `redirect_uri`, `state`, `scope=ai:read ai:write models:read usage:read`). Public client — no client secret / PKCE.
- `callback` — validates `state` against the session value (rejects mismatch as CSRF), exchanges the code at `{dashboard}/oauth/token` (`AuthService::exchangeCodeForToken`, `grant_type=authorization_code`), then **auto-creates Key entities** `quant_cloud_oauth_access_token` (and `quant_cloud_oauth_refresh_token` if returned) via the `config` key provider, stores token expiry in state, and sets `auth.method=oauth` + `auth.access_token_key`.
- `disconnect` — deletes those keys and resets `auth.method=manual`, `auth.access_token_key=NULL`.

All clients read the token through `key.repository->getKey(...)->getKeyValue()` and send it as an `Authorization: Bearer` header — never in a URL or query string. When `advanced.enable_logging` is on, only the request method, URL and response status code are logged.
