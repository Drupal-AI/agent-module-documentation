<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Patterns lets you control what an entity-reference autocomplete actually shows: instead of the bare `Label (id)`, suggestions, the pre-filled value of an existing reference, and select-list options can all be rendered from a Token pattern — title plus author, or SKU plus product name — configured per entity type with optional bundle criteria.

---

Core's autocomplete offers `Label (id)` and nothing else, which is unhelpful when many entities share a title. This module adds an `entity_reference_pattern` config entity holding a `type` (target entity type), a Token `pattern`, `selection_criteria` limiting it to certain bundles, and a `weight` so several patterns can be ordered and the lightest matching one wins. Patterns are managed at `/admin/config/search/entity-reference-patterns` with add, edit, duplicate and delete operations in modal dialogs, each governed by its own permission — `administer entity reference pattern` and `delete entity reference pattern` are marked restricted, while add, edit and duplicate are ordinary editorial permissions. Application happens on three fronts: a route subscriber swaps core's `system.entity_autocomplete` controller so live suggestions come from `EntityReferencePatternMatcher`; `hook_element_info_alter` repoints the autocomplete element's `#value_callback` at the module's `Element\EntityAutocomplete` so an already-stored reference value is shown with the pattern too; and `hook_options_list_alter` applies the same formatting to select, radio and checkbox widgets. Token replacement uses `clear => TRUE`, so unresolved tokens render empty and the code falls back to the default label. A small JS library hides the trailing `(id)` in the visible field while keeping the real value, and the module requires the Token module since patterns are Token strings.

---

- Show an author's name alongside the node title in autocomplete.
- Distinguish entities that share the same label.
- Display a product SKU next to its name when referencing products.
- Include a taxonomy parent in term autocomplete suggestions.
- Show the publication date in article reference suggestions.
- Apply different patterns to different entity types.
- Format select-list options the same way as autocomplete.
- Order patterns by weight so the most specific one wins.
- Limit a pattern to specific bundles with the checkboxes, or leave empty for all.
- Duplicate an existing pattern as a starting point.
- Let editors add patterns without full admin rights.
- Restrict pattern deletion to administrators.
- Use any token available on the referenced entity type.
- Improve editor accuracy when picking references.
- Reduce mis-selection on sites with duplicate titles.
- Include a status indicator in labels for unpublished items.
- Add a bundle label to mixed-bundle reference fields.
- Keep the pattern configuration exportable with the site.
- Give media reference fields more informative labels.
- Standardise reference labels across an editorial team.
