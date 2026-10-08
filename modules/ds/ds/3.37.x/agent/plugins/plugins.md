# Display Suite plugin types

DS defines two plugin types (managers in `ds.services.yml`: `plugin.manager.ds`,
`plugin.manager.ds.field.layout`). Both support attribute (`src/Attribute/`) and legacy
annotation (`src/Annotation/`) discovery.

## DsField — a placeable display field
Provides a value/markup that can be dragged into a layout region on any entity display.

- Attribute: `Drupal\ds\Attribute\DsField` (or annotation `@DsField`).
- Base class: `Drupal\ds\Plugin\DsField\DsFieldBase` (implements `DsFieldInterface`).
- Location: `src/Plugin/DsField/`.
- Key properties: `id`, `title`, `entity_type` (which entity types it applies to), optional `provider`, `ui_limit`.
- Implement `build()` to return a render array; `settingsForm()` / `settingsSummary()` for per-instance config.

Example skeleton:
```php
namespace Drupal\my_module\Plugin\DsField;

use Drupal\ds\Attribute\DsField;
use Drupal\ds\Plugin\DsField\DsFieldBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[DsField(
  id: 'my_reading_time',
  title: new TranslatableMarkup('Reading time'),
  entity_type: 'node',
)]
class ReadingTime extends DsFieldBase {
  public function build() {
    return ['#markup' => $this->minutes() . ' min read'];
  }
}
```

## DsFieldTemplate — field markup wrapper
Controls the HTML wrapper, label placement, and classes applied when a field is rendered.

- Attribute: `Drupal\ds\Attribute\DsFieldTemplate` (or annotation `@DsFieldTemplate`).
- Location: `src/Plugin/DsFieldTemplate/` (core options: default, minimal, reset, expert).
- Implement the form/preprocess methods to expose options (e.g. wrapper tags, classes) shown per field on Manage display.

## Also
`DsLayout` (`src/Plugin/DsLayout.php`) is DS's layout plugin class used by the layouts in
`ds.layouts.yml`; you add new layouts via the core Layout API, not a DS-specific plugin type.
