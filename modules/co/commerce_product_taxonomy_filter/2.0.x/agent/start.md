# Commerce Product taxonomy filter — agent index

Ports core's taxonomy-index Views integration to Commerce products: filter / argument /
relationship / field to query `commerce_product` by taxonomy term, with depth-aware variants.
Depends on `commerce`. No admin UI (`configure` null), no permissions, no Drush; all setup is in
Views.

- **The index table, the Views handlers it adds, the plugin swaps, and how to use them in a View** →
  [api/views.md](api/views.md)

Key facts:
- Maintains table `commerce_product_taxonomy_index` (`product_id, tid, status, created`) via
  `commerce_product` insert/update/predelete hooks; backfills on install, drops on uninstall.
- Honors `taxonomy.settings:maintain_index_table`.
- Views data added on `commerce_product_field_data`: relationship `commerce_product_term_data`;
  field `commerce_product_taxonomy_index_tid`; filter/argument `taxonomy_index_tid` and the
  `commerce_product_taxonomy_index_tid_depth` (+ `_depth_modifier`) variants.
- Argument validator `entity:taxonomy_term` swapped to this module's `Term`; term-name variant `TermName`.
- Ships optional View `views.view.product_terms` (config/optional) and a Views wizard
  (`TaxonomyTerm`).
