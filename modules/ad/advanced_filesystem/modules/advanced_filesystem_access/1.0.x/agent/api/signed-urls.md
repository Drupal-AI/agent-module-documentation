<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signed download URLs & the secure endpoint

## Generating a link
`Service\FileAccessService::generateSignedUrl(FileInterface $file, int $ttl = 0): string`
- Requires a non-empty `signing_secret` (config `advanced_filesystem_access.settings`), else throws `\RuntimeException`.
- `$ttl <= 0` uses config `token_ttl` (default 3600 s).
- Computes `expires = now + ttl`, `payload = "fid={fid}&expires={expires}"`, `token = hash_hmac('sha256', payload, secret)`.
- Returns root-relative `"{base_path}/adfs/download/{fid}/{token}?expires={expires}"`.

Twig (via `AdfsAccessTwigExtension`), filter or function `adfs_signed_url`:
```twig
<a href="{{ file|adfs_signed_url }}">Download</a>            {# default TTL #}
<a href="{{ file|adfs_signed_url('24h') }}">24h link</a>     {# shorthand s/m/h/d/w #}
<a href="{{ adfs_signed_url(node.field_attachment.target_id, 600) }}">10 min</a>
```
`signedUrl()` resolves a `FileInterface`, an int/numeric FID, or a field item/array with `target_id`, then calls `generateSignedUrl()`; on any error it returns `''` so templates degrade gracefully. `parseTtl()` accepts int seconds or `^\d+(s|m|h|d|w)$`.

## Serving a download
Route `advanced_filesystem_access.download` = `/adfs/download/{fid}/{token}` (`fid: \d+`), `requirements._access: 'TRUE'`.
`Controller\SecureDownloadController::download(Request, int $fid, string $token)`:
1. `expires = (int) request query 'expires'`.
2. `FileAccessService::validateToken($fid, $token, $expires)` — returns FALSE if the secret is empty (fail-closed); if `expires > 0 && expires < now` returns FALSE (expired); otherwise recomputes the HMAC and compares with `hash_equals($expected, $token)` (constant-time). Invalid → HTTP 403.
3. Load `file` entity; missing → 404.
4. `isIpAllowed($fid)` — per-file blocklist wins, then per-file allowlist (if set, client IP must match), then global blocklist; deny → 403. Exact IP match or IPv4 CIDR (`ip2long` mask).
5. `isDownloadBlocked($file)` — if the per-file `download_limit > 0` and the `adfs_access_log` row count for that fid `>= limit`, deny → 403.
6. `logDownload($fid, 'signed')` writes an `adfs_access_log` row (fid, uid, ip, timestamp, method, truncated user_agent).
7. Stream via `BinaryFileResponse` of `file_system->realpath($file->getFileUri())` with `Content-Disposition: attachment`, `Cache-Control: private, no-cache, no-store, must-revalidate`, `Pragma: no-cache`. Unreadable realpath → 500.

Notes: `fid` is regex-constrained and loaded through entity storage (no path input reaches the filesystem beyond the file's own URI). The `_access: 'TRUE'` route is intentionally public because the capability is the unforgeable HMAC token; rotating `signing_secret` invalidates all outstanding links. Setting `token_ttl` to 0 in the settings form issues non-expiring tokens (still secret-bound).
