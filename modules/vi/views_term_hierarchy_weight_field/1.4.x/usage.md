Adds two auto-managed integer fields to every taxonomy term — hierarchical weight (position within the flattened tree) and hierarchical depth — so Views can sort or filter terms in true hierarchical (tree) order instead of alphabetically or by raw weight.

---

On install the module creates two `FieldStorageConfig` integer fields on the `taxonomy_term` entity — `field_tax_hierarchical_weight` and `field_tax_hierarchical_depth` — and attaches a `FieldConfig` for each existing vocabulary (labels "Hierarchical Weight" / "Hierarchical Depth"). `hook_entity_insert` attaches the same two fields to any new vocabulary. The values are computed by walking the vocabulary's flattened tree via `TermStorage::loadTree()`: each term's weight is its index in the flattened, hierarchy-ordered tree, and its depth is `count(loadAllParents(tid)) - 1`. Recalculation runs in a Batch API job (25 terms per batch) and is triggered by submit handlers added to the taxonomy overview (drag-and-drop reorder / "reset to alphabetical"), the term add/edit form, and vocabulary creation; it is multilingual-aware (writes the values into every enabled language translation). Because the two values live on the term as normal fields, you expose them in a View of taxonomy terms and sort ascending on `field_tax_hierarchical_weight` to render the vocabulary in the exact tree order shown on the admin overview page. There is no settings UI (`configure` is null) and no permissions; the only moving part is the `views_term_hierarchy_weight_field.fields` service that provisions the fields per vocabulary.

---

- Sort a View of taxonomy terms in true tree order (parents immediately followed by their children) rather than alphabetically.
- Filter or group a term listing by nesting depth (top-level only, second level, etc.) using the depth field.
- Build a hierarchical glossary / directory View that mirrors the admin term overview ordering.
- Render a nested category menu or sitemap from a flat Views term listing.
- Indent term labels in a View by their `field_tax_hierarchical_depth` value.
- Keep a custom term listing in sync with editors' drag-and-drop ordering on the overview page.
- Order faceted taxonomy blocks so children stay grouped under their parents.
- Provide a "table of categories" page ordered exactly like the vocabulary tree.
- Expose the hierarchical weight as an exposed sort so visitors can toggle tree order on/off.
- Show only leaf terms (max depth) or only branch terms in a View by filtering on depth.
- Drive a multilingual term listing that stays hierarchy-ordered in every language.
- Recompute ordering automatically after adding, editing, or reordering terms.
- Feed hierarchy-ordered term data to a REST/JSON export View for a decoupled front end.
- Populate a select/autocomplete elsewhere using a hierarchy-ordered Views term reference.
- Replace hand-maintained term "weight" hacks with an automatically derived tree weight.
- Order breadcrumb or navigation blocks built on Views by term hierarchy.
- Give a taxonomy-based product/category browse page a stable, tree-consistent order.
- Present a nested FAQ or documentation category index in reading order.
- Batch-recalculate weights for a large vocabulary safely (25 terms per batch).
- Sort tagged content Views indirectly by joining to the term's hierarchical weight.
