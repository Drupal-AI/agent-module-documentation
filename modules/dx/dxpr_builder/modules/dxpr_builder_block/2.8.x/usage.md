<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
DXPR Builder Block Type is a config-only submodule that ships a "Drag and Drop Block" (`drag_and_drop_block`) block-content type whose body is edited with the DXPR Builder visual editor.

---

Enabling `dxpr_builder_block` installs a custom block type (`block_content` bundle
`drag_and_drop_block`, label "Drag and Drop Block") pre-wired for DXPR Builder: it adds a `body`
field and sets that field's default view display to the `dxpr_builder_text` formatter, so any
reusable custom block of this type is authored with DXPR's drag-and-drop tools. The block type
config is `enforced` to the module. The submodule contains no code — it is pure configuration
(`config/optional/`: the block type, the body field + storage, and the default form/view
displays) depending on the parent `dxpr_builder` plus `text` and `node`. Use it to build
reusable, visually-designed content blocks (heroes, CTAs, feature grids) that can be placed in
regions or embedded, without hand-configuring a block type and its display.

---

- Create reusable, DXPR-designed custom blocks (hero, CTA, feature grid) without setup.
- Give editors a "Drag and Drop Block" option when adding a custom block.
- Build a library of visually-designed components placed across the site.
- Author block content with DXPR's drag-and-drop editor instead of a plain body field.
- Reuse one designed block in multiple regions or pages.
- Keep DXPR-built reusable components in their own block type.
- Embed DXPR-built blocks inside DXPR Builder page content.
- Provide branded, consistent components an editorial team can drop in.
- Prototype marketing components as blocks quickly.
- Ship the block type as enforced, exportable configuration.
- Standardize reusable component authoring across a platform.
- Separate reusable block components from full-page builder content (dxpr_builder_page).
- Offer a demo of DXPR Builder on the block_content entity type.
- Let site builders skip manual block-type + display configuration.
- Place designed blocks via Block layout like any custom block.
- Serve as reference config for wiring dxpr_builder_text onto block_content.
- Maintain a component library that editors manage without a developer.
- Combine designed blocks with Views/other blocks embedded by DXPR Builder.
- Roll out reusable DXPR components with zero site-builder effort.
