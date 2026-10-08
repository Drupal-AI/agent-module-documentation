# Plugin types: PrintableFormat & PrintableLinkExtractor

Printable defines two annotation-based plugin types, each with its own manager service.

## 1. PrintableFormat — output formats

- Manager service: `printable.format_plugin_manager`
  (`\Drupal\printable\PrintableFormatPluginManager`).
- Directory: `src/Plugin/PrintableFormat/`. Interface:
  `\Drupal\printable\Plugin\PrintableFormatInterface`. Base:
  `\Drupal\printable\Plugin\PrintableFormatBase`. Annotation:
  `@PrintableFormat`.
- Shipped formats:
  - `print` (this module) — `PrintFormat`, renders a themeable HTML print page.
  - `pdf` (in the **`printable_pdf`** submodule) — `PdfFormat`, streams a PDF via pdf_api.

The plugin id is the `{format}` slug in `/{entity}/printable/{format}`. Per-plugin config is
merged from the `printable.format` config on `createInstance()`.

### Implement a format

```php
namespace Drupal\my_module\Plugin\PrintableFormat;

use Drupal\printable\Plugin\PrintableFormatBase;

/**
 * @PrintableFormat(
 *   id = "epub",
 *   module = "my_module",
 *   title = @Translation("ePub"),
 *   description = @Translation("Downloadable ePub version."),
 * )
 */
class EpubFormat extends PrintableFormatBase {
  public function getResponse() { /* build and return a Symfony Response */ }
  // implement setContent(), getOutput(), calculateDependencies(),
  // and the buildConfigurationForm()/submit hooks as needed.
}
```

Your format then gets its own `/{entity}/printable/epub` link automatically.

## 2. PrintableLinkExtractor — in-content link rewriting

- Manager service: `printable.link_extractor_plugin_manager`.
- Directory: `src/Plugin/PrintableLinkExtractor/`. Interface:
  `PrintableLinkExtractorInterface`. Base: `PrintableLinkExtractorBase`. Annotation:
  `@PrintableLinkExtractor` (has a `weight`).
- Chosen via `printable.settings.extract_links`. Shipped ids:

| id | Class | Effect on `<a href>` in print output |
|---|---|---|
| `none` | `...ExtractorNone` | Leave links unchanged (weight 100 = default) |
| `remove` | `...ExtractorRemove` | Delete the `href` attribute |
| `extract` | `...ExtractorExtract` | Show the URL in brackets after the link text |
| `subscript` | `...ExtractorSubscript` | Render the reference as a subscript |

### Implement an extractor

```php
/**
 * @PrintableLinkExtractor(
 *   id = "footnote",
 *   module = "my_module",
 *   title = @Translation("Footnote"),
 *   description = @Translation("Collect links as numbered footnotes."),
 *   weight = 0,
 * )
 */
class FootnoteExtractor extends PrintableLinkExtractorBase { /* extract() logic */ }
```

Both managers are standard `DefaultPluginManager`s, so add a plugin class in the right
namespace with the right annotation and clear caches — no service registration needed.
