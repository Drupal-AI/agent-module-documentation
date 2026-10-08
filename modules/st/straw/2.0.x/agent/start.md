<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Straw (Super Term Reference Autocomplete Widget) — agent index

A hierarchy-aware taxonomy term-reference autocomplete. Shows selected terms with their full
parent path (joined by `>>`), searches the whole hierarchy, and can create a term plus all
missing parents via `Parent >> Child`. **No settings page** (`configure: null`), no permissions.

- **The two-step setup (selection method + widget) and the `>>` behaviour** →
  [configure/setup.md](configure/setup.md)
- **The plugins/element and `NewTermStorage` service** → [api/plugins.md](api/plugins.md)

Key facts (two plugins that must both be selected):
- Reference method: `EntityReferenceSelection` plugin id `straw` ("Straw selection", group
  `straw`, extends `TermSelection`) — set on the **field settings**.
- Widget: `super_term_reference_autocomplete_widget` ("Autocomplete (Straw style)", extends
  `EntityReferenceAutocompleteWidget`) — set on **Manage form display**.
- Form element: `super_term_reference_autocomplete` (extends `EntityAutocomplete`).
- Depends only on `taxonomy`. Services: `straw.new_term_storage`, `cache.straw` bin.
- Hierarchy delimiter is `>>`; new-term creation requires the field to allow creating terms.
