# Plugins — ParagraphsConversion

Conversion plugins transform one paragraph into one or more paragraphs (e.g. split a mixed
"text + image" paragraph into separate text and image paragraphs). Used by the paragraphs
convert workflow.

- **Manager service:** `plugin.manager.paragraphs.conversion`
  (`Drupal\paragraphs\ParagraphsConversionManager`).
- **Namespace:** `Plugin\paragraphs\Conversion`
- **Discovery:** attribute `#[Drupal\paragraphs\Attribute\ParagraphsConversion]`
  (annotation `@ParagraphsConversion` also supported).
- **Interface:** `ParagraphsConversionInterface`; **base:** `ParagraphsConversionBase`.

## Attribute params
`id`, `label` (TranslatableMarkup), `source_type` (string — the paragraph type this converts
from), `target_types` (array), optional `weight`, `deriver`.

## Key interface methods
- `supports(ParagraphInterface $paragraph, ?array $parent_allowed_types = NULL)` — whether
  this plugin can convert the given paragraph (respecting the parent field's allowed types).
- `buildConversionForm($paragraph, &$form, $form_state)` + `validateConversionForm()` —
  optional extra settings collected before converting.
- `convert(array $settings, ParagraphInterface $original_paragraph, ?array $converted_paragraphs = NULL)`
  — return the converted paragraph(s).

## Skeleton
```php
namespace Drupal\my_module\Plugin\paragraphs\Conversion;

use Drupal\paragraphs\ParagraphsConversionBase;
use Drupal\paragraphs\Attribute\ParagraphsConversion;
use Drupal\paragraphs\ParagraphInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[ParagraphsConversion(
  id: 'text_to_text_image',
  label: new TranslatableMarkup('Text to text+image'),
  source_type: 'text',
  target_types: ['text', 'image'],
)]
class TextToTextImage extends ParagraphsConversionBase {
  public function convert(array $settings, ParagraphInterface $original_paragraph, ?array $converted_paragraphs = NULL) {
    // Build and return converted paragraph entities.
  }
}
```

After conversion, [`hook_paragraphs_conversion_alter()`](../hooks/hooks.md) fires once per
converted paragraph. See `modules/paragraphs_demo/src/Plugin/paragraphs/Conversion/` for
working examples.
