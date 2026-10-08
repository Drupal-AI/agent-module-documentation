# Configuring the hierarchy field

There is **no admin settings page** (`configure: null`). You configure Entity Hierarchy by
adding an `entity_reference_hierarchy` field to a bundle and choosing its widget/formatter.

## Add the field (drush / PHP)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_parent',
  'entity_type' => 'node',
  'type' => 'entity_reference_hierarchy',   // the field type this module provides
  'settings' => ['target_type' => 'node'],  // parent is the SAME entity type
  'cardinality' => 1,                        // hierarchy is single-parent
])->save();

FieldConfig::create([
  'field_name' => 'field_parent',
  'entity_type' => 'node',
  'bundle' => 'page',
  'label' => 'Parent',
  'settings' => [
    'handler' => 'entity_hierarchy',                 // lineage-aware selection handler
    'handler_settings' => ['target_bundles' => ['page' => 'page']],
  ],
])->save();
```

`target_bundles` on the reference limits which bundles may be chosen as a parent; leaving it
empty allows any bundle of the target type.

## Field settings (`field.field_settings.entity_reference_hierarchy`)

| Key | Default | Meaning |
|---|---|---|
| `weight_min` | `-50` (`HIERARCHY_MIN_CHILD_WEIGHT`) | lowest allowed sibling weight |
| `weight_max` | `50` (`HIERARCHY_MAX_CHILD_WEIGHT`) | highest allowed sibling weight |
| `weight_label` | `Weight` | label for the weight sub-field |

The field stores an extra integer **`weight`** column (indexed) alongside the target id; it
orders siblings under the same parent.

## Widgets

- `entity_reference_hierarchy_autocomplete` (default) — autocomplete parent + weight.
- `entity_reference_hierarchy_select` — options select + weight.
- Both accept a boolean widget setting **`hide_weight`** — hide the weight field from editors
  (order is then managed only via the Reorder children screen).

## Formatter

- `entity_reference_hierarchy_label` (default) — renders the parent label; setting
  `weight_output` controls whether/how weight is shown.

## Reorder children UI

When a bundle has a hierarchy field, each entity of that type gets a **Reorder children**
local task at `<entity>/children` (route `entity.<entity_type>.entity_hierarchy_reorder`,
form `HierarchyChildrenForm`), a drag-and-drop table to set the weight/order of an entity's
direct children. It requires the permission **`reorder entity_hierarchy children`** plus
view access to the entity. Routes are added automatically by
`EntityHierarchyRouteProvider` for entity types that have a hierarchy field.

## Storage note

Each hierarchy field gets its own nested-set table `nested_set_<field>_<entity_type>`
(e.g. `nested_set_field_parent_node`). It is populated on entity save/delete — you never
edit it directly. See [../drush/commands.md](../drush/commands.md) to rebuild it.
