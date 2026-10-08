# XML Sitemap hooks

From `xmlsitemap.api.php`. Implement these to contribute links or reshape output.

## Links
- `hook_xmlsitemap_link_info()` — declare link types/bundles your module manages (entity
  info, settings labels). The primary integration point for a custom entity type.
- `hook_xmlsitemap_link_alter(&$link, $entity)` — change a link before it's saved (priority,
  changefreq, access, status, loc).
- `hook_xmlsitemap_link_insert($link)` / `hook_xmlsitemap_link_update($link)` — react to link changes.
- `hook_xmlsitemap_index_links($limit)` — return additional links to index in a cron batch.
- `hook_xmlsitemap_rebuild_clear($entity_types, $save_custom)` — clean up during a full rebuild.

## Contexts (multiple sitemaps)
- `hook_xmlsitemap_context_info()` / `..._alter()` — define/alter available contexts (e.g. language, domain).
- `hook_xmlsitemap_context()` / `..._alter()` — provide the current request's context.
- `hook_xmlsitemap_context_url_options()` / `..._alter()` — URL options per context.

## Output shaping
- `hook_xmlsitemap_element_alter(&$element, $link, $sitemap)` — add/change `<url>` child elements.
- `hook_xmlsitemap_root_attributes_alter(&$attributes, $sitemap)` — alter the `<urlset>` root attributes/namespaces.
- `hook_query_xmlsitemap_generate_alter(QueryAlterableInterface $query)` — alter the generation query.

## Sitemap lifecycle
- `hook_xmlsitemap_sitemap_operations()` — add operations to the sitemap list.
- `hook_xmlsitemap_sitemap_delete($sitemaps)` — react to sitemap deletion.
