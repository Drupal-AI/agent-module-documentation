<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding a common field to a Search API index

There is **no settings page** (`configure: null`). A common field is added to a Search API
index like any other field.

## Requirements

- The index must have **two or more datasources** that share at least one property with the
  **same property path** (e.g. two entity datasources that both expose `title` or `created`).
  The add form only offers properties present on more than one datasource.

## UI flow

1. Go to the index's **Fields** tab (*Configuration → Search and metadata → Search API →
   your index → Fields*).
2. Click **Add fields**.
3. Under the datasource-independent ("General") group, pick **Common field**
   (label "Common field", from processor `common_field`).
4. On the field's configuration form, choose the **Common field** radio — the shared
   property to pull from. Options are labelled `@property (used in @datasourceA, @datasourceB)`.
5. Save. Adding the field enables the (locked, hidden) `common_field` processor automatically.

## Where it is stored

Everything lives in the index config entity `search_api.index.<id>`:

```yaml
processor_settings:
  common_field: {}            # enabled implicitly when a Common field exists
field_settings:
  common_title:               # your field's machine name
    label: 'Common title'
    datasource_id: null       # datasource-independent
    property_path: common_field
    type: string
    configuration:
      property_name: title    # the shared source property to merge
```

## Programmatic setup

```php
use Drupal\search_api\Entity\Index;
$index = Index::load('my_index');
$index->addProcessor($index->createPlugin('processor', 'common_field'));
$fh = \Drupal::getContainer()->get('search_api.fields_helper');
$field = $fh->createField($index, 'common_title', [
  'label' => 'Common title',
  'type' => 'string',
  'datasource_id' => NULL,
  'property_path' => 'common_field',
  'configuration' => ['property_name' => 'title'],
]);
$index->addField($field);
$index->save();
```

After saving, reindex (`$index->reindex()` / *Index now*) so items get the merged value.
Read the chosen source with `$index->getField('common_title')->getConfiguration()['property_name']`.
