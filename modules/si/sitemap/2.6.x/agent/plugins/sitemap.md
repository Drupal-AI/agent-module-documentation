# Sitemap plugin type

Each section of the sitemap page is a **Sitemap** plugin.

- Namespace: `Plugin/Sitemap`
- Attribute: `Drupal\sitemap\Attribute\Sitemap` (annotation `@Sitemap` also supported)
- Interface: `Drupal\sitemap\SitemapInterface` (extends `ConfigurableInterface`,
  `DependentPluginInterface`, `PluginInspectionInterface`)
- Base class: `Drupal\sitemap\SitemapBase`
- Manager: `plugin.manager.sitemap` (`Drupal\sitemap\SitemapManager`)

Attribute params: `id`, `title`, `description`, `weight`, `enabled`, `settings`
(default settings array), `deriver`, `menu`, `vocabulary`.

Interface methods to implement: `view()` (return a render array for the section),
`settingsForm()`, `settingsSummary()`, `getLabel()`, `getDescription()`.

Built-in plugins:
- `Frontpage` (`Plugin/Sitemap/Frontpage.php`) — front-page link + optional site feed.
- `Menu` (`Plugin/Sitemap/Menu.php`) — one instance per menu via `MenuSitemapDeriver`.
- `Vocabulary` (`Plugin/Sitemap/Vocabulary.php`) — one per vocabulary via
  `VocabularySitemapDeriver` (node counts, RSS, depth options).

```php
namespace Drupal\mymodule\Plugin\Sitemap;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\sitemap\Attribute\Sitemap;
use Drupal\sitemap\SitemapBase;

#[Sitemap(
  id: 'recent_content',
  title: new TranslatableMarkup('Recent content'),
  description: new TranslatableMarkup('Lists the latest published nodes.'),
  weight: 5,
  enabled: FALSE,
)]
class RecentContent extends SitemapBase {
  public function view() { return ['#markup' => '...']; }
}
```
Enable/order via the settings form ([../configure/settings.md](../configure/settings.md)).
Menu link trees use the `sitemap.menu.link_tree` service.
