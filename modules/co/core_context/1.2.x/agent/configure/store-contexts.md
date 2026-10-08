# Store contexts on an entity

There is no UI. A context is a ctools context configuration:

```yaml
<context_key>:
  type: string          # a data type: 'string', 'integer', 'entity:node', 'boolean', ...
  label: 'My Context'
  description: ''
  value: 'hello'        # for entity:* types, the entity UUID
```

`type`, `label`, `description`, `value` are mapped by `ctools.context_mapper->getContextValues()`
into `\Drupal\Core\Plugin\Context\Context` objects (or `EntityLazyLoadContext` when `type`
begins with `entity:`).

## On a config entity — third-party settings (`SettingsContextHandler`)

Any config entity implementing `ThirdPartySettingsInterface` (entity view/form displays, content
types, menus, …) stores contexts under third-party setting `core_context` / `contexts`. Schema:
`core_context.sequence` (a sequence of `ctools.context`).

```php
$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$display->setThirdPartySetting('core_context', 'contexts', [
  'my_flag' => ['type' => 'string', 'label' => 'My Flag', 'description' => '', 'value' => 'on'],
]);
$display->save();
```

```bash
drush cget core.entity_view_display.node.article.default third_party_settings.core_context
```

Remove with `$display->unsetThirdPartySetting('core_context', 'contexts')` then `save()`.

## On a fieldable entity — the `context` field type (`FieldContextHandler`)

Fieldable entities store contexts in a field of the module's `context` field type (`id = context`,
`no_ui = TRUE`, unlimited cardinality). Because the field is `no_ui`, add it programmatically:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_contexts', 'entity_type' => 'node', 'type' => 'context',
])->save();
FieldConfig::create([
  'field_name' => 'field_contexts', 'entity_type' => 'node', 'bundle' => 'article',
])->save();

$node->field_contexts->appendItem([
  'id' => 'my_flag', 'type' => 'string', 'label' => 'My Flag', 'description' => '', 'value' => 'on',
]);
$node->save();
```

`FieldContextHandler` reads the **first** field of type `context` on the entity
(`getFieldMapByFieldType('context')`), so typically one such field per entity type. Each item's
`id` becomes the context key.

## Column/property shape of a `context` field item

`id`, `type`, `label` (varchar 255, required), `description` (text), `value` (serialized blob).
