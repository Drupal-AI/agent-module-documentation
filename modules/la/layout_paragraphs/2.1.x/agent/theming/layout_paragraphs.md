# Theming Layout Paragraphs

Layout Paragraphs registers theme hooks in `layout_paragraphs_theme()` (see
`layout_paragraphs.module`) and exposes preprocess hooks for the builder UI. The rendered
front-end markup is produced by the core Layout Discovery layout templates plus the module's
own builder/control templates.

## Preprocess hooks (from `layout_paragraphs.api.php`)

- `hook_preprocess_layout_paragraphs_builder(&$variables)` — alter the whole builder render
  (called from `LayoutParagraphsBuilder::preRender()`).
- `hook_preprocess_layout_paragraphs_builder_controls(&$variables)` — alter the per-component
  controls UI (move up / move down / edit / delete / duplicate, etc.).

## Altering component output

In `hook_entity_view_alter()` you can detect a Layout Paragraphs component via
`$build['#layout_paragraphs_component']` and adjust its build array, or change the builder's
client-side UI elements through `$build['drupalSettings']['lpBuilder']['uiElements']`.

## Labels & modal appearance

Visible chrome is driven by config rather than templates:
- `layout_paragraphs.settings`: `show_paragraph_labels`, `show_layout_labels`,
  `paragraph_behaviors_label`, `paragraph_behaviors_position`, `empty_message`.
- `layout_paragraphs.modal_settings`: `width`, `height`, `autoresize` for the builder dialog.

## Layout rendering

Sections render through core layouts (Layout Discovery). To change the visual layout output,
override or add layouts the normal core way (a `*.layouts.yml` definition + its Twig template
in your theme/module); any layout enabled in a section's `available_layouts` becomes selectable
in the builder.

Libraries are declared in `layout_paragraphs.libraries.yml` (builder JS/CSS) and attached by
the widget/formatter/render element.
