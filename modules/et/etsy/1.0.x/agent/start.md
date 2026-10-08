<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etsy API (etsy) — agent index

Base integration that wraps the **Etsy v3 API** as the Drupal service **`etsy.api`** for a single Etsy shop. Package `Etsy`. Core `^10.4 || ^11.1`. License GPL-2.0-or-later. Version-dir 1.0.x (installed as a `^1.0@dev` checkout). By itself it does nothing user-facing — it is the connectivity layer other modules build on.

Depends on contrib **`oauth2_client`** (OAuth2 auth + credential/token storage) and **`imagecache_external`** (remote images, used by Etsy Shop). Ships two submodules: **etsy_fields**, **etsy_shop** (documented in their own trees).

## Solution docs

- **The `etsy.api` service — every method, caching, endpoint, auth headers** → [api/service.md](api/service.md)
- **OAuth2 client plugin + provider (auth code + PKCE), credential & token storage** → [api/oauth.md](api/oauth.md)
- **Settings form, config objects, routes, permission, test form, block, cron, requirements** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Service** `etsy.api` = `Drupal\etsy\EtsyService` (`src/EtsyService.php`, iface `EtsyServiceInterface`). Args: `@http_client` (Guzzle), `@config.factory`, `@oauth2_client.service`, `@logger.channel.etsy`, `@cache.default`. Endpoint const `https://openapi.etsy.com/v3/application/`. Only GET is implemented; other methods throw.
- **OAuth2** plugin `Drupal\etsy\Plugin\Oauth2Client\Etsy` (id `etsy`, grant `authorization_code`, PKCE S256) + `Drupal\etsy\Provider\EtsyProvider` (extends League `GenericProvider`). Access token stored in Drupal **state** key `oauth2_client_access_token-etsy`. Client ID (keystring) / Client Secret (shared secret) live in the **`oauth2_client.oauth2_client.etsy`** config entity, edited at `/admin/config/system/oauth2-client` — NOT in etsy's own config, and NOT env/getenv/Key based.
- **Config** `etsy.settings` holds only `shop_id` and `cache_lifetime` (install default 42300). No config/schema dir ships.
- **Routes** (`etsy.routing.yml`): `etsy.settings` = `/admin/config/services/etsy` (`EtsySettingsForm`); `etsy.test_form` = `/admin/config/services/etsy/testing-form` (`EtsyTestForm`). Both require permission **`administer etsy settings`** (restrict access: true) and are `_admin_route`.
- **Permission**: `administer etsy settings` (`etsy.permissions.yml`).
- **Block**: `etsy_trademark_block` (`EtsyTrademarkNoticeBlock`) — required Etsy trademark notice text.
- **Hooks** (`etsy.module`): `hook_cron` pings the API to keep the token alive; `hook_requirements` (runtime) reports Etsy connectivity; `hook_uninstall` deletes `etsy.settings` + `oauth2_client.oauth2_client.etsy`. Helper `etsy_supported_currencies()`.
