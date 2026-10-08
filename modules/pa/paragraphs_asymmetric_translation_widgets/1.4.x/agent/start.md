<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Asymmetric Translation Widgets — agent index

Makes a translatable Paragraphs reference field **asymmetric**: each language of the host
entity keeps its own independent set of paragraph items (add / delete / reorder per
language). No admin settings form — you enable it by picking the module's widget on a
bundle's **form display**, on a *translatable* `entity_reference_revisions` → `paragraph`
field.

- **Turn a paragraphs field asymmetric (form-display widget)** → [configure/widgets.md](configure/widgets.md)
- **The two widgets it provides / swaps, plugin ids & settings** → [plugins/widgets.md](plugins/widgets.md)

Key facts:
- Legacy widget id: `paragraphs_classic_asymmetric` (label "Paragraphs Legacy Asymmetric").
- Modern widget: no new id — the module rewrites the class of the stable `paragraphs`
  widget via `hook_field_widget_info_alter`.
- Duplication engine: `hook_entity_translation_create` recursively clones the source
  language's paragraphs when a translation is created.
- Depends on `paragraphs` (1.15+) and `content_translation`; the field must be translatable.
