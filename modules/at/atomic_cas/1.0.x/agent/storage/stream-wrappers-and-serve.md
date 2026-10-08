<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stream wrappers, the serve route, DB schema & image-style dedup

## DB schema (atomic_cas.install, hook_schema)

- **`atomic_cas_blob`** — one row per unique blob. Fields: `hash` (varchar_ascii 64, lowercase SHA-256
  hex), `scheme` (varchar_ascii 32), `filesize` (big int unsigned), `mimetype` (varchar 255),
  `created` (int unsigned). **Primary key `(hash, scheme)`** — same bytes in public vs. private roots
  = two independent rows (cross-scheme dedup is forbidden by design). Indexes on hash and scheme.
- **`atomic_cas_map`** — one row per file entity. Fields: `fid` (PK, big int), `hash` (64),
  `scheme` (32). Indexes `hash` and `(scheme, hash)`.

## Stream wrappers

Base `src/StreamWrapper/CasStreamWrapperBase.php` implements `StreamWrapperInterface` as a **read-only
virtual overlay**: `realpath()` always FALSE, every write/rename/unlink/mkdir/rmdir/truncate/lock
returns FALSE/0, `stream_open()` accepts only `r`/`rb` (rejects `+`). The physical blob path is never
returned to callers — it is resolved internally from the map table.

- `stream_open($path)` parses the CAS URI, looks up the map row, verifies scheme match + blob exists,
  then `fopen(blobPath, 'rb')`. `stream_read/seek/tell/eof/stat/close` delegate to that handle.
- `url_stat($path)` synthesises a stat array from blob metadata (mode `0100444`, read-only), FALSE when
  unmapped / no metadata / blob missing (callers treat as "does not exist").
- `getExternalUrl()` builds the versioned route URL (empty string when the fid is still unmapped).
- Registered by `atomic_cas.services.yml` with tag `stream_wrapper`:
  - `cas-public` → `CasPublicWrapper`, `getType()` = **READ_VISIBLE** (visible but read-only, so image
    styles write derivatives into the default scheme instead of trying to write into CAS).
  - `cas-private` → `CasPrivateWrapper`, `getType()` = **READ** (not visible in file browsers).

## Serve route & controller

Route `atomic_cas.serve` (`atomic_cas.routing.yml`): path
`/files/cas/{fid}/{short_hash}/{filename}`, `_access: 'TRUE'`, constraints `fid=\d+`,
`short_hash=[0-9a-f]+`, `filename=[^/]+`. Handler `CasServeController::serve()` (`src/Controller/`).

Flow:
1. `AtomicCasManager::validateServeRequest($fid,$short_hash,$filename)` — loads the file entity + map
   row and throws a **hard 404** (`NotFoundHttpException`) on any mismatch: unknown fid, no map row,
   stale filename (must equal the entity's current filename), stale short hash (must equal
   `getShortHash(mapping.hash)`), or a physically missing blob. There are **no redirects** for stale
   URLs. The blob path is computed from the DB hash, never from URL input → no path traversal.
2. **Private access.** For `cas-private`, `checkPrivateAccess($uri)` invokes `hook_file_download` on
   `cas-private://{fid}/{filename}` (mirroring core's `FileDownloadController`): a `-1` result or an
   empty header set → `AccessDeniedHttpException`; otherwise the granted headers are merged onto the
   response. Public blobs need no access check (core public-file semantics).
3. **ETag / 304.** ETag is `"{full hash}"`; a matching `If-None-Match` returns 304.
4. **Serve mode** (`buildResponse()`): X-Accel-Redirect (Nginx) if `atomic_cas_x_accel_redirect` set,
   else X-Sendfile (Apache) if `atomic_cas_x_sendfile`, else a `StreamedResponse` running `readfile()`.
5. **Cache headers** (`applySchemeHeaders()`): `cas-public` → `public, max-age=31536000, immutable`;
   `cas-private` → `private, no-cache, no-store, must-revalidate` + `Pragma: no-cache`.

The short hash (12 hex = 48 bits) content-versions the URL: change the bytes → new short hash → old
URL 404s, making immutable caching safe.

## Image-style derivative dedup

`entity_type_alter` swaps `image_style` to `Drupal\atomic_cas\Entity\AtomicCasImageStyle`. For a
CAS-backed source, `createDerivative()` renders the derivative once to a shared hash-keyed path
`{derivativeScheme}://styles/{styleId}/{casScheme}/__shared__/{aa}/{bb}/{hash}.{ext}` and points the
normal per-fid derivative URI at it via a **symlink** (falling back to hard link, then copy).
`flush($path)` deletes both the per-file alias and the shared derivative; a full-style flush relies on
core deleting the whole `styles/{id}/` tree. Non-CAS sources return NULL and keep core behavior.
