<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Set Lineage automatically adds a term's ancestors to an entity's taxonomy reference fields when the entity is saved.

---

Install the module (`drupal/taxonomy_set_lineage`, no dependencies) and enable it, then visit **Configuration › Content authoring › Taxonomy Set Lineage** (`/admin/config/content/taxonomy_set_lineage`, needs the *administer taxonomy* permission). Tick at least one **vocabulary** — that is the only required setting. Leave the *Entity types*, *Bundles* and *Fields* boxes empty to apply lineage everywhere those vocabularies are referenced, or tick some to narrow the scope to specific entity types, bundles or individual reference fields. From then on, whenever content is saved and one of its scoped taxonomy-reference fields **changes**, the module loads each selected term's parents and inserts the missing ancestors immediately before the child term (so a page tagged *Berlin* also ends up tagged *Germany* and *Europe*, ordered root-first). It only **adds** terms, never removes them, and it only reacts to fields whose value actually changed — so it does not retro-fit content you have not edited. Two caveats worth telling editors: because the stored ancestors are a copy, **re-parenting a term in the vocabulary does not update already-saved content** until each item is re-saved; and if an editor removes only an ancestor while keeping the leaf, the ancestor is **re-added on the next save**. For existing content, use the bundled **Update Taxonomy Term Parents** bulk action on `/admin/content` (also gated by *administer taxonomy*) to backfill parents on selected nodes in one pass. Note that field **cardinality** is respected — on a single-value field there is no room for parents, so none are added — and in multilingual setups only the terms in the language just edited are processed.

---

- Tag content with a leaf term and have its ancestors added automatically.
- Make a page tagged *Berlin* also appear under *Germany* and *Europe*.
- Stop editors from having to hand-pick every parent term.
- Avoid recursive hierarchy lookups at read time by materialising ancestors on save.
- Let Views listings filtered by a broad term include narrowly-tagged content.
- Feed facets and search indexes the full lineage of each term.
- Enable lineage for one specific vocabulary only.
- Restrict lineage saving to chosen entity types.
- Restrict lineage saving to specific bundles (e.g. only Articles).
- Restrict lineage saving to individual taxonomy reference fields.
- Apply lineage to fields that use a View-based term selection handler.
- Backfill parents on existing nodes with the *Update Taxonomy Term Parents* bulk action.
- Repair content that was tagged before the module was configured.
- Add newly-required parents after re-parenting terms (via the bulk action).
- Understand that removing an ancestor is undone on the next save.
- Understand that moving a term leaves old content on stale lineage until re-saved.
- Respect single-value field cardinality (no parents forced into a one-term field).
- Keep multilingual term sets independent per language.
- Restrict who can configure it to holders of *administer taxonomy*.
- Document the field's auto-tagging behaviour for the editorial team.
- Audit hierarchical-taxonomy tagging during a site review.
