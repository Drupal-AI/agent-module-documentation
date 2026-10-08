<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled Entity Block (seb) — agent index

**Derives one block per content entity type that renders a chosen entity in a chosen view mode only during a configured schedule.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Plugin:** block `seb_entity_block` with deriver `Drupal\seb\Plugin\Derivative\EntityBlock` (one derivative per entity type with a view builder).
- **Config:** stored on the block instance — target `entity`, `view_mode`, and a `seb_type` schedule (daily / week_days / weekend_days / between_dates / custom).
- **Render gate:** `EntityBlock::isValidNow()` checks the current time; `build()` returns empty when out of window; recursive-render guard limit 3.
- **No routes, no permissions, no services.**

**Security:** `blockAccess()` delegates to the target entity's own `view` access (`AccessResult::forbidden` otherwise) and merges the entity's cache metadata; no anonymous or mutating endpoints.
