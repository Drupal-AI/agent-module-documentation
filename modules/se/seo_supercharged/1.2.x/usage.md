<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO Supercharged exposes REST endpoints so the external SEO Supercharged platform can create/update posts and pages, sideload images, and read a site content inventory — with a WordPress-compatible response shape.
---
The endpoints live under `/seo-supercharged/v1/*` (and `/wp-json/wp-seo-supercharged/v1/*` aliases) and are declared in routing with `_access: 'TRUE'`, meaning route-level access is intentionally open and **authorization is enforced inside the controller** by `ApiController::isAuthorized()` (seo_supercharged/src/Controller/ApiController.php:999). Authorization passes if the caller is an authenticated Drupal user with `administer nodes`/`bypass node access`, OR presents the correct API key via `X-API-KEY` (or `Authorization: Bearer …`) compared with `hash_equals()` against a value in State. Crucially, if no API key has been configured, the constant-time comparison requires a non-empty stored key, so anonymous requests are rejected — the endpoints are not open by default. Write endpoints create nodes as the authenticated user, or as **uid 1** when authorized purely by API key (`authorUid()`), so the API key is a powerful credential.

Image handling is defensive: `downloadAndSaveImage()` calls `validateUrlSsrf()` (https-only, blocks localhost/link-local/metadata hosts and private/reserved IPs, re-validates each redirect target) and fetches with `'verify' => TRUE` and size/redirect limits — a solid anti-SSRF posture. Inline `<img>` rewriting only pulls remote `https://` non-local sources. Responses send permissive CORS (`Access-Control-Allow-Origin: *`) and `no-store`. Metatag values are read with `unserialize(..., ['allowed_classes' => FALSE])`. Settings (bundle/field mapping, API key, timeouts) are at `/admin/config/content/seo-supercharged` (`administer seo supercharged`).

Typical setup: configure the API key and bundle/field mappings on the settings form, then point the SEO Supercharged platform at the endpoints using that key.
---
- Receive AI-generated posts via `create-post`.
- Update existing posts via `update-post`.
- Batch-create posts, pages and categories via `push-batch`.
- Look up a post by slug/alias.
- Sideload a remote image into a Media entity.
- Rewrite inline `<img>` sources to local media.
- Map `post`/`page` to configured node bundles.
- Assign categories/tags from the payload.
- Apply SEO meta (via Metatag) to nodes.
- Schedule a post when Scheduler is present.
- Expose site info to the platform.
- Return a paginated content index.
- List categories and content types.
- Authenticate callers with an `X-API-KEY`.
- Authenticate as a Drupal admin session instead.
- Enforce https + SSRF blocks on image fetches.
- Cap image size, timeout and redirects.
- Restrict settings to `administer seo supercharged`.
- Serve WordPress-compatible `/wp-json/...` aliases.
