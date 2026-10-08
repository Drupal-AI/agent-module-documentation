<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Paragraphs is the Paragraphs host: an opt-in field widget that renders closed paragraph rows as deck cards.

---

This host submodule binds the Entity Reference Deck card builder to Paragraphs. It provides the 'entity_reference_deck_paragraphs' field widget (EntityReferenceDeckParagraphsWidget), which extends the stable ParagraphsWidget so add/drag/AJAX behaviour is inherited unchanged; closed rows are locked to preview mode and rendered as deck cards via EntityReferenceDeckCardBuilder. It decorates the card type presentation with paragraph type labels and icons (ParagraphsCardTypePresentation, using ParagraphsType::getIconUrl()), supplies a ParagraphPreviewProvider plus a ParagraphPreviewSnapshot service, and acts as the preview host adapter (mapping the widget's show_preview to the card context and passing in-form/unsaved-changes signals). Requires Paragraphs and Entity Reference Revisions.

---

- Render closed Paragraph rows as deck cards.
- Keep Paragraphs add/drag/AJAX behaviour intact by extending the core widget.
- Show the paragraph type icon on each closed row via getIconUrl().
- Show the paragraph type label on each card.
- Lay out paragraph rows as a list or grid.
- Preview referenced paragraphs live when the Preview submodule is enabled.
- Pass unsaved in-form paragraph changes into the card context.
- Give paragraph rows a consistent action toolbar.
- Reuse the same card chrome as the Entity Browser host.
- Skin paragraph cards for Gin via the Gin submodule.
- Add moderation status pills to paragraph cards.
- Add usage counts to paragraph cards.
- Add revision compare to paragraph cards.
- Support Paragraphs Library items via the companion submodule.
- Opt in per field by selecting the deck Paragraphs widget on Manage form display.
- Keep deck CSS hooks stable across AJAX row rebuilds.
- Avoid reimplementing a custom Paragraphs widget from scratch.
- Toggle and reorder toolbar actions globally for paragraph cards.
- Provide a scannable overview of a long paragraphs field.
- Improve the closed-row editing experience for structured content.
