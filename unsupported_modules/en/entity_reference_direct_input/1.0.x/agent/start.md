<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Direct Input (entity_reference_direct_input) — agent index

**Overrides the entity autocomplete matcher so ID / #ID / email / URL / alias input resolves to a reference (Node, User, Taxonomy Term).**

- **Version:** 1.0.x  •  **Core:** ^10.2 || ^11  •  **Configure:** `entity_reference_direct_input.admin_settings` (`/admin/config/content/entity-reference-direct-input`)
- **Mechanism:** `EntityReferenceDirectInputServiceProvider` swaps core `entity.autocomplete_matcher` for `EntityReferenceDirectInputMatcher`.
- **Config:** `entity_reference_direct_input.settings:enabled_entities` (list of enabled target types).
- **Route:** settings form gated by `administer site configuration`. No custom permissions.
- **Security:** Matcher augments suggestions only; it respects the field's `target_bundles` before injecting a match. Path→ID resolution uses `getUrlIfValidWithoutAccessCheck()` (`EntityReferenceDirectInputMatcher.php:237`), i.e. it maps a path to an ID without a view-access check — but final entity access is still enforced by the reference selection handler and by the entity's own access on save/render. No public endpoints.

See [configure/settings.md](configure/settings.md)
