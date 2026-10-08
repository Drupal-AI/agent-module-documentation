<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# autoshortqr — routes & CodeController (resolution + QR download)

All routes are in `autoshortqr.routing.yml`, all handled by
`src/Controller/CodeController.php`, all gated by `_permission: "access content"`.

## Route map

| Path | Method target | What it does |
|---|---|---|
| `/nc/{short_value}` | `resolveNodeUrlQr` | 302 → node canonical URL (QR settings) |
| `/uc/{short_value}` | `resolveUserUrlQr` | 302 → user canonical URL |
| `/tc/{short_value}` | `resolveTermUrlQr` | 302 → term canonical URL |
| `/rc/{short_value}` | `resolveRedirectUrlQr` | 302 → redirect target URL |
| `/ns /us /ts /rs {short_value}` | `resolve*UrlShort` | same, using the `short_*` settings |
| `/autoshortqr/nc/{short_value}` | `downloadNodeQr` | streams the QR **SVG** (attachment) |
| `/autoshortqr/uc,tc,rc/{short_value}` | `downloadUserQr` / `downloadTermQr` / `downloadRedirectQr` | QR SVG for user/term/redirect |

The resolve routes set `options.no_cache: TRUE`. `{short_value}` is a **base36** string; the
controller decodes it with `intval($short_value, 36)` to recover the numeric entity id.

## Resolution mechanism

`resolveNodeUrl()/resolveUserUrl()/resolveTermUrl()` (and `resolveRedirectUrl()`):

1. Default `$url = Url::fromRoute('<front>')`.
2. `$id = intval($short_value, 36)`; load the entity by that id via the entity type manager
   (`Redirect::load()` for redirects).
3. If found, read the bundle's `getThirdPartySettings('autoshortqr')` and call `createUrl()` (or, for
   redirect, use `$entity->getRedirectUrl()` directly).
4. `createUrl()` returns front page unless `<type>_enable` is set; otherwise it builds
   `$entity->toURL('canonical', [...])` with the content-language and a merged query.
5. If `$url->isExternal()` → `TrustedRedirectResponse(...)`, else `RedirectResponse($url->toString())`.

**UTM merging:** current request query (`$request->query->all()`) is merged with any query already on
the target; for each `UTM_VARS` key the per-type setting is `token`-replaced
(`$this->tokenService->replace($settings[...], [entityTypeId => entity], ['clear' => TRUE])`) and
added **only if the visitor did not already supply it** (`empty($query[$utmvar])`). `createUrl()`
passes a fresh `BubbleableMetadata` to token replace so `TrustedRedirectResponse` caching does not
fail. The redirect (`rc`/`rs`) branch redirects to the redirect entity's own **admin-configured**
target (`getRedirectUrl()`) — the destination is not taken from the request.

## QR download (`downloadNodeQr` etc.)

`intval($short_value,36)` → load entity → verify the bundle's `qr_enable` third-party setting →
`sendQrCode($entity)`. `sendQrCode()` renders `$entity->get('autoshortqr')->view(['type' =>
'autoshortqr', 'settings' => ['height'=>400,'width'=>400]])`, extracts `[0]['#svg']`, and returns a
`Response` with `content-type: image/svg+xml` and `Content-Disposition: attachment;
filename=qr_<entityType>_<id>.svg`. A miss returns `new Response('', 404)`.

## Notes

- The base fields/tokens build a `uri` of `<base_domain>/<prefix>/<base36 id>`; these routes are the
  matching resolvers. Prefixes: node `nc/ns`, user `uc/us`, term `tc/ts`, redirect `rc/rs`.
- `getThirdPartySetting()` on the fake wrappers reads config `autoshortqr.settings` (`user.` /
  `redirect.` prefix); node/term read the bundle config entity.
