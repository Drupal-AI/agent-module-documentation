<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrAPI REST endpoints, dispatch & access

All source in `src/Controller/BrapiController.php`, `src/Routing/BrapiRoutes.php`, `src/EventSubscriber/BrapiSubscriber.php`.

## Static routes (`brapi.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `brapi.main` | `/brapi` | `_access: TRUE` (public landing page, theme `brapi_main`) |
| `brapi.documentation` | `/brapi/doc` | `_access: TRUE` (public, theme `brapi_documentation`) |
| `brapi.token` | `/brapi/token` | `_role: authenticated` — shows the user's token(s) |
| `brapi.token.new` | `/brapi/token/new` | `_role: authenticated` — (re)generate token |
| `brapi.token.expire` | `/brapi/token/expire` | `_role: authenticated` — expire current token |
| `brapi.token.delete` | `/brapi/token/delete` | `_role: authenticated` — delete current token |
| `brapi.admin` / `brapi.datatypes` / `brapi.calls` | `/brapi/admin[...]` | `_permission: 'administer site configuration,administer brapi'` |
| `entity.brapidatatype.*` | `/brapi/admin/datatypes/...` | entity access on `brapidatatype` |

## Dynamic call routes (`BrapiRoutes::routes()`)

For every call enabled in `brapi.settings:calls`, a route `/brapi/{v1|v2}{call}` is registered pointing at `BrapiController::brapiCall`, methods `GET|DELETE|POST|PUT`, with **`_access: TRUE`**. Access is intentionally not enforced by the router — it is checked inside `brapiCall()` *after* the request subscriber has had a chance to authenticate the bearer token. Catch-all `brapi.v{1,2}_invalid[_N]` routes return a JSON "Unsupported call" 404 (`brapiInvalidCall()`).

## Bearer-token authentication (`BrapiSubscriber::BrapiRequest`, priority 20)

BrAPI clients send `Authorization: Bearer <token>`. The subscriber matches `^/brapi/(v\d)/...`, extracts the bearer (`getBearer()` reads `Authorization`/`HTTP_AUTHORIZATION`/apache headers or a non-standard `bearer` header), loads the `brapi_token` entity by exact `token` property (`loadByProperties`, parameterized), and calls `user_login_finalize()` on the token's user. Token auth is only honored over HTTPS unless the `insecure` config flag is set (over plain HTTP without `insecure`, it logs a warning and does not authenticate). Token generation: `bin2hex(random_bytes(16))` (32 hex chars) in `BrapiToken::preCreate()`.

## Access / permission model (`brapiCall()`)

Constants (`brapi.module`): `BRAPI_PERMISSION_USE = 'use brapi'`, `BRAPI_PERMISSION_EDIT = 'edit brapi content'`, `BRAPI_PERMISSION_SPECIFIC = 'use restricted brapi'`, `BRAPI_PERMISSION_ADMIN = 'administer brapi'`.

Per request `brapiCall()`:
1. Parses `version` + `call` from the route path; requires a matching definition (`brapi_get_definition`) and an enabled entry in `calls[version][call][method]`, else 404 / 501.
2. Computes `$read_mode` = GET, or POST to a `search` call, or v1 `/login`,`/logout`.
3. Grants when the user has: (`$read_mode` AND `use brapi`) OR `edit brapi content` OR `administer brapi`; v1 `/login`/`/logout` are always allowed. Otherwise it falls back to a **per-call role check**: the roles listed in `calls[version][call][method_access]` are intersected with `$user->getRoles()`; no overlap → `AccessDeniedHttpException`.

So: `use brapi` = read (GET + search POST) on any enabled call; `edit brapi content` = read + write; per-call `*_access` role lists grant named roles access to specific calls/methods without the blanket permissions. The `use restricted brapi` permission only opens the mapping-view access handler (`BrapiDatatypeAccessController`); actual call access for restricted clients is driven by the per-call role lists.

## Call processors

- `processQueryObjectCalls()` — GET single/list objects and `/search` execution. Builds filters from route placeholders, query string, and POST body (with singular/plural/case fixups), resolves referenced-datatype filters, applies pagination, then calls `BrapiDatatype::getBrapiData()`.
- `processSearchCalls()` — `/search/*`. If the call is `deferred` (or a `searchResultsDbId` is supplied) it returns a `searchResultsDbId` (md5 of call + normalized params + sorted user roles) and a 202, queueing the search into `BrapiAsyncSearch`; the actual query runs in `kernel.terminate` and the result is cached in the `brapi_search` bin (lifetime `search_default_lifetime`). Non-deferred search must use POST.
- `processPostObjectCalls()` / `processPutObjectCalls()` — create / update via `BrapiDatatype::saveBrapiData()`; body is a JSON array of objects (POST) or one object keyed by its URL DbId (PUT).
- `processDeleteObjectCalls()` — delete via `BrapiDatatype::deleteBrapiData()` using the URL identifier.
- `processV2ServerInfoCall()` — builds `/serverinfo` listing calls the *current user* may reach (re-runs the same permission logic per call) plus server metadata config.
- `processV1CallsCall()` / `processV1LoginCall()` / `processV1LogoutCall()` — v1 `/calls`, `/login` (POST creds → token; enforces HTTPS unless `insecure`; uses `user.auth` + `user.flood_control`), `/logout` (DELETE).

Responses are `JsonResponse` wrapped with `generateMetadata()` (BrAPI `metadata.status` + `pagination`). Errors are caught and returned as BrAPI status JSON with the HTTP status code.

## Extensibility (`brapi.api.php`)

`hook_brapi_call_alter(&$json_array, $context)`, `hook_brapi_call_{method}_{version}_{call}[_result]_alter`, `hook_brapi_unsupported_call_alter`, `hook_brapi_definition_alter`, and `hook_brapi_{datatype}_save_alter` let modules implement or post-process calls and inject/extend definitions.
