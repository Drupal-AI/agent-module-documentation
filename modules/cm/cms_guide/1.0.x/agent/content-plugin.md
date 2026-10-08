<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# @CMSGuideContent content-pack plugin

Companion modules contribute guide content through this plugin type, keeping site-specific
documentation out of the contrib `cms_guide` module itself and letting multiple packs coexist.

## Plugin infrastructure (source)

- **Manager**: `CMSGuideContentManager` (`src/Plugin/CMSGuideContentManager.php`), service
  `plugin.manager.cmsguide_content` (parent `default_plugin_manager`). Scans
  `Plugin/CMSGuideContent`, interface `CMSGuideContentInterface`, annotation
  `Annotation/CMSGuideContent`; alter hook `cms_guide_cmsguide_content_info`; cached in
  `cms_guide_cmsguide_content_plugins`.
- **Annotation** (`src/Annotation/CMSGuideContent.php`) properties: `id`, `label`, **`structure`**
  (path to the pack's `structure.yml`, relative to the providing module).
- **Base class**: `CMSGuideContentBase extends PluginBase` — plugins are essentially declarative;
  no methods to implement.

The import form reads plugin **definitions** only (`getDefinitions()`); it does not instantiate the
plugin objects. It uses the definition's `provider` (module name → path) and `structure` to locate
that pack's `structure.yml`, then loads content exactly like the default pack. `source` on each
resulting entity is set to the provider module's machine name.

## Minimal companion module

```
my_site_guide/
├── my_site_guide.info.yml            # dependencies: - cms_guide:cms_guide
├── content/
│   ├── structure.yml                 # the pack's table of contents
│   ├── getting-started/*.md          # Markdown, referenced from structure.yml
│   └── images/*.png                  # referenced via {{image_path}}/foo.png
└── src/Plugin/CMSGuideContent/MySiteContent.php
```

```php
namespace Drupal\my_site_guide\Plugin\CMSGuideContent;

use Drupal\cms_guide\Plugin\CMSGuideContentBase;

/**
 * @CMSGuideContent(
 *   id = "my_site_guide",
 *   label = @Translation("My Site Guide Content"),
 *   structure = "content/structure.yml"
 * )
 */
final class MySiteContent extends CMSGuideContentBase {}
```

After enabling the companion module, its entries appear as importable rows on
`/admin/structure/cms-guide/import` (see [import.md](import.md) for the `structure.yml` format and
refresh semantics). Slugs must be unique **across all packs** — the importer warns on duplicates and
imports only one.

## Alternative: the module's own content/ directory

The `cms_guide` module ships an empty `content/structure.yml`. You can populate it (and a
`content/` tree) directly, but that content lives in the contrib module and is overwritten on
update — the plugin approach is recommended.
