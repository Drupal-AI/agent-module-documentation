# Processor: taxonomy_machine_name_hierarchy (AddHierarchy)

A Search API processor that adds ancestor term machine names to indexed machine-name fields.

- **id**: `taxonomy_machine_name_hierarchy`
- **label**: "Index machine name hierarchy"
- **class**: `Drupal\search_api_taxonomy_machine_name\Plugin\search_api\processor\AddHierarchy`
- **stage**: `preprocess_index` (weight **-45**)

## What it does

At index time (`preprocessIndexItems`), for every field flagged in its config it loads the
referenced term(s), calls `taxonomy_term` storage `loadAllParents($tid)`, and adds each
ancestor's `machine_name` value into the field (deduplicated). Result: a field that held only
a leaf term's slug now holds the leaf **and** every ancestor slug — so a query on a parent
category matches descendants.

## When it is available

`supportsIndex()` / `getHierarchyFields()` only expose the processor when the index already
has at least one field whose field dependencies include the module `taxonomy_machine_name`
(i.e. a term reference's `…:entity:machine_name` field). Add that field to the index first.

## Configuration shape

```php
// Stored in the index config under processor_settings.taxonomy_machine_name_hierarchy:
[
  'fields' => [
    '<field_id>' => ['status' => TRUE],   // enable hierarchy for this field
  ],
]
```

The config form (`buildConfigurationForm`) renders one checkbox per eligible field, titled
with the field label; ticking it sets `fields[<field_id>][status] = TRUE`.

## Add it in code

```php
$index = \Drupal::entityTypeManager()->getStorage('search_api_index')->load('my_index');
$index->addProcessor($index->createPlugin('processor', 'taxonomy_machine_name_hierarchy', [
  'fields' => ['field_category_machine_name' => ['status' => TRUE]],
]));
$index->save();
// Read back:
$index->getProcessor('taxonomy_machine_name_hierarchy');       // throws SearchApiException if not set
in_array('taxonomy_machine_name_hierarchy', array_keys($index->getProcessors()), TRUE);
```

## Solr multi-value mapping

`alterFieldMapping(IndexInterface, &$fields, $language_id)` (invoked from
`hook_search_api_solr_field_mapping_alter()` in the `.module`) rewrites each enabled field's
Solr field name to a **multi-value** `sm_<field_name>` mapping, because a hierarchy field now
holds several values. This only affects Solr-backed indexes; DB-backed indexes ignore it.
