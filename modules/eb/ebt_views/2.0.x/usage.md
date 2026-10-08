<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Views provides a reusable "EBT Views" block-content type that embeds an existing View inside an EBT-styled block.

Part of the Extra Block Types family, the module ships a `block_content` bundle named `ebt_views` with a Views Reference field (`field_ebt_views_views`), a body field, and a shared `field_ebt_settings` for the EBT design options. Editors create a block-content entity of this type, point the Views Reference field at a view and display, and place the resulting block — in Layout Builder or classic Block Layout — with EBT's background, spacing and styling controls applied through the supplied Twig templates and CSS.

The module is configuration- and template-only: it defines fields, form/view displays and templates, and depends on `ebt_core` and `viewsreference`. It has no routes, controllers, services or permissions of its own, so there is no anonymous or mutating endpoint. The embedded view's own access controls still apply. Typical setup: install EBT Core and Views Reference, enable this module, create an "EBT Views" block, select a view, and place it.
---
EBT: Views adds a block-content type that embeds an existing View as a styled Extra Block Type block.
---
- Enable EBT Core and Views Reference, then this module.
- Create an "EBT Views" block-content entity.
- Select a view and display in the Views Reference field.
- Add optional body text above or around the embedded view.
- Configure EBT design settings (background, spacing, styling).
- Place the block through Layout Builder.
- Place the block through classic Block Layout.
- Reuse the same view in multiple EBT blocks with different styling.
- Pass arguments/contextual filters through the Views Reference field.
- Override the block's markup via the provided Twig templates.
- Apply custom CSS classes from the EBT settings field.
- Restrict a placed block with core visibility conditions.
- Build a landing page composed of several EBT Views blocks.
- Embed a slider or listing view as a promotional block.
- Show recent content by referencing a "recent nodes" view.
- Keep view access controls intact (embedded view still checks access).
- Update the referenced view without re-placing the block.
- Clone an EBT Views block to speed up building similar sections.
- Translate the block body per language where enabled.
- Remove the embed by deleting the block-content entity.
