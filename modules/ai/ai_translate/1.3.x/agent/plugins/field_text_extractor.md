# Plugin type: `text_extractor` (FieldTextExtractor)

Defines how a field type's translatable text is extracted from an entity and written back after
translation. Manager `plugin.manager.text_extractor` (`FieldTextExtractorPluginManager`, extends the
default plugin manager). Discovery: attribute
`\Drupal\ai_translate\Attribute\FieldTextExtractor` on classes in
`Plugin/FieldTextExtractor/`. Interface: `FieldTextExtractorInterface`; base class `FieldExtractorBase`.

## Attribute

```php
#[FieldTextExtractor(
  id: "text",
  label: new TranslatableMarkup('Text'),
  field_types: ['title', 'text', 'text_long', 'string', 'string_long'],
  deriver: NULL, // optional
)]
```

Gotcha (from the attribute docblock): the plugin `id` must equal the group or be prefixed with it
(`foo` or `foo:bar`) or the plugin will not be discovered.

## Interface methods (implement or inherit from `FieldExtractorBase`)

- `getColumns(): array` — field-item columns holding translatable text (e.g. `['value']`,
  `['value', 'summary']`, `['title']`). Base `extract()` uses this.
- `extract(ContentEntityInterface $entity, string $fieldName): array` — per-delta metadata; base
  implementation returns `['delta' => n, '_columns' => …] + $item->getValue()`.
- `setValue(ContentEntityInterface $entity, string $fieldName, array $textMeta): void` — merge
  translated columns back into the field (e.g. `TextFieldExtractor` also trims to `max_length`).
- `shouldExtract(ContentEntityInterface $entity, FieldConfigInterface $fieldDefinition): bool` —
  base returns `$fieldDefinition->isTranslatable()`.

## Shipped plugins (`Plugin/FieldTextExtractor/`)

`TextFieldExtractor` (title/text/string), `TextWithSummaryExtractor`, `LinkTextExtractor`,
`ImageTextExtractor` (alt/title), `FileTextExtractor`, `ReferenceFieldExtractor` (recurses into
referenced entities honoring `entity_reference_depth`), `LbFieldExtractor` (Layout Builder).

## Minimal custom extractor

```php
#[FieldTextExtractor(id: "my_field", label: new TranslatableMarkup('My field'), field_types: ['my_field_type'])]
class MyFieldExtractor extends FieldExtractorBase {
  public function getColumns(): array { return ['value']; }
  public function setValue(ContentEntityInterface $entity, string $fieldName, array $textMeta): void {
    $v = $entity->get($fieldName)->getValue();
    foreach ($textMeta as $delta => $single) { $v[$delta] = ($v[$delta] ?? []) + $single; }
    $entity->set($fieldName, $v);
  }
}
```
