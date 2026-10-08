# Meta-tag records (domain_route_meta_tag entity)

A **content entity** (`@ContentEntityType id="domain_route_meta_tag"`, base table
`domain_route_meta_tag`, class `Drupal\domain_route_meta_tag\Entity\DomainRouteMetaTag`).
Each record maps one `(route_link, domain)` pair to a set of meta values.

## Admin routes (no dedicated settings form)
- List (the `configure` route): `/admin/config/system/domain_route_meta_tag/list`
- Add: `/admin/config/system/domain_route_meta_tag/add`
- View: `/admin/config/system/{id}`
- Edit: `/admin/config/system/domain_route_meta_tag/{id}/edit`
- Delete: `/admin/config/system/domain_route_meta_tag/{id}/delete`

Add/edit require the entity `create`/`edit` access, which maps to the
`access domain meta` permission (see permissions doc). If no active domain is
resolved when opening the add form, it redirects to the Domain admin page.

## Fields (base fields)
- `domain` (list_string, **required**) — select from the Domain module's active
  domains (`domain` storage `loadOptionsList()`). Scopes the record to one domain.
- `route_link` (string, **required**) — the path, e.g. `/user`. Must start with `/`
  and resolve to an existing route; unique per domain.
- `title` (string, **required**) — Meta Title → `<meta name="title">` (NOT the page `<title>`).
- `description` (string_long, **required**) — → `<meta name="description">`.
- `keywords` (string_long) — comma-separated → `<meta name="keywords">`.
- `canonical` (string_long) — a path; served as `<link rel="canonical" href="{domain}{canonical}">`.
- `og_title` / `og_description` / `og_image_url` — → `og:title` / `og:description` / `og:image`.
- `og_url` (string_long) — a path; emitted as `og:url` prefixed with the domain scheme+hostname.
- `twitter_title` / `twitter_description` — → `twitter:title` / `twitter:description`.
- `fb_id` (string_long) — → `<meta name="fb:app_id">`.
- `is_cachable` (boolean, default FALSE) — see caching below.
- `user_id` (entity_reference → user) — owner, auto-set to current user on create.
- `langcode` — the add/edit form exposes a language selector.

Empty fields are skipped (each getter returns NULL when blank), so only populated
tags are emitted.

## How matching & output work (runtime)
`domain_route_meta_tag_page_attachments_alter()` (in `.module`) runs on every page:
1. Reads the active domain from the `domain.negotiator` service. No active domain → nothing.
2. Builds a cache key `str_replace('/', '_', domain_id . current_path)` and checks `cache.default`.
3. On a cache miss, `DomainRouteMetaHelper::getInstance()->getMetaEntity()` loads a record by
   `loadByProperties(['route_link' => <current path alias>, 'domain' => <active domain>])`;
   if none, it retries with the internal current path. First match wins.
4. `getEntityData()` returns `meta` (name→content pairs) and `link` (canonical). The hook
   appends each non-null meta value as `#attached['html_head']` (`<meta name content>`) and the
   canonical as `#attached['html_head_link']` (`rel`/`href`). Values are placed in render-array
   attributes, so core escapes them.

The module also implements `hook_module_implements_alter()` to run its
`page_attachments_alter` last.

## Save-time validation (`DomainRouteMetaTagForm`)
`route_link`, `canonical` and `og_url` are each validated: must start with `/`, must be a
valid existing URL (`path.validator` `getUrlIfValid()`), and `(route_link, domain)` must be
unique (edit form allows the record's own unchanged value).

## Caching
If **Is Cachable** is checked, `save()` writes `getEntityData()` to `cache.default` under the
domain+path key with a 4-hour lifetime (`META_CACHE_DURATION = 14400`) and cache tag
`domain_route_meta_tag`. Otherwise every request runs the entity query.

## Requirements / scope
- `hook_requirements` errors on install/update/runtime if no Domain entity exists.
- README: intended for controller routes and Views pages; for nodes/taxonomy use Metatag.
