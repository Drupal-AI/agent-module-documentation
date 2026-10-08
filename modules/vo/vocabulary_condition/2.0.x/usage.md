<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vocabulary Condition adds condition plugins that test the taxonomy context of the current page — which vocabulary, which term, and crucially whether the page is under a term's **descendants** — so block visibility can follow a site's taxonomy structure.

---

Block visibility in core is path, content type, role and language. A site organised around taxonomy — a knowledge base by subject, a shop by category, a council site by service area — needs "show this block on anything in the Health section", and neither a path pattern nor a content-type rule expresses that. Path patterns break the moment aliases change; a term-id list breaks whenever a term is added. The descendant support is what makes this usable: a condition set on a parent term keeps applying as the hierarchy grows beneath it. `src/Plugin` supplies the conditions with `config/schema` for their settings, depending on core `taxonomy` alone, with `core_version_requirement: ^10.3 || ^11 || ^12` — already covering Drupal 12. Because they are ordinary condition plugins they work anywhere conditions are consumed: block layout, Context, Page Manager and custom code. As with all visibility conditions, the standard caution applies — this decides what is *shown*, not what a user may *access*, and a condition that varies output needs the right cache context or the page cache will serve one visitor's variant to another.

---

- Show a block on everything in a subject area.
- Target a term and all its children.
- Show contextual help per category.
- Vary a sidebar by vocabulary.
- Show a related-links block under one branch.
- Follow a taxonomy hierarchy without listing terms.
- Keep visibility working as terms are added.
- Show a promotion on a product category.
- Target a council service area.
- Avoid brittle path patterns.
- Show a banner across a documentation section.
- Vary navigation by vocabulary.
- Drive a Context reaction from taxonomy.
- Show a disclaimer on regulated categories.
- Target term pages and content alike.
- Reuse conditions across block and Context.
- Prepare visibility rules for Drupal 12.
- Show a block only on term pages.
