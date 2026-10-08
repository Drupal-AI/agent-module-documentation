<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Parents Index builds an index table for storing every parent Term ID for a Taxonomy Term.

---

Taxonomy Parents Index builds and maintains an index table that stores **every ancestor Term ID** for
each taxonomy term — so, given a term, you can efficiently query all its parents (up the hierarchy) without
walking the parent chain each time, useful for filtering content by any ancestor term. It is configured at
`taxonomy_parents_index.reindex_form` and provides its own permissions, in the Taxonomy package.

Use it to query taxonomy ancestry efficiently. It is a taxonomy/performance feature providing a derived index;
the data reflects the term hierarchy and it has no access-control role beyond its permission (gating the
reindex operation). Configure/rebuild the index.

---

- Index every parent Term ID per term.
- Query all ancestors efficiently.
- Avoid walking the parent chain.
- Filter content by any ancestor term.
- Configure at the reindex form.
- Provide its own permissions.
- Maintain a derived index.
- Reflect the term hierarchy.
- Have no access-control role beyond permission.
- Rebuild the index.
- Handle parent indexing.
- Query term ancestors.
- Index term parents.
- Configure the index.
- Reindex terms.
- Handle taxonomy ancestry.
- Index ancestors.
- Query parents.
- Configure reindexing.
- Index the hierarchy.
