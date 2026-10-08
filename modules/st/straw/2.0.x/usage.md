<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Straw (Super Term Reference Autocomplete Widget) is a taxonomy term-reference autocomplete that shows and searches the *whole term hierarchy*: selected terms display with all their parents (separated by `>>`), and — if term creation is on — typing `Parent >> Child` creates the whole chain of missing terms.

---

Straw replaces the plain term-reference autocomplete for entity-reference fields that point at taxonomy terms. It ships two cooperating plugins plus a form element: an `EntityReferenceSelection` plugin `straw` ("Straw selection", group `straw`, extending core's `TermSelection`) that you pick as the field's **reference method**, and a `FieldWidget` `super_term_reference_autocomplete_widget` ("Autocomplete (Straw style)", extending `EntityReferenceAutocompleteWidget`) that you pick on *Manage form display*. The widget renders a `super_term_reference_autocomplete` form element (extending core `EntityAutocomplete`) that displays each existing value with its full ancestry joined by `>>` and matches the autocomplete against the whole hierarchy, so ambiguous leaf names are disambiguated by their parents. When the field allows creating new terms, the same `>>` delimiter lets an editor type a path like `Travel >> Tourist Destinations` and Straw creates every missing term in the path, parenting each to the previous one (staged via the `NewTermStorage` service and a dedicated `straw` cache bin). Setup is two steps and requires only core Taxonomy; there is no settings page. It is ideal for deep vocabularies where the same term label appears under different parents.

---

- Show a selected taxonomy term together with its full parent path (e.g. `Travel >> Europe >> France`).
- Disambiguate terms that share a name but live under different parents in the autocomplete.
- Search the entire term hierarchy (not just leaf labels) when picking a term.
- Create a new term and all its missing parents at once by typing `Parent >> Child`.
- Keep a deep vocabulary usable in a term-reference field without a huge select list.
- Let editors add categories on the fly while preserving hierarchy.
- Use on any entity-reference field that targets taxonomy terms (nodes, media, users, etc.).
- Replace the default term autocomplete with a hierarchy-aware one on an Article's Tags field.
- Enforce consistent placement of new terms under the correct parent via the `>>` path syntax.
- Present breadcrum's-style term context inline in the edit form.
- Reduce mis-tagging in large taxonomies by showing where each term sits.
- Configure per field: choose "Straw selection" as the reference method for that field.
- Configure per form mode: choose "Autocomplete (Straw style)" as the widget.
- Allow multi-value term fields to each show their full ancestry.
- Build faceted content structures where authors pick deeply nested categories quickly.
- Migrate an existing term field to Straw without changing stored data (just the widget + handler).
- Avoid creating duplicate parent terms by reusing existing ancestors when creating a child.
- Support very large geographic or product taxonomies in the node form.
- Give content teams a consistent tagging UX across many bundles.
- Cache hierarchy lookups in the dedicated `straw` cache bin for performance.
