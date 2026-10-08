<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Moderation (entity_reference_deck_moderation) — agent index

Feature submodule of **Entity Reference Deck**. Content Moderation-aware card styling. Depends on
`entity_reference_deck`, core **`content_moderation`** and **`workflows`**. Core `^11.4 || ^12`.
Version 1.0.0-beta5. No permission, route or config of its own.

## What it provides
- Service `entity_reference_deck_moderation.moderation_style`
  (`src/EntityReferenceDeckContentModerationStyle.php`) — resolves the card tint modifier
  (`draft` / `has-draft` / `new`) and label from the entity's moderation state; consumed by the core
  card builder and the `moderation` action's `status-tag`.

## Operate
Enable with Content Moderation + Workflows and a moderation workflow on the referenced entity type.
The tint/pill then appear automatically on deck cards; no configuration.
