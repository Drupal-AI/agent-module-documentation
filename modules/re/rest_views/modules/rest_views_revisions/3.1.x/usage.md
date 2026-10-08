<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Views Entity Revisions is a submodule of REST Views that adds an export field formatter for Entity Reference Revisions fields (the field type behind Paragraphs), so revisioned references can be serialized as nested structures in a Views REST Export.

---

The submodule contributes a single field formatter, **`entity_reference_revisions_export`**
(class `EntityReferenceRevisionsExportFormatter`), which extends the parent module's
`EntityReferenceExportFormatter` and targets the `entity_reference_revisions` field type. Because
entity-reference-revisions fields already expose the core Views `field` handler, REST Views' own
`hook_views_data_alter()` already provides the **"(serializable)"** (`field_export`) handler for
them — this submodule only needs to add the matching export formatter. Used on the serializable
handler, it serializes each referenced (revisioned) entity as a nested structure, like the
regular entity-reference export but for Paragraphs and other ERR fields. Deep nesting still
generally needs a dedicated display mode whose sub-fields also use export formatters. The
submodule has no configuration, permissions, Drush, or plugin types; it requires
`entity_reference_revisions` and `rest_views`.

---

- Export a Paragraphs field as a nested array of paragraph data in a REST feed.
- Serialize entity-reference-revisions targets as structured JSON, not HTML.
- Feed a decoupled front-end the structured content of a Paragraphs field.
- Include nested paragraph fields in a Views REST Export payload.
- Export a flexible page-builder (Paragraphs) body as JSON for an app.
- Combine paragraph exports with other serialized fields in one row.
- Serialize a repeatable ERR field as an array of nested objects.
- Provide structured layout/content blocks to a headless renderer.
- Avoid custom code to expose Paragraphs over REST.
- Export a component-based content model as nested data.
- Serialize FAQ/accordion paragraphs as an array of {question, answer}-style objects.
- Drive a mobile app's rich content from Paragraphs via Views.
- Return nested media/paragraph references in a search results endpoint.
- Keep paragraph values typed by pairing sub-fields with export formatters.
- Export a Paragraphs slideshow as structured slide data.
- Replace a bespoke Paragraphs normalizer with a Views-configured export.
