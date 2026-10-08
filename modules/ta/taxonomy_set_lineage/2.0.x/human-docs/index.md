# Taxonomy Set Lineage — manual setup guide

**Taxonomy Set Lineage** (`taxonomy_set_lineage`) automatically adds a term's
ancestors to an entity's taxonomy reference fields whenever the term is selected. Tag
an article with *Berlin* in a Geography vocabulary, and the module also records
*Germany* and *Europe* — so a listing filtered by *Germany*, or a facet on *Europe*,
finds that article too.

The problem it solves is a classic one with hierarchical vocabularies. An editor knows
that Berlin is in Germany is in Europe, but the stored data does not — so content
tagged only with the specific term goes missing from broader listings. The two usual
workarounds are both poor: asking editors to select every ancestor by hand (they
forget), or querying the hierarchy at read time (every listing pays for a recursive
lookup). Taxonomy Set Lineage takes the third path — *materialising* the ancestors on
save — so the editor picks the specific term, the data records the whole lineage, and
every consumer (Views, facets, search indexes, feeds) sees it without needing to know
the vocabulary is hierarchical.

You enable lineage per vocabulary, and the module checks entities as they are saved: if
they have fields referencing an enabled vocabulary, it selects all parents of the
manually chosen terms. It also provides an **Update Taxonomy Term Parents** bulk action
on the content administration page, so you can backfill lineage on existing content.
The module works with any Drupal language / i18n strategy and depends on no other
contributed modules (core taxonomy handling only).

**Two consequences of materialising are worth planning for, and your editors should
know about both.** First, the stored lineage is a **copy** — if you later move a term
to a different parent, existing content keeps pointing at the *old* ancestry until
something re-saves it. Use the bulk action to refresh it after restructuring your
taxonomy. Second, the module **adds missing parents but does not remove existing
values** — so if an editor deletes an ancestor term from an entity, the module may add
it back on the next save. Editors should understand that, because a field that silently
re-adds what someone removed is a field they stop trusting. Also note: it never
overrides a field's cardinality — a field limited to a single value cannot hold the
extra parent terms.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. **Enable lineage on the vocabularies you want.** The module only acts on
   vocabularies that have lineage turned on, so switch it on for the hierarchical
   vocabularies where ancestors should be filled in automatically.
2. **Make sure your reference fields allow multiple values.** Because lineage adds the
   parent terms alongside the one the editor picked, a field restricted to a single
   value cannot store them — give it a cardinality greater than one (or unlimited).
3. **Let it work on save.** From then on, when content referencing an enabled
   vocabulary is saved, the module adds all ancestors of the selected terms
   automatically.
4. **Backfill existing content.** On the content administration page
   (`/admin/content`), select the entities you want and run the **Update Taxonomy Term
   Parents** action. It adds any missing parents to the selected entities' taxonomy
   reference fields without removing existing values — useful for content tagged before
   you enabled the module, or after you move terms in the hierarchy.
