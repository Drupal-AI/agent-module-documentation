<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Filterable Autocomplete" entity-reference widget whose bundle select restricts autocomplete suggestions to one of the field's allowed target bundles.

---

Entity Reference Field Autocomplete Filter ships one field widget, "Filterable Autocomplete" (plugin id `entity_reference_filterable_autocomplete`), for `entity_reference` fields. It extends Drupal core's `EntityReferenceAutocompleteWidget`, so it keeps all the standard autocomplete settings (match operator, match limit, size, placeholder) and adds a "Search within" select box above the autocomplete textfield. When the reference field is configured to allow two or more target bundles, an editor can pick a bundle from that select and the autocomplete suggestions are AJAX-narrowed to that single bundle; choosing "- Any bundle -" searches across all the field's allowed bundles again. If the field allows only one bundle (or none), the extra select is not shown and the widget behaves exactly like the core autocomplete widget. Enable it per field on the entity's Manage form display page. The module has no dependencies beyond core, defines no permissions, no configuration form, and no routes — it reuses core's entity autocomplete endpoint and selection handling throughout.

---

- Let editors quickly narrow a large entity-reference autocomplete to a single content type before typing.
- Reference a node field that targets several node bundles, and search within just one (e.g. only Articles).
- Speed up picking a term from a term-reference field that spans multiple vocabularies by limiting to one vocabulary.
- Reduce mismatched picks when many bundles share similar titles by scoping the search first.
- Keep the familiar core autocomplete UX while adding a per-widget bundle scope.
- Preserve the core autocomplete "Match operator" (starts with / contains) setting on the filtered field.
- Preserve the core "Number of results" (match limit) setting for suggestions.
- Preserve the core textfield "Size" and "Placeholder" settings.
- Default the "Search within" select to the bundle of the already-referenced entity when editing existing content.
- Fall back to all allowed bundles when no specific bundle is selected.
- Swap the widget on any existing entity_reference field via Manage form display with no data migration.
- Apply it to reference fields on nodes, taxonomy terms, media, users, or any content entity type.
- Give content authors a guided, less error-prone reference picker on complex editorial forms.
- Avoid writing a custom Entity Reference Selection plugin just to scope autocomplete by bundle.
- Combine with core's field-level "target bundles" setting so the select only offers bundles the field already permits.
- Style the bundle select and textfield together via the bundled `theme` CSS library (flex row layout).
- Let a multi-bundle "related content" field be filtered to one type at edit time.
- Use it on paragraph or block reference fields to scope suggestions by paragraph/block bundle.
- Keep single-bundle reference fields untouched (the widget degrades to plain autocomplete automatically).
- Configure it entirely through the UI — no code, no YAML edits required to operate it.
- Deploy the widget choice through exported form-display config across environments.
- Provide editors a bundle dropdown labelled by human-readable bundle labels, not machine names.
- Re-run the autocomplete instantly when the bundle select changes, via the widget's AJAX callback.
