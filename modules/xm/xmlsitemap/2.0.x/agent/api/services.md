# XML Sitemap API — services

## `xmlsitemap.link_storage` — `XmlSitemapLinkStorageInterface`
Reads/writes rows in the sitemap link table.
- `save(array $link, ...)` — insert/update a link (`type`, `id`, `loc`, `priority`,
  `changefreq`, `changecount`, `language`, `access`, `status`, ...).
- `load($entity_type, $entity_id)` / `loadMultiple(array $conditions)` — fetch links.
- `delete($entity_type, $entity_id)` / `deleteMultiple(array $conditions)` — remove links.
- `checkChangedLink(...)`, `updateMultiple(...)` — bulk maintenance used during indexing.
- `createLink(EntityInterface $entity)` — build a link array from an entity.

## `xmlsitemap_generator` — `XmlSitemapGeneratorInterface`
Produces the actual XML files from the link table.
- `regenerateSitemap()` — regenerate all sitemap files.
- `generateSitemap(XmlSitemapInterface $sitemap)` — (re)generate one sitemap.
- `generatePage(XmlSitemapInterface $sitemap, $page)` — write one chunk/page.
- `generateIndex(...)` — write the sitemap index file.
- `getSitemapChunkFile(...)`, helpers for chunk file paths and cache flags.

Contrib modules usually contribute links via hooks (see [../hooks/hooks.md](../hooks/hooks.md))
rather than calling the storage directly. The config entity is `Drupal\xmlsitemap\Entity\XmlSitemap`
(`XmlSitemapInterface`).
