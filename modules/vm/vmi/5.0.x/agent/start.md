<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Modes Inventory (vmi) 5.0.x — agent index

Installs 17 **node view modes** in five card families and, when you enable one on a content
type's *Manage display*, auto-generates both a `core.entity_view_display` and a matching
**Canvas** (`canvas.content_template`) SDC card display for that bundle.

- Families / view mode ids: `impressed_card_{xsmall,small,medium,large,xlarge}`,
  `featured_card_{xsmall,small,medium,large,xlarge}`, `text_card_{small,medium,large}`,
  `overlay_card_{medium,large,xlarge}`, `hero_card`. The `view_modes.list` also names `full`
  and `card`, but only the 17 above are created as view modes by `config/install`.
- **5.0 is a re-platform onto `drupal/canvas`** (Single Directory Components). It drops the
  4.x Display Suite / UI Patterns / Varbase Components stack. Drupal 11 only —
  `core_version_requirement: ~11.4.0`.
- Declared dependencies: `user`, `node` (info.yml) + `drupal/canvas: ~1` (composer). No
  `ds`, `field_group`, `smart_trim` or `varbase_components` hard deps any more. (Some shipped
  `entity_view_display` templates still use the `smart_trim` formatter — a soft dependency of
  that path only.)
- No admin settings form (`configure: null`), no permissions, no Drush, no config schema.
  Surface = install-time view modes + the display-form auto-mapping.

Hooks live in `Drupal\vmi\Hook\VmiHooks` (OO `#[Hook]` attributes): `help` and
`form_entity_view_display_edit_form_alter`; the appended submit handler is
`VmiHooks::entityViewDisplayEditFormSubmit`.

Service: `vmi.factory` → `Drupal\vmi\ViewModesInventoryFactory` (the submit handler resolves it
via `class_resolver->getInstanceFromDefinition()`, which uses the class's `create()`). Assets:
`src/assets/view_modes.list.vmi.yml`, `src/assets/layouts.mapping.vmi.yml`,
`src/assets/config_templates/CONTENT_TYPE_NAME/*` (paired `core.entity_view_display.*` and
`canvas.content_template.*` per mode).

## Capabilities

- [Enable a view mode and its auto-generated core + Canvas display, or generate it in code](configure/view-modes.md)
