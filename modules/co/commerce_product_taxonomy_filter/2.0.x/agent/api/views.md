# Commerce Product taxonomy filter — Views integration & index

## The index table

`commerce_product_taxonomy_index` (`hook_schema` in the `.install`): columns `product_id`, `tid`,
`status` (published bool), `created`; primary key `(product_id, tid)`. It is a denormalized
product↔term map, the commerce analogue of core's `taxonomy_index`.

Maintenance (`.module`):
- `commerce_product_taxonomy_filter_commerce_product_insert/update/predelete` rebuild/delete rows.
- `…_build_commerce_product_index()` collects tids from every field whose item class is (a subclass
  of) `EntityReferenceItem` with `target_type == taxonomy_term`, over all translations of the
  default revision, and `merge()`s a row per tid (status = published, created = product created time).
- All writes are skipped unless `taxonomy.settings:maintain_index_table` is truthy and the product
  storage is SQL. Install backfills existing products; uninstall drops the table.

## Views handlers added (`hook_views_data_alter`)

On base table `commerce_product_field_data`:

| Views field key | Handler kind | id | Purpose |
|---|---|---|---|
| `term_commerce_product_tid` | relationship | `commerce_product_term_data` | Join products → `taxonomy_term_field_data`. |
| `term_commerce_product_tid` | field | `commerce_product_taxonomy_index_tid` | "All taxonomy terms" on a product. |
| `term_commerce_product_tid` | filter | `taxonomy_index_tid` | "Has taxonomy term". |
| `term_commerce_product_tid` | argument | `taxonomy_index_tid` | "Has taxonomy term ID" (contextual filter). |
| `term_commerce_product_tid_depth` | filter/argument | `commerce_product_taxonomy_index_tid_depth` | Term + descendants (uses `taxonomy_term__parent` hierarchy join). |
| `term_commerce_product_tid_depth_modifier` | argument | `commerce_product_taxonomy_index_tid_depth_modifier` | Adjust the depth of the preceding argument via an extra contextual value. |

The `commerce_product_taxonomy_index` table joins to `taxonomy_term_field_data` (via `tid`),
`commerce_product_field_data` (via `product_id`), and `taxonomy_term__parent` (for depth).

## Plugin swaps / retargets

- `hook_field_views_data_alter`: for any `entity_reference` field targeting `taxonomy_term`, sets
  its exposed-filter handler id to `commerce_product_taxonomy_index_tid`.
- `hook_views_plugins_argument_validator_alter`: replaces the `entity:taxonomy_term` validator with
  `…\Plugin\views\argument_validator\Term` (there is also `TermName` for name-based args).

Plugin classes live under `src/Plugin/views/` (argument: `IndexTid`, `IndexTidDepth`,
`IndexTidDepthModifier`, `Taxonomy`, `VocabularyVid`; argument_default: `Tid`; argument_validator:
`Term`, `TermName`; field: `TaxonomyIndexTid`, `TermName`; filter: `TaxonomyIndexTid`,
`TaxonomyIndexTidDepth`; relationship: `CommerceProductTermData`; wizard: `TaxonomyTerm`) — direct
ports of the core taxonomy equivalents retargeted at the commerce product index.

## How to use in a View

1. Create a View of **Products** (`commerce_product`).
2. For a category page: *Advanced → Contextual filters → Add → "Product: Has taxonomy term ID"*
   (or the *with depth* variant to include child terms).
3. For an exposed category selector: add the *"Has taxonomy term"* filter and expose it.
4. To show or sort by term: add the *term* relationship, then the term-name field.

Config schema for the depth argument and the `argument_default` (term id from URL /
commerce_product page) is in `config/schema/commerce_product_taxonomy_filter.views.schema.yml`. An
example is provided as the optional View `product_terms`.
