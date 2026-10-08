<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck EB is the Entity Browser host: it provides a FieldWidgetDisplay that renders selected entities as deck cards inside stock Entity Browser reference widgets.

---

This host submodule binds the Entity Reference Deck card builder to Entity Browser. It registers the 'entity_reference_deck' Entity Browser FieldWidgetDisplay plugin (EntityReferenceDeckDisplay), which an editor selects on a stock entity_browser_entity_reference widget (or the optional entity_browser_multi multi-launcher) exactly like picking 'Rendered entity' or 'Label'. Each selected entity is then rendered through EntityReferenceDeckCardBuilder, respecting the entity's own view access (a user without access sees a restricted label instead of the card). A field_widget_complete_form_alter hook stamps deck CSS classes and a list/grid listing modifier on the widget, attaches the widget library, and — when the display's show_preview is on and the Preview submodule is enabled — mounts the preview field chrome. Requires the contrib Entity Browser module.

---

- Render Entity Browser selections as deck cards instead of plain labels.
- Choose the deck display on any entity_browser_entity_reference widget.
- Extend deck chrome to entity_browser_multi multi-launcher widgets.
- Show an icon, type, label and action toolbar for each selected entity.
- Lay out selections as a list or a grid via the listing_style setting.
- Respect each referenced entity's view access in the selection list.
- Show a restricted label when the user cannot view a selected entity.
- Mount live preview field chrome when the Preview submodule is enabled.
- Keep deck styles stable across Entity Browser AJAX rebuilds.
- Give media reference fields a card-based selection UI.
- Give content reference fields a consistent selection UI.
- Combine with the Diff action to compare revisions from the browser.
- Combine with the Usage action to see where a selection is used.
- Combine with the Moderation submodule for status pills on selections.
- Reuse the same card chrome as the Paragraphs host for consistency.
- Skin the widget for Gin via the Gin submodule.
- Avoid writing a custom Entity Browser display plugin per site.
- Toggle and reorder toolbar actions globally for browser cards.
- Support Paragraphs Library items selected through Entity Browser.
- Present long reference lists with scannable status metadata.
