# `child_entity_generate` migrate process plugin

The module's only surface. A Migrate **process** plugin (`@MigrateProcessPlugin(id =
"child_entity_generate")`) that, for each incoming value, builds and **saves** a new entity and
returns the entity object. Class:
`src/Plugin/migrate/process/ChildEntityGenerate.php` — `transform()` at `:134`, `create()` (DI) at
`:124`.

Use it for entities that live only inside their parent (paragraphs, `field_collection` items,
referenced children) where you do **not** need to check for prior existence. It always creates and
saves — there is no lookup, no update-if-exists, no dedupe. (For that, use Migrate Plus's
`entity_generate`.) Its advantage over `entity_generate` is that it can generate an entity from an
**array of values** and map those sub-values onto destination fields.

## Configuration keys

All keys are read from `$this->configuration` inside `transform()`:

| Key | Required | Meaning |
|---|---|---|
| `entity_type` | yes | Machine id of the entity type to create (e.g. `paragraph`, `field_collection`, `node`). Passed to `entityTypeManager->getDefinition()` and `getStorage()` (`:135`, `:137`). |
| `bundle` | no | Bundle machine name. If truthy, stored under the entity type's bundle key (`$definition->getKey('bundle')`) (`:141`). |
| `destination` | no | If set (non-empty), the **whole** incoming `$value` is stored in this one destination property (`:145`). |
| `values` | no | Map of `destination_field: source_key`. For each pair the source value is resolved and set on `destination_field` (`:149`). |
| `default_values` | no | Map of `destination_field: literal_value`. Each literal is set verbatim, applied **after** `values` (`:163`). |

### How `values` resolves each `source_key` (`:149`–`:161`)

For a pair `destination_field: source_key`, the value is looked up in this order:

1. If the incoming `$value` is an **array** and `array_key_exists(source_key, $value)` → use
   `$value[source_key]`.
2. Else if `$value` is an **object** and `property_exists($value, source_key)` → use
   `$value->source_key`.
3. Else → `$row->get(source_key)` (read `source_key` from the whole migration Row).

So `source_key` names a sub-key of the array/object flowing into this plugin, and falls back to a
Row property. The resolved value is written with
`NestedArray::setValue($values, explode('/', destination_field), $fieldValue, TRUE)` — the `/`
(`Row::PROPERTY_SEPARATOR`) lets you target field columns like `field_body/format`.

### Order of precedence

`bundle` → `destination` → `values` → `default_values`. Because `default_values` runs last, a
literal there **overwrites** anything a `values` mapping set on the same destination field.

## Return value

`transform()` returns the **saved entity object** (`$entity`), not its id (`:167`–`:170`:
`$storage->create($values); $entity->save(); return $entity;`). Feed the field pipeline into an
entity-reference field on the destination, or chain it. Because it saves on every call, running the
same migration twice creates duplicate children (rollback deletes what the migration map tracked).

## Usage patterns (from the plugin's own docblock)

Map array sub-keys onto fields:

```yaml
destination:
  plugin: 'entity:node'
source:
  # a source plugin that yields structured rows
  fields:
    -
      faq_items:
        - { question: 'Some question', answer: 'Some answer' }
        - { question: 'Another question', answer: 'Another answer' }
process:
  field_faqs:
    plugin: child_entity_generate
    source: faq_items
    entity_type: field_collection
    bundle: faq
    values:
      field_faq_question: question
      field_faq_answer/value: answer
    default_values:
      field_faq_answer/format: basic_html
```

Store the whole value in one property (no field mapping):

```yaml
process:
  field_faqs:
    plugin: child_entity_generate
    source: questions            # e.g. a list of scalar strings
    entity_type: field_collection
    bundle: question
    destination: field_question
```

Pre-process values with `sub_process`, then generate:

```yaml
process:
  field_faqs:
    -
      plugin: sub_process
      source: faq_items
      process:
        entity:
          plugin: migration_lookup
          migration: faqs
          source: id
        isHighlighted: isHighlighted
    -
      plugin: child_entity_generate
      entity_type: field_collection
      bundle: faq
      values:
        field_faq_entity: entity
        field_faq_is_highlighted: isHighlighted
```

When the source yields a list, pair the plugin with `sub_process` (as above) or a multiple-value
pipeline so `transform()` runs once per child; each call produces one saved entity.

## Notes & gotchas

- `entity_type` is dereferenced directly (`$this->configuration['entity_type']`) with no default —
  omit it and the migration errors. `bundle`, `values`, `default_values`, `destination` are all
  optional (guarded with `??`/`empty()`).
- No `calculateDependencies()` / config schema is provided; the plugin does not register migration
  dependencies for the entities it creates.
- Runtime-verified on Drupal 11.x: module enabled at 1.0.3, and
  `plugin.manager.migrate.process` resolves `child_entity_generate` to the class above.
