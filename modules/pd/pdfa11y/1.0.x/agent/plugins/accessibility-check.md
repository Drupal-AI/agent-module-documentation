# Plugin type: AccessibilityCheck

A check inspects one aspect of a parsed PDF and returns a pass/fail/error result.

- Manager: `plugin.manager.pdfa11y_check` = `Drupal\pdfa11y\AccessibilityCheckManager`
- Attribute: `Drupal\pdfa11y\Attribute\AccessibilityCheck` (id, label, description, category, weight, deriver)
- Interface: `Drupal\pdfa11y\AccessibilityCheckInterface` — `check(Document $document, string $fileUri): AccessibilityCheckResult`
- Base: `Drupal\pdfa11y\AccessibilityCheckBase` — provides `pass()`, `fail($msg, $severity)`, `notApplicable()`
- Discovery namespace: `Plugin/AccessibilityCheck`; alter hook: `pdfa11y_check_info`; cache bin key `pdfa11y_check_plugins`

A plugin only runs when its id is listed in `pdfa11y.settings:enabled_checks`. `$document` is a
`Smalot\PdfParser\Document`; `$fileUri` is the Drupal stream URI (use it to read the raw header, e.g.
via `PdfParserService::getPdfVersion()`).

## Built-in checks

| id | Label | Category | What it verifies |
|---|---|---|---|
| `tagged_pdf` | Tagged PDF | structure | Catalog `MarkInfo`/`Marked` present (logical structure tree exists). |
| `heading_structure` | Heading structure | structure | Structure tree present; headings start at H1 and skip no levels. Uses `PdfParserService` raw-byte fallback for ObjStm. |
| `document_title` | Document title | metadata | Info `Title` or XMP `dc:title` is non-empty. |
| `document_title_filename` | Document title is not a filename | metadata | Title does not end in a document extension (`.pdf`, `.docx`, …). |
| `document_language` | Document language | metadata | Catalog `Lang` set and non-empty. |
| `pdf_version` | PDF version | structure | `%PDF-x.y` header ≥ `min_pdf_version` (default 1.4). |

## Add a custom check

```php
namespace Drupal\my_module\Plugin\AccessibilityCheck;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\pdfa11y\AccessibilityCheckBase;
use Drupal\pdfa11y\AccessibilityCheckResult;
use Drupal\pdfa11y\Attribute\AccessibilityCheck;
use Smalot\PdfParser\Document;

#[AccessibilityCheck(
  id: 'alt_text',
  label: new TranslatableMarkup('Image alt text'),
  description: new TranslatableMarkup('Checks images carry alternate text.'),
  category: 'content',
  weight: 30,
)]
final class AltTextCheck extends AccessibilityCheckBase {

  public function check(Document $document, string $fileUri): AccessibilityCheckResult {
    // ... inspect $document ...
    return $ok ? $this->pass('All images have alt text.') : $this->fail('Some images lack alt text.');
  }
}
```

Implement `ContainerFactoryPluginInterface::create()` if the plugin needs services (as
`HeadingStructureCheck` and `PdfVersionCheck` do to inject `PdfParserService`). After adding the
class, enable it by appending its id to `pdfa11y.settings:enabled_checks`. Returning
`notApplicable()` opts the file out of producing a stored row for that check.
