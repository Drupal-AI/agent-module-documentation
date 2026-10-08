<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Dynamic Display (entity_reference_dynamic_display) — agent index

**Field formatter that renders each referenced entity with a view mode chosen per target bundle or per item delta.**

- **Version:** 8.x-1.x  •  core: `^8 || ^9 || ^10`  •  package: Custom.
- **Formatter:** `@FieldFormatter(id="dynamic_display")` `DynamicDisplay extends EntityReferenceEntityFormatter`; field types `entity_reference`, `entity_reference_revisions`.
- **Settings:** `override` (`none` | `bundle` | `delta`), `bundle_modes`, `delta_modes`, plus default `view_mode`.
- **No routes/permissions/config;** configured on each field's Manage Display.

**Security (reviewed, sound):** extends core's rendered-entity formatter, inheriting referenced-entity access checks and recursion protection; it only selects a view mode. No endpoints or mutation.
