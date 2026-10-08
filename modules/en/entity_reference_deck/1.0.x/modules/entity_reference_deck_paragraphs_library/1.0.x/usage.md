<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Paragraphs Library makes a Paragraphs Library item card reflect the underlying reusable paragraph.

---

This feature submodule is the companion to the Paragraphs host for the contrib Paragraphs Library module. When a deck card represents a Paragraphs Library item (a wrapper around a reusable paragraph), it unwraps the item and presents the underlying paragraph's type and label so the card is meaningful rather than showing the generic library-item wrapper. It provides LibraryItemCardTypePresentation (decorating the card type presentation), LibraryItemParagraphUnwrapper (resolving the wrapped paragraph), a ParagraphsLibraryItemPreviewProvider, and a library-item Twig template. Depends on the Paragraphs host submodule and Paragraphs Library.

---

- Show the underlying reusable paragraph's type on a library-item card.
- Show the underlying paragraph's label instead of the wrapper label.
- Unwrap Paragraphs Library items for accurate card presentation.
- Preview a library item's referenced paragraph live.
- Render library items with a dedicated Twig template.
- Keep reusable-content cards consistent with regular paragraph cards.
- Support Paragraphs Library selections in Paragraphs deck widgets.
- Support Paragraphs Library items selected via Entity Browser deck displays.
- Show the correct type icon for a reusable paragraph.
- Give editors clarity when reusing shared paragraphs.
- Combine with moderation styling on library-item cards.
- Combine with usage counts on library-item cards.
- Avoid custom code to present library items nicely.
- Decorate the card type presentation chain cleanly.
- Degrade gracefully when an item cannot be unwrapped.
- Maintain a consistent deck experience for reusable content.
- Help content teams manage a library of shared paragraphs.
- Reflect reusable-paragraph metadata in long reference lists.
- Integrate with the preview provider system for library items.
- Keep library-item cards visually aligned with the active skin.
