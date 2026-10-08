<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Paragraphs (entity_reference_deck_paragraphs) — agent index

Host submodule of **Entity Reference Deck** for **Paragraphs**. Depends on `entity_reference_deck`,
contrib **`paragraphs`** and **`entity_reference_revisions`**. Core `^11.4 || ^12`. Version
1.0.0-beta5. No permission or config of its own.

## What it provides
- Field widget **`entity_reference_deck_paragraphs`** (label *Paragraphs (entity reference deck)*,
  field type `entity_reference_revisions`) —
  `src/Plugin/Field/FieldWidget/EntityReferenceDeckParagraphsWidget.php`, extends `ParagraphsWidget`;
  closed rows use `EntityReferenceDeckCardBuilder`, `closed_mode` locked to `preview`; preview host
  adapter (`withShowPreview()`, in-form paragraph + `hasUnsavedChanges`).
- `ParagraphsCardTypePresentation` (decorates the card type-presentation; icons via
  `ParagraphsType::getIconUrl()`), `ParagraphPreviewProvider` (Plugin/PreviewProvider) and
  `ParagraphPreviewSnapshot` service.
- Library **`widget`**.

## Operate
Enable with Paragraphs + Entity Reference Revisions. On *Manage form display*, set the paragraphs
field widget to **Paragraphs (entity reference deck)**.
