Search in text fields is the bundled Autotagger plugin that tags a node by scanning its configured text fields for taxonomy term labels and appending the terms it finds.

---

This submodule supplies the `search_in_text_fields` Autotagger plugin — the only tagging implementation shipped with the autotagger project. It adds an "Autotagger" settings group to the content-type add/edit form where you choose one or more **source** fields to scan and one **destination** taxonomy_term entity_reference field. On node presave it gathers text from the source fields (plain text/string fields, text fields on referenced node/media entities, and text fields on referenced paragraphs including nested ones), lowercases and Unicode-normalizes it, then loads every possible term for the destination field and appends any term whose label occurs as a whole-word substring of that text. An option limits tagging to initial node creation only. Matching is purely local literal string matching — there is no AI, no scoring, and no network access. Requires the `autotagger` core module and core Taxonomy.

---

- Enable it (with `autotagger`) to get working auto-tagging out of the box.
- Tag nodes automatically from the words already in their text fields.
- Pick which fields on a content type are scanned for term labels.
- Choose the taxonomy reference field that receives the matched terms.
- Reuse an existing controlled vocabulary as the tag source.
- Scan the node title, body, and any text/string/long-text fields.
- Scan text fields on referenced node or media entities.
- Scan text fields on referenced paragraphs, drilling into nested paragraphs.
- Tag only when a node is first created (leave later edits untouched).
- Re-tag on every save when the create-only option is off.
- Keep manually assigned tags and only add newly matched terms.
- Avoid duplicate term references (dedupe by target id).
- Match accented / multi-byte term labels correctly (NFC normalization).
- Match on whole words only (punctuation and separators are collapsed).
- Bootstrap related-content and faceted search by ensuring nodes carry tags.
- Enforce consistent taxonomy tagging across editors.
- Categorize an imported content batch by saving each node once.
- Use it as the reference example when writing a custom Autotagger plugin.
- Restrict auto-tagging to the specific content types you configure.
- Leave nodes untouched when the plugin is unconfigured for their type.
