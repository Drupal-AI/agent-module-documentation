<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Modes Inventory (vmi) 4.0.x — agent index

Installs 17 **node view modes** in five card families and auto-wires each to a Display Suite /
UI Patterns card layout when you enable it on a content type's *Manage display*.

- Families / view mode ids: `impressed_card_{xsmall,small,medium,large,xlarge}`,
  `featured_card_{xsmall,small,medium,large,xlarge}`, `text_card_{small,medium,large}`,
  `overlay_card_{medium,large,xlarge}`, `hero_card`.
- **4.0 is Drupal 11 only** — `core_version_requirement: ~11.4.0` (single pinned minor,
  distribution-style, arrives with Varbase). New major drops the 1.x D10 support and adds a
  hard `varbase_components` dependency.
- Depends on: `user`, `node`, `ds:ds`, `ds:ds_extras`, `field_group`, `smart_trim`,
  `varbase_components`. Layouts resolve to `ui_patterns:<default_theme>:card_*`.
- No admin settings form (`configure: null`), no permissions, no Drush, no config schema.
  Surface = install-time view modes + the display-form auto-mapping.

Service: `vmi.factory` → `Drupal\vmi\ViewModesInventoryFactory` (also resolvable via
`class_resolver`). Assets: `src/assets/view_modes.list.vmi.yml`,
`src/assets/layouts.mapping.vmi.yml`, `src/assets/config_templates/CONTENT_TYPE_NAME/*`.

## Capabilities

- [Enable a view mode and its auto-mapped layout, or generate the display in code](configure/view-modes.md)
