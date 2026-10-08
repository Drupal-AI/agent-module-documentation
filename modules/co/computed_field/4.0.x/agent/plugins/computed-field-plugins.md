# plugins — writing a computed field plugin

A computed field's value is produced by a `computed_field` plugin.

- **Namespace:** `Drupal\{module}\Plugin\ComputedField\` (discovered by manager
  `plugin.manager.computed_field`).
- **Attribute:** `Drupal\computed_field\Attribute\ComputedField` (a legacy annotation of the
  same name also works).
- **Base class:** `Drupal\computed_field\Plugin\ComputedField\ComputedFieldBase`
  (implements `ComputedFieldPluginInterface`).
- **Alter:** `hook_computed_field_info_alter(array &$info)` to change definitions.

## The attribute

```php
#[ComputedField(
  id: 'my_plugin',
  label: new TranslatableMarkup('My plugin'),
  field_type: 'string',        // any CORE field type — reused for storage/formatters
  no_ui: FALSE,                // TRUE = hide from the Field UI add form
  cardinality: 1,              // -1 for unlimited
  attach: NULL,                // set for AUTOMATIC attachment (see below)
)]
```

`field_type` is a normal field type id (`string`, `integer`, `entity_reference`, `text`,
`link`, `datetime`, …). No data is stored — the type only decides which formatters/settings
apply.

## computeValue()

Return an array of values indexed by delta:

```php
public function computeValue(EntityInterface $host_entity, ComputedFieldDefinitionWithValuePluginInterface $computed_field_definition): array {
  return [
    0 => $host_entity->label() . '!',   // scalar => primary property
    // multi-property types use ['value' => …, 'format' => …]
  ];
}
```

For a single value, instead `use SingleValueTrait;` and implement
`singleComputeValue()` (return the scalar, or `NULL` for an empty field).

The second argument is the field definition; **for configured plugins it is the
`computed_field` config entity**, so `$computed_field_definition->getName()` and the plugin's
own `$this->configuration` are available.

## Two attach modes

**1. Automatically attached** — the plugin declares where it lives via `attach`; no config
entity, no UI step:

```php
attach: [
  'scope' => 'bundle',                       // 'base' or 'bundle'
  'field_name' => 'my_computed',
  'entity_types' => ['node' => ['article', 'page']],  // base: values are []
  // 'dynamic' => TRUE                        // instead of entity_types; then override
  //                                          // attachAsBaseField()/attachAsBundleField()
]
```

Base-field plugins attach to whole entity types; bundle-field plugins to listed bundles.
Set `no_ui: TRUE` to keep an automatic plugin out of the admin add form.

**2. Configured attaching** — omit `attach`; a site admin adds the field (UI submodule or
code), creating a `computed_field` config entity that stores `plugin_id` + `plugin_config`.
A configured field is always a **bundle** field. To be admin-configurable the plugin must
implement **both** `\Drupal\Component\Plugin\ConfigurableInterface` and
`\Drupal\Core\Plugin\PluginFormInterface` (and provide config schema at
`computed_field.computed_field_plugin.{plugin_id}`).

## Cacheability / dynamic values

Override `useLazyBuilder()` to return `TRUE` and `getCacheability()` to return a
`CacheableMetadata` when the value is dynamic or depends on more than the host entity
(per-user output, list cache tags, etc.). Default: cached with the host entity.

## Other overridable hooks

`getFieldCardinality()`, `getStorageDefinitionSettings()`, `getFieldDefinitionSettings()`
let the plugin influence the resulting field's storage/instance settings.

## Bundled example: `reverse_entity_reference`

`Drupal\computed_field\Plugin\ComputedField\ReverseEntityReference` — a **configured,
configurable** plugin, `field_type: entity_reference`. Config key `reference_field` is
`HOST_ENTITY_TYPE-FIELD_NAME` (e.g. `node-uid`); `computeValue()` queries all entities of
that type whose field references the host, returning their ids. It uses a lazy builder and
adds the referenced entity type's list cache tags.
