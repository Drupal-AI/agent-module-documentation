# The Taxonomy Term Replace dashboard

There is **no configuration** for this module. Everything happens in one form.

## Access

- Route: `taxonomy_term_replace.dashboard` → `/admin/structure/taxonomy/taxonomy-term-replace`
  (also a confirmation route `taxonomy_term_replace.confirmation`).
- Permission: **`access Taxonomy Term Replace dashboard`**.
- Linked from the Taxonomy vocabulary collection (`entity.taxonomy_vocabulary.collection`).

## Workflow (UI)

1. Select a **vocabulary** (AJAX loads its terms).
2. Select a **target term** (the term to replace) and a **replacement term** (both from that
   vocabulary).
3. Optionally tick **Add unpublished nodes**, then click **Search** to list associated nodes in a
   selectable table (Node ID, URL, content type, status).
4. Optionally **Download table** to export the list as CSV.
5. Select rows and **Process replacement** to run the swap.

## How nodes are found

- **Published only** (default): a query on the core `taxonomy_index` table —
  `SELECT ti.nid FROM taxonomy_index ti WHERE ti.tid IN (<target_tid>)` (joined to
  `node_field_data`). `taxonomy_index` is core's record of published nodes ↔ term references.
- **Including unpublished**: iterates every content type's field definitions, finds the
  entity-reference field whose settings have `target_type == taxonomy_term` and whose first
  `target_bundles` entry equals the target term's vocabulary, then
  `loadByProperties([$field_name => $target_tid])`.

## How the replacement works

A batch (`TaxonomyTermReplaceForm::taxonomyTermReplacement()`) runs per selected node: it reads the
matching reference field's values, finds the item whose `target_id` equals the target term id,
rewrites that item's `target_id` to the replacement term id, and saves the node. So the field on the
node ends up referencing the replacement term instead of the target term. Programmatic equivalent:

```php
$values = $node->get($field_name)->getValue();
foreach ($values as $i => $item) {
  if ($item['target_id'] == $target_tid) { $values[$i]['target_id'] = $replacement_tid; break; }
}
$node->set($field_name, $values)->save();
```

## CSV export

`Download table` batches the searched nodes and writes `public://taxonomy-term-node-search.csv` with
columns Node ID, Node URL, Content Type, Node Status, then streams it to the browser.
