<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 integration & the reference dropdown

## CKEditor 5 plugin

- Defined in `bibcite_footnotes.ckeditor5.yml`: Drupal plugin id `bibcite_footnotes_bibciteFootnotes`,
  label "Citation Footnotes", toolbar item `bibciteFootnotes` ("Insert citation"), library
  `bibcite_footnotes/bibciteFootnotes`, CKEditor plugin `bibciteFootnotes.BibciteFootnotes`.
- Declared editable elements: `<bibcite-footnote>` and `<bibcite-footnote data-entity-id data-page-range>`.
- PHP side `src/Plugin/CKEditor5Plugin/BibciteFootnotes.php` — a bare `CKEditor5PluginDefault`
  subclass (uses the configurable trait; `getDynamicPluginConfig` is commented out). All behaviour is
  in the compiled JS.
- JS: source at `js/ckeditor5_plugins/bibciteFootnotes/src/` (`index.js`, `bibciteFootnotes.js`, CSS);
  the built bundle shipped/loaded is `js/build/bibciteFootnotes.js` (see `bibcite_footnotes.libraries.yml`,
  library `bibciteFootnotes`, depends on `core/ckeditor5`). Build with `yarn build` (webpack). The
  toolbar button opens a dialog listing available references and inserts the `<bibcite-footnote>` tag.

To enable per format: edit a text format, move "Insert Citation" into the toolbar, enable the "Inline
citation filter", and configure it (see [filter.md](filter.md)).

## Feeding the dropdown — `bibcite_footnotes_form_node_form_alter()`

Implemented in `bibcite_footnotes.module`. It populates
`drupalSettings.bibcite_footnotes.references` with the references the author may cite, as an array of
`[citation_text, citation_key]` pairs built by `bibcite_footnotes_get_ckeditor_select_item()`
(normalizes the entity to CSL via the `serializer`, renders `#theme` `bibcite_citation`, strips tags;
key = the reference entity id).

Two code paths:
- **Inline Entity Form present:** iterates `$form_state->get('inline_entity_form')` instances, keeps
  those whose handler is `default:bibcite_reference`, and reads their staged entities. Also attaches
  `core/drupal.dialog` and `bibcite_footnotes/ckeditor5.referenceFootnotes`. References just added
  inline become immediately selectable.
- **No IEF:** finds the node's `entity_reference` field whose handler is `default:bibcite_reference`
  (the "Works Cited" field) and reads its `referencedEntities()`.

`hook_inline_entity_form_entity_form_alter()` forces `$form['#save_entity'] = TRUE` so newly created
references are persisted.

If the `bibcite_import` module is enabled and the current user has the `bibcite import` permission, a
"Bulk import citations by going to Bibcite Import" link is appended under the reference field.

## Setup checklist (from README)

1. Install; BibCite + BibCite Entity enable as dependencies.
2. On a text format: add the "Insert Citation" toolbar button and enable + configure the Inline
   citation filter.
3. On the content type: add an entity-reference field targeting **Reference** (`bibcite_reference`)
   — the "Works Cited" field. Choose the allowed reference types. Set its display to "Disabled" since
   the bibliography renders inside the Body via the filter.
4. (Recommended) Install Inline Entity Form and set the Works Cited widget to "Inline Entity Form –
   complex" so authors create references in the node form.
