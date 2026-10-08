# Diff plugin types

Diff defines two plugin types, both managed by `default_plugin_manager` subclasses and
discovered under `Plugin/diff/…`.

## FieldDiffBuilder — turn a field's values into comparable strings
- Manager: `plugin.manager.diff.builder` (`src/DiffBuilderManager.php`).
- Attribute: `Drupal\diff\Attribute\FieldDiffBuilder` (id, label, `field_types` array, weight).
  Legacy annotation `Drupal\diff\Annotation\FieldDiffBuilder` also supported.
- Interface: `FieldDiffBuilderInterface`; base class: `FieldDiffBuilderBase`.
- Namespace: `Drupal\{module}\Plugin\diff\Field\`.
- Implement `build(FieldItemListInterface $field_items): array` returning, per delta, an array
  of strings to compare. Optionally override `buildConfigurationForm()` for per-field settings.

```php
#[FieldDiffBuilder(
  id: 'text_field_diff_builder',
  label: new TranslatableMarkup('Text Field Diff'),
  field_types: ['text', 'text_long', 'text_with_summary'],
)]
class TextFieldBuilder extends FieldDiffBuilderBase {
  public function build(FieldItemListInterface $field_items): array {
    $result = [];
    foreach ($field_items as $key => $item) {
      $values = $item->getValue();
      $result[$key][] = $values['value'] ?? '';
    }
    return $result;
  }
}
```
Ships builders for text, text-with-summary, list, file, image, link, entity reference,
comment, and core fields (see `src/Plugin/diff/Field/`).

## DiffLayoutBuilder — how the comparison is displayed
- Manager: `plugin.manager.diff.layout` (`src/DiffLayoutManager.php`).
- Attribute: `Drupal\diff\Attribute\DiffLayoutBuilder` (id, label, description).
- Interface: `DiffLayoutInterface`; base class: `DiffLayoutBase`.
- Namespace: `Drupal\{module}\Plugin\diff\Layout\`.
- Implement `build(EntityInterface $left, EntityInterface $right, EntityInterface $entity): array`
  returning a render array. Ships `split_fields`, `unified_fields`, `visual_inline`
  (see `src/Plugin/diff/Layout/`). Enable/weight layouts in general settings.
