<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin surface (filter, CKEditor 5, embed type, embed display, widget)

The module implements several plugin types from filter/embed/entity_embed/paragraphs. You don't
implement a plugin type of its own; these are the ids to know.

## Filter — `paragraphs_entity_embed`

`Plugin/Filter/ParagraphEmbedFilter` — title "Display embedded paragraphs",
`TYPE_TRANSFORM_REVERSIBLE`. On output it finds `<drupal-paragraph>` elements (via `DomHelperTrait`
+ Entity Embed's builder) and replaces them with the rendered embedded paragraph. Enable it on a
text format for embeds to render.

## CKEditor 5 plugin — `paragraphs_entity_embed_paragraphsEmbed`

Declared in `paragraphs_entity_embed.ckeditor5.yml`; PHP class
`Plugin/CKEditor5Plugin/DrupalParagraph`. JS plugin `embeddedParagraph.ParagraphsEmbed` opens the
Drupal dialog. Provides the **Paragraphs** toolbar button (toolbar items are added dynamically in
`paragraphs_entity_embed_ckeditor5_plugin_info_alter()` from the embed buttons). Declares the
allowed elements `<drupal-paragraph>` (with `data-embed-button data-entity-label data-paragraph-id
data-paragraph-revision-id data-align`) and condition `filter: paragraphs_entity_embed`.

## Embed type — `paragraphs_entity_embed`

`Plugin/EmbedType/Paragraph` (`@EmbedType(id="paragraphs_entity_embed", label="Paragraph")`). The
type behind the `paragraphs` embed button; provides its settings form (paragraph-type filter,
add mode).

## Entity Embed Display — `entity_reference_revisions`

`Plugin/entity_embed/EntityEmbedDisplay/EntityReferenceRevisionFieldFormatter` extends Entity
Embed's `EntityReferenceFieldFormatter` (deriver `FieldFormatterDeriver`,
`field_type = entity_reference_revisions`). Renders the referenced paragraph revision as the
embed display.

## Field widget — `entity_reference_embed_paragraphs`

`Plugin/Field/FieldWidget/EmbedParagraphsWidget` (extends Paragraphs' `ParagraphsWidget`). The
inline add/edit widget used inside the embed dialog (and as the `paragraph` field's default form
widget); hides add/remove buttons while translating.

## Dialog routes & controller

`ParagraphsEntityEmbedController` serves the iframe dialog:
- `paragraphs_entity_embed.dialog` — `/paragraph-embed/dialog/{editor}/{embed_button}` (add).
- `paragraphs_entity_embed_edit.dialog` —
  `/paragraph-embed/dialog/{editor}/{embed_button}/{embedded_paragraphs_uuid}/{embedded_paragraphs_revision_id}` (edit).
- `paragraphs_entity_embed.autocomplete` — `/paragraphs_entity_embed/autocomplete`.

The embed form class is bound via `hook_entity_type_build()`:
`embedded_paragraphs` gets form handler `paragraphs_entity_embed` →
`Form/ParagraphEmbedDialog`.
