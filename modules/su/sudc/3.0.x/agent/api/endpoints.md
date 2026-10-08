<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SearchUnify Connector — endpoints & JWT

All routes below require only `_permission: 'access content'` (anonymous by default). Controller: `SuResultController`.

## Front-end results page
`GET /searchunify/{dynamic_path}` → `content()`. Matches `{dynamic_path}` against configured Search-URL values to resolve a UID, renders `#theme => 'su_results'` with `data = {uid, token(access_token), epoint, cdn}`. The access token is placed into the render data for the client widget.

## Search proxy
`POST /search-unify/v1/searchresultbypost` → `resultsByPost()`. Reads JSON body, injects the stored `uid` + `accessToken`, forwards to `{epoint}search/searchResultByPost` via `RestCalls::exeHttpClient()` (`verify => sslVerify`, default TRUE), returns the JSON response.

## GPT proxy
`POST /search-unify/v1/su-gpt` → `getAPIParams()`. Forwards the raw body to `{epoint}mlService/su-gpt` with the stored token in a `token` header (`exeHttpClientSuGpt`). Supports a `streaming` flag.

## JWT
`GET /search-unify/v1/search_jwt` → `getsearchjwt()`. Builds a payload via `buildJwtPayload()` that **includes the SearchUnify `access_token` in plaintext**, plus the current user's id/email/roles, `iat`/`exp` (config `token_expiry` minutes, default 180). Signs with `hash_hmac('sha256', userId, access_token)` using HS256 (`firebase/php-jwt`). The active UID is resolved from the `Referer` header, falling back to the first configured UID.

> Observation: because these routes are anonymous-accessible and the JWT payload/results data carry the server-side SearchUnify access token, the token is disclosable to unauthenticated clients, and the proxy endpoints can be driven by anonymous users. Restrict `access content` or the routes if that is not intended.
