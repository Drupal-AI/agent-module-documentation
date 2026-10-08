<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MD Sitemap — generator, caching, output

## Service `mdsitemap.generator` → `Drupal\mdsitemap\MdsitemapGenerator`

Constructor args (from `mdsitemap.services.yml`): `@cache.mdsitemap`, `@request_stack`,
`@entity_type.manager`, `@config.factory`. `cache.mdsitemap` is a dedicated bin created by
`['@cache_factory', get]` with argument `mdsitemap`.

### `generate(): string`

1. If cid `mdsitemap_sitemap` is in the bin, return it (array → `implode("\n", …)`, string as-is,
   else `''`). **No regeneration while cached.**
2. Resolve host: `requestStack->getCurrentRequest()->getSchemeAndHttpHost()` (empty if no request,
   e.g. some CLI contexts).
3. Read `url_suffix` (fallback `.md` if empty/non-string) and `entities` (fallback `[]`) from
   `mdsitemap.settings`.
4. For each `entity_type_id => bundles` (skip non-string type or empty bundle list):
   - `entityTypeManager->getDefinition()` — **skip unless it is a `ContentEntityTypeInterface`**
     (config entities are ignored even if selectable).
   - `getStorage()->getQuery()`; if the type `hasKey('status')` add `->condition('status', 1)`;
     then **`->accessCheck(TRUE)`**; `execute()`.
   - Load each id; if it is a `ContentEntityInterface`, its `bundle()` is in the selected list, and
     it `hasLinkTemplate('canonical')`, append
     `"- [%s](%s%s)"` = `label`, `host . toUrl()->toString()`, `suffix`.
5. `cacheBackend->set('mdsitemap_sitemap', $urls, Cache::PERMANENT, ['mdsitemap'])` and return
   `implode("\n", $urls)`.

**Output** is a Markdown bullet list, one entity per line, e.g.
`- [About us](https://example.com/about.md)`. The controller returns it verbatim.

## Controller `Controller\SitemapController::build()`

`new Response($generator->generate(), 200, ['Content-Type' => 'text/markdown'])`. No render array,
no theming — the response body is the raw generated string.

## Cache invalidation & warming

- `mdsitemap.module`: `hook_entity_insert/update/delete` each call
  `Cache::invalidateTags(['mdsitemap'])` — any entity change (any type) drops the sitemap.
- `EventSubscriber\EntityChangeSubscriber` subscribes to `entity.insert/update/delete` and calls
  `cacheBackend->deleteAll()` on the `mdsitemap` bin (a second, broader invalidation path).
- `SitemapSettingsForm::submitForm()` also `deleteAll()`s the bin on save.
- `hook_cron()` calls `generate()` to pre-warm the cache for a fast first request.

## Operating notes

- Nothing appears until you select bundles at `/admin/config/search/md-sitemap`; a fresh install
  returns an empty body.
- The list is flat (no `<lastmod>`/priority/XML — this is not an XML sitemap); it is intended to be
  consumed by LLM crawlers and referenced from `llms.txt`.
- URLs are absolute (scheme + host from the current request) with the configured suffix appended to
  the canonical path; pair with a Markdown page renderer (e.g. Markdownify) if you actually serve
  `.md` variants.
- Because generation is cached permanently until the next entity change / config save / manual
  clear, the sitemap reflects the state at generation time.
