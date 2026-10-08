<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Entity Reference (drowl_paragraphs_bs_type_entity_reference) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `entity_reference` Paragraph type.

- **Fields**: `field_nodeentityref` (entity reference to node, using a **views** selection handler
  `entity_reference_referenceable_nodes`), `field_nodeentityrefvm` (view-mode selector, hidden on display),
  shared `field_settings` (hidden).
- Displayed with **`entity_reference_display_default`** (contrib `entity_reference_display`) — renders the
  node via the standard entity view builder, so **referenced-entity access is respected**; the view mode
  comes from `field_nodeentityrefvm`.
- **Template** adds paragraph classes reflecting the referenced node's bundle and view mode.
- Depends on `entity_reference_display`, `fences`, core `node`. No routes/permissions/services/schema.

See [paragraphs/entity-reference.md](paragraphs/entity-reference.md).
