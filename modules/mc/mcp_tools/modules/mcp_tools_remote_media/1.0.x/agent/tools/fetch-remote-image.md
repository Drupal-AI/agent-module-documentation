<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_fetch_remote_image — fetch a remote image into a media entity

## Enable

`drush en mcp_tools_remote_media -y` (needs `mcp_tools`, `mcp_tools_media`, core `media` + `file`).
Grant a role `mcp_tools use remote media`, and ensure the connection has **write** scope.

## Tool

Plugin `FetchRemoteImage` (`id: mcp_fetch_remote_image`, operation Write). Inputs:

| Input | Req | Default | Notes |
| --- | --- | --- | --- |
| `url` | yes | — | Remote image URL, http/https only. |
| `name` | yes | — | Media/entity name (also filename fallback). |
| `bundle` | no | `image` | Media type machine name. |
| `directory` | no | `public://mcp-uploads` | Target stream wrapper (public:// or private:// only). |
| `create_media` | no | `true` | If false, only the managed file is created. |

Outputs: `fid`, `mid`, `filename`, `uri`, `url`, `message`.

## Pipeline (`AbstractRemoteFileService::fetchAndCreate()`)

1. `validateAccess()` — `AccessManager::canWrite()`; denied → write-access-denied error.
2. `validateUrl()` — `FILTER_VALIDATE_URL` and scheme ∈ {http, https}.
3. `validateNotInternalUrl()` — `gethostbyname($host)`; reject when the resolved IP fails
   `FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE` (blocks RFC1918/loopback/link-local/reserved).
4. `validateDirectory()` — regex-restricted to `public://`/`private://`, no `..`.
5. `fetchFromRemote()` — Guzzle GET, 30s timeout, 10s connect, `allow_redirects max 3`, custom UA.
6. MIME checks: `validateMimeType()` on the Content-Type header, then `validateBody()`
   (non-empty, ≤ 10 MiB), then `validateContentMime()` via `finfo` buffer detection — both against
   the image allowlist (`image/jpeg|png|gif|webp|svg+xml`).
7. `sanitizeContent()` — for `image/svg+xml`, `enshrined/svg-sanitize` with
   `removeRemoteReferences(true)`; empty/invalid → error.
8. `buildFilename()` + `validateExtension()` — sanitize the basename, reject
   `BLOCKED_UPLOAD_EXTENSIONS` (php/phar/exe/sh/…).
9. `saveFileEntity()` — `fileSystem->saveData(..., FileExists::Rename)`, create a `file` entity
   (status 1, current time), `auditLogger->logSuccess('fetch_remote_image', …)`.
10. If `create_media`, `createMediaEntity()` delegates to `mcp_tools_media` `MediaService::createMedia()`.

## Operational notes

- The tool creates the `file`/`media` entities directly as the executing (service) account; gating
  is the MCP write scope + `mcp_tools use remote media` permission rather than per-entity create
  access. Grant the permission only to a trusted, least-privilege connection.
- SVGs are sanitized before save; non-image content that `finfo` cannot classify as an allowed
  image type is rejected, so the saved artifact is always an allowed image.
