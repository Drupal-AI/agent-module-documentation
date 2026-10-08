<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Usage adds a card action showing how many nodes reference the card's entity, using the Entity Usage module.

---

This feature submodule integrates the contrib Entity Usage module into Entity Reference Deck. It registers a 'usage' card action (UsageEntityReferenceDeckAction) that renders a usage badge for the referenced entity, backed by EntityReferenceDeckUsageCounter which queries the entity_usage service (listSources) for the distinct source node IDs that use the entity. Editors can see at a glance whether a referenced entity is reused elsewhere. Enable it after entity_reference_deck when Entity Usage is present.

---

- Show how many nodes reference a card's entity.
- Render a usage badge on deck cards.
- Query Entity Usage for distinct source nodes.
- Help editors spot shared/reused referenced entities.
- Warn implicitly when editing widely-used content.
- Work across Entity Browser deck widgets.
- Work across Paragraphs deck widgets.
- Support any entity type tracked by Entity Usage.
- Skip the badge for unsaved or unused entities.
- Toggle and reorder the usage action from the global settings form.
- Combine with moderation styling for a fuller status overview.
- Combine with diff to review usage-relevant changes.
- Avoid custom code to surface usage in reference UIs.
- Give content teams reuse awareness while editing.
- Present usage consistently across deck host widgets.
- Reflect real-time usage counts from Entity Usage.
- Help prevent accidental edits to heavily-referenced media.
- Surface usage in long reference lists at a glance.
- Support editorial governance of shared assets.
- Integrate cleanly as a discoverable action plugin.
