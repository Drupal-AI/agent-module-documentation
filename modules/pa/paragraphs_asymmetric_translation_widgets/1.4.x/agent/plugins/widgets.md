<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widgets provided / altered

This module does not define new plugin *types*; it provides field **widget** plugins for
the core Field Widget plugin type (`Plugin/Field/FieldWidget`). Two mechanisms:

## 1. `paragraphs_classic_asymmetric` (a real, selectable widget)

- **Class:** `Drupal\paragraphs_asymmetric_translation_widgets\Plugin\Field\FieldWidget\ParagraphsClassicAsymmetricWidget`
- **Extends:** `Drupal\paragraphs\Plugin\Field\FieldWidget\InlineParagraphsWidget` (the
  legacy/classic Paragraphs widget).
- **Annotation:** `id = "paragraphs_classic_asymmetric"`, label *"Paragraphs Legacy
  Asymmetric"*, `field_types = { "entity_reference_revisions" }`.
- Appears in the form-display "Widget" dropdown for any `entity_reference_revisions` field.
- **Settings** (config schema `field.widget.settings.paragraphs_classic_asymmetric`):
  `title`, `title_plural`, `edit_mode`, `add_mode`, `form_display_mode`,
  `default_paragraph_type` — same keys as the classic Paragraphs widget.

## 2. The modern `paragraphs` widget — class swap (no new id)

The module implements `hook_field_widget_info_alter()` and, if the `paragraphs` widget
definition exists, rewrites its `class` to
`…\Plugin\Field\FieldWidget\ParagraphsAsymmetricWidget` (which extends the stable
`ParagraphsWidget`). So the widget id **stays `paragraphs`**; there is no second selectable
id for the modern form. On this site you can confirm the swap:

```bash
drush php:eval '$d = \Drupal::service("plugin.manager.field.widget")->getDefinition("paragraphs");
  print $d["class"] . "\n";'
# => Drupal\paragraphs_asymmetric_translation_widgets\Plugin\Field\FieldWidget\ParagraphsAsymmetricWidget
```

## The duplication engine (why it works)

Both widgets rely on `hook_entity_translation_create($entity)` in the `.module` file: when
a new translation of a host entity is created, it finds every **translatable**
`entity_reference_revisions` field whose target is `paragraph` and recursively duplicates
the source paragraphs, so each language starts with its own paragraph revisions and can
then diverge (add / remove / reorder) independently.

## Implementing your own variant

To customize behavior, subclass one of the widget classes above and give it a new
`@FieldWidget` id, or re-alter the `paragraphs` class in a later-weighted
`hook_field_widget_info_alter()`. There are no dedicated hooks or services beyond these.
