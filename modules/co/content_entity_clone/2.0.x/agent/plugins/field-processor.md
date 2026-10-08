# FieldProcessor plugin type

Field processors decide how a single field's values are carried onto a clone.

## Plugin registration

- Discovery: **PHP attribute** `#[ContentEntityCloneFieldProcessor(...)]`
  (`Drupal\content_entity_clone\Attribute\ContentEntityCloneFieldProcessor`) — this 2.x major uses
  attributes, not the old `@ContentEntityCloneFieldProcessor` annotation.
- Plugin namespace: `Plugin/content_entity_clone/FieldProcessor`.
- Interface: `Drupal\content_entity_clone\Plugin\FieldProcessorPluginInterface`.
- Base class: `Drupal\content_entity_clone\Plugin\FieldProcessorPluginBase`.
- Manager service: `Drupal\content_entity_clone\Plugin\FieldProcessorPluginManager`
  (implements `FieldProcessorPluginManagerInterface`; autowire by either interface or class).
  Deprecated alias `plugin.manager.content_entity_clone.field_processor` still resolves.
- Alter hook: `content_entity_clone_field_processor_info_alter` (see hooks/hooks.md).

## Attribute properties

```php
#[ContentEntityCloneFieldProcessor(
  id: 'my_processor',
  label: new TranslatableMarkup('My processor'),
  description: new TranslatableMarkup('What it does.'),
  fieldTypes: ['text', 'string'],   // optional; empty/omitted = applies to all field types
  // deriver: optional class-string
)]
```

## Interface

- `getPluginLabel(): string` — human label (base returns the definition `label` or the id).
- `supports(FieldDefinitionInterface $field_definition): bool` — whether it applies to a field
  (base class returns true when `fieldTypes` is empty or contains the field's type).
- `process(FieldItemListInterface $field): void` — mutate the (already-cloned) field item list in
  place; the caller copies the resulting values onto the new entity.

## Shipped processors

| id | Effect |
|---|---|
| `copy_values` | Copies the field values as-is (no processing). `supports()` excludes `layout_section` fields. |
| `entity_label_clone_suffix` | Appends ` [CLONE]` to the entity's **label** field only. Field types: `text`, `text_long`, `text_with_summary`, `string`, `string_long`; also verifies the field is the entity type's `label` key. |
| `clone_referenced_entities` | Replaces each referenced entity with `createDuplicate()`. Field types: `entity_reference`, `entity_reference_revisions`. |
| `copy_layout` | Copies a Layout Builder `layout_section` field; gives each cloned component a fresh UUID and **deep-clones inline content blocks** (`inline_block:*` from `layout_builder`), saving new `block_content` entities — honoring that bundle's own clone config if enabled, else `createDuplicate()`. Field type: `layout_section`. |

## Manager methods

- `getAvailablePlugins(FieldDefinitionInterface $field_definition): array` — processor instances
  whose `supports()` matches (used by the bundle settings form). Instances are built once per request.
- `processField(string $plugin_id, FieldItemListInterface $field): void` — instantiate the
  processor and run `process()` on the field (no-op if the id is unknown).

## Writing one

```php
namespace Drupal\my_module\Plugin\content_entity_clone\FieldProcessor;

use Drupal\content_entity_clone\Attribute\ContentEntityCloneFieldProcessor;
use Drupal\content_entity_clone\Plugin\FieldProcessorPluginBase;
use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[ContentEntityCloneFieldProcessor(
  id: 'uppercase',
  label: new TranslatableMarkup('Uppercase'),
  description: new TranslatableMarkup('Make text field values uppercase.'),
  fieldTypes: ['string', 'text'],
)]
class Uppercase extends FieldProcessorPluginBase {

  public function process(FieldItemListInterface $field): void {
    foreach ($field as $item) {
      $item->value = mb_strtoupper($item->value);
    }
  }

}
```

Place it under `Plugin/content_entity_clone/FieldProcessor/`; it then appears as a selectable
processor for matching fields in the bundle settings form. Processors needing services implement
`ContainerFactoryPluginInterface` (see `EntityLabelCloneSuffix`, `CopyLayout`).
