<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WOPI endpoints, JWT token flow, proof check & access model

Drupal is the **WOPI host**. This page documents the endpoints the Collabora server calls, how
requests are authenticated, and the Drupal permission model behind them.

## Editor / viewer entry points (browser-facing)

| Route | Path | Controller | Route access requirement |
|-------|------|-----------|--------------------------|
| `collabora-online.view` | `/cool/view/{media}` | `ViewerController::editor` | `_entity_access: media.preview in collabora` |
| `collabora-online.edit` | `/cool/edit/{media}` (`edit: true`) | `ViewerController::editor` | `_entity_access: media.edit in collabora` |
| `collabora-online.modal` | `/cool/modal/{media}` | `ModalController::modalPreview` | `_entity_access: media.preview in collabora` |

`{media}` is constrained to `\d+`. `ViewerController::editor()`:
1. Fetches discovery and the WOPI client URL; returns a 400 text response if Collabora is
   unavailable, the file type is unsupported, or the client URL scheme mismatches the request scheme.
2. Reads an optional `destination` query param via `getDestinationUrl()` — **external destinations
   are rejected** (`UrlHelper::isExternal`), only internal URLs become the editor's close button.
3. `getViewerRender()` requires `cool.wopi_base` to be set, then mints the access token (below) and
   renders the `collabora_online_full` theme: an iframe that auto-submits the token to the WOPI
   client, with `#wopiSrc = urlencode(wopi_base . '/cool/wopi/files/' . media_id)`.

`ModalController::modalPreview()` returns an iframe render element pointing at the view route (its
title callback returns `$media->label()`).

## The access token (JWT, HS256)

Minted in `ViewerController::getViewerRender()` via `JwtTranscoder::encode()`:

```
payload = { fid: media.id(), uid: currentUser.id(), wri: can_write }
exp     = now + (cool.access_token_ttl ?: 86400)   // seconds
```

`Jwt\JwtTranscoderBase` (unit-testable base; `JwtTranscoder` supplies the key):
- `encode()` — `Firebase\JWT\JWT::encode($payload, $key, 'HS256')`.
- `decode()` — `JWT::decode($token, new Key($key, 'HS256'))`; **the algorithm is pinned to HS256**
  (no `alg:none` / algorithm confusion). Returns NULL on any exception, or if the payload lacks
  `exp`. firebase/php-jwt enforces `exp`/`nbf` itself.
- `getKey()` (in `JwtTranscoder`) loads the secret from the Key entity `cool.key_id`; throws
  `CollaboraJwtKeyException` if the id is unset or the key is empty/missing.

## WOPI endpoints (Collabora → Drupal)

| Route | Path | Method | `action` | Handler |
|-------|------|--------|----------|---------|
| `collabora-online.wopi.info` | `/cool/wopi/files/{media}` | GET | `info` | `WopiController::wopi` → `wopiCheckFileInfo` |
| `collabora-online.wopi.contents` | `/cool/wopi/files/{media}/contents` | GET | `content` | → `wopiGetFile` |
| `collabora-online.wopi.save` | `/cool/wopi/files/{media}/contents` | POST | `save` | → `wopiPutFile` |

All three carry `requirements._collabora_online_wopi_access: 'TRUE'` and
`_format: collabora_online_wopi`.

### Two-layer authentication

**Layer 1 — RSA proof** (`Access\WopiProofAccessCheck`, tagged `access_check` for
`_collabora_online_wopi_access`, in `collabora_online.services.yml`). Runs when `cool.wopi_proof` is
TRUE (default); if disabled it allows and caches. When enabled it sets cache max-age 0 and:
- `checkTimeout()` — rejects a missing/invalid `X-WOPI-Timestamp` or one older than a **20-minute
  TTL** (`ttlSeconds = 20*60`; `.NET` ticks converted via `Util\DotNetTime`).
- `checkProof()` — loads the current + old RSA public keys from `discovery.xml`
  (`phpseclib3`, SHA-256, relaxed PKCS1), builds the canonical subject from the access_token, the
  upper-cased request URI and the timestamp ticks, and verifies `X-WOPI-Proof` /
  `X-WOPI-ProofOld`. Any matching key/signature pair (except old-key+old-signature) allows.

**Layer 2 — JWT + entity access** (`WopiController::wopi`):
1. Requires a non-empty `access_token` query param (else 403).
2. `verifyTokenForMedia()` decodes/verifies the JWT and enforces
   `(string) payload['fid'] === (string) media->id()` — **a token for one media cannot be replayed
   on another** (403 otherwise). Decode failures → 403.
3. Loads the user from `payload['uid']` (403 if absent) and the file from the media (403 if none).
4. `can_write = !empty(payload['wri'])`. For a write token on a non-`content` action it re-checks
   **live** `media.access('edit in collabora', $user)` — a permission revoked after mint blocks the
   request.
5. Dispatches on `action`.

### Handlers

- `wopiCheckFileInfo()` — returns a WOPI `CheckFileInfo` JSON: `BaseFileName`, `Size`,
  `LastModifiedTime`, `UserId`, `UserFriendlyName`, `UserCanWrite`, `IsAdminUser`
  (`administer collabora instance`), `IsAnonymousUser`, `SupportsRename: false`, and an avatar URL if
  the user has a `user_picture`.
- `wopiGetFile()` — streams the file as a `BinaryFileResponse` (404 if missing on disk).
- `wopiPutFile()` — **write only** (throws `AccessDeniedHttpException` unless `can_write`). Then:
  - `checkSaveTimestampConflict()` — if the `x-cool-wopi-timestamp` header differs from the file's
    changed time, returns HTTP 409 `{COOLStatusCode: 1010}` (edited out of band).
  - If within `cool.new_file_interval` (or it is 0): overwrites the file in place
    (`saveData(..., FileExists::Replace)`), re-saves the file entity, logs, returns the new
    `LastModifiedTime`.
  - Otherwise: `createNewFileEntity()` writes the content to a fresh uri
    (`FileExists::Rename`, original filename/owner preserved), sets it as the media source, and saves
    a new media revision (revision user = token user, log = build save reason).
  - `buildSaveReason()` maps `x-cool-wopi-ismodifiedbyuser` / `-isautosave` / `-isexitsave` headers
    into a human revision message.

### Error formatting

`EventSubscriber\ExceptionWopiSubscriber` (handles the `collabora_online_wopi` format) renders 4xx
errors as `text/plain`, and rewrites the verbose 404 "media parameter was not converted" message to
"Media not found."

## Permission / access model

Global permission `administer collabora instance` (restricted). Per media type, four permissions are
generated by `CollaboraMediaPermissions::mediaTypePermissions()`:
`preview {type} in collabora`, `preview own unpublished {type} in collabora`,
`edit own {type} in collabora`, `edit any {type} in collabora`.

`collabora_online_media_access()` (`hook_ENTITY_TYPE_access` for media) resolves the two virtual
operations:
- **`preview in collabora`** — published media: `preview {type} in collabora`. Unpublished: requires
  `preview own unpublished {type} in collabora` **and** ownership (`account->id() == owner`).
- **`edit in collabora`** — `edit any {type} in collabora`, or `edit own {type} in collabora` **and**
  ownership.

Core's `administer media` also grants these (standard media behaviour). Both branches attach proper
cache metadata (`cachePerUser`, `cachePerPermissions`, `addCacheableDependency($media)`). Developers
can further alter access via standard entity access hooks (e.g. the group submodule does this).
