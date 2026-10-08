<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Coder plugin type

Facets Pretty Paths defines **one plugin type**: the *coder*. A coder turns a facet's raw
value into a URL segment (`encode`) and back (`decode`). It also ships one plugin *of the
Facets `url_processor` type* (`facets_pretty_paths`) — that is not a new plugin type, it is
an instance the Facets manager discovers; see [../configure/pretty-paths.md](../configure/pretty-paths.md).

## Coder plugin type at a glance

| Aspect | Value |
|---|---|
| Plugin type id / dir | `facets_pretty_paths_coder` — namespace `Plugin/facets_pretty_paths/coder` |
| Annotation | `@FacetsPrettyPathsCoder` (`src/Annotation/FacetsPrettyPathsCoder.php`) — props `id`, `label`, `description` |
| Manager service | `plugin.manager.facets_pretty_paths.coder` (`CoderPluginManager`) |
| Interface | `Drupal\facets_pretty_paths\Coder\CoderInterface` — `encode($id)`, `decode($alias)` |
| Base class | `Drupal\facets_pretty_paths\Coder\CoderPluginBase` (extends Facets' `ProcessorPluginBase`) |
| Required props | `id`, `label` (manager throws `PluginException` if missing) |

## Bundled coders

| id | label | segment example |
|---|---|---|
| `default_coder` | Default | `/color/2` (raw value, no processing) |
| `url_encoded_coder` | URL encoded | `/color/2` but urlencoded — safe for reserved chars |
| `taxonomy_term_coder` | Taxonomy term name + id | `/color/blue-2` |
| `taxonomy_term_name_coder` | Taxonomy term name | `/color/blue` |
| `node_title_coder` | Node title + id | `/author/jane-doe-7` |
| `list_item_coder` | List item + id | `/size/large-3` |

The `*-id` coders `decode()` by splitting on the last `-` and popping the id, so the human
part is cosmetic and the trailing id is authoritative. Term/node coders use
`pathauto.alias_cleaner` (hence the pathauto dependency) to slugify labels and translate
term names to the current context language.

## Write a custom coder

Drop a class in `your_module/src/Plugin/facets_pretty_paths/coder/`:

```php
namespace Drupal\your_module\Plugin\facets_pretty_paths\coder;

use Drupal\facets_pretty_paths\Coder\CoderPluginBase;

/**
 * @FacetsPrettyPathsCoder(
 *   id = "my_coder",
 *   label = @Translation("My coder"),
 *   description = @Translation("Use a custom slug, e.g. /color/my-blue")
 * )
 */
class MyCoder extends CoderPluginBase {

  public function encode($id) {
    // raw facet value -> URL segment
    return \Drupal::service('pathauto.alias_cleaner')->cleanString($id);
  }

  public function decode($alias) {
    // URL segment -> raw facet value
    return $alias;
  }

}
```

`encode`/`decode` must round-trip (decoding an encoded value must yield the original raw
value the search backend expects). After adding the plugin, `drush cr`, then select it on
the facet's edit form or set the third-party setting `facets_pretty_paths.coder = my_coder`
(see [../configure/pretty-paths.md](../configure/pretty-paths.md)).
