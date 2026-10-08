<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Block adds a Paragraphs type whose main field is a reference to an existing Drupal block plugin, so a block can be placed in a page's paragraph flow like any other component — with an optional title/text and the EPT family's shared design settings.

---

Component-built pages produce a specific gap: the page is assembled from paragraphs, and some of the things that belong in it already exist as blocks — a shared call to action, a contact panel, a views listing, a menu, something a module provides. Rebuilding those as bespoke paragraph types duplicates them and means two things to maintain; referencing them keeps one definition and lets the editor position it. EPT Block answers that by giving the `ept_block` paragraph bundle a `field_ept_block_block` field of type **`block_field`** (from the contrib module of the same name, a hard dependency), so the module itself ships no PHP — it is a Paragraphs bundle plus field configuration. The editor picks a block from the site's block plugins (the field's selection is restricted by block category, though the shipped allowlist spans essentially every category), optionally configures that block's own settings inline, and the `block_field` formatter renders it at display time — importantly, that formatter calls the block plugin's `access()` for the current viewer and skips it if disallowed, and merges the block's cacheability, so a views block embedded this way runs with its own access, filters and cache metadata per viewer. The paragraph also carries an optional `field_ept_title` (rendered as an `<h2>`) and `field_ept_text`, plus `field_ept_settings` — the shared `ept_core` design tab (margin/padding/border, background color/image/video, edge-to-edge, container width) that every EPT paragraph gets, emitted as a scoped inline `<style>` block. Version **2.0.0**; core requirement `^10.1 || ^11 || ^12`. The one thing worth an editor knowing: because the block is rendered at display time, updating the referenced block updates every page that references it — that is the point, and the reason to prefer referencing over duplicating.

---

- Place a shared call to action block in a page's paragraph flow.
- Embed a Views listing block as a component mid-page.
- Add a contact form block to a built landing page.
- Reference an existing module-provided block instead of rebuilding it.
- Avoid duplicating a block as a separate paragraph type.
- Position a menu block within page content.
- Add a promotional / banner block between other paragraphs.
- Embed a filtered product-list Views block.
- Place a newsletter or webform signup block.
- Reuse one block definition across many landing pages.
- Add a search form block into a page.
- Keep a single source of truth for a reused component.
- Embed a social-feed or map block in content.
- Place a testimonial or quote block.
- Add a downloads / attachments block to a guide page.
- Give the embedded block a heading via the paragraph's title field.
- Add intro text above an embedded block via the text field.
- Apply per-paragraph spacing, borders or a background to the embedded block.
- Make an embedded block edge-to-edge or constrain its container width.
- Configure the chosen block's own settings inline while editing the paragraph.
- Let an access-restricted block auto-hide for viewers who lack access.
- Build a page from a mix of native paragraphs and referenced blocks.
