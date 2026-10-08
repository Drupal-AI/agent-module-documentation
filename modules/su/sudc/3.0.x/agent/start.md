<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SearchUnify Drupal Connector (sudc) — agent index
**Integrates Drupal with the SearchUnify hosted search platform: a results page, proxy REST endpoints, and a per-user JWT endpoint.**

- **Version:** 3.0.x (3.0.1)
- **Core:** ^9 || ^10 || ^11 (PHP 8.1); composer: firebase/php-jwt ^6.10
- **Configure:** `/admin/config/sudc` (`administer site configuration`); help at `/admin/config/sudc/help`.
- **Routes:** `/searchunify/{dynamic_path}` (results page); `/search-unify/v1/searchresultbypost`, `/search-unify/v1/su-gpt`, `/search-unify/v1/search_jwt` — all `_permission: 'access content'`.
- **Services:** `sudc.restCalls` (RestCalls; `sslVerify` default TRUE), `sudc.commonCalls`.

**Security — review carefully (observations reported, not recorded here):** all four front-end/REST routes are gated only by `access content` (anonymous by default). `/search-unify/v1/search_jwt` returns a JWT whose payload embeds the site's SearchUnify `access_token` in plaintext (base64-decodable) — token disclosure to anonymous users (SuResultController::buildJwtPayload). The `searchresultbypost`/`su-gpt` endpoints act as an unauthenticated proxy to SearchUnify using stored server credentials. TLS verification is on by default (no `verify=>false` in code).

See [api/endpoints.md](api/endpoints.md)
