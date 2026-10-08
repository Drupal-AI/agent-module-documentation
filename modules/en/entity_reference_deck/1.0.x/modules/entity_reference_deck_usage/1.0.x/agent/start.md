<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Usage (entity_reference_deck_usage) — agent index

Feature submodule of **Entity Reference Deck**. Surfaces Entity Usage counts on cards. Depends on
`entity_reference_deck` and contrib **`entity_usage`**. Core `^11.4 || ^12`. Version 1.0.0-beta5.
No permission, route or config of its own.

## What it provides
- Action plugin **`usage`** (`src/Plugin/EntityReferenceDeckAction/UsageEntityReferenceDeckAction.php`)
  rendering the `entity_reference_deck:usage-badge` component.
- Service `entity_reference_deck_usage.counter` (`EntityReferenceDeckUsageCounter`) — `nidsFor()`
  calls `entity_usage.listSources()` and returns distinct source node IDs (empty for unsaved/unused).

## Operate
Enable with `entity_usage`. The badge appears on cards for entities Entity Usage tracks; toggle and
reorder the action on the core settings form.
