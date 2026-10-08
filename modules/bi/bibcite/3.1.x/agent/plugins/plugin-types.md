<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types defined by bibcite core

Bibcite core defines **two** plugin types.

## 1. `bibcite_processor` — citation renderers

- Manager: `plugin.manager.bibcite_processor` (`BibCiteProcessorManager`, a standard
  attribute/annotation plugin manager). Discovery: `src/Plugin/BibCiteProcessor/`.
- Attribute: `Drupal\bibcite\Attribute\BibCiteProcessor(id, label)` (legacy annotation
  `@BibCiteProcessor` also supported).
- Interface: `BibCiteProcessorInterface` — implement `render($data, $csl, $lang)` (return the
  citation HTML string), `getDescription()`, `getPluginLabel()`. Base class:
  `BibCiteProcessorBase`.
- Shipped plugin: **`citeproc-php`** (`Plugin/BibCiteProcessor/CiteprocPhp.php`) — wraps
  `Seboettg\CiteProc\CiteProc`; strips CSL date fields with out-of-range month/day so malformed
  dates don't crash rendering. It is the default `processor` in `bibcite.settings`.

Minimal custom processor:

```php
namespace Drupal\my_module\Plugin\BibCiteProcessor;

use Drupal\bibcite\Attribute\BibCiteProcessor;
use Drupal\bibcite\Plugin\BibCiteProcessorBase;
use Drupal\bibcite\Plugin\BibCiteProcessorInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[BibCiteProcessor(id: 'my_processor', label: new TranslatableMarkup('My processor'))]
class MyProcessor extends BibCiteProcessorBase implements BibCiteProcessorInterface {
  public function getDescription() { return $this->t('...'); }
  public function render($data, $csl, $lang) { /* return citation HTML */ }
}
```

Select it site-wide by setting `bibcite.settings:processor` to `my_processor`.

## 2. `bibcite_format` — import/export formats

- Manager: `plugin.manager.bibcite_format` (`BibciteFormatManager`). Discovery is **YAML**:
  `<module>.bibcite_format.yml` files (`YamlDiscovery` + derivative decorator), not PHP classes.
- Plugin object: `BibciteFormat` (`BibciteFormatInterface`) — `getFields()`, `getTypes()`,
  `getLabel()`, `getExtension()`, `isExportFormat()` / `isImportFormat()` (decided by whether the
  `encoder` class is a Symfony `EncoderInterface` / `DecoderInterface`).
- A format definition (see the bibtex/endnote/marc/ris submodules) declares:
  `id`, `label`, `extension`, `encoder` (FQCN), optional `normalizer`, and `types` / `fields`
  lists. Example (`bibcite_bibtex.bibcite_format.yml`):
  ```yaml
  bibtex:
    id: bibtex
    label: BibTeX
    extension: bib
    encoder: \Drupal\bibcite_bibtex\Encoder\BibtexEncoder
    types: [article, book, ...]
    fields: [author, title, year, ...]
  ```
- Manager helpers: `getExportDefinitions()` (encoders that are `EncoderInterface`),
  `getImportDefinitions()` (encoders that are `DecoderInterface`).

List the registered formats:

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("plugin.manager.bibcite_format")->getDefinitions()));'
# bibtex,endnote8,endnote7,tagged,marc,ris  (with all format submodules enabled)
```

The `{bibcite_format}` route slug is resolved to a format plugin by the
`bibcite.format_param_converter` service.
