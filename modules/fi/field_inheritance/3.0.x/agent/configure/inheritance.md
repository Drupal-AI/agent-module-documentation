# Configure Field Inheritance

Two things are configured: the global **`field_inheritance.config`** object (which entity types can
participate), and one **`field_inheritance` config entity per inheritance**.

## Global settings — `field_inheritance.config`

```yaml
included_entities:      # entity types that get the base map field + appear as source/dest options
  - block_content
  - file
  - node
  - taxonomy_term
```

- Edited via the settings form `field_inheritance.settings`
  (`/admin/structure/field_inheritance/settings`), which routes through a **confirm** form
  (`field_inheritance.settings_confirm`) because changing it adds/removes the base
  `field_inheritance` map field on those entity types (`hook_entity_base_field_info()`).
- drush: `drush cget field_inheritance.config included_entities` /
  `drush cset field_inheritance.config included_entities.4 media -y` (then rebuild caches).

## Per-inheritance config entity — `field_inheritance.field_inheritance.<id>`

Fields (all exported):

| Key | Meaning |
|---|---|
| `id` | Machine id. **Auto-prefixed** on save with `<destinationEntityType>_<destinationEntityBundle>_`. |
| `label` | Human label; also the computed field's label. |
| `type` | Inheritance **strategy**: `inherit`, `prepend`, `append`, or `fallback`. |
| `sourceEntityType` / `sourceEntityBundle` / `sourceField` | Where data is read from. |
| `destinationEntityType` / `destinationEntityBundle` | Which bundle gets the computed field. |
| `destinationField` | (Optional) local field used by `prepend`/`append`/`fallback`. Not needed for `inherit`. |
| `plugin` | `default_inheritance` or `entity_reference_inheritance`. |

Admin UI: `/admin/structure/field_inheritance` (list), `/add` (create). The add form
(`FieldInheritanceForm`) uses AJAX to populate source/destination entity-type → bundle → field
selects, and only shows **Destination Field** when the strategy is not `inherit`. Permission:
`administer field inheritance`.

## The computed field it produces

For each inheritance, `hook_entity_bundle_field_info_alter()` adds a **computed, read-only** field to
the destination bundle. Its machine name is the inheritance id **with the
`<destType>_<destBundle>_` prefix stripped** (`idWithoutTypeAndBundle()`). The field:
- is computed at read time (class `FieldInheritanceFactory`, or
  `EntityReferenceFieldInheritanceFactory` for the `entity_reference_inheritance` plugin),
- takes the **source field's type and settings**,
- gets a cardinality derived from the strategy (`inherit` = source cardinality; `prepend`/`append` =
  sum, or unlimited if either is; `fallback` = max),
- is `setReadOnly(TRUE)` and display-configurable on view.

## Create one via drush php:eval

```php
use Drupal\field_inheritance\Entity\FieldInheritance;
$e = FieldInheritance::create([
  'id' => 'inherited_body',          // becomes node_page_inherited_body after save()
  'label' => 'Inherited Body',
  'type' => 'inherit',               // inherit | prepend | append | fallback
  'sourceEntityType' => 'node',
  'sourceEntityBundle' => 'article',
  'sourceField' => 'body',
  'destinationEntityType' => 'node',
  'destinationEntityBundle' => 'page',
  // 'destinationField' => 'body',   // required only for prepend/append/fallback
  'plugin' => 'default_inheritance',
]);
$e->save();                          // $e->id() is now 'node_page_inherited_body'
```

Read back: `drush cget field_inheritance.field_inheritance.node_page_inherited_body`, or
`FieldInheritance::load('node_page_inherited_body')->sourceField()`.

## Notes

- The `admin_permission` on the config entity annotation is `administer site configuration`, but the
  routes require `administer field inheritance`.
- Saving an inheritance does not itself validate that `sourceField` exists; the computed field is only
  added when the source field definition can be resolved (`getSourceFieldDefinition()` returns a
  FieldConfig or base field), otherwise that inheritance is skipped in the field-info alter.
