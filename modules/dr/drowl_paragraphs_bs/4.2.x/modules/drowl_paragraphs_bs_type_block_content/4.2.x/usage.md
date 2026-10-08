<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Block content' Paragraph bundle that embeds a reusable custom block into content.

---

This sub-module installs the `block_content` Paragraph type with a `block_field` field (`field_block_content`) so editors can embed a placed/reusable block (including custom content blocks) into Paragraphs-based content. It also adds editor shortcut buttons to the Layout Paragraphs component form linking to the custom block library and the add-custom-block page. Blocks are rendered by the block_field module through the block plugin system.

---

- Embed a reusable custom content block into page-built content.
- Embed any block plugin exposed through block_field.
- Jump to the custom block library from the paragraph edit form.
- Create a new custom block from the paragraph edit form.
- Reuse a block across many pages via reference.
- Combine with field_settings for animation/classes/id.
- Enable only where editors need to place blocks into Paragraphs.
