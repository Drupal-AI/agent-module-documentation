Views Taxonomy Parent ID from Term adds a Views relationship, filter, and argument that resolve a taxonomy term to its parent term's id.

---

Taxonomy hierarchies drive navigation constantly — a section with subsections, a product category with sub-categories, a region with its localities — and Views can filter a term listing by a term id. What it cannot easily do is take the term you are on and act on that term's *parent*, which is what "show me the siblings of this term" and "show me the section this page belongs to" both need. This module supplies that: it registers a "Parent ID From Term" data handler on the `taxonomy_term__parent` table (a relationship, a numeric filter, and a taxonomy argument), then rewrites the query at execution time so that a value you feed in as a term id is converted to that term's parent id before the condition runs. The typical result is a sidebar block that lists the other pages in the same section, driven entirely from the vocabulary hierarchy rather than a hand-maintained menu. Two cases need planning: a top-level term has no parent (the filter resolves to NULL, so define a fallback), and Drupal's taxonomy model allows multiple parents (the module uses only the first parent and warns this can produce duplicate rows).

---

- Show the siblings of the current taxonomy term in a View.
- Build section navigation from a vocabulary hierarchy instead of a menu.
- List the other pages that share the current term's parent category.
- Filter a "Taxonomy term" View by the parent id of a supplied term.
- Drive a sidebar block from taxonomy structure using a contextual filter.
- Feed a term id from the URL and act on its parent term.
- Add the "Parent ID From Term" numeric filter to a taxonomy-term View.
- Add the "Parent ID From Term" argument (contextual filter) to a View.
- Add a relationship to the parent term for further field access.
- Show a product category's sibling sub-categories.
- Show a region's other localities under the same parent region.
- Show the other articles filed under the same top-level section.
- Handle a top-level term with no parent by defining fallback behaviour.
- Avoid an empty listing on section landing pages where a term has no parent.
- Decide which parent to use in a vocabulary that allows multiple parents.
- Audit vocabularies for multiple parents before relying on the filter.
- Combine parent-id resolution with other contextual filters in one View.
- Replace a manually maintained "related pages in this section" block.
- Provide breadcrumb-like sibling listings without custom code.
- Reuse the same taxonomy hierarchy for both breadcrumbs and sibling navigation.
