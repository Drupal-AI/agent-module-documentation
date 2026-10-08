<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 block embed adds a toolbar button and a matching text-format filter that insert content blocks, view blocks, and the active theme's region blocks into body text, resolved and rendered at display time.

---

Editors want to put a thing inside an article: a related-content view partway down, a call-to-action block between sections, a newsletter signup at the end. The structured answers are a paragraph type or Layout Builder, which are better designed but a larger change to how the site is built; the unstructured answer is a raw embed pasted into the body. A CKEditor 5 button is the pragmatic middle, and it keeps the reference as a reference — the block is re-rendered every time the field displays, so updating the block updates every article that embeds it. Version **1.0.3** on core `^10 || ^11`, depending only on core `ckeditor5`. Two pieces must both be present on a text format for it to work: the **Embed Block** toolbar button and the **Embed blocks** filter — the button writes a placeholder `<ck5-block-embed data-plugin-id="…" data-plugin-config="…">` element, and the filter turns that placeholder into the rendered block on output. The button offers three embed types backed by three plugins: **content_block** (a `block_content` entity, rendered via its view builder), **view_block** (a view's block display, run at render time), and **theme_block** (a block config entity placed in the active theme's regions). The toolbar button is gated by the **`use ck5 block embed button`** permission (the module strips the button from the editor for users who lack it). **Treat that permission as site-building, not editing**: the picker lists every content block, view block, and theme block on the site, blocks can attach libraries and render arbitrary configured markup, and the placeholder element is a plain data-attribute tag that anyone able to write raw HTML into the format (source editing) can hand-author. Grant it to the people who would otherwise be placing blocks in block layout, and prefer a curated text format over an open one.

---

- Insert a related-content view into an article body.
- Add a call-to-action block between two sections.
- Embed a newsletter-signup block at the end of a page.
- Place a `block_content` custom block inline in text.
- Reference a block rather than copying its markup.
- Embed a view's block display in a node body.
- Add a promotional block to selected articles only.
- Insert a contact or form block into a page.
- Embed one of the active theme's region-placed blocks.
- Keep an embedded block current by editing the block once.
- Add a testimonial block to an article.
- Embed a filtered product or listing view.
- Insert a video or media block into running text.
- Add a downloads block to a documentation guide.
- Reuse a single block across many articles.
- Drop a menu or navigation block into body content.
- Gate the Embed Block button behind `use ck5 block embed button`.
- Require both the toolbar button and the Embed blocks filter on a format.
- Author the `<ck5-block-embed>` placeholder directly via source editing.
- Preview an embedded block live inside the editor before saving.
- Choose the embed type (content / view / region) from the dialog.
- Curate which formats expose the button to limit who can embed blocks.
