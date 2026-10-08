Commerce Product taxonomy filter ports core's taxonomy-index Views integration to Commerce products, letting you filter, argue (contextual filter), relate, and list commerce products by taxonomy term — including "with depth" (term + children) handling.

---

The module maintains a denormalized `commerce_product_taxonomy_index` table (product_id ↔ tid, plus status and created) via `hook_ENTITY_TYPE_insert/update/predelete` on `commerce_product`, walking every entity-reference field that targets `taxonomy_term` (across translations) — mirroring how core taxonomy indexes nodes. On install it backfills the index from existing products; on uninstall it drops the table. Indexing respects `taxonomy.settings:maintain_index_table`. Through `hook_views_data_alter` it exposes Views handlers on `commerce_product_field_data`: a term relationship, an "All taxonomy terms" field, a "Has taxonomy term(s)" filter and "Has taxonomy term ID" argument (backed by `commerce_product_taxonomy_index`), and depth-aware variants ("with depth" + a depth-modifier argument). It also swaps the taxonomy-term entity argument validator (`entity:taxonomy_term`) to its own `Term`/`TermName` classes, retargets exposed filters on term entity-reference fields to its `commerce_product_taxonomy_index_tid` handler via `hook_field_views_data_alter`, and ships an optional example View (`views.view.product_terms`) plus a Views wizard for taxonomy-term based product listings. It has no admin UI, permissions, or Drush; everything is configured inside Views.

---

- Filter a product listing View by one or more taxonomy terms (categories, brands, tags).
- Add a "Has taxonomy term ID" contextual filter (argument) to a products View.
- Build a category landing page that lists all products in a term, driven by the URL term id.
- Include child-term products via the depth-aware "Has taxonomy terms (with depth)" filter/argument.
- Modify argument depth dynamically with the depth-modifier contextual filter.
- Add a term relationship to a products View to pull in term name/fields.
- Show all taxonomy terms attached to each product as a Views field.
- Create related-product blocks based on shared taxonomy terms of the current product.
- Use the bundled `product_terms` example View as a starting catalog listing.
- Spin up a taxonomy-term products listing quickly via the Views wizard.
- Validate a contextual filter value against real taxonomy terms (term id or name).
- Accept a term name (not just id) as an argument via the `TermName` validator/argument.
- Filter products across multiple vocabularies from a single relationship.
- Keep the product/term index in sync automatically as products are created, updated, or deleted.
- Backfill the index for an existing catalog on module install.
- Respect core's `maintain_index_table` setting to avoid unnecessary writes.
- Power faceted or multi-term category filtering ("any"/"all" term matching).
- Sort or group a products View by taxonomy term.
- Provide category navigation for a Commerce store without custom code.
- Restrict term autocomplete/options to selected vocabularies in an exposed filter.
- Reuse familiar core taxonomy-index Views UX, but against commerce_product instead of node.
