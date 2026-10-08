<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote Sync API endpoints (source-server side)

Two read-only HTTP endpoints the **destination** server calls to pull files from a **source**
server. Both live in `src/Controller/RemoteSyncApiController.php` and are declared in
`advanced_filesystem_remote_sync.routing.yml` with `_access: 'TRUE'` and `options: no_cache: TRUE`.

## Authentication (this is the real gate)

`_access: 'TRUE'` opens the route, but each endpoint method calls `authenticate($request)` as its
**first statement**, so there is no unauthenticated access. `authenticate()`:

1. Reads `PHP_AUTH_USER` / `PHP_AUTH_PW` from `$request->server`; if empty, base64-decodes the
   `Authorization: Basic …` header (`str_starts_with(..., 'Basic ')`, split on first `:`).
2. If username or password is empty → `AccessDeniedHttpException`.
3. Verifies the password with core `user.auth`: `\Drupal::service('user.auth')->authenticate($username, $password)`.
   FALSE/NULL → `AccessDeniedHttpException`.
4. Loads the account and requires `->hasPermission('access advanced_filesystem_remote_sync api')`;
   otherwise `AccessDeniedHttpException`.

The permission (`advanced_filesystem_remote_sync.permissions.yml`) is `restrict access: true` and
is meant for a dedicated service account. This is a real password check (no token compare, no
default-empty secret), so the endpoints are effectively "Basic Auth + restricted permission".

## GET /advanced-filesystem-remote-sync/list — `listFiles()`

Query params (sanitized in the method):
- `scheme` (default `public`) — `preg_replace('/[^a-z0-9_-]/', '', …)`; required after sanitizing;
  must pass `stream_wrapper_manager->isValidScheme()`.
- `offset` (default 0, floored at 0).
- `limit` (default 200, clamped to 1..500).

Resolves `scheme://` to a real dir via `file_system->realpath()`; if missing, returns an empty
`files` array. Otherwise `scanDir()` recurses the real directory and collects every file as
`{uri, rel, size, mtime}` (rel = path under the scheme root, backslashes normalized to `/`).
Returns `JsonResponse`:

```json
{"scheme":"public","total":1234,"offset":0,"limit":200,
 "files":[{"uri":"public://foo/bar.jpg","rel":"foo/bar.jpg","size":12345,"mtime":1700000000}]}
```

Note: the scan builds the **full** file list in memory before slicing `array_slice($all, $offset, $limit)`.

## GET /advanced-filesystem-remote-sync/file — `serveFile()`

Query param: `uri` (required), e.g. `public://path/to/file.jpg`. The scheme is extracted with
`stream_wrapper_manager->getScheme($uri)` and must be a valid scheme; the path is resolved with
`file_system->realpath($uri)` and must be an existing file (else `NotFoundHttpException`).
Streams the bytes via a `StreamedResponse` (64 KB `fread` loop) with `Content-Type` from
`mime_content_type()`, `Content-Length`, `Content-Disposition: attachment`, an `X-File-URI`
header echoing the URI, and no-cache headers. Traversal outside the scheme root is blocked by
core's `LocalStream::getLocalPath()` (realpath must start with the wrapper root), and any read
still requires the authenticated restricted permission.

## Calling them (example)

```
curl -u sync_user:PASS "https://old.example.com/advanced-filesystem-remote-sync/list?scheme=public&limit=200&offset=0"
curl -u sync_user:PASS "https://old.example.com/advanced-filesystem-remote-sync/file?uri=public://logo.png" -o logo.png
```

The destination never calls these by hand — `RemoteSyncBatch` does (see
[../config/settings.md](../config/settings.md)).
