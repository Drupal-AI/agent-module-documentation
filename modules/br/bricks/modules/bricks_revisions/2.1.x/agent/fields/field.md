# The `bricks_revisioned` field type + revision behavior

`bricks_revisions` provides one field type and one extra formatter. There is no settings page —
you add the field to a bundle and pick widget/formatter on *Manage form display* / *Manage display*,
exactly like the core `bricks` field (see parent
[../../../../../2.1.x/agent/configure/field.md](../../../../../2.1.x/agent/configure/field.md)).

## Field type

| id | class | extends | default_widget | default_formatter |
|---|---|---|---|---|
| `bricks_revisioned` | `BricksTreeRevisionedItem` | core `EntityReferenceRevisionsItem` (ERR) + `BricksFieldTypeTrait` | `bricks_tree_autocomplete` | `bricks_nested` |

Annotation: label "Bricks (revisioned)", category `Reference revisions`,
`list_class = EntityReferenceFieldItemList`, implements `Drupal\bricks\BricksFieldItemInterface`.

The class body is empty — all Bricks behavior comes from the shared `BricksFieldTypeTrait` (in the
parent `bricks` module), so `bricks_revisioned` storage adds the same two extra columns/properties to
ERR's entity-reference-revisions storage:

- `depth` — tinyint unsigned; the item's nesting level in the drag tree.
- `options` — serialized blob of per-item `view_mode` / `layout` / `css_class` / `css_id`.

Preconfigured field options are ERR's own options with " (bricks)" appended to each label.

**Why ERR instead of plain entity_reference:** a `bricks` field references the *current* version of
each brick entity; a `bricks_revisioned` field references a specific *revision* of each brick. When
the host entity gets a new revision, ERR tracks the referenced brick revisions with it, so reverting
the host reverts its nested bricks too. Use this field type instead of `bricks` when brick edits must
be versioned and revertible alongside the page.

## Formatters

| id | class | extends | Notes |
|---|---|---|---|
| `bricks_nested` | `BricksNestedFormatter` (parent) | core `EntityReferenceEntityFormatter` | default formatter of the field; parent formatter, lists both `bricks` and `bricks_revisioned` |
| `bricks_revisions_nested` | `BricksRevisionsNestedFormatter` (this module) | `EntityReferenceRevisionsEntityFormatter` | ERR-aware; renders the referenced *revisions* recursively |

Both formatter classes are empty subclasses — nesting is applied by the parent's
`bricks_preprocess_field()`, which runs `Bricks::nestItems()` over any formatter whose id starts with
`bricks_` (see parent [../../../../../2.1.x/agent/api/rendering.md](../../../../../2.1.x/agent/api/rendering.md)).
Pick `bricks_revisions_nested` when you want rendering to resolve the referenced revision explicitly;
the default `bricks_nested` also works because it accepts the `bricks_revisioned` type.

## Widgets

No widget class is defined here. The default is the parent's deprecated
`bricks_tree_autocomplete`, but the parent's `bricks_field_widget_info_alter()` registers
`bricks_revisioned` with **every** `entity_reference_revisions`-capable widget, and the submodule
widgets (`bricks_tree_inline`, `bricks_tree_paragraphs`, `bricks_tree_dynamic` /
`bricks_tree_dynamic_inline`) also list `bricks_revisioned`. Whatever widget you choose, the parent's
tabledrag/tree alters inject the `depth` field and inline `options` UI.

## Config schema (`config/schema/bricks_revisions.schema.yml`)

| key | mapped type |
|---|---|
| `field.storage_settings.bricks_revisioned` | `field.storage_settings.entity_reference` |
| `field.field_settings.bricks_revisioned` | `field.field_settings.entity_reference` |
| `field.widget.settings.bricks_tree_autocomplete` | `field.widget.settings.entity_reference_autocomplete` |
| `field.formatter.settings.bricks_nested` | `field.formatter.settings.entity_reference_revisions_entity_view` |

Note the last row: this file **re-declares** the parent's `field.formatter.settings.bricks_nested`
key, remapping it from the entity_reference view schema to the ERR view schema. The submodule's own
`bricks_revisions_nested` formatter has no explicit settings-schema key of its own.

## Replicate integration (lives in the parent)

The parent `BricksServiceProvider` registers `replicate.event_subscriber.bricks`
(`Drupal\bricks\EventSubscriber\ReplicateFieldSubscriber`) only when the `replicate` module is
installed; that subscriber listens on `ReplicatorEvents::replicateEntityField('bricks_revisioned')`
and calls `onClone` (inherited from Paragraphs' base subscriber), so cloning a host entity duplicates
the referenced brick revisions correctly. This wiring targets the `bricks_revisioned` field
specifically.

## Add a revisioned Bricks field (Drush example)

```php
// drush php:eval — add a bricks_revisioned field referencing paragraphs to node.page.
$fs = \Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_bricks_rev', 'entity_type' => 'node', 'type' => 'bricks_revisioned',
  'cardinality' => -1, 'settings' => ['target_type' => 'paragraph'],
]); $fs->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_storage' => $fs, 'bundle' => 'page', 'label' => 'Bricks (revisioned)',
])->save();
// Then set an entity_reference_revisions widget + a bricks_nested / bricks_revisions_nested
// formatter on the form/view displays. The referenced target_type must be revisionable.
```
