<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_reference` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_entity_reference -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.entity_reference` — the bundle.
- `field.storage.paragraph.field_nodeentityref` + `field.field.paragraph.entity_reference.field_nodeentityref`
  (entity reference to `node`, selection **handler: views**, view
  `entity_reference_referenceable_nodes`). The optional view is shipped in `config/optional`.
- `field_nodeentityrefvm` (the shared view-mode selector storage lives in the base module) — picks the
  display view mode; hidden on the default view display.
- `field_settings` — shared settings field.
- View display: `field_nodeentityref` rendered by **`entity_reference_display_default`** (label hidden),
  `view_mode: default` overridable by the vm field; other fields + preview placeholder hidden; Layout
  Builder disabled.

## Access behavior
`entity_reference_display_default` renders the referenced node through the core entity view builder, which
applies the node's entity access for the current user. Referencing a node the viewer cannot access does
not disclose it. Node selection for editors is scoped by the `entity_reference_referenceable_nodes` view.

## Template
`paragraph--drowl-paragraphs-bs--entity-reference.html.twig` extends the base paragraph template and adds
`paragraph--entity-view-mode-*` and `paragraph--entity-bundle-*` classes derived from the referenced
node.
