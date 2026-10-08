# Configure a weight field & sort by it

Weight has **no admin settings form** (`configure` is null). All configuration happens per
field, on the entity bundle you attach it to.

## Add the field (UI)

**Structure → [entity type] → Manage fields → Add field → General → Weight**, give it a label,
then set its options and save. The field type machine name is `weight`.

## Field settings

| Setting | Level | Default | Meaning |
|---|---|---|---|
| `range` | field (per bundle) | `20` | The widget offers every integer from `-range` to `+range`. Range `20` → weights `-20`…`20`. Stored as a string in config. |
| `unsigned` | storage (shared by all bundles of the field) | `false` | Restrict the DB column to non-negative integers. |

- Default widget: **Weight Selector** (`weight_selector`) — a `<select>` of all values in range.
- Default formatter: core `number_integer`. The module also ships a bare `default_weight`
  formatter that prints the raw value.
- Config schema: `field.field_settings.weight` (`range`) and `field.storage_settings.weight`
  (`unsigned`). Settings export/deploy with `drush config:export`.
- An empty item is treated as empty **except** the literal `0`, which is a valid stored weight.

## Actually ordering content

Storing a weight does not reorder anything by itself. To render entities in weight order, sort
your listing **ascending by the field's value**:

- In a **View**: add a Sort criterion on the weight field (the `<field>_value` column), ascending.
- In an **entityQuery** / DB query: `->sort('field_weight.value', 'ASC')`.

Lower weights float to the top; use negative weights to push items above the default `0`.

## Programmatic field creation

Standard core field API — no module-specific helper:

```php
FieldStorageConfig::create([
  'field_name' => 'field_weight',
  'entity_type' => 'node',
  'type' => 'weight',
  'settings' => ['unsigned' => FALSE],
])->save();

FieldConfig::create([
  'field_name' => 'field_weight',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Weight',
  'settings' => ['range' => 20],
])->save();
```

For drag-and-drop reordering in a Views table, see [../theming/weight.md](../theming/weight.md).
