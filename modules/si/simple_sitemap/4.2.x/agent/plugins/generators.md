# Plugins: URL generators & sitemap generators

The module defines two plugin types. A **sitemap type** (config entity) wires one
**SitemapGenerator** to a list of **UrlGenerator**s.

## UrlGenerator — produces the links to index
- Namespace: `Plugin/simple_sitemap/UrlGenerator`
- Annotation: `Drupal\simple_sitemap\Annotation\UrlGenerator` (`@UrlGenerator`)
- Manager: `plugin.manager.simple_sitemap.url_generator` (`UrlGeneratorManager`)
- Base classes: `UrlGeneratorBase`, `EntityUrlGeneratorBase`
- Alter hook: `hook_simple_sitemap_url_generators_alter`
- Core plugins: `entity`, `entity_menu_link_content`, `custom`, `arbitrary`,
  `sitemap_index` (submodule adds `views`).

```php
namespace Drupal\mymodule\Plugin\simple_sitemap\UrlGenerator;

use Drupal\simple_sitemap\Plugin\simple_sitemap\UrlGenerator\UrlGeneratorBase;

/**
 * @UrlGenerator(
 *   id = "my_urls",
 *   label = @Translation("My URL generator"),
 *   description = @Translation("Generates my URLs."),
 * )
 */
class MyUrlGenerator extends UrlGeneratorBase {
  public function getDataSets(): array { /* return items to process */ return []; }
  public function generate($data_set): array { /* return path/link arrays */ return []; }
}
```

## SitemapGenerator — writes the XML document
- Namespace: `Plugin/simple_sitemap/SitemapGenerator`
- Annotation: `Drupal\simple_sitemap\Annotation\SitemapGenerator` (`@SitemapGenerator`)
- Manager: `plugin.manager.simple_sitemap.sitemap_generator`
- Base class: `SitemapGeneratorBase`; core plugins: `default` (hreflang), `index`.
- Alter hook: `hook_simple_sitemap_sitemap_generators_alter`

After adding a plugin run `drush cr`, then attach it to a sitemap type at
`entity.simple_sitemap_type.collection` (see [../configure/sitemaps.md](../configure/sitemaps.md)).
Note: **sitemap types** themselves are config entities (`SimpleSitemapType`), not a plugin type.
