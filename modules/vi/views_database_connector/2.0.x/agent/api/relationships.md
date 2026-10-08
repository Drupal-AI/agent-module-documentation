# Relationships between VDC tables + the `standard_vdc` field

## The `standard_vdc` string field handler

String columns use `Drupal\views_database_connector\Plugin\views\field\StandardVDC`
(`@ViewsField("standard_vdc")`), extending core `Standard`. It adds one option:

- `render_html` (bool, default `FALSE`). When off, `render()` returns
  `sanitizeValue($value)` (plain-text escaped). When on, it returns
  `sanitizeValue($value, 'xss')` — HTML kept but run through Drupal's `xss` filter. The
  option form warns to enable it only if you trust the source.

## Defining relationships (joins) between VDC tables

VDC provides the relationship plugin
`views_database_connector_relationship` (`@ViewsRelationship`, an empty subclass of
core `RelationshipPluginBase`) but does **not** auto-create relationships. To join two
VDC/base tables you ship a tiny custom module implementing `hook_views_data_alter()`:

`custom_relationships.info.yml`:
```yaml
name: "Custom Relationships"
type: module
description: "Custom relationships for VDC Views."
dependencies:
  - views
  - views_database_connector
package: "Views"
```

`custom_relationships.views.inc`:
```php
<?php

/**
 * Implements hook_views_data_alter().
 */
function custom_relationships_views_data_alter(array &$data) {
  $data['Base_DB_table']['relationship_key'] = [
    'title' => t('Relationship Name'),
    'relationship' => [
      'base'       => 'Relationship_DB_Table',       // the other VDC table
      'base field' => 'shared_column_in_each_table', // column on the target table
      'field'      => 'shared_column_in_each_table', // column on the base table
      'id'         => 'views_database_connector_relationship',
      'label'      => t('Label for the Relationship'),
    ],
  ];
}
```

The relationship then appears in the View's **Relationships** dialog, letting you add
fields/filters from the joined table. Use the exact table names VDC registered (the part
after `[VDC] <db>:  ` — i.e. the raw table name, which is the `$data` key).
