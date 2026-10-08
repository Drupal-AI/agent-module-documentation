<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO Supercharged — endpoints & auth model

## Authorization (in-controller, routes are `_access: 'TRUE'`)
`ApiController::isAuthorized($request)`:
1. Authenticated Drupal user with `administer nodes` OR `bypass node access` → allow.
2. `X-API-KEY: <key>` compared via `hash_equals()` to `state.get('seo_supercharged.api_key')`.
3. Legacy `Authorization: Bearer <key>` (same comparison).
Returns 403 `{"success":false,"message":"Unauthorized"}` otherwise. If no key is stored, only path (1) can succeed — anonymous callers are rejected. `authorUid()` = current uid, or **1** for API-key-only callers.

## Write endpoints (POST, + OPTIONS preflight)
- `create-post` — create node from `title/content/post_type/status/categories/tags/meta/images/...`. status `publish` publishes; `scheduled` uses Scheduler `publish_on` if present.
- `update-post` — load by `post_id`, apply provided fields; empty arrays clear tags/categories.
- `sideload-image` — download a remote image to a Media entity.
- `push-batch` — first pass creates `category` items, second pass creates posts/pages.

## Read endpoints (GET)
- `site-info` — site name/tagline/langs, active theme, active modules, admin email, detected SEO module.
- `content-index` — paginated inventory (`page`,`per_page` 10..200); uses entity query `accessCheck(FALSE)` (both published+unpublished) — intended for the authorized platform.
- `categories`, `content-types`.

## Image fetch / SSRF (`downloadAndSaveImage` + `validateUrlSsrf`)
- https-only; blocks localhost/`0.0.0.0`/`::1`/`host.docker.internal`/`metadata*`/`169.254.169.254`; rejects private/reserved IPs (IP literals and resolved A/AAAA); re-validates each redirect Location.
- Guzzle `'verify' => TRUE`, `allow_redirects => FALSE` (manual, capped), size cap (`max_image_size`), timeout.
- Inline `<img>` rewriting only touches remote `https://` non-site-local URLs.

## Hardening notes
- The API key is admin-equivalent (authors as uid 1, bypasses node access). Store it well, rotate it.
- `content-index` deliberately ignores node access — do not widen the key's exposure.
- CORS is `Access-Control-Allow-Origin: *`.
