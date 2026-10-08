<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO Supercharged (seo_supercharged) — agent index
**REST endpoints to receive AI content pushes (posts/pages/images) and read a content inventory; WordPress-compatible shape.**

- **Version:** 1.2.x
- **Core:** ^9.3 || ^10 || ^11 · **Depends on:** node, file, image, media, user, system, path, path_alias, taxonomy
- **Config:** `seo_supercharged.settings_form` → `/admin/config/content/seo-supercharged` (`administer seo supercharged`)
- **API routes (all `_access: 'TRUE'`):** `create-post`, `update-post`, `get-post-by-slug`, `sideload-image`, `push-batch`, `site-info`, `content-index`, `categories`, `content-types` (+ `/wp-json/wp-seo-supercharged/v1/*` aliases)
- **Controller:** `ApiController`

**Security:** Routes are `_access: 'TRUE'` **by design** — real authz is in-controller `isAuthorized()`: authenticated `administer nodes`/`bypass node access`, OR `X-API-KEY`/`Bearer` compared with `hash_equals()` to a State-stored key. With no key set, anonymous is rejected (stored key must be non-empty). API-key-only callers author content as **uid 1** (`authorUid()`) — treat the key as admin-equivalent. Image fetches enforce https + SSRF allow/deny (`validateUrlSsrf`) with `verify => TRUE`, size/redirect caps. CORS `*`; `unserialize` uses `allowed_classes=>FALSE`. Observations, not a bypass. See [api/endpoints.md](api/endpoints.md).
