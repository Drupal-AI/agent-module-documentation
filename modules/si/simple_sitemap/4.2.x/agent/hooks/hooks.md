# Hooks

Declared in `simple_sitemap.api.php`. Implement in `mymodule.module`.

| Hook | Purpose |
|---|---|
| `hook_simple_sitemap_entity_process(ContentEntityInterface $entity)` | Act on an entity before it is indexed; throw `SkipElementException` to exclude it, or mutate fields. |
| `hook_simple_sitemap_links_alter(array &$links, SimpleSitemapInterface $sitemap)` | Alter generated multilingual link data (loc, alternate_urls, lastmod) per chunk before write. |
| `hook_simple_sitemap_arbitrary_links_alter(array &$arbitrary_links, SimpleSitemapInterface $sitemap)` | Add arbitrary links (url, priority, lastmod, changefreq, images, alternate_urls) to a sitemap using the `arbitrary` URL generator. |
| `hook_simple_sitemap_attributes_alter(array &$attributes, SimpleSitemapInterface $sitemap)` | Add/change/remove root XML attributes/namespaces before document generation. |
| `hook_simple_sitemap_index_attributes_alter(array &$index_attributes, SimpleSitemapInterface $sitemap)` | Same for the sitemap **index** document. |
| `hook_simple_sitemap_url_generators_alter(array &$url_generators)` | Alter/remove registered URL generator plugins. |
| `hook_simple_sitemap_sitemap_generators_alter(array &$sitemap_generators)` | Alter/remove registered sitemap generator plugins. |

```php
use Drupal\simple_sitemap\Exception\SkipElementException;

function mymodule_simple_sitemap_entity_process(\Drupal\Core\Entity\ContentEntityInterface $entity): void {
  if (!$entity->hasTranslation('de')) {
    throw new SkipElementException();  // keep untranslated entities out
  }
}
```
