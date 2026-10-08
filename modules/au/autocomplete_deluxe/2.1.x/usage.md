<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Autocomplete Deluxe provides a single field widget, `autocomplete_deluxe`, that replaces core's plain entity-reference autocomplete with a jQuery UI powered tag-box: matches drop down as you type and chosen values become removable "chips" in one multi-value box.

---

The module ships one `@FieldWidget` (id `autocomplete_deluxe`) that applies to any `entity_reference` field — most commonly taxonomy term reference "Tags" fields, but any entity-reference target works. It reuses core's entity-reference selection handlers and autocomplete route, so it respects the field's target bundles and selection settings, then renders results through a custom `autocomplete_deluxe` render element backed by jQuery UI (no external jQuery library needed). Because the widget declares `multiple_values = TRUE`, one box collects all values of a multi-cardinality field, separated by the Enter key or an optional delimiter character. Per-field settings (configured on *Manage form display*) control the match operator (Starts with / Contains), the result limit, the minimum characters before suggestions open, whether editors may add brand-new terms (free tagging), and the helper messages shown when a term is not found or the box is empty. Styling adapts to the active admin theme (Claro, Gin, Seven) via bundled CSS libraries. There is no global admin settings form — all configuration lives on each field's form-display component.

---

- Turn a taxonomy "Tags" field on Articles into a chip-style tag box editors can type into
- Let content editors add new taxonomy terms on the fly (free tagging) from the node form
- Restrict autocomplete matching to "Starts with" for large vocabularies where prefix search is faster
- Cap the number of suggestions shown with the match limit setting on a busy reference field
- Require a minimum number of typed characters before the suggestion list opens, reducing query load
- Provide a comma or semicolon delimiter so editors can paste several tags at once
- Replace core's one-value-per-row autocomplete with a single multi-value box on unlimited-cardinality fields
- Reference users, nodes, or any custom entity type through an entity_reference field with a nicer picker
- Show a custom "term not found" message that names the term about to be created
- Show a friendly empty-state prompt inside the box when a reference field has no values yet
- Improve the editorial UX of an existing entity-reference field without changing its storage or data
- Keep autocomplete behavior consistent with core selection handlers (target bundles, sort, auto-create)
- Style the widget to match a Gin or Claro admin theme out of the box
- Use it as the widget for a product-category reference on a commerce content type
- Attach it to a media reference field so editors pick existing media by typing its name
- Build a "related content" reference field where editors search existing nodes by title
- Offer a keyword/skill tag box on a user-profile entity-reference field
- Swap the widget on a per-form-mode basis (e.g. deluxe on the full edit form, plain elsewhere)
- Let editors remove a selected value by clicking the ✕ on its chip rather than clearing text
- Migrate a legacy Drupal 7 Autocomplete Deluxe field to Drupal 10/11 with the same UX
- Pair with a term-reference field to power a faceted tagging workflow on articles
- Provide autocomplete tagging inside a paragraph or inline entity form reference field
- Give translators a predictable typeahead when referencing terms in a translated vocabulary
- Reduce mis-typed free tags by surfacing existing matches before a new term is created
