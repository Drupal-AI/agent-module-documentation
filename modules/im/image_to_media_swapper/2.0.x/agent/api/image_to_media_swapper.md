<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# image_to_media_swapper — JSON API & access model

All `/media-api/*` swap endpoints require permissions `create media`+`update media` and pass `SwapperController::validateSecurityRequirements()`:
1. CSRF token — `csrf_token` in the JSON body or `X-CSRF-Token` header, compared to `csrf_token('image_to_media_swapper_api')` with `hash_equals`.
2. `user_uuid` in the body must equal the current user's UUID.
3. `Origin` or `Referer` must start with the site's scheme+host.
4. Rate limit: 30 requests/min per (IP + uid) via the module cache bin.
5. `Content-Type` must contain `application/json`.

Endpoints (all POST unless noted):
- `swap-file-to-media/file-uuid` — body `{uuid}`; finds the file entity, returns/creates media.
- `swap-file-to-media/local-path` — body `{filepath}`; converts a web path to `public://` and swaps.
- `swap-file-to-media/remote-uri` — body `{remote_file}`; downloads via `SwapperService::downloadRemoteFile()` after `SecurityValidationService::validateUrl()` (SSRF/scheme/size checks), filename sanitised with `generateSafeFileName()`.
- `security-tokens` (GET) — returns `{csrf_token, user_uuid, user_id, timestamp}`; requires Referer same-host.

Batch/records:
- `_batch_swapper_access` (service `image_to_media_swapper.access_checker`) → forbids anonymous, requires `access batch media swapper` (restricted), and honours `security_settings.disable_batch_processing`.
- `media_swap_record` entity has view/create/edit/delete permissions and an access-control handler.

Security settings (`image_to_media_swapper.security_settings`): `enable_remote_downloads`, `require_https`, `block_private_ips` (default TRUE), `restrict_domains`+`allowed_domains` (wildcard `*.example.com`), `max_file_size`, `download_timeout`, `max_redirects`, allowed extensions/MIME arrays.
