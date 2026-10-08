# The Bricks field: type, widgets, formatter, per-item options

No settings page (`configure` null). You add a **Bricks** field to an entity bundle, pick a widget on
*Manage form display* and the Bricks formatter on *Manage display*.

## Field type

| id | class | Notes |
|---|---|---|
| `bricks` | `BricksTreeItem` (extends core `EntityReferenceItem`) | default widget `entity_reference_autocomplete`, default formatter `bricks_nested` |

`BricksFieldTypeTrait` adds two extra columns/properties to the entity-reference storage:
- `depth` — tinyint, the item's nesting level (managed by drag indentation + depth correction).
- `options` — a serialized blob holding per-item `view_mode`, `layout`, `css_class`, `css_id`.

Preconfigured field options are the core entity-reference ones with " (bricks)" appended.

Related field types from submodules: `bricks_revisioned` (bricks_revisions),
`bricks_dynamic` (bricks_dynamic).

## Widgets

Bricks does NOT require a special widget — `bricks_field_widget_info_alter()` adds the `bricks` type to
**every** widget that supports `entity_reference` (and `bricks_revisioned` to every
`entity_reference_revisions` widget). Whatever widget you choose, the widget-form alters add the tree UI:

- `_bricks_form_element_alter()` injects a hidden `depth` field (class `bricks-depth`) and an inline
  `options` container with: a `view_mode` select (for non-`layout` bundles), a `layout` select (for a
  `layout` bundle when `layout_discovery` is on), and `css_class` / `css_id` textfields.
- `_bricks_preprocess_tabledrag_form()` turns the multi-value form into an indentable tabledrag table
  (Depth column, `bricks/tabledrag.relationship-all` library) so editors drag + indent items.
- `bricks_tree_autocomplete` (`BricksTreeAutocompleteWidget`) still exists but is DEPRECATED in favour of
  the generic `entity_reference_autocomplete`.
- Submodule widgets: `bricks_tree_inline` (IEF), `bricks_tree_paragraphs`, `bricks_tree_dynamic` /
  `bricks_tree_dynamic_inline`.

## Formatter

| id | class | Output |
|---|---|---|
| `bricks_nested` | `BricksNestedFormatter` (extends `EntityReferenceEntityFormatter`) | referenced entities rendered recursively as a nested tree |

`bricks_preprocess_field()` detects any formatter whose id starts with `bricks_` and runs
`Bricks::nestItems()` over the rendered items to build the nesting. Submodule formatters:
`bricks_nested_dynamic`, `bricks_revisions_nested`.

## Per-item `options`

Set inline in the widget per row; stored in the serialized `options` blob and applied at render
(`Bricks::newElement()`):
- `view_mode` — override the view mode for that referenced entity.
- `layout` — for a `layout`-bundle item, the Layout API layout to build (children go into its regions).
- `css_class` / `css_id` — added to the brick wrapper; plus auto classes `brick`,
  `brick--type--<bundle>`, `brick--id--<id>`.

## Add a Bricks field (Drush example)

```php
// drush php:eval — add a bricks field referencing block_content to node.page.
$fs = \Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_bricks', 'entity_type' => 'node', 'type' => 'bricks',
  'cardinality' => -1, 'settings' => ['target_type' => 'block_content'],
]); $fs->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_storage' => $fs, 'bundle' => 'page', 'label' => 'Bricks',
])->save();
// Then set widget (any entity_reference widget) + the bricks_nested formatter on the displays.
```
