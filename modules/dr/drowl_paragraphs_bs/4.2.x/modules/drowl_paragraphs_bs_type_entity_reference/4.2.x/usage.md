<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an 'Entity reference' Paragraph bundle that references a node and renders it in a chosen view mode.

---

This sub-module installs the `entity_reference` Paragraph type. It references a node via `field_nodeentityref` (using a views-based selection handler that lists referenceable nodes) and renders it with the `entity_reference_display` module's formatter, which lets editors also pick the view mode (`field_nodeentityrefvm`) used to display the referenced node. Rendering goes through the standard entity view builder, so the referenced node's entity access is respected.

---

- Reference an existing node and render it inside page-built content.
- Choose the view mode used to display the referenced node.
- Reuse content across pages without duplicating it.
- Rely on standard entity access for the referenced node.
- Use the provided selection view of referenceable nodes.
- Combine with field_settings for animation/classes/id.
- Add a bundle-specific wrapper class (template adds referenced-entity classes).
