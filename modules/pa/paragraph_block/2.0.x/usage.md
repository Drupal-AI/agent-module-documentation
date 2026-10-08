<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraph Block turns any paragraph type into a placeable block type, so the components an editor already builds with Paragraphs can be dropped into block layout or Layout Builder without defining a separate block type.

---

The module ships one real block-content bundle, `paragraph_block`, holding a single `entity_reference_revisions` field (`field_paragraph_block_paragraph`) that stores one paragraph. You do not use that bundle directly. Instead, on each paragraph type's edit form the module adds a "Paragraph block settings" section (via a Form Decorator plugin) with an Enable checkbox; ticking it sets a third-party setting on the paragraphs type. Every enabled paragraph type then appears as its own "fake" block-content bundle in the block-add UI and in Layout Builder's inline-block chooser. When an editor picks one, a custom block-content storage handler transparently creates a real `paragraph_block` block containing a fresh paragraph of the chosen type, so from Drupal's point of view it is an ordinary reusable/inline block, while from the editor's point of view it is the paragraph component they know.

Because storage is the standard block-content entity, the approach is minimally invasive: reusable blocks, Layout Builder inline blocks (with the module's `hook_update_N` migration from an older custom block plugin to core `inline_block`), revisions, and duplication all work through core. The module also filters its own bundle out of Layout Builder's raw inline-block list, forbids standalone creation of the base `paragraph_block` bundle, keeps its fake bundles from leaking into exported config dependencies (rewriting them to the owning `paragraphs.paragraphs_type.*`), and forces content-translation settings for these bundles to follow the paragraph type rather than being set independently.

It is most useful as a bridge for Paragraphs-based sites adopting Layout Builder or block placement, letting existing components be reused without rebuilding them as block types. Requires the contrib Paragraphs, Form Decorator and Block Form Alter modules plus core Block content; Layout Builder is optional but a primary target.

---

- Place an existing paragraph type as a block through the standard block-add UI.
- Reuse a paragraph component inside Layout Builder as an inline block.
- Adopt Layout Builder on a Paragraphs site without rebuilding components as block types.
- Enable a single paragraph type as a block by ticking one checkbox on its edit form.
- Expose only selected paragraph types as blocks, leaving others paragraph-only.
- Create a reusable block that renders one paragraph and its nested content.
- Give editors one component vocabulary across paragraphs and blocks.
- Migrate layouts from an older custom paragraph-block plugin to core inline blocks (update hook).
- Store block-embedded paragraphs in the normal block_content entity so revisions work.
- Duplicate a paragraph block and get an independent copy of its paragraph (entity_duplicate hook).
- Keep the internal `paragraph_block` bundle out of the block chooser so editors see paragraph names.
- Prevent editors from creating the base paragraph_block block type standalone.
- Avoid maintaining parallel paragraph and block component sets.
- Render paragraph components through the standard entity_reference_revisions view formatter.
- Let translation of a bridged component follow the paragraph type's translation settings.
- Audit which paragraph types are also exposed as blocks across a site.
- Retire duplicated component types after standardizing on block placement.
- Plan and stage a migration off custom paragraph-block layout components.
- Verify nested paragraphs render correctly when a paragraph type is used as a block.
- Review the module's behaviour during a Layout Builder rollout or site audit.
