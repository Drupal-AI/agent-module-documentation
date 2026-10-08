<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Paragraphs Library (entity_reference_deck_paragraphs_library) — agent index

Feature submodule of **Entity Reference Deck**. Paragraphs Library companion. Depends on the
Paragraphs host **`entity_reference_deck_paragraphs`** and contrib **`paragraphs_library`**. Core
`^11.4 || ^12`. Version 1.0.0-beta5. No permission, route or config of its own.

## What it provides
- `LibraryItemCardTypePresentation` — decorates the card type presentation so a library-item card
  shows the underlying reusable paragraph's type/label.
- `LibraryItemParagraphUnwrapper` — resolves the wrapped paragraph from a library item.
- `ParagraphsLibraryItemPreviewProvider` (Plugin/PreviewProvider) and a
  `templates/paragraphs-library-item.html.twig` (via `Hook/ThemeHooks`).

## Operate
Enable with the Paragraphs host and Paragraphs Library. Library-item cards then reflect the
underlying paragraph automatically; no configuration.
