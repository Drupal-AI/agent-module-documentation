<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Taxonomy Parent Autocomplete** fixes the unusable *Parent terms* multi-select on the taxonomy term edit form for large vocabularies: it swaps the core `<select>` for an `entity_autocomplete` field, so editors type-to-find parent terms instead of scrolling a giant option list. On install it also sets core's `taxonomy.settings:override_selector` so the default parent selector is suppressed.

---

`hook_form_alter()` targets forms whose `base_form_id` is `taxonomy_term_form`: it reads the current parents from form state (`['taxonomy','parent']`, loading them with `Term::loadMultiple`) and replaces `$form['relations']['parent']` with an `entity_autocomplete` element (`#target_type: taxonomy_term`, `#tags: TRUE`, default selection handler, `target_bundles` restricted to the current vocabulary via `$form['vid']['#value']`). An `#after_build` callback (`taxonomy_parent_autocomplete_process`) normalizes an empty value to an empty array so saving a term with no parent works. `hook_install()` sets `taxonomy.settings:override_selector = TRUE`. The module has no routes, services, permissions, config entities or blocks — it is a pure form alteration governed by the user's existing taxonomy edit permissions, and it introduces no new request surface.

---

- Make the parent-term field usable on vocabularies with thousands of terms.
- Type-ahead search for a term's parent instead of a long dropdown.
- Assign multiple parents to a term via autocomplete tags.
- Restrict parent suggestions to the term's own vocabulary.
- Save a term with no parent (root term) reliably.
- Speed up editing deep taxonomy hierarchies.
- Avoid slow-rendering giant `<select>` elements on term forms.
- Improve editor UX for hierarchical category management.
- Suppress the core parent selector via `override_selector`.
- Keep parent selection scoped to a single bundle.
- Reduce page weight on large-vocabulary term edit forms.
- Support multi-parent (poly-hierarchy) taxonomies.
- Work with any vocabulary without configuration.
- Preserve existing parents when editing a term.
- Let editors reassign a term's parent quickly.
- Prevent browser slowdowns from huge option lists.
- Apply automatically to all taxonomy term forms once enabled.
