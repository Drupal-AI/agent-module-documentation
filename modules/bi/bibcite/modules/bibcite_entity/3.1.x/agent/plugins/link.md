<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bibcite_link` plugin type

Bibcite_entity defines one plugin type for **external links attached to a rendered reference**
(e.g. a DOI resolver link, a Google Scholar search link).

- Manager: `plugin.manager.bibcite_link` (`BibciteLinkPluginManager`, a standard plugin manager).
- Discovery directory: `src/Plugin/bibcite/link/`.
- Attribute: `Drupal\bibcite_entity\Attribute\BibciteLink` (legacy annotation
  `Drupal\bibcite_entity\Annotation\BibciteLink` also supported).
- Interface: `BibciteLinkPluginInterface`; base class `BibciteLinkPluginBase`.
- Alter hook: `hook_bibcite_entity_bibcite_link_info_alter()`.

## Shipped plugins

| Plugin id | Links to |
|---|---|
| `doi` | doi.org resolver for the reference's DOI |
| `google_scholar` | Google Scholar search |
| `pubmed` | PubMed record |
| `pubmedcentral` | PubMed Central record |

(The `bibcite_export` submodule adds `export:*` derivatives to the same link list so a reference
can be exported in each format from its display.)

List them live:

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("plugin.manager.bibcite_link")->getDefinitions()));'
# google_scholar,doi,pubmed,pubmedcentral,export:bibtex,export:endnote8,...
```

## Add a custom link plugin

```php
namespace Drupal\my_module\Plugin\bibcite\link;

use Drupal\bibcite_entity\Attribute\BibciteLink;
use Drupal\bibcite_entity\Plugin\BibciteLinkPluginBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[BibciteLink(id: 'my_link', label: new TranslatableMarkup('My link'))]
class MyLink extends BibciteLinkPluginBase {
  // implement the interface methods to build the link from a reference
}
```

The links are rendered by the `Links` Views field handler / the reference view builder.
