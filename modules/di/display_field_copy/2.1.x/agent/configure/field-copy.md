<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating and storing a field copy

Display Field Copy has **no settings form of its own** (`configure: null`). A "copy" is a
Display Suite dynamic field.

## Admin flow

1. Go to *Structure → Display Suite → Fields* — `/admin/structure/ds/fields`
   (route `ds.fields_list`).
2. Click **Create a copy of a field** (action link, route `display_field_copy.add`,
   path `/admin/structure/ds/fields/display_field_copy`, permission `admin fields`).
3. Fill in **Label**, pick the source **Field** from the select (all base fields and
   configured fields across content entity types), and save.
4. Go to the source entity's *Manage display* (e.g.
   `/admin/structure/types/manage/article/display`), where the copy now appears as a DS
   field. Enable it, choose a **formatter** and its settings, place it in a region.

## Where it is stored

Each copy is a **simple config object** (not a config entity) named `ds.field.<id>`:

```yaml
# config: ds.field.article_body_copy
id: article_body_copy
label: 'Body (copy)'
ui_limit: ''
properties:
  field_id: node.article.body      # <entity_type>.<bundle>.<field> for configured fields
                                   # or <entity_type>.<field> for base fields
type: display_field_copy
type_label: 'Copy field'
entities:
  node: node                       # entity type(s) the copy is offered on
```

- `type` is always `display_field_copy` (this is how the DS deriver
  `Drupal\display_field_copy\Plugin\Derivative\DisplayFieldCopy` picks it up).
- `properties.field_id` is the source field. `explode('.', $field_id)`: 2 pieces →
  a base field (resolved via `entity_field.manager`); 3 pieces → a configured field
  (loaded as a `field_config`). The last piece is the entity property read at render time.
- `entities` is set from the source field's entity type by the add form's `submitForm()`;
  `ui_limit` is auto-set to `<bundle>|*` when the source is a configured (3-part) field.

## Create one programmatically

```php
\Drupal::configFactory()->getEditable('ds.field.article_body_copy')->setData([
  'id' => 'article_body_copy',
  'label' => 'Body (copy)',
  'ui_limit' => '',
  'properties' => ['field_id' => 'node.article.body'],
  'type' => 'display_field_copy',
  'type_label' => 'Copy field',
  'entities' => ['node' => 'node'],
])->save();
// DS caches the field list by the 'ds_fields_info' cache tag:
\Drupal::service('cache_tags.invalidator')->invalidateTags(['ds_fields_info']);
```

Delete a copy by deleting its `ds.field.<id>` config object. There is no per-copy limit.
