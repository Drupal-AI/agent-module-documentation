<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck adds a shared card ("erdeck-card") shell and a pluggable toolbar of actions (moderation, usage, diff, preview) to entity reference fields, driven from existing Entity Browser and Paragraphs widgets rather than a brand-new field widget.

---

Entity Reference Deck is a framework, not a single widget. Its core module ships a card builder (`EntityReferenceDeckCardBuilder`) and a toolbar builder (`EntityReferenceDeckBuilder`) that render referenced entities as consistent Apple-style list-row "cards" built from Single Directory Components (erdeck-card, status-tag, usage-badge, type-icon, meta-text, action-link). Around each card it assembles a toolbar of discoverable **action** plugins grouped into **groups**, plus muted **meta-item** lines, each of which can be enabled/disabled and re-ordered from one global settings form. Hosts bind this card builder to a concrete editing surface: the EB submodule provides an Entity Browser `FieldWidgetDisplay`, and the Paragraphs submodule provides a Paragraphs field widget and closed-row chrome. Feature submodules contribute specific actions/surfaces — Diff (revision compare modal), Usage (Entity Usage counts), Moderation (Content Moderation styling), Paragraphs Library — and an optional Preview submodule renders a live, sandboxed front-end iframe preview of the referenced entity inside its card. The whole system degrades gracefully: the core module depends only on core Field, and each feature is a separately enabled submodule with its own dependencies. Card labels are rendered as plain text and referenced entities respect their own view access, so no per-site custom widget code is needed to get a uniform, extensible reference-editing experience.

---

- Give entity reference fields a consistent card-based editor UI without writing a custom widget per site.
- Show each referenced entity as an erdeck-card with an icon, type label, primary label, meta lines and an action toolbar.
- Add a moderation status pill (Draft / Unpublished edits / New) to reference cards when Content Moderation is in play.
- Surface Entity Usage counts on reference cards so editors see where a referenced entity is used.
- Offer a "compare revisions" action that opens a Diff comparison in an AJAX modal dialog.
- Render a live front-end preview of a referenced entity inside its card via a sandboxed iframe.
- Give editors a preview refresh and preview show/hide toggle action on each card.
- Present referenced entities inside an Entity Browser widget with deck card chrome (list / pill layout).
- Present closed Paragraph rows with deck card chrome, including the paragraph type icon.
- Reorder toolbar actions and their groups site-wide from Configuration -> Content authoring -> Entity Reference Deck.
- Enable or disable individual card meta items (timestamps, editor) and set their order.
- Show relative "created/updated/draft saved N ago" timestamps as a card meta line.
- Show the last editor of a referenced entity as a card meta line.
- Style reference cards to match the Gin admin theme by remapping --erdeck-* CSS tokens.
- Extend the toolbar with your own action plugin (implement `EntityReferenceDeckActionInterface`, add the `EntityReferenceDeckAction` attribute).
- Add a custom card meta line with a meta-item plugin (`EntityReferenceDeckMetaItemInterface`).
- Wrap a toolbar group in a custom (Lit) element via a group plugin (`EntityReferenceDeckGroupInterface`).
- Add entity-type-specific live preview by implementing a PreviewProvider plugin.
- Alter any built card render array centrally via `hook_entity_reference_deck_card_alter()`.
- Alter the discovered action/group/meta-item definitions via the `*_info_alter` hooks.
- Reuse the same card chrome across both Entity Browser and Paragraphs editing without duplicating markup.
- Present a Paragraphs Library item as a card that reflects the underlying reusable paragraph's type.
- Keep reference-management UX consistent when migrating a field between Entity Browser and Paragraphs.
- Restrict live preview to trusted editors with the "use entity reference deck preview" permission.
- Give content authors an at-a-glance status/usage overview of long reference lists.
