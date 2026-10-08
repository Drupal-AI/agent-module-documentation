<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typed Relation field (`typed_relation`)

An entity-reference field where **each referenced value also carries a relationship type** picked from
a configurable list — e.g. a person referenced as `relators:aut` (Author) vs `relators:pbl`
(Publisher), or `schema:spouse`. Models MARC relators / schema.org relations on a single reference
field.

- Field type class: `Plugin\Field\FieldType\TypedRelation` (id `typed_relation`, category
  `typed_relation`). Extends core `EntityReferenceItem`; `schema()` adds a required tiny-text
  `rel_type` column; `propertyDefinitions()` adds a required `rel_type` string property. `isEmpty()`
  is TRUE unless both a target and a `rel_type` are set.
- Default widget `typed_relation_default`, default formatter `typed_relation_default`
  (a second formatter `typed_relation_dedup` is also provided).
- Config schema: `field.field_settings.typed_relation` (extends entity_reference, adds `rel_types`
  sequence) and `field.storage_settings.typed_relation`.

## Field settings — relation types

`fieldSettingsForm()` adds an "Available Relations" textarea, one `key|label` per line. Keys may not
contain dots (`.` is stripped by `extractPipedValues()`). Stored as `rel_types`; `getRelTypes()`
returns the map. Example values used by the defaults submodule: `relators:aut|Author`,
`schema:spouse|Spouse`.

## Widget: `typed_relation_default`

Class `Plugin\Field\FieldWidget\TypedRelationWidget` (extends core
`EntityReferenceAutocompleteWidget`). Adds a **Relationship Type** `select` (options = `rel_types`,
weight -1) above the autocomplete. Widget settings: `match_operator`, `size`, `placeholder`,
`match_limit`.

## Formatters

| Formatter id | Class | Behavior |
|---|---|---|
| `typed_relation_default` | `TypedRelationFormatter` | Core entity-reference label output, prefixed with `"<Relation label>: "` per item |
| `typed_relation_dedup` | `TypedRelationDedupFormatter` | Same, but collapses repeated targets into one line, merging their relation labels (`Author, Editor: <term>`) |

Both extend `EntityReferenceLabelFormatter`; the resolved label is `rel_types[rel_type]` falling back
to the raw `rel_type`. Formatter setting `link` (`field.formatter.settings.typed_relation_default`).

## Views & tokens

- `hook_field_views_data_views_data_alter()` (in the .module) adds, for each `typed_relation` field, a
  forward entity-reference relationship and a reverse (`entity_reverse`) relationship, so you can join
  from either side in Views.
- Islandora tokens read a `field_linked_agent` typed-relation field by `rel_type` — see
  [hooks/integrations.md](../hooks/integrations.md).

## Create the field in code

```php
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_linked_agent', 'entity_type' => 'node', 'bundle' => 'article',
  'field_type' => 'typed_relation',
  'settings' => [
    'handler' => 'default:taxonomy_term',
    'handler_settings' => ['target_bundles' => ['person' => 'person']],
    'rel_types' => ['relators:aut' => 'Author', 'relators:pbl' => 'Publisher'],
  ],
])->save();
```
